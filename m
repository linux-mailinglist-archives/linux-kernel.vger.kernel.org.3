Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8447980C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhLRBor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:44:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50914 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRBor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:44:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBA1BB82B4F;
        Sat, 18 Dec 2021 01:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0A5C36AE7;
        Sat, 18 Dec 2021 01:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639791884;
        bh=iFHSC+vXydAOODxyaXkmdBf5Q2WYP70elczNwaRfPWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvMS0EjrWI3g74ScgPvmIVs/TyYoFjk6cC6CVdDPbRNrZje7/vWLm+CMPAgSY/dNX
         94KlHYYWldKcv19pBhHvfQTLAHxSGqiwjiuCQqGsOf536SYNa7NUIvgs6EVvyhk+Nf
         P+aEcA1AkPUKirzXacPiNqNSf2tXOM8+YwqyRD203mTNT/KkC0W1OV6+//OUjm2QxM
         FyJBxLAIBLQEKoX+YzI+2HLb40fVyBsvdx00vs2FEAN5KRSv0G+WL2g0dJv3cZWrSu
         uq7huiMTjJtu7v7gpgNLr9tUMneNw08r8cAImP3GA+3O9SE0Y18Y0KEr/nJ+5J+cbS
         2Y8G3qNAVnLIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B26C40B92; Fri, 17 Dec 2021 22:44:42 -0300 (-03)
Date:   Fri, 17 Dec 2021 22:44:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf arm-spe: Synthesize SPE instruction events
Message-ID: <Yb09CrOjq5UoIDOG@kernel.org>
References: <20211216152404.52474-1-german.gomez@arm.com>
 <CAM9d7cjyuJnFmz5vAuZtzGWD6ttG94owfJW4i53x50n8+a=kJA@mail.gmail.com>
 <20211217063413.GA371207@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217063413.GA371207@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 17, 2021 at 02:34:13PM +0800, Leo Yan escreveu:
> On Thu, Dec 16, 2021 at 04:53:45PM -0800, Namhyung Kim wrote:
> > On Thu, Dec 16, 2021 at 7:24 AM German Gomez <german.gomez@arm.com> wrote:
> > >
> > > Synthesize instruction events for every ARM SPE record.
> > >
> > > Arm SPE implements a hardware-based sample period, and perf implements a
> > > software-based one. Add a warning message to inform the user of this.
> > >
> > > Signed-off-by: German Gomez <german.gomez@arm.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tested this patch with perf commands (record/report/mem) and looks good
> to me:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

