Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B02046B2B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhLGGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLGGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:08:45 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFAC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 22:05:15 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o17so13358800qtk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 22:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQOzS8BVhQngVP+oTiWyWNJRrUwIkaNZ0R7LTwmPL7Y=;
        b=U5ltEzk9JX7crR8EeWwBpvgEpfb7gsdsLo0ZhDWLLso0rSoQ74EMmGO1/2cPeC0TLD
         977PZ73in1p+m5UuJZipvR12R4I1I0+eMpVgLT9F722/VASU1cyW4PWPBep2rZlQfg0M
         UMqAKTOtandU+K7oELK8LFYqYVxM3HNAtoK+7spn4XRQmqwYhWF10U0IvdhDNr7Wu8sp
         Ba5eAW+X67oydvBw6aR0joPlCDv1Qcyvs/7699Arp3GZruGvlCLfZt+EsrizU73tTkIA
         BT9Nzx1yp0zBbXX27h8/9UdHEE0TG9xxbzmm2ZQKwF0iLwBtPFuj1Nmnt/jwq1ltLuD9
         u9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQOzS8BVhQngVP+oTiWyWNJRrUwIkaNZ0R7LTwmPL7Y=;
        b=qjqDhx0ATtJHLOOVK+rx4QoQ1IR/nvGcWcj07Hfsv4yC+2bGt+Rnxhdn3q2t7KeBBO
         OSas+q2HCkBlKdeEy+1P1lj2h3chR6b5j4lnwdL5LfaSGIzUUNZ9nm+OP/jgjawIrDHN
         2+mqHx3CCzyM8gLr5gMf1YNBG4ndgoyQqm99omA+eYgUEazwwAl7HlNCTlPyctqlnrcH
         ZnpuF1DQTa0k0/Up9LSnZuSlHjeBW9U6XzQ1X8j1aD65Y9Ji85RIIauKX6suW9elAiHW
         1rm/wVyAkaq9s20f9vq2iLvlDG+hDNILJZ1Lys1efM8Xnvte3K2TdwEWaO9vER168s1Z
         jf1g==
X-Gm-Message-State: AOAM531NVCRd/39q+wvKMXMImvZDWUrzSneaS2Dp1fMyK6EeBi+Hp5zO
        sFt8MV/EJeWn/kmK1q7ELcM=
X-Google-Smtp-Source: ABdhPJy3bmAKjNsJ0mUglSNW4i1NkdtXBx6TYdt1VpYeF4kaqQj/BOL35Rn5kqN+xrbzfzPyTODWZA==
X-Received: by 2002:ac8:7c41:: with SMTP id o1mr46450028qtv.53.1638857114292;
        Mon, 06 Dec 2021 22:05:14 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:6fa5])
        by smtp.gmail.com with ESMTPSA id j126sm7618569qke.103.2021.12.06.22.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 22:05:13 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     ying.huang@intel.com
Cc:     akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        feng.tang@intel.com, hasanalmaruf@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
        mgorman@techsingularity.net, mhocko@suse.com, osalvador@suse.de,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        shy828301@gmail.com, weixugc@google.com, ziy@nvidia.com
Subject: Re: [PATCH -V10 RESEND 1/6] NUMA Balancing: add page promotion counter
Date:   Tue,  7 Dec 2021 01:05:09 -0500
Message-Id: <20211207060509.79442-1-hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207022757.2523359-2-ying.huang@intel.com>
References: <20211207022757.2523359-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

>+#ifdef CONFIG_NUMA_BALANCING
>+	PGPROMOTE_SUCCESS,	/* promote successfully */

I find a breakdown of Anon and File page promotion can often be useful to
understand an application's behavior (i.e. what kind of pages are moved to
remote node and later being promoted). What do you think about adding
counters for such a breakdown?

What's your thought on adding counters for failures on different reasons?

Best,
Hasan
