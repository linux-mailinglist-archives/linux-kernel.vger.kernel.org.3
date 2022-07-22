Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA157E252
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiGVNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiGVNaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:30:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2882FAA;
        Fri, 22 Jul 2022 06:30:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b11so8537866eju.10;
        Fri, 22 Jul 2022 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loYefRsJFRIddRKsH8gC7LMjbqNjPpq3cIkCYbNRO3E=;
        b=Rh01wbkfBC5ZZj1hDCS/aCtPIkGp/SWmMyexZiSGbgj4WsZeQCLFgmSbGDbSom5doo
         O4AlubGbvMbwUZzlI2/SSAaXXshOjtdYmYIYk/Akg+5NPUeBQwGRo7K9tvtkJTg/kfyR
         ZVKYSrjOMcLUEegv8cI8ok8k6vVdFvm9O169yV5knNWfKeAQ27QZI1hMkR7bKMOQ741b
         6mLpTktYR//EXQ4vNz3Euvdw+WQHyfmIe5p1zDiJK1Zi5xIXGFPlzunSZvVtSTRDfpqZ
         1sB8cY2kv9KlNDYpNBw1SjRdxE//5h53sFPntabeydt+go3aQJQdFmFBMO3IIaZizTlG
         PpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loYefRsJFRIddRKsH8gC7LMjbqNjPpq3cIkCYbNRO3E=;
        b=uWt9aYvDZuYQR2odmpSzXNx3U04Cl8NkcA0WH3R9fuU+sZvS2YoY5Ww97EG2BakmsT
         dibRRMIa5Iy/TYemHFX9KvO9Nigvv37l47G4BDBxgbE4bqh04W9Etso+UyozC9J+Tl9N
         Qz5Wu8dngXxooKNCdcPJpwcHpXTAcXxPZuqC5p8u2ldrgGPATPy9PmtKo7djwThF6KJs
         6FH4aE8+jMHToNkgZhY31q14I+QmiyObg+LN2vugEiye4kmlq9fXO8GXUKxizTlDzgtn
         tGqheY+rN2fGtHMrwFw9QBVFCg7HVOG5/9quu/xOcstJI6DPCtpfDNIVzBG/JD4y6WQu
         UuzA==
X-Gm-Message-State: AJIora/aDSbXilt2Sd6taClEcKnSdpFhNXeVHqUDXol4H0+8iWVWf1DP
        6s4JNWhX8pr6uTbAHa0EDU2sbauXvkqvDL48wOp3e/MK
X-Google-Smtp-Source: AGRyM1uj6Bf98bVaoiFb716jOFlfc4hB5SFO0a70HCy+/nha2uMDwFX1voSmi28H6LB5TNkkH0D/Pz0tyB+e/ciWZho=
X-Received: by 2002:a17:907:a06f:b0:72b:564c:465b with SMTP id
 ia15-20020a170907a06f00b0072b564c465bmr519713ejc.344.1658496644409; Fri, 22
 Jul 2022 06:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220719123607.63cbb3c5@canb.auug.org.au> <20220720124732.4aeb3748@canb.auug.org.au>
 <20220721121618.049b9c00@canb.auug.org.au> <20220722125212.2af3601f@canb.auug.org.au>
In-Reply-To: <20220722125212.2af3601f@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Jul 2022 09:30:32 -0400
Message-ID: <CADnq5_NdSQADn7xaLVJzgERist5aMMw07pqZQhSogatotF=y1w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:52 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Thu, 21 Jul 2022 12:16:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Wed, 20 Jul 2022 12:47:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > > >  3799 | } // ModeSupportAndSystemConfigurationFull
> > > >       | ^
> > >
> > > This is still here, but the frame size is down to 2336.
> >
> > Today it is down to 2128.
>
> And today we are back up to 2152.  I can only imagine that maybe things
> are being inlined?

This is driving me crazy, there is almost nothing left on the stack at
this point.

Alex

>
> My compiler (in case it matters):
>
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
>
> --
> Cheers,
> Stephen Rothwell
