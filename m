Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CA506541
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348259AbiDSHCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiDSHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:02:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8190031520
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:59:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r189so9656839ybr.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLIrmWP9mXkLIC9iIHIn3XCQoyxe5sOSyoG//x2aOB8=;
        b=ThTeM3jBhBi2PiZY4yzkoSbixU5AkEHN0BKQVu2jZHDget4O3JgkMf9IsR5Zh8cPWZ
         Kh6IPc3MfXo81VDJ8zu2NXays2VI1Py8TNWRih6cW/zMfTr1eYTM/cE1+8DgVcbkWAqO
         B57yNQW8rfX0tdpnq9btq3LQ/72k6jMszPNeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLIrmWP9mXkLIC9iIHIn3XCQoyxe5sOSyoG//x2aOB8=;
        b=I/E1Z62+1sHchmyyax3+m7Qhto7cb2xAKMoErqjuW63O7x73IaPyG8L2xb6zQWm4Tg
         yS54nNSYNc54Y5T0+Cu6l+XTpyfNh3Xy6DIvImNoUpnMLvhg4o4+vktiR15BnhXDA/ky
         Bvhkm+hNkcgEEZQSLx99Zj/WyT97gFASfgcubucj9hhSbBqlIVBlMlbMQOqmj4EC6oaJ
         KxunU3StdW5J+fRMdHhSaknoPzONDlMEu+875JNh4rBape7mJfSlkngYe1F0IQoaNsl9
         DnepWO03kgNMR+onka9AUqXqBC0bSmLS66JbT3KB4eWWmccHPPwt+E8vjkN+PuWQWIQ/
         yjDw==
X-Gm-Message-State: AOAM530AuNixIyohcJup11ws4I+gubxL5W3WN3/CyajuwsdgvdhEyZkn
        Mpr7MnrcZa0zqhrgKm4PlDwjm82ImVX3ayukXhmDuQ==
X-Google-Smtp-Source: ABdhPJzek0zDeLDFbfPQO12QrLbP1YaoyRNgh912u/LHMLJKfU2u0znkiciiHGBZwK1caQDmdSb5GTb/aZ7aUwEgMjg=
X-Received: by 2002:a25:2ac3:0:b0:645:36f4:2db3 with SMTP id
 q186-20020a252ac3000000b0064536f42db3mr2136588ybq.189.1650351557830; Mon, 18
 Apr 2022 23:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
 <20220418132154.7401-3-rex-bc.chen@mediatek.com> <CAGXv+5F027EsJCG4zQarcoqCR8S4tew1n1DjeqU7_+HOzmZs2Q@mail.gmail.com>
 <a5da87dbed150b8de4495da4a7f9b98d88e176a8.camel@mediatek.com>
In-Reply-To: <a5da87dbed150b8de4495da4a7f9b98d88e176a8.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 19 Apr 2022 14:59:06 +0800
Message-ID: <CAGXv+5FSfF=vEx71MUhpw+80baHaAYcw9cWTsQD6BfMx-p6WWw@mail.gmail.com>
Subject: Re: [PATCH 2/7] clk: mediatek: reset: Rename reset function
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, yong.liang@mediatek.com,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 2:37 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> On Tue, 2022-04-19 at 13:57 +0800, Chen-Yu Tsai wrote:
> > On Mon, Apr 18, 2022 at 9:22 PM Rex-BC Chen <rex-bc.chen@mediatek.com
> > > wrote:
> > >
> > > There are two version for clock reset register control of MediaTek
> > > SoCs.
> > > Since MT8183, the version 2 is adopted.
> > >
> > > To make the driver more readable,
> > > - Rename them to v2 for MT8183 and v1 for previous SoCs.
> > > - Adjust the fuinction order in reset.c.
> >
> > I'm not sure that the renaming actually helps, since it is not given
> > that
> > people outside of MediaTek would know which chip use which version.
> > The
> > original name of "_set_clr" at least relays how the hardware works,
> > which
> > coupled with the register naming in the datasheets make it quite
> > obvious
> > if the hardware is using the "set/clr" variant.
> >
> > On a different note, the v1 hardware, where a hardware bit represents
> > the
> > state, is quite common, and there is a common reset driver that
> > handles it.
> > Perhaps that could be reused instead of code duplicated?
> > See drivers/reset/reset-simple.c.
> >
> >
> > Thanks
> > ChenYu
>
> Hello ChenYu,
>
> Thanks for your review.
> I will use reset_simple_ops to replace v1 in next version.
>
> What do you think the proper name of v2?
> Or I just use mtk_reset_assert for v2?

I would just keep the current name.


ChenYu
