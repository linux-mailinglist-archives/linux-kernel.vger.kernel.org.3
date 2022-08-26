Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0140D5A1DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiHZA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHZA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:58:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78920C888B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17673B82F5E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAEBC433D6;
        Fri, 26 Aug 2022 00:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661475495;
        bh=2KO2ctk5+kkvwr4IR91IAL/jLIp687//D+t1Eubhxl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ezH9zVpLbKpPS1kA42cZlxqA3ygxNlapdA20bB9gWxrhYQ/r8Q3S5dm3d9ZpK0PQb
         zJjv9lnNyuuEweCxVekf4M07ltPotZyzadBm9nhOUVoWP6ROacxOR9mRZkR4pNsrI7
         mPbyI+FGIpuSQtLCFc94hBy4kehy82VfG6+E63erxrsyTvWQseaAw/MxAkiTd5tdze
         jwM+cRajhz1sKvxj8bjYkK9cLKr6/62UO5mUgs6ifvxghdlXLLxyCE2pu2Em3lO+pt
         tkjapjlSlYTv4zem2JV7VOXdqGOrVxmgM+3Km8toAgvlQEoPhHg1MZtJGuJtiGPIPR
         ZFLX2vwuGfL4w==
Date:   Fri, 26 Aug 2022 09:58:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing/histograms: multiple hitcount support
Message-Id: <20220826095811.455861bec38a7f4189b8e4a2@kernel.org>
In-Reply-To: <cover.1661464992.git.zanussi@kernel.org>
References: <cover.1661464992.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, 25 Aug 2022 17:19:00 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> The first patch here adds support for multiple hitcount fields.
> 
> The second and third fix up your v2 [1] patches on top of the first
> just so I could test them.
> 
> It works fine for me.  Let me know if you want me to update the v3
> version instead of this one and I can do that instead.

Thanks! I'll check it and rebase my v3 patches on it.

> 
> Thanks,
> 
> Tom
> 
> [1] https://lore.kernel.org/lkml/165966330764.3826604.9358384228095103695.stgit@devnote2/
> 
> 
> The following changes since commit 09c9cdd023f26244463b1276b251a91e72915178:
> 
>   tracing/filter: Call filter predicate functions directly via a switch statement (2022-08-23 17:41:13 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/masami-hitcount-v0
> 
> Masami Hiramatsu (Google) (2):
>   tracing: Add .percent suffix option to histogram values
>   tracing: Add .graph suffix option to histogram value
> 
> Tom Zanussi (1):
>   tracing: Allow multiple hitcount values in histograms
> 
>  kernel/trace/trace.c             |   3 +-
>  kernel/trace/trace_events_hist.c | 144 ++++++++++++++++++++++++++++---
>  2 files changed, 136 insertions(+), 11 deletions(-)
> 
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
