Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3F94BEE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 00:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiBUXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 18:40:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiBUXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 18:40:47 -0500
X-Greylist: delayed 13197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 15:40:21 PST
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E8240AB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:40:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645486818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OK+un4V/aeVMjWJC0DxSGK3Hdj4j+7kI4FwDw4pB+q4=;
        b=KHz5ulIsGGKQw2cUBBdMMR9jUUTl9qFg45hF5+OhR0QtrjCIaIbLpqvAJWBaOjYbRFDcvP
        iQIn+dXDxpAVRXFuoHyMaGePY6rtHvg/JSrx6kMBv74s8jsgFDb8Fqqb7haPzMqY5OHQdi
        e47Iz7/z8AhnvBDZM9q1gdBBUVbjaUg=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: [PATCH] MAINTAINERS: add myself as a memcg co-maintainer
Date:   Mon, 21 Feb 2022 15:39:51 -0800
Message-Id: <20220221233951.659048-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a memcg co-maintainer. My primary focus over last few
years was the kernel memory accounting stack, but I do work on some
other parts of the memory controller as well.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66aa3a589f6a..ecdb90e99ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4991,6 +4991,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Vladimir Davydov <vdavydov.dev@gmail.com>
+M:	Roman Gushchin <roman.gushchin@linux.dev>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.35.1

