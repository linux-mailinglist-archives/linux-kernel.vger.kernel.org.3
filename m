Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D08D50B8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448137AbiDVNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbiDVNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9758E69
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C1A620D8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F311C385A4;
        Fri, 22 Apr 2022 13:43:51 +0000 (UTC)
Date:   Fri, 22 Apr 2022 09:43:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-ID: <20220422094350.2397cd2d@gandalf.local.home>
In-Reply-To: <20220422220523.bbad0538ef69b81cc7befe2a@kernel.org>
References: <20220415180723.GA13921@pi3.com.pl>
        <20220415181006.GA14021@pi3.com.pl>
        <20220422220523.bbad0538ef69b81cc7befe2a@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 22:05:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Can you pick this fix to urgent branch? Or Should I ask bpf people?

It looks to fix a bug from a commit pulled in from the BPF folks. I would
have them take it.

Thanks,

-- Steve
> 
> > Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
