Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15849435C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 00:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiASXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 18:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiASXAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 18:00:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94AC061574;
        Wed, 19 Jan 2022 15:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=69M6KMphEDIUOUxds36xj+F/fkNqq7cJu1oHQj03tXo=; b=oMSVG2gAzAEGFzNYEkSw1n6ZeN
        9t2IPI55TogrWuTYu5ev1LLx/5LuLBgyVrxogr4vVdpGsWC3bUzfjE3lRXz/G6wzKc0TlEnNV5UuQ
        hRx4Le1cwlOx1HUcv+l68rSk/suScwTEvs/LAwTxm4pYpLNLJF146YwvZDHdVpFlcYwJs13lBTZgo
        YZaMhrn3KbC1scHsGPEzLQpBTZIeHkzbjpWelg0iyi/TmIV6bAIn2WEmfB4uDm/m0vOZgZq2m1cre
        wRe+LbEHx7e57C/0jZcWrBOdfVSa4d9ZhaPZcB+EnXVodck2bgKV1elQqusOgiTvxBmBvK0zjButG
        GWZ56x8Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAJw7-00CX3s-6f; Wed, 19 Jan 2022 23:00:15 +0000
Message-ID: <d7130556-a8a4-76c0-0fde-b6b1439efda6@infradead.org>
Date:   Wed, 19 Jan 2022 15:00:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] docs: Update the preferred line size to 100 characters
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220119160642.140e84c6@gandalf.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220119160642.140e84c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/22 13:06, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As commit bdc48fa11e46f ("checkpatch/coding-style: deprecate 80-column
> warning") states:
> 
>     Increase the default limit to 100 characters.  Not because 100
>     characters is some hard limit either, but that's certainly a "what are
>     you doing" kind of value and less likely to be about the occasional
>     slightly longer lines.


Has Linus has changed his view on this since 2016?
  https://lore.kernel.org/all/CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com/

Guess we will see.
I expect that the answer is "be reasonable," but that's subjective.

To me, it is easier to look below one line for something in context than it is
to have to scan several inches to the right and then back to the left (or vice versa).
Maybe I'm alone in that, but I doubt it.
It's sort of a locality of vision thing.


> It's 2022, people are not using 80x24 terminals anymore (well I'm sure
> someone is, but they are the small minority).
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/process/coding-style.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 03eb53fd029a..73be9edffede 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -101,10 +101,10 @@ Get a decent editor and don't leave whitespace at the end of lines.
>  Coding style is all about readability and maintainability using commonly
>  available tools.
>  
> -The preferred limit on the length of a single line is 80 columns.
> +The preferred limit on the length of a single line is 100 columns.
>  
> -Statements longer than 80 columns should be broken into sensible chunks,
> -unless exceeding 80 columns significantly increases readability and does
> +Statements longer than 100 columns should be broken into sensible chunks,
> +unless exceeding 100 columns significantly increases readability and does
>  not hide information.
>  
>  Descendants are always substantially shorter than the parent and

-- 
~Randy
