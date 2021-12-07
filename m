Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66346BE1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhLGOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhLGOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:51:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC0C061756;
        Tue,  7 Dec 2021 06:48:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5D28CE1AC9;
        Tue,  7 Dec 2021 14:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D43C341C3;
        Tue,  7 Dec 2021 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638888478;
        bh=raY7TDVvO4iQeKqEdPapwVP53dHEH5mYEaAInMVEuqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vK3D3A7o3oTpRUezl8iWzRB0JkKdEjzdRAbrCMssuUkiZayupdqE48ePy3glh27Jp
         lh9jK2nizdgM2AQkdNvFQ/0Zg2rui75jZSyWfnrC2BrC6Fwgr2DjhkLdO2kcKvpvvx
         bIv2p4dg+GA2Oj2I45yvMiRBoNsDJ6dqcbN8sObTfDQPBJm3EnScUiIKIWjXhN+xDQ
         bsQ7vX/T7po7U+kfX+5vKq+mzHreW02SkyIxjKbHHQ9y+rEAeop+82ynltcarhMMYO
         F6dcYliKgKzFTmcKdHetyzInVTOvOX6+ke4bX3Bp1IoTu5Mrho4/z3ZFOCnHo94KuR
         +JSZVFqOWcXNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E81B406C1; Tue,  7 Dec 2021 11:47:56 -0300 (-03)
Date:   Tue, 7 Dec 2021 11:47:56 -0300
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
Subject: Re: [PATCH 2/3] perf vendor events: Fix whitespace
Message-ID: <Ya90HDV9HHTANmkx@kernel.org>
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
 <20211203123525.31127-2-andrew.kilroy@arm.com>
 <aabc45c7-cea4-2e8b-bddc-7ea1bd18910f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabc45c7-cea4-2e8b-bddc-7ea1bd18910f@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 07, 2021 at 09:36:40AM +0000, John Garry escreveu:
> On 03/12/2021 12:35, Andrew Kilroy wrote:
> > Correct indentation to 4 spaces, same as the other json files.
> > 
> > Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> As an aside,  maybe we should improve the parser to find these inconsistencies in formatting.


Thanks, applied.

- Arnaldo

