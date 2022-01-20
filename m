Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B033C4944D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357936AbiATAhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:37:09 -0500
Received: from relay037.a.hostedemail.com ([64.99.140.37]:43874 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1357871AbiATAhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:37:02 -0500
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 5752060300;
        Thu, 20 Jan 2022 00:36:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 2A95A2002E;
        Thu, 20 Jan 2022 00:36:44 +0000 (UTC)
Message-ID: <7e6d37612af05c7c21fc7b06462ccf0da1b8d062.camel@perches.com>
Subject: Re: [PATCH] docs: Update the preferred line size to 100 characters
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Date:   Wed, 19 Jan 2022 16:36:42 -0800
In-Reply-To: <d7130556-a8a4-76c0-0fde-b6b1439efda6@infradead.org>
References: <20220119160642.140e84c6@gandalf.local.home>
         <d7130556-a8a4-76c0-0fde-b6b1439efda6@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.83
X-Stat-Signature: hunt9abibkxg5nqdgs6sgs7bpubdbfxk
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2A95A2002E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18sEW+HDq360VC4B2Ve33z2oG4VjpE/A3k=
X-HE-Tag: 1642639004-641063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 15:00 -0800, Randy Dunlap wrote:
> 
> On 1/19/22 13:06, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > As commit bdc48fa11e46f ("checkpatch/coding-style: deprecate 80-column
> > warning") states:
> > 
> >     Increase the default limit to 100 characters.  Not because 100
> >     characters is some hard limit either, but that's certainly a "what are
> >     you doing" kind of value and less likely to be about the occasional
> >     slightly longer lines.
> 
> 
> Has Linus has changed his view on this since 2016?
>   https://lore.kernel.org/all/CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com/
> 
> Guess we will see.
> I expect that the answer is "be reasonable," but that's subjective.
> 
> To me, it is easier to look below one line for something in context than it is
> to have to scan several inches to the right and then back to the left (or vice versa).
> Maybe I'm alone in that, but I doubt it.

You are not alone.

Reading left to right is relatively easy but for long line lengths
the eye movement to the next appropriate line is not at all easy.

> It's sort of a locality of vision thing.

Yup.

I think this is not a good patch.

The preferred line length should stay relatively small at 80 and not
allow an entire file to be wrapped to 100.

I'd still prefer a warning when any new identifier is longer than some
length like say 20 characters.

> > It's 2022, people are not using 80x24 terminals anymore (well I'm sure
> > someone is, but they are the small minority).
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  Documentation/process/coding-style.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 03eb53fd029a..73be9edffede 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -101,10 +101,10 @@ Get a decent editor and don't leave whitespace at the end of lines.
> >  Coding style is all about readability and maintainability using commonly
> >  available tools.
> >  
> > -The preferred limit on the length of a single line is 80 columns.
> > +The preferred limit on the length of a single line is 100 columns.
> >  
> > -Statements longer than 80 columns should be broken into sensible chunks,
> > -unless exceeding 80 columns significantly increases readability and does
> > +Statements longer than 100 columns should be broken into sensible chunks,
> > +unless exceeding 100 columns significantly increases readability and does
> >  not hide information.
> >  
> >  Descendants are always substantially shorter than the parent and
> 


