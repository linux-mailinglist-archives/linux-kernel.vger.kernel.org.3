Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF44A0309
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348920AbiA1VmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiA1VmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:42:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE54C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:42:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF3961EAF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 21:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBE3C340E7;
        Fri, 28 Jan 2022 21:42:21 +0000 (UTC)
Date:   Fri, 28 Jan 2022 16:42:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Misc bugfixes
Message-ID: <20220128164219.1a5189cd@gandalf.local.home>
In-Reply-To: <cover.1643399022.git.zanussi@kernel.org>
References: <cover.1643399022.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 14:08:25 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> There were 2 patches in v1 that were flagged by the 0day robot for
> strncpy off-by-1 warnings:
> 
>   tracing: Remove size restriction on hist trigger cmd error logging
>   tracing: Remove size restriction on synthetic event cmd error logging
> 
>   warning: 'strncpy' output truncated before terminating nul copying
>   as many bytes from a string as its length [-Wstringop-truncation]
> 
> This v2 patchset consists of just those two patches with the fix for
> those warnings.


So this just replaces the last two patches you sent previously?

Probably would have been better to send all three (since the other 4
already made it into mainline).

But if "tracing: Remove size restriction on tracing_log_err cmd strings" is
OK:

   https://lkml.kernel.org/r/ca965f23256b350ebd94b3dc1a319f28e8267f5f.1643319703.git.zanussi@kernel.org

then I'll just replace the other two.

-- Steve
