Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5F4653C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351818AbhLARUM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Dec 2021 12:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351795AbhLARUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:20:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7132DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DB70B82049
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F6C56747;
        Wed,  1 Dec 2021 17:16:38 +0000 (UTC)
Date:   Wed, 1 Dec 2021 12:16:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] cgroup: Trace event cgroup id fields should be u64
Message-ID: <20211201121636.4e25c2b8@gandalf.local.home>
In-Reply-To: <20211201165658.728107-1-william.kucharski@oracle.com>
References: <20211201165658.728107-1-william.kucharski@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Dec 2021 09:56:58 -0700
William Kucharski <william.kucharski@oracle.com> wrote:

> Various trace event fields that store cgroup IDs were declared as
> ints, but cgroup_id(() returns a u64 and the structures and associated
> TP_printk() calls were not updated to reflect this.
> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  V3: Reorder structures to avoid leaving alignment padding holes
>  V2: Do not remove tabs from macro definitions
> 
>  include/trace/events/cgroup.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

From a tracing POV:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
