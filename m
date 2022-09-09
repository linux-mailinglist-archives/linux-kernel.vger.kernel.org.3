Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1DE5B2D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 05:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIIDy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 23:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIIDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 23:54:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE21EC5F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 20:54:47 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP27n6WQpzZcnt;
        Fri,  9 Sep 2022 11:50:13 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 11:54:44 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <johan@kernel.org>,
        <stefanha@gmail.com>, <dhowells@redhat.com>,
        <cuigaosheng1@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ALSA: line6: remove line6_set_raw declaration
Date:   Fri, 9 Sep 2022 11:54:42 +0800
Message-ID: <20220909035443.1065737-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909035443.1065737-1-cuigaosheng1@huawei.com>
References: <20220909035443.1065737-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

line6_set_raw has been removed since
commit 9f673d7a6022 ("staging: line6: drop CONFIG_LINE6_USB_RAW"),
so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 sound/usb/line6/driver.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index ecf3a2b39c7e..dbb1d90d3647 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -193,8 +193,6 @@ extern int line6_send_raw_message_async(struct usb_line6 *line6,
 					const char *buffer, int size);
 extern int line6_send_sysex_message(struct usb_line6 *line6,
 				    const char *buffer, int size);
-extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count);
 extern int line6_version_request_async(struct usb_line6 *line6);
 extern int line6_write_data(struct usb_line6 *line6, unsigned address,
 			    void *data, unsigned datalen);
-- 
2.25.1

