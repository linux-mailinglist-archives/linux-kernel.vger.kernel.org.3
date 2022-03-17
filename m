Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003FB4DD169
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCQXvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiCQXvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CC2B3D6C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0133611B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 23:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5363DC340E9;
        Thu, 17 Mar 2022 23:49:39 +0000 (UTC)
Date:   Thu, 17 Mar 2022 19:49:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 03/13] fprobe: Add ftrace based probe APIs
Message-ID: <20220317194937.08584828@gandalf.local.home>
In-Reply-To: <CAEf4BzaN_HnyAkVYeUmYoxvW01cFKR2FW0MwZJBL3gvkRw0TYg@mail.gmail.com>
References: <20220317152458.213689956@goodmis.org>
        <20220317152522.284233550@goodmis.org>
        <CAEf4BzaN_HnyAkVYeUmYoxvW01cFKR2FW0MwZJBL3gvkRw0TYg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 15:03:33 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Do I understand correctly that this patch set was applied in your
> tree? I was under the impression that we agreed to route this through
> the bpf-next tree earlier (see [0]), but I might have misunderstood
> something, sorry.
> 
> Either way, the reason it matters is because Jiri's multi-attach
> kprobe patch set ([1]) is depending on Masami's patches and having
> fprobe patches in bpf-next tree would simplify logistics
> significantly.

I knew Jiri's patches were to go through the bpf tree, but I missed that
those were dependent on this and you wanted these to go through as well.

I had just finished my automated tests that ran these patches. I haven't
pushed them to my next branch yet so I can hold them off. I don't have
anything dependent on them.

Would you be able to take these for-next patches directly (as they all have
been tested) and you can switch my signed-off-by to Reviewed-by.

The first of the series is unrelated and will go through my tree. That's
the user_events patch.

-- Steve


> 
> So I wonder if it's still possible to route it through bpf-next?
> 
> If not, we'd need a way to get these changes into the bpf-next tree
> somehow. Having it in a separate branch that we can merge would be a
> way to go about this, I presume? But it's certainly a more complicated
> way, so it would be preferable to back it out and land through
> bpf-next.
