Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821204ECA49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiC3RJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiC3RJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:09:01 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA338BD0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648660034; x=1680196034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JauRNTN/iXFEioeAVJXi5dYw32L+cbz1swoCNS2p/fo=;
  b=dSsfV92KBzSImIIZUPUGdwANzQniFvHURFMVvgBs/0pbIPHnL3ls5BRD
   4xizmKmzm2NB/MRpC/2hhGA/fjWwQe+yJ/4r+32evizynRbOm7+hFdP6Y
   C2DZwDAkqEalSjuIrbNs2ZL5jkHqqNJ4Bt17kVt6f2yN/DQSAuqhcO3T3
   mkichWIXcCyZH0TPGfQ0CNb4cJApkqSN2weCOw6cwNL9l+yykKoKBN5rD
   UwhjbsEobiQm3LpBmzvzKUzLw8IjzWehHLskhsWYQR1MYL3RY5J642yEV
   giKN0W2q+aNIKrmW4yhzVOxLmmVQeP4DC86R8eGltkjXrvQgBYFZRUL+L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320293268"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="320293268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:07:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565655237"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 10:07:13 -0700
Date:   Wed, 30 Mar 2022 10:09:36 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:rtl8723bs:rtw_cmd.c remove suspect indent
Message-ID: <20220330170936.GA1176693@alison-desk>
References: <20220330153100.5813-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330153100.5813-1-eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:31:00PM +0200, Alaa Mohamed wrote:
> Fix "WARNING: suspect code indent for conditional
> statements (16, 32)" for line 1240
> founded by checkpatch.pl
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>

Hi Alaa,

https://kernelnewbies.org/PatchPhilosophy
Please take a look at the section on "Patch subject formatting" 
and the follow on sections about checkpatch descriptions.

Thanks,
Alison


> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 14d37b369273..46e18a90529f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -1238,7 +1238,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
>  		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
>  		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
>  		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
> -				BusyThreshold = BusyThresholdLow;
> +			BusyThreshold = BusyThresholdLow;
>  
>  		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > BusyThreshold ||
>  			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
> -- 
> 2.35.1
> 
> 
