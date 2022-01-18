Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1569492188
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344780AbiARIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:45:09 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:48974 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiARIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:45:08 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20I8c8hV013910;
        Tue, 18 Jan 2022 16:38:08 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 Jan
 2022 16:45:05 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Fix incorrect resolution detected
Date:   Tue, 18 Jan 2022 16:44:47 +0800
Message-ID: <20220118084449.5182-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20I8c8hV013910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes incorrect resolution detected.
We found this problem happened occasionally in the switch between bios
and bootloader.

Changes in v3:
 - In v2, we tried to increase the min-required-count of stable signal
   to avoid incorrect transient state in timing detection. But it is
   not working for all conditions.
   Thus, we go another way in v3. Use regs, which can represent the
   signal status, to decide if we needs to do detection again.
 
Changes in v2:
 - Separate the patch into two patches

Jammy Huang (2):
  media: aspeed: Add macro for the fields of the mode-detect registers
  video: aspeed: Fix unstable timing detection

 drivers/media/platform/aspeed-video.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.25.1

