Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0666C477515
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhLPO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:56:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48366 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhLPO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:56:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF9EB1F3A7;
        Thu, 16 Dec 2021 14:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639666584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbZMjTq3ApjfLH9PBdmydkALxgQfnfuGHo8ADc744ws=;
        b=ixA/hc43S2j+Avp9MS5rg4UuuMPRSifbcDC/BPOpBVFnzJjMPF8RElcCSRhTORRlWQI7uI
        P2qZRaOuwMZHIs4Txdrh0/hQi3oufQmgz0IgayuFJRKUhSZSQVimaa/CNJ5IA+EEaSuZNd
        2JZWaxSWW2v0+Oe5vQeY00D4bP9UDQ8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD4E2A3B83;
        Thu, 16 Dec 2021 14:56:24 +0000 (UTC)
Date:   Thu, 16 Dec 2021 15:56:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/gdb: lx-dmesg: read records individually
Message-ID: <YbtTl4zU4U8prj90@alley>
References: <874k79c3a9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k79c3a9.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-12-15 16:16:22, John Ogness wrote:
> For the gdb command lx-dmesg, the entire descriptor, info, and text
> data regions are read into memory before printing any records. For
> large kernel log buffers, this not only causes a huge delay before
> seeing any records, but it may also lead to python errors of too
> much memory allocation.
> 
> Rather than reading in all these regions in advance, read them as
> needed and only read the regions for the particular record that is
> being printed.
> 
> The gdb macro "dmesg" in Documentation/admin-guide/kdump/gdbmacros.txt
> already prints out the kernel log buffer like this.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me.

The patch has been committed into printk/linux.git, branch for-5.17.

Best Regards,
Petr
