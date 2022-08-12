Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA035912CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiHLPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiHLPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:14:10 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E0A61F4;
        Fri, 12 Aug 2022 08:14:09 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id l24so1020129ion.13;
        Fri, 12 Aug 2022 08:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ikeEPiuKHYMe9xXHEeJbSPSH1rglZXTX+Lz/Wx8z9D8=;
        b=7lyj8WEE1Q3M4LxAWq5J21p3F6XCoNnXjzxALeRwQXnmdRz+qldbNG7TJaxr5dKe+6
         6c8V+WAKYT6opGCKWOup6WrfTUEN6sU1Omr2L2FZBdbZTYHMnCuNzeP2SII1B5Xz28Kw
         wQygZ9qv8juTApde8HtgibUCFWWPa02/rE65jA5KMlh56/ds8HQVuJ6NmjLbRX4unTKI
         PsHiF6WHWsPtuL1ejXbTKUjSEmRadeVC2JwBXK040y5HXFy1yMEHg/SmUKaFCpJxCbWi
         IUJb/KkURMtTxoGIFEWKhqPwvStUzOL/T466U70rzptB4QbPv9Vm6aVh7O9dQwD975mv
         0Rpg==
X-Gm-Message-State: ACgBeo06nyPbp3YYS5NLWjAVYdQhB5y9G2jrbyNL/n/WTZHZnQWtS5sA
        718N1e+Ph+fp9RKAsiDzQQ==
X-Google-Smtp-Source: AA6agR7QH8e1Cxzl8c/w8Z4o6Wh9QqSi0rqDkC8FsYzAPkC89ZCQl6Gn7SL/x2lPIDRU2S2GKjrQug==
X-Received: by 2002:a02:b60d:0:b0:343:5ddd:66b3 with SMTP id h13-20020a02b60d000000b003435ddd66b3mr2137872jam.8.1660317248790;
        Fri, 12 Aug 2022 08:14:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m66-20020a6b3f45000000b0067cb742ad4csm1054062ioa.23.2022.08.12.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:14:08 -0700 (PDT)
Received: (nullmailer pid 168984 invoked by uid 1000);
        Fri, 12 Aug 2022 15:13:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     fshao@chromium.org, lee.jones@linaro.org,
        hsin-hsiung.wang@mediatek.com, a.zummo@towertech.it,
        lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        macpaul.lin@mediatek.com, wen.su@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        sean.wang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        sen.chu@mediatek.com, hui.liu@mediatek.com,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
In-Reply-To: <20220812092901.6429-2-zhiyong.tao@mediatek.com>
References: <20220812092901.6429-1-zhiyong.tao@mediatek.com> <20220812092901.6429-2-zhiyong.tao@mediatek.com>
Subject: Re: [PATCH v3 1/1] regulator: dt-bindings: mediatek: add mt6366
Date:   Fri, 12 Aug 2022 09:13:53 -0600
Message-Id: <1660317233.452120.168983.nullmailer@robh.at.kernel.org>
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

On Fri, 12 Aug 2022 17:29:01 +0800, Zhiyong Tao wrote:
> Add mt6366 regulator document
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  .../regulator/mediatek,mt6366-regulator.yaml  | 287 ++++++++++++++++++
>  1 file changed, 287 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vrf12: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vio18: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vcamio: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vcn18: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vfe28: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vcn28: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vxo22: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vaux18: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vbif28: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vio28: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-va12: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vrf18: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.example.dtb: ldo-vaud28: 'regulator-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

