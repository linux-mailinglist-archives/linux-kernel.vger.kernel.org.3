Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D047848C926
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355522AbiALRQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:16:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58140 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355493AbiALRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:16:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00ADFB8200E;
        Wed, 12 Jan 2022 17:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB8C36AEA;
        Wed, 12 Jan 2022 17:16:24 +0000 (UTC)
Date:   Wed, 12 Jan 2022 12:16:23 -0500
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
Message-ID: <20220112121623.5b989f83@rorschach.local.home>
In-Reply-To: <20220112121426.2dde33c2@rorschach.local.home>
References: <20220111173030.999527342@goodmis.org>
        <20220111173116.190327559@goodmis.org>
        <5f04540c-273a-c4f2-692d-9de2f1495ba9@kernel.org>
        <20220112112159.742d258c@rorschach.local.home>
        <20220112113054.1be08f6c@rorschach.local.home>
        <20220112121426.2dde33c2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 12:14:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> And by making this mistake, I noticed something in doing the diff. You
> put rtla into Documentation/tools. It should be in tools/ itself, not
> the Documentation directory.

At least it use to be in tools/tracing/rtla, but this series has code
in Documentation/tools/rtla, was it not fully moved over?

-- Steve
