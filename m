Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC25625B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiF3VzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiF3VzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:55:06 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC40217;
        Thu, 30 Jun 2022 14:55:04 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id m13so571439ioj.0;
        Thu, 30 Jun 2022 14:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O0oI2Gbpm910/K3zuIgYxSbljlnn6O3+k19Oo002PO8=;
        b=h2UuwuwbnKEelVZu8LJo9AA0aImrF0GDkLZVz8mo+EUEQqFuDxorAzBX7gRP9D4NMT
         rm6f8mKyVqZKgDIIbAGaI2hPe234/3lDuyH5PeQwvVAk9FbTY/7U5kx9avfu6Od47YkG
         Btvh+TQwsMgB9XyZ+ZbsaUb2QTgOEAD9WrlhNWqvYLG4jq/WXqD3FKgGPKx2N2Wjs6f+
         /UfTbau/WZBJZ9scuA4vNaadl6vdLDS3u1doDgDEn5cB+Hov51zng2btG0HSw8fwEvIg
         l4WAALllHpUUnSz/D63d6LLSppbbL567BSWjddmVR2pzhwyLEcA+qdBakaIIhFbe6ydy
         8bRg==
X-Gm-Message-State: AJIora9tACg6r7ixO9iVlMXVy/p+t1GuEN2Tr9/JgoW5P92w8CwCU5Ld
        xkUItkoN2/t7wYOFSRb1ew==
X-Google-Smtp-Source: AGRyM1vtcfkSVY6M7PNTiDY7FVEXYZMNw3bvjSTqjH2j0Qe5vPkkxFrAuZnZMfEK51OROsKsre8rDw==
X-Received: by 2002:a05:6638:3387:b0:33c:9f9e:5a17 with SMTP id h7-20020a056638338700b0033c9f9e5a17mr6777342jav.12.1656626104166;
        Thu, 30 Jun 2022 14:55:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m2-20020a02cdc2000000b00339e6168237sm8637761jap.34.2022.06.30.14.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:55:03 -0700 (PDT)
Received: (nullmailer pid 3384041 invoked by uid 1000);
        Thu, 30 Jun 2022 21:55:00 -0000
Date:   Thu, 30 Jun 2022 15:55:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     chiaen_wu@richtek.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, jic23@kernel.org,
        daniel.thompson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        jingoohan1@gmail.com, linux-leds@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        alice_chen@richtek.com, pavel@ucw.cz, lee.jones@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, chunfeng.yun@mediatek.com,
        linux@roeck-us.net, linux-fbdev@vger.kernel.org,
        broonie@kernel.org, szunichen@gmail.com, sre@kernel.org,
        heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, deller@gmx.de
Subject: Re: [PATCH v3 05/14] dt-bindings: backlight: Add Mediatek MT6370
 backlight
Message-ID: <20220630215500.GA3383976-robh@kernel.org>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-6-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623115631.22209-6-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 19:56:22 +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add mt6370 backlight binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 
> v3
> - Rename "mediatek,bled-pwm-hys-input-threshold-steps" to
>   "mediatek,bled-pwm-hys-input-th-steps"
> - Refine "bled-pwm-hys-input-th-steps", "bled-ovp-microvolt",
>   "bled-ocp-microamp" enum values
> ---
>  .../leds/backlight/mediatek,mt6370-backlight.yaml  | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
