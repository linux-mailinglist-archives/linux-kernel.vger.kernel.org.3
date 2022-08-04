Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB3589699
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHDDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHDDhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:37:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844F12D2E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:37:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so11938302ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LVd6x4jd0g7TYMdesIbqiqpXq1pUyWFD95vFNyBmMLc=;
        b=FkkSlScGm6mmeoBPA6MeYQvLc1RnIXfWRfW6UA/pN/ey69EO4VPSsor2KcBvVz0+Dn
         1Rk4TnfLz0rgPESu3F9VyKL2aPXEWVzFNX0LyBh3y0LEfvGdAxUy+59k2eOeHcNeKTPf
         veXtqJ8V5phXmzyywQ1UJS85hO4i4fYjAX1NSMjYrhLC4YFjRpj/j7e1TTjIoK/YppbE
         eMhMBIsn/Y8GmVMomR0RSzM6Lg/C2vThcpU04rgz/wFoYLmzulfETi6l6uUwu21ij3wl
         wP7hyx/EgJA6qE3q9I9IflSw+gWwRpjltOkJW4q2RNR7iClEFzdTtrpNvV/Oc0ehRaVG
         iMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LVd6x4jd0g7TYMdesIbqiqpXq1pUyWFD95vFNyBmMLc=;
        b=OBRdVVXv2sKVsO5Okw8OdTLTiy/5kd45l/eCGOinCf8xkTlg708xEh1iMuK+SOpG4U
         X9MDx6mUjUoEkbLRZLBVdJXY8/ixvKU2GeNcxWNj29/KAsxNoLbKtDdt6AF9EJlxA1QK
         nHg+K3XvO1OmbfDIu0xwIAD9oMYR2TdpaxwvRlKAwn7HyVabC5ybiWmcMQ5Uh4AqkWH1
         lxRPkjuRLW6w2hK/Nc3Xes6osiYwxluEzuU6TxNR8Vq82XNczUq4YrzFQUSOrOWryTcc
         CMOOHJjxLkc27sjC/uMIOA7eGpxoResjIhTqg/s1q8JWqQvE/eagPjuK8/55E5CFTPVM
         M/OA==
X-Gm-Message-State: AJIora/61Uzyly+ft4VGqWWqR/4Y5ZLlFCOvAIGHiE5h/jKsfEExtOOp
        sgE2O80wd6jCOA1P5cYjb8RQdRaRIV5SFCYH3CY=
X-Google-Smtp-Source: AGRyM1vNZJq1ARxRxepmPJ8am83ern4n6XWg8Qno1AlZusGnNYHH8H+kH3ubIVjYYRgPJUjrFi715BXNE5LFABQwerY=
X-Received: by 2002:a17:907:96ac:b0:72f:1dea:5b66 with SMTP id
 hd44-20020a17090796ac00b0072f1dea5b66mr22316171ejc.266.1659584268602; Wed, 03
 Aug 2022 20:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com> <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
In-Reply-To: <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 13:37:37 +1000
Message-ID: <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
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

On Thu, 4 Aug 2022 at 13:16, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 3, 2022 at 7:46 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think I have it resolved, am still doing a full build test, and will
> > then compare against what your suggested merge is.
>
> Hmm.
>
> I end up with *almost* the same thing.
>
> Except I ended up with a
>
>         select DRM_BUDDY
>
> for the DRM_AMDGPU config entry, and you don't have that.
>
> I *think* my version is correct, in that clearly the amdgpu driver now
> uses that buddy logic (just doing a random "grep drm_buddy_block" to
> see).

Actually I did miss that so that looks good.

>
> But this was messy enough to resolve that I think people should
> double-check my end, and maybe I just got confused at some point in
> the process.
>
> And while I seem to have gotten the same result as you did on the i915
> firmware side too, again, I'd like people to re-verify.

I'll pull it down and look over it.

Dave.
