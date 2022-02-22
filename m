Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649824BF1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiBVFsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:48:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiBVFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:48:37 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C813F77
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:48:12 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d625082ae2so161421827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw6aQJa1MO9WdpxwzimvLityGgLsFlQla0AXaHMQmt0=;
        b=q//0ngBw/9CR5mrn8X0xPqPq9wEjbNjeSbSLQaR1T9XnxZ6n6eOU/zM9nTaILAgbDj
         AbZb2CzrN8VVOPIZg8lcIqeo1AyHKbg9rHy33/6sqG+f6Jxs5gpFmcChMOkJzsrY3xgw
         YcBPrAMipOn34XET6lfU5xmem/NSO6dn5bfVUzx3vXqrcq5J26cdP9DraWBw9kth9RM4
         ZEoIhB30eylsyqC+bBwoned+sm1fvSG980njnWDcZO+XUhtDNalHnyPWclNCojmomU9r
         pkQZkjfsXAbLe78VXjdYJzkjvpfaFQh7ffzpHoqI7ZmyMpfEntiQF9WrMYaJxrBknlJQ
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw6aQJa1MO9WdpxwzimvLityGgLsFlQla0AXaHMQmt0=;
        b=AKGH9rIZXWWpM+ITXjw/F8S8OdjvHl5cqQqq3B/8Yp0SYg9M5bZ4tk1xCms9xTGJKS
         ZtDx/Y8DJDK1lXotMwqZMGgIchFoZfGgzhoGjos+Lef7zdjj5pG2diK6UUMMxevYXcJm
         gQG4ihtzbYVtq7PRQg8jSdzt+SlUpUN1kOFLMRY4OuV2Qr8AaXb0+yQOrTbgzYiUzCJ1
         4ezmpvOy6Kd00aCvWafelSIiDqvDhkbJMYEYhV5SU9SC5FQ0yYPqgD5kFwk5+PStwq5+
         4enlFw64FPNv8J+sUxrO4nE2CTCyxkZZ2V04RqF1uid2eGpPIReg1GgUi79Hd6wPgw0z
         LHXg==
X-Gm-Message-State: AOAM5336Ps6NuoeF8odHhN53CG2WogTvnrQwOzFjacOjfJIGE7venY8H
        D6A/G7Dlwd0wzWSH6bQ6L4yAchu2cMIiRj4mTruTUg==
X-Google-Smtp-Source: ABdhPJyhDuclYQmodYIzN2CJ9eAgBf112KtTtES+r/ZuZFe3mtJx+Sv/y4TK/ne8vFOyQsWxtDM1mBcQMZ/Aa1QF7CM=
X-Received: by 2002:a81:1748:0:b0:2d6:41ae:1384 with SMTP id
 69-20020a811748000000b002d641ae1384mr22200124ywx.293.1645508891454; Mon, 21
 Feb 2022 21:48:11 -0800 (PST)
MIME-Version: 1.0
References: <20220211013032.623763-1-surenb@google.com> <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
 <YgwDa6rMHRdRTnzB@dhcp22.suse.cz> <YgwHhTN4P5yyZqBz@dhcp22.suse.cz>
 <CAJuCfpGG9zwbvfH5UZkt6cG=woeO0RGE7QxjEpXn=gFhiaDdmQ@mail.gmail.com>
 <YgywnF8l4Zu0aLtF@dhcp22.suse.cz> <CAJuCfpFOy_oRp=WWqtzE7bJR7p51FzzBPtbKhWeTGOKC-n41Cg@mail.gmail.com>
In-Reply-To: <CAJuCfpFOy_oRp=WWqtzE7bJR7p51FzzBPtbKhWeTGOKC-n41Cg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 21 Feb 2022 21:48:00 -0800
Message-ID: <CAJuCfpE+3OzM3h79ywWrNWHM3B2v7u3Z07MTt4cMtVD4OGi7pQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>, legion@kernel.org,
        ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Thu, Feb 17, 2022 at 11:54 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Feb 16, 2022 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 15-02-22 15:02:54, Suren Baghdasaryan wrote:
> > > On Tue, Feb 15, 2022 at 12:05 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > One thing I was considering is to check agains ref counte overflo (a
> > > > deep process chain with many vmas could grow really high. ref_count
> > > > interface doesn't provide any easy way to check for overflows as far as
> > > > I could see from a quick glance so I gave up there but the logic would
> > > > be really straightforward. We just create a new anon_vma_name with the same
> > > > content and use it when duplicating if the usage grow really
> > > > (arbitrarily) high.
> > >
> > > I went over proposed changes. I see a couple small required fixes
> > > (resetting the name to NULL seems to be missing and I think
> > > dup_vma_anon_name needs some tweaking) but overall quite
> > > straight-forward.
> >
> > OK, great that this makes sense to you. As I've said I didn't really go
> > into details, not even dared to boot that to test. So it will very
> > likely need some more work but I do not expect this to grow much.
> >
> > > I'll post a separate patch to do this refactoring.
> > > The original patch is fixing the UAF issue, so I don't want to mix it
> > > with refactoring. Please let me know if you see an issue with
> > > separating it that way.
> >
> > Well, I am not sure TBH. Look at diffstats. Your fix
> > 2 files changed, 63 insertions(+), 17 deletions(-)
> > the refactoring which should fix this and potentially others that might
> > be still lurking there (because mixing shared pointers and their internal
> > objects just begs for problems) is
> > 7 files changed, 63 insertions(+), 86 deletions(-)
> >
> > more files touched for sure but the net result is much more clear and a
> > much more code removed.
> > The overflow logic would make it bigger but I guess the existing scheme
> > needs it as well.
>
> Ok, I'll see how to slice it after it's complete and tested.
> Thanks for the input!

I posted the new patchset that includes:
1. refactoring of the code suggested by Michal:
https://lore.kernel.org/all/20220222054025.3412898-1-surenb@google.com
2. refcount overflow protection suggested by Michal:
https://lore.kernel.org/all/20220222054025.3412898-2-surenb@google.com
3. UAF fix (originally implemented by this patch) reimplemented after
the first two changes:
https://lore.kernel.org/all/20220222054025.3412898-3-surenb@google.com
Hopefully this sequence makes sense.
Thanks,
Suren.

>
> >
> > I would also claim that both approaches are really painful to review
> > because the existing model spreads into several areas and it is not
> > really clear you caught them all just by staring into the diff so both
> > will be rather painful to backport to older kernels. Fortunately this
> > would be only 5.17.
> > --
> > Michal Hocko
> > SUSE Labs
