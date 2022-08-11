Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464358FD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiHKNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiHKNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:22:26 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D181696
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:22:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g5so28143771ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Eb3rnYYvtIKOzVfVgbxd4mjo9Ht+qE4u6mbe1XaOMUQ=;
        b=bqqg6BYyIOZ+h3ZXDwmc1lPC+7zZ8KZPrW8UMe1KSZnMVQwVGPH83VQznwGbQMsPQ9
         J/3yQt9Ic1sYAuWcEt9l2/nrJRihNOWq62cn9NjGKGBF/9uZDOHFqVzyxqvQwPwlruLK
         jYTU0YZvCk0WsDLY8mEElC6obFA6qFIk8EJn3iZC53PmNEx/Nc2tD80cMlirKBaDOhqi
         6JdYmtFJVr1AioB69OvBOLuth+Qyyye6xTZLri+QP5m4b/ODp7QmNs5sw/VRiL4e/QRV
         2zPn0ZfzKxi3876GjtpQjVDQfOrgqnbJdwS2fvF15LFcAnyzyoTcB40sKWl4XJ82lKhs
         ZM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Eb3rnYYvtIKOzVfVgbxd4mjo9Ht+qE4u6mbe1XaOMUQ=;
        b=PYk4fcLJA05Z6swp71P5Au2M3Ci76xbA35CwiC3bz2T/roo9veWsqpT62N8nelvKHT
         zh5uQgQ7CL2YyKVPRVV3EaeB1hkKC2F7hbS2oU5X0wAPAGqVMHs7Wyn+SmItq/KPs8Lm
         HJnyHXFEKAmfRmzJcgTE8Z9pjVvG/yf/PN4Rpr8yyx05aKbjtr9000yANyX2Hbz1zK9X
         GHZmi8nMtXX8CJSIPufpzmzK5olB2B+fZjIftxSPNBKZFSH4u6t1vOqOPzPj1Y2BvMEK
         vhydNO0Mn6xrm9rWH/R01n3/tny3E4hQRtdGm1vFtvQi9vFoUndsZBqr0SoCGKQ4F65t
         NAqA==
X-Gm-Message-State: ACgBeo07kWnrv/YpmuCt0HrpVbMDNvwI8d0/I98IDkmSUAoN/re6HIzE
        OMRiUV/GfamrU4U9MLU5xg8hUyxhJMgiykAlsqcvTQ==
X-Google-Smtp-Source: AA6agR6zVaiHK/kIrAry6AatC6jYuU0aS2xrWFmXfwvuQwVa//jF132uNnBuKNJYM9vd5ehlbi0mN76VRryf7Tb1eqA=
X-Received: by 2002:a25:ad16:0:b0:671:75d9:6aad with SMTP id
 y22-20020a25ad16000000b0067175d96aadmr28012031ybi.143.1660224144897; Thu, 11
 Aug 2022 06:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220811085938.2506536-1-imran.f.khan@oracle.com>
 <d3cd0f34-b30b-9a1d-8715-439ffb818539@suse.cz> <CANpmjNMYwxbkOc+LxLfZ--163yfXpQj69oOfEFkSwq7JZurbdA@mail.gmail.com>
 <6b41bb2c-6305-2bf4-1949-84ba08fdbd72@suse.cz>
In-Reply-To: <6b41bb2c-6305-2bf4-1949-84ba08fdbd72@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Thu, 11 Aug 2022 15:21:48 +0200
Message-ID: <CANpmjNNC3F88_Jr24DuFyubvQR2Huz6i3BGXgDgi5o_Gs0Znmg@mail.gmail.com>
Subject: Re: [PATCH v2] Introduce sysfs interface to disable kfence for
 selected slabs.
To:     vbabka@suse.cz
Cc:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        dvyukov@google.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 at 12:07, <vbabka@suse.cz> wrote:
[...]
> > new flag SLAB_SKIP_KFENCE, it also can serve a dual purpose, where
> > someone might want to explicitly opt out by default and pass it to
> > kmem_cache_create() (for whatever reason; not that we'd encourage
> > that).
>
> Right, not be able to do that would be a downside (although it should be
> possible even with opt-in to add an opt-out cache flag that would just make
> sure the opt-in flag is not set even if eligible by global defaults).

True, but I'd avoid all this unnecessary complexity if possible.

> > I feel that the real use cases for selectively enabling caches for
> > KFENCE are very narrow, and a design that introduces lots of
> > complexity elsewhere, just to support this feature cannot be justified
> > (which is why I suggested the simpler design here back in
> > https://lore.kernel.org/lkml/CANpmjNNmD9z7oRqSaP72m90kWL7jYH+cxNAZEGpJP8oLrDV-vw@mail.gmail.com/
> > )
>
> I don't mind strongly either way, just a suggestion to consider.

While switching the semantics of the flag from opt-out to opt-in is
just as valid, I'm more comfortable with the opt-out flag: the rest of
the logic can stay the same, and we're aware of the fact that changing
cache coverage by KFENCE shouldn't be something that needs to be done
manually.

My main point is that opting out or in to only a few select caches
should be a rarely used feature, and accordingly it should be as
simple as possible. Honestly, I still don't quite see the point of it,
and my solution would be to just increase the KFENCE pool, increase
sample rate, or decrease the "skip covered threshold%". But in the
case described by Imran, perhaps a running machine is having trouble
and limiting the caches to be analyzed by KFENCE might be worthwhile
if a more aggressive configuration doesn't yield anything (and then
there's of course KASAN, but I recognize it's not always possible to
switch kernel and run the same workload with it).

The use case for the proposed change is definitely when an admin or
kernel dev is starting to debug a problem. KFENCE wasn't designed for
that (vs. deployment at scale, discovery of bugs). As such I'm having
a hard time admitting how useful this feature will really be, but
given the current implementation is simple, having it might actually
help a few people.

Imran, just to make sure my assumptions here are right, have you had
success debugging an issue in this way? Can you elaborate on what
"certain debugging scenarios" you mean (admin debugging something, or
a kernel dev, production fleet, or test machine)?

Thanks,
-- Marco
