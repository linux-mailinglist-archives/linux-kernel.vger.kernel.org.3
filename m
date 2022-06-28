Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8181255C43C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbiF1IbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiF1IbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:31:08 -0400
Received: from relay2.uni-heidelberg.de (relay2.uni-heidelberg.de [129.206.119.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEE26542
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:31:06 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2C7BQCEu7piffxkzoFagliDJYFXlBABAQEGjHGBCYYWi?=
 =?us-ascii?q?ieCBwEBAQEBAQEBAQkvEwQBAUCEOYVWJzYHDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEGAQEBAQEHBBQBASM8J4VoDYZ7AUaESwEDgmQBM65ggQGGWgGBP4FlgT2JW?=
 =?us-ascii?q?YUfgUCBEIR9hRGFbgSaBgoDCQQHBUYXEk4xIQJFCxwBCAYGBwEIAQUIKAQCA?=
 =?us-ascii?q?QEBBgUYFAEDAQETEgUTDAcoChICEgwKGwcHAwsFMg0CDgcBAQwPAQIPAwECE?=
 =?us-ascii?q?QEHAgkSCAYPKwgDAQEDAQcBAgIDIAsCAxYJBwgCAQIFAgIBAw8BCAocEhAUA?=
 =?us-ascii?q?gQNBB4JAggBAhkeLAcCAgQOAyMfCAsKAw4DBAMBEAIYBwIBFQEFAgQIBAEDB?=
 =?us-ascii?q?gMIFRkBDScEBwMSAg0BBgECBgEBBQUBAxgIAxQDBQECCAMWBwECIQUKJgkED?=
 =?us-ascii?q?QMBIhsCAwMBBBsKAgECAgUWBQIBAQIDAgYVBgICPy8RHQ0IBAgECRIcIwECD?=
 =?us-ascii?q?AEEAQIHLwUELQIBAR4EBQEFDwIIAQEWAgYEAwICAwEBAgEWAhAIAggnFwcTM?=
 =?us-ascii?q?xkBBTcUDg8BAwYIGRwiBwkHBQYWAwwVKR4pBQcREhsPBA0NCjQgFiQBAQ4FA?=
 =?us-ascii?q?wESGREOBxQKUyYhFRAGASsWAwQBAwMCBhoBAgMiAhILCRUCBC0FASIdGZtKg?=
 =?us-ascii?q?Q5OWYECkmmDN6thB4NREAGLEJR5LYNjgWKRHQKSAC2WQ6JxhE81gTMGgghNI?=
 =?us-ascii?q?4M4CUgZD412AYldhR5zOwIGCwEBAwmPAQEB?=
IronPort-Data: A9a23:ZK+/Yqhehs0VgE1MGeOE6qFaX161+hAKZh0ujC45NGQN5FlHY01je
 htvCDvXM/uIZjChKttwPtvjpk9QuZKHyYJgTgJrryxhEC1jpJueD7x1DG+pYnzIfpOfJK5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHWeIcw98z0M58wIFqtQw24LhXVnd4
 YqaT/D3YTdJ5RYlagr41Ire8HuDjNyq0N/PlgVjDRzjlAa2e0g9VPrzF4noR5fLatE88tqBe
 gr25OrRElU1X/saIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt44ol
 tN2u4aQcikob7TwgsRAdwd1CggraMWq+JefSZS+mcmazkmeKj3xxfQrDEw3MYAc8OttDidC+
 JT0KhhUNEHF3brohuvjEq82255LwMrDZevzvll7xjHdAO4+TIrrWLnX6ZlF2jZ1hs1PEfvab
 ccDZnxjYXwsZjUWZwhNVspnwbnAan/XURNdj2jOqY8N4XXczhRWwbTQd+WMZYnfLSlSth3E+
 D6cpjyR7gshHMOd0j2Z+1qjg+bOmWXwX4d6PLKi+/FpgHWXx2oOGBMRSF23qOW4jUj4XMhQQ
 2QQ+ywzve0p6EWkT9/ydxm5u2Kf+BodXcdAVeE39mmlxPHP6AbfCWkYZjlcdNghs8xwTjsvv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJTbp+PHmqYA31kuJU9BiVa64j9H4HTv92
 T/MoCVWa6gvYdAjifzl+2vJmRKXiJmYVzIvxljzQE+8x1YsDGK6XLCA5V/e5PdGCY+WSFido
 XQJ8/RyCshQVPlhcwTQEI0w8KGVC+WtbGyA2AYwd3U132Tzqyb6FWxFyGwmfC9U3tA4lSjBT
 GK7Vel5xJJSMHauZ6JtbOpd4Ox0nPG6TbwJutj+Z9ZDZN1O39ud4D1jYESdxW+FraTBuaQ2O
 JPDKICxC3dfCalmwDeyTeoH3vkny0jSJF8/p7iln3xLMpLHOhZ5rIvp1nPSMYjVC4vf8W3oH
 y53bZfi9vmmeLSWjtPr2YASN0sWCnMwGIr7rcdaHsbafFc4Qzx9VaWPn+h4E2CAo0izvrmZl
 p1achEEoGcTeVWZeG1ml1g5MOKyA88hxZ7FFXx3bQbAN4cfjXaHt/tBK8FuJdHLBcRpwPprU
 vRNZsOBHPlVUTXb6nwbYIXiq5ZhHClHdirRVxdJlAMXIcU6LySXoYCMQ+ca3HNTZsZBnZdl/
 ufIO8KyacZrejmO++6MOK7ykAvg7SNG8A+wNmORSuRulIzX2NACA0TMYjUfeqng9T2rKuOm6
 jur
IronPort-HdrOrdr: A9a23:SUxdZKiYi+9NRtOf1N+W9SgafXBQXsEji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcK2+gs1N6ZNWGMhILCFu5fBOXZrgEIYxefytJg
X-IronPort-Anti-Spam-Filtered: true
Received: from mail01.uni-heidelberg.de ([129.206.100.252])
  by relay2.uni-heidelberg.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 10:31:04 +0200
Received: from localhost (ip-037-209-006-204.um11.pools.vodafone-ip.de [37.209.6.204])
        (Authenticated sender: ln194)
        by mail01.uni-heidelberg.de (Postfix) with ESMTPSA id 951F9300084F1;
        Tue, 28 Jun 2022 10:31:03 +0200 (CEST)
From:   Felix Schlepper <f3sch.git@outlook.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        wjsota@gmail.com, Felix Schlepper <f3sch.git@outlook.com>
Subject: [PATCH 0/7] Staging: rtl8192e: rtllib_wx.c coding style
Date:   Tue, 28 Jun 2022 10:30:49 +0200
Message-Id: <cover.1656402464.git.f3sch.git@outlook.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some issues raised by chechpatch.pl.
There are no logical changes, just addressing coding style.
I 'tested' it by bulding.

Felix Schlepper (7):
  Staging: rtl8192e: Added blank lines before/after struct
  Staging: rtl8192e: Added spaces around binary operators
  Staging: rtl8192e: Avoid multiple assignments
  Staging: rtl8192e: Remove unnecessary parentheses
  Staging: rtl8192e: Added braces around else
  Staging: rtl8192e: Remove unnecessary blank line
  Staging: rtl8192e: Added spaces around '+'

 drivers/staging/rtl8192e/rtllib_wx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.36.1

