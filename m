Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A854FEA93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiDLXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiDLXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDB8B6D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649806586; x=1681342586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjhF2LEHO+cHqCM8/1aoy6xD1SETj0bTEeakqPsejYM=;
  b=ZYcVkWuZmlhrlncQeXsZm7DdEUaPr1ClGpma/bwPdZKOIQZnL5C4eJJn
   2GbQQBeXUQoHXWhtMoGUGys5wDS3AFAouGEtKkZqv6VNbHZMv3Ei2C3uX
   mYL/5besgCVb1tU7bhRQ6aVc97vyn6dfWu2XgefJWnzO/027gdnkxM8vR
   gMUrGANnxq1sGNeUvRCFKVDMxF+U8/zQraUuzew/Gi1lAFQeGdbVs7uXV
   gJZKFfeh+59EljPdTUxKG64mGzmZRSpEszdt2QECsR8SOmVCbp6eVeAAG
   h86wKBN8CJC/ldwWz/YwltQ1DQoivp4p6pJJ3SjTS5iY2nkLZlYZLCkVG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="322975986"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="322975986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 16:36:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="660707822"
Received: from aalaniz-mobl.amr.corp.intel.com (HELO localhost) ([10.209.160.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 16:36:25 -0700
Date:   Tue, 12 Apr 2022 16:36:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: combine both sides of conditional
 statement
Message-ID: <YlYM+LjgZWALaa1R@iweiny-desk3>
References: <cover.1649011311.git.remckee0@gmail.com>
 <d33c51bc3a20fa25e4737b258f3b1c42cc8124e3.1649011311.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33c51bc3a20fa25e4737b258f3b1c42cc8124e3.1649011311.git.remckee0@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 02:17:05PM -0500, Rebecca Mckeever wrote:
> Both sides of conditional statement are the same except for the comment.
> Additional instance found with git grep.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index da455eb4d8cb..2d316a6c8294 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1411,11 +1411,9 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  {
>  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	if (pcmd->res == H2C_DROPPED) {
> +	if (pcmd->res != H2C_SUCCESS) {
>  		/* TODO: cancel timer and do timeout handler directly... */
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> -	} else if (pcmd->res != H2C_SUCCESS) {
> -		_set_timer(&pmlmepriv->scan_to_timer, 1);
>  	}
>  
>  	/*  free cmd */
> @@ -1445,11 +1443,9 @@ void rtw_joinbss_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  {
>  	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  
> -	if (pcmd->res == H2C_DROPPED) {
> +	if (pcmd->res != H2C_SUCCESS) {
>  		/* TODO: cancel timer and do timeout handler directly... */
>  		_set_timer(&pmlmepriv->assoc_timer, 1);
> -	} else if (pcmd->res != H2C_SUCCESS) {
> -		_set_timer(&pmlmepriv->assoc_timer, 1);
>  	}
>  
>  	rtw_free_cmd_obj(pcmd);
> -- 
> 2.32.0
> 
