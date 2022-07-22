Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168F57D7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiGVAWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiGVAWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:22:15 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F24974E3F;
        Thu, 21 Jul 2022 17:22:14 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id 1so1639404ill.11;
        Thu, 21 Jul 2022 17:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37TNQXkegxnNHaxlV6oBSEt0TAcZ2231cTAxeerzb9A=;
        b=pGC9smnRAob4qn8jwEh6UskjyWnFyBzj4HlbQBKvStLq4Kd0nAw8H1QfX3tjJ91ZeI
         uhZj4xqpqt5MZto0ys3O9dfFlBMkM57cBqXl0TqdwBzpttEQrE5xte6p8UVxfCXnWFpt
         pujX1YYyLznd5HPDjPQ/MQqCHV+ft1C9CBw/aNPMUSbBEpYQ0uZskAmNOR0LuOiCeBs+
         XaxJaR8LsC+b6Ehi5LhPjzFqkJc2LHsclmbiISerjnrt3fc9sz7aJV3JVwYuyF8Otf7u
         UPRU6UfyvySIJ3+h0/6uE0Q0cwAKsl47pp4MJ14ebn7nh/bPPXgdcDmeYXP7p5w6yXW7
         pOFA==
X-Gm-Message-State: AJIora8aJJzpSS8O9Mn2joMjmfYE+MTYTGF/Qzk5xs6verwHNd5NxK7Z
        AhZf1sMG097E6zNOS3p6Vg==
X-Google-Smtp-Source: AGRyM1t3xSUTPj8NUaYheUjJGn/Wyn134h6vs453EwhUvdH1zTFkN1/JYZprUAj7UKTKrKlLTtP4HQ==
X-Received: by 2002:a05:6e02:1c43:b0:2dc:7428:cdef with SMTP id d3-20020a056e021c4300b002dc7428cdefmr413494ilg.4.1658449333103;
        Thu, 21 Jul 2022 17:22:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j10-20020a0566022cca00b00674c8448c3csm1442019iow.6.2022.07.21.17.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:22:12 -0700 (PDT)
Received: (nullmailer pid 2233392 invoked by uid 1000);
        Fri, 22 Jul 2022 00:22:10 -0000
Date:   Thu, 21 Jul 2022 18:22:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
Message-ID: <20220722002210.GA2223409-robh@kernel.org>
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com>
 <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org>
 <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
 <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org>
 <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:29:13AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 21, 2022 at 9:52 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 21/07/2022 18:43, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 21/07/2022 15:37, Doug Anderson wrote:
> > >>>
> > >>> Not worth sending a new version for, but normally I expect the
> > >>> bindings to be patch #1 and the dts change to be patch #2. In any
> > >>> case:
> > >>>
> > >>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > >>
> > >> I would say worth v4, because otherwise patches is not bisectable.
> > >
> > > You're saying because `dtbs_check` will fail between the two?
> >
> > Yes
> 
> OK. Then I assume you agree that reversing the order of the patches
> won't help, only combining the two patches into one.
> 
> 
> > > How does
> > > flipping the order help? If `dtbs_check` needs to be bisectable then
> > > these two need to be one patch, but I was always under the impression
> > > that we wanted bindings patches separate from dts patches.
> >
> > I don't think anyone said that bindings patches must be separate from
> > DTS. The only restriction is DTS cannot go with drivers.
> 
> I have always heard that best practice is to have bindings in a patch
> by themselves. If I've misunderstood and/or folks have changed their
> minds, that's fine, but historically I've been told to keep them
> separate.

Correct.


> > Bindings for boards go pretty often with DTS (subarch). This is exactly
> > what maintainers do, e.g.:
> > https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-5.20
> > Bindings for hardware should go via subsystem maintainer (drivers).
> 
> OK, fair that in this case both the bindings and the yaml will land
> through the Qualcomm tree. I guess it's really up to Bjorn and whether
> he'd prefer "make dtbs_check" to be bisectable or whether he'd prefer
> the bindings and dts change to be in separate patches from each other.

Bindings go first if applied together because you have to define the 
binding before you use it. But sometimes things go via multiple trees 
and that's fine because it's just easier. In that case, the subsystem 
tree is preferred for bindings (i.e. with the driver). But in this case, 
Bjorn is the subsystem tree.

Rob
