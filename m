Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FDB5A37D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiH0NQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0NQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8A6D9E8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 06:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD15B80064
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 13:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCE9C433D6;
        Sat, 27 Aug 2022 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661606178;
        bh=IWBzYlrnmUPkksd7GMSRNCvwLJIO8ZnQzL1q9UgX1VE=;
        h=From:To:Cc:Subject:Date:From;
        b=hc5T7ZsIPdcAJDjFDCEPW5RuVYqtq/n+Nd1kLKqFGwgUBYQmVDw4RUTvWLQlVzDTd
         i7DpOqm5aaF9to1yMvq50GHWGh+7UnQcO0qSW4pYQtucZOkjCmJEdSp8Vzs5BcmBnu
         rCu0kIN4YXI9Jqwqva7wSq7mlNs3ElWlEJo3PTSE476kJjX8cF/yU3Lxxt4i4aI6Ry
         hNvVm8xQpkNImbkRTiRnJ9YdahN69NQ0aSNkmI3+LzdAz5bTZ5V1qoRAdazR/zGWC2
         yKD+qGX8t4hNLYi2GbnpHJyCdaQCH+JIS6/NNOLrUe8PpQs2UtZi6Grjwhio6T1xFq
         5Cy7UVRsNJS+g==
Received: by pali.im (Postfix)
        id 52B33C7A; Sat, 27 Aug 2022 15:16:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: turris1x.dts: Fix labels in DSA cpu port nodes
Date:   Sat, 27 Aug 2022 15:15:38 +0200
Message-Id: <20220827131538.14577-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSA cpu port node has to be marked with "cpu" label.
So fix it for both cpu port nodes.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index 8277e0d7fd91..64c0dd733e40 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -147,7 +147,7 @@
 
 					port@0 {
 						reg = <0>;
-						label = "cpu1";
+						label = "cpu";
 						ethernet = <&enet1>;
 						phy-mode = "rgmii-id";
 
@@ -184,7 +184,7 @@
 
 					port@6 {
 						reg = <6>;
-						label = "cpu0";
+						label = "cpu";
 						ethernet = <&enet0>;
 						phy-mode = "rgmii-id";
 
-- 
2.20.1

