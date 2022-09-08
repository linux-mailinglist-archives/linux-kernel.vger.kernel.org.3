Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3025B2178
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiIHPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiIHPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:02:38 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043CED9A5;
        Thu,  8 Sep 2022 08:02:35 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 288F26HX020965;
        Fri, 9 Sep 2022 00:02:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 288F26HX020965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662649327;
        bh=8hQteixhTRn0IXFAmCEqnMliHvXuSMH7IbIKeVN8/rQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WyohYophnaNZeLJr8jkYQ8cIE01qdIWlIuOr1CCUXAZDh1wPUuW3dcrlNWenG1EZD
         4nesU49MQMbrTya6ETvsACljXAWwdnVphffel7Nq4jH5P5pSAdV02S7nsJ7VguuluS
         kK7WP7+pGSpMRm9vDQVC22FiVzsFfTCQiSpIQLaKqvUaBZsfErF/k2v6mZHDLSga3t
         GLO59188ubtP5O19aj4D16tqufBF7odnVFq9zoi++rWgF70FDKfA9Yuwb8saz456Cq
         VU4nQ+4EKRGMc8wrdYQrMkZ8cCO15K55xxw7lcvYoDKyRpa5wX+LonNVWnt+t3ZXhj
         1zxCcH6o26ATw==
X-Nifty-SrcIP: [209.85.210.48]
Received: by mail-ot1-f48.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so12510577otq.11;
        Thu, 08 Sep 2022 08:02:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo12REupkMkTEj71Vv0MzH4gZtcp8iuDUlP9HhKz3m3/FB33f55C
        GDgGy4jm4LkinVeE/llKwe5Bu4AGrUcggTNMo1w=
X-Google-Smtp-Source: AA6agR5EIgPiVg+b9R2y17Oh6bb4VRfCwISrVT+nftqwkQ3XwlwJlQzx0MbpWzAc8RpiE3LyivfufYGI7/vyN8EjMDU=
X-Received: by 2002:a9d:4806:0:b0:637:cdca:f8d3 with SMTP id
 c6-20020a9d4806000000b00637cdcaf8d3mr3689470otf.225.1662649326153; Thu, 08
 Sep 2022 08:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220907230339.271633-1-danielwa@cisco.com> <CAK7LNAQSUkWz9hvEmB1wSCMJ0Do209QZOgAxO=oSK6HQa7XgTg@mail.gmail.com>
 <20220908143859.GF4320@zorba>
In-Reply-To: <20220908143859.GF4320@zorba>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 9 Sep 2022 00:01:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEEVF7x1_gX-Y2fFf6Cp3RtRLr41YLkv+s8YHzo1ikKA@mail.gmail.com>
Message-ID: <CAK7LNAQEEVF7x1_gX-Y2fFf6Cp3RtRLr41YLkv+s8YHzo1ikKA@mail.gmail.com>
Subject: Re: [RFC-PATCH] Makefile: dts: include directory makefile for DTC_FLAGS
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        xe-linux-external@cisco.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 11:39 PM Daniel Walker <danielwa@cisco.com> wrote:
>
> On Thu, Sep 08, 2022 at 04:08:06PM +0900, Masahiro Yamada wrote:
> > On Thu, Sep 8, 2022 at 8:03 AM Daniel Walker <danielwa@cisco.com> wrote:
> > >
> > > The current Makefile will drop the DTC_FLAGS depending on how you
> > > build. For example,
> > >
> > > make dtbs
> > >
> > > includes correct DTC_FLAGS. However if you run,
> > >
> > > make nvidia/tegra210-p2371-2180.dtb
> > >
> > > The DTC_FLAGS are dropped. This appears to be caused by the top level
> > > Makefile not including the Makefile from the directory where the dts lives.
> > >
> > > This normally doesn't matter because most dts files have nothing added
> > > from the Makefile. This changes when you have overlays, and the
> > > DTC_FLAGS modifier is mandatory for the dtb to work correctly.
> >
> >
> > I recently fixed another issue of single target builds.
> > https://patchwork.kernel.org/project/linux-kbuild/patch/20220906061313.1445810-2-masahiroy@kernel.org/
> >
> >
> > It fixed your issue as well.
> >
> >
>
> Yeah, it fixes the issue I was seeing. Are you planning to resubmit this or is
> the v2 the final version ?
>
> Daniel


I do not have a plan to submit v3
(unless a new issue comes up)



-- 
Best Regards
Masahiro Yamada
