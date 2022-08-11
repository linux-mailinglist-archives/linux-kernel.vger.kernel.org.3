Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817985903B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiHKQ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiHKQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:26:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F597D6D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:07:39 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660234046t47ds8n7
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 12 Aug 2022 00:06:46 +0800 (CST)
X-QQ-SSF: 0100000000000080H000000A0000020
X-QQ-FEAT: xqT8U4SkSphZ0tDRVh3ihB6+gn7JJNiM4lisSNR2JoYVl1eB/2DwrreHIGBke
        O7jKX+zyeM2ytEHsXcTnHsLY4pvU6KMy6IHJeuxTPygVo9EXOiBxFxI6TYBA81gPuY3H90A
        jEgfn6UdQ6A/E0R78ms1AwyQE4tpEcr6tgvDEtczB6SrHwuEtAd0bSxjs3bSfdshdm4xdiY
        zMp/Y/TLju4xANYvj1sedgDS2wE7gJB7nPXFG2hoKEfwVGJrA7dunp2AqY0mQgnlfl5WSE1
        PywC/NvepLNEyN1959q6zsZjsf6UKqZ8NCMycH49+X/uWKYArw2lLibkiWZxBFu4ZrIml7+
        EeJUBNzkgoDc/stLTmBI2OhtLr/qZ5fYn5ayWw8
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] drm/amd/display: Fix comment typo
Date:   Fri, 12 Aug 2022 00:06:34 +0800
Message-Id: <20220811160634.13938-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `aligned' is duplicated in line 1070, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index b1671b00ce40..0844b3eeb291 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1066,7 +1066,7 @@ static void optc1_set_test_pattern(
 				src_color[index] >> (src_bpc - dst_bpc);
 		/* CRTC_TEST_PATTERN_DATA has 16 bits,
 		 * lowest 6 are hardwired to ZERO
-		 * color bits should be left aligned aligned to MSB
+		 * color bits should be left aligned to MSB
 		 * XXXXXXXXXX000000 for 10 bit,
 		 * XXXXXXXX00000000 for 8 bit and XXXXXX0000000000 for 6
 		 */
-- 
2.17.1

