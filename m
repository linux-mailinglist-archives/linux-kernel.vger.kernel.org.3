Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DC95277F6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiEOOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiEOOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:15:12 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625127172;
        Sun, 15 May 2022 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=SKEEjlHOSjFCa7bZJB6iPc+e+tHsD1OSOzTQK
        j2FpAM=; b=Xo4ZpwgolloRc5ZycBxBRATmBtQjJEH/o06WM9HvrRpUmliPLi+A5
        wb8XPVQ7Amgr7LpzB1JKoXMu0dkX5X80jgbif8zv2bEVkaEtE7+vqrNQQMsuxymC
        AiMKm2m9CflRkfEMFN7o7nMu6Kv2fNliJSA49XRI+mpTXBSb19WDyw=
Received: from bobwxc.top (unknown [120.242.68.220])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgB33b3lCoFiZpaCAA--.64977S2;
        Sun, 15 May 2022 22:15:03 +0800 (CST)
Date:   Sun, 15 May 2022 22:14:59 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH V10 02/22] Documentation/zh_CN: Add basic LoongArch
 documentations
Message-ID: <YoB7c6k1i6/lAh/X@bobwxc.top>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-3-chenhuacai@loongson.cn>
 <7dc1abfd-e811-85b8-2a5b-8ace6ccb1ec7@xen0n.name>
 <CAAhV-H70qwXEWfejPjaPtbrMUA7wCMWkJueMMYPAeQxF46gJvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H70qwXEWfejPjaPtbrMUA7wCMWkJueMMYPAeQxF46gJvw@mail.gmail.com>
X-CM-TRANSID: LCKnCgB33b3lCoFiZpaCAA--.64977S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1UWr1UKw4xXw4DAFyftFb_yoWrAF4fpa
        40gFyfGan7Jw13Cws2gw1UJF15JF1xCw47GF1aqw109rnIyrs5KrWDtryqgF97Jry0vFWj
        qF4rKryY9F15A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW5XwCF04k20x
        vY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
        0xZFpf9x07jlxRDUUUUU=
X-Originating-IP: [120.242.68.220]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 14, 2022 at 10:49:19PM +0800, Huacai Chen wrote:
> Hi, Xuerui.
> 
> On Sat, May 14, 2022 at 9:26 PM WANG Xuerui <kernel@xen0n.name> wrote:
> >
> > Hi,
> >
> > On 5/14/22 16:03, Huacai Chen wrote:
> > > Add some basic documentation (zh_CN version) for LoongArch. LoongArch is
> > > a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch includes a
> > > reduced 32-bit version (LA32R), a standard 32-bit version (LA32S) and a
> > > 64-bit version (LA64).
> > >
> > > Reviewed-by: Alex Shi <alexs@kernel.org>
> > > Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >   Documentation/translations/zh_CN/index.rst    |   1 +
> > >   .../translations/zh_CN/loongarch/features.rst |   8 +
> > >   .../translations/zh_CN/loongarch/index.rst    |  26 ++
> > >   .../zh_CN/loongarch/introduction.rst          | 326 ++++++++++++++++++
> > >   .../zh_CN/loongarch/irq-chip-model.rst        | 167 +++++++++
> > >   5 files changed, 528 insertions(+)
> > >   create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
> > >   create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
> > >   create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
> > >   create mode 100644 Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> > >
> > > diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> > > index 88d8df957a78..41c59950523c 100644
> > > --- a/Documentation/translations/zh_CN/index.rst
> > > +++ b/Documentation/translations/zh_CN/index.rst
> > > @@ -171,6 +171,7 @@ TODOList:
> > >      riscv/index
> > >      openrisc/index
> > >      parisc/index
> > > +   loongarch/index
> > >
> > >   TODOList:
> > >
> > > diff --git a/Documentation/translations/zh_CN/loongarch/features.rst b/Documentation/translations/zh_CN/loongarch/features.rst
> > > new file mode 100644
> > > index 000000000000..3886e635ec06
> > > --- /dev/null
> > > +++ b/Documentation/translations/zh_CN/loongarch/features.rst
> > > @@ -0,0 +1,8 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +.. include:: ../disclaimer-zh_CN.rst
> > > +
> > > +:Original: Documentation/loongarch/features.rst
> > > +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> >
> > Actually, here's an interesting situation:
> >
> > Every LoongArch (or Loongson) developer is native speaker of Chinese,
> > not English, so most likely the "original" version of the various
> > LoongArch documentation is actually the *Chinese* one, i.e. those added
> > in this commit. As one can see, the English version has many unnatural
> > expression recognizable even by a Chinese speaker (such as myself). I've
> > seen worse translations (not necessarily in this patch series), broken
> > to the point that even Chinese speakers with an adequate understanding
> > of English (again, such as myself) *cannot* mentally map back into
> > Chinese. (Usually such broken English are in fact perfect Chinese
> > expression if mapped back word-for-word).
> >
> > So, how do we handle situation like this for the kernel documentation?
> > Do we keep the English version as the "original" or "authoritative"
> > version, even though they may be inaccurate compared to the
> > "translation", or do we just switch a bit and move this "original" and
> > "translator" information to the English version instead?
> I think the Chinese version is the original one, and the English
> version is translation.

As Documentation/translations/index.rst said:

 but please bear in mind that the *only* official documentation is the 
 English one

So, whatever the original language is, you need to keep the correct of
English version. Even the English version is a translation, it is still
the official documentation. It seems impossible to mark a official
version as "translation". But we can remove the translation tag in
Chinese version and add a note to explain why.

Also, that means Loongson need to keep the synchronization of
documentation. Updating the "official" document when the "original"
document is updated ;)

Thanks,
Wu

> 
[...]

