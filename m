Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55B4E3F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiCVN2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiCVN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:27:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE386E23;
        Tue, 22 Mar 2022 06:26:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so2540412wmj.0;
        Tue, 22 Mar 2022 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IIdko25aJ8r8oXO9dJcIkuRwywJie0xWlfwcrpolijM=;
        b=k+Xqm4XEjcNB27dcl8cbdcV2mnDhFAVtfIoMn7Bho9BKtBXi9IRwts13efcC0yHIaO
         OtrTAG1ol9iF1l3eolv/82D2yUnApnxbirFLo0N5Pnbb6HFPxtCUkx7wMWQXF0qIHLad
         O1rPYRm+7z+yOaO4Z0t5+qh4aQzYKtij/MIDBIeWyXcTbJJngE8nJpWIiuyL/O69909r
         1NIWlA2tnXo9b2yM2TbC0UIpJcVtGpBS++HHe2GXPdivECG7raR3fDW6+EbaPIYsqgOX
         b7TIc9EiimdBEg4pI8svrB7Sb/sq5232sw/hSjHbT+w5+4dFSzfheK1uTSL7glpRxKaY
         OUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IIdko25aJ8r8oXO9dJcIkuRwywJie0xWlfwcrpolijM=;
        b=hjFvrwEj0YEA5QhqAcnzqzVSVsgAs7tQ1j4p7K9E2XgU8IQWzNGyKvHJXh+d4vtnAp
         7XqHNdrVQYJCCosgtoLgz6mrUf49eCSBJKcvekhZEaaT9iZ+9hi8tyWaF4kY2GnwI0Cq
         u6dMh0zlX54UU9UXFhiQ0I7Qf+/qy4v7RKLV2nc0o5/ekSdDY+CQoyaeZJ8pbs23+d/m
         l+q2THWq3OW4wDEuH2ogcsP4JIk+QHWzqsr3xJQ0gp+qDT+SY0MPiepY7/sQyOXH4gWp
         +czqyRHTrDev2I1nH76rbIz+YcVYFU6WJBp2jBGngcipItHD5sCoMC+gyHUID0c9YKUM
         PhlQ==
X-Gm-Message-State: AOAM531pWPpSAhRsV/xctO+2aZFO8bgbW95yVnPvQQYuwcc+DDUUXVze
        wSvM9PKhcg79ewMPzeXPP7A=
X-Google-Smtp-Source: ABdhPJwCjEoZaxPfszasxDZYViMDEX1R+a26wY4aZzUJ72h6blx+Qf1X6DlzYk1oWN78GbZIaT+RHQ==
X-Received: by 2002:a5d:4890:0:b0:1ed:9d4e:f8ef with SMTP id g16-20020a5d4890000000b001ed9d4ef8efmr22733837wrq.595.1647955574998;
        Tue, 22 Mar 2022 06:26:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id x13-20020adfec0d000000b00203ff46f802sm13971386wrn.36.2022.03.22.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 06:26:14 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:26:13 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Message-ID: <YjnOdYMS+P85pqvF@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:07:26AM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2022 00:15, Ansuel Smith wrote:
> > Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> > clock add the required '#clock-cells' binding while converting it.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
> >  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
> >  2 files changed, 69 insertions(+), 44 deletions(-)
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
> > index 000000000000..7eb852be02c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> > @@ -0,0 +1,69 @@
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
> > +      - const: syscon
> 
> There was no syscon here before. This is not explained in commit msg or
> patch history, while I asked to document explicitly any deviation from
> the conversion.
> 
> This is not how the process works. You keep making silent/hidden changes
> to the bindings and to the patch submission process. It's difficult to
> review and it is even more difficult to trust you that you implement
> what we ask for. You keep resending versions of the patchset the same
> day (two versions yesterday, shortly after another one) which does not
> give time to react and review. Plus then you hide some more changes to
> regular conversion without explaining them.
> 
> NAK. It's really bad process. :(
> 
> 
> Best regards,
> Krzysztof

The thing is that i'm trying to fix all the mess of years of keeping bad
Documentation and having dts that never followed Documentation. It's
really nothing silent/hidden. You add review tag to a patch? That won't
change. The bot alert me of some bugs? I push another revision with the
bug fixed. (I understand I should not send that much revision in the
same day but still considering the slow process of reviewing the c code,
I prefer to keep the Documentation part correct and ready)

If you notice the changes across the different patch, it's very minimal
and 99% of it has not changed. Nothing silent just me addressing warning
from the bot. About the trust issue...
Is it really a syscon addition that bad? Again the original
Documentation was just bad so why should we care to have a 100% 1:1
conversion if it should have been not accepted in the first place.
The addition of this new syscon is because in the current dtsi it's
there and I assume it's there as this is a global accessor and probably
other driver would access the same regs (so it's also a syscon)

I understand the complain about putting too much revision... But NAK
this cause I'm trying to fix all this mess just because more and more
problems are coming up and I'm trying to fix them. It's a bit sad.
Hope you can understand that it's not my interest to push silent changes
or other nasty stuff. It's just me fixing the mess and trying to at
least have the Documentation part ready while I wait for c code review.

-- 
	Ansuel
