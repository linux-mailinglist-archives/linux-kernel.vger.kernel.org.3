Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A949AC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359144AbiAYGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:47:07 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:8592 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357877AbiAYGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:44:24 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20P6akGu078227;
        Tue, 25 Jan 2022 14:36:46 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 Jan
 2022 14:44:06 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/3] Correct timing report
Date:   Tue, 25 Jan 2022 14:44:06 +0800
Message-ID: <20220125064409.5502-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20P6akGu078227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will correct the value of timing detected.

Changes in v4:
 - Combine patch 3 and 4
Changes in v3:
 - Add API, aspeed_video_get_timings(), for the calculation of timings
 - Use active rather than 'total/2' as critera for sync polarity workaround
Changes in v2:
 - code refined to improve readability

Jammy Huang (3):
  media: aspeed: Correct value for h-total-pixels
  media: aspeed: Use FIELD_GET to improve readability
  media: aspeed: Correct values for detected timing

 drivers/media/platform/aspeed-video.c | 137 ++++++++++++++++++++------
 1 file changed, 109 insertions(+), 28 deletions(-)

-- 
2.25.1

