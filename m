Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D838B5AA9E3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiIBIYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiIBIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:24:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0703ADCE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662107056; x=1693643056;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Omf6Bt9yIpzl/KvsyXiiDF7MSmQ2JQdb+IyJVLiWHSY=;
  b=DLVSo9yzHbph2nJu8pSfZXUbyJKoQMzLekFGjTbQn9YbwPVICcRwJAHU
   r1htSJ0B0r0UrKCxv+pdCn7Fkr7lR1tJPuQ/ZTcy5VlZoV41kqu5/+lMD
   gX2JNKwQxIEhqmf8tSXDWiVcCrPlRRLqFrQ+xnfHeym0CFvc1SIBOGiD0
   tEogs8JnT9PwXOWvn+E3W5o3jJNdE3mdvGmU+sSQum0LRl/t6hazr+Eq1
   wJfKWBp+wR3Cf1eOmgzFKjY+pfiGXOgswraZIKWgInh9QjZkIvSl46m5K
   R6YGtTk7Cgv5pKWByZTJ6B6CpkmF+/Yr+lkLUmIyhZyHlnUbczfcSWpgf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296714593"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296714593"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:24:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="589992462"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:24:12 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     cgel.zte@gmail.com, airlied@linux.ie
Cc:     daniel@ffwll.ch, ville.syrjala@linux.intel.com, lyude@redhat.com,
        tzimmermann@suse.de, imre.deak@intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] drm/dp_helper: Remove the unneeded result
 variable
In-Reply-To: <20220902081203.320165-1-zhang.songyi@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220902081203.320165-1-zhang.songyi@zte.com.cn>
Date:   Fri, 02 Sep 2022 11:24:01 +0300
Message-ID: <877d2mfala.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Sep 2022, cgel.zte@gmail.com wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> Return the drm_dp_dpcd_writeb() directly instead of storing it in another
> redundant variable.

Please just *stop* sending changes like this. See for example [1].

What's most offending to me is that I've replied to a lot of patches
from you, but I've *never* *even* *once* received a reply back on my
reviews.

If you want to participate in creating a better kernel, then please
*participate*. Just throwing random cleanup patches in our general
direction with one-way communication is not helping.

I'm seriously considering just ignoring *all* patches from you.


BR,
Jani.



[1] https://lore.kernel.org/r/8735dcepcv.fsf@intel.com

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 92990a3d577a..09b282b704fa 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2925,16 +2925,13 @@ EXPORT_SYMBOL(drm_dp_get_pcon_max_frl_bw);
>   */
>  int drm_dp_pcon_frl_prepare(struct drm_dp_aux *aux, bool enable_frl_ready_hpd)
>  {
> -	int ret;
>  	u8 buf = DP_PCON_ENABLE_SOURCE_CTL_MODE |
>  		 DP_PCON_ENABLE_LINK_FRL_MODE;
>  
>  	if (enable_frl_ready_hpd)
>  		buf |= DP_PCON_ENABLE_HPD_READY;
>  
> -	ret = drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
> -
> -	return ret;
> +	return drm_dp_dpcd_writeb(aux, DP_PCON_HDMI_LINK_CONFIG_1, buf);
>  }
>  EXPORT_SYMBOL(drm_dp_pcon_frl_prepare);

-- 
Jani Nikula, Intel Open Source Graphics Center
