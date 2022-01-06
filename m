Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2E486D10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiAFWJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:09:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60000 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbiAFWJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:09:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2D0FB8244D;
        Thu,  6 Jan 2022 22:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97C3C36AE5;
        Thu,  6 Jan 2022 22:09:08 +0000 (UTC)
Date:   Thu, 6 Jan 2022 17:09:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] user_events: Add sample code for typical usage
Message-ID: <20220106170907.2e7f2bd8@gandalf.local.home>
In-Reply-To: <20211223081814.1ca544cdf18e29a93f60c597@kernel.org>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-11-beaub@linux.microsoft.com>
        <20211223081814.1ca544cdf18e29a93f60c597@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 08:18:14 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 16 Dec 2021 09:35:09 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Add sample code for user_events typical usage to show how to register
> > and monitor status, as well as to write out data.  
> 
> Ah, here is the sample code. OK.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Ah, probably should swap the patches around (makes it easier on the
reviewers ;-)

That is, 10 should come before 9, so that the reference to samples exists
when the document is added.

-- Steve
