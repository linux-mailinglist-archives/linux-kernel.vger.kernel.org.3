Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259AA496DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiAVUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:16:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35176 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiAVUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:15:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDD02B80AD7;
        Sat, 22 Jan 2022 20:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55593C004E1;
        Sat, 22 Jan 2022 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642882553;
        bh=S8xrHwYwZk79eQ+RDxQMDrtwZJSz9IW+n5Un7rxCUsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkAwb0PSCsWEW7IfjBNh6z/Q9kYbJQkZVgzpojQyJx6sK5gWmKxyu9P3blyqKQWxB
         6d+jwr8cxMeBzrc+CVz97zQHWoBXqC4TGJ/5uMrYSwmVNdrC70oAeDA9wxbM36KCsA
         fXgFmvyoPG30v0sCf0RWUbfGe6zT9/VjaLNUxEnR/hPwhbkZc8LgiDdzgDk/brtpDb
         9XkpIfHRe2c+5fVICyxl4lLhk3nU22aMEyWtdjqMgfdl+zMSX4Y8QW9mhM+7zH/+og
         m8sjvN0UZp1pdJHLwzBZzQ1pW9s1AuVIeQ2bv89roLu6AIX5YTfc9r4XH926sNdBe+
         2SjHwOKF8j5lQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E08F40C99; Sat, 22 Jan 2022 17:13:51 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:13:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     cgel.zte@gmail.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] perf cpumap: remove duplicate include in cpumap.h
Message-ID: <Yexlf2Fuk6BZVuzp@kernel.org>
References: <20220117083730.863200-1-lv.ruyi@zte.com.cn>
 <CAP-5=fXxwCjcsej5QJMoAz1kvoy5LLKUDMop0GzBMuj8oc3mmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXxwCjcsej5QJMoAz1kvoy5LLKUDMop0GzBMuj8oc3mmA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 17, 2022 at 08:31:12AM -0800, Ian Rogers escreveu:
> On Mon, Jan 17, 2022 at 12:37 AM <cgel.zte@gmail.com> wrote:
> >
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> >
> > Remove all but the first include of stdbool.h from cpumap.h.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/cpumap.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> > index 0d3c2006a15d..240db1da370c 100644
> > --- a/tools/perf/util/cpumap.h
> > +++ b/tools/perf/util/cpumap.h
> > @@ -4,7 +4,6 @@
> >
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > -#include <stdbool.h>
> >  #include <internal/cpumap.h>
> >  #include <perf/cpumap.h>
> >
> > --
> > 2.25.1
> >

-- 

- Arnaldo
