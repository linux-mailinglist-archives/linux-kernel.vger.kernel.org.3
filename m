Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E31497C09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiAXJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:34:14 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:50240 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiAXJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:34:06 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20O9QVf4054145;
        Mon, 24 Jan 2022 17:26:31 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 17:33:47 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] Correct timing report
Date:   Mon, 24 Jan 2022 17:33:41 +0800
Message-ID: <20220124093345.3935-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20O9QVf4054145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will correct the value of timing detected.

Changes in v3:
 - Add API, aspeed_video_get_timings(), for the calculation of timings
 - Use active rather than 'total/2' as critera for sync polarity workaround
Changes in v2:
 - code refined to improve readability

Jammy Huang (4):
  media: aspeed: Correct value for h-total-pixels
  media: aspeed: Use FIELD_GET to improve readability
  media: aspeed: Correct values for detected timing
  media: aspeed: Fix timing polarity incorrect

 drivers/media/platform/aspeed-video.c | 139 ++++++++++++++++++++------
 1 file changed, 111 insertions(+), 28 deletions(-)

-- 
2.25.1

