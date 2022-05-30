Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2E538915
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbiE3XLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiE3XLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 19:11:31 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502C674D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:11:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w21so462931pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XccysWYb9npF6/LhDMMloDpt6bBM9wjai1M7rMuSIWA=;
        b=rEab6xQwEY+eak1x8ft2kjj07SA4kneFvxf9adlurZbtSov84bRMpGloFeGQOBjiJE
         OQ2qrUSAwSfpyJM2Fcl4HvAPv3VSoYYPvdnUj2w6JucpE9uPQ0mnkx71/OhVqYg2+CWg
         BBQ/lbXI6x43ekWTRCgZ/Dm9K31i4HWACdKAO2U24CgCYtqI5zT0cLGqr9Ia8zvNX5Pp
         +rFWp27IhTGXJMo46x6MaK4PZXfQ2VWP1+42/N4/90uwBRCpvCKB4ArBfcdGDt08Vcxx
         q1AC3Q/Ldch9FHiiWGDvfctYxhGuvdatyIXFs2ah/NxknnESi/6v7I4Rby1xMSc8iLxh
         ULIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XccysWYb9npF6/LhDMMloDpt6bBM9wjai1M7rMuSIWA=;
        b=tyfdBZ1DSbFlBHvt9vw8RysHB5xVGMscu072QjtKWoHze5VQ4a9Pv1qu5ndfqbTv+z
         4Y46Izj5fn+Xtb56SQYIJdrvHthdG77NkCH6ZoPC6tG+MD8+u63sYOxePcX8hC8xu7iH
         AOBMTrgnaULPLIGX3/y2cRDKWuP300d5CdTcXSsy7g93qQI9YTBTEvdz/Pk6y+t7XvgK
         ilqByLchFPUQeJrCohowi2oH2zHnv5MG1DZsTko7A1xlw62WlWOCFKGDatJx2/kn0Gwk
         4wtV/+pHD69laX+0ALyBoasD5ZW1kw6Xz3ou0Db8u2bO6tMMAqvkAWDBjCUDeaIQ4DV9
         vVXw==
X-Gm-Message-State: AOAM533srJfEigS6C8jwDP1iHzso11gn7AQSS0/bLXDrkmP7xYPByxK+
        WXPBrEwGsw6RutQg7SGvRyWHvg==
X-Google-Smtp-Source: ABdhPJywJkfeRl2r1A5LD7jIeXFcAGYOXC/vSUBBTpRc2bJNyDatde0HYxiGJjkDLh3XNObv/FtM4g==
X-Received: by 2002:a05:6a00:248c:b0:519:27f7:28a8 with SMTP id c12-20020a056a00248c00b0051927f728a8mr20376570pfv.32.1653952288194;
        Mon, 30 May 2022 16:11:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z125-20020a626583000000b00518119900e9sm9372102pfb.53.2022.05.30.16.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 16:11:27 -0700 (PDT)
Date:   Mon, 30 May 2022 16:11:27 -0700 (PDT)
X-Google-Original-Date: Mon, 30 May 2022 16:11:25 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
In-Reply-To: <20220530194133.udwdjsb2l33hsiil@pengutronix.de>
CC:     wangkefeng.wang@huawei.com, guoren@linux.alibaba.com,
        sunnanyong@huawei.com, jszhang@kernel.org, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>, alex@ghiti.fr,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        lizhengyu3@huawei.com, aou@eecs.berkeley.edu,
        liaochang1@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Topel <bjorn.topel@gmail.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, penberg@kernel.org,
        ebiederm@xmission.com, kernel@pengutronix.de,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     u.kleine-koenig@pengutronix.de
Message-ID: <mhng-99e09fbd-fa71-40fc-92da-ff4af0d209a5@palmer-mbp2014>
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

On Mon, 30 May 2022 12:41:33 PDT (-0700), u.kleine-koenig@pengutronix.de wrote:
> Hello,
>
> On Mon, May 30, 2022 at 11:58:16AM -0700, Palmer Dabbelt wrote:
>> On Mon, 30 May 2022 00:42:02 PDT (-0700), u.kleine-koenig@pengutronix.de wrote:
>> > Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
>> > commit 233c1e6c319c ("kexec_file: drop weak attribute from
>> > arch_kexec_apply_relocations[_add]") is also contained in the tree.
>> > This currently happens in next-20220527.
>> > 
>> > Prepare the RISC-V similar to the s390 adaption done in 233c1e6c319c.
>> > This is safe to do on top of the riscv change even without the change to
>> > arch_kexec_apply_relocations.
>> > 
>> > Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>> > Looks-good-to: liaochang (A) <liaochang1@huawei.com>
>> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> > ---
>> > 
>> > On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
>> > > > I can confirm that doing
>> > > > > diff --git a/arch/riscv/include/asm/kexec.h
>> > > b/arch/riscv/include/asm/kexec.h
>> > > > index 206217b23301..eee260e8ab30 100644
>> > > > --- a/arch/riscv/include/asm/kexec.h
>> > > > +++ b/arch/riscv/include/asm/kexec.h
>> > > > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>> > > >  >  #ifdef CONFIG_KEXEC_FILE
>> > > >  extern const struct kexec_file_ops elf_kexec_ops;
>> > > > +
>> > > > +struct purgatory_info;
>> > > > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> > > > +				     Elf_Shdr *section,
>> > > > +				     const Elf_Shdr *relsec,
>> > > > +				     const Elf_Shdr *symtab);
>> > > > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> > > >  #endif
>> > > >  >  #endif
>> > > 
>> > > LGTM, you could send a fixup patch to riscv, thanks.
>> > > 
>> > > > > on top of 838b3e28488f results in a compilable tree. And when
>> > > merging
>> > > > 233c1e6c319c into this, it is still building.
>> > > > > I'm not enough into kexec (and riscv) to judge if this is
>> > > sensible, or
>> > > > create a useful commit log but the obvious way forward is to apply the
>> > > > above patch to the riscv tree before it hits Linus' tree.
>> > 
>> > Ok, here comes a patch with a generic commit log.
>> > 
>> > @riscv people: If you prefer, squash it into 838b3e28488f.
>> 
>> Sorry, just saw this after I sent my version of the fix.  They're the same,
>> but do you mind sending a full-on patch so I can merge it?
>
> Sorry, I don't understand your request. I found
> https://lore.kernel.org/linux-riscv/20220530180408.16239-1-palmer@rivosinc.com/
>
> but I don't know what a full-on patch is and what stops you merging my
> patch. 
>
> Is it that it's in reply to a patch series and b4 fails to fetch the
> right patch and you ask to send it in a new thread?

Ya, with the reply bits in there my mail merge (which unfortunately 
isn't b4, I haven't gotten around to converting yet) got tripped up.  
It's kind of easy to for me to screw something up trying to pull bits 
out of replies and such, but I think this one was pretty simple (looks 
like maybe some PGP or MIME thing was the issue).

I just put 
<https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=7699f7aacf3ebfee51c670b6f796b2797f0f7487> 
on my staging branch, it looks OK to me but LMK if there's a problem.

Thanks!

>
> Best regards
> Uwe
>
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
