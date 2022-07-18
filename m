Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27887578503
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiGROMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGROMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:12:52 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA632714C;
        Mon, 18 Jul 2022 07:12:51 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id h145so9311805iof.9;
        Mon, 18 Jul 2022 07:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CjYtWWfAKoGBLkN3ePtgZPz8hbvJlD5dayq7LK+HM8c=;
        b=mCwKTPYZbbdBLeNKCvNtdWJAS8kz0dp2eUmkqK5/YEpHTGlfIDwzKbJmF1OkriN3zc
         nLU7hZofWtCSkNXp3xaT3sOjHo7XcHP9HZDACxBdiwrteP/xUdiWm3QFaCs1Bd8ABKOC
         5Fzxy9axUPLNmffHBiJyznEDIgTcjivvcpvCh/hg12hY8dINHEejDkNJcxvIW/rmar66
         Xq9lZKUuiiVcbnUF5B2yw8+daRbJOOgq4vVjuoixXCVMha6RAhti2o9t9lvWWl93200V
         sXBoStAGC0Ax+IG/PeD15SB3XoKIwkFl2ODtZftK2jTjM/X1mXvVjhJiYgZnp4C+U2Km
         nTVA==
X-Gm-Message-State: AJIora/vIhjEhS/fhyfO9vJxRsRuxveHD+WQPegs7C8+xGkNXto73IFz
        EJCvE5lsXKZY7xvV/azeOYfldMeiBA==
X-Google-Smtp-Source: AGRyM1vdc6FYIMZSZdxh3LHKeIA7iTeO8nBZvbxzi60Hlrt2wYs8YOgH55g1NF3Vp4WB4jtfMlecXA==
X-Received: by 2002:a05:6638:dd1:b0:341:595e:4ef8 with SMTP id m17-20020a0566380dd100b00341595e4ef8mr5884376jaj.26.1658153571163;
        Mon, 18 Jul 2022 07:12:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x12-20020a92dc4c000000b002dc0d743570sm4864230ilq.43.2022.07.18.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 07:12:50 -0700 (PDT)
Received: (nullmailer pid 2879771 invoked by uid 1000);
        Mon, 18 Jul 2022 14:12:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hui Liu <hui.liu@mediatek.com>
Cc:     zhiyong.tao@mediatek.com, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, johnson.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sean.wang@mediatek.com, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220718113813.23787-2-hui.liu@mediatek.com>
References: <20220718113813.23787-1-hui.liu@mediatek.com> <20220718113813.23787-2-hui.liu@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: add pinctrl definition for mt8188
Date:   Mon, 18 Jul 2022 08:12:49 -0600
Message-Id: <1658153569.317351.2879770.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 19:38:11 +0800, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> This commit adds mt8188 compatible node in binding document.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8188.yaml      | 306 ++++++++++++++++++
>  1 file changed, 306 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.example.dts:21:18: fatal error: dt-bindings/pinctrl/mt8188-pinfunc.h: No such file or directory
   21 |         #include <dt-bindings/pinctrl/mt8188-pinfunc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/pinctrl/pinctrl-mt8188.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

