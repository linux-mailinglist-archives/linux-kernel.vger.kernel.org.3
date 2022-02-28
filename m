Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB764C65C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiB1Jg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:36:57 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB3B5BD31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:36:19 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 28446478;
        Mon, 28 Feb 2022 10:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646040977;
        bh=9xHAMfe5cP+Bn5+HCFryCq3zebr3kIe8n3BFKz3uQP4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HHXZHcnQqTJwkikCSq714JL37wFd/UDLvOfilnT68RlC/1ob/qYsxj/j/6FJYpSdq
         x0UaRjaTF97f0Qe5KA4JOZPDl5CjlDoQUB9JY+vkIQ/ZkSBWsXYmskf0D9m1oadNh2
         Gr8uNYrPh/Vu4uyLidqHrTWwci/6HVabXdOpafiQ=
Message-ID: <0e10c717-145d-8ff9-54ef-d574c0a06289@ideasonboard.com>
Date:   Mon, 28 Feb 2022 11:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/panel: simple: Initialize bpc in RK101II01D-CT panel
 descriptor
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nikhil.nd@ti.com, laurent.pinchart@ideasonboard.com
References: <20220210140300.11900-1-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220210140300.11900-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 16:03, Rahul T R wrote:
> Initialize bpc while creating panel_desc structure for RK101II01D-CT
> 
> Below warning is triggered since bpc is not being initialized
> 
> WARNING: CPU: 2 PID: 47 at drivers/gpu/drm/panel/panel-simple.c:614
> panel_simple_probe+0x1b0/0x3c8
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c324a3ed34b9..c09eb5ad65fc 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -3058,6 +3058,7 @@ static const struct drm_display_mode rocktech_rk101ii01d_ct_mode = {
>   
>   static const struct panel_desc rocktech_rk101ii01d_ct = {
>   	.modes = &rocktech_rk101ii01d_ct_mode,
> +	.bpc = 8,
>   	.num_modes = 1,
>   	.size = {
>   		.width = 217,

Thanks, looks good to me. I'll apply to drm-misc-next.

  Tomi
