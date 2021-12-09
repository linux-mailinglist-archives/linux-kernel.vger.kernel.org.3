Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC3A46F6A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhLIWUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhLIWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:20:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEAFC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:16:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id o14so4952502plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwvbU69FuFwHXTmhn/pR+rWJlcg59V5ZNzi0LiQ5GIs=;
        b=oWOkNyDGQSeH4GFBzojprRdPZTihv9oeHgGTvv10HpH4sG4fpUMJDu3gGLhvTtZffw
         D0bCJrvhCmQ8EgAZXX6HgdmR1ZkSYqEFwn62NT+pSyP+nTaVfhnJuxRXOr6MRKBMxVVa
         eCfS23AQ2t0rAx9XK25drA1PMtqzZmY+nCSqdiPXHDD+aA/zVXESH4jM11BVbFegcG2W
         LClGsD6VvmxRF52//hX3VQPPLW2GfAHiqAAT7CzXXsuv3scCtGtt0lq94TBcyWxTZtHc
         xaqkH8+CJieH1jJq//3oeoowQk9POvefkh/c+c7pEepr569Iez+dZRqf9pd1NT7wW+WV
         yWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TwvbU69FuFwHXTmhn/pR+rWJlcg59V5ZNzi0LiQ5GIs=;
        b=tayD72Dxr/b4oosnVGqFBF58CZriyGYnMe7n/O9cfuc+FRpwwkYMtyomnf8nytKV1W
         phsOgewR7lysR1M3Abbd1AI8YN8sJmpdWypdPjK0MC1hjQL+oouA3NZ3aggETXRrAksN
         fWBTO32vbKmaaZ71ZTEx2IDCKIazoizjBhFCCvdave3bzIcdK0HzK+Fr7B2nzrrjGI44
         ybBG2KMW+QQnJfwkgpx3aMXPyvq+hmAOMrHR7ZNFnir5qg5/EqRoHSVWbVmi059oKS8m
         NATS+CkHVOfunrw0LZZSHGR7W6V6Erk5c6ya4nn4fRoSu63XvzPxlq4CznZd0Wkaz7+B
         Qj0A==
X-Gm-Message-State: AOAM531y7juQXJIHk/sUHQ7ja8kpMCCCXtMhZN/TUw8DfCT3Ca+SvBhU
        TXtZTz6vr9ZAvbKzL2tYt+s=
X-Google-Smtp-Source: ABdhPJxhDFM8vH3d1aWFNaAImYeEYD6HNXTwjEi2uYK6aDOAbQfLooHL/eo4wP98OFM/sf3bC46C9Q==
X-Received: by 2002:a17:902:8e87:b0:143:759c:6a2d with SMTP id bg7-20020a1709028e8700b00143759c6a2dmr69661130plb.59.1639088193258;
        Thu, 09 Dec 2021 14:16:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x1sm558997pgh.1.2021.12.09.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 14:16:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 9 Dec 2021 12:16:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 3/7] workqueue: Remove outdated comment about exceptional
 workers in unbind_workers()
Message-ID: <YbKAP8LwwKlcQQpV@slm.duckdns.org>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
 <20211207073543.61092-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207073543.61092-4-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:35:39PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Long time before, workers are not ALL bound after CPU_ONLINE, they can
> still be running in other CPUs before self rebinding.
> 
> But the commit a9ab775bcadf ("workqueue: directly restore CPU affinity
> of workers from CPU_ONLINE") makes rebind_workers() bind them all.
> 
> So all workers are on the CPU before the CPU is down.
> 
> And the comment in unbind_workers() refers to the workers "which are
> still executing works from before the last CPU down" is outdated.
> Just removed it.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied 1-3 to wq/for-5.17.

Thanks.

-- 
tejun
