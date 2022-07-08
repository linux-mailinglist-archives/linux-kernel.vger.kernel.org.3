Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD556B2A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiGHGUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiGHGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:20:36 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A472BB0E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:20:34 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101b4f9e825so28152512fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 23:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fNUjdaE0EV5/B+j5srZeGZYYmMZqdCOZDtEVyCgIxko=;
        b=up6lv63TJqDJNKt+uARsxdCYMx06YRGPTg32IQOo84VFRSGJBj5dGWn22ABK5QW2bL
         mH/hTMed8jZOXlr20wjWtNUEH3QWs4oZRMXhor/IIqbmNpN9SJ/g0GwVpW9W5t85366c
         XGcZvx0HCAnAP1oQRlx13wxwH3ozNzqO6PMicCNssjm1FxJPwCo6YzsUGnkwQxDIiEtG
         VfA9htZp9ONuXQjonl+m/80VztxTaqIgp9A4q5uhNMx8VrC3S+X3gekDNt4ChZ4Z/MdO
         VdL9O9rxbMdlKXoS7KHwsLE5J/l68QaMBBRYQLLaZPzofLD1o8+8g0q6F6TcGA3rnsXw
         6z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fNUjdaE0EV5/B+j5srZeGZYYmMZqdCOZDtEVyCgIxko=;
        b=YFlWypbpeW2EBdaOddVY5mY2BFf5L+8tRmIhNVVLlpjsVc0uMl/DgavLuLftnVTOWA
         22O2vhEnoKdXvUMzs/V9gWfqe9rxk78pznZjPLmKE+4VBndAzjEHJQH6RN9G85wMzgFj
         O+yeObGZqnwaYRDwsh8SlVvmb0lpkHVmr5RmpFsquSukgnSkFOqEAT9LtpWDKspzQ4JZ
         0h2XFwGuJsNZpGxhExi2xALI+HrRrQQ06c2lNgjH8M9lW4r0nTCrG34FlRWrrKMHi7mW
         qYlREs9Vya2s3jgBr1jH4LUXZnkE0r++E9c7sDWiNaPb3DFO/UTmkqOAcAt5qFuYOsso
         XMgg==
X-Gm-Message-State: AJIora8RcM2+X8XWTqrDP8QS0LzXBZN00e82oLjinLiVzhe9RRuiByqL
        G8oyrvOHDxcha3HdT+VMnfOWOA==
X-Google-Smtp-Source: AGRyM1taXaq5OqDQrcefmu3M0SkJMa0nCXbKpMQEe5AVrhfbaOhr8KeyNeg88OlWw/owVGZEcCrwRA==
X-Received: by 2002:a05:6870:f149:b0:dd:f3b0:986d with SMTP id l9-20020a056870f14900b000ddf3b0986dmr5065544oac.148.1657261233655;
        Thu, 07 Jul 2022 23:20:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r7-20020a0568080aa700b0032e548d96e0sm604389oij.23.2022.07.07.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:20:33 -0700 (PDT)
Date:   Thu, 07 Jul 2022 23:20:33 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Jul 2022 23:20:31 PDT (-0700)
Subject:     Re: [PATCH] riscv: don't warn for sifive erratas in modules
In-Reply-To: <CAJF2gTTXT1UusfCDrccqd1X=16Z2Gg9+cvvhSjohF+D_ukVEiw@mail.gmail.com>
CC:     heiko@sntech.de, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Christoph Hellwig <hch@lst.de>, re@w6rz.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de, guoren@kernel.org
Message-ID: <mhng-9491384b-d185-4e4f-a812-26ec8369bb6e@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jun 2022 18:12:27 PDT (-0700), guoren@kernel.org wrote:
> On Thu, Jun 9, 2022 at 5:58 PM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Hi Guo,
>>
>> Am Donnerstag, 9. Juni 2022, 03:39:24 CEST schrieb Guo Ren:
>> > On Wed, Jun 8, 2022 at 8:09 PM Heiko Stuebner <heiko@sntech.de> wrote:
>> > >
>> > > The SiFive errata code contains code checking applicable erratas
>> > > vs. actually applied erratas to suggest missing erratas to the
>> > > user when their Kconfig options are not enabled.
>> > >
>> > > In the main kernel image one can be quite sure that all available
>> > > erratas appear at least once, so that check will succeed.
>> > > On the other hand modules can very well not use any errata-relevant
>> > > code, so the newly added module-alternative support may also patch
>> > > the module code, but not touch SiFive-specific erratas at all.
>> > >
>> > > So to restore the original behaviour don't warn when patching
>> > > modules. This will keep the warning if necessary for the main kernel
>> > > image but prevent spurious warnings for modules.
>> > >
>> > > Of course having such a vendor-specific warning may not be needed at
>> > > all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
>> > > individual erratas are default-y so disabling them requires
>> > > deliberate action anyway. But for now just restore the old behaviour.
>> > >
>> > > Fixes: a8e910168bba ("riscv: implement module alternatives")
>> > > Reported-by: Ron Economos <re@w6rz.net>
>> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> > > ---
>> > >  arch/riscv/errata/sifive/errata.c | 3 ++-
>> > >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
>> > > index 672f02b21ce0..1031038423e7 100644
>> > > --- a/arch/riscv/errata/sifive/errata.c
>> > > +++ b/arch/riscv/errata/sifive/errata.c
>> > > @@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
>> > >                         cpu_apply_errata |= tmp;
>> > >                 }
>> > >         }
>> > > -       if (cpu_apply_errata != cpu_req_errata)
>> > > +       if (stage != RISCV_ALTERNATIVES_MODULE &&
>> > > +           cpu_apply_errata != cpu_req_errata)
>> > if (cpu_apply_errata &= ~cpu_req_errata)
>>
>> Hmm, I don't see what that changes?
> +       if (stage != RISCV_ALTERNATIVES_MODULE &&
> +           cpu_apply_errata != cpu_req_errata)
>                 warn_miss_errata(cpu_req_errata - cpu_apply_errata);
> +       else if (cpu_apply_errata &= ~cpu_req_errata)
>                 warn_miss_errata(cpu_req_errata - cpu_apply_errata);
>
> All module's errata should be a subset of the main kernel. Not just
> skip the check of MODULE.
>
>>
>>
>> > Shall we still guarantee the module's must be a subset of the main kernel.'s?
>>
>> The warning generated there is mainly to warn about some Kconfig options
>> not being enabled and in individual modules even no errata usage may be
>> required.

The problem here is really the mechanism by which that warning is 
generated: we assume that each alternative stage generates at least one 
instance of each errata, otherwise we provide the warning.  That's OK 
for the kernel, as we only have the one errata stage for SiFive stuff,
but modules might not directly include any behavior that depends on 
errata so they'll miss the check.

Having a mismatch between the kernel and a module could also cause 
issues, but there's way bigger issues than errata.  Unless I missed 
something there's no checks to make sure the kernel matches modules, but 
that's not really an arch/riscv thing.

>> The intent for the patch is to restore how things behaved before
>> module-alternatives were introduced, so I don't really want to
>> introduce functional changes ;-) .

IMO that's fine for a regression fix.  Maybe there's better ways to do 
this, but this at least gets rid of the spurious warning.

>> But also in the future we could debate if that warning is helpful at all,
>> as the erratas are enabled automatically by CONFIG_SOC_SIFIVE and
>> thus disabling individual erratas requires someone to turn them off
>> manually in their .config .

I could see arguments either way here: there's a bunch of Kconfigs 
(drivers and such) where turning them off will result in kernels that 
don't work and we don't warn for those, but errata are also likely to 
result in kernels that are subtly broken so being extra careful about 
checking for them seems reasonable.

This is on fixes.

Thanks!
