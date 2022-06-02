Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342053B982
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiFBNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiFBNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:14:28 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922CEEB0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:14:27 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id s1so3400963ilj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgLg/AKbyDLXa17x68nO4wD5tM3TzhU72GY+ii+nIYw=;
        b=M/WKw0pgr28e9f4TCf+3US/EEL+xYB2Og+ra97BHVbcKps3ispv/i06yZHWX6HITMn
         GuWN5ybp07+KSKBAmLnC6ChVpTXiHh5Byp+MDEqkug4+JCokhxTj9VdUwlC7Sejssr/r
         oVU8EgBtKxR9S8NSlefu1+JRdoiq/KAsrcF4X9DYFot/BZXVqRpPaBrWVm4K2kYPW3us
         wn0WNHW/9m/V8RsaqEEOeG+Nq/Iq3bYhz4G2uppznh/gUvGD0LnkmF01TuyIm27eoKmm
         D28KjsVVVqRvOicWvrZqnaak2ws8pPHj1xqA3UbJze1CNvsslGqsoJwls8K5MAf7tDuJ
         9nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgLg/AKbyDLXa17x68nO4wD5tM3TzhU72GY+ii+nIYw=;
        b=C/LBvg7FZ+GeFz34lY4Grz08TpXOLDiGFJdDzEG4+7sjc8CP5yV61Ygxyy16GFoAvO
         9vmC6nTjcGyUnb9WWpUc/ZifDi0KCB0OdvdjgyS6YHJu37cF00dz3MHEdyFBYjFwZFqj
         wxMAbGvmlgv7tW2ok6rMLv9nn30T1ePZUXTvdQquvzC8SteCTpMs6cO8Izhp6ZaEa1nX
         ljW7FRWuuzBU2VqxK7ydXu7CLaF0ywfyeyN0Ln8LGE+rHIyNFKhVyv32w5CKsNrvXf8j
         rxRFfCtnrhNVZbp8SA+03OQ6a8nJ3g5AUsBkWzZrsIw5e1CH3jgg4nBR1IU0nE8h3nJK
         wf0g==
X-Gm-Message-State: AOAM531H0Bddu8gPiF4feQrw0n5WIXZgoMGeLhtXM5D2Cl47nrD5Fidd
        AH5IFd3TVOeMjzluVFdHXuKNHwBt9w/IvtnrYUDfexh54c2koIsf
X-Google-Smtp-Source: ABdhPJy0FI+rxQz9nAWhZwndcFs2t7KOXbUPQnWiUtcloIPqI9PXi/qlrq50anIaDsEEDd86Bz/RA1Qm+q3pFTEO6cA=
X-Received: by 2002:a92:d7ce:0:b0:2cf:d004:10e2 with SMTP id
 g14-20020a92d7ce000000b002cfd00410e2mr3137913ilq.193.1654175666981; Thu, 02
 Jun 2022 06:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220531115942.1686812-1-chenhuacai@loongson.cn>
 <e7cf33a170d0b4e98e53744f60dbf922@kernel.org> <CAAhV-H6ZoqSty=yaAUPMg1QTamfwuYODB_mxf_o=HCJ1boawQg@mail.gmail.com>
 <11542d9318062155ae5dfaafc7b14bb6@kernel.org>
In-Reply-To: <11542d9318062155ae5dfaafc7b14bb6@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 21:14:15 +0800
Message-ID: <CAAhV-H6vdw2FoPBHLjTFv2iNHnbeJ8ccE2oxCqZL71fNnY6AqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: Adjust Kconfig for Loongson
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Thu, Jun 2, 2022 at 7:35 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-05-31 16:53, Huacai Chen wrote:
> > Hi, Marc,
> >
> > On Tue, May 31, 2022 at 8:52 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2022-05-31 12:59, Huacai Chen wrote:
> >> > We are preparing to add new Loongson (based on LoongArch, not
> >> > compatible
> >> > with old MIPS-based Loongson) support.
> >>
> >> Please drop this blurb from all your patches. It adds zero
> >> information.
> > OK, will be removed.
> >
> >>
> >> > HTVEC will be shared by both old
> >> > and new Loongson processors, so we adjust its description. HTPIC is
> >> > only
> >> > used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
> >> > PCH_MSI will have some arch-specific code, so we remove the
> >> > COMPILE_TEST
> >> > dependency to avoid build warnings.
> >> >
> >> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>
> >> No cover letter, no indication of what this applies on, no mention
> >> of how this relates to the ongoing irqchip review.
> >>
> >> What do you want me to do with this?
> > Sorry about the confusion; as suggested by you and Arnd, these two
> > patches
> > are the minimal changes required on irqchip's side to make the port
> > build,
> > without introducing any non-reviewed pieces of code. I originally
> > wanted to
> > send the patches then quickly reply you in the asm-generic thread, but
> > unfortunately I lost Internet connectivity at my site until you have
> > replied.
> >
> > You are knowledgeable, and have taught me much; I owe you many thanks.
> > However, as my native language is not English, I realize I may sound
> > impolite
> > or inappropriate from time to time, making some of you unhappy.
> > (Actually I
> > had to ask Xuerui to translate this reply for me, in case I get
> > something
> > wrong again.) I'll try to improve in the future and I hope you'll
> > understand.
>
> No worries. English isn't my native language either, and I somehow
> developed
> a thick skin when it comes to perceived attitude. So please don't
> apologise,
> and keep working with us.
Thanks for your understanding.

Sorry for bothering you again, but I've stripped down the irqchip
patches originally
posted at [1] even more, as can be seen in the latest submission (v14) that I've
CC-ed you; I'd like to get Acked-by from you for the 2 patches, to hopefully get
the port PR sent shortly.

In addition, as the timing is rather tight by now, if you don't want to give out
the Acked-by for any reason, would you please explain a little bit in a quick
reply? So that I can arrange for things inside Loongson in advance if the port
isn't going to appear in v5.19.

[1]: https://lore.kernel.org/lkml/20220531163236.2109556-1-chenhuacai@loongson.cn/

Thanks again,

Huacai

>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
