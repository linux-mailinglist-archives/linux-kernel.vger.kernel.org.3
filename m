Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E04733D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241805AbhLMSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:18:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52066 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbhLMSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:18:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC40AB8120F;
        Mon, 13 Dec 2021 18:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70716C34602;
        Mon, 13 Dec 2021 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639419529;
        bh=uNmf5NWVYUtNQ8nh5+KS4K67JFhPM7HjDGgf0WnTdWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHtP84tBhprZ2fc90bhFRo6O9ygxBUuEusx2rYdLlVwRrltRIVFWzqJ65JBMH1NCr
         WXshnuigxHn1PVa3UIIH/WUqL9F9VYnxSMH+SSWwMDRhE8ruAS9OhJGXz9mGXqEmU/
         fypFGHHtFYIhKDZ0yPiSV0MIVdr/dYpFqc/+KdWcxQk7z3hg22bhlTJF9MUn66BniX
         FMrZbCRRcX6BM1U3wo9w4PbLijvLiasm5+4vAVTsC6oU5KHa/LbJCVoAd/m7mj1jPs
         C6JtVIM5yRBwP/i3JvVyMXtl6Qh901+m8RDvVI/TSAIEmrFqVSInotjT4vZFOTLvHl
         zCTeCBxpPa2dw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4BB16405D8; Mon, 13 Dec 2021 15:18:47 -0300 (-03)
Date:   Mon, 13 Dec 2021 15:18:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] libperf tests: Fix a spelling mistake "Runnnig" ->
 "Running"
Message-ID: <YbeOhwfDoxYfICRP@kernel.org>
References: <20211212222122.478537-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212222122.478537-1-colin.i.king@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 12, 2021 at 10:21:22PM +0000, Colin Ian King escreveu:
> There is a spelling mistake in a __T_VERBOSE message. Fix it.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/lib/perf/tests/test-evlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 520a78267743..e7afff12c35a 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -535,7 +535,7 @@ static int test_stat_multiplexing(void)
>  				    (double)counts[i].run / (double)counts[i].ena * 100.0,
>  				    counts[i].run, counts[i].ena);
>  		} else if (scaled == -1) {
> -			__T_VERBOSE("\t Not Runnnig\n");
> +			__T_VERBOSE("\t Not Running\n");
>  		} else {
>  			__T_VERBOSE("\t Not Scaling\n");
>  		}
> -- 
> 2.33.1

-- 

- Arnaldo
