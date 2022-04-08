Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA244F9C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiDHRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiDHRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:55:55 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B58D747B;
        Fri,  8 Apr 2022 10:53:48 -0700 (PDT)
Received: from [78.32.143.231] (helo=devbox3.arkver.dev)
        by smtp.hosts.co.uk with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim)
        (envelope-from <ian.dev@arkver.com>)
        id 1ncsnq-000CRH-BA;
        Fri, 08 Apr 2022 18:53:46 +0100
From:   Ian Jamison <ian.dev@arkver.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ian Arkver <ian.arkver.dev@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: media-entity.h: Fix documentation for media_create_intf_link
Date:   Fri,  8 Apr 2022 18:53:45 +0100
Message-Id: <21f190a8bb9ddaa43949b4455983bd66b4e11798.1649440397.git.ian.dev@arkver.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation comment was inserted between the return type
and the function name. Reunite the lines.

Signed-off-by: Ian Jamison <ian.dev@arkver.com>
Fixes: db7ee32aa185 ("[media] media-device.h: Improve documentation and update it")
---
 include/media/media-entity.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 742918962d46..9bc9a55df71e 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -1030,7 +1030,6 @@ __must_check media_devnode_create(struct media_device *mdev,
  * removed.
  */
 void media_devnode_remove(struct media_intf_devnode *devnode);
-struct media_link *
 
 /**
  * media_create_intf_link() - creates a link between an entity and an interface
@@ -1061,6 +1060,7 @@ struct media_link *
  *    the interface and media_device_register_entity() should be called for the
  *    interface that will be part of the link.
  */
+struct media_link *
 __must_check media_create_intf_link(struct media_entity *entity,
 				    struct media_interface *intf,
 				    u32 flags);
-- 
2.35.1

