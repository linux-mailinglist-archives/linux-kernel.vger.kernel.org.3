Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FE4E2C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350478AbiCUPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiCUPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:45:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE3413DE4;
        Mon, 21 Mar 2022 08:44:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h16so8249221wmd.0;
        Mon, 21 Mar 2022 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XoXisWW93pi2sg9tIKJ01ulYb1YdPWU5OGPWRm7ICC8=;
        b=ZkJpGUGZG9/PZzeERfZOKs755Ch+NcehEboHt9ataGdfL9hvC87CjoNyVxbqHHxAbZ
         R+vrihTuqVommri1kJaqDILNLLl1/jXiK7/8yuL4ENXPCCpklTkxHRCz4/teui+aJgA4
         n0w7eC++x+3Q/DuRGB4V9SAo8EZYQ7OYFk6rRCfVVI3mc4jgBZcTGWIo/5iqdCI/OBTg
         9IkUdIShLal30IKV0DZ8VaBwDaEL14DLa13qFx5WX87BkZbwnWjsEAuh6GIWQJ3GhIun
         UZg4IT6Q2RD7YzbPupQoNTNBBP+iQPhhzqS0+HtgTf3qDg1/ag9TNJlrljxJwbKZxD70
         HotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XoXisWW93pi2sg9tIKJ01ulYb1YdPWU5OGPWRm7ICC8=;
        b=DiHW7vePiRkykqYQ7rYzFJoEOG1TmKcL9ZERm3Ry2i8KmParjgKsPe6XTquumBqGez
         sHRj/galPRSO7s7yBVrpHt7Dm6EyA7dIGCGQswwnyuBOQkMtyzvxCPtM03pQsQRcZKcm
         HX/bj2NAf0oWhafCoBGyrz979XVJ7xJuTNHKrdwkpYUZG5YgHHFZytpG18gl0LyMD2fU
         Q0Jr+/MROmYiscia32wBydT8ZN6xRj5X/1Hk3veUUEGmqXV3OGNxlT8USz1ieWYMRbdV
         pD6rgPtwiMHpzi9kZ95hrS3TAAr1K6/CP+Z/DZyj7bvfs3ey4NN8X+CuEp4qubmS++AP
         7taA==
X-Gm-Message-State: AOAM531u9mGf+eKcdCx5s7ZLNkdncliT/hEcGrUJ4vm04hbN6k89RaQZ
        s1FZAdQ67B1pjwxu1aZ33Zk=
X-Google-Smtp-Source: ABdhPJxz1OvwDf6onrSDOBQ3m4NWwCfjreQVmBfTLj/cPJO7pdDw9tod5DFAPbxVQ1P8+ZVmz1FBfg==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr20648461wml.160.1647877443015;
        Mon, 21 Mar 2022 08:44:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm15457215wms.25.2022.03.21.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:44:02 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:14:43 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <YjiWY9wxGMtUAcjY@Ansuel-xps.localdomain>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-19-ansuelsmth@gmail.com>
 <a7837388-e36f-9e55-4107-9f7f85571f3b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7837388-e36f-9e55-4107-9f7f85571f3b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:41:37PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 15:48, Ansuel Smith wrote:
> > Convert kpss-gcc driver Documentation to yaml.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
> >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
> >  2 files changed, 68 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > deleted file mode 100644
> > index e628758950e1..000000000000
> > --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> > +++ /dev/null
> > @@ -1,44 +0,0 @@
> > -Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> > -
> > -PROPERTIES
> > -
> > -- compatible:
> > -	Usage: required
> > -	Value type: <string>
> > -	Definition: should be one of the following. The generic compatible
> > -			"qcom,kpss-gcc" should also be included.
> > -			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
> > -			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
> > -			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
> > -			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
> > -
> > -- reg:
> > -	Usage: required
> > -	Value type: <prop-encoded-array>
> > -	Definition: base address and size of the register region
> > -
> > -- clocks:
> > -	Usage: required
> > -	Value type: <prop-encoded-array>
> > -	Definition: reference to the pll parents.
> > -
> > -- clock-names:
> > -	Usage: required
> > -	Value type: <stringlist>
> > -	Definition: must be "pll8_vote", "pxo".
> > -
> > -- clock-output-names:
> > -	Usage: required
> > -	Value type: <string>
> > -	Definition: Name of the output clock. Typically acpu_l2_aux indicating
> > -		    an L2 cache auxiliary clock.
> > -
> > -Example:
> > -
> > -	l2cc: clock-controller@2011000 {
> > -		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
> > -		reg = <0x2011000 0x1000>;
> > -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> > -		clock-names = "pll8_vote", "pxo";
> > -		clock-output-names = "acpu_l2_aux";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > new file mode 100644
> > index 000000000000..20ee182eb16f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
> > +  to control L2 mux (in the current implementation).
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,kpss-gcc-ipq8064
> > +          - qcom,kpss-gcc-apq8064
> > +          - qcom,kpss-gcc-msm8974
> > +          - qcom,kpss-gcc-msm8960
> > +      - const: qcom,kpss-gcc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: phandle to pll8_vote
> > +      - description: phandle to pxo_board
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pll8_vote
> > +      - const: pxo
> > +
> > +  clock-output-names:
> > +    const: acpu_l2_aux
> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - clock-output-names
> > +  - '#clock-cells'
> 
> You add here a new required property, so this is not a pure conversion.
> Please explain in the commit msg why are you doing this. I asked about
> this in your previous patchset.
> 
> Best regards,
> Krzysztof

Sorry I probably missed it. Just to make sure you are referring to
#clock-cells?
Since this expose a clock, clock-cells is required. Should I put this in
a different commit? 

-- 
	Ansuel
