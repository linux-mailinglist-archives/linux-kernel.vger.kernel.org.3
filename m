Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EF4D0E32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbiCHDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCHDNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:13:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D2AE62
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:12:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t187so10963411pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 19:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSL+CJ30QrNNiMtvQAliZTSjOgz5ibG4HT8HISEqYVw=;
        b=enIgMCftvwgGBl1IncTfFPpjWznJL5qOknJvHD/wBZJXmsv3Wv4QmwayLtrZ+zuS07
         d81C5bvx7boL+GzT394rKVRZ4JEaHLbJvnDpJCRi1lrOvTY5UBe0LAFZuDX515iy2br+
         7jnDJCki9KavViUAUuAyN4LTN2zbEHxS1lwxuM9cKkjVFSPtFdY6Fh0ko3cSag7/KJE5
         aYdshI7z68wm3TA1d2GD83NR0wwze00yL+cXLLhB3GwIh20lenTE+f4vyshK6/VFdsef
         EKsaaVmavyt3YttJlz8NwtEdqK7IkbOlZX31WjYcKET/3HCd9SzJeXUGIFQJvlE3B6dx
         nisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSL+CJ30QrNNiMtvQAliZTSjOgz5ibG4HT8HISEqYVw=;
        b=zpfdDufD5Kw0fJYawLDsa0WAXRdX421dbN4Gm0jJJuGL+FUPpaA5rR7mROiNyQTt5V
         6TgIABXL2liz3xIpA2M7OPQ3uRrVUzzwwkBBN4DkaRH82VYZ/L6caL8xgYMjfXB3pk+g
         SsDlw4MaNIJHWTmVUKA8KBJUsW1RP5bc58UwqJkgH1WNFpNRIY76izTzi12OJJAdwFoP
         st5oRIlBoZzlM0A3jLixpjJx9juWsYd8gi0oZQ+4XoESxbKPg9XWjcf5YW/hPxlPDJbH
         21RCTrTUQQ2jOY1k+Qpr1IwKDNCzp+N0p3spY/rt7NxqVJ9SFeFBRkWKH/peVs86Zifu
         J+DA==
X-Gm-Message-State: AOAM532YtSrvSq8hF8Qo7wzB9wmxPdHbSmqnYXjXNYphxUHDtPEdXubo
        VdPGy0paI0ukBVXazGvHdMHRQTDbRvVfF+VSca4=
X-Google-Smtp-Source: ABdhPJwtoNx6F2DnCx+OyV0HaX2RHwYKcgUBJsc6OpAydX/rAAPDRRmjID2wQgJXWbBnsxmS7FYdeoDpJzJYZEhrD1k=
X-Received: by 2002:a63:cd49:0:b0:373:5fbb:c790 with SMTP id
 a9-20020a63cd49000000b003735fbbc790mr12247352pgj.206.1646709132146; Mon, 07
 Mar 2022 19:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20220303222014.517033-1-shy828301@gmail.com> <CADFyXm6W9CVkO4XPYep-tHg55c8m8NES783kcVYrdjSMbzYoDA@mail.gmail.com>
 <CAHbLzkriyBy2HqjssurLSnhoyuUzpJRZjMPNx34MTgxeO0dddg@mail.gmail.com>
 <13ad4ba1-2a88-9459-3995-70af36aba33e@redhat.com> <20220306180718.6d4e6233130b94fdad98df88@linux-foundation.org>
 <84a6c9c1-d18f-6955-2666-0a2d7bce6094@redhat.com> <20220307154326.6494f7fca7def491a23e5df1@linux-foundation.org>
 <CAHbLzkqY69nFniK+ckQaeu117Q+OqZ2hvFEdVbZaW2C_zAzDbg@mail.gmail.com>
 <20220307165015.77fbcbe9e1fa2fe15f3eb239@linux-foundation.org> <8f419d19-c83d-bbcd-8936-2d64ced7464c@google.com>
In-Reply-To: <8f419d19-c83d-bbcd-8936-2d64ced7464c@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Mar 2022 19:12:00 -0800
Message-ID: <CAHbLzko0cGBjPzfB28+AKRsb=B_m1NnPoHQ+HdKibP7wH7HxZA@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 6:36 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 7 Mar 2022, Andrew Morton wrote:
> >
> > OK, looks sane.  Can someone please test all this?
>
> Only the briefest of testing, but
>
> mmotm 2022-03-06-20-33
> minus mm-thp-dont-have-to-lock-page-anymore-when-splitting-pmd.patch
> plus mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd.patch
> plus mm-huge_memory-remove-stale-locking-logic-from-__split_huge_pmd-fix.patch
>
> is infinitely better than mmotm 2022-03-06-20-33.
>
> I could just about reach a login on yesterday's mmotm, but graphics no.
> Couldn't spend time to investigate, but Naresh's mail today that LTP
> thp04 timeouted (hey, I'm English, we say timed out!) inspired me to
> try booting with transparent_hugepage=never on cmdline, and that worked.

I think it was because of
mm-thp-dont-have-to-lock-page-anymore-when-splitting-pmd.patch. It was
buggy (missed pmd_trans_huge(*pmd) check) and was dropped by Andrew.

>
> Again, no time to investigate, but the combination above has booted
> and is running load, including transparent hugepages.  And before
> setting that load going, I did try LTP thp04, which passed.
>
> (There is an unrelated console printk lockdep spew, and am I the only
> one to see these mm/workingset.c:567 shadow_lru_isolate warnings that
> started up a week or three ago?)
>
> Must dash,
> Hugh
