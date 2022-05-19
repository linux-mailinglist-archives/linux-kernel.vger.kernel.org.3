Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E352D387
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiESNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbiESNFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:05:50 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB12DF4;
        Thu, 19 May 2022 06:05:46 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id m6-20020a05683023a600b0060612720715so3476909ots.10;
        Thu, 19 May 2022 06:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2+i74u3ZZM7l9wk2/F/HfAuqugTEXe5t2ly2GSSgeoI=;
        b=hyzPYnzizsN4xDwyAAIZyAIEYc7mvsWORe8q8SdNSPziu7ZmvhLUf/UIr7yaIo7j2+
         h/8fLPCs6r0Ze9+cnc/VRDxG919of0OqIKAFXjJErnJOoY9hMFHWf4jrbTEliYoGD5pk
         x9iW0YMmfJ9CMonSnCcZaYt7oOmyVts45POBuHK0lvyVIM+G5P62p6JpiwJdTGKpCtH+
         1H0Z3reGCKr2p4xn9vkIvFczJvcSKEdI2hCVDaUGzi5XEl/bwZ+aiF28KLqXi5/+N0h2
         GCn5WQ11AhK5RGjagElxTZLQ/1drNqS8B4bv1lVLezYvERajNZWlHS6uXz+lPSv+D36j
         hn2A==
X-Gm-Message-State: AOAM530uHBIxZFmYmqNZBffB3tQewlPeorCprz48uZ/A2E7I6zBC2TRp
        gS/NaPhOwGPNe7lbZ0ImDQ==
X-Google-Smtp-Source: ABdhPJx13WQbNFLUXx9Sun7/J3THykl4WUX5vRXL+kUcH2nWi53SzXAepLltS56IsVr6PIfDgx+HWw==
X-Received: by 2002:a9d:ed2:0:b0:60a:de4f:bd93 with SMTP id 76-20020a9d0ed2000000b0060ade4fbd93mr1534030otj.40.1652965545587;
        Thu, 19 May 2022 06:05:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a0568301e8600b0060603221280sm1722383otr.80.2022.05.19.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:05:44 -0700 (PDT)
Received: (nullmailer pid 1359565 invoked by uid 1000);
        Thu, 19 May 2022 13:05:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Satya Tangirala <satyat@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lucas Stach <dev@lynxeye.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        angelogioacchino.delregno@collabora.com,
        Yue Hu <huyue2@yulong.com>, Kiwoong Kim <kwmad.kim@samsung.com>
In-Reply-To: <20220519111323.14586-2-axe.yang@mediatek.com>
References: <20220519111323.14586-1-axe.yang@mediatek.com> <20220519111323.14586-2-axe.yang@mediatek.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
Date:   Thu, 19 May 2022 08:05:39 -0500
Message-Id: <1652965539.952223.1359564.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 19:13:21 +0800, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 53 ++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mmc/mtk-sd.example.dts:50.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

