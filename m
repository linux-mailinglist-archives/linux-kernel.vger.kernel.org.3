Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9259B4D88FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiCNQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbiCNQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:23:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382961C13A;
        Mon, 14 Mar 2022 09:22:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so33894368ejc.9;
        Mon, 14 Mar 2022 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z5m7Rzd7PHl8jdAafRhu23AuInCvvTjkbtTtp1sT0eE=;
        b=VyL2mQcduDG3aI2fSM5miQTVTewd1/hd2WHokC6cIlqVaQoIGjmU/vmoXAGOjIMm4m
         zkRLDLaUMvRDhWMyOLTLpqn5d+YQdByUozxpFYxf/oKqaUYgwYuiRETxLwZKnwCvcHXp
         k6l2bMbDry3C3jTwrzyT+WonvUYJH3sUuMhx6+wM5ejb2RthhaEpKKANV5JGFCZ1QodQ
         j0JhnWLITG4xcF8Tg/xFeRUe+PdsM4It24O6wzP6h65l6T0wGAufnZ1pD4MfT+zGONLP
         cwP+rgZ7FOh44d8cbVkxmrc7sNCbQn0nmODD+BO9igAIswim9W1H6F9y3zB84Qd8FeXm
         uveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z5m7Rzd7PHl8jdAafRhu23AuInCvvTjkbtTtp1sT0eE=;
        b=sil+ZwE+V1lsFvHcP6cbDqcV9TZUj8hbQDRvxO3PtMkyHPOUO6rT/3H4q9q2d7X/4h
         ajQRpe+Rrkbhr9VzobIC53xFQLBvJPtgN8abBJxn2mULa10n3rrkdeHlLFDBG7CiI4QS
         zwnAbWKFq0574KpANYK+QJvsJb7oBKR3y5RqYPfbraTuqzN00I/DFG8GNVIDJVr5+vbB
         ZYZBwxUkOsTtd7wubhyH/uxMyFpFcYcQpmUzCe/X6KlRnbUScWp96AcK8+m8otN3f5wB
         wJcqCWKgnq0aTw9hR/ehCMl3cexaMv5+1CMI2VALZpArXUwryv5eaUXQcZABbGxD9mIC
         VjtA==
X-Gm-Message-State: AOAM5316FEWEQdYVcqxYN/01uiJb7mWBunxo7qnR+bXQUI1JX80facPH
        PgqFfaStH7VFvWJynNkX9/o=
X-Google-Smtp-Source: ABdhPJy1bCM29GUJpCGWrIB2LGEc3cpHH+v2TkW5IvI5lQwUIeFMD1X4o5Yuy3PBiAfd87Nb4S6cHA==
X-Received: by 2002:a17:907:7685:b0:6db:67:7218 with SMTP id jv5-20020a170907768500b006db00677218mr19310240ejc.461.1647274920903;
        Mon, 14 Mar 2022 09:22:00 -0700 (PDT)
Received: from omen ([188.127.98.149])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402525600b00416cb5fdc56sm6300664edd.57.2022.03.14.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:22:00 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:21:58 +0100
From:   Enver Balalic <balalic.enver@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, pobrn@protonmail.com
Subject: Re: [PATCH v2] platform/x86: hp-wmi: support omen thermal profile
 policy v1
Message-ID: <20220314162158.kuqg7jsvzaild5tl@omen>
References: <20220314121453.kjszdciymtg6ctbq@omen>
 <32332118-bf97-e890-7d97-5d4eeab0388b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32332118-bf97-e890-7d97-5d4eeab0388b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 14, 2022 at 04:27:50PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/14/22 13:14, Enver Balalic wrote:
> > As it turns out, these laptops have 2 thermal profile versions.
> > A previous patch added support for v0, this patch adds support
> > for v1 thermal policies that are in use on some devices.
> > We obtain the thermal policy version by querying the get system
> > design data WMI call and looking at the fourth byte it returns,
> > except if the system board DMI Board ID is in a specific array
> > that the windows command center app overrides to thermal policy
> > v0 for some reason.
> > 
> > - V1
> >   Initial Patch
> > - V2
> >   Rename V0 thermal policy values to HP_OMEN_V0_THERMAL_PROFILE_
> >   for consistency with the V1 thermal policy values.
> >   Fix issue where instead of forcing certain boards to V0, they
> >   were being forced to V1.
> >   Drop unnecessary newline additions.
> > 
> > Signed-off-by: Enver Balalic <balalic.enver@gmail.com>
> > ---
> >  drivers/platform/x86/hp-wmi.c | 81 +++++++++++++++++++++++++++++------
> >  1 file changed, 67 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> > index c56c8864961d..0109ddc84be7 100644
> > --- a/drivers/platform/x86/hp-wmi.c
> > +++ b/drivers/platform/x86/hp-wmi.c
> > @@ -57,6 +57,14 @@ static const char * const omen_thermal_profile_boards[] = {
> >  	"8917", "8918", "8949", "894A", "89EB"
> >  };
> >  
> > +/* DMI Board names of Omen laptops that are specifically set to be thermal
> > + * profile version 0 by the Omen Command Center app, regardless of what
> > + * the get system design information WMI call returns
> > + */
> > +static const char *const omen_thermal_profile_force_v0_boards[] = {
> > +	"8607", "8746", "8747", "8749", "874A", "8748"
> > +};
> > +
> >  enum hp_wmi_radio {
> >  	HPWMI_WIFI	= 0x0,
> >  	HPWMI_BLUETOOTH	= 0x1,
> > @@ -117,6 +125,7 @@ enum hp_wmi_gm_commandtype {
> >  	HPWMI_SET_PERFORMANCE_MODE = 0x1A,
> >  	HPWMI_FAN_SPEED_MAX_GET_QUERY = 0x26,
> >  	HPWMI_FAN_SPEED_MAX_SET_QUERY = 0x27,
> > +	HPWMI_GET_SYSTEM_DESIGN_DATA = 0x28,
> >  };
> >  
> >  enum hp_wmi_command {
> > @@ -151,10 +160,16 @@ enum hp_wireless2_bits {
> >  	HPWMI_POWER_FW_OR_HW	= HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
> >  };
> >  
> > -enum hp_thermal_profile_omen {
> > -	HP_OMEN_THERMAL_PROFILE_DEFAULT     = 0x00,
> > -	HP_OMEN_THERMAL_PROFILE_PERFORMANCE = 0x01,
> > -	HP_OMEN_THERMAL_PROFILE_COOL        = 0x02,
> > +enum hp_thermal_profile_omen_v1 {
> > +	HP_OMEN_V1_THERMAL_PROFILE_DEFAULT	= 0x30,
> > +	HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE	= 0x31,
> > +	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
> > +};
> > +
> > +enum hp_thermal_profile_omen_v0 {
> > +	HP_OMEN_V0_THERMAL_PROFILE_DEFAULT     = 0x00,
> > +	HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE = 0x01,
> > +	HP_OMEN_V0_THERMAL_PROFILE_COOL        = 0x02,
> >  };
> 
> IMHO it would be more logical to list the v0 settings above
> the v1 settings, rather then the other way around.
> 
> I've fixed this up while merging this patch:
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
> Regards,
> 
> Hans
> 
Thank you.
> 
> >  
> >  enum hp_thermal_profile {
> > @@ -407,9 +422,6 @@ static int omen_thermal_profile_set(int mode)
> >  	char buffer[2] = {0, mode};
> >  	int ret;
> >  
> > -	if (mode < 0 || mode > 2)
> > -		return -EINVAL;
> > -
> >  	ret = hp_wmi_perform_query(HPWMI_SET_PERFORMANCE_MODE, HPWMI_GM,
> >  				   &buffer, sizeof(buffer), 0);
> >  
> > @@ -431,6 +443,30 @@ static bool is_omen_thermal_profile(void)
> >  			    board_name) >= 0;
> >  }
> >  
> > +static int omen_get_thermal_policy_version(void)
> > +{
> > +	unsigned char buffer[8] = { 0 };
> > +	int ret;
> > +
> > +	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
> > +
> > +	if (board_name) {
> > +		int matches = match_string(omen_thermal_profile_force_v0_boards,
> > +			ARRAY_SIZE(omen_thermal_profile_force_v0_boards),
> > +			board_name);
> > +		if (matches >= 0)
> > +			return 0;
> > +	}
> > +
> > +	ret = hp_wmi_perform_query(HPWMI_GET_SYSTEM_DESIGN_DATA, HPWMI_GM,
> > +				   &buffer, sizeof(buffer), sizeof(buffer));
While I was looking at the other changes to the hp-wmi driver
on your review-hans branch, I noticed this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=review-hans&id=be9d73e64957bbd31ee9a0d11adc0f720974c558
(is this the proper way to link to a commit in a patch email response?)

Based on this, I think the input buffer size here should be 0.
Do you want me to make another patch for this or will you check 
and commit it directly instead?
> > +
> > +	if (ret)
> > +		return ret < 0 ? ret : -EINVAL;
> > +
> > +	return buffer[3];
> > +}
> > +
> >  static int omen_thermal_profile_get(void)
> >  {
> >  	u8 data;
> > @@ -1053,13 +1089,16 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> >  		return tp;
> >  
> >  	switch (tp) {
> > -	case HP_OMEN_THERMAL_PROFILE_PERFORMANCE:
> > +	case HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE:
> > +	case HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE:
> >  		*profile = PLATFORM_PROFILE_PERFORMANCE;
> >  		break;
> > -	case HP_OMEN_THERMAL_PROFILE_DEFAULT:
> > +	case HP_OMEN_V0_THERMAL_PROFILE_DEFAULT:
> > +	case HP_OMEN_V1_THERMAL_PROFILE_DEFAULT:
> >  		*profile = PLATFORM_PROFILE_BALANCED;
> >  		break;
> > -	case HP_OMEN_THERMAL_PROFILE_COOL:
> > +	case HP_OMEN_V0_THERMAL_PROFILE_COOL:
> > +	case HP_OMEN_V1_THERMAL_PROFILE_COOL:
> >  		*profile = PLATFORM_PROFILE_COOL;
> >  		break;
> >  	default:
> > @@ -1072,17 +1111,31 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
> >  static int platform_profile_omen_set(struct platform_profile_handler *pprof,
> >  				     enum platform_profile_option profile)
> >  {
> > -	int err, tp;
> > +	int err, tp, tp_version;
> > +
> > +	tp_version = omen_get_thermal_policy_version();
> > +
> > +	if (tp_version < 0 || tp_version > 1)
> > +		return -EOPNOTSUPP;
> >  
> >  	switch (profile) {
> >  	case PLATFORM_PROFILE_PERFORMANCE:
> > -		tp = HP_OMEN_THERMAL_PROFILE_PERFORMANCE;
> > +		if (tp_version == 0)
> > +			tp = HP_OMEN_V0_THERMAL_PROFILE_PERFORMANCE;
> > +		else
> > +			tp = HP_OMEN_V1_THERMAL_PROFILE_PERFORMANCE;
> >  		break;
> >  	case PLATFORM_PROFILE_BALANCED:
> > -		tp = HP_OMEN_THERMAL_PROFILE_DEFAULT;
> > +		if (tp_version == 0)
> > +			tp = HP_OMEN_V0_THERMAL_PROFILE_DEFAULT;
> > +		else
> > +			tp = HP_OMEN_V1_THERMAL_PROFILE_DEFAULT;
> >  		break;
> >  	case PLATFORM_PROFILE_COOL:
> > -		tp = HP_OMEN_THERMAL_PROFILE_COOL;
> > +		if (tp_version == 0)
> > +			tp = HP_OMEN_V0_THERMAL_PROFILE_COOL;
> > +		else
> > +			tp = HP_OMEN_V1_THERMAL_PROFILE_COOL;
> >  		break;
> >  	default:
> >  		return -EOPNOTSUPP;
> 
Thanks,
Enver.
