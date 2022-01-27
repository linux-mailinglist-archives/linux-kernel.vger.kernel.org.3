Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6B49E8D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiA0RV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbiA0RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:21:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B71C06174A;
        Thu, 27 Jan 2022 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=++lt+r3Y4bab0BW17JDv/wIUj9g0zt5v7cL/jioKeD0=; b=czZbjO7aOmG9ULVsiPLq0AKYyk
        8qBtfGEiLrKZBGqIHHOzsEZA2c5rbVMKc5G6FbwhDyE3oV4TBssSL9yj5tfHR1ObUh+x1o9qglJ1V
        mYCQ0I0lkGHUl7RaK9paMq7G66fkz7KefVBUqlvb2qpCKTUjRsRGpoHk1LF2RYE4UsX1g3j+Hgfpf
        ytc9McdcWB8PJpHiZOCUGw1lGLIkgQuxBi4GMoW3NCXa3PmW9aXD7CjbS1M1OuH7FQvpno3S4L8U2
        DFszPJcNd4jvHawf813oPG/SoUqbSxiZvXuzF5+IgrcHre7f/D6/fFV7wF0NbM2lPnuZNZF4PA5uT
        zuGNJhgQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD8Sd-005Snl-3S; Thu, 27 Jan 2022 17:21:27 +0000
Message-ID: <1e2e99f6-e9bf-7d93-9629-3d70275c77f4@infradead.org>
Date:   Thu, 27 Jan 2022 09:21:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Florian Eckert <fe@dev.tdt.de>
References: <20220127163258.48482-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220127163258.48482-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/22 08:32, Andy Shevchenko wrote:
> It's unclear from "Submitting Patches" documentation that Reported-by
> is not supposed to be used against new features. (It's more clear
> in the section 5.4 "Patch formatting and changelogs" of the "A guide
> to the Kernel Development Process", where it suggests that change
> should fix something existing in the kernel. Clarify the Reported-by
> usage in the "Submitting Patches".
> 
> Reported-by: Florian Eckert <fe@dev.tdt.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rephrased as suggested by Jonathan
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 31ea120ce531..fb496b2ebfd3 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
>  The Reported-by tag gives credit to people who find bugs and report them and it
>  hopefully inspires them to help us again in the future.  Please note that if
>  the bug was reported in private, then ask for permission first before using the
> -Reported-by tag.
> +Reported-by tag. The tag is intended for bugs; please do not use it to credit
> +feature requests.
>  

LGTM.
Although it could refer to Suggested-by.  :)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

>  A Tested-by: tag indicates that the patch has been successfully tested (in
>  some environment) by the person named.  This tag informs maintainers that

-- 
~Randy
