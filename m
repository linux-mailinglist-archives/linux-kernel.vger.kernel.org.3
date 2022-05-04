Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6754451A2F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351725AbiEDPFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350502AbiEDPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:05:39 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB251C125;
        Wed,  4 May 2022 08:02:03 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id v66so1444797oib.3;
        Wed, 04 May 2022 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bUzFIcnTpP1YHwMyCBy1/Dkz2nFJvraPhMKAf/6334=;
        b=ZsEkxSfoYU2pRaPZABV/vJS0HO1RGWOcgiA7L9r8aox59PYXSG2Y9jz8PB8OiKVn9w
         ZjFmHBlEGUTBGnTV2RLbtoBvo0DR7+7GuIkwkTytEExAdqoGGCVBAQ8llWMqkorYeN5O
         TGQusbfh8JLORw57GYhN16mI92MzRUwuzTOVuCPcSnZ4SK9IPht2KV46JsLpiSsrK0QL
         o5c1t+N6EAYlVrTiTljKWVjbiOp8T7TV9XkTwiNsS4P5jAayLDipvymk5SAimMJraMAB
         XR6kY0Qlh8/zcwrPJqBgud6RjANBAIkJUfD99yzEO60URmX/D1RWSdYSpk8+uAg4Qbp0
         mc0A==
X-Gm-Message-State: AOAM532UaArgtx0PHtOxllURUb9/zoRZBgDSGimA9ZwLJPNJqz34fMB3
        UY9+Qm6o5ayxYj58npZA6g==
X-Google-Smtp-Source: ABdhPJwDUQBUsjncC53awzHGrsJgLkC6MgScQXjD0f1Bqi4PdHsw0mbDyGSi1wjcQvxhHX0kRG9tGQ==
X-Received: by 2002:a05:6808:ab2:b0:326:149b:64ff with SMTP id r18-20020a0568080ab200b00326149b64ffmr1673071oij.147.1651676523124;
        Wed, 04 May 2022 08:02:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d38-20020a9d2929000000b00606387601a2sm1652344otb.34.2022.05.04.08.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:02:02 -0700 (PDT)
Received: (nullmailer pid 1705139 invoked by uid 1000);
        Wed, 04 May 2022 15:02:02 -0000
Date:   Wed, 4 May 2022 10:02:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: clock: Add resets for LPASS audio
 clock controller for SC7280
Message-ID: <YnKVaXqHOSM9PByW@robh.at.kernel.org>
References: <20220503164635.23876-1-quic_tdas@quicinc.com>
 <20220503164635.23876-2-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503164635.23876-2-quic_tdas@quicinc.com>
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

On Tue, May 03, 2022 at 10:16:33PM +0530, Taniya Das wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for SC7280. Update reg property min/max items in YAML schema.
> 
> Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,sc7280-lpasscorecc.yaml        | 10 ++++++++--
>  include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h   |  5 +++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> index bad9135489de..f74d9c1cb11d 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
> @@ -38,8 +38,12 @@ properties:
>    '#power-domain-cells':
>      const: 1
> 
> +  '#reset-cells':
> +    const: 1
> +
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

When more than 1, you need to define what each entry is.

> 
>  required:
>    - compatible
> @@ -116,13 +120,15 @@ examples:
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
