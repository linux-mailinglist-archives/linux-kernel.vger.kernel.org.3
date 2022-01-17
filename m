Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EE3490C86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbiAQQb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiAQQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:31:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413BCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:31:25 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x15so15212897ilc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UgfzTkoWvoIvznmTnwssdnor05qB07oVIv9rYDhQKTw=;
        b=EwGkXKiYdlcp5eUc9AKrnQ9koB+9YPPHIHliSj59oEUKBYWaPYSrMFb8XdWlX+YJcR
         cAwFzGg2CMSRrQRoQ8wa8h1BK9OK49G44qybKz/sZeJJ1nKdFi3mIyaLaX/y5P7FfMiA
         wqQfxMTtrR2RixevRWgIoqQon6moZ6hQQv+DcsM8rtR28FJkC5PFvKbK/02n/cNmOpzF
         Ojj/OTOudwKbfwFSq4wImQaQFCmQGa5WAGHPZF0A9cz5XVY+q2LU3N5OrJX5WEkh1NMt
         TmWeuh2vX0m2H8fsYt6OsXLFNXMZClCw6DaPkDPaMgI6ovKlFwxBDFsL58k9PXVwIZCc
         2Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgfzTkoWvoIvznmTnwssdnor05qB07oVIv9rYDhQKTw=;
        b=SODH4ewbUgJeNfkCJu6Xort131KDpV16objCS5RISGWRq5m1PKxqmAU6lZbas+KxOh
         LSqfwsnD7/+/bfx0vQ8yzKLWY3XAMkd6BEQtogldCdPYK/WI/gRZYZYoyQtorMlZ2OIZ
         fHw56sr6ITt8EWyUKCYFmgPCvqi97OJAJeR8/CrMlRWafDyOXjWTaeaFtEIFQ0PsLEGT
         CKeffgMoav0PBBVOiERYkButRyELHq0B2Kms1yMKkbwBnfFjgGzohicCOXtB7vSet4or
         DJfjhWwAtaREoRWMd/UYQEfDUaBcTjXRoImowZb01lFgc3SCevtEYGsvqB0daPId3MxG
         odZQ==
X-Gm-Message-State: AOAM5310o8hLdu2JYHibD65Y63jpGOaU3waBgw5zQTLgOMcVyetgy0TJ
        Ia9uGgAVarll0u1oy9LcYlScp7XmCb6L4MfDSR33SA==
X-Google-Smtp-Source: ABdhPJwX9RVhMQ1p4iLcCQttEXZztwv0uzu36vIRXDGTxiUyd5NU2hURBRrHoZaJxa8CHEXq+o5J0mmUe+6tBALHbnA=
X-Received: by 2002:a92:dd87:: with SMTP id g7mr11277748iln.174.1642437084482;
 Mon, 17 Jan 2022 08:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 17 Jan 2022 08:31:12 -0800
Message-ID: <CAP-5=fXxwCjcsej5QJMoAz1kvoy5LLKUDMop0GzBMuj8oc3mmA@mail.gmail.com>
Subject: Re: [PATCH] perf cpumap: remove duplicate include in cpumap.h
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:37 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> Remove all but the first include of stdbool.h from cpumap.h.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/cpumap.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 0d3c2006a15d..240db1da370c 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -4,7 +4,6 @@
>
>  #include <stdbool.h>
>  #include <stdio.h>
> -#include <stdbool.h>
>  #include <internal/cpumap.h>
>  #include <perf/cpumap.h>
>
> --
> 2.25.1
>
