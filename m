Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14D349E70A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiA0QHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:07:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:52000 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbiA0QHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:07:36 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C202F2D5;
        Thu, 27 Jan 2022 16:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C202F2D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643299655; bh=rQeVCu4PDNsyGpc74Exoe0ByVIF33X+J4U9OePlxRCM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OzgaTzFZPZFjL0IYa7oQO5S4uncY9TYHSkGRSLC4qLx1bVUT8GkSg7+P96uadNkL9
         AE7u199u8VUztM0ND1vDVqGRbfPUYtT/9AcdHG+39ZgL0WiZgn/x6Q5nmVIrw9bULx
         kugK7lt6LvXlLjMqlOadoARb7YHIk7Kjui78jJ7p1DOi0H0JsXp9XLYhxRZrN1Va1V
         VVkBFZHigc8Q+D+Ob0nJlucR9nQzKVQ520/jrz1mWuwsyAgJqEf6GQsi9MSBXibmeK
         DGE0WvHigUXjT14eIraZJRAG21/77byQkExAtSNRyBo2psVI4j2JdVKeBkufVFYL+n
         t4YpsSs30er5A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
In-Reply-To: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
Date:   Thu, 27 Jan 2022 09:08:06 -0700
Message-ID: <87o83xrwk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> It's unclear from "Submitting Patches" documentation that Reported-by
> is not supposed to be used against new features. (It's more clear
> in the section 5.4 "Patch formatting and changelogs" of the "A guide
> to the Kernel Development Process", where it suggests that change
> should fix something existing in the kernel. Clarify the Reported-by
> usage in the "Submitting Patches".
>
> Reported-by: Florian Eckert <fe@dev.tdt.de>

You're sure this added documentation isn't a new feature that shouldn't
have a Reported-by? :)

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 31ea120ce531..24c1a5565385 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
>  The Reported-by tag gives credit to people who find bugs and report them and it
>  hopefully inspires them to help us again in the future.  Please note that if
>  the bug was reported in private, then ask for permission first before using the
> -Reported-by tag.
> +Reported-by tag. A new feature can't be reported since there is no code in the
> +kernel to fix.

How about instead something like "Reported-by is intended for bugs;
please do not use it to credit feature requests"?

(i.e. I want the shed in green :)

Thanks,

jon
