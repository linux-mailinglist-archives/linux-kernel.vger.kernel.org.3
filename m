Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8346F4C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhLIUXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:23:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E2C061746;
        Thu,  9 Dec 2021 12:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 909ECB82673;
        Thu,  9 Dec 2021 20:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD72C004DD;
        Thu,  9 Dec 2021 20:19:31 +0000 (UTC)
Date:   Thu, 9 Dec 2021 15:19:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211209151930.709d3d0b@gandalf.local.home>
In-Reply-To: <20211209201112.GB21676@kbox>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
        <20211201182515.2446-3-beaub@linux.microsoft.com>
        <20211208181905.62f8f999@gandalf.local.home>
        <20211209005823.GA21399@kbox>
        <20211208210336.40c7741b@yoga.local.home>
        <20211209174050.GA21553@kbox>
        <20211209124735.3d1a9707@gandalf.local.home>
        <20211209194235.GA21676@kbox>
        <20211209145738.4da346ba@gandalf.local.home>
        <20211209201112.GB21676@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2021 12:11:12 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> I guess I am being paranoid about an architecture that does not have
> automatic cache consistency and while the write / read don't happen at
> the exact time, they happen close together. Close enough that one CPU
> reads the old value from a cache line and gets it wrong.
> 
> I don't believe that is possible on Intel, but I don't know if it's
> possible on other architectures (especially older ones).

If this was possible, then there would be a lot more bugs out there than
this one. For one thing, the file descriptor itself would be freed while
accessed.

-- Steve
