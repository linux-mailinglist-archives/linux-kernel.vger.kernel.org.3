Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6B4E6CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbiCYDCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiCYDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:02:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3158F9AE6F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:01:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so12865901ejd.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/tnBjCQqbz+ipRB4x1lKBYbOrRRjB/fgc1SofcvrKE=;
        b=BpvZWhPub7tbx5LK/ZUdJWfm+Z7LZ3QO2G1RKBupz6bPHTh2VVII8Y+jDNjde2TJWM
         c4EyLL3WySEQ9R2rsW3R4ltk4tsoDBImqjnolJvZPTA2qvSYr8tzbvwMfgnriYP6hnB6
         aN3auJ1Cq2eUs+jrzEiEHPbsnMbEvDgEdXk/F5MW/dHAleJ37M0VLvlE7g49k91mRx/R
         tAbYWvlRL8XTYMfPLKJ4gCd2R0LMCrqUhSOBe6WnyW6Oz71C4+4A5fWHOWurXHtUQVXu
         2ra0VDUKKqcH2buFnPzQKvKn2ppXCgRQ1Nbk7zymgNg9MWVZw7CMt+Hx/ipNxpDIGj8m
         t0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/tnBjCQqbz+ipRB4x1lKBYbOrRRjB/fgc1SofcvrKE=;
        b=iPSVNvjjDXUQcvRCUbozzJr/SE4UNrrsm3iDnkZ1QrM0sXWfxAVj9OC0XkIyTJ4XuF
         IUdgzNy00EuILLiyzBJotBr+ddvuyuppUne9je9XLD5LUeasSJ6mrUI/doY93HfB480n
         k/vUVBBWc9RjkuhXpfuK3dAozVS2N57kcq8Oi0ai+3yq9djgubY5t3KVCVLao+xXDS6t
         0VruEDZ8eJSLK49oQgkiyz0dLnCkB2CjizC9QuANtOHwLPK/x5UviS/hg9w+NzsWrO6f
         IKH9VAlguEF+owXEKwaVfWt47gWZGFr1WXTabQNesDzAA+FWoirrjOHrYbprjNho4nDe
         xAIA==
X-Gm-Message-State: AOAM531N275k/aDk04cQ/ousyc4BfGsbCl9KCfdI8HjiZzbnZRF4jhzK
        yNllVcglvEAld3HWlK2yB+ZKTug/g7PjmEmkIMo=
X-Google-Smtp-Source: ABdhPJwbVnkv8Pu9ryy6Zf5UnAAyByy4xvpWgaSyHoOsPbh4F5sb6OrhtjuEy8bp8tlmiXKjHM8ylmQW5BZYRl2Dot4=
X-Received: by 2002:a17:906:dc95:b0:6df:d2cf:4d93 with SMTP id
 cs21-20020a170906dc9500b006dfd2cf4d93mr9013969ejc.66.1648177268654; Thu, 24
 Mar 2022 20:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tytg5jd_i3z3C5Y1dii2-cgO11Gjgvaq8qoWn3CGfCreg@mail.gmail.com>
 <CAL_JsqJqb6HYN5cw7GsyFobZxFmhU-ci8w4HKQEdFsx=bC_F3w@mail.gmail.com>
In-Reply-To: <CAL_JsqJqb6HYN5cw7GsyFobZxFmhU-ci8w4HKQEdFsx=bC_F3w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Mar 2022 13:00:57 +1000
Message-ID: <CAPM=9tx+YeOCBZ0WRcSMKTyUYr5ngySratZ0K8tmRZ0rCaFf8Q@mail.gmail.com>
Subject: Re: [git pull] drm for 5.18-rc1
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
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

> FYI, this breaks the DT bindings. The relevant patches didn't get
> reviewed nor run thru automated testing because their encoding was
> 'charset=y'[1]. (While email clients seem to just ignore that
> encoding, patchwork and b4 do not.) linux-next is still broken and has
> been since Mar 2[2]. v2 of the fixes[3] have been posted since Mar 9,
> and still aren't in linux-next.
>
> It doesn't have to be fixed in this PR, but it needs to be fixed
> before rc1. Otherwise, no one can test their bindings using rc1. In
> general, there's no reason fixes need to wait until after rc1 as
> Chun-Kuang suggests[4].

With the conflicts that Linus merged, can we get this rebased onto
Linus merge, and submitted to him?

Otherwise Linus I sent you a fix for the fbdev in a separate pull.

Dave.
