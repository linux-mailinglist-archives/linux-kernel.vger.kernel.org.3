Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA45251AD66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377433AbiEDTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354684AbiEDTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B9422534
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651690765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2bI1b+9CHVnFXDiPfBY5bMPSxLI4NMkzf8DybM3QlWY=;
        b=J5LwVWHux4JvOrLMdbsre8JKE6SdrMcRw4gqjkQgfMRavxAh/OiP+GvTkwIxLFN+MAKn6j
        3sf79o4/f1sdHDqCJIjj1NeOMurGVI0Fg5n6aTIYLcMR4ds7c1uxr5iatjld8RL6g1GfHT
        liBam037vmJwFEKNlFsGXnPYDlfWT/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-Wx5mXPf7N8WwPxwMgX0Xmw-1; Wed, 04 May 2022 14:59:23 -0400
X-MC-Unique: Wx5mXPf7N8WwPxwMgX0Xmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61E9219705AA;
        Wed,  4 May 2022 18:59:23 +0000 (UTC)
Received: from jtoppins.rdu.csb (unknown [10.22.10.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B107C07F5D;
        Wed,  4 May 2022 18:59:23 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH net-next RESEND] MAINTAINERS: add missing files for bonding definition
Date:   Wed,  4 May 2022 14:59:08 -0400
Message-Id: <903ed2906b93628b38a2015664a20d2802042863.1651690748.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bonding entry did not include additional include files that have
been added nor did it reference the documentation. Add these references
for completeness.

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa6896e8b2d8..0d024c5308f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3570,8 +3570,9 @@ M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://sourceforge.net/projects/bonding/
+F:	Documentation/networking/bonding.rst
 F:	drivers/net/bonding/
-F:	include/net/bonding.h
+F:	include/net/bond*
 F:	include/uapi/linux/if_bonding.h
 
 BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
-- 
2.27.0

