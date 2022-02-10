Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0F4B10CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243158AbiBJOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:47:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiBJOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:47:54 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D00A1;
        Thu, 10 Feb 2022 06:47:54 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so6643032ooi.2;
        Thu, 10 Feb 2022 06:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8fxH81jreNlAG66dkkm12iasx5L3uqki8uR5z92L6jE=;
        b=IcaeN86BBP6r3hcPjZf7jimED2wTzOYFUlvtL3nmcNAVpFZvdf6wuk4G4WIBTmeCBf
         k3hMuf1LYAnlNisqGKXShiJcl1wTcRZKt72P5x+DyNmb3u0ab8Cr3O8/LgDXlxBRlxnJ
         m9JEVDCo0761eP6fL5GiL3zE8hutecgCNljpnZ/vmrpSYFCIIc2c/D2kfWsEo+di+EXQ
         mwAB+heow6unMhyn0abjLnlAxRkBLmwIpIswY/an5uDy8BCroHj3+7AjEpVCAylHXLVJ
         ReBQ1JHvFdUeiH8unx6LKMeOUTYMkIt/8z1D8QOP3VxENlkHYZntmGYF2QsehmppejLL
         xFcw==
X-Gm-Message-State: AOAM530eUSJ8ccTRVPYUpPIIlPb9oPENLTa43/BvcL0dB2IZYBGxlC5L
        xwEI/x3hi+Vlp3DSa+jYSx1P+iX7xA==
X-Google-Smtp-Source: ABdhPJyAkIAnn1SjTWT3DVfZeP9xM7w/tc1EWhAce6OrhewoxIv9CXgMpmVC3NcjSxhSQcTlfxldQA==
X-Received: by 2002:a05:6870:ea05:: with SMTP id g5mr904565oap.181.1644504474040;
        Thu, 10 Feb 2022 06:47:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b8sm7983446otk.36.2022.02.10.06.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 06:47:53 -0800 (PST)
Received: (nullmailer pid 2624781 invoked by uid 1000);
        Thu, 10 Feb 2022 14:47:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20220210062122.23974-2-guodong.liu@mediatek.com>
References: <20220210062122.23974-1-guodong.liu@mediatek.com> <20220210062122.23974-2-guodong.liu@mediatek.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file and binding document
Date:   Thu, 10 Feb 2022 08:47:52 -0600
Message-Id: <1644504472.320340.2624780.nullmailer@robh.at.kernel.org>
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

On Thu, 10 Feb 2022 14:21:20 +0800, Guodong Liu wrote:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      |  313 +++++
>  include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174 +++++++++++++++++
>  2 files changed, 1487 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>  create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml: properties:reg-names: {'description': 'Gpio base register names.\n', 'items': [{'const': 'iocfg0'}, {'const': 'iocfg_bm'}, {'const': 'iocfg_bl'}, {'const': 'iocfg_br'}, {'const': 'iocfg_lm'}, {'const': 'iocfg_rb'}, {'const': 'iocfg_tl'}, {'const': 'eint'}], 'maxItems': 8} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml: ignoring, error in schema: properties: reg-names
Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.example.dt.yaml:0:0: /example-0/pinctrl@10005000: failed to match any schema with compatible: ['mediatek,mt8186-pinctrl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1590838

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

