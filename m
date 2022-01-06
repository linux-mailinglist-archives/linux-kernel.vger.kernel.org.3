Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FB4486BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244172AbiAFVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiAFVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:14:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA4C061245;
        Thu,  6 Jan 2022 13:14:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 111E0B8175C;
        Thu,  6 Jan 2022 21:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4151EC36AE5;
        Thu,  6 Jan 2022 21:14:18 +0000 (UTC)
Date:   Thu, 6 Jan 2022 16:14:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] user_events: Add documentation file
Message-ID: <20220106161416.3af2a007@gandalf.local.home>
In-Reply-To: <20220103230139.GA1522@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
        <20211216173511.10390-10-beaub@linux.microsoft.com>
        <20211222231834.875f662b37fe673dec0b3663@kernel.org>
        <20220103230139.GA1522@kbox>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 15:01:39 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > > +Example Code
> > > +------------
> > > +See sample code in samples/user_events.  
> > 
> > Maybe tools/testing/selftests/user_events ?
> >   
> 
> Previously I was asked to put the sample code in samples/user_events, so
> it lives there.

Yes, please keep the sample code in samples. Even if we have duplicate code
in selftests, that should not be used for sample code.

-- Steve
