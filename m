Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE84ED545
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiCaIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiCaIQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:16:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A21A818;
        Thu, 31 Mar 2022 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsP+IlSxkL6NqvmArcUcnZSFybZOrqNvIwp1wgxlJIk=; b=bMyiaHaMN75EELHxtOPozcytje
        4mR6+DKXg5nGbvJz+LCHWyRTSQj5FtRPk+9fPKTRB/YWeXnT7ELAMnzzKqEZ+vdYlsjCe/2jaMUBx
        u9+oLraRrNsLGR+VbTmGpdtHrVVa+oOcIpDj20PBKajoAcuJV32ZPAQ6R5yMLjd/oieN2Jph2nPC/
        /idfbV9iJI8w547jEKWLeqfGRr7fhb3755KXKnsmwsdvolNbv90nJf7E2j6yj4uvxaU7C60sjXm4P
        WxqjADp849Kof3CgS28laWtVcWxQZQn/aBvZfgz9yc7hr4ysOZziw3bBPjSKHcgk2bTACUT07NHXG
        ZRNb4Z3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZpwS-006PsI-JO; Thu, 31 Mar 2022 08:14:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BC9D98695C; Thu, 31 Mar 2022 10:14:01 +0200 (CEST)
Date:   Thu, 31 Mar 2022 10:14:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v4 0/4] perf/core: Fixes for cgroup events
Message-ID: <20220331081401.GR8939@worktop.programming.kicks-ass.net>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 11:45:19PM +0800, Chengming Zhou wrote:
> Chengming Zhou (4):
>   perf/core: Don't pass task around when ctx sched in
>   perf/core: Use perf_cgroup_info->active to check if cgroup is active
>   perf/core: Fix perf_cgroup_switch()
>   perf/core: Always set cpuctx cgrp when enable cgroup event

Thanks, queued for post -rc1
