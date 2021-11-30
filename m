Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91BC46292F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhK3AlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:41:05 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:39545 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhK3AlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:41:04 -0500
Received: by mail-qt1-f180.google.com with SMTP id l8so18530450qtk.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgwVk16X0tOT5NSJOLn+LfHJOb/YERyJUpEEJC77JU4=;
        b=Tu21pq73TbpWi5gw5rAjEBt7yiLpLwisKT+fZJobynWtWaa0moXDt6unbV6P5sW8kd
         PKS3H6FBJaWDHJ4CkZfzRBMRKVMkONkV/h1KvwGVN2Yd+4T5Fh6v+k2YMeybBRjw7DhL
         J/+nzA3zcRHe1Nxvly2lzcCFfxOJDnLxe+KMhn0nGUxm5DTwh+YZ/NwZiJs3WQptciKH
         +PEQS4Nhd+P4pSbrnRu9xfADZkSuVD4aRU0Zu34edEv/HGTWlvgBwLNks1pIVGnH9xr7
         QlOfWSaLKLaIF5TEaurOxyXdW2f3gcUKJ5aI80sUxDG9cXUB5pSOR8v/iA5pQoA2vtCr
         TJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgwVk16X0tOT5NSJOLn+LfHJOb/YERyJUpEEJC77JU4=;
        b=kh1xDe67WcpocbXj5OhozDr+qjarFFYknsGxO5F3CUukz1nnLbLF/8CNxdlaY6xzoj
         tQAr4P+g0gYOvXVpcIy0LJgAlz23+1sMV4bTjj5B2Ok7tCEOrAds4wwnXYUkRpLO8PYp
         TPiaHzMCxzVVa7IUfDe7yoNy8TVYzgeJFmQmUTQDlvW3S6wjaXaHusLekkb0wvWXfo8C
         Hw22Eb+o1HnwTGnHcNl6mLQXg2MkSOtncq6pyrLHsRcBCam4YBC6FO+erj2MqMwt4ui5
         Ltb+1Mxi7ilaqyOrL092XOUHzTOrmzTz8NIwzHSwrkejPTEFRmlFEzCAxcIqpklO5CGN
         pq8Q==
X-Gm-Message-State: AOAM530UKt6wPlFKYGATHVnuwAiiPFyQJLEGRVGAKapXwpd7aCDa/M32
        C67mPeUnZKalqEPIEXIIvn0=
X-Google-Smtp-Source: ABdhPJwcg05cF3u5IqP8YFO/nvfPUjduJntt4JFGXp5OsMI35r9TFNkH73R5/PzGGFu2T6Dz1m3WDw==
X-Received: by 2002:a05:622a:1a9c:: with SMTP id s28mr38544546qtc.428.1638232605197;
        Mon, 29 Nov 2021 16:36:45 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:86be])
        by smtp.gmail.com with ESMTPSA id y20sm9274131qkj.24.2021.11.29.16.36.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 16:36:44 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     ying.huang@intel.com
Cc:     dave.hansen@linux.intel.com, hannes@cmpxchg.org,
        hasan3050@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, riel@surriel.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
Date:   Mon, 29 Nov 2021 19:36:34 -0500
Message-Id: <20211130003634.35468-1-hasanalmaruf@fb.com>
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
