Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA814E2C73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbiCUPkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbiCUPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:40:04 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47C25EB3;
        Mon, 21 Mar 2022 08:38:38 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id h4so3282568wrc.13;
        Mon, 21 Mar 2022 08:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cf0m9Mwc2BlB8cGnAdUDBhvPmKLbUteebGr9iCh2DTg=;
        b=pOOxZwcd25kDNpO+BArN7H8ZAAKmnVkpUzrE934/VBnrWaoSwEI8+G7DduBJgTp7rt
         KwKtItq3R/UhgZN5QTU974IsD93RMACssIHR37/Bd2Slam8GQzqYdN0mCbzh9agDZqp6
         n8w5Pd/SSvzbp0xdrE4NnHY7Lwka91St81ESom6TJ0lDKCTUEl3GYSmT2CAW3nB/3m5h
         QBI388I7DEMNzLW+eNrnfiIzePonMTGSGXC2MISjboZzmGu+cZq7k5lBYFoiIJpez2xG
         t9ZQws7wELFnA9DJIaLhtiIF+xBQ2UmBGNILVmT4FFNN+VcUff/vtjQQ5rZo0Qc8TI2E
         R/rw==
X-Gm-Message-State: AOAM533zjemfPtJuvC7N/71u9VfLyVfXDRRC+8ePQCnfdE/jIYDGC8iW
        z61e4nD2LFTxo2/Lj8975Hg=
X-Google-Smtp-Source: ABdhPJx3VX5shtu4IB2janA9ZSJj9UXkISBE89gJasz6bhAFIlep/kxEQ0RfkdFLmqh4yYAmU4AtGg==
X-Received: by 2002:adf:82d1:0:b0:203:e43a:ed40 with SMTP id 75-20020adf82d1000000b00203e43aed40mr18980260wrc.492.1647877117324;
        Mon, 21 Mar 2022 08:38:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id p8-20020a5d59a8000000b00204178688d3sm2418319wrr.100.2022.03.21.08.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:38:36 -0700 (PDT)
Message-ID: <39ea8a19-9c47-0a07-d938-a023d62b4450@kernel.org>
Date:   Mon, 21 Mar 2022 16:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 17/18] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-18-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321144825.11736-18-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 15:48, Ansuel Smith wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings to v1.

This looks not accurate. What additional bindings are you limiting here?
I still see two clocks required for v2, just like old bindings were
specifying.

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> deleted file mode 100644
> index 7f696362a4a1..000000000000
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> -
> -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> -There is one ACC register region per CPU within the KPSS remapped region as
> -well as an alias register region that remaps accesses to the ACC associated
> -with the CPU accessing the region.
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: should be one of:
> -			"qcom,kpss-acc-v1"
> -			"qcom,kpss-acc-v2"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: the first element specifies the base address and size of
> -		    the register region. An optional second element specifies
> -		    the base address and size of the alias register region.
> -
> -- clocks:
> -        Usage: required
> -        Value type: <prop-encoded-array>
> -        Definition: reference to the pll parents.
> -
> -- clock-names:
> -        Usage: required
> -        Value type: <stringlist>
> -        Definition: must be "pll8_vote", "pxo".
> -
> -- clock-output-names:
> -	Usage: optional
> -	Value type: <string>
> -	Definition: Name of the output clock. Typically acpuX_aux where X is a
> -		    CPU number starting at 0.
> -
> -Example:
> -
> -	clock-controller@2088000 {
> -		compatible = "qcom,kpss-acc-v2";
> -		reg = <0x02088000 0x1000>,
> -		      <0x02008000 0x1000>;
> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> -		clock-names = "pll8_vote", "pxo";
> -		clock-output-names = "acpu0_aux";
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> new file mode 100644
> index 000000000000..5a3233b1654a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kpss-acc-v1
> +      - qcom,kpss-acc-v2
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region
> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote
> +      - description: phandle to pxo_board
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    description: Name of the aux clock. Krait can have at most 4 cpu.
> +    enum:
> +      - acpu0_aux
> +      - acpu1_aux
> +      - acpu2_aux
> +      - acpu3_aux
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,kpss-acc-v1
> +      then:
> +        required:
> +          - clocks
> +          - clock-names
> +          - clock-output-names
> +          - '#clock-cells'
> +

I expect clock-output-names and clock-cells to be not allowed on v2
(else: ... clock-output-names: false).


Best regards,
Krzysztof
