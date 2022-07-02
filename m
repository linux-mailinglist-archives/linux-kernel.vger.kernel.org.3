Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0B5640FC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiGBPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiGBPWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:22:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA7F589;
        Sat,  2 Jul 2022 08:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16016B8015A;
        Sat,  2 Jul 2022 15:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6894C341CB;
        Sat,  2 Jul 2022 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656775352;
        bh=2tMav/HhVl/mmXhabScCO0vkRYv++C7WhpbMm8nt2mA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FRsZ2wzWCQ8uysvLj2Bf8YbilFK487L8K+vOGFKqOj4D5DmQ02uBH8JEARTNe6IYZ
         wC2dJqZ8lqtYzVg42Of3jV5zWEBe45MzZC9Lj8O2XMDS6g2nCb9JQkYfm5fUTf8Bwu
         eijuwhRb6suaY7XJjGbZ6iUD3EVuVlI3SVa77nm9FBkZJnObF8G0FN4srNEL6w/JR6
         q3YgfmxQjFOjiwRIF8ZHP5gzSkQdmR3k/qKjVhCW6trCJzcm0ZhKNiggXrODh4cMXM
         Hl3bBdDYA5qqfyAl6XJz5bD2kXjORxVqN2370KPCjXHVo+wv+w6LEJcZy+6+dw8vF2
         oq2cgJ8AS8GVg==
Received: by mail-vk1-f176.google.com with SMTP id bb7so2471240vkb.9;
        Sat, 02 Jul 2022 08:22:32 -0700 (PDT)
X-Gm-Message-State: AJIora/nM4BJI78/RyWBY773qEDy5qs1l00ecYwr+mTEK5Qg69Z23zS9
        nz0huAV76t2DZQQ5tqiUSit7Rkq7Ad73yiNViA==
X-Google-Smtp-Source: AGRyM1sElqB7nhfgozJEOtHMoMxkEWrI0RcrzkUAChO9VDVsMbWoEZZ3uVFn/Y3qE4iVzKSxxxoA2223jPGTuqIakB0=
X-Received: by 2002:a1f:1ec8:0:b0:36c:643a:e985 with SMTP id
 e191-20020a1f1ec8000000b0036c643ae985mr14527934vke.14.1656775351619; Sat, 02
 Jul 2022 08:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org>
 <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com> <D42FBBDC-A6BA-4374-A726-061A4478D4C7@linaro.org>
In-Reply-To: <D42FBBDC-A6BA-4374-A726-061A4478D4C7@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 2 Jul 2022 09:22:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
Message-ID: <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Gross, Andy" <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 2, 2022 at 3:14 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
>
>
> On 2 July 2022 01:06:48 GMT+03:00, Rob Herring <robh@kernel.org> wrote:
> >On Sat, May 14, 2022 at 4:01 PM Bhupesh Sharma
> ><bhupesh.sharma@linaro.org> wrote:
> >>
> >> Rob pointed some remaining issues in the sdhci-msm yaml
> >> bindings (via [1]).
> >>
> >> Fix the same by first using the 'mmc-controller.yaml' as
> >> 'ref' and thereafter also fix the issues reported by
> >> 'make dtbs_check' check.
> >>
> >> [1]. https://lore.kernel.org/linux-arm-msm/YnLmNCwNfoqZln12@robh.at.kernel.org/
> >>
> >> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
> >> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >> ---
> >> -> This patch uses the dts changes sent (here: https://lore.kernel.org/linux-arm-msm/20220514215424.1007718-1-bhupesh.sharma@linaro.org/), for fixing the dtbs_check errors.
> >> -> This patch is rebased on 'linux-next/master'
> >>
> >>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 52 ++++++++++++++++---
> >>  1 file changed, 44 insertions(+), 8 deletions(-)
> >
> >There's another issue with this applied:
> >
> >Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb:
> >mmc@8804000: Unevaluated properties are not allowed
> >('operating-points-v2' was unexpected)
> >
> >Should just need a 'operating-points-v2: true' line.
> >
> >This won't show up until a fix for 'unevaluatedProperties' handling is
> >applied. But first I need all the issues fixed.
>
> Could you please add a dt-validate (?) argument so that we can validate new schemas with unevaluatedProperties working as expected, while keeping default behaviour intact (while it gets sorted out)?
>

I think that wouldn't work well because the schemas have to be
reprocessed when such an option changes. Though kbuild does look for
command line changes...

In any case, I'm going to commit this to the main branch in a few
days. There aren't many warnings left.

Rob
