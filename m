Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B234A8ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353430AbiBCRvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:51:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59002 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353093AbiBCRua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:30 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0F3E9E41;
        Thu,  3 Feb 2022 18:50:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910626;
        bh=FUShm0Je8GKszM0LsCaE7NT2WlwBfAIu03c+bSEwf44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQq0CimwzXMGn0oNliN//kCvTrJ/GVOOVqdlpKNxCgQ/KlcmtkJJAVhzBAAuYjLMB
         Ai9oQWUJPvehsWEmEWlDOBd7tO9KMCNfPWLaGI8agHGoXNphheMxyJKHk0tK9cjxFt
         0pMly4vL7l/SjUpVnTqWkQQ4qAAS8vlv9W2vbTlw=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 04/12] media: MAINTAINERS: add bcm2835 unicam driver
Date:   Thu,  3 Feb 2022 18:50:01 +0100
Message-Id: <20220203175009.558868-5-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BCM2835 Camera driver named Unicam in the list.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1868a6002df8..740cf86c56dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3670,6 +3670,13 @@ N:	bcm113*
 N:	bcm216*
 N:	kona
 
+BROADCOM BCM2835 CAMERA DRIVER
+M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
+F:	arch/arm/boot/dts/bcm283x*
+
 BROADCOM BCM47XX MIPS ARCHITECTURE
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
-- 
2.32.0

