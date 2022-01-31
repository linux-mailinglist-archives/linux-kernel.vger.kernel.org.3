Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0134A5242
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiAaWVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiAaWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:21:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADAC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:21:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 190A8B82CBE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4CCC340E8;
        Mon, 31 Jan 2022 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643667673;
        bh=8qMR6brikdgeVt/6tuePPh0LX5UMZ/856Zhi1gbN+ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sG+RHJaU+chKiMncxD6MaAr4hhWObMKDUcCgkTdTyZpihVAgdWML4X6DeP8yMoDMY
         /pk4B89xl6cpZGPF5/ysuxRKaGyej3MKFUKxtaYPJmIY5dyXGuST729yeAUPfQAolq
         dVwDR9eqEy0Ya9Nux3Bmkn37O2X//CHTWZgtjqI8pxs3oKepDVIES26ZiXYZ+vBXW6
         r395tSBUphpE5uA5JmbkVPG5ERFSHbTD506mW6fzOBL7qM96geGFE0KqlI7qYZwYa6
         kqwYeojs2vlYVPbUAmNg1UbV3Sd2I2LYCrv9j72hPRz1Vn9Ws3DiPqyvldpkxykojH
         2WaOjcEzMUQEg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0A2040466; Mon, 31 Jan 2022 19:21:11 -0300 (-03)
Date:   Mon, 31 Jan 2022 19:21:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v13 03/16] perf record: Introduce thread specific data
 array
Message-ID: <Yfhg1zH9rQ3lBP9N@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <YfhXG5yEHhrGDjvl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhXG5yEHhrGDjvl@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 31, 2022 at 06:39:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> Some changes to reduce patch size, I have them in my local tree, will
> publish later.

Its in perf/threaded at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Will continue tomorrow, testing it and checking the speedups on my
5950x, I think the things I found so far can be fixed in follow up
patches, to make progress and have this merged sooner.

I'll try and add committer notes with the test for some 'perf bench'
workload without/with parallel recording, something I missed in your
patch descriptions.

- Arnaldo
