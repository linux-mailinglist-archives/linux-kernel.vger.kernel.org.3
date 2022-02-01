Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B34A6878
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbiBAXXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiBAXXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:23:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF904C061714;
        Tue,  1 Feb 2022 15:23:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 615AC6121;
        Tue,  1 Feb 2022 23:23:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 615AC6121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643757804; bh=VvGRRIPndm2N7PsaIeDcTYf2h9W/LL2RsOe4MKKSjcc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rId22cr2qmfBMlQDc2ZGMs+si+cyc36hqX36GeuI+Y+e72cAyqRCRPyyRsTtkOzON
         xKPZy9L7H88BfSOHOmF1niEMeDTWDTfN3NwCRgPm7m9lozjy3Eq5fgVIz+UCVNQZAL
         +drEZr8IMnCnUDhTzs7Je0crwRtUv5p9rUpB8Y7DZSeSHn0lYsUt/YjxQ7e3BvJV3I
         oPXNjWYYOMLNMsSkO4IELxLc8pesi7WNyRIwswD+/CgeW29UZ9RQ6GNAvowrcUYZAC
         5iFLtgWiedYeciq2/a5OwZX8A3HiIkBxyjPPAs1gIx3lYaXYeHdx9t3RYVEwxXsT4G
         aQNhxnzy8theA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v4 3/3] docs: reporting-issues.rst: link new document
 about regressions
In-Reply-To: <978ad91647e93b20b7fe12c3f237f6de8f9eaca1.1643710947.git.linux@leemhuis.info>
References: <cover.1643710947.git.linux@leemhuis.info>
 <978ad91647e93b20b7fe12c3f237f6de8f9eaca1.1643710947.git.linux@leemhuis.info>
Date:   Tue, 01 Feb 2022 16:23:57 -0700
Message-ID: <87bkzq5fxu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Make Documentation/admin-guide/reporting-issues.rst point to the newly
> created document about regressions
> (Documentation/admin-guide/regressions-users.rst). This allows to
> shorten a few explanations the new document describes better and in more
> detail.
>
> While at it move the copyright hint to the end of the file, as suggested
> during review of the new documents about regressions.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 60 +++++++++----------
>  1 file changed, 29 insertions(+), 31 deletions(-)

[...]

> +You deal with a regression if some application or practical use case running
> +fine with one Linux kernel works worse or not at all with a newer version
> +compiled using a similar configuration. The document
> +'Documentation/admin-guide/regressions-users.rst' explains this in more detail.

Some of those quotes around file names are still sneaking in.

Thanks,

jon
