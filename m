Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739CA5320A9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiEXCHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiEXCGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:06:54 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9706D3AB;
        Mon, 23 May 2022 19:06:52 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id i66so19891385oia.11;
        Mon, 23 May 2022 19:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2EDROOSrbqPNpsPn0fwyesh9TCqxhLM25BxpcKmgGQ=;
        b=x1h6oPwcf2KA3pe9aUK/WXrB9ZetDTdIAlUt41ya9tHKCNjfALs7MLcGi0Us91uCwB
         ZON7f564fALFtOUnf7A8eqxFFfKKrU5e/FMC6P/26LNHthA6KsdKWyuNaKXPjvZn38HH
         lXqR8yYFDeBIwEJ8TQ82yvbUne4zdxGhuGkgXhzKfg6KXs3V0BKVZTwzCnVS3bMMnbQu
         9xSfgYQvC+5/DQtD0I3IMExHpDtNc4HTUFnoRATebqTwcHTiHL+WK+zfi7JaEfXgF99O
         XmrDcxpJ5iZKzYkVnvWrJtPrXSd9FOI7Ea775EJoTFKwoaAZfbdnOHp2npXVyspEiXX/
         4aFA==
X-Gm-Message-State: AOAM5312Y9pEncKCnH3PWKtbJ6SwEkUsKrJXpjiItM75LK05y9kbtyi4
        DuQxw28n2IMx8BJ+WmSm1A==
X-Google-Smtp-Source: ABdhPJy7VbkC9VvK40Cbz/x+9ObPFhVCPmQWe7VwrKRoxHQuCk6GKzWpIqLyO85vo/39KvA3WInvhA==
X-Received: by 2002:a05:6808:2125:b0:32b:1ba0:8b05 with SMTP id r37-20020a056808212500b0032b1ba08b05mr1101250oiw.20.1653358012155;
        Mon, 23 May 2022 19:06:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u190-20020acaabc7000000b00325cda1ffb8sm4606078oie.55.2022.05.23.19.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:06:51 -0700 (PDT)
Received: (nullmailer pid 2607411 invoked by uid 1000);
        Tue, 24 May 2022 02:06:50 -0000
Date:   Mon, 23 May 2022 21:06:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Message-ID: <20220524020650.GA2605976-robh@kernel.org>
References: <20220523092314.14252-1-quic_tdas@quicinc.com>
 <20220523092314.14252-2-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523092314.14252-2-quic_tdas@quicinc.com>
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

On Mon, May 23, 2022 at 02:53:12PM +0530, Taniya Das wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
> 
> Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../clock/qcom,sc7280-lpasscorecc.yaml        | 20 ++++++++++++++++---
>  .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> index bad9135489de..f066e8c57bbf 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> @@ -22,6 +22,8 @@ properties:
> 
>    clock-names: true
> 
> +  reg: true
> +
>    compatible:
>      enum:
>        - qcom,sc7280-lpassaoncc
> @@ -38,8 +40,8 @@ properties:
>    '#power-domain-cells':
>      const: 1
> 
> -  reg:
> -    maxItems: 1
> +  '#reset-cells':
> +    const: 1
> 
>  required:
>    - compatible
> @@ -69,6 +71,12 @@ allOf:
>            items:
>              - const: bi_tcxo
>              - const: lpass_aon_cc_main_rcg_clk_src
> +
> +        reg:
> +          maxItems: 2

Don't need maxItems. 2 is implied from 'items' length.

> +          items:
> +            - description: lpass core cc register
> +            - description: lpass audio csr register
>    - if:
>        properties:
>          compatible:
> @@ -90,6 +98,8 @@ allOf:
>              - const: bi_tcxo_ao
>              - const: iface
> 
> +        reg:
> +          maxItems: 1
>    - if:
>        properties:
>          compatible:
> @@ -108,6 +118,8 @@ allOf:
>            items:
>              - const: bi_tcxo
> 
> +        reg:
> +          maxItems: 1
>  examples:
>    - |
>      #include <dt-bindings/clock/qcom,rpmh.h>
> @@ -116,13 +128,15 @@ examples:
>      #include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>      lpass_audiocc: clock-controller@3300000 {
>        compatible = "qcom,sc7280-lpassaudiocc";
> -      reg = <0x3300000 0x30000>;
> +      reg = <0x3300000 0x30000>,
> +            <0x32a9000 0x1000>;
>        clocks = <&rpmhcc RPMH_CXO_CLK>,
>                 <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
>        clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
>        power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>        #clock-cells = <1>;
>        #power-domain-cells = <1>;
> +      #reset-cells = <1>;
>      };
> 
>    - |
> diff --git a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
> index 20ef2ea673f3..22dcd47d4513 100644
> --- a/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
> +++ b/include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h
> @@ -24,6 +24,11 @@
>  #define LPASS_AUDIO_CC_RX_MCLK_CLK			14
>  #define LPASS_AUDIO_CC_RX_MCLK_CLK_SRC			15
> 
> +/* LPASS AUDIO CC CSR */
> +#define LPASS_AUDIO_SWR_RX_CGCR				0
> +#define LPASS_AUDIO_SWR_TX_CGCR				1
> +#define LPASS_AUDIO_SWR_WSA_CGCR			2
> +
>  /* LPASS_AON_CC clocks */
>  #define LPASS_AON_CC_PLL				0
>  #define LPASS_AON_CC_PLL_OUT_EVEN			1
> --
> 2.17.1
> 
> 
