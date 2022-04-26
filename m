Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0F50FAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiDZKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349008AbiDZKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:31:18 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B2ABFFEEF;
        Tue, 26 Apr 2022 03:09:33 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:40704.1059882310
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id 17B242800B8;
        Tue, 26 Apr 2022 18:09:29 +0800 (CST)
X-189-SAVE-TO-SEND: +liuxp11@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 8198c660950143f299a92cb45404995c for wim@linux-watchdog.org;
        Tue, 26 Apr 2022 18:09:32 CST
X-Transaction-ID: 8198c660950143f299a92cb45404995c
X-Real-From: liuxp11@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liuxp11@chinatelecom.cn
From:   Liu Xinpeng <liuxp11@chinatelecom.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net, tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xinpeng <liuxp11@chinatelecom.cn>
Subject: [PATCH v7 0/3] Some impovements about acpi hardware watchdog
Date:   Tue, 26 Apr 2022 18:09:19 +0800
Message-Id: <1650967762-3122-1-git-send-email-liuxp11@chinatelecom.cn>
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
v3->v4 - For patch 1, update commit message, rename WDAT_TIMEOUT_MIN
       to WDAT_MIN_TIMEOUT, keeps consistent with WDAT_DEFAULT_TIMEOUT.
       - For patch 4, iTCO_wdt_suspend_noirq and iTCO_wdt_resume_noirq
       are possible unused, so keep "ifdef CONFIG_PM_SLEEP ... #endif".
v4->v5 split iTCO_wdt's commit fro this patchset.
v5->v6 For patch 1, drop "Context: " and to change "existed" in the 
subject to "existing".
v6->v7 Rename "watchdog: wdat_wdg" in subject to "watchdog: wdat_wdt"

Liu Xinpeng (3):
  watchdog: wdat_wdg: Using the existing function to check parameter
    timeout
  watchdog: wdat_wdg: Stop watchdog when rebooting the system
  watchdog: wdat_wdg: Stop watchdog when uninstalling module

 drivers/watchdog/wdat_wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.23.0

