Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C25675FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGERvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGERvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:51:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A091A06B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 10:51:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so21901326lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iKfmYqFl8eXZRKHVQFMy0ij+1ahWYflV52//TH7IUPA=;
        b=lBt5qQV75xYWQrQSgYHwKy3sRqadvbYfSXLv0NCKs6FjpPeEJHKSkHNAyCzDQtK4v3
         +OA96M3OAtGz/CFEjQdyFdh0WrNk7RrDySPWzqdKM9HWkiMuB50R7NcXM0syHQ0bbUKw
         gK09ZCXz2Hce/Br/O3hKNAYRVRuDvRbT4DD13IncTeHeGbvpGFLVHVXyCiCSGRhyRH8P
         30yQbOxHN8jZbDG9Ipas1WRDLAomQdCv6jjk6DvjcjdFB6lAkOjNTlrgQ65RZmFRt2b5
         jP8pLBvsG68bWhqhpynIZCaOKbCkCDPLelKGuZ5vcExlJhSuJQ5m5Y27soEDxdU2xdix
         RPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iKfmYqFl8eXZRKHVQFMy0ij+1ahWYflV52//TH7IUPA=;
        b=wb8eHl79b9pDu0vW5UuQ9jsAkEyEfcHFKDsExx8nTZuv5h1Ht8obI+cVshNvw7nxpn
         L4F2SgMV2Qx24n9B5QYD7UXeyA6OuY92HDHI/reAStMYwaQhKKhfd1SDpgLjwCdTWzy1
         WElXEIeZh95n9cDlmAnFCE8X98rl4U4HLrSFjrhViCkjEMs6RAgqlahRzxa+702uYla7
         o9QHkbVvAkG7WifrztKlV7eGz4KzdBCR3FpC2dkpTo75Vl7NDXj2Cb955417zm7g0pVt
         g9LyrBU5mJ2WeQAJayKTvi4VG2arRv5tA8cA00eSf3766GZ0fqmbhHFN1oDn4d24R5lY
         4+UQ==
X-Gm-Message-State: AJIora/YNTH57ADbjWRmJDYzoz5Sf7AZ9AGiMDH7PUMK24wp+fCkSGWf
        Tg8WQmy10KUQmMqaCmZJ/qd1EQ==
X-Google-Smtp-Source: AGRyM1uXuX6zwfwoFhhbvBNBZAlJkQSisF7fAqgBYTrNnpqUXMVJoy+6qqRBQ3DpNgbqSX3UW+RrvQ==
X-Received: by 2002:a05:6512:3c86:b0:47f:afe3:f26e with SMTP id h6-20020a0565123c8600b0047fafe3f26emr22622739lfv.173.1657043499223;
        Tue, 05 Jul 2022 10:51:39 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id m10-20020a19710a000000b0047f68b11329sm5783160lfc.266.2022.07.05.10.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 10:51:38 -0700 (PDT)
Message-ID: <ebf5029e-83fd-e50d-b7cb-eae1b64f7145@linaro.org>
Date:   Tue, 5 Jul 2022 19:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705155929.25565-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 17:59, Pali Rohár wrote:
> Add device-tree bindings documentation for Turris 1.x RGB LEDs.

The patchset is difficult to find because you attached it to some older
thread. Don't.

> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v2:
> * Fix schema errors
> ---
>  .../bindings/leds/cznic,turris1x-leds.yaml    | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> new file mode 100644
> index 000000000000..bcaab5b03128
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CZ.NIC's Turris 1.x LEDs driver
> +
> +maintainers:
> +  - Pali Rohár <pali@kernel.org>
> +
> +description:
> +  This module adds support for the RGB LEDs found on the front panel of the
> +  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
> +  firmware running on Lattice FPGA. Firmware is open source and available at
> +  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
> +
> +properties:
> +  compatible:
> +    const: cznic,turris1x-leds
> +
> +  reg:
> +    description: CPLD address range where LED registers are mapped
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^multi-led@[0-7]$":
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    cpld@3,0 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x3 0x0 0x00020000>;
> +
> +        led-controller@13 {
> +            compatible = "cznic,turris1x-leds";
> +            reg = <0x13 0x1d>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            multi-led@0 {
> +                    reg = <0x0>;
You have some weird indentation here. In other places of DTS example it
is correct four spaces, so here should be four spaces as well.

Best regards,
Krzysztof
