Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163B585FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGaQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGaQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:01:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61919B7E7;
        Sun, 31 Jul 2022 09:01:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id m7so6835508qkk.6;
        Sun, 31 Jul 2022 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Ls49MCuUPGsCWSsHd+LecCPnmoDzAGdp19gbXuWH4=;
        b=HVgyZWgm7iXzy2eO2ax8Ey6krAL5xH5Ha611dAwe+YWBNTMR29uS5KjC2C8HbEEOwS
         Z/o/ROcpR1bRdCRguN1KmxQTnV/cdjSuuK3yc97FSJLi610QdwvPtgD947Iz78JVW1tN
         FgOszYRdeoDYDF9p7YeoQFwdVmo71uKrcqKhnEWgsdl1K+gFAKDYpQysZLIU3gWUB7vL
         SyEeeV+HWXdu+M0eGDXyPuheo03Rxkt8b3FMiwiGQQUuuprE3yQCLc7yAsVzuB7uRSmR
         iD6rWjxyfx3Ha1pTqnVTKQUky3fCA4wKxta9V9DFXbjTfmVzGYaQidJ/KAndJXzPbbWT
         F7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3Ls49MCuUPGsCWSsHd+LecCPnmoDzAGdp19gbXuWH4=;
        b=zetA97R/SVQ0EYMqBVD7HTNNgIUmNktPfZTu1LGJzMuyOC9PO+9lej3vDlURVSUnup
         7+42ukzDBhRyh0lgOp2cmVI/GGi1oFN8HE80XpMm21I0ncqLum2+tLOODFPQ/QhdSJPH
         /fGbmIfaX3KtEg0nfmdfwucsElP+twotevFC8Lfgezpd/g8sEbfDvGvjX4zCbxsMErO2
         NOf8sHEtarbFlhIbrg0L1GNkGgaq893DARZgRYP1M9gLXo+yIP11jJUao7s47wtOUZgK
         H3J7WLSd5uFfzNSsUYqAB3nnDtLXY+0Asic5i2VXyCmMn1yPUQ0SMCDT2KGgjSznjo0V
         zl0A==
X-Gm-Message-State: AJIora+gNB8iiyRdvk7JARvp0+SmaqmLylEdIfE6gC36ytlZ6wagD0jy
        h16sNthhsVGCXKzhegim1Zg1FSDylRw=
X-Google-Smtp-Source: AGRyM1vMxiVD2Ny3xdS3RafgYzu5GZSk1uvTU4pl8CF0eLRf2M5/OSt+Z1dKWnqXmvwfjYHAocz58Q==
X-Received: by 2002:a37:b346:0:b0:6b2:8e4c:690c with SMTP id c67-20020a37b346000000b006b28e4c690cmr9348826qkf.654.1659283296501;
        Sun, 31 Jul 2022 09:01:36 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05620a2ac400b006b4880b08a9sm6854626qkb.88.2022.07.31.09.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 09:01:36 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Add names for function definition arguments.
Date:   Sun, 31 Jul 2022 12:01:20 -0400
Message-Id: <20220731160120.4831-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl add missing names for function definition
arguments.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index b5e059e15b0a..0e2056894965 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -354,9 +354,10 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 	enum iio_shared_by shared_by, const unsigned long *mask)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	ssize_t (*show)(struct device *, struct device_attribute *, char *);
-	ssize_t (*store)(struct device *, struct device_attribute *,
-		const char *, size_t);
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+		char *buf);
+	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len);
 	unsigned int attrcount = 0;
 	unsigned int i;
 	char *postfix;
-- 
2.37.1

