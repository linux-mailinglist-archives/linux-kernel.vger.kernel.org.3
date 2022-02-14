Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F674B52F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355001AbiBNOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:15:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiBNOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:15:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E4278
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:15:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so5695064wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GhrHfphJQbfLHZGHShzFVwpGb33fGRasst5lc4cJXI8=;
        b=PsfK8rqlQGcBPZ30LK11uF8gIkxB+HziLMQ9JOtWJ60VHQf+svJmcf1rpbXaYT60AN
         a7ImAv4AqKCdiEh2sUPydWiXFZ8uKuP9LR+zYq7dfXg3aJf/FbWwqux+ji72qLBCun5M
         /7rAKKaGtpCiHswu4nZq2gaGKgT+ZXGUk1rfkyS4r5oPPx8wu909ChwgnPnr5RxS/7wR
         zTJNfLJa50ohgKYhiKaGMdf0feeCtv1+WfHkwWFyQSaw8a0gBwyB+vVNsh63tRIpQq8A
         5Xh+ENH4GFwfiw0WRnhw8ZZ9NCMeIyPT4/QP9wjCrlhIf0IacNgA8agyxfofF0gTMQSy
         sCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GhrHfphJQbfLHZGHShzFVwpGb33fGRasst5lc4cJXI8=;
        b=MZDZsM+GWYWikMfpDMirb3hZWtyNHrvgHwpN+kXAzA5z1wMI+Xxo2iL+2EyV6i31NL
         ms9uWddSXy9bfMkWj3fa3AJ7GmzqJO5L07aHNw2J5zNhGj2jZQ/frAHHvCIp8187/uXW
         KIEiXjLjGEF/iMky0Kvy0qyMZEqTAGY4j/r30w33mEhfhcCMP42LbUkGvojtkQONcE9Z
         cOLB7LCLKRF19OZ0LhYuClNZ6crS+dw5XmBCP5XvaTlwhsYgqZn7AU6GnKQCdNBgC061
         yEKArGTS5oFslQtgR3diB+6zQLFbiVwaOr21lDgrmwQn5zb5PcaPnzSOO5WTiHBuF8uF
         4onw==
X-Gm-Message-State: AOAM532kvadObwwcVWVzB4pdnOvHhaRNWn5aOAi64iN2b9wbdsF9+NmZ
        gRq9VduiFSpOru8DcwMTzWlMYw==
X-Google-Smtp-Source: ABdhPJzQBfXvD8Ft/MTVQ27yEibtBNwH0Q5/uOHXNNsdEeZym1fH3VPkUg8qpnSr+4e3JNsGVmHI6A==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr11065679wmf.163.1644848141661;
        Mon, 14 Feb 2022 06:15:41 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n35sm8402141wms.8.2022.02.14.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:15:41 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:15:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
Message-ID: <YgpkCyoSMg5RYfkO@google.com>
References: <20220207184652.1218447-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207184652.1218447-1-michael@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022, Michael Walle wrote:

> The sl28cpld is a management controller found on the Kontron SMARC-sAL28
> board for now. Support for it was added by me quite a while ago, but I
> didn't add a MAINTAINERS entry. Add it now.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Hi,
> 
> since this affects so many subsystems, I'm not sure through which tree this
> should go. I'm sending this to the arm soc maintainers because it's an
> aarch64 board where this driver is used as well as Lee as the MFD
> maintainer.

I'm happy to take this, if it pleases everyone.

>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddcee331dc09..c14209168ce6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17762,6 +17762,21 @@ S:	Maintained
>  W:	http://www.winischhofer.at/linuxsisusbvga.shtml
>  F:	drivers/usb/misc/sisusbvga/
>  
> +SL28 CPLD MFD DRIVER
> +M:	Michael Walle <michael@walle.cc>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
> +F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
> +F:	Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> +F:	Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
> +F:	Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> +F:	drivers/gpio/gpio-sl28cpld.c
> +F:	drivers/hwmon/sl28cpld-hwmon.c
> +F:	drivers/irqchip/irq-sl28cpld.c
> +F:	drivers/pwm/pwm-sl28cpld.c
> +F:	drivers/watchdog/sl28cpld_wdt.c
> +
>  SLAB ALLOCATOR
>  M:	Christoph Lameter <cl@linux.com>
>  M:	Pekka Enberg <penberg@kernel.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
