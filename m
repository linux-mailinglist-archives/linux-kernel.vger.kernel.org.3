Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975F0591621
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiHLTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLTwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:52:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C08B441F;
        Fri, 12 Aug 2022 12:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D20FB82530;
        Fri, 12 Aug 2022 19:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31956C433D6;
        Fri, 12 Aug 2022 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333932;
        bh=fNZ6b7o4H3O/gTW0/IKHtVj1M5dS8dBZ3jSGPsjwy7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/iareo2uycNmnBL+a6twGMGl3D48uvM1RnXtOVzQEf+ZzeX5bL26/1vl38RWAZ0a
         SN04/BpDuaKKQq5rZH8gZFYAp/4TRQD5dGbL9P0zAJnvJ2MMfRVJ+QCTt5EZv/9urN
         z2H1hDDggJYkh+Fm8rvlT3PsS0MDK7Nk6sD8B/WCk8h1HU1lyVDCjCy/LhJdqDx0rW
         cvSuolMgvs4cordL/49sT3+dj9x6T+mDerIE3U7XFzrDb12oFEXO5EVyVa656WMsD8
         n7/JHXc+BeEUSVtkVnZwG9HWHWYhVCSQZBP2vvPNhQPBnLgfTxfDBH0pfBT0BLUoI2
         HnynptJ41YwGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6559C4035A; Fri, 12 Aug 2022 16:52:09 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:52:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] perf stat: Remove duplicated include in
 builtin-stat.c
Message-ID: <YvavaYuhZ/VDGG7Z@kernel.org>
References: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
 <CAP-5=fX_2sfYOa+4=28-JKfYoTg9wG3i8MRkGvqc3fLE1R=qYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX_2sfYOa+4=28-JKfYoTg9wG3i8MRkGvqc3fLE1R=qYQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 04, 2022 at 08:32:22AM -0700, Ian Rogers escreveu:
> On Wed, Aug 3, 2022 at 5:52 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
> >
> > util/topdown.h is included twice in builtin-stat.c,
> > remove one of them.
> >
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1818
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-stat.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 3d22543fc305..e326226656e4 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -71,7 +71,6 @@
> >  #include "util/bpf_counter.h"
> >  #include "util/iostat.h"
> >  #include "util/pmu-hybrid.h"
> > - #include "util/topdown.h"
> >  #include "asm/bug.h"
> >
> >  #include <linux/time64.h>
> > --
> > 2.20.1.7.g153144c
> >

-- 

- Arnaldo
