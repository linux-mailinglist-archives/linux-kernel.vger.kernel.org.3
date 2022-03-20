Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33F4E1B88
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 13:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiCTMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiCTMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 08:11:10 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC53DDD1;
        Sun, 20 Mar 2022 05:09:47 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id w25so15021197edi.11;
        Sun, 20 Mar 2022 05:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=09MJ3F+SKFH/o6mzuUI5CFbfCkCq8QY9FgJU9k73OZc=;
        b=fiRC911N6/W6iGbV1JRrSUO87WXp9WRuMNaCtvHy0RX3SanCyN0mfgEK6tpDa/FHUJ
         ZdLVla7ZBETDHCBIO+bgeQUjbZzqj1FtmHE/8AbH2jucxn1IGHc08jMsGG+FHZuE9gjR
         wtDhbteeJ1e1W1ATm0NN8byiIxMGH5Kbxx4pIa9TZKhTZiKYHE43nA5cTpUHQm9nTRqv
         b3dNSHava7sqq2AY3fkZ4lKuwUTSCgQlSlRh9ApsyTKGljisLjnqrZ6DV7WTykYfeuP0
         LIrn1WE16GO4mMqxqKYS8Tb+HaPmkHv9o+0fplHQEhR288hRub76cKdqxqTL4gSoyyaQ
         Ry9w==
X-Gm-Message-State: AOAM531q1bKi9Qupk9ZjLxtSv8zM6f7b8TntDCG/jYK17yDfQfyxKCUQ
        jTogCwt5AT2IyVetP2nT4vY=
X-Google-Smtp-Source: ABdhPJxJw0uAM+k7E1tqS8+6bFI30rkfWXjj31C1g20y/9V+mDiczOByjIKW0euKEIwV3OiVfosgQA==
X-Received: by 2002:aa7:d156:0:b0:419:bc7:acd6 with SMTP id r22-20020aa7d156000000b004190bc7acd6mr11821446edo.239.1647778186114;
        Sun, 20 Mar 2022 05:09:46 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z21-20020a1709063a1500b006da6436819dsm5790038eje.173.2022.03.20.05.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 05:09:45 -0700 (PDT)
Message-ID: <ce32768b-d68f-a5dd-ff68-4b90089c88f2@kernel.org>
Date:   Sun, 20 Mar 2022 13:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 14/16] dt-bindings: clock: Convert qcom,krait-cc to
 yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
 <20220318160827.8860-15-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318160827.8860-15-ansuelsmth@gmail.com>
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

On 18/03/2022 17:08, Ansuel Smith wrote:
> Convert qcom,krait-cc to yaml and add missing l2 clocks and names
> definiton.

lang typo.

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,krait-cc.txt          | 34 ----------
>  .../bindings/clock/qcom,krait-cc.yaml         | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> deleted file mode 100644
> index 030ba60dab08..000000000000
> --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -Krait Clock Controller
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: must be one of:
> -			"qcom,krait-cc-v1"
> -			"qcom,krait-cc-v2"
> -
> -- #clock-cells:
> -	Usage: required
> -	Value type: <u32>
> -	Definition: must be 1
> -
> -- clocks:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: reference to the clock parents of hfpll, secondary muxes.
> -
> -- clock-names:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
> -
> -Example:
> -
> -	kraitcc: clock-controller {
> -		compatible = "qcom,krait-cc-v1";
> -		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
> -		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
> -		#clock-cells = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> new file mode 100644
> index 000000000000..f89b70ab01ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Krait Clock Controller
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
> +  rates.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,krait-cc-v1
> +      - qcom,krait-cc-v2
> +
> +  clocks:
> +    items:
> +      - description: phandle to hfpll for CPU0 mux
> +      - description: phandle to hfpll for CPU1 mux
> +      - description: phandle to hfpll for L2 mux
> +      - description: phandle to CPU0 aux clock
> +      - description: phandle to CPU1 aux clock
> +      - description: phandle to L2 aux clock
> +      - description: phandle to QSB fixed clk

None of these were in original bindings, original DTS (because it does
not exist), original driver. Therefore you do not need to change
bindings during conversion.

I propose to add them in second commit with explanation why do you add them.

Best regards,
Krzysztof
