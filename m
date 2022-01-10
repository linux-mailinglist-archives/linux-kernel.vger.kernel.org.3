Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAF489D24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiAJQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbiAJQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:07:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B48C06173F;
        Mon, 10 Jan 2022 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B6V65xnVE+/ksl9Jg9xACdnGIOxOGXV3q9QJQLCOkuU=; b=RgcH6DWTW1PbwRaIAMDLji5Oyv
        oa86BLd/mI3oc0gTa4yjMojxl071NbJEC9ozQmQ/caW3fuLgBfBa93IFBKmscMnEKlAkeiDMbMNCF
        DPam5YHSzAbQ7OJL8InJ3OVxSe63Rz9t3q5j2GHbW5hwpYqfnx+Kz1qqKvTNYGblVK7Qt5eCb/QiK
        83C5FEKWwMCtGnLqfKENX/cUtRGwpm/1jI2ErwRLtygHZ+0ZQbcQewuPqOo4RjeP9GxJIPYurBIHx
        UC93LZgjBF95XtCWUEOkuXQXydj87l5lju9cbQkDUf7nPqNCyHhVOm2o4epPdyeSgogs9HbecafoT
        ZX55gZcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6xBp-000QCH-48; Mon, 10 Jan 2022 16:06:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58214300079;
        Mon, 10 Jan 2022 17:06:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3489B20244CDF; Mon, 10 Jan 2022 17:06:30 +0100 (CET)
Date:   Mon, 10 Jan 2022 17:06:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <YdxZhsQ2NQ3dpUVR@hirez.programming.kicks-ass.net>
References: <20220107025212.177040-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107025212.177040-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:52:12AM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calculation.
> There is no functional change in this patch.

Why ?!? This makes something that was trivial to read into something
weird.
