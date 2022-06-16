Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903D54DC39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359233AbiFPHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiFPHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:54:44 -0400
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B99F19014
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:54:43 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=rainbowdash)
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1o1kKv-0007ZL-7u; Thu, 16 Jun 2022 08:54:41 +0100
Received: from ben by rainbowdash with local (Exim 4.95)
        (envelope-from <ben@rainbowdash>)
        id 1o1kKu-007hmP-Q1;
        Thu, 16 Jun 2022 08:54:40 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org, ben-linux@fluff.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mailmap: add alias from Ben Dooks' old simtec address
Date:   Thu, 16 Jun 2022 08:54:40 +0100
Message-Id: <20220616075440.1836576-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I left Simtec a long time ago, so make sure this is now listed
under my fluff.org account.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 825fae8e6b7b..9f86c296c595 100644
--- a/.mailmap
+++ b/.mailmap
@@ -60,6 +60,7 @@ Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
 Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
+Ben Dooks <ben-linux@fluff.org> <ben@simtec.co.uk>
 Ben Gardner <bgardner@wabtec.com>
 Ben M Cahill <ben.m.cahill@intel.com>
 Björn Steinbrink <B.Steinbrink@gmx.de>
-- 
2.35.1

