Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4D50BD64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389821AbiDVQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357337AbiDVQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30ADB5EBDD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650645935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iRkZ/MlhVt4hFpcsFs4QSWVVxX1L4tCfV1bfk1REu+M=;
        b=ea2tDBnzFe0N/o1oZCDE34whu7pJsvje1RcX7Bkw54k44IErKYlsdaX83q9RF30falF9ts
        YjQHFjGJnwF+rWQ6Pxt/h81rrmL9lJUzX/WfqSXCIp1aXeVrVrSQbigFCW2qaj4If6tgdi
        C98/aJUCUQ7AuvNruHxAZLrzVZMSfcA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-pbnhvUw6MYGIrHBckTXuTg-1; Fri, 22 Apr 2022 12:45:31 -0400
X-MC-Unique: pbnhvUw6MYGIrHBckTXuTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6094A101AA44;
        Fri, 22 Apr 2022 16:45:31 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.10.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE9482166B5E;
        Fri, 22 Apr 2022 16:45:30 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] Documentation: add missing angle bracket in cgroup-v2 doc Tejun Heo <tj@kernel.org>
Date:   Fri, 22 Apr 2022 12:45:26 -0400
Message-Id: <20220422164526.3464306-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial addition of missing closing angle backet.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 69d7a6983f78..38aa01939e1e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1881,7 +1881,7 @@ IO Latency Interface Files
   io.latency
 	This takes a similar format as the other controllers.
 
-		"MAJOR:MINOR target=<target time in microseconds"
+		"MAJOR:MINOR target=<target time in microseconds>"
 
   io.stat
 	If the controller is enabled you will see extra stats in io.stat in
-- 
2.27.0

