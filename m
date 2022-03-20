Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB504E1970
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 03:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiCTCPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 22:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244640AbiCTCPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 22:15:06 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849C13D68;
        Sat, 19 Mar 2022 19:13:44 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id e22so13342662ioe.11;
        Sat, 19 Mar 2022 19:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=EcBP75kXnzxIJCHk9xGycw2UXPhg1tlo3uKzCGAClzs=;
        b=h9S7NYwzMq6MYDqJB8+IW8i0dVAns9F3vKQCdQgo6n6H+kJDcNGH+E1FQgRwfyA9Li
         zO6JCTdfk+U4LsPqlNP2Eq6CBEQ732y2sz98z8CTQoGGb3JSGU+RIOSXGQQVi2aK8KyT
         v1DjiT4CZv7N6fQFEswl5mHekdpPb2KbKq7oMIUfaGVO1ueneui+Zjrkpwdjicq2AqEj
         odUmk1wzzco9pj89f/zAsLth1L4lESktVznpD5reNBRGAcw+oYdAjC1b5dle4M0WHSJV
         QSlhfQq0vFVwchlTbiQlZK6KVNNrrkX/CfUOtZfJJTmuqnTmZ6lkJDLBHBwS/b+UJMKn
         sKpQ==
X-Gm-Message-State: AOAM533MJ/4+AS9HEpR7soP8PrhFXAx1YtRff+mdaslea1m/oBdizDgf
        oU89IpIhQkXYIZo6BLLaeg==
X-Google-Smtp-Source: ABdhPJxJDPbpWKi67EujRKBkRH8RtGb7+aW3ugz6xBNYrcq3XreB500+i0t7U2WL1fo2Plmn4BTXug==
X-Received: by 2002:a05:6638:1402:b0:319:fe13:8eee with SMTP id k2-20020a056638140200b00319fe138eeemr8538086jad.130.1647742423702;
        Sat, 19 Mar 2022 19:13:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d16-20020a05660225d000b00645c8db7767sm6506688iop.35.2022.03.19.19.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 19:13:42 -0700 (PDT)
Received: (nullmailer pid 2990519 invoked by uid 1000);
        Sun, 20 Mar 2022 02:13:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yue Hu <huyue2@yulong.com>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        angelogioacchino.delregno@collabora.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mediatek@lists.infradead.org, Lucas Stach <dev@lynxeye.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
In-Reply-To: <20220317101215.24985-2-axe.yang@mediatek.com>
References: <20220317101215.24985-1-axe.yang@mediatek.com> <20220317101215.24985-2-axe.yang@mediatek.com>
Subject: Re: [RESEND v7 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
Date:   Sat, 19 Mar 2022 20:13:33 -0600
Message-Id: <1647742413.962309.2990518.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Mar 2022 18:12:13 +0800, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: properties:pinctrl-names: {'description': 'Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are mandatory in this scenarios.', 'minItems': 2, 'maxItems': 4, 'items': [{'const': 'default'}, {'const': 'state_uhs'}, {'const': 'state_eint'}, {'const': 'state_dat1'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/mtk-sd.yaml: ignoring, error in schema: properties: pinctrl-names
Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml:0:0: /example-0/mmc@11230000: failed to match any schema with compatible: ['mediatek,mt8173-mmc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1606491

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

