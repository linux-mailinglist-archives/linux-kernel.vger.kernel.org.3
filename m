Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3521D4E50F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbiCWLFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiCWLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:05:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342C329BE;
        Wed, 23 Mar 2022 04:03:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so1574264wru.4;
        Wed, 23 Mar 2022 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RWyTeLloRggO0aRSYdwaAf5udtAwME0wgjBe7d6pgFI=;
        b=QZgiweJCKofOK8uoBRmIPzRE2XcxP133Wn+ZNHmBlHh5Mud10gI/R7BVoBweFEI8mu
         nV06q23xufXrTMzsVKuDzfTqf5zf4HON9XTcteDF/O9bEjzlyKXts7IcIhVrNNUIEaJU
         6aplFeaKFkC3vH8b4eAow8F3EPIvxsFtub3j/5J+eezjKa/Jt9ttl7xgd2QYWvtf9mFx
         fjttkMZwwzgI/yis8wklZc6aSjGOobduSYUF2vX8/DiVBHb7InL7lY2XOVI/EUT5ETIo
         8Km99gvYsMI81mPq+HS8v9Td00P9Sv+r9QGaQw8esBjj6Oe5/biRBXUhXukXSLn9D44H
         CluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWyTeLloRggO0aRSYdwaAf5udtAwME0wgjBe7d6pgFI=;
        b=77hJaQKkXIzk8xrvKWjgLHUSbYB4H5dfrK0PxE7NTlehRIikFPQZvWDxeU/sSCIeZq
         zkFQ4A8QXVXl+55A3Dl0QfSHUuVAwtw+rbZzsyMKXnAAnxHgh/oNXLkv2nfXSAeZiEWu
         IUgQqA2DShIQ4DsJ3KXEEWT0ZzG2HFuBD8bCyYK2GGuEHOQqf8ninx4H+dbpxMJ/SD4z
         Lujpp6EwEn3ve7CfLUNIb+Au5/OvoQ9cRId3Hl3FzJByFn5iQ2M9dx1LBHm2g3oAk9Us
         PMLH//WWKBUa3Ks7VwHDO4Vd8oVvyWtduJYUIF2iaRc7ofDq5S+8eeTwLB0iJQ5LUCWu
         0Kaw==
X-Gm-Message-State: AOAM531+bWiDZ/2v7/hPZfX5CtOojHfkVEpQ+ngn294qkDZYAeE17wAf
        mIV/WPPBMbQlvxSJorOT0qHhm3BcosE=
X-Google-Smtp-Source: ABdhPJziR2lH8txrTYlubu9CEC0aF8NT/odmTcNjnpayJgOccreCldOkGxBFI+ugroH13x4qmQfahQ==
X-Received: by 2002:a5d:4609:0:b0:203:e792:3add with SMTP id t9-20020a5d4609000000b00203e7923addmr26543215wrq.657.1648033437644;
        Wed, 23 Mar 2022 04:03:57 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm5289709wmb.36.2022.03.23.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 04:03:57 -0700 (PDT)
Date:   Wed, 23 Mar 2022 12:03:56 +0100
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
Message-ID: <Yjr+nHBFqNqMV+v0@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
 <YjnOdYMS+P85pqvF@Ansuel-xps.localdomain>
 <f13fdc4b-8f45-b09f-5d58-8d2a565e2c18@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13fdc4b-8f45-b09f-5d58-8d2a565e2c18@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:59:39AM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2022 14:26, Ansuel Smith wrote:
> > On Tue, Mar 22, 2022 at 11:07:26AM +0100, Krzysztof Kozlowski wrote:
> >> On 22/03/2022 00:15, Ansuel Smith wrote:
> >>> Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
> >>> clock add the required '#clock-cells' binding while converting it.
> >>>
> >>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> >>> ---
> >>>  .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
> >>>  .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 69 +++++++++++++++++++
> >>>  2 files changed, 69 insertions(+), 44 deletions(-)
> >>>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >>> deleted file mode 100644
> >>> index e628758950e1..000000000000
> >>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
> >>> +++ /dev/null
> >>> @@ -1,44 +0,0 @@
> >>> -Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> >>> -
> >>> -PROPERTIES
> >>> -
> >>> -- compatible:
> >>> -	Usage: required
> >>> -	Value type: <string>
> >>> -	Definition: should be one of the following. The generic compatible
> >>> -			"qcom,kpss-gcc" should also be included.
> >>> -			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
> >>> -			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
> >>> -			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
> >>> -			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
> >>> -
> >>> -- reg:
> >>> -	Usage: required
> >>> -	Value type: <prop-encoded-array>
> >>> -	Definition: base address and size of the register region
> >>> -
> >>> -- clocks:
> >>> -	Usage: required
> >>> -	Value type: <prop-encoded-array>
> >>> -	Definition: reference to the pll parents.
> >>> -
> >>> -- clock-names:
> >>> -	Usage: required
> >>> -	Value type: <stringlist>
> >>> -	Definition: must be "pll8_vote", "pxo".
> >>> -
> >>> -- clock-output-names:
> >>> -	Usage: required
> >>> -	Value type: <string>
> >>> -	Definition: Name of the output clock. Typically acpu_l2_aux indicating
> >>> -		    an L2 cache auxiliary clock.
> >>> -
> >>> -Example:
> >>> -
> >>> -	l2cc: clock-controller@2011000 {
> >>> -		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
> >>> -		reg = <0x2011000 0x1000>;
> >>> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> >>> -		clock-names = "pll8_vote", "pxo";
> >>> -		clock-output-names = "acpu_l2_aux";
> >>> -	};
> >>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >>> new file mode 100644
> >>> index 000000000000..7eb852be02c1
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
> >>> @@ -0,0 +1,69 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
> >>> +
> >>> +maintainers:
> >>> +  - Ansuel Smith <ansuelsmth@gmail.com>
> >>> +
> >>> +description: |
> >>> +  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
> >>> +  to control L2 mux (in the current implementation).
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - enum:
> >>> +          - qcom,kpss-gcc-ipq8064
> >>> +          - qcom,kpss-gcc-apq8064
> >>> +          - qcom,kpss-gcc-msm8974
> >>> +          - qcom,kpss-gcc-msm8960
> >>> +      - const: qcom,kpss-gcc
> >>> +      - const: syscon
> >>
> >> There was no syscon here before. This is not explained in commit msg or
> >> patch history, while I asked to document explicitly any deviation from
> >> the conversion.
> >>
> >> This is not how the process works. You keep making silent/hidden changes
> >> to the bindings and to the patch submission process. It's difficult to
> >> review and it is even more difficult to trust you that you implement
> >> what we ask for. You keep resending versions of the patchset the same
> >> day (two versions yesterday, shortly after another one) which does not
> >> give time to react and review. Plus then you hide some more changes to
> >> regular conversion without explaining them.
> >>
> >> NAK. It's really bad process. :(
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > The thing is that i'm trying to fix all the mess of years of keeping bad
> > Documentation and having dts that never followed Documentation. It's
> > really nothing silent/hidden. You add review tag to a patch? That won't
> > change. The bot alert me of some bugs? I push another revision with the
> > bug fixed. 
> 
> It does not necessarily mean that bindings are bad and such changes
> should be documented.
> 
> > (I understand I should not send that much revision in the
> > same day but still considering the slow process of reviewing the c code,
> > I prefer to keep the Documentation part correct and ready)
> 
> Rob also pointed to this - sending two versions of this huge patchset
> the same day is way too much.
>

You are totally right. I understand now the problem.

> > 
> > If you notice the changes across the different patch, it's very minimal
> > and 99% of it has not changed. Nothing silent just me addressing warning
> > from the bot. About the trust issue...
> > Is it really a syscon addition that bad? Again the original
> > Documentation was just bad so why should we care to have a 100% 1:1
> > conversion if it should have been not accepted in the first place.
> 
> Does not have to be 100% but deviations should be either expected or
> explained. Bindings are used also outside of Linux kernel.
> 
> > The addition of this new syscon is because in the current dtsi it's
> > there and I assume it's there as this is a global accessor and probably
> > other driver would access the same regs (so it's also a syscon)
> 
> If these are assumptions, then they need to be checked. If these were
> new bindings, we would discuss/check the need of syscon. Now we do not
> question existing properties, because they were accepted. But syscon
> compatible was not accepted, so putting it here requires our acknowledgment.
> 

About this I have a question. If the dts already have some binding and
the Documentation doesn't have them. Should the dts have priority or the
Documentation?
In the case where we can't prove that syscon is needed (for example), can
we remove it from dts (and accept to have inconsistency while the dts
changes are merged) or we should add the extra binding to the
Documentation putting some comments about it and discussing the
inclusion? 

> The bindings are probably pure junk, so this is not merely a conversion
> how you wrote in commit msg. This is rework of the bindings. Don't hide
> rework under "conversion". Conversion is TXT->YAML without any changes...
> 

Ok, thanks for the clarification. I still think should be handled with
conversion + additional commit to add the missing part so I have to fix
my wrong commits.

> I asked about this before and the only part you added to commit msg was
> "clock-cells". And now I see syscon - so isn't it a bit surprising?
> 

You are right... I will just do the 1:1 conversion and put all these
addition to a separate commit to make them clear.

> > 
> > I understand the complain about putting too much revision... But NAK
> > this cause I'm trying to fix all this mess just because more and more
> > problems are coming up and I'm trying to fix them. It's a bit sad.
> 
> Why you cannot test your changes and fix them all before sending sixth
> version? Why the bot has to test your code, not you?
> 

I'm aksed Rob if there is a quicker way to test single Documenation and
dts but it's my fault anyway.

> > Hope you can understand that it's not my interest to push silent changes
> > or other nasty stuff. It's just me fixing the mess and trying to at
> > least have the Documentation part ready while I wait for c code review.
> Best regards,
> Krzysztof

-- 
	Ansuel
