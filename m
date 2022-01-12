Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D648C82E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355130AbiALQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiALQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:22:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4EC06173F;
        Wed, 12 Jan 2022 08:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC17061A14;
        Wed, 12 Jan 2022 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9CCC36AEA;
        Wed, 12 Jan 2022 16:22:00 +0000 (UTC)
Date:   Wed, 12 Jan 2022 11:21:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 16/31] rtla: Real-Time Linux Analysis tool
Message-ID: <20220112112159.742d258c@rorschach.local.home>
In-Reply-To: <5f04540c-273a-c4f2-692d-9de2f1495ba9@kernel.org>
References: <20220111173030.999527342@goodmis.org>
        <20220111173116.190327559@goodmis.org>
        <5f04540c-273a-c4f2-692d-9de2f1495ba9@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 12:15:13 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> > Link: https://lkml.kernel.org/r/f59acda8bc513c4a6c279a9bc3ad112a20690e68.1638182284.git.bristot@kernel.org  
> 
> Thanks for picking RTLA!
> 
> Just one problem, you are picking the V8, but we actually had a V9:
>   https://lore.kernel.org/lkml/cover.1639158831.git.bristot@kernel.org/

Strange. I should have picked it up from Patchwork.

https://patchwork.kernel.org/project/linux-trace-devel/list/?series=604588

Not sure how that happened. As it's not kernel code, I may rebase to
fix it.

-- Steve
