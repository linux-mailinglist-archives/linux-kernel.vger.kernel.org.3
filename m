Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2910150E1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiDYNe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiDYNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFCFF2A6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650893476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vRkFZZ+bpHCqYl5M+UHtMrybHZdURp3ea7MDvTxPK6I=;
        b=fDpfV6Gilsm7IrLB5+RD8C85Wxrm4JoJlS7Zdgjiwf5YUbWAXfINqvpakQPOL0KpoFwaJk
        5qeA6jnGn8pL2whcrqDekkKrB1r1SjIPRm3CLjZTaP/GsVFho8CzjY7O+V+/6TmLuCZMhL
        6NRR4/EIIjaiI2RF2+vGQH+0tyuoy8o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-6m0Yp1bkP2SlnB40Z61Srw-1; Mon, 25 Apr 2022 09:31:14 -0400
X-MC-Unique: 6m0Yp1bkP2SlnB40Z61Srw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47F7C380050C;
        Mon, 25 Apr 2022 13:31:13 +0000 (UTC)
Received: from localhost (unknown [10.76.0.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB71F404E4A6;
        Mon, 25 Apr 2022 13:31:12 +0000 (UTC)
From:   Vaibhav Nagare <vnagare@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        vnagare@redhat.com
Subject: [PATCH] staging: greybus: tools: fix spelling
Date:   Mon, 25 Apr 2022 19:01:11 +0530
Message-Id: <20220425133111.118257-1-vnagare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the spelling mistake of appendation to appending.

Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 drivers/staging/greybus/tools/loopback_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 867bf289df2e..4c42e393cd3d 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -533,7 +533,7 @@ static int log_results(struct loopback_test *t)
 
 		fd = open(file_name, O_WRONLY | O_CREAT | O_APPEND, 0644);
 		if (fd < 0) {
-			fprintf(stderr, "unable to open %s for appendation\n", file_name);
+			fprintf(stderr, "unable to open %s for appending\n", file_name);
 			abort();
 		}
 
-- 
2.27.0

