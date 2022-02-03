Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE04A85C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbiBCOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:06:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBCOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:06:12 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc5-00033r-0z; Thu, 03 Feb 2022 14:57:29 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcc4-009xpK-Go; Thu, 03 Feb 2022 14:57:28 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/2] counter: add new COUNTER_EVENT_CHANGE_OF_STATE
Date:   Thu,  3 Feb 2022 14:57:26 +0100
Message-Id: <20220203135727.2374052-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203135727.2374052-1-o.rempel@pengutronix.de>
References: <20220203135727.2374052-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new counter event to notify user space about every new counter
pulse.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/uapi/linux/counter.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index d0aa95aeff7b..96c5ffd368ad 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -61,6 +61,8 @@ enum counter_event_type {
 	COUNTER_EVENT_THRESHOLD,
 	/* Index signal detected */
 	COUNTER_EVENT_INDEX,
+	/* State of counter is changed */
+	COUNTER_EVENT_CHANGE_OF_STATE,
 };
 
 /**
-- 
2.30.2

