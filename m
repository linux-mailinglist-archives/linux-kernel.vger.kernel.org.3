Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B654B4707D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbhLJR45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53704 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244897AbhLJR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2616B82920
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 17:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16443C341C5;
        Fri, 10 Dec 2021 17:52:49 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:52:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] trace: Account bottom half disabled sections.
Message-ID: <20211210125248.3d047603@gandalf.local.home>
In-Reply-To: <20211210125155.27e910f4@gandalf.local.home>
References: <YbN0In1NLVLMLpMj@linutronix.de>
        <20211210125155.27e910f4@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 12:51:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Looks good to me. Care to resend without the RFC attached, and that will
> make sure it gets into my scripts.

Also, please fix the subject. Precedence has, "tracing:" over "trace:", and
remove the ending period.

Thanks!

-- Steve
