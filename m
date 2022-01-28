Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43E149F665
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbiA1JcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:32:03 -0500
Received: from mail.thorsis.com ([92.198.35.195]:58922 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347617AbiA1Jb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:31:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 14AFE2984;
        Fri, 28 Jan 2022 10:31:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cATs4BJi6wes; Fri, 28 Jan 2022 10:31:57 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id E6D7CCE9; Fri, 28 Jan 2022 10:31:56 +0100 (CET)
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RECEIVED,NO_RELAYS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: intel.com]
        * -0.0 NO_RELAYS Informational: message was not relayed via SMTP
        * -0.0 NO_RECEIVED Informational: message has no Received headers
Date:   Fri, 28 Jan 2022 10:31:45 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfO37KjTS7B2W2bH@ada.ifak-system.com>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o83xrwk9.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Thu, Jan 27, 2022 at 09:08:06AM -0700 schrieb Jonathan Corbet:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > It's unclear from "Submitting Patches" documentation that Reported-by
> > is not supposed to be used against new features. (It's more clear
> > in the section 5.4 "Patch formatting and changelogs" of the "A guide
> > to the Kernel Development Process", where it suggests that change
> > should fix something existing in the kernel. Clarify the Reported-by
> > usage in the "Submitting Patches".
> >
> > Reported-by: Florian Eckert <fe@dev.tdt.de>
> 
> You're sure this added documentation isn't a new feature that shouldn't
> have a Reported-by? :)
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 31ea120ce531..24c1a5565385 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
> >  The Reported-by tag gives credit to people who find bugs and report them and it
> >  hopefully inspires them to help us again in the future.  Please note that if
> >  the bug was reported in private, then ask for permission first before using the
> > -Reported-by tag.
> > +Reported-by tag. A new feature can't be reported since there is no code in the
> > +kernel to fix.
> 
> How about instead something like "Reported-by is intended for bugs;
> please do not use it to credit feature requests"?

What should be used for feature requests then? Suggested-by? Would it
help to mention it here?

Greets
Alex
