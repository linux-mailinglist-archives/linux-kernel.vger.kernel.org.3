Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8414810F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhL2I20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:28:26 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:44419 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbhL2I2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:28:25 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BT8M72T020375;
        Wed, 29 Dec 2021 16:22:07 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.180) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 29 Dec
 2021 16:27:56 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <kuohsiang_chou@aspeedtech.com>, <arc_sung@aspeedtech.com>
Subject: [PATCH] drm/ast: Enable the supporting of wide screen on AST2600
Date:   Wed, 29 Dec 2021 16:27:49 +0800
Message-ID: <20211229082749.5415-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.180]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BT8M72T020375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the supporting of wide sscreen on AST2600, so that the resolution
of 16:9 and 16:10 are able to be selected on Display Settings.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index 9f25fa2c8..1113ee1cb 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -209,6 +209,8 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
 			if (ast->chip == AST2500 &&
 			    scu_rev == 0x100)           /* ast2510 */
 				ast->support_wide_screen = true;
+			if (ast->chip == AST2600)		/* ast2600 */
+				ast->support_wide_screen = true;
 		}
 		break;
 	}
--
2.27.0

