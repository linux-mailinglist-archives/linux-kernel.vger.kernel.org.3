Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781C950EF47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbiDZDjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243219AbiDZDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:38:47 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3D6A39829;
        Mon, 25 Apr 2022 20:35:41 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.188:49938.983364622
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id 9226E2800CD;
        Tue, 26 Apr 2022 11:35:36 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.188])
        by app0023 with ESMTP id 5a46b418558e44358452701610bdefdb for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 11:35:40 CST
X-Transaction-ID: 5a46b418558e44358452701610bdefdb
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.188
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v3 0/4] Some Impovements about watchdog
Date:   Tue, 26 Apr 2022 11:35:16 +0800
Message-Id: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v1->v2 Update the commit messages
v2->v3 - Add the context about why using watchdog_timeout_invalid.
       - Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code for
       iTCO watchdog.

Liu Xinpeng (4):
  watchdog: wdat_wdg: Using the existed function to check parameter
    timeout
  watchdog: wdat_wdg: Stop watchdog when rebooting the system
  watchdog: wdat_wdg: Stop watchdog when uninstalling module
  watchdog: iTCO_wdg: Make code more clearly with macro definition

 drivers/watchdog/iTCO_wdt.c | 12 +++---------
 drivers/watchdog/wdat_wdt.c |  7 +++++--
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.23.0

