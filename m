Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB70476ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhLPKYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhLPKYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:24:31 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD962C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zYHgJWtqLVAy49fO88Jbmdu++WWLG5zeHbiahMNAOO4=; b=C+xbIOt12/fPvdLxmJK/yVhW8F
        DenTvAAOQcy1GRNL/y+f52H1er4n71AL/ckfYtouWhNn9sBpibrHHzzlDHBR0h71HVe0pO2eENjuI
        F8LzvlrKH4SKUxRbYCGznH1ekK/nq3raLqm4jFbyQAKixPvRQzKuG8hNc5u1BwmwgmLFlB286dPN1
        oTgH9fzSDON8E9XEh8SC9q4jp5zLJZMdbe3B3drDT1XBFmJOjUPWj8sQBc9MXMdj3xXjG/uAZQ8r8
        tvZmgD/hCXj2vc2qcqAZq3rl+3YPfHvn/wAwNFlM4zNuSK8RblbNdg3bTsYptWpy24bvCNd3AqY8i
        5vAzM7Lg==;
Received: from webng-gw.kapsi.fi ([91.232.154.200] helo=roundcube.kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jyri.sarha@iki.fi>)
        id 1mxnvx-0007MQ-Eu; Thu, 16 Dec 2021 12:24:21 +0200
MIME-Version: 1.0
Date:   Thu, 16 Dec 2021 12:24:19 +0200
From:   Jyri Sarha <jyri.sarha@iki.fi>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/tilcdc: add const to of_device_id
In-Reply-To: <20211216095536.58577-1-wangxiang@cdjrlc.com>
References: <20211216095536.58577-1-wangxiang@cdjrlc.com>
Message-ID: <de290f52a9fedbe24f928e95f01d7d94@iki.fi>
X-Sender: jyri.sarha@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.232.154.200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-16 11:55, Xiang wangx wrote:
> struct of_device_id should normally be const.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>

Thanks,
Jyri

> ---
> 
> Changes since v1
> * add const in line 63
> 
> Changes since v2
> * removed line 63
> 
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 3ddb7c710a3d..cc567c87057d 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -60,8 +60,6 @@ void tilcdc_module_cleanup(struct tilcdc_module *mod)
>  	list_del(&mod->list);
>  }
> 
> -static struct of_device_id tilcdc_of_match[];
> -
>  static int tilcdc_atomic_check(struct drm_device *dev,
>  			       struct drm_atomic_state *state)
>  {
> @@ -587,7 +585,7 @@ static int tilcdc_pdev_remove(struct 
> platform_device *pdev)
>  	return 0;
>  }
> 
> -static struct of_device_id tilcdc_of_match[] = {
> +static const struct of_device_id tilcdc_of_match[] = {
>  		{ .compatible = "ti,am33xx-tilcdc", },
>  		{ .compatible = "ti,da850-tilcdc", },
>  		{ },
