Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152859E558
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiHWOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbiHWOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:49:10 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD01561E3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:12:24 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661256679tov9dh2x
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:11:17 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: 4do7Yod3Qisv2fBV3BL8PyGx5qFmkAnPeIRHODAsHOnet4x0f7jRE8B9GKE0a
        mp8mH1ERDA8l9KwqSwptYfEJObC1HlARMrXwOW/m9rCS3ndkjZY5y2tHqw4L6JBqxNQvRIB
        tM9zH3TmWvcmcfvTE3LBxX/XUIgpJz9wNcp4HMIh/zM4wlY/B+hD9PrQUksNfjlAfj8dd79
        InNJCWKFrflelwMOyPHnARQ44EIKzD0fGyZOhYzWDrIY4dFv6XuYWZxc5eZulmW1HPgB/39
        IpTFEM8wR6PWa3QYtdqtXE0+QATWIP57abu1zUbQ2gY8pBqCz2bpOEtmhrzoIYxubNaL4GU
        5J5Q2lQMSwQlc2nyzZ26MBpylvJZtVVuEI6N6cPBCZ+ZvgefbHqyRMvvRaBMDWJIXOYtNP6
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, aniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] gpu/drm: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:11:12 +0800
Message-Id: <20220823121112.5087-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/drm_ioctl.c    | 2 +-
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 51fcf1298023..8faad23dc1d8 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -83,7 +83,7 @@
  *
  * 1. Directly call VERSION to get the version and to match against the driver
  *    name returned by that ioctl. Note that SET_VERSION is not called, which
- *    means the the unique name for the master node just opening is _not_ filled
+ *    means the unique name for the master node just opening is _not_ filled
  *    out. This despite that with current drm device nodes are always bound to
  *    one device, and can't be runtime assigned like with drm 1.0.
  * 2. Match driver name. If it mismatches, proceed to the next device node.
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index c40bde96cfdf..fd2790a5664d 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -606,7 +606,7 @@ EXPORT_SYMBOL(mipi_dsi_turn_on_peripheral);
 
 /*
  * mipi_dsi_set_maximum_return_packet_size() - specify the maximum size of the
- *    the payload in a long packet transmitted from the peripheral back to the
+ *    payload in a long packet transmitted from the peripheral back to the
  *    host processor
  * @dsi: DSI peripheral device
  * @value: the maximum size of the payload
-- 
2.36.1

