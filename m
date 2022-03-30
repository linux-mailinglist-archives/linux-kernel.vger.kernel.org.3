Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6E4EBF70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiC3LDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245740AbiC3LDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:03:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D986DF70
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:01:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y10so23920981edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:organization:content-transfer-encoding;
        bh=W97zjKC2lKisGi/T+P9tuQtL3d342tRx+Re6fZFpdes=;
        b=yhC8Ax47LLwUnw5G7sWigAU0D2M2BujjqMg9x1HpVTVTYNdK2SO8xLTDcBOrNHJEvI
         o6QeIHUnC3XfSL636iB+2jfgCojUo7HnMFpMWSr8n89KT0qNOWzSs2iWs8qZ5UaQZsze
         IRscB2btaK9fHLzCHVSa7jVDrQh81Rjdon+uOLJVAN8ef+0+psitrc8PxGje/ZGUF1Hb
         IgNxzUA4ImXOGezUOKWMksl2B0FKR1+rrtRxbR5lKNSwRS9bz5OgwMngrYYdj9jE0sLE
         8Kqi/ttFsUtkjpok3xnxIyNMUsmsmLYg8//DtDM0i+PkAM6XUzJ4yfJM0D44G12jFdLC
         XCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:organization
         :content-transfer-encoding;
        bh=W97zjKC2lKisGi/T+P9tuQtL3d342tRx+Re6fZFpdes=;
        b=79XKFEWkPKxdJ+4OSqHG/Hnj9iL4I8x0XHHYGVVwt1LvNkCUQ0VTuoo8mzqWrG36RI
         UjikrtdEXj1a/W3Z1WHWScl4W/yhuU1QBSax+4kFRWN1fKV9fBFhQsrgxP5X8NymmNL4
         j6KJtIYUIV+DrM48PpIOuRj6R1dABBZ/y6l6BoRxTOidN3Q46qMVk07WtCwVmb3iL/fS
         Yjf6ioo0+ZqGEys+ftgOq0ytPk4AN/DT6XKcMHZqDSIAit4N0UdjmfRXZPz8nDcktfxM
         iz+ad43InJvcITlezvUoPLQtQNbXDfI09BD8QioPRCDsQ7lY/cMinXggibKdkUSOAyXD
         QEKQ==
X-Gm-Message-State: AOAM530mab26XT1ZJgzQVfPJh2kC6kXLWMNnpYQBPe2KRANrpVxpK5Cv
        eF1xucKw1uno2iHRapCjo7ztNA==
X-Google-Smtp-Source: ABdhPJw54DP98AE/Bsyi8eXeZZBKyfRIXL4lJNgvsVS/YneOVLUEM0wW6MYow1I1OCPDofMMaL27/A==
X-Received: by 2002:a50:fd04:0:b0:419:9c4a:7d79 with SMTP id i4-20020a50fd04000000b004199c4a7d79mr10015639eds.99.1648638083603;
        Wed, 30 Mar 2022 04:01:23 -0700 (PDT)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd7dee980sm8120744ejc.30.2022.03.30.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 04:01:23 -0700 (PDT)
Message-ID: <bd95a0f0-5589-2d9e-8fb0-a66322e556e4@scylladb.com>
Date:   Wed, 30 Mar 2022 14:01:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Asias He <asias@scylladb.com>, linux-kernel@vger.kernel.org
From:   Avi Kivity <avi@scylladb.com>
Subject: sched_min_granuality_ns exile into debugfs
Organization: ScyllaDB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


In 8a99b683 ("sched: Move SCHED_DEBUG sysctl to debugfs"), you moved

sched_min_granularity_ns to debugfs, citing that it is debug-only (true)

and undocumented (it is documented in sched-design-CFS.rst, under

the old name).


This breaks my application, Scylla[1]. We use sched_min_granularity_ns

to reduce the chances that a high networking backlog will starve the

application thread. It is a thread-per-core design, so we won't find another

core for the application, they are all busy (and besides, the application

threads are pinned).


In addition to sched_min_granularity_ns, we also tune a few other

sysctls:


# Prevent auto-scaling from doing anything to our tunables
kernel.sched_tunable_scaling = 0

# Preempt sooner
kernel.sched_min_granularity_ns = 500000

# Don't delay unrelated workloads
kernel.sched_wakeup_granularity_ns = 450000

# Schedule all tasks in this period
kernel.sched_latency_ns = 1000000

# autogroup seems to prevent sched_latency_ns from being respected
kernel.sched_autogroup_enabled = 0

# Disable numa balancing
kernel.numa_balancing = 0


While we can adapt to the move, I would much prefer it if the old location

was restored. I think it even makes sense to make this a non-debug tunable;

it helps to application to be more responsive without using the realtime

class, which is its own can of worms (and will likely result in reduced 
throughput).


[1] https://github.com/scylladb/scylla

