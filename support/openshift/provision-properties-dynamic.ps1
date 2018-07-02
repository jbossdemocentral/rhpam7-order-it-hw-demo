if (-not ([string]::IsNullOrEmpty($ARG_PROJECT_SUFFIX)))
{
  $PRJ_SUFFIX = $ARG_PROJECT_SUFFIX
} else {
  $PRJ_SUFFIX =  %{$OPENSHIFT_USER -creplace "[^-a-z0-9]","-"}
}

$PRJ=@("rhpam7-template-$PRJ_SUFFIX","RHPAM7 Demo Template","$PRJ_DESCRIPTION")
