Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD750DB15
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiDYI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiDYIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:25:47 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 382901CB2F;
        Mon, 25 Apr 2022 01:22:42 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:45926.704897365
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.38 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 29E26280097;
        Mon, 25 Apr 2022 16:22:35 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 6bced1fbeb91485ba2dc62cdc64ebbb9 for wim@linux-watchdog.org;
        Mon, 25 Apr 2022 16:22:38 CST
X-Transaction-ID: 6bced1fbeb91485ba2dc62cdc64ebbb9
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v2 0/3] Impovements about acpi hardware watchdog
Date:   Mon, 25 Apr 2022 16:22:09 +0800
Message-Id: <1650874932-18407-1-git-send-email-liuxp11@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v1->v2 update the commit messages for a better understanding

Liu Xinpeng (3):
  watchdog: wdat_wdg: Using the existed function to check if a timeout
    value is invalid
  watchdog: wdat_wdg: Stop watchdog when rebooting the system
  watchdog: wdat_wdg: Stop watchdog when uninstalling module

 drivers/watchdog/wdat_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.23.0

