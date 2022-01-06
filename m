Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBBE486D86
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiAFXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:07:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35508 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245283AbiAFXHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:07:14 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 71D1920B7179;
        Thu,  6 Jan 2022 15:07:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71D1920B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641510434;
        bh=f2wACj9WZK2QCImdwnOicF3lUDyuoYCy7ROFz5G0vTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=innuqWilhcyDHc/NPxWgLlv6GqSvcpNWzrFrLvF+UbAdnID+Zdnrr/e4LYDjpuO5E
         +jdCehd5r71GTvYmm7Ntu8Ioxs34X5pGJMt6/82ongvq7vjyfcrSwJFyDv1IATF5LH
         ww+Bfqm6K3PfvqzJ+bou9lIc+XBa3HrzUP0eMDx4=
Date:   Thu, 6 Jan 2022 15:06:31 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] user_events: Add sample code for typical usage
Message-ID: <20220106230631.GB2447@kbox>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
 <20211216173511.10390-11-beaub@linux.microsoft.com>
 <20211223081814.1ca544cdf18e29a93f60c597@kernel.org>
 <20220106170907.2e7f2bd8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106170907.2e7f2bd8@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 05:09:07PM -0500, Steven Rostedt wrote:
> On Thu, 23 Dec 2021 08:18:14 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 16 Dec 2021 09:35:09 -0800
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > Add sample code for user_events typical usage to show how to register
> > > and monitor status, as well as to write out data.  
> > 
> > Ah, here is the sample code. OK.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Ah, probably should swap the patches around (makes it easier on the
> reviewers ;-)
> 
> That is, 10 should come before 9, so that the reference to samples exists
> when the document is added.
> 
> -- Steve

Sure thing.

Thanks,
-Beau
