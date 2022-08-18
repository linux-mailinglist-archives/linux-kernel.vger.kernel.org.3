Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84464597B46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 04:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242664AbiHRCCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 22:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiHRCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 22:01:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133CFA5C7A;
        Wed, 17 Aug 2022 19:01:58 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so320236fac.5;
        Wed, 17 Aug 2022 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S/5XKfr/1Laii/jvtSToZop43NduFSge4r6M3yzcyjw=;
        b=b6NrriDxkguKdMxIx5EHPF92Ex0lVfeC4m9fKjxD5xVtw7GaFu8tLhqFfiHzAZcMd3
         YF0WmvOmWuC7l5BY5QkUp0bR6r0xoJD93h+rLZnYrlvP1RNzzVDH3TV6wgC8DBXxRzzI
         iUchu8J4g6JALFwchiea1CJBaqnLlrjn0nD8SqvSpkyrIRd6Kn//SGtaNZK4m4BSBVV2
         z3ygs9rpj+TQJ1DH2hET9EJ2k+Gcsz6efSeDKjZGTwq79f6sXOctW2/8pGUKfXaJXYeN
         05KT1OPNd/m9w4wYZ4d8ikKRhjTyT2IlaaAvpqhhpeVMrF8ygdo7QW3AnL28pSugNc3r
         oHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S/5XKfr/1Laii/jvtSToZop43NduFSge4r6M3yzcyjw=;
        b=Njdd649TtaxyjqCzqQMKFmlwfldo20DVHZiVCOVewj20H+crbw5CE7Lqk6c9a5IYSz
         jMG2R4uS/x6SE45rWsHBw1YQUDj+A59F9mFT3QL1Y3UOxQVrAUCkVWk/w07scDcp4Cue
         c68bZYG4EQ7IM50ht/b004oUMqB0PlbkuN17riYu95f9SC6b71SnND95FceosyoFuQSU
         hFOZQP/P9NsK90f0CYIhWmTKWQJByo/ur6Pr9HIyE2ZGHGFJwuuGRzjv0okGI3BjmiIT
         ZZLiuMTlTonpR9qtB74yhodkGTfnvYvKmqeWF4Rrh8zdKsga2DVBJgRdZ2LP5sPimR9s
         FosQ==
X-Gm-Message-State: ACgBeo0E+fYq8YNQzp0oku4PprrrKfBHCYaV9m9ILZFh+0Dh4eGaqhM+
        3hCWcKpRJouD251YKbTftzu9br/58w3+05tWblw=
X-Google-Smtp-Source: AA6agR5xyQe78Urmto57ircyi6EeHV+S2tnoOsF5QZuLcPzMKlnYvHKY05ZlT9jJ8u4iccYRJY5jEBIysxyi2jCzGas=
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id
 w24-20020a056870339800b001137f43d0e9mr359862oae.33.1660788117392; Wed, 17 Aug
 2022 19:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1lepjhg/6QKyQl@debian>
In-Reply-To: <Yv1lepjhg/6QKyQl@debian>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Aug 2022 22:01:45 -0400
Message-ID: <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
Subject: Re: build failure of next-20220817 for amdgpu
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-next@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported, build of next-20220817 fails with the
> error:
>
> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> Trying to do a git bisect to find out the offending commit.
>

Thanks.  I don't see that symbol in the driver at all.  Not sure where
it is coming from.

Alex


> I will be happy to test any patch or provide any extra log if needed.
>
>
> --
> Regards
> Sudip
