Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266314DB223
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiCPOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiCPOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:07:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD46E0A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A0D60AEE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87B4C340E9;
        Wed, 16 Mar 2022 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647439572;
        bh=w47aXrCm29kubF+/xcmuK2BH38wNJJnSOjYjEPq8++s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPTb/xwQ1gjEdaCNqbGJIxNkGSGX3DT8UBJ+5DVOQiZYA5OWfKLTS/+wo7GDZDXJp
         4ZuDMfec6uJkIIpzl3otegOmTT/0YMcEcWHwpIqhIOgS9zihxAyBlaTC+MoMRC+Dq4
         vC2n4+NZuEHijAjd5OGzgJcGmbbyQxxL+TdMuakY=
Date:   Wed, 16 Mar 2022 15:06:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nam Cao <cvn249@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix CamelCase naming style
Message-ID: <YjHu0FjaHRoqfZ+y@kroah.com>
References: <20220316113228.21243-1-cvn249@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316113228.21243-1-cvn249@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 11:32:28AM +0000, Nam Cao wrote:
> Fix CamelCase names defined in ddk750_dvi.c and ddk750_dvi.h, as
> reported by checkpatch.pl.
> 
> Signed-off-by: Nam Cao <cvn249@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c | 50 +++++++++++-----------
>  drivers/staging/sm750fb/ddk750_dvi.h | 64 ++++++++++++++--------------
>  2 files changed, 57 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index cd564ea40779..48f40dcc5ffd 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> @@ -11,41 +11,41 @@
>   * function API. Please set the function pointer to NULL whenever the function
>   * is not supported.
>   */
> -static struct dvi_ctrl_device g_dcftSupportedDviController[] = {
> +static struct dvi_ctrl_device g_dcft_supported_dvi_controller[] = {
>  #ifdef DVI_CTRL_SII164
>  	{
> -		.pfnInit = sii164InitChip,
> -		.pfnGetVendorId = sii164GetVendorID,
> -		.pfnGetDeviceId = sii164GetDeviceID,
> +		.pfn_init = sii164InitChip,
> +		.pfn_get_vendor_id = sii164GetVendorID,
> +		.pfn_get_device_id = sii164GetDeviceID,
>  #ifdef SII164_FULL_FUNCTIONS
> -		.pfnResetChip = sii164ResetChip,
> -		.pfnGetChipString = sii164GetChipString,
> -		.pfnSetPower = sii164SetPower,
> -		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
> -		.pfnIsConnected = sii164IsConnected,
> -		.pfnCheckInterrupt = sii164CheckInterrupt,
> -		.pfnClearInterrupt = sii164ClearInterrupt,
> +		.pfn_reset_chip = sii164ResetChip,
> +		.pfn_get_chip_string = sii164GetChipString,
> +		.pfn_set_power = sii164SetPower,
> +		.pfn_enable_hot_plug_detection = sii164EnableHotPlugDetection,
> +		.pfn_is_connected = sii164IsConnected,
> +		.pfn_check_interrupt = sii164CheckInterrupt,
> +		.pfn_clear_interrupt = sii164ClearInterrupt,
>  #endif
>  	},
>  #endif
>  };
>  
> -int dviInit(unsigned char edge_select,
> -	    unsigned char bus_select,
> -	    unsigned char dual_edge_clk_select,
> -	    unsigned char hsync_enable,
> -	    unsigned char vsync_enable,
> -	    unsigned char deskew_enable,
> -	    unsigned char deskew_setting,
> -	    unsigned char continuous_sync_enable,
> -	    unsigned char pll_filter_enable,
> -	    unsigned char pll_filter_value)
> +int dvi_init(unsigned char edge_select,
> +	     unsigned char bus_select,
> +	     unsigned char dual_edge_clk_select,
> +	     unsigned char hsync_enable,
> +	     unsigned char vsync_enable,
> +	     unsigned char deskew_enable,
> +	     unsigned char deskew_setting,
> +	     unsigned char continuous_sync_enable,
> +	     unsigned char pll_filter_enable,
> +	     unsigned char pll_filter_value)
>  {
> -	struct dvi_ctrl_device *pCurrentDviCtrl;
> +	struct dvi_ctrl_device *p_current_dvi_ctrl;
>  
> -	pCurrentDviCtrl = g_dcftSupportedDviController;
> -	if (pCurrentDviCtrl->pfnInit) {
> -		return pCurrentDviCtrl->pfnInit(edge_select,
> +	p_current_dvi_ctrl = g_dcft_supported_dvi_controller;
> +	if (p_current_dvi_ctrl->pfn_init) {
> +		return p_current_dvi_ctrl->pfn_init(edge_select,
>  						bus_select,
>  						dual_edge_clk_select,
>  						hsync_enable,
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
> index 1c7a565b617a..ab00f8621375 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.h
> +++ b/drivers/staging/sm750fb/ddk750_dvi.h
> @@ -4,54 +4,54 @@
>  
>  /* dvi chip stuffs structros */
>  
> -typedef long (*PFN_DVICTRL_INIT)(unsigned char edgeSelect,
> -				 unsigned char busSelect,
> -				 unsigned char dualEdgeClkSelect,
> -				 unsigned char hsyncEnable,
> -				 unsigned char vsyncEnable,
> -				 unsigned char deskewEnable,
> -				 unsigned char deskewSetting,
> -				 unsigned char continuousSyncEnable,
> -				 unsigned char pllFilterEnable,
> -				 unsigned char pllFilterValue);
> +typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
> +				 unsigned char bus_select,
> +				 unsigned char dual_edge_clk_select,
> +				 unsigned char hsync_enable,
> +				 unsigned char vsync_enable,
> +				 unsigned char deskew_enable,
> +				 unsigned char deskew_eetting,
> +				 unsigned char continuous_sync_enable,
> +				 unsigned char pll_filter_enable,
> +				 unsigned char pll_filter_value);
>  
>  typedef void (*PFN_DVICTRL_RESETCHIP)(void);
>  typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
>  typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
>  typedef unsigned short (*PFN_DVICTRL_GETDEVICEID)(void);
> -typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char powerUp);
> -typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enableHotPlug);
> +typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char power_up);
> +typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enable_hot_plug);
>  typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
>  typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
>  typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
>  
>  /* Structure to hold all the function pointer to the DVI Controller. */
>  struct dvi_ctrl_device {
> -	PFN_DVICTRL_INIT		pfnInit;
> -	PFN_DVICTRL_RESETCHIP		pfnResetChip;
> -	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
> -	PFN_DVICTRL_GETVENDORID		pfnGetVendorId;
> -	PFN_DVICTRL_GETDEVICEID		pfnGetDeviceId;
> -	PFN_DVICTRL_SETPOWER		pfnSetPower;
> -	PFN_DVICTRL_HOTPLUGDETECTION	pfnEnableHotPlugDetection;
> -	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
> -	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
> -	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
> +	PFN_DVICTRL_INIT		pfn_init;
> +	PFN_DVICTRL_RESETCHIP		pfn_reset_chip;
> +	PFN_DVICTRL_GETCHIPSTRING	pfn_get_chip_string;
> +	PFN_DVICTRL_GETVENDORID		pfn_get_vendor_id;
> +	PFN_DVICTRL_GETDEVICEID		pfn_get_device_id;
> +	PFN_DVICTRL_SETPOWER		pfn_set_power;
> +	PFN_DVICTRL_HOTPLUGDETECTION	pfn_enable_hot_plug_detection;
> +	PFN_DVICTRL_ISCONNECTED		pfn_is_connected;
> +	PFN_DVICTRL_CHECKINTERRUPT	pfn_check_interrupt;
> +	PFN_DVICTRL_CLEARINTERRUPT	pfn_clear_interrupt;

Why are you keeping "pfn_"?  You do not need to say that this is a
"pointer to a function" anymore, right?

thanks,

greg k-h
