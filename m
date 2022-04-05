Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095FD4F4952
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442312AbiDEWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447766AbiDEPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:47:04 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A555B19B055
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:23:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so14535156fac.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3viWxA/JBHdP0TQbOykdsaxa+Gs7txej/lLx0GIvIYg=;
        b=G9QnFQmPtVjj4tVobX1LMic5zPY274r2vdLPAoUHBKEo99rnSV8OgrXJiFUo/7/jTF
         HjRanar2kAcinOYdoYvDGcnYJCuDuEuq0Zai+Uq0v6oNYRccBrMVRMdFmiEV85NERQ9C
         7vO48nBrMzEKZEJVJ8XZajlPZLIjcsxvASt5VlRRUCL1kA3K18vbkH8swg9+yzJ9rGMP
         bFCRoCQAY3/a8STCLM+PzA5oegHvKvG3gC1g6iDc6bi30ZQD9wkIiGfKM1QRvaqcYdSM
         rfBcCGGpw/3xxa0Vz8+ryEQQNncgOdCH6noH47HWTgOvqSb3hQ57Qsfk/RiWmJ24PVYC
         lHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3viWxA/JBHdP0TQbOykdsaxa+Gs7txej/lLx0GIvIYg=;
        b=UDOcIiQbJFjhxhSOJOdCVhaWfKNelknqWYv6XJXJuLSwfwv4+sxC8IiZKa5ocqwNkj
         Cbc5qEVctWLTmNdJ8sRZx+VqJTJjNbXX+z4rq20HsXLKKsyNwhEFxfjr9VRCK+caZEra
         R4/p/leNNovSugcYx0bdQew8NJk1odFXXMBRlealMInwS76P9SE3uS4J+Rf7AUzZeUZh
         nrQghU4NM8SdsuzET8IcjcYogXzUcdeh9F9yjxn3wncxPj+QSjr3vodunKzeLI0ukiN1
         HaWKYxelnNmNVcAdK98ZTcFwdjdeJMxKntstHMvBMrcRondOpTZiMlTWBuRtNUlXq8/z
         WodA==
X-Gm-Message-State: AOAM5335LsoGUEmFXKbaENAKfUn4R0eS9X/3/WvLz/TM53A7vt8tdzoI
        L1tg6c4NVnrPN0VL6K2Byb+tJyH/QdkZ8cVrGf1o2fT5
X-Google-Smtp-Source: ABdhPJwwvFJ/nErrBLzLGpycHCVzIhCmGoPUp6o1bgcidxfVOxHS2sTwvSWskrCQURlhd5hQ2zrWnsbBLhhhsqySV8U=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr1567641oaa.200.1649168608008; Tue, 05
 Apr 2022 07:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220403132322.51c90903@darkstar.example.org> <CADnq5_M+M_iykM0Ag6RF+kxzgpEopUBtp82h7tRM3G+B3AWZ2w@mail.gmail.com>
 <20220404213940.09a56d15@darkstar.example.org>
In-Reply-To: <20220404213940.09a56d15@darkstar.example.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Apr 2022 10:23:16 -0400
Message-ID: <CADnq5_PhaFbVCb=-AUCx4L-sCyPCPOsY3tNpiAg=gfCN7hFcJA@mail.gmail.com>
Subject: Re: AMDGPU: regression on 5.17.1
To:     Michele Ballabio <ballabio.m@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Mon, Apr 4, 2022 at 3:39 PM Michele Ballabio <ballabio.m@gmail.com> wrote:
>
> On Mon, 4 Apr 2022 13:03:41 -0400
> Alex Deucher <alexdeucher@gmail.com> wrote:
>
> > On Sun, Apr 3, 2022 at 10:19 AM Michele Ballabio
> > <ballabio.m@gmail.com> wrote:
> > >
> > > Hi,
> > >         I've hit a regression on 5.17.1 (haven't tested 5.17.0, but
> > > 5.16-stable didn't have this problem).
> > >
> > > The machine is a Ryzen 5 1600 with AMD graphics (RX 560).
> > >
> > > The regression I hit seems to trigger when the machine is left
> > > idle at boot (I don't boot straight to X, I boot to a tty, login
> > > and then start X). The machine after a while blanks the screen.
> > > Usually, the screen unblanks as the keyboard is hit or the mouse
> > > moves, but with kernel 5.17.1 the screen does not wake up. The
> > > machine seems to run mostly fine: I can login from ssh, but I
> > > cannot reboot or halt it: a sysrq sequence is needed for that. Note
> > > that if the screen goes blank under X, it wakes up fine.
> > >
> > > Below a dmesg and two traces from syslog (they're quite similar).
> >
> > Can you bisect?  Does setting amdgpu.runpm=0 help?
>
> I can try to bisect, should I narrow the search to drivers/gpu/drm/ ?

I would just do a full bisect if possible in case the change happens
to be outside of drm.

>
> Setting amdgpu.runpm=0 works, the display now unblanks without problems.

Thanks,

Alex


>
> Thanks,
>     Michele Ballabio
