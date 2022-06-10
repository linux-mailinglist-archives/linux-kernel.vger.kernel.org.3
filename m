Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E452D546A77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349793AbiFJQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349732AbiFJQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:33:54 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB258E45;
        Fri, 10 Jun 2022 09:33:47 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h7so13715267ila.10;
        Fri, 10 Jun 2022 09:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SJRA8bZv4EkDoSWAX6IXj5FOkwecFc6bH5o9u3WQVA=;
        b=IHSzsE8by4zmzO3B5AJXWY4sPBQCbPhRndCIYoJXp7P4O6h8QIcMyGl+dG12jmlCWB
         3bzdR55Eb1X3GChRwUJCM1+IBDZ/RO0Zvk/LG2voGmk9/PawpnLzs0bJ7ynFvoncSQWg
         x/D0o5HDMR8K4CUfICvAS5M8cHGMc2msMLERJKG7i9HWFrEqsXSkZpqQuxlDZOb4qa8s
         +M0KOtLaIEc0AZbJ3D4lzMtg8/XtOeEH8NOWF/XKRj/IP64Qg7mYqSXf33I+qnj5aB1R
         gEMofIS+7vH9Dt9DLNJPclgdkjfzzOnogP0KaRmbHu0iMAkMm8jME5sa1Q9p31f1OzcK
         oYsg==
X-Gm-Message-State: AOAM532K7HSUI4OBWASfbEOaCNpa93tbcjum1jD/KHmbw6hJCeE/oPkW
        pHxnvnUo14539f2FJ9fRPQ==
X-Google-Smtp-Source: ABdhPJxR45UYGkioPDHY+f3C0XLliQgvW0kq5KZai959ccAbBSK7UnS3cbZLCMdNKsbKfJnyQy6f3g==
X-Received: by 2002:a05:6e02:1c02:b0:2d3:ccfe:6551 with SMTP id l2-20020a056e021c0200b002d3ccfe6551mr26493589ilh.134.1654878826477;
        Fri, 10 Jun 2022 09:33:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y15-20020a02bb0f000000b0032e21876ea8sm10348748jan.72.2022.06.10.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:33:46 -0700 (PDT)
Received: (nullmailer pid 1794568 invoked by uid 1000);
        Fri, 10 Jun 2022 16:33:43 -0000
Date:   Fri, 10 Jun 2022 10:33:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Message-ID: <20220610163343.GA1787330-robh@kernel.org>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
 <20220529202629.47588-2-krzysztof.kozlowski@linaro.org>
 <20220605150747.GA3465286-robh@kernel.org>
 <54015d41-d4eb-12ae-5bd1-00d2c3cf7814@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54015d41-d4eb-12ae-5bd1-00d2c3cf7814@linaro.org>
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

On Tue, Jun 07, 2022 at 01:15:51PM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2022 17:07, Rob Herring wrote:
> > On Sun, May 29, 2022 at 10:26:26PM +0200, Krzysztof Kozlowski wrote:
> >> The top level qcom,msm-id and qcom,board-id properties are utilized by
> >> bootloaders on Qualcomm MSM platforms to determine which device tree
> >> should be used and passed to the kernel.
> >>
> >> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> >> compatible format") from 2015 was a consensus during discussion about
> >> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> >> problems with that consensus:
> >> 1. It was reached 7 years ago but it turned out its implementation did
> >>    not reach all possible products.
> >>
> >> 2. Initially additional tool (dtbTool) was needed for parsing these
> >>    fields to create a QCDT image consisting of multiple DTBs, later the
> >>    bootloaders were improved and they use these qcom,msm-id and
> >>    qcom,board-id properties directly.
> >>
> >> 3. Extracting relevant information from the board compatible requires
> >>    this additional tool (dtbTool), which makes the build process more
> >>    complicated and not easily reproducible (DTBs are modified after the
> >>    kernel build).
> >>
> >> 4. Some versions of Qualcomm bootloaders expect these properties even
> >>    when booting with a single DTB.  The community is stuck with these
> >>    bootloaders thus they require properties in the DTBs.
> >>
> >> Since several upstreamed Qualcomm SoC-based boards require these
> >> properties to properly boot and the properties are reportedly used by
> >> bootloaders, document them.
> > 
> > My primary issue here is accepting this will be an endorsement for 
> > other vendors doing something similar. I'm not against an ID 
> > property(ies) in the root node, but would rather see something common 
> > if we do anything.
> 
> Hi Rob,
> 
> A more common approach was merged back in 2015 - encoding this ID
> information in the board compatibles. If I understood previous
> discussion correctly, this common method was later used by Qualcomm DTB
> post-processing tool. At least for some of the cases.
> 
> Other cases (several Qualcomm boards from different vendors) still use
> these ID properties. It even turns out they use it differently between
> vendors (e.g. Xiaomi vs OnePlus).
> 
> Important arguments for documenting these properties:
> 1. These ID properties are already on released boards where changing
> bootloader is non-trivial or even not possible. It will not be possible
> to remove these properties, without seriously affecting the community
> working with them.

Accepting things because they are already in use is also not a path we 
want to go down. If it's the color of the bike shed, then fine.

> 2. According to Konrad [1] (second paragraph), newer chipsets (starting
> with sm8350 released in 2021) do not use these properties. These newer
> DTS do not have them.
> 
> Considering 1+2 above, maybe let's document these properties as
> compatible? Would that solve your point of "endorsement for other vendors"?

What do you mean? Only allow them for certain root compatible strings? I 
suppose that would be okay by me. It would also be useful documentation 
of where they are needed.

Rob
