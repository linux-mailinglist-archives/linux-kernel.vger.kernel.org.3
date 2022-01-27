Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8DA49EED1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbiA0X0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiA0X0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA3C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:26:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8321861CE8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 23:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71774C340E4;
        Thu, 27 Jan 2022 23:26:17 +0000 (UTC)
Date:   Thu, 27 Jan 2022 18:26:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7]  tracing: Misc bugfixes
Message-ID: <20220127182616.10a0db27@gandalf.local.home>
In-Reply-To: <cover.1643319703.git.zanussi@kernel.org>
References: <cover.1643319703.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 15:44:14 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> This is an assorted bunch of bugfixes addressing a bugzilla bug,
> smatch warnings, and related things I found while fixing those.  In
> particular, when looking at the bugzilla bug,
> https://bugzilla.kernel.org/show_bug.cgi?id=215513, I noticed that the
> err_log output looked truncated and looking further into it found that
> it was, because the hist trigger command was very long, exceeding the
> 256 character limit.
> 
> Obviously that's too short, and the final 3 patches remove that
> limitation.

Thanks Tom,

I'm going to run all of them through my tests, but I'm only going to push
the first 4 to Linus for rc, and the limitation limit can wait till the
merge window.

-- Steve
