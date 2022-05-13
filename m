Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D057F526692
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382273AbiEMPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382265AbiEMPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:52:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59F1E15D6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:52:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m23so10819030ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=EoRCzFgdqymU94vAV2iJ0vqJH+w1nYNzWrX56BJFK5A=;
        b=PQ1JGa4uyb8yMkUdsAm4Nt9mj9ncphlDfrDvRbPZYFDeH2DUMyZv3Nlv4C2VVX83CM
         2gEOM/vV0TlfADwx2QvGxXWHr9C/RM/onavTakiX8tERXNg9OdVBey51Na0iQnlbbstt
         AoEaInLDNa2zgzydNcT5Sdn/QuQ5Qfdd6ibSZqOTOBpF+lKkDe0TwZp/wBz1z5HcLO5c
         8zgAjxrQyB052eIvSU4BbLlZySBZrPpr932JWX+fT5bxyXWGAXGu9nx7mcdq6IqCF+VQ
         TTBR8HK8sInoUF0IAVdMjhfQ9x5pXUm7gMllPun0H9v7ux2hEofCG7my4kvmA6sKYKGc
         5EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=EoRCzFgdqymU94vAV2iJ0vqJH+w1nYNzWrX56BJFK5A=;
        b=JRDY8Iz0zUjF4x275A32jGNEQ4bCdWK/wC8Y8kjDA6ftuHLVQGjyMzUNvhaS2EEThY
         vJ3Ezkh7o8OJcjMdorm9iKhkHUy6DSZZM468dc4ID1IB8X/O/K2KfuHEJy3h4xSgl1wS
         65fY9o2md05G3wla5Yb8+lR9pCXzR3Zery90gKwFtcwf8dZxhXckZEM3oX96CNQ1ATGI
         +6eJz2NGxN14R6v6kdyfc25oFZnE3VgLzNVoqRv/gZ75l9PlMN7YLvQirHo/NpD8z/Qj
         LFS79/65jRyDFfrDGhODiu+RriPq+VQlAc/ATbJsnIpcDtUwHOokLkJ64O3BK6SZpxzg
         vrUQ==
X-Gm-Message-State: AOAM531hSwbWHgZKZem9sNGon08/EQv6A1C/5vucT7ih6DxyhEOnE+pM
        8znjifIbGLNhMY7Az8kcT5ASOQ==
X-Google-Smtp-Source: ABdhPJwsfGujpSQqtlAqQ86j3Dk+tCX7/tncyCU1pG/8MjVQ1z8dNsl8CEYDE9gBsEQQi6S/8WGTtw==
X-Received: by 2002:a05:651c:1058:b0:250:d064:53d5 with SMTP id x24-20020a05651c105800b00250d06453d5mr3397509ljm.29.1652457133993;
        Fri, 13 May 2022 08:52:13 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651238cf00b0047255d2112csm419874lft.91.2022.05.13.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:52:13 -0700 (PDT)
Message-ID: <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
Date:   Fri, 13 May 2022 18:52:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 3/4] memcg: enable accounting for struct cgroup
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
Content-Language: en-US
In-Reply-To: <Ynv7+VG+T2y9rpdk@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating each new cgroup allocates 4Kb for struct cgroup. This is the
largest memory allocation in this scenario and is epecially important
for small VMs with 1-2 CPUs.

Accounting of this memory helps to avoid misuse inside memcg-limited
containers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index adb820e98f24..7595127c5b3a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5353,7 +5353,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
 	cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
-		       GFP_KERNEL);
+		       GFP_KERNEL_ACCOUNT);
 	if (!cgrp)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.31.1

