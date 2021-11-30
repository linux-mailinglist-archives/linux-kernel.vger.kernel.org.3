Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A743C46291B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhK3Act (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:32:49 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43790 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhK3Acs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:32:48 -0500
Received: by mail-qv1-f53.google.com with SMTP id j9so16249307qvm.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgwVk16X0tOT5NSJOLn+LfHJOb/YERyJUpEEJC77JU4=;
        b=RMYAUvQIJOZXnvb++JtH/OlZtSIxgeFNZIh4UgIoHA9X3vbyF09SAvmMExFm/fcNOv
         qSYR/aDR6Kn4UIse3B8rhaO3YYti36ARf30+LtcnDf0lsWzaUlRU5kiO4+rypEzl6Y93
         9T0+mjDYvUqsxktng/AkjrJVu1aNlTknn42bfZJ8FhV+0YIf5yseN1exu5/AQK07kznN
         q4vwhfhEJwiw5bLcKCG3bUX3VM4LRmxAXKHjfBVlvtSpdkoqDc0QGXoJfPr3vNgwJBWE
         i33tQ6KskuS54KdP5VI1PMs+OTrMMhaSH7Px1HmGjZnpGt1P0qLd/JoSBpF/ZURp2nme
         mF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgwVk16X0tOT5NSJOLn+LfHJOb/YERyJUpEEJC77JU4=;
        b=6IR8gi9aInanvts0+GBv1DYqMkasH5nzQZDwyX2GUxfCA3Ao6ONW9y6T8yz7t1zjh2
         mkjzRok/2557HrWtHSAx7hOQpWsUYxHYzr/fVWmxMVByZ5KNhnlrMlL2rvwaCOQXcWAR
         gJEhWWRX+F4tKkhjiUeucwRHNEk4lf0FHKG2oZDTt9x9LnKCmASCZqhjjPOlTBepHjsr
         Pecz5qd3rnI3xC4uKNqKYuMQTjyliJcrsjnVETxzr7pSBuiaCyte+5O46OnPVL/EcEVQ
         yWN51anhKAWJBrRtZe2xMyasJ7MD1yYlxfBlSjAgVlk/Lim7rIgDePuvGZaJojhsmyq3
         paFQ==
X-Gm-Message-State: AOAM531GMLPzQr6Xb/KYwjSGBbeL1JJ76NJwesaEecogAxl7GlM6lpfd
        MGnp5MN9VyHXAI5Y/eI0NlIeRekzcdx1pg==
X-Google-Smtp-Source: ABdhPJyaLvjh/yGIzGs4G2UWuV82/ZaC0bn8HyVf/K/DeiTl5uABWiz1VcfBtsjlgcm7yHwnzU2xFw==
X-Received: by 2002:a05:6214:104b:: with SMTP id l11mr33731937qvr.111.1638232110178;
        Mon, 29 Nov 2021 16:28:30 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:86be])
        by smtp.gmail.com with ESMTPSA id o20sm9812078qkp.114.2021.11.29.16.28.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 16:28:29 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     ying.huang@intel.com
Cc:     dave.hansen@linux.intel.com, hannes@cmpxchg.org,
        hasan3050@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, riel@surriel.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
Date:   Mon, 29 Nov 2021 19:28:16 -0500
Message-Id: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <874k812fl8.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

We find the patches in the tiering series are well thought and helpful.
For our workloads, we initially started with that series and we find the
whole series is too complex and some features do not benefit as
expected. Therefore, we have come up with the current basic patches which
are essential and help achieve most of the intended behaviors while
reducing complexity as much as possible.

As we started with your tiering series (with 72 patches), there are
overlaps between our patches and the tiering series. We adopt the
functionalities from the tiering series, modify, and extend them to make
page placement mechanism simpler but workable. Here is the key points for
each of the patches in our Transparent Page Placement series.

Patch #1:
We combine all the promotion and demotion related statistics in this patch
Having statistics on both promotion, demotion, and failures help observe
the systems behavior and reason about performance behavior. Besides, anon
vs file breakdown in both promotion and demotion path help understand
application behavior on a tiered memory systems. As applications may have
different sensitivity toward the anon and file placements, this breakdown
in the migration path is often helpful to assess the effectiveness of the
page placement policy.

Patch #2:
This patch largely overlaps with your current series on NUMA Balancing.
https://lore.kernel.org/lkml/20211116013522.140575-1-ying.huang@intel.com/
This patch is a combination of your Patch #2 and Patch #3 except the
static 10MB free space in the top-tier node to maintain a free headroom
for new allocation and promotion. Rather, we find having a user defined
demote watermark would make it more generic that we include in our patch#3

Patch #3:
This patch has the logic for having a separate demote watermark per node.
In the tiering series, that demote watermark is somewhat bound to the
cgroup and triggered on per-application basis. Besides, It only supports
cgroup-v1. However, we think, instead of cgroup based soft reclamation,
a global per-node demote watermark is more meaningful and should be the
basic one to start with. In that case, the user does not have to think
about per-application setup.

Patch #4:
This patch includes the code for kswapd based reclamation. As I mentioned
earlier, instead of cgroup-based reclamation, here we look whether a node
is balanced during each kswapd invocation. For top-tier node, we check
whether kswapd reclaimed till DEMOTE_WMARK is satisfied, for other nodes
the default mechanism continues. The differences between tiering series
and this patch is the cgroup based reclamation vs per-node reclamation.

Patch #5:
In your patches for promotion, you consider re-fault time for promotion
candidate selection. Although the hot-threshold is tunable, from our
experiments, we find this not helpful to some extent. For example, if
different subset of pages have different re-access time, time-based
promotion should not be able to distinguish between them. If you make
the time window long enough, then any infrequently accessed pages will
also become the promotion candidate, and later be a candidate for the
demotion.

In this patch, we propose LRU based promotion, which would give anon and
files different promotion paths. If pages are used sporadically at high
frequency, irregular pages would be eventually moved from the active LRU
list. We find that our LRU based approach can reduce up to 11x promotion
traffic while retaining the same application throughput for multiple
workloads.

Besides, with promotion rate limit, if files largely get promoted to
top-tier, anon promotion rate often gets hampered as files are taking the
large portion of the total rate (which often happen for applications that
generates huge caches). In our LRU-based approach, each type has their own
separate LRU to check. So for workloads with smaller anons and large file
usage, with LRU-based approach, we can see more anons are being promoted
rather than the files.

I don't mind this patchset being merged to your current patchset under
discussion or any later ones. But, I think this series contains the very
basic functionalities to have a workable page placement mechanism for
tiered-memory. This can obviously be augmented by the other features in
you future tiering series.

Best,
Hasan
