Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA87560BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiF2VgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiF2Vfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2A36B51
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:35:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h85so17352581iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGBhZHWqW6jU2n7a27O2QHBIK43y3nGHte6lt/SEtG0=;
        b=W8+Z7i9qRM0MsWbc+KsXIAElN0YZEtmcc17hsLOb/KWWvqaEbf5Q9Btz7IbP5bm5/V
         nydE4Dx0h63nSNLveaItcJSr4cPaMXeYz0N20AdqwpHoW+E8pV7C60HUzv9CtekRWfia
         sbvNxWCC0oyNPa7tfrRbC+UUvIpAQtLITqPZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGBhZHWqW6jU2n7a27O2QHBIK43y3nGHte6lt/SEtG0=;
        b=vaG0tzwRf1czLQW2TeztmnCoreR+T6zwp9eRR8JlnkrxTwIEDuhmF+GOO9NIpfTnzg
         wAxPhWzgLfuqO8wQRVt9ck3FKRO8CW1lZQtUSgTdUjQtBsOCfYR7u5mcMrlHWkhlkRo7
         miCFyE/qhaD0S6NGxmPNniv5I5mNwrmNAEvWTtfueUekgrpPwPqkN11RM2FBUKmP2NM0
         1SdTrEM9JH78hRxBvTWVkA2LZlyyxlovQdaGkyZfI70gL4L0RPjNW5jaT0R4sen3iN4v
         e67q6zjMGFxXpmkZkWgg0maJpd7f733uQXWyBM1LxD++ET8bd4zxLlYKrCAqljtxpMEX
         S//Q==
X-Gm-Message-State: AJIora/bEBzoiS+ix612tFRys+n/nLEUf95144I1k79NcKQW9RV89J7M
        Y9izMuLFPhEUUKYl2J80HZqUXFtTHgSrs8qG9T1SFQQMfNU=
X-Google-Smtp-Source: AGRyM1sx3YTgbATfQDjAunxSoBLK3pi4IP0MMX8oiX8OkYO1T6fFycU68AHBce48c5X0XhL2pfBRw7LbtQUOSVzQraM=
X-Received: by 2002:a05:6638:22cf:b0:33b:fd4a:122b with SMTP id
 j15-20020a05663822cf00b0033bfd4a122bmr3164522jat.244.1656538543693; Wed, 29
 Jun 2022 14:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <3c38b723-40e6-ded9-5a3b-7b442a3f65d8@linux.vnet.ibm.com> <YrvDEqdk3ZfcEy9i@sol.localdomain>
In-Reply-To: <YrvDEqdk3ZfcEy9i@sol.localdomain>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 29 Jun 2022 22:35:33 +0100
Message-ID: <CALrw=nEsEemxP4q4QkFGxOY3+fo07wopdtLUerzBP0oKhRLmUA@mail.gmail.com>
Subject: Re: [linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot to
 linux-next kernel
To:     Eric Biggers <ebiggers@kernel.org>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.com,
        mputtash@linux.vnet.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 4:12 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 02:33:55PM +0530, Tasmiya Nalatwad wrote:
> > Greetings,
> >
> > [linux-next] [[5.19.0-rc4-next-20220627] WARNING during reboot to linux-next
> > kernel
> >
> > --- Call Traces ---
> > [    1.788574] ------------[ cut here ]------------
> > [    1.788577] alg: self-tests for rsa-generic (rsa) failed (rc=-22)
> > [    1.788586] WARNING: CPU: 9 PID: 218 at crypto/testmgr.c:5774
> > alg_test+0x438/0x880
> > [    1.788598] Modules linked in:
> > [    1.788603] CPU: 9 PID: 218 Comm: cryptomgr_test Not tainted
> > 5.19.0-rc4-next-20220627-autotest #1
> > [    1.788609] NIP:  c00000000062e078 LR: c00000000062e074 CTR:
> > c00000000075e020
> > [    1.788614] REGS: c00000000e733980 TRAP: 0700   Not tainted
> > (5.19.0-rc4-next-20220627-autotest)
> > [    1.788620] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28008822
> > XER: 20040005
> > [    1.788632] CFAR: c00000000014f244 IRQMASK: 0
> > [    1.788632] GPR00: c00000000062e074 c00000000e733c20 c000000002a12000
> > 0000000000000035
> > [    1.788632] GPR04: 00000000ffff7fff c00000000e7339e0 c00000000e7339d8
> > 0000000000000000
> > [    1.788632] GPR08: c000000002826b78 0000000000000000 c000000002566a50
> > c0000000028e6bb8
> > [    1.788632] GPR12: 0000000000008000 c00000000fff3280 c00000000018b6d8
> > c00000000d640080
> > [    1.788632] GPR16: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    1.788632] GPR20: 0000000000000000 0000000000000000 0000000000000000
> > 0000000000000000
> > [    1.788632] GPR24: c000000000da49e8 0000000000000000 c000000050630480
> > 0000000000000400
> > [    1.788632] GPR28: c000000050630400 000000000000000d c000000002cd33d8
> > ffffffffffffffea
> > [    1.788691] NIP [c00000000062e078] alg_test+0x438/0x880
> > [    1.788696] LR [c00000000062e074] alg_test+0x434/0x880
> > [    1.788701] Call Trace:
> > [    1.788704] [c00000000e733c20] [c00000000062e074] alg_test+0x434/0x880
> > (unreliable)
> > [    1.788712] [c00000000e733d90] [c00000000062c040]
> > cryptomgr_test+0x40/0x70
> > [    1.788718] [c00000000e733dc0] [c00000000018b7f4] kthread+0x124/0x130
> > [    1.788726] [c00000000e733e10] [c00000000000ce54]
> > ret_from_kernel_thread+0x5c/0x64
> > [    1.788733] Instruction dump:
> > [    1.788736] 409e02e4 3d22002c 892913fd 2f890000 409e02d4 3c62fe63
> > 7f45d378 7f84e378
> > [    1.788746] 7fe6fb78 3863fa90 4bb2116d 60000000 <0fe00000> fa2100f8
> > fa410100 fa610108
> > [    1.788757] ---[ end trace 0000000000000000 ]---
> > --
>
> It's caused by:
>
> commit f145d411a67efacc0731fc3f9c7b2d89fb62523a
> Author: Ignat Korchagin <ignat@cloudflare.com>
> Date:   Fri Jun 17 09:42:10 2022 +0100
>
>     crypto: rsa - implement Chinese Remainder Theorem for faster private key operations

Thanks for the report. Seems the RSA test vectors need updating as we
now care about CRT parameters. I'll try to craft something.
