Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF244E835A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiCZSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiCZSgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:36:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BE1EEF2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:35:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:4cb:3227:231:99f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A6FA11F44FBF;
        Sat, 26 Mar 2022 18:35:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648319710;
        bh=Yjl46ueIb8FFOE6LTpGiYGQrCe+XfsGRJYwSzV+wGB4=;
        h=From:To:Cc:Subject:Date:From;
        b=jwPvrKO+8Bji2v6cwz+sxa4KmWJgjaeLsupN01ijooDIOyvMN4hzHpfLJJ1CDYGJr
         kvn/jLVOrZ3VCM+3IlgSoFr1HbGa4ZIJE/LgF1Uepqo6PCDSosuwF9jkjFq91Nm4VF
         Z4awMbpz44LyFq2WqyY5kSCauD08V1Wy5OaY0VbbC9ejFdtA5n/eFbiLy5H1Lqp6Sn
         l4r9JWTiXRe7/NEAf1ztEmiugEms6BMgGcM7W0+6hj5Q5trUlVsI6KW4cP/V3YOszO
         t3e9t711npz2pKT4LUYnBDujC6HhPPOqUkget9o4U/Awcy2py+O92jj7PIYAcgd/pT
         E+FWnr6NBssAw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: rockchip: pm_domains: Fix typo in comment
Date:   Sat, 26 Mar 2022 19:34:50 +0100
Message-Id: <20220326183451.66115-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/eject devices form power domain/eject devices from the power domain/

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/soc/rockchip/pm_domains.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0868b7d406fb..1b029e494274 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -1068,9 +1068,9 @@ static struct platform_driver rockchip_pm_domain_driver = {
 		.name   = "rockchip-pm-domain",
 		.of_match_table = rockchip_pm_domain_dt_match,
 		/*
-		 * We can't forcibly eject devices form power domain,
-		 * so we can't really remove power domains once they
-		 * were added.
+		 * We can't forcibly eject devices from the power
+		 * domain, so we can't really remove power domains
+		 * once they were added.
 		 */
 		.suppress_bind_attrs = true,
 	},
-- 
2.25.1

