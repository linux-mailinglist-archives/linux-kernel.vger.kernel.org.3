Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A85896BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiHDDxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiHDDxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:53:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B555D0F9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:53:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b96so13436234edf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iRR1iLqoiLPd05xUeu4QA8DoUj4NMWZ3GKO/1gQCb2I=;
        b=GxolS5frGx/BtcZWjbwLLwCuSaexugK/wUcVJmuMVPzwWd3CYbwSLUTiOJy07fEwtP
         d8WJPIyN2HaPusVtWhz4Ut9sGpp45K45rI/i85Fq1hTolady9EZ8zSVZuBQ6uNNKVwNB
         gRmYmsAa8aLiDH2PDaBmb+jsp4CGgRMBcYtf2cACrbr5FDWp4gdKpR/fjL2eFjp2p+qZ
         gTRJner75WzQHAcLBvFSzIPnVvfQx1MiAHOMvtjOhHyJROpafhv+n4Ry7FchlYlEUktK
         M7u3RJyZkWZdWoG85npqZjb1s7he5hnG5wDGr1RNOiyIuiq5GRNhI7fwaMjccYsU8Fqx
         FtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iRR1iLqoiLPd05xUeu4QA8DoUj4NMWZ3GKO/1gQCb2I=;
        b=dblIPAxQfHHUBvgiUysMun1+NXgof9yL3A/uJMVbsRe9XzEy6OYXsR4fPUEz+kN9Sd
         TLI+fGLBiPauzzXsQEXjaIAFF3WQ4RAbqgGlNVG7fbPZQJEnJl6OzZDX4K0WgEt0C3Ch
         EvLkQQJ+r4LO5fx3Q8lyw/nsF2nO3gFpfOTa63rjJhw221T5+zIIkalhDTGE1ZYbhYbq
         rV/feGFX7RoJb0lE0+ceN6b9oZXKtfgbV6XJGT46KHL4fUCjQO9pPv1iKaBfoMamxMrm
         JPl8zBCtJFkxZ+4QOsGoje8ozWa6D+OjPyvNctNykcmBcZYZrpAUDC4tbwHS49bvOSkX
         cKTw==
X-Gm-Message-State: AJIora817HzlWGltepKvkRLhpZSVui3LWyy+1AHMsH3QsEThiqvfs5TU
        bN/U2l6krcFXLMU868z8uj7ZFMgYd9O9OC+rQVc=
X-Google-Smtp-Source: AGRyM1vSAPI2YsHTOOApkyHPOdms11QNqSrKtkzqP9s71qm9oI9T7GNWpOXvWGFo/ZgLzLVt38DGnhbxrJAIhpPjBGk=
X-Received: by 2002:a05:6402:90e:b0:43b:914e:f084 with SMTP id
 g14-20020a056402090e00b0043b914ef084mr29091987edz.144.1659585180675; Wed, 03
 Aug 2022 20:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com> <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 13:52:49 +1000
Message-ID: <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, 4 Aug 2022 at 13:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 3, 2022 at 8:37 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Actually I did miss that so that looks good.
>
> .. I wish it did, but I just actually test-booted my desktop with the
> result, and it crashes the X server.  This seems to be the splat in
> Xorg.0.log:
>
>   (II) Initializing extension DRI2
>   (II) AMDGPU(0): Setting screen physical size to 2032 x 571
>   (EE)
>   (EE) Backtrace:
>   (EE) 0: /usr/libexec/Xorg (OsLookupColor+0x13d) [0x55b1dc61258d]
>   (EE) 1: /lib64/libc.so.6 (__sigaction+0x50) [0x7f7972a3ea70]
>   (EE) 2: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
> (AMDGPUCreateWindow_oneshot+0x101) [0x7f797207ddd1]
>   (EE) 3: /usr/libexec/Xorg (compIsAlternateVisual+0xdc4) [0x55b1dc545fa4]
>   (EE) 4: /usr/libexec/Xorg (InitRootWindow+0x17) [0x55b1dc4e0047]
>   (EE) 5: /usr/libexec/Xorg (miPutImage+0xd4c) [0x55b1dc49e60b]
>   (EE) 6: /lib64/libc.so.6 (__libc_start_call_main+0x80) [0x7f7972a29550]
>   (EE) 7: /lib64/libc.so.6 (__libc_start_main+0x89) [0x7f7972a29609]
>   (EE) 8: /usr/libexec/Xorg (_start+0x25) [0x55b1dc49f2c5]
>   (EE)
>   (EE) Segmentation fault at address 0x4
>   (EE)
> Fatal server error:
>   (EE) Caught signal 11 (Segmentation fault). Server aborting
>
> so something is going horribly wrong. No kernel oops, though.
>
> It works on my intel laptop, so it's amdgpu somewhere.

I'll spin my ryzen up to see if I can reproduce, and test against the
drm-next pre-merge tree as well.

Dave.
