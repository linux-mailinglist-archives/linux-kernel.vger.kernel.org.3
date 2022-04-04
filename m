Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429804F1D58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382533AbiDDVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380351AbiDDTll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:41:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B71EAD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:39:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id yy13so22207140ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NU7HyoNi5meZJ6AGWzLvmGnJXrmedqwt4yUiP1S+dCg=;
        b=LmrPdK7D8KSejIMXvgQfWXzEV/KY6ZsFIOXpOfLYcmxokXt1ycWJVJ5BBbQc4RZ+4m
         Ij0yboQumDgoZPfnGCtP+DBbKVR+XYU5co738N4q2zihDCjnRMfR3nR3OfOVa6LM7pQE
         mADowT1BHanupnNcq0NojZ+S1Oub+rtSfYbECsjxhgpevsQt50yUmzwnj+a2GWtXUKPT
         vrsMxJXiI2buC1fXRD+u7C+61Fqf4JasghPdsYjmUq1NVvJnrnWHcc36uBqd1eoTgzfq
         tod7AjQS34oMihVHShMHtR4cv7Uz9WL1l0aewijORHN/c3VDFF2QoldPR0zSBS4xgpwo
         bGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NU7HyoNi5meZJ6AGWzLvmGnJXrmedqwt4yUiP1S+dCg=;
        b=ic9xgy91vl4/cGdI0UtMmUXDR03SY1I+za5LlQ9sFTOnHk2y41Nc3ch+c61lfsVmTG
         xD9Geq+xTlJznjqVML4r2Fkxuc2GkIPnw1Wjgmh9PC4PuSGMoPN3wKez1CuQCLrmbXnl
         ZuKb2gKs/Rs+jf5s1gnbdRZ7ORpMXfn+A8o79W2rKdNY38SQmRNnPrvAh5XbM3uk0eXI
         qqnnLC9KBVGl0cL78fWZ/D9Q0V6zoTM619ULg1zbEmEgz4mqm/C02Bm3OobapX3Pf5Iv
         2RQ4KA/veSh833urk9eVc3GOR2TUT86PKFen7tCq1JW+MIIPjBdCMFC1/m64R0YocV8J
         2ptQ==
X-Gm-Message-State: AOAM531dFrTlBafIM0iLZYS0y3f4Kw8lqDXToDQ6KD4kpL4mWyw9IvHj
        p3YsV3jSon7xjMIlES6KgOg=
X-Google-Smtp-Source: ABdhPJwf+njJLTQQYntTOyiKLugPASzyX2p5fs8mxMEkTSLKyQsIlO/mL3faNbxx+FZvWyGg/vE+IA==
X-Received: by 2002:a17:906:4787:b0:6e1:409f:8deb with SMTP id cw7-20020a170906478700b006e1409f8debmr1695858ejc.80.1649101183211;
        Mon, 04 Apr 2022 12:39:43 -0700 (PDT)
Received: from darkstar.example.org (host-79-21-204-193.retail.telecomitalia.it. [79.21.204.193])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm2052788ejk.125.2022.04.04.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:39:42 -0700 (PDT)
Date:   Mon, 4 Apr 2022 21:39:40 +0200
From:   Michele Ballabio <ballabio.m@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: AMDGPU: regression on 5.17.1
Message-ID: <20220404213940.09a56d15@darkstar.example.org>
In-Reply-To: <CADnq5_M+M_iykM0Ag6RF+kxzgpEopUBtp82h7tRM3G+B3AWZ2w@mail.gmail.com>
References: <20220403132322.51c90903@darkstar.example.org>
        <CADnq5_M+M_iykM0Ag6RF+kxzgpEopUBtp82h7tRM3G+B3AWZ2w@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-slackware-linux-gnu)
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

On Mon, 4 Apr 2022 13:03:41 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Sun, Apr 3, 2022 at 10:19 AM Michele Ballabio
> <ballabio.m@gmail.com> wrote:
> >
> > Hi,
> >         I've hit a regression on 5.17.1 (haven't tested 5.17.0, but
> > 5.16-stable didn't have this problem).
> >
> > The machine is a Ryzen 5 1600 with AMD graphics (RX 560).
> >
> > The regression I hit seems to trigger when the machine is left
> > idle at boot (I don't boot straight to X, I boot to a tty, login
> > and then start X). The machine after a while blanks the screen.
> > Usually, the screen unblanks as the keyboard is hit or the mouse
> > moves, but with kernel 5.17.1 the screen does not wake up. The
> > machine seems to run mostly fine: I can login from ssh, but I
> > cannot reboot or halt it: a sysrq sequence is needed for that. Note
> > that if the screen goes blank under X, it wakes up fine.
> >
> > Below a dmesg and two traces from syslog (they're quite similar).  
> 
> Can you bisect?  Does setting amdgpu.runpm=0 help?

I can try to bisect, should I narrow the search to drivers/gpu/drm/ ?

Setting amdgpu.runpm=0 works, the display now unblanks without problems.

Thanks,
    Michele Ballabio
