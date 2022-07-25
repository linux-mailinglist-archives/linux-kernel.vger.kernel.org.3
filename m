Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54692580755
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiGYW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGYW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:27:46 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA23825594;
        Mon, 25 Jul 2022 15:27:45 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10d867a8358so16575328fac.10;
        Mon, 25 Jul 2022 15:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QsZxY3x/h1CKG5QnfFuRHQidpNEdsOaAbN7HUlphdhs=;
        b=OpLra2rjwctfQYOR3WD4goDH48NU6kVJm4/bvpTb+6Gxu7kk7VOYVwFKqtq8flTN9W
         vqOBNyz7GJQ4naY8IINKIg8rTFg1UP/ax75tg4a0vONRcnJz6SWZUL1zewP+RSE+323C
         kkqOREd8oDYt3f4MfUTKV0mwDtoeY+BCPJvYmSo/c+b9dCj+PA/fZD9nClsymQH2QMAO
         ikM2Puui+uhyyztPdi8+mtP58Gkvp311/1HEzTwtR34k2CdNA7Ge04Q2mJQG0/9mZVQa
         gnEptGI0UmN8ngZWQXUX2tTJTwHuc3XCE+VbbtpuL+4UczuvY7Vj6t/3Q9HlqMIRkt63
         eT5w==
X-Gm-Message-State: AJIora8gVF4QrNmgO4O8KO+CmlGdEaJJ9/fWEodpVz2FR+FnyBhJ6PBK
        /7h+Iw0CKPIDFwmArzqkwzd56W/SDQ==
X-Google-Smtp-Source: AGRyM1v4h7huPKooJcptUd4mgfbYV6YVP5u+QrfqMD0TJGGQYRQ6gM2Hy7kwEq6HK0U37c9/yjzedw==
X-Received: by 2002:a05:6870:d79d:b0:10d:ab03:b59 with SMTP id bd29-20020a056870d79d00b0010dab030b59mr6935961oab.39.1658788065042;
        Mon, 25 Jul 2022 15:27:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p28-20020a056870831c00b0010c727a3c79sm6607396oae.26.2022.07.25.15.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:27:44 -0700 (PDT)
Received: (nullmailer pid 2857915 invoked by uid 1000);
        Mon, 25 Jul 2022 22:27:42 -0000
Date:   Mon, 25 Jul 2022 16:27:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        nfraprado@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-binding: mediatek: watchdog: Fix compatible
 fallbacks and example
Message-ID: <20220725222742.GA2857882-robh@kernel.org>
References: <20220720125015.13797-1-allen-kh.cheng@mediatek.com>
 <20220720125015.13797-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720125015.13797-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 20:50:12 +0800, Allen-KH Cheng wrote:
> The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
> We should not use 'mediatek,mt6589-wdt' as fallback.
> 
> For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.
> 
> Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
> Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
> Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
> Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
