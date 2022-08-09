Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1258DF01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiHIS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiHIS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:26:51 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D262981D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:09:37 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 47F91308D0F;
        Tue,  9 Aug 2022 20:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660068555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z3NnR0TOuWJ3454HudlPvY9L+5B9dZRvp4G1MqPjrzk=;
        b=afLp95M23vaGC6pzb84/NlH28DXansp8NXZ0uxJqwL621c7wMfJ0BtA4uN56ilTI2VQdFp
        qxJC8H7hOdiX4GcXPHB16rZSj+wvntMM3q16XWmKZzgQ/QIbxkyDBER0WF1Wyn2Xb+I34y
        Ci4a2SNrjcXa61LwCiA4519j3nfjs4ElNMXWXCfEWEf/lW1vb+9zG1t4qt5Iyegd5WpKU6
        3keVeGYBjPra9qzXjEbGCFCuYbcFeIiycGVFcWEkcrR670BHcpCjmJAMNMtdhQJhtFBiOn
        RXNrBA1NB0F8z9fQB8T3LVAqaFcit0hOoZtrrdQDCTqSnacqDIC8+Kewr0wXzA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 0/5] cpumask: KUnit test suite fixes and improvements
Date:   Tue,  9 Aug 2022 20:08:50 +0200
Message-Id: <cover.1660068429.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the reported issues, and implements the suggested
improvements, for the version of the cpumask tests [1] that was merged
with commit c41e8866c28c ("lib/test: introduce cpumask KUnit test
suite").

[1] https://lore.kernel.org/all/85217b5de6d62257313ad7fde3e1969421acad75.1659077534.git.sander@svanheule.net/

Sander Vanheule (5):
  lib/test_cpumask: drop cpu_possible_mask full test
  lib/test_cpumask: fix cpu_possible_mask last test
  lib/test_cpumask: follow KUnit style guidelines
  lib/cpumask_kunit: log mask contents
  lib/cpumask_kunit: add tests file to MAINTAINERS

 MAINTAINERS                             |  1 +
 lib/Kconfig.debug                       |  7 +++++--
 lib/Makefile                            |  2 +-
 lib/{test_cpumask.c => cpumask_kunit.c} | 13 +++++++++++--
 4 files changed, 18 insertions(+), 5 deletions(-)
 rename lib/{test_cpumask.c => cpumask_kunit.c} (90%)

-- 
2.37.1

