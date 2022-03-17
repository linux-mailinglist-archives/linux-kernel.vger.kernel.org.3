Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8CB4DC818
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiCQOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiCQOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:00:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410F89322
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:59:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gb19so4945409pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ufxjnN9NXxK3d3D2EltlhEeSkTYyF9wi0vNhDjdgD90=;
        b=tmRZHIAcgMeQDuM7muHe8p6SEei55SxxX6+zstwjJjNGEYMdGY2OdzLJCKoOX1DTXw
         cm2lE+9l1ugHinFCikY6ByT8TObK+NROrgNqTNZAl4whBGh+PB1AcOVg7WAReYQSSuru
         /qLH97xv1NGGnXdKEcRnB7eqaNt2WKFf+C3xdTpLG1sYdxOEp8kXesd/HX2IVpDHK/PP
         QOzDiWuaWJwzwokhX6A/re9inVAFkLITUqBeGd54l+ksPVB3bvIftQSBljSXcJ7FZO/3
         wXlZa695obyqD7yNEQe9XZhxf0hX73egssDF+sno4OlSSJ4Kacd1tD1Vls1iO5JLtuhJ
         0FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufxjnN9NXxK3d3D2EltlhEeSkTYyF9wi0vNhDjdgD90=;
        b=RCHlD4d/vAxgmnmuUprOS5ycbdQjkz0eE6I5TwQLTSL0Jmb0zENNEGymgrGDb8oqVz
         OQWlL3PKCCzWX1lO5/3VczfF0s49x4wLWAEvXkTFMjl+uFFFxFCWJ9xlav1FvBHf4CJj
         3U2DyrXLbkViBXQzi/zdMGm91pY9G6Xasjxd744NHy1i+1ctfXjDRkKsl0L0vM+soEJW
         hFmlZGdCpUtUBJV3TuSd+3B8X2mQs+WFXc5pAuSLpRCK7sg+sxJsgfDrlAPYckwGIhvU
         4aPTxjS10EJ/Nmffwos41v9hQgvUbmTUf1E3vSZQrmvcHvzzpgWhe5Q6EYLrFqkIYgwX
         lyEw==
X-Gm-Message-State: AOAM533sidDEGWWN01avk09Z8EZR9qewb2MjtIIy9+r4qcta2M6IpDST
        DlX/tA3PoVRIbjqi4Y4UnPVNOQ==
X-Google-Smtp-Source: ABdhPJxTvPnqpk9VUO/Rtcmmm3KApekS1/CYvvgDk8CeBxMLflQ5n7YUVCQqgGQZMZupYJpwmhhV8A==
X-Received: by 2002:a17:90b:4b4a:b0:1bf:83d:6805 with SMTP id mi10-20020a17090b4b4a00b001bf083d6805mr16473549pjb.174.1647525562873;
        Thu, 17 Mar 2022 06:59:22 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm9495069pju.8.2022.03.17.06.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 06:59:22 -0700 (PDT)
Date:   Thu, 17 Mar 2022 21:59:17 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] irq/qcom-mpm: Fix build error without MAILBOX
Message-ID: <20220317135917.GA360113@dragon>
References: <20220317131956.30004-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317131956.30004-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:19:56PM +0800, YueHaibing wrote:
> If MAILBOX is n, building fails:
> 
> drivers/irqchip/irq-qcom-mpm.o: In function `mpm_pd_power_off':
> irq-qcom-mpm.c:(.text+0x174): undefined reference to `mbox_send_message'
> irq-qcom-mpm.c:(.text+0x174): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `mbox_send_message'
> 
> Make QCOM_MPM depends on MAILBOX to fix this.
> 
> Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/irqchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 680d2fcf2686..15edb9a6fcae 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -433,6 +433,7 @@ config QCOM_PDC
>  config QCOM_MPM
>  	tristate "QCOM MPM"
>  	depends on ARCH_QCOM
> +	depends on MAILBOX
>  	select IRQ_DOMAIN_HIERARCHY
>  	help
>  	  MSM Power Manager driver to manage and configure wakeup
> -- 
> 2.17.1
> 
