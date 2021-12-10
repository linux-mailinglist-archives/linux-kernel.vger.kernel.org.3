Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11088470904
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbhLJSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhLJSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:43:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24442C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 10:40:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E57ACB82955
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBF3C00446;
        Fri, 10 Dec 2021 18:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161604;
        bh=Di6M3NSnLtTaJP2yl9ivYDFdFYD37x5cmTWueRIoCAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWCrcY7kYz14xz8wHuYBnNhtqN76Iaqyv5ZBmRRXtU1NlQw1/J48S2xR9uxgzIkc6
         /Qbdb+Ca6/WQ57l+q2OGzC3pG7HP2aWkp/Ac1H7LwFBa3aZGGiwc/mQvus9Ab14uBn
         Mnz5ydMvXpKHW1PZkcByHHHxAGWu87066aaI4OmfLfYGClhfV2QeOnUDgIpbZ8Hkg9
         8irwKcXhBDrnt8XSP8DogJ+DYoyZd1WLxTj2w0qCYrUVYyjKB91O3/rGqufKWvqeRR
         SCBpZs4l3jY2Pcry8bgJ+ynwo/zMLrgQB6CkN16yRcEf/I0F54Q8YGl5jDX74O6+I9
         3miJAUh4pbS9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74EE6405D8; Fri, 10 Dec 2021 15:40:00 -0300 (-03)
Date:   Fri, 10 Dec 2021 15:40:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] perf intel-pt: Fixes
Message-ID: <YbOfALOv1L5AYk9g@kernel.org>
References: <20211210162303.2288710-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162303.2288710-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 06:22:56PM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here are a few fairly small Intel PT fixes. Backports would be needed
> to apply before v5.15, so the stable tags reflect that.
> 

Thanks, applied.

- Arnaldo

 
> Adrian Hunter (7):
>       perf intel-pt: Fix some PGE usage
>       perf intel-pt: Fix sync state
>       perf intel-pt: Fix intel_pt_fup_event() assumptions
>       perf intel-pt: Fix overflow state
>       perf intel-pt: Fix next 'err' value, walking trace
>       perf intel-pt: Fix missing 'instruction' events with 'q' option
>       perf intel-pt: Fix error timestamp
> 
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 85 ++++++++++++++--------
>  tools/perf/util/intel-pt.c                         |  1 +
>  2 files changed, 56 insertions(+), 30 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
