Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88984E32F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiCUWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiCUWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:48:26 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292173A35E8;
        Mon, 21 Mar 2022 15:28:56 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q189so17775145oia.9;
        Mon, 21 Mar 2022 15:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YO4SN1wEs/yJeLJGOZjJMDJTulq40d9dJPAb4zUdaCM=;
        b=VC2kKz8hIxRruEthpLYXbB+mGXbxdGVXD8Pv0QBmJRgFQFQ/6Vo8DL8it05JCuqid1
         X8+rU+u8PqcOfpEEayPMuk9ZKS8lcmw5RtaZks40cjtPfNVz680KmEwtDiTswAsU2aip
         eNBlnYU9L3thkcUjhaJIqGqTM4sCzfBQpkZFpXsRNdfSz3o5IAWsUvtZ2yPwmD1ErqNs
         RNW1vSfCWe9qqakVUnvU9SvRQcH8WwnU3wk61dueJABmW9tM7aA/vttfO0f+wkjDSbm2
         ehpgLaQW50mfzTpx1UtK8+sU3o9mOgKXxt0FtWmO2x5QKRBYEH0iT2iIPrWgRBmc0R8U
         61LQ==
X-Gm-Message-State: AOAM530TbLNlce4wNOEIw3OhGJLEVOlxkJlbmgeXLYJM1Pt4o/ndNhmG
        y+8GYrinTrGs6lkN6RCTk0BtFJl/Yw==
X-Google-Smtp-Source: ABdhPJxLqe1bKl0PVo8niOwZUt8ulY+MNU1ZxCNz4XsGxJRbPcI37WuR1d6sG+t+t9WzTmU1AnOrTQ==
X-Received: by 2002:a05:6870:c386:b0:dd:f8af:70f5 with SMTP id g6-20020a056870c38600b000ddf8af70f5mr464258oao.173.1647899461780;
        Mon, 21 Mar 2022 14:51:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020acaa813000000b002ed02ca6a3fsm7995244oie.1.2022.03.21.14.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 14:51:00 -0700 (PDT)
Received: (nullmailer pid 600564 invoked by uid 1000);
        Mon, 21 Mar 2022 21:50:59 -0000
Date:   Mon, 21 Mar 2022 16:50:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v5 15/18] dt-bindings: clock: Add L2 clocks to
 qcom,krait-cc Documentation
Message-ID: <YjjzQw4z6GCmlmp+@robh.at.kernel.org>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
 <20220321153855.12082-16-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321153855.12082-16-ansuelsmth@gmail.com>
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

On Mon, Mar 21, 2022 at 04:38:52PM +0100, Ansuel Smith wrote:
> Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
> and the hfpll_l2 clock to be provided. Add these missing clocks to the
> Documentation. The driver keep support for both old and this new
> implementation and should prevent any regression by this fixup.

Depends on what the old driver looks for.

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,krait-cc.yaml     | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> index e879bfbe67ac..f89b70ab01ae 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
> @@ -23,16 +23,20 @@ properties:
>      items:
>        - description: phandle to hfpll for CPU0 mux
>        - description: phandle to hfpll for CPU1 mux
> +      - description: phandle to hfpll for L2 mux
>        - description: phandle to CPU0 aux clock
>        - description: phandle to CPU1 aux clock
> +      - description: phandle to L2 aux clock
>        - description: phandle to QSB fixed clk

Clock indices should not change. New clocks go on the end of the list.

>  
>    clock-names:
>      items:
>        - const: hfpll0
>        - const: hfpll1
> +      - const: hfpll_l2
>        - const: acpu0_aux
>        - const: acpu1_aux
> +      - const: acpu_l2_aux
>        - const: qsb
>  
>    '#clock-cells':
> @@ -50,10 +54,10 @@ examples:
>    - |
>      clock-controller {
>        compatible = "qcom,krait-cc-v1";
> -      clocks = <&hfpll0>, <&hfpll1>,
> -               <&acpu0_aux>, <&acpu1_aux>, <&qsb>;
> -      clock-names = "hfpll0", "hfpll1",
> -                    "acpu0_aux", "acpu1_aux", "qsb";
> +      clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
> +               <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
> +      clock-names = "hfpll0", "hfpll1", "hfpll_l2",
> +                    "acpu0_aux", "acpu1_aux", "acpu_l2_aux", "qsb";
>        #clock-cells = <1>;
>      };
>  ...
> -- 
> 2.34.1
> 
> 
