Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3444D0713
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiCGS6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244898AbiCGS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:58:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B15528E30
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646679470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIEo8DUeeVvdeAtDzMVTfRpe1FoQl+OoA2kxWVVYsJI=;
        b=gdagCkyvZncr63cAkM8zfUeKbkNteQm1ClL1C390dCOrp9j/iAAdRRzfJCdom6v5JWcRu5
        Vus4IIWcbE0BMshQcNi6eChl4LiDBSz601EJ6pTjsxHeCgVB43x8Kzs6kvGAXbXGPDDgy0
        Y6n96n1EhOwowj9M67cinb2YNRnDZYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-tEku2LycPC2Pj6ynXgB1Wg-1; Mon, 07 Mar 2022 13:57:43 -0500
X-MC-Unique: tEku2LycPC2Pj6ynXgB1Wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C250B1006AA6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:57:42 +0000 (UTC)
Received: from jtoppins.rdu.csb (unknown [10.22.34.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E6D86C5B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:57:42 +0000 (UTC)
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add missing files for bonding definition
Date:   Mon,  7 Mar 2022 13:57:34 -0500
Message-Id: <247a5ccddbce5b6b37ce4f0c98d7e89b33f981c5.1646679416.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index cb75c5d6d78b..9449caf87b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3480,8 +3480,9 @@ M:	Andy Gospodarek <andy@greyhouse.net>
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

