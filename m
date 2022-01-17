Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254E0491180
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiAQV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiAQV4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:56:13 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D9C061574;
        Mon, 17 Jan 2022 13:56:13 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6CDEF37D;
        Mon, 17 Jan 2022 21:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6CDEF37D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1642456572; bh=7yulRf+1yVRR69nokC8IcrGxd2577u/Uh5ZlrWl9hB8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gr+xCgrSoJcTg/ytKhrG0GBFVn1tY3nEFvGubzrFg3FuZlojtrogdO/NlJ4wyj75W
         84rPpwtOxm9izeYalEUVLb+nS5heagjiIsbo2yu05NviDD7K/vLJRCxfYxCSvxVNru
         TSl+FfYXCPisOliEOxEYYGaV8ZyUw6nJ5wNLDekInCvDZ/0UGLHCYidHvRimNTSIoo
         tFHIkzGQZQoAdR8kx3oZLSxEmpw5E+m44B9tVVz60IdFS+1zWLE7+Xs89/L99U18L3
         THI6mZAbtU7Mg5WIJ1PAz6ncnjP4yyw8tQgkqbdcFfaVLiTJSkSWmG4RTEoJ6iUsTK
         n7AsLwLEf1zjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Huichun Feng <foxhoundsk.tw@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: Re: [PATCH] docs: ftrace: fix ambiguous sentence
In-Reply-To: <20220111052000.2675944-1-foxhoundsk.tw@gmail.com>
References: <20220111052000.2675944-1-foxhoundsk.tw@gmail.com>
Date:   Mon, 17 Jan 2022 14:56:32 -0700
Message-ID: <87fspm3u27.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huichun Feng <foxhoundsk.tw@gmail.com> writes:

> The sentence looks ambiguous, rephrase it by adding ", there".
>
> Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>
> Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b3166c4a7..45b8c56af 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3370,7 +3370,7 @@ one of the latency tracers, you will get the following results.
>  
>  Instances
>  ---------
> -In the tracefs tracing directory is a directory called "instances".
> +In the tracefs tracing directory, there is a directory called "instances".
>  This directory can have new directories created inside of it using

Applied, thanks.

jon
