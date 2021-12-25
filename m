Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E262647F196
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 01:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhLYA5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 19:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYA5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 19:57:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA955C061401;
        Fri, 24 Dec 2021 16:57:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id mj19so8706601pjb.3;
        Fri, 24 Dec 2021 16:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuXYWh4++SJmPwpnU9xEwsXfzzE1IjvMK2Lt9SAVUYw=;
        b=Veanz8KHkiJeCda93YvcURxjzL7nz9RQtY7qiI+Nbr785i2CWj6KKdVywHvp77jPTs
         2wS3HHloHFfgIRwRRrSGQFVLRB8n5aOtgmWVGFZbW96pXi85bSOp0SI/705SQa5UnA7Q
         vsCV6q3d2Z9KuU2Iz7kvIZ54P0xtMtLVRXWl6H+VcoWAVFyoyBl/PiZxL/AOlsCXybq5
         yC6Z4qiBfEopCweEWJ6V+Up7tFLoDs3bhKC9l+kFY9OXIEBKOFlN5qfbCP5IROnzTR59
         FSzLDarLtwyTK31Kb8DW0HgFt0TpGLtAWMwfN6zwFt+2fYr9bpdz6Rln14Nfyg6vavve
         gQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kuXYWh4++SJmPwpnU9xEwsXfzzE1IjvMK2Lt9SAVUYw=;
        b=A3evWO820BAcG7u6cw1Sm361btkAE+pdmKvBm4jMNATPSVi7ApAdD895+RNZtCvFdN
         MTYYOf7PB08jZRhwKPzxiic/Lj7dTqE/AWe3Gjb7+gx8/vgQKgaGYz36c4Tacsn2BX/S
         jj7KjFYecVY2e8poESqtSA6shN/n1qKFxOYx3a9djJFWrJ30Ys8/sB7rJdeek+DjBjWI
         Hvf2MWcmEhaL+e5FXRcTFJpqF/oXBE91Q4WF+s7PwOHP3jAo9RiQa40b3GFA5u+VmfCk
         S/wbIzX12h9CMlPRW6geiwnjpzAaJFflDo6lbkxk2Lug/OOr6C3Sr0/P/DxDuTGBLXrR
         fX0A==
X-Gm-Message-State: AOAM533b7D8HlGxuAEdlz8LGE99QCHIOKfOFm+D6T3XdHn6QA5dhYAJb
        vs7OJSsy1iS3vIfnVyo/84US4kSf4ew=
X-Google-Smtp-Source: ABdhPJz4rPnr27ObZgryYPo9ij4abeMzrqyQnizEHX71SzONTel03n/77R8ayiQxRbCWiwsv256wmw==
X-Received: by 2002:a17:90a:5992:: with SMTP id l18mr10636078pji.160.1640393821293;
        Fri, 24 Dec 2021 16:57:01 -0800 (PST)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id v4sm9445350pjk.38.2021.12.24.16.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 16:57:00 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id A159F2360ECB; Sat, 25 Dec 2021 09:56:58 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] perf bpf: Fix a typo in bpf_counter_cgroup.c
Date:   Sat, 25 Dec 2021 09:55:58 +0900
Message-Id: <20211225005558.503935-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in error message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/perf/util/bpf_counter_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index cbc6c2bca488..fea5f2ca03f6 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -266,7 +266,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 		idx = evsel->core.idx;
 		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
 		if (err) {
-			pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
+			pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
 			       idx, evsel__name(evsel), evsel->cgrp->name);
 			goto out;
 		}
-- 
2.25.0

