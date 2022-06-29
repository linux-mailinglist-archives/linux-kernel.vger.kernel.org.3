Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A75560134
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiF2NXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiF2NW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:22:58 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBF34BA9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:22:53 -0700 (PDT)
X-QQ-mid: bizesmtp65t1656508939tswi8yzf
Received: from localhost.localdomain ( [182.148.13.66])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 29 Jun 2022 21:22:16 +0800 (CST)
X-QQ-SSF: 0100000000200060C000C00A0000000
X-QQ-FEAT: MYl5Gn9dGPU8YT+5ZkHurVRhLXTgHvFsIdJfTPawL/dHrlkE8qf0Qiniuoycd
        nNDl6+vehW/6TLBcK88IN1vjdmaoTEnuOdasepYn3sTVu0x/uVnBfLwHZWf9usTRoWObYeT
        P8Cv66DMwdNgHkvxQ+xA4zhXqh7avupOTHKD7hQ5KBSu0qZK1P43HIPS2pxzj3OXgmvvfJ1
        e7WgNqIP6wmwUOwXIXhwdFEb8YBcA+c2rlDaIsYY7NXfbvbYrrMF07MNuS7S/4znWoLpyfu
        vFk5eVQRmbAOh5XgbQJEbtWghHK/+DwVtL1WakZLI9F39JJ+W0gmq92ed19SXuruvprg+52
        cbCxqNJ
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     drt@linux.ibm.com, tlfalcon@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] ethernet/ibm:fix repeated words in comments
Date:   Wed, 29 Jun 2022 21:22:09 +0800
Message-Id: <20220629132209.30191-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_DYNAMIC,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'a'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7e7fe5bdf1f8..8ab326fdc3f5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3073,7 +3073,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 
 	/* If failover is pending don't schedule any other reset.
 	 * Instead let the failover complete. If there is already a
-	 * a failover reset scheduled, we will detect and drop the
+	 * failover reset scheduled, we will detect and drop the
 	 * duplicate reset when walking the ->rwi_list below.
 	 */
 	if (adapter->state == VNIC_REMOVING ||
-- 
2.36.1

