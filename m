Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687845798B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiGSLnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiGSLnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:43:45 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892F73F304;
        Tue, 19 Jul 2022 04:43:39 -0700 (PDT)
X-QQ-mid: bizesmtp63t1658230985t1veqesu
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 19:42:57 +0800 (CST)
X-QQ-SSF: 0100000000600030C000B00A0000020
X-QQ-FEAT: oxALfFWpRnA2vxCg5jbyfzDMGhwSwIVpVEd1zKNA7dpv2bX1DTjcdYk5ug3GJ
        TjLTRkOieAtbdp6R8vxT84GhLCVzPcImF3gbpXORW035tvyJcQu6ymMW3atpKQ+Cj2Ep48B
        2qfpyoj1ZPxpEl0wqfJvI2HERrafCX8TGZ7OCZp/NSxmOmjH1JJOAh9uETbsiFSxvdGR4E2
        Nbr3JMrTT5Npr3kTFJoo5oOqB2RmZdPcyaRtMAvJ765IEDPxVcR/zr6bQZIaHN3Nx7VLHRr
        pUzpuswZqBOPvedMtsze2KYgeVxmhPh0MIA4FLknZjUGTwickniI2V/Woyd7JntRqBjoX0C
        szRMzahUnxuo1i8xQzKTjY0qZqtPVPhjGryUFvgMhDPYOZzEPZ8gWJk5npcfqU5uRvKPd/E
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ata:do not initialise statics to 0
Date:   Tue, 19 Jul 2022 19:42:55 +0800
Message-Id: <20220719114255.7568-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 40e816419f48..bbb98433d160 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -119,7 +119,7 @@ static int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
 MODULE_PARM_DESC(atapi_enabled, "Enable discovery of ATAPI devices (0=off, 1=on [default])");
 
-static int atapi_dmadir = 0;
+static int atapi_dmadir;
 module_param(atapi_dmadir, int, 0444);
 MODULE_PARM_DESC(atapi_dmadir, "Enable ATAPI DMADIR bridge support (0=off [default], 1=on)");
 
-- 
2.30.2

