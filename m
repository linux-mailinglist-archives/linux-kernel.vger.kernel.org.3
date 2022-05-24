Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE32C5324EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiEXIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEXIIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB6AF77F05
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653379701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1XePJKWKS494invWsXxLhpx1dxpr9onX16/MIWMtA1w=;
        b=CV7MR8mwgpOEobptHIobTv5+qPYKnP+T8PmJt1Nhmpo8w3jkzYN5syNla2rdPQ2TIVK4Ry
        XcP6EKvjH1JYasinwZig9aeR6Fp1vqeCVRxtpywHPOh00aB9eJZoKFZ3JRKWAraXuvZAfn
        gSJbV6UKcUlHxJI1Vw//UKmY5Q+FcOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-ldqEcdFFPiqt1KFdNOPDiw-1; Tue, 24 May 2022 04:08:17 -0400
X-MC-Unique: ldqEcdFFPiqt1KFdNOPDiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40119803B42;
        Tue, 24 May 2022 08:08:17 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D533492C3B;
        Tue, 24 May 2022 08:08:08 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, shan.gavin@gmail.com, zhenyzha@redhat.com
Subject: [PATCH] sched/topology: Fix typo in build_sched_domain()
Date:   Tue, 24 May 2022 16:07:33 +0800
Message-Id: <20220524080733.1362818-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In build_sched_domain(), it seems that "borken" is misspelled. To
correct it with "broken".

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 810750e62118..b1d4f059bc04 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2166,7 +2166,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 #ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-- 
2.23.0

