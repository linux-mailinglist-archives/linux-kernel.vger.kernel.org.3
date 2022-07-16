Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8269B576D33
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiGPJtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiGPJtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:49:02 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507EC13DFE;
        Sat, 16 Jul 2022 02:48:58 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 26G9mhk7014254;
        Sat, 16 Jul 2022 18:48:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 26G9mhk7014254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657964924;
        bh=/dtC549vlGdoSOYGv/+pARyo3Vm0hc5cfGNLXCx56Fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x5l5l5wL3b1vEeZI3IuHNmnU41MaGPTHXySmfwv2VNCIuNdDP4bX9cvxf3TT8y26v
         YamuUQcsNKhTp+FW4jShtBGQD7RnNu82WEqEHjRqJ6cL1PQBLrHwariLep/SyXRfJC
         GYk5vKGLE/y/cP/tZgyrjBwh4QbdVp50fEIJyK1UYMrDraMaqVsnA8xj/HSo7C2iBV
         +HnL+D2Lw36El/PmNEudVuwvnuq47u68IfEQwDA1YnXSq/EOwtf8fB+cjJIrnEA4US
         FCsbCMv/Gls2L0mjxTWf2xRvfDwiJbtfCUqsdICOnO7PYV9/brfSSegHdRQYkzF6rk
         n4cpOMw1wCxcQ==
X-Nifty-SrcIP: [209.85.128.49]
Received: by mail-wm1-f49.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so4444642wmb.5;
        Sat, 16 Jul 2022 02:48:43 -0700 (PDT)
X-Gm-Message-State: AJIora+FuDEVSue+i0XvxD6EAEIwBjumi0mU2n5/H4CAYKrJzwUhbLb7
        X+Ja5J4bTRwT9NM6IT/ydl0Rxq12ldmHBS1vklo=
X-Google-Smtp-Source: AGRyM1uxneNOF13Ebfu4qpArl4lxwbVO1STopASVugNGhMe8fIiYsC3WNvZ1InUkUyB62qUkcKJV7SIbwzUxKBJc2zs=
X-Received: by 2002:a05:600c:35d6:b0:3a2:e873:6295 with SMTP id
 r22-20020a05600c35d600b003a2e8736295mr17774399wmq.22.1657964922170; Sat, 16
 Jul 2022 02:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com> <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
In-Reply-To: <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 16 Jul 2022 18:48:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT_e0sGuzfT3FMJ=afutxiWYQxAJtV2ZcMAPiySg1+aGg@mail.gmail.com>
Message-ID: <CAK7LNAT_e0sGuzfT3FMJ=afutxiWYQxAJtV2ZcMAPiySg1+aGg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Enable DT schema checks for %.dtb targets
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 5:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jul 16, 2022 at 8:02 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jun 23, 2022 at 8:44 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > It is possible to build a single dtb, but not with DT schema validation
> > > enabled. Enable the schema validation to run for %.dtb and %.dtbo
> > > targets. Anyone building a dtb for a specific platform *should* pay
> > > attention to schema warnings.
> > >
> > > This could be supported with a separate %.dt.yaml target instead.
> > > However, the .dt.yaml format is considered an intermediate format and
> > > could possibly go away at some point if schema checking is integrated
> > > into dtc. Also, the plan is to enable the schema checks by default once
> > > platforms are free of warnings, and this is a move in that direction.
> > >
> > > This patch differs from the previous one ([1]) in the fact that it
> > > requires specifying VALIDATE_DT=1 to run the checks while doing the
> > > build. Thus default build procedures would not obtain additional build
> > > dependency, while maintainers can still build a single DTB file an get
> > > only corresponding warnings.
> >
> > I'd rather this be a kconfig option, so that eventually 'make
> > allmodconfig; make dtbs' also runs the schema checks. If something can
> > be enabled for allmodconfig, then builders will automatically start
> > testing it. Though the extra dependency is a problem here.
>
>
> The dependency on libyaml is gone.
>
> As for the dependency on dt-schema, is it a good idea to
> pull it into the kernel tree somewhere,
> like we periodically sync scripts/dtc/ with its upstream?
>
> Any other problematic tool dependency?
>
>
>
>
>
> >
> > >
> > > [1] https://lore.kernel.org/all/20210913145146.766080-1-robh@kernel.org/
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: linux-kbuild@vger.kernel.org
> > > Co-developed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  Makefile | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index c43d825a3c4c..0942922384c4 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -1365,11 +1365,17 @@ endif
> > >
> > >  ifneq ($(dtstree),)
> > >
> > > -%.dtb: include/config/kernel.release scripts_dtc
> > > -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > > +ifneq ($(VALIDATE_DT),)
> > > +DT_YAML = $(dtstree)/$*.dt.yaml
> >
> > .dt.yaml files are deprecated now. This probably doesn't do anything.
>
> Right, this causes a build error.
>
>
> masahiro@grover:~/ref/linux$ make ARCH=arm64 VALIDATE_DT=1
> arm/foundation-v8.dtb
> arch/arm64/Makefile:36: Detected assembler with broken .inst;
> disassembly will be unreliable
>   DTC     arch/arm64/boot/dts/arm/foundation-v8.dtb
>   CHECK   arch/arm64/boot/dts/arm/foundation-v8.dtb
> /home/masahiro/ref/linux/arch/arm64/boot/dts/arm/foundation-v8.dtb:
> sysreg@10000: '#address-cells' is a required property
> From schema: /home/masahiro/ref/linux/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
> /home/masahiro/ref/linux/arch/arm64/boot/dts/arm/foundation-v8.dtb:
> sysreg@10000: '#size-cells' is a required property
> From schema: /home/masahiro/ref/linux/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
> make[1]: *** No rule to make target
> 'arch/arm64/boot/dts/arm/foundation-v8.dt.yaml'.  Stop.
> make: *** [Makefile:1379: arm/foundation-v8.dtb] Error 2
>
>
>
>
>
>
>
> --
> Best Regards
>
> Masahiro Yamada





I think v2 was better than v3 at least.
(v2 reuses existing CHECK_DTBS instead of adding new VALIDATE_DT)

v2: https://lore.kernel.org/linux-kbuild/20220706114407.1507412-1-dmitry.baryshkov@linaro.org/

I commented there for a simpler implementation if we go this way.






-- 
Best Regards
Masahiro Yamada
