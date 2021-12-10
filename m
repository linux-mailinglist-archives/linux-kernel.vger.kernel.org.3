Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74C47072D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhLJRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:33:06 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33208 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhLJRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:33:04 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id F091220B7179;
        Fri, 10 Dec 2021 09:29:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F091220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639157369;
        bh=n3zFD77fsu2iBIM9YqHc629nKk39GrFY63PHyYmw85U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXUw2uq6CrIM+oPL4h8hzEASkQNrmoEYocHhGK+ljy7/Vw1CIE2bMPHb7sbDKQpmm
         SC0Flcxh6cPE2jEyHn6NOPhydzbl3kD3SoIREsJyWR8Rp/Rd+7fhEmWCKzb1Rwx0lB
         pU3TenAQJtcV9T/nww8zyPe/N0T3iU3OGietbY5o=
Date:   Fri, 10 Dec 2021 09:29:23 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/13] user_events: Add UABI header for user access to
 user_events
Message-ID: <20211210172923.GA2131@kbox>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
 <20211209223210.1818-2-beaub@linux.microsoft.com>
 <20211210223017.2f9254f056e8e1b5404bc409@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210223017.2f9254f056e8e1b5404bc409@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:30:17PM +0900, Masami Hiramatsu wrote:
> On Thu,  9 Dec 2021 14:31:58 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Define the basic structs and ioctl commands that allow user processes to
> > interact with user_events.
> > 
> 
> IMHO, a basic part of this should be integrated with the [2/13] and
> other parts are incrementaly added with the patch which actually
> use that data structure or definition, so that it can be bisected
> cleanly.
> (because there is no reason to introduce only this header.)
> 

Sure thing.

Thanks,
-Beau
