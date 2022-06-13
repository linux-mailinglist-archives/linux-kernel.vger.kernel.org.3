Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D06549BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiFMSki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbiFMSkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:40:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E291E35DE3;
        Mon, 13 Jun 2022 08:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96587B810DD;
        Mon, 13 Jun 2022 15:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE0C341C0;
        Mon, 13 Jun 2022 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655134240;
        bh=+o2q1hRcYjzFUzea1j0OeY5des9WrszY01X5PQtHunw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bo7FRG/hdGVYGaKC1N2/Ei8F9BQ/HmnFeT7WFdUzrlsLoanJCEeYASx6vIvFRt+Dj
         AEXpNBML5f2iuwqz8E1TKO2Yy4x8tq3LPAzIMBNjXI9KK/V9CVxTZh9ZHGJOeWjM0j
         +UUz/p/bfMNjGCo31R4VFYbxOwBA4L0wD64XRK2ImbfHCFiw91xrhDBXaqJa27Fn51
         YYRMvCSE4E9H/WLdO40m7tK3KI5tUbOMFrIioBK1bEpKsrvUP9ZYTnFGyFmITwktnf
         EuXmkaJRNBM4ZE3nJ+EzPbcywtAzhQve3YLDckD762eKJVrFu/NVcbYq5oRfetmZSn
         EQ/gOsrPIWR5A==
Received: by mail-vs1-f51.google.com with SMTP id n4so6229694vsm.6;
        Mon, 13 Jun 2022 08:30:40 -0700 (PDT)
X-Gm-Message-State: AJIora/iEpNS+QdrH9SQV4SdTCqLprv0kPEI7W/T0zvOSPK1iFRr59p+
        95YeInS5eQZj/9CGXPDSvSfl6PfuNTb/HjZTpQ==
X-Google-Smtp-Source: AGRyM1vvoYCb2KN32+C4ALLGEMM949kDImgGdA/SQpmZYkAISQQLWXa3LvXAbiCq8ITHkh2LU5mvWWx3uN0meaGsQSc=
X-Received: by 2002:a05:6102:3117:b0:34b:ea03:5664 with SMTP id
 e23-20020a056102311700b0034bea035664mr276483vsh.53.1655134239259; Mon, 13 Jun
 2022 08:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-2-krzysztof.kozlowski@linaro.org> <20220605150747.GA3465286-robh@kernel.org>
 <54015d41-d4eb-12ae-5bd1-00d2c3cf7814@linaro.org> <20220610163343.GA1787330-robh@kernel.org>
 <89d6735a-61eb-08cf-8d4a-6fb1b2d457ad@linaro.org>
In-Reply-To: <89d6735a-61eb-08cf-8d4a-6fb1b2d457ad@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Jun 2022 09:30:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKL-mtAQ8Q9H4vLGM8izVVzDPbUAVWSdS8AmGjN6X6kcA@mail.gmail.com>
Message-ID: <CAL_JsqKL-mtAQ8Q9H4vLGM8izVVzDPbUAVWSdS8AmGjN6X6kcA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 7:07 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/06/2022 18:33, Rob Herring wrote:
> > On Tue, Jun 07, 2022 at 01:15:51PM +0200, Krzysztof Kozlowski wrote:
> >> On 05/06/2022 17:07, Rob Herring wrote:
> >>> On Sun, May 29, 2022 at 10:26:26PM +0200, Krzysztof Kozlowski wrote:
> >>>> The top level qcom,msm-id and qcom,board-id properties are utilized by
> >>>> bootloaders on Qualcomm MSM platforms to determine which device tree
> >>>> should be used and passed to the kernel.
> >>>>
> >>>> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> >>>> compatible format") from 2015 was a consensus during discussion about
> >>>> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> >>>> problems with that consensus:
> >>>> 1. It was reached 7 years ago but it turned out its implementation did
> >>>>    not reach all possible products.
> >>>>
> >>>> 2. Initially additional tool (dtbTool) was needed for parsing these
> >>>>    fields to create a QCDT image consisting of multiple DTBs, later the
> >>>>    bootloaders were improved and they use these qcom,msm-id and
> >>>>    qcom,board-id properties directly.
> >>>>
> >>>> 3. Extracting relevant information from the board compatible requires
> >>>>    this additional tool (dtbTool), which makes the build process more
> >>>>    complicated and not easily reproducible (DTBs are modified after the
> >>>>    kernel build).
> >>>>
> >>>> 4. Some versions of Qualcomm bootloaders expect these properties even
> >>>>    when booting with a single DTB.  The community is stuck with these
> >>>>    bootloaders thus they require properties in the DTBs.
> >>>>
> >>>> Since several upstreamed Qualcomm SoC-based boards require these
> >>>> properties to properly boot and the properties are reportedly used by
> >>>> bootloaders, document them.
> >>>
> >>> My primary issue here is accepting this will be an endorsement for
> >>> other vendors doing something similar. I'm not against an ID
> >>> property(ies) in the root node, but would rather see something common
> >>> if we do anything.
> >>
> >> Hi Rob,
> >>
> >> A more common approach was merged back in 2015 - encoding this ID
> >> information in the board compatibles. If I understood previous
> >> discussion correctly, this common method was later used by Qualcomm DTB
> >> post-processing tool. At least for some of the cases.
> >>
> >> Other cases (several Qualcomm boards from different vendors) still use
> >> these ID properties. It even turns out they use it differently between
> >> vendors (e.g. Xiaomi vs OnePlus).
> >>
> >> Important arguments for documenting these properties:
> >> 1. These ID properties are already on released boards where changing
> >> bootloader is non-trivial or even not possible. It will not be possible
> >> to remove these properties, without seriously affecting the community
> >> working with them.
> >
> > Accepting things because they are already in use is also not a path we
> > want to go down. If it's the color of the bike shed, then fine.
> >
> >> 2. According to Konrad [1] (second paragraph), newer chipsets (starting
> >> with sm8350 released in 2021) do not use these properties. These newer
> >> DTS do not have them.
> >>
> >> Considering 1+2 above, maybe let's document these properties as
> >> compatible? Would that solve your point of "endorsement for other vendors"?
> >
> > What do you mean? Only allow them for certain root compatible strings? I
> > suppose that would be okay by me. It would also be useful documentation
> > of where they are needed.
>
> Bah, I wrote something else than I had in mind. So one more try:
>
> Considering 1+2 above, maybe let's document these properties as
> *deprecated*? Would that solve your point of "endorsement for other
> vendors"?

Yes.

> However the idea to restrict them per-compatible, is also nice. Although
> I cannot guarantee the list will not grow for older SoCs.

No issue with that.

Rob
