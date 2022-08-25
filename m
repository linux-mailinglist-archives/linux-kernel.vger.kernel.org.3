Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5336A5A1C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbiHYWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C99F0F2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 248A161CAC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 22:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D9C433D6;
        Thu, 25 Aug 2022 22:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661465946;
        bh=cLUVQswR3NMF9do2XwrJRP9fYIYJD075FiMOezpmJIw=;
        h=From:To:Cc:Subject:Date:From;
        b=NXCpeEI0VXAtI5kMcrsEPEJqfelvWGgPncsKYfZAwc1B1y7k00MaFVvKnPgA4R82j
         pZXJSbdyS6W2WEFeBLkRHeepnXEBiUSy2ua7CGgeII5yZO0QCNfIqZIMpinIMc19rH
         v/vjy6OapZOY4P4Vo1qYO7fiH/7JdzQARepfRNEXXsIcvyvW9v8eIkSqZs7LX2bTqs
         n7WBIZLlny8WRDOgMCLEqduuAbezzFLIPbxeaQf8aOUMWluN8ra+H2bgaj7vPMCLws
         pi+QushMWLc8+tGo0/pLUw4agCFTdtzr0EZa2eZ1z9CZa8W/+PH3D6wodyHWateHnN
         5DM4mTETdUgDA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing/histograms: multiple hitcount support
Date:   Thu, 25 Aug 2022 17:19:00 -0500
Message-Id: <cover.1661464992.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

The first patch here adds support for multiple hitcount fields.

The second and third fix up your v2 [1] patches on top of the first
just so I could test them.

It works fine for me.  Let me know if you want me to update the v3
version instead of this one and I can do that instead.

Thanks,

Tom

[1] https://lore.kernel.org/lkml/165966330764.3826604.9358384228095103695.stgit@devnote2/


The following changes since commit 09c9cdd023f26244463b1276b251a91e72915178:

  tracing/filter: Call filter predicate functions directly via a switch statement (2022-08-23 17:41:13 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/masami-hitcount-v0

Masami Hiramatsu (Google) (2):
  tracing: Add .percent suffix option to histogram values
  tracing: Add .graph suffix option to histogram value

Tom Zanussi (1):
  tracing: Allow multiple hitcount values in histograms

 kernel/trace/trace.c             |   3 +-
 kernel/trace/trace_events_hist.c | 144 ++++++++++++++++++++++++++++---
 2 files changed, 136 insertions(+), 11 deletions(-)

-- 
2.34.1

