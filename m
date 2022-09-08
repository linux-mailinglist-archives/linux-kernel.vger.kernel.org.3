Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556545B1D31
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIHMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiIHMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:35:05 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A22D46DB4;
        Thu,  8 Sep 2022 05:35:04 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1278a61bd57so25378501fac.7;
        Thu, 08 Sep 2022 05:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jtr3p5j/5DRL0YbjSC8bWCtn5/EBjL0frgBB2T6QJQs=;
        b=UeH+BNC1pLe9+74rUfiqSt3FxTb8qGdR4JFk3KdubQm83oFjZnW823ygN0E7MinI7R
         WkrG40f6FhYAlUYJ6cu0XS0HmgCLRjDvAVne3cRb6Wp9rmXPmcgsxZmckWVnwe7/IfPh
         D9/VlQcxHlCQN9wKwJV8iVxKLf1w2v0Er6QaYDTUsDcLwsyHYE5x8H1/XlZEnZyKRGLx
         TQVB5V+Xqn2dDPl3DbW0ejbDS+6pUp0sksL9OlyqnkJguDRbzh0zaBY6GEKwXnSDU1iB
         RS2uQjY+wBzBayzMNvgpRhApegRowDk5qboevRaDqkEpJ/7Ok5yHcKlxNapvo7btcBSo
         V/vA==
X-Gm-Message-State: ACgBeo1Wgy21jSJL7QbJXDGjfTpJ0tdo11hFtj/gnnKt55cRloPNJYt9
        fXDg1E4GTfeUk5i5Fowv2SVanMV69g==
X-Google-Smtp-Source: AA6agR6Eir+ai1AypOeRyNPLX6bOtb5zKFX1YkGCr8hnsznL/Uw2peWhUP3YRVLOTVBWk77FhE3P/w==
X-Received: by 2002:a05:6871:72a:b0:127:7b8e:feca with SMTP id f42-20020a056871072a00b001277b8efecamr1715936oap.193.1662640503661;
        Thu, 08 Sep 2022 05:35:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v18-20020a056870b51200b0011f22e74d5fsm5374067oap.20.2022.09.08.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 05:35:03 -0700 (PDT)
Received: (nullmailer pid 2262543 invoked by uid 1000);
        Thu, 08 Sep 2022 12:35:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20220908003107.220143-9-sebastian.reichel@collabora.com>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com> <20220908003107.220143-9-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv2 08/13] dt-bindings: mfd: add rk806 binding
Date:   Thu, 08 Sep 2022 07:35:00 -0500
Message-Id: <1662640500.364305.2262542.nullmailer@robh.at.kernel.org>
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

On Thu, 08 Sep 2022 02:31:02 +0200, Sebastian Reichel wrote:
> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/mfd/rockchip,rk806.yaml          | 388 ++++++++++++++++++
>  1 file changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rockchip,rk806.example.dtb: pmic@0: regulators: Unevaluated properties are not allowed ('nldo-reg1', 'nldo-reg2', 'nldo-reg3', 'nldo-reg4', 'nldo-reg5', 'pldo-reg1', 'pldo-reg2', 'pldo-reg3', 'pldo-reg4', 'pldo-reg5', 'pldo-reg6' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

