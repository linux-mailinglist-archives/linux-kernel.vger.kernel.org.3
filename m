Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E51494B32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359701AbiATJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:56:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:51681 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359683AbiATJz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642672556; x=1674208556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Jt2Js2JOtnvL4mYuFnW/EzkdCTVSihhHWbNkdDiFR8=;
  b=I/K9bIbmw6xDqfj5dYHnlpFuRrdRAMhc0Hvw6qwI2jTD2oFPC9LXioZG
   JqHrzbkdMF++UPpNTGYRydiSRIzzqAxJrY3H/27CQWIrrdDvCcJbWNjjE
   SSmXN84UWyQEeuVg3CyyUgZ4Etu65fvK3uy0sponQKbJA5FjWon3Uvkzh
   YUrNFdysmwA8yyegIgd4fC1wlyMk7J1SpjEm+giSD7tJndDoRQyxJo5Xt
   p166YjBqSn/4ewIa1F6yfpfFSO6xGS3nONJKbqpzf4JVENC7keqOojJlh
   HOCDUYaPhwOctGyKpTjuy5XfuhNX+4V25d62/C6LF8uyGGhHzrksFmLwk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="308651537"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="308651537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:55:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="595700060"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 01:55:50 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 5ACE9203C8;
        Thu, 20 Jan 2022 11:55:46 +0200 (EET)
Date:   Thu, 20 Jan 2022 11:55:46 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: Update the preferred line size to 100 characters
Message-ID: <YekxouspRBkzHpKO@paasikivi.fi.intel.com>
References: <20220119160642.140e84c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119160642.140e84c6@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for cc'ing me.

On Wed, Jan 19, 2022 at 04:06:42PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> As commit bdc48fa11e46f ("checkpatch/coding-style: deprecate 80-column
> warning") states:
> 
>     Increase the default limit to 100 characters.  Not because 100
>     characters is some hard limit either, but that's certainly a "what are
>     you doing" kind of value and less likely to be about the occasional
>     slightly longer lines.
> 
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

As others have already opined, I agree that increasing the line length from
80 isn't going to make the code universally (or even mostly) more readable.
There are probably cases it does but this is not necessarily common.

I think the original text puts it well: there is a limit of 80 but that is
not a hard limit. When reviewing code, I often ask to wrap lines if there's
really no reason to keep them longer (in this case that seldom is the only
problem with the code). Of course you could argue what these reasons might
be. At the very least indentation has a higher precedence that the line
length. This is also written in the documentation.

My view is that this recommendation is not, at least today, relevant for
the purpose of making the code readable for someone with a VT100 terminal,
but a part of a recipe for writing good code simply expressed in units
everyone knows: VT100 terminal size. Also 80x24 is still the default window
size of many if not most terminal emulators.

-- 
Kind regards,

Sakari Ailus
