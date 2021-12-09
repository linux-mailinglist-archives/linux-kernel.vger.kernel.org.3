Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2651346F2B2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbhLISFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:05:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56724 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLISF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:05:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B019CE2777
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 18:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1CC004DD;
        Thu,  9 Dec 2021 18:01:51 +0000 (UTC)
Date:   Thu, 9 Dec 2021 13:01:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [for-linus][PATCH 5/5] ftrace/samples: Add module to test multi
 direct modify interface
Message-ID: <20211209130150.0b7cc8d6@gandalf.local.home>
In-Reply-To: <YbJCAVYQZ5cQ9lmv@osiris>
References: <20211209152908.459494269@goodmis.org>
        <20211209153223.843082247@goodmis.org>
        <YbJCAVYQZ5cQ9lmv@osiris>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 18:50:57 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> FWIW, for the s390 bits in here:
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Tested-by: Heiko Carstens <hca@linux.ibm.com>

Thanks! I'll update the tags. (one of the reasons I post patches before
sending a pull request).

-- Steve
