Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910424709A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbhLJTE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238887AbhLJTEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:04:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171D0C061746;
        Fri, 10 Dec 2021 11:01:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4EE9B829B8;
        Fri, 10 Dec 2021 19:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E7C00446;
        Fri, 10 Dec 2021 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162872;
        bh=zgB+bjKPrWYZ2x6sT/TcpMl0LVsdv1gHVr5Ek+A2J4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjOV1anw7DP7Jb5NvNf8NlFpKkhej9aEG41NheqqLfrIuGJj6hoSQcIVqN5RmZbZ4
         ioc0/SdQ3GrPRJgQL8c72LZmjgPCdGS+/LDi8sNLEkobhFS/2W5avsNjR7MMu+lKjV
         X7hfM5qSRgjTq6ajuzne8HN3yN45tOfCHakUd8VG1+Gm01smZJLI3ZgAMZT0o+eNFh
         WfK7osNfiHxRuJsjzG7QFUbO12LbE8cARtu/59dZHwP7WmEdnUG2+bd1HJJZVDQbvO
         Kpz8Lt7n4DXI0lz4CbPWfuUXIGtAi2dJ6m+oJ8CjrKOu9g/sdW5q2zeymt0DMecNTa
         KAzWslgV3WMfw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A3E4405D8; Fri, 10 Dec 2021 16:01:02 -0300 (-03)
Date:   Fri, 10 Dec 2021 16:01:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] perf vendor events: Rename arm64 arch std event
 files
Message-ID: <YbOj7q+OIM8crbpY@kernel.org>
References: <20211210123706.7490-1-andrew.kilroy@arm.com>
 <20211210123706.7490-3-andrew.kilroy@arm.com>
 <292d3ee6-c8f8-8155-9c90-e05026ea1f76@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292d3ee6-c8f8-8155-9c90-e05026ea1f76@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 01:46:48PM +0000, John Garry escreveu:
> On 10/12/2021 12:37, Andrew Kilroy wrote:
> > A previous commit adds pmu events into the files
> > 
> >    armv8-common-and-microarch.json
> >    armv8-recommended.json
> > 
> > that are actually specified in an armv9 reference supplement, not armv8.
> > As such, naming the files with the armv8 prefix seems artificial.
> > 
> > This patch renames the files to reflect that these two files are for
> > arch std events regardless of whether they are defined in armv8 or
> > armv9.
> > 
> > Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>


Thanks, applied both patches.

- Arnaldo

