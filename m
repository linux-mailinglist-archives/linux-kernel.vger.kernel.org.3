Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911F578E15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiGRXLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiGRXLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:11:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648532CCA9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:11:16 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 7so6058314ybw.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9j8vgvSn8k1pKIOzdTIGV031NEyB4KfdD0KsS47kB1M=;
        b=Z+xv8aucm9Wu7rEve4rvcC4oDIv0lEZ4AxjtsUTvuoqUajYe049N+sstsyIQW+UrSu
         riqKjRbcaawQnE7ybvKKybeYVQD58kAs0u5GAfXHlqVbwIYIs6Xmi0cKLwmdvwvUGWNk
         cARRio9Qf/OEp1PhVhTMfFu1bt+nMhTw5RpopYyem2LoRegJ4rck4+7JWKuV5La5UcKH
         PxD50Ied29DGeVZBYFKr1McYZLheiaShcLdwURC5lnfygy4vxm5kCdaU3WG5UC0bnwWH
         u/GereRFWG7CIpMOEYOAHQpRNHo4/Xfm7oHQNAC2ad0IcsP6j0lcoqvqrPbtkI5ICDOE
         5fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9j8vgvSn8k1pKIOzdTIGV031NEyB4KfdD0KsS47kB1M=;
        b=475c3HTQ/rm/myp1r/HXAQC2sDnnOex6r7Op4+hE00fuz8JjmnzyPu6/BC5keGNlqV
         w6ZNFilBVM8J5PywEWz60JIcF+hJ/EbAgLca7+c+HY+VIiN4CVUoLtfML/gPPMshHqpK
         /Do+x+/AarBCX96f0v5IJyVX+KgkRC/P7dRT2BOA3Q/r3uY0B++/UHr7mmdpap89jP8U
         h7W5SFC7DZgVNH77Mt2oM/sLq8hTvGEBf90WgZj7xeDZ9F/Ii9GTYlMP+MIeUcNXdc87
         EMVDFm3XMY77JgK96pYG0avVHEH90wowT0HwbhxgtpIrcD0Kfafneucpeu2NT9ttrwM4
         4OiA==
X-Gm-Message-State: AJIora99hTBXh41VMG/ecP0IhKTl0u+qohkecZlKgYsMTzz1mJbeTJ+q
        40UjmfU0vOkXxlsWal0wnlAjyKVDp+Ox1gTtl/6x8g==
X-Google-Smtp-Source: AGRyM1tLSdy8hX41ImG5NitWZwBW7lvmwa8+A+n385W3m/3hDC2AxrA3BKH9W1HWhYgrT+2VUeqA/iDEwRiwQzOm8Gg=
X-Received: by 2002:a5b:cc6:0:b0:66e:45c6:2a25 with SMTP id
 e6-20020a5b0cc6000000b0066e45c62a25mr30392881ybr.304.1658185875490; Mon, 18
 Jul 2022 16:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com> <87ilnuuiw8.ffs@tglx>
In-Reply-To: <87ilnuuiw8.ffs@tglx>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 18 Jul 2022 16:10:39 -0700
Message-ID: <CABCJKufysUur5jb1OX7ksb4UrvLszSz=FOtHH22GcTrLFZWx+w@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 3:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Jul 18 2022 at 15:48, Sami Tolvanen wrote:
> > On Mon, Jul 18, 2022 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
> >> > And we need input from the Clang folks because their CFI work also puts
> >> > stuff in front of the function entry, which nicely collides.
> >>
> >> Right, I need to go look at the latest kCFI patches, that sorta got
> >> side-tracked for working on all the retbleed muck :/
> >>
> >> Basically kCFI wants to preface every (indirect callable) function with:
> >>
> >> __cfi_\func:
> >>         int3
> >>         movl $0x12345678, %rax
> >>         int3
> >>         int3
> >> \func:
> >
> > Yes, and in order to avoid scattering the code with call target
> > gadgets, the preamble should remain immediately before the function.
> >
> >> Ofc, we can still put the whole:
> >>
> >>         sarq    $5, PER_CPU_VAR(__x86_call_depth);
> >>         jmp     \func_direct
> >>
> >> thing in front of that.
> >
> > Sure, that would work.
> >
> >> But it does somewhat destroy the version I had that only needs the
> >> 10 bytes padding for the sarq.
> >
> > There's also the question of how function alignment should work in the
> > KCFI case. Currently, the __cfi_ preamble is 16-byte aligned, which
> > obviously means the function itself isn't.
>
> That's bad. The function entry should be 16 byte aligned and as I just
> learned for AMD the ideal alignment would be possibly 32 byte as that's
> their I-fetch width. But my experiments with 16 bytes alignment
> independent of the padding muck is benefitial for both AMD and Intel
> over the 4 byte alignment we have right now.

OK, that's what I thought. KCFI hasn't landed in Clang yet, so it
shouldn't be a problem to fix this.

Sami
