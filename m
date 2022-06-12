Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBC54798B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiFLJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiFLJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:22:36 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44BAD10B;
        Sun, 12 Jun 2022 02:22:35 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8084ECD419;
        Sun, 12 Jun 2022 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1655025754; bh=wtBEwHgxf1k3VKPNLzIL+M2+HCS54WwTAdfC55EoI9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OkRsSr+4F6L+MVvGWtvyrygNzovKELtMgXuIWQG84o5ff+rTc3HUSzVW5EwGHE4gx
         Nyzwkl7C00WhhglGgZR9Nri3nTWpF2MnZBoCzAygUOlaO4GQ5bvBBQqwY0TdU6jT7m
         OJqaYwVDnJhuxwXUw7WndxsCl63q0VND+rJoTpgo=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        James Willcox <jwillcox@squareup.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/msm/mdp5: Add perf data for MDP v1.16
Date:   Sun, 12 Jun 2022 11:22:15 +0200
Message-Id: <20220612092218.424809-4-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612092218.424809-1-luca@z3ntu.xyz>
References: <20220612092218.424809-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add the perf data for the mdp found in msm8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes from v1:
- pick up R-b tag

 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 1bf9ff5dbabc..b17f868ffca8 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -837,6 +837,11 @@ static const struct mdp5_cfg_hw msm8x53_config = {
 			[2] = INTF_DSI,
 		},
 	},
+	.perf = {
+		.ab_inefficiency = 100,
+		.ib_inefficiency = 200,
+		.clk_inefficiency = 105
+	},
 	.max_clk = 400000000,
 };
 
-- 
2.36.1

