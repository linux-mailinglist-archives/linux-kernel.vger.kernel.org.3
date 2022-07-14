Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48288574A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiGNKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGNKar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:30:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7902243E60
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:30:46 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i14so2491184yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lz8rGIDj9SXfgtM2+NZtPq8eRu27DnZwFYVL9tqzU00=;
        b=UvzEqHXVWDE8JyHkxyh135weDxe1AEyOVg6p1RG2QmPQVKznjn6egIm+afeDBMnEPI
         vS3umzYqLiGNYhv3OXv9at5XDpsjZX02DzV+g/OWAIsLT7RqwrKqgCuHnUOmwNh6oucX
         IgoS90dqsUP9sj5QeQI6Z7FyAAlG4GZXr3qKXfpx3nlRV6EiLFEDgWMe5JbdZug7z2Gs
         NtO5SsVJEI6L/1oWMeCNWl3dQNQC24m9mhPKkGZW4UIKte9CuXjBVEl5rvB4qqPkMBmn
         nxny9eHAzbU9D2H4/13Qpi+VjQv/rxrWcnzFGy67gj7q2tmar6F1RfU4GmBPtPRwy/E9
         PYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lz8rGIDj9SXfgtM2+NZtPq8eRu27DnZwFYVL9tqzU00=;
        b=lSsoh+zGiNRakNKIwbDgEKHImxC+EBap41do0izgGCBFD2Pf40yHuk49pdkghaXD1b
         C0YnH5jkaU4gDQ5+91SF+0IPV8A3ZCqUkRPzLmU7KCahJqxg12aoDMQIg+bJpF/0oxnS
         JVw1o5FtNtx7zLCckdjI0ngjI0FfBFk+plYFq3LjTq3DLrGcJRHO1fOYagFiuPMyipJe
         ozVUSRsVFhcTkGw5+TyAhE0gHonaLP5VrUMFNLgbfZ/au2sL1hgbtvbsOG3ZjDP0zUln
         cx/fs+zg0lOaxG/cn8B8MffoB8BQuA3uPutbof1uclAUdF50q++HDmyvJDRV85vpCOaV
         trhw==
X-Gm-Message-State: AJIora9JF9sCFTB5wX70EZkRB688MS4E+KavYldL4hON0yPPcJAUBbhu
        jM9Csz4wJ0sruSYEy7WJXFaQWfVvO4mLsRyaP8OUKA==
X-Google-Smtp-Source: AGRyM1uIv12rQzdLqqPzl8LdX476CU5OQAwR4beJZOeqAcyUeQCaYF0ArVBVh+G01Ah8zxlMQrh15WmRaEeU1uj5Rko=
X-Received: by 2002:a05:6902:1184:b0:66e:756d:3baa with SMTP id
 m4-20020a056902118400b0066e756d3baamr7783160ybu.533.1657794645395; Thu, 14
 Jul 2022 03:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220712133946.307181-1-42.hyeyoo@gmail.com> <20220712133946.307181-17-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de> <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de> <CANpmjNPbbugrbCFADy1C7PgaU-4PMd9UK90QiHKS-Md0ocqa3w@mail.gmail.com>
 <alpine.DEB.2.22.394.2207141115050.184626@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2207141115050.184626@gentwo.de>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 Jul 2022 12:30:09 +0200
Message-ID: <CANpmjNPGsqV4FYNq9Q-rUKCEZ3wOJbk3xfcfBks0O-bhFDmYcw@mail.gmail.com>
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in __ksize()
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, 14 Jul 2022 at 11:16, Christoph Lameter <cl@gentwo.de> wrote:
>
> On Wed, 13 Jul 2022, Marco Elver wrote:
>
> > We shouldn't crash, so it should be WARN(), but also returning
> > PAGE_SIZE is bad. The intuition behind returning 0 is to try and make
> > the buggy code cause less harm to the rest of the kernel.
> >
> > >From [1]:
> >
> > > Similarly, if you are able to tell if the passed pointer is not a
> > > valid object some other way, you can do something better - namely,
> > > return 0. The intuition here is that the caller has a pointer to an
> > > invalid object, and wants to use ksize() to determine its size, and
> > > most likely access all those bytes. Arguably, at that point the kernel
> > > is already in a degrading state. But we can try to not let things get
> > > worse by having ksize() return 0, in the hopes that it will stop
> > > corrupting more memory. It won't work in all cases, but should avoid
> > > things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> > > bounds the memory accessed corrupting random memory.
>
> "in the hopes that it will stop corrupting memory"!!!???
>
> Do a BUG() then and definitely stop all chances of memory corruption.

Fair enough.

Well, I'd also prefer to just kill the kernel. But some people don't
like that and want the option to continue running. So a WARN() gives
that option, and just have to boot the kernel with panic_on_warn to
kill it. There are other warnings in the kernel where we'd better kill
the kernel as the chances of corrupting memory are pretty damn high if
we hit them. And I still don't quite see why the case here is any more
or less special.

If the situation here is exceedingly rare, let's try BUG() and see what breaks?
