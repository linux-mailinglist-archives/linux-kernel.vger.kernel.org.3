Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8962459FC43
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiHXNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiHXNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:52:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA3799B49
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:49:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id n24so14452833ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m1Sal+zjZnkwoqGvQ6H8AHjXqyf22s9U5Nu3Rc+Vm0Q=;
        b=rz/0RMC74FHYHj3NS10LPfVgVyQ9/TCifjML3uU7474anZc7xN0a8/ZVKRXpxE32g8
         AecxzU8h7lJ0/Iu+xHRbxAE+ncVKfsdp7vyimyT4ul4Of8DNa+gmKGHuIlM/aBbQkXFc
         Gd8IamyePt7Whc2bOz660bYhl5Ie5+sPG8rQ67SfA8k/TnZjK2sIu1YyzZ9Shet2+59p
         KY0ycP9vaURuhY3X6Af+Ao+Av0BN0Oeb/BYuAJ5YbobBECXTFDNteDyEhwYmh1BgXDjS
         DlZCs1G5mUCSy0QFKR18yDsHIB1d/32YmD0Bs5LBLApWe+rjacUi6GsoNICVlXaLGMGC
         ajqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m1Sal+zjZnkwoqGvQ6H8AHjXqyf22s9U5Nu3Rc+Vm0Q=;
        b=MRtQ8ynA2Buj5IIp3+3v2IvOLavxvB2kcW+TrCl3UypcaZX17v4hAx4Vg49bAvkMin
         NxC1vaUhlTyuBHEuZDS/9it2gBxSxPCKTPrbeq8C2IDVte9IjUzJTw7eQvo99swGmkH8
         luzFxOr3Pf4DSyjgTZgfZ7cfgMXmPZE0EMnnTdsnvQlXgRgo5bD/1rCIkywo/DWf3Yav
         qpolSf6zknirXLVKj9cy8BPLHudh33GNYy7JaVy6IKHo91tEhwxxpj7szrFcAZrY4K3r
         9W6sJw4qya6tMCxYiLkvRdFDzmEJBwYBflVJoFobUEeNX8jnaOOHkNR+3OUk2RhUdG+9
         4REA==
X-Gm-Message-State: ACgBeo3EOSMd9Am6DbImv4Q5WUPj6grdXxQZQvU5/whAQKtzfKDmBGAE
        XidzqtZUxo4rVW5IvfpFx+HJVQ==
X-Google-Smtp-Source: AA6agR5ajdfKjHqC9MSRvD5WVvB29vhkN8j/6Wy4cmfzipDMPMFyEgCL9ozjFEdGvtJSe6rcyiqGAw==
X-Received: by 2002:a2e:b88b:0:b0:261:c9e7:fc59 with SMTP id r11-20020a2eb88b000000b00261c9e7fc59mr4821612ljp.120.1661348932352;
        Wed, 24 Aug 2022 06:48:52 -0700 (PDT)
Received: from [10.243.4.185] ([194.204.13.210])
        by smtp.gmail.com with ESMTPSA id d16-20020a0565123d1000b0048ae518364dsm2148435lfv.148.2022.08.24.06.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:48:51 -0700 (PDT)
Message-ID: <57d259cd-613b-a608-5b67-01aa72c2babb@linaro.org>
Date:   Wed, 24 Aug 2022 16:48:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4] regulator: dt-bindings: mediatek: add mt6366
Content-Language: en-US
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 15:37, Zhiyong Tao wrote:
> Add mt6366 regulator document
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

https://lore.kernel.org/all/3a26be5c-04c5-cd67-1154-dfd7d99fb5d0@linaro.org/

Where is the driver?

This ended up in spam folder, so you might need to fix up your setup
just like other folks in Mediatek did.

> ---
> Changes in patch v4:
> 1)Add unevaluatedProperties in all places
> 2)Fix check warning and errors
> 3)remove "compatible="regulator-fixed"" properties for some ldo
> 
> Changes in patch v3:
> 1)change patch title
> 2)change "regulator.yaml#" to regulator.yaml#
> 3)remove regulator-name
> 4)fix 4 space for DTS example
> 
> Changes in patch v2:
> 1)fix patch title description.
> 2)fix patch maintainer description.
> 3)won't cc to srv_heupstream@mediatek.com
> 4)fix patch commit message description.
> 5)add properties node and compatible
> 6)put "unevaluatedProperties: false" after $ref
> 7)remove underscores in node names.
> 8)change Filename to "mediatek,mt6366-regulator.yaml"
> [Zhiyong Tao <zhiyong.tao@mediatek.com>]
> ---
> ---
>  .../regulator/mediatek,mt6366-regulator.yaml  | 279 ++++++++++++++++++
>  1 file changed, 279 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> new file mode 100644
> index 000000000000..8945bf20b574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
> @@ -0,0 +1,279 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MT6366 Regulator from MediaTek Integrated
> +
> +maintainers:
> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> +
> +description: |
> +  List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  MT6366 regulators node should be sub node of the MT6397 MFD node.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6366-regulator

This looks incomplete. How does it bind? Further pieces also suggest you
send something incomplete.

> +
> +  regulators:
> +    type: object
> +    description: List of regulators and its properties
> +
> +    patternProperties:
> +      "^buck-v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^buck-(vcore)-sshub$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vcn(28|33)-bt$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vcn(33)-wifi$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vsram-(others)-sshub$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vsram-(proc11|others|gpu|proc12)$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-v(aud|bif|io|ldo)28$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-v(io|aux|rf)18$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^ldo-vsim[2]$":

I have now doubts whether you define generic regulators or quite
specific regulators you have on your board... Are the names used in the
device datasheet in register API description?


> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +        compatible = "mediatek,mt6366-regulator";
> +
> +        regulators {
> +            mt6366_vdram1_reg: buck-vdram1 {

Drop the labels here and further. Why you do not have here any regular
constraints like min/max voltage?

> +                regulator-ramp-delay = <12500>;
> +                regulator-enable-ramp-delay = <0>;
> +                regulator-allowed-modes = <0 1>;

Where do you explain the meaning of modes?

> +            };
> +
> +            mt6366_vcore_reg: buck-vcore {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <200>;
> +                regulator-allowed-modes = <0 1>;
> +            };
> +
> +           mt6366_vproc11_reg: buck-vproc11 {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <200>;
> +                regulator-allowed-modes = <0 1>;
> +            };
> +
> +            mt6366_vproc12_reg: buck-vproc12 {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <200>;
> +                regulator-allowed-modes = <0 1>;
> +            };
> +
> +            mt6366_vgpu_reg: buck-vgpu {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <200>;
> +                regulator-allowed-modes = <0 1>;
> +            };
> +
> +            mt6366_vs2_reg: buck-vs2 {
> +                regulator-ramp-delay = <12500>;
> +                regulator-enable-ramp-delay = <0>;
> +            };
> +
> +           mt6366_vmodem_reg: buck-vmodem {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <900>;
> +                regulator-allowed-modes = <0 1>;
> +            };
> +
> +            mt6366_vs1_reg: buck-vs1 {
> +                regulator-ramp-delay = <12500>;
> +                regulator-enable-ramp-delay = <0>;
> +            };
> +
> +            mt6366_vdram2_reg: ldo-vdram2 {
> +                regulator-enable-ramp-delay = <3300>;
> +            };
> +
> +            mt6366_vsim1_reg: ldo-vsim1 {
> +                regulator-enable-ramp-delay = <540>;
> +            };
> +
> +            mt6366_vibr_reg: ldo-vibr {
> +                regulator-enable-ramp-delay = <60>;
> +            };
> +
> +            mt6366_vrf12_reg: ldo-vrf12 {
> +                regulator-enable-ramp-delay = <120>;
> +            };
> +
> +            mt6366_vio18_reg: ldo-vio18 {
> +                regulator-enable-ramp-delay = <2700>;
> +            };
> +
> +            mt6366_vusb_reg: ldo-vusb {
> +                regulator-name = "vusb";
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vcamio_reg: ldo-vcamio {
> +                regulator-enable-ramp-delay = <325>;
> +            };
> +
> +            mt6366_vcamd_reg: ldo-vcamd {
> +                regulator-enable-ramp-delay = <325>;
> +            };
> +
> +            mt6366_vcn18_reg: ldo-vcn18 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vfe28_reg: ldo-vfe28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vsram_proc11_reg: ldo-vsram-proc11 {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <240>;
> +            };
> +
> +            mt6366_vcn28_reg: ldo-vcn28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vsram_others_reg: ldo-vsram-others {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <240>;
> +            };
> +
> +            mt6366_vsram_gpu_reg: ldo-vsram-gpu {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <240>;
> +            };
> +
> +            mt6366_vxo22_reg: ldo-vxo22 {
> +                regulator-enable-ramp-delay = <120>;
> +            };
> +
> +            mt6366_vefuse_reg: ldo-vefuse {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vaux18_reg: ldo-vaux18 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vmch_reg: ldo-vmch {
> +                regulator-enable-ramp-delay = <60>;
> +            };
> +
> +            mt6366_vbif28_reg: ldo-vbif28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vsram_proc12_reg: ldo-vsram-proc12 {
> +                regulator-ramp-delay = <6250>;
> +                regulator-enable-ramp-delay = <240>;
> +            };
> +
> +            mt6366_vcama1_reg: ldo-vcama1 {
> +                regulator-enable-ramp-delay = <325>;
> +            };
> +
> +            mt6366_vemc_reg: ldo-vemc {
> +                regulator-enable-ramp-delay = <60>;
> +            };
> +
> +            mt6366_vio28_reg: ldo-vio28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_va12_reg: ldo-va12 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vrf18_reg: ldo-vrf18 {
> +                regulator-enable-ramp-delay = <120>;
> +            };
> +
> +            mt6366_vcn33_bt_reg: ldo-vcn33-bt {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vcn33_wifi_reg: ldo-vcn33-wifi {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vcama2_reg: ldo-vcama2 {
> +                regulator-enable-ramp-delay = <325>;
> +            };
> +
> +            mt6366_vmc_reg: ldo-vmc {
> +                regulator-enable-ramp-delay = <60>;
> +            };
> +
> +            mt6366_vldo28_reg: ldo-vldo28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vaud28_reg: ldo-vaud28 {
> +                regulator-enable-ramp-delay = <270>;
> +            };
> +
> +            mt6366_vsim2_reg: ldo-vsim2 {
> +                regulator-enable-ramp-delay = <540>;
> +            };
> +
> +            mt6366_vcore_sshub_reg: buck-vcore-sshub {

Empty node? What does it do?



Best regards,
Krzysztof
