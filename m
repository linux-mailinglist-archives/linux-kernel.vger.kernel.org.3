Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2658D93B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiHINOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbiHINOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:14:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7C19C39
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 06:14:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay12so3486578wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dBqbYW9tbViwcewTo3bCPmvXW6SZtS25kUYhTbQNV8c=;
        b=y571nheINae9LUI/SJMNbLrGWhVOjCeCDgW1FZioe3HjacILCjd6QSMQsqQLVaf6ej
         vIu1F57XpVYbcP4KdE2zpOJXTaoTzu0BV5waTrO9VkrQKOyXdOdHigwSkiT1LSg0yEfz
         nvdTRa0VyWxUrvttnpZhPUA2nBjZ/UYCUgqZlOsmZMdY2108t+OmfmbTT7+us90g5Rf7
         i+0hxV16SiU7p7aTM7uSA6Cuj2vHo6O5Nm6ss3AEfscFNblCFzDGlPa/sHFBVbaj0T6l
         oTJx8MwwHSJtrMvKNV8wSIpolrJVA+vV6dbRo2MUkzEksKk8omCBBBIFWfQN8hYxzd/P
         OFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dBqbYW9tbViwcewTo3bCPmvXW6SZtS25kUYhTbQNV8c=;
        b=YPt7MbgUW6auIajmk3wOXxQ50sv+NUjqjkVhQNqbHb000y1/eMr0wbwmSI+XaLTz/c
         NoHKm/BsgCp2X7+zhh8nZA2YQl4ezVBhbSF3JYW059HdHQs6rhpP2+U31HN506uLvSb/
         7p2WFf/fF/vI4GftitO4JwMZg5sqjjJRaEb7C2CRLVbUxzqP3wreOfp6DnDM1R0UNaqy
         O9FIJR/M2yc3BMWfgRaffloPg3TQ9+ccA8On6kaU9/zUwyfFQDzXpzsnKGoj+pt+YzVL
         ydySGAvndlPJJf8u6hcxzJBn+wBY9j4fEXFCE17yZuTWS+VUWblrpk6NPRNmiXB/qXP3
         jlig==
X-Gm-Message-State: ACgBeo1fD7+ykfpQyr3XOdzWHyCR6fRNYyy8h23bXs0l96FV3byqbJeV
        /Vv8EodPgnU9CSIhgZJq8sYKPw==
X-Google-Smtp-Source: AA6agR6TpJGcLGt3ec1JQE9loH2/RHUpfI8WY60Mc8fNQRrRSfAKatUW5XphGdaQl8HnNqdDadGXhA==
X-Received: by 2002:a05:600c:3790:b0:3a5:435d:b2d3 with SMTP id o16-20020a05600c379000b003a5435db2d3mr5591567wmr.134.1660050887523;
        Tue, 09 Aug 2022 06:14:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d6088000000b002185631adf0sm13519557wrt.23.2022.08.09.06.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:14:47 -0700 (PDT)
Date:   Tue, 9 Aug 2022 14:14:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v7 07/13] mfd: mt6370: Add MediaTek MT6370 support
Message-ID: <YvJdxEpC2cB58Bq9@google.com>
References: <20220805070610.3516-1-peterwu.pub@gmail.com>
 <20220805070610.3516-8-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805070610.3516-8-peterwu.pub@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This adds support for the MediaTek MT6370 SubPMIC. MediaTek MT6370 is a
> SubPMIC consisting of a single cell battery charger with ADC monitoring,
> RGB LEDs, dual channel flashlight, WLED backlight driver, display bias
> voltage supply, one general purpose LDO, and the USB Type-C & PD controller
> complies with the latest USB Type-C and PD standards.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> 
> v7
> - Move '#define MT6370_REG_MAXADDR' to the next line of
>   '#define MT6370_REG_CHG_MASK1'
> - Rename 'MT6370_REG_ADDRLEN' to 'MT6370_MAX_ADDRLEN'
> ---
>  drivers/mfd/Kconfig  |  16 +++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/mt6370.c | 312 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/mt6370.h |  99 ++++++++++++++++
>  4 files changed, 428 insertions(+)
>  create mode 100644 drivers/mfd/mt6370.c
>  create mode 100644 drivers/mfd/mt6370.h

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
