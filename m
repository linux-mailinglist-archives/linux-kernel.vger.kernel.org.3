Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7764F86B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbiDGR6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiDGR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:58:53 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC12C13A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:56:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w134so10893294ybe.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlVF6lOp5dpC/j+GTWtTRB8fshiniUoILlPCbn8biBo=;
        b=cnyeRbdWotGynXREUrsZQqgNgw9t4HD1KXVc4VKbHn62elv0ZJt7/Sny282D3dfpa7
         9mwQsjnSnkas/boXNFGM4nCbO8mV/xB7h4n5AXa8sVjfI3a6kspQMlWxD7mZyWIVwdGO
         1k9Sx57p+wkTVmp+URiYVrQqs+xgROZiGchYY37qIcmaFSYoqXA6sCPLlvBhtZUFpu3f
         gvjzwXPBDF9oHVP9nQmjySzPmPJpUHFLeynLskBL2jB3YA1jp/eVHOgk7UEUFUcJOEAi
         tFuYYy5mhJhPwfEJ/9nNrBcZZrwOjPrIpmdswHYrYNZ6PiZjnrXsqcHnToS9LDQHE13L
         +V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlVF6lOp5dpC/j+GTWtTRB8fshiniUoILlPCbn8biBo=;
        b=abLLllOepbTYAMH3IzdDvDEE8elwoITGRUDcuVsNXat8N4T/VRQH8bdwuxSSsoBmG6
         i1xShcJTBH/lvrQVOD/VOvKSKWJB67dz6nJUi1QD6i9rGXTLQmrp/412nkXRjeXGd7V9
         ZdunhqQ2bwSmw54hNdFGdYXQNMB+8c3+ITUNINq6x9bayQhoFc954vsX7lrkNiy9R3nh
         2BTq79/T0XZmsY2mNgA/p8mcQOMdb0h6pcJWv0APvPlEECUWnUNDlO9lq19h3rckBKcd
         IIxBzJCwg34ht8hksZMlIVk5+ojEJnyM8I7xLcIC0pzYgt1UiQd+2y3bhh+ntwnZ46dw
         oPTQ==
X-Gm-Message-State: AOAM530+1yhe5xOrMPqrskwbQ3kpoLF13gd9R1DOx3rAKjlVgSbizHNM
        lYfWg5QcehDOMNGqllBVhAP4j8T/RKzuxkZlwIXRlg==
X-Google-Smtp-Source: ABdhPJx7pBIu4DCGwRwQQvrbwgWliwJ3a5uEdC2cz90Zd9apB6WTYrp2DxQjMM+J44bGx5hlZh8QCq7A4LTclign76w=
X-Received: by 2002:a25:2409:0:b0:634:15f4:2240 with SMTP id
 k9-20020a252409000000b0063415f42240mr10337229ybk.88.1649354211810; Thu, 07
 Apr 2022 10:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
 <20220401151058.fipdax3kvmxknctv@houat> <CA+G9fYu+WddXTb0NcbviUfGQHhsmThssVCafLPw7+nj3JsoFAA@mail.gmail.com>
 <20220407075435.ahlylmbqmqnpxz64@houat> <CA+G9fYvT_W9+0AguQu97mqTm5zNnSvF0asnatZX8BTf=_1oANg@mail.gmail.com>
 <20220407134615.pqx4lxvgl4ofjrki@houat>
In-Reply-To: <20220407134615.pqx4lxvgl4ofjrki@houat>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 7 Apr 2022 23:26:40 +0530
Message-ID: <CA+G9fYucyqd6LqBGGzmwXA=hYRyETJmk_w1Z0qPnFn3+Fzj7sQ@mail.gmail.com>
Subject: Re: [next] db845c: WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
 divider_recalc_rate
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Thu, 7 Apr 2022 at 19:16, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Naresh,
>
> On Thu, Apr 07, 2022 at 05:12:09PM +0530, Naresh Kamboju wrote:
> > On Thu, 7 Apr 2022 at 13:24, Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi,
> > >
> > > > > I'm not sure if it's feasible, but if it is, it looks like something
> > > > > that could be fixed by the patch pasted here:
> > > > >
> > > > > https://lore.kernel.org/linux-clk/20220401122736.5yvanksa4pla7uql@houat/
> > > > > Could you test it?
> > > >
> > > > I have tested the single line patch and reported problems not fixed.
> > >
> > > Could you test this branch?
> > > https://github.com/mripard/linux/tree/rpi/clk-improvements-more-fixes
> >
> > I have tested your tree and branch.
> > I saw more clk prints in the boot log and did not notice the reported warning.
>
> I just pushed a new version of my branch? It should get rid of most of
> the side effects (and logs) you were seeing.

The reported problem has been fixed.
Please check this boot log and test log [1].
FYI, "clk_ignore_unused" has been used in Kernel boot args.

https://lkft.validation.linaro.org/scheduler/job/4862043#L2712


- Naresh

>
> Thanks!
> Maxime
