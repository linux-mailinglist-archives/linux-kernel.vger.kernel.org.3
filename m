Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D384F4FFF87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiDMToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiDMTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:43:58 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFEE78073
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:41:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g18so6029936ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6aYxcvUneI95bTdsz28eCaOVBdeKnTjyTuYgm31g58=;
        b=Ar3JAMnHPCsIfQYgcOes+uiSzpnx2R4RdaeNwBiYdyffO5H4jlupRKtMT1blWMazuk
         tjVoI3SSwl54uS9M3FkXwQePiClm6RACTE/aXHpYtDIRLtOo03dbhCVQitsMd4w3dFd8
         czqlfics96/Kpux4eQ2ek8DDhjaj8YRi39er2T83Pv/WnUs4r3dPgAtkzpGfE5BvtZLd
         2fAt15A/DSqyFYyrnl54U7zparp6BwDfcWc9xUuy3y/qMp/oZ790IL4hV0y5uIvSNRuK
         0elHxdOKzwMOa/VazktVd6X0o2vuu8fEdDPYovN1jRitw/MVI/utxIcOkAM4oZd7AZIW
         bJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6aYxcvUneI95bTdsz28eCaOVBdeKnTjyTuYgm31g58=;
        b=sTpdl9eOJmTPXpBk8BsAg2TTB9efSEEqh8w7bsx8id6eze8EbArf3XDAUQBjy/OVNh
         xxxyA/IYBSyphSzP+bWqT2hN8IAYs5GnKEh/yCJuWNxwipNrWmGpiFCpxQeaFg1st7cO
         N5uoeiTK0cxDyrZIlKI5XZ5k+wnWP7vbalYLd+z0hI+/E4vVwQ+0Ky48mHCz4pfmkRva
         xEE9kjf1r4cfQ7PT8butGLTau46vm6gsIeLysnzmFJbmnHBVai/GaLxMkAZVf65uudPR
         KpvZhD241iywuDZdNX+xHF+fEadRgn25tCqrYPvPdppElLWU0qQex5m0wXpCR5wG1uKn
         lsGA==
X-Gm-Message-State: AOAM531U5i3TNpjFCRqCPdJjB2Yc6pvw83yHxRXrhKzzgrMgH0Of2oIP
        FZ+y3UPY3VQH+K6Rwi8uJ+o=
X-Google-Smtp-Source: ABdhPJxEljLLVQ0kEiFPkfKG9RmhUUwAQUiziY+Xv9O5hm0W3swx+T8iKPfSoBJTmPnsirazAn9qfA==
X-Received: by 2002:a17:906:6a14:b0:6e8:a87d:3f2f with SMTP id qw20-20020a1709066a1400b006e8a87d3f2fmr10779140ejc.300.1649878894821;
        Wed, 13 Apr 2022 12:41:34 -0700 (PDT)
Received: from darkstar.example.org (host-79-21-204-193.retail.telecomitalia.it. [79.21.204.193])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm287200ejt.50.2022.04.13.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:41:34 -0700 (PDT)
Date:   Wed, 13 Apr 2022 21:41:32 +0200
From:   Michele Ballabio <ballabio.m@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: AMDGPU: regression on 5.17.1
Message-ID: <20220413214132.6aaa061a@darkstar.example.org>
In-Reply-To: <CADnq5_MVO8B-EH70XJ=L6pp7haHz5ZeF1rGFvPEX5nD1+4n1AQ@mail.gmail.com>
References: <20220403132322.51c90903@darkstar.example.org>
        <CADnq5_M+M_iykM0Ag6RF+kxzgpEopUBtp82h7tRM3G+B3AWZ2w@mail.gmail.com>
        <20220404213940.09a56d15@darkstar.example.org>
        <CADnq5_PhaFbVCb=-AUCx4L-sCyPCPOsY3tNpiAg=gfCN7hFcJA@mail.gmail.com>
        <20220409182831.185e5d92@darkstar.example.org>
        <CADnq5_MvGGONvAvhwgokDxRpTbnsGEFROcgsZteJby9Bya81Nw@mail.gmail.com>
        <20220413193337.16ecc808@darkstar.example.org>
        <CADnq5_MVO8B-EH70XJ=L6pp7haHz5ZeF1rGFvPEX5nD1+4n1AQ@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 14:14:42 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Wed, Apr 13, 2022 at 1:33 PM Michele Ballabio
> <ballabio.m@gmail.com> wrote:
> >
> > On Mon, 11 Apr 2022 14:34:37 -0400
> > Alex Deucher <alexdeucher@gmail.com> wrote:
> >  
> > > On Sat, Apr 9, 2022 at 12:28 PM Michele Ballabio
> > > <ballabio.m@gmail.com> wrote:  
> > > >
> > > > On Tue, 5 Apr 2022 10:23:16 -0400
> > > > Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >  
> > > > > On Mon, Apr 4, 2022 at 3:39 PM Michele Ballabio
> > > > > <ballabio.m@gmail.com> wrote:  
> > > > > >
> > > > > > On Mon, 4 Apr 2022 13:03:41 -0400
> > > > > > Alex Deucher <alexdeucher@gmail.com> wrote:
> > > > > >  
> > > > > > > On Sun, Apr 3, 2022 at 10:19 AM Michele Ballabio
> > > > > > > <ballabio.m@gmail.com> wrote:  
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >         I've hit a regression on 5.17.1 (haven't tested
> > > > > > > > 5.17.0, but 5.16-stable didn't have this problem).
> > > > > > > >
> > > > > > > > The machine is a Ryzen 5 1600 with AMD graphics (RX
> > > > > > > > 560).
> > > > > > > >
> > > > > > > > The regression I hit seems to trigger when the machine
> > > > > > > > is left idle at boot (I don't boot straight to X, I
> > > > > > > > boot to a tty, login and then start X). The machine
> > > > > > > > after a while blanks the screen. Usually, the screen
> > > > > > > > unblanks as the keyboard is hit or the mouse moves, but
> > > > > > > > with kernel 5.17.1 the screen does not wake up. The
> > > > > > > > machine seems to run mostly fine: I can login from ssh,
> > > > > > > > but I cannot reboot or halt it: a sysrq sequence is
> > > > > > > > needed for that. Note that if the screen goes blank
> > > > > > > > under X, it wakes up fine.
> > > > > > > >
> > > > > > > > Below a dmesg and two traces from syslog (they're quite
> > > > > > > > similar).  
> > > > > > >
> > > > > > > Can you bisect?  Does setting amdgpu.runpm=0 help?  
> > > > > >
> > > > > > I can try to bisect, should I narrow the search to
> > > > > > drivers/gpu/drm/ ?  
> > > > >
> > > > > I would just do a full bisect if possible in case the change
> > > > > happens to be outside of drm.
> > > > >  
> > > > > >
> > > > > > Setting amdgpu.runpm=0 works, the display now unblanks
> > > > > > without problems.  
> > > > >  
> > > >
> > > > Hi,
> > > >     I bisected this, and the first bad commit is
> > > > [087451f372bf76d971184caa258807b7c35aac8f] drm/amdgpu: use
> > > > generic fb helpers instead of setting up AMD own's.
> > > >
> > > > Let me know if you need some more testing.  
> > >
> > > Thanks.  Do the attached patches fix the issue?
> > >
> > > Thanks,
> > >
> > > Alex  
> >
> > Sorry, no. I applied them both on top of 5.17.1.  
> 
> Thanks.  Please try the attached patch.
> 
> Thanks,
> 
> Alex

I applied the v2 patch on top of 5.17.1 and it works as expected.

Tested-by: Michele Ballabio <ballabio.m@gmail.com>

Thanks,
    Michele Ballabio

