Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231B6598507
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiHRN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiHRN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4A72672
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E70A0B82175
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 13:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F6DC433D6;
        Thu, 18 Aug 2022 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831095;
        bh=q0OPuQbcdF1V1h6hlvy81uFHSyeXfFNwWV6JIbldMtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGw3uF1/SlW1blcN279Rxu0Cmdkojc/zhtVEjDGFiS+VFcpEkdHLgAfmnO7pgiV76
         ItZ0qe5C8bmSFjb3SspNPbm1optPk+BIaN73vIzx8l+C9imaVnEm3j88le+2PZ8siq
         0mPTKJNA+RkuvXAKv/mqSfzW03H8SJlAN9yfN+39JQMWXo4laoM5SGF1M6eYizey8U
         7wLk/wtkvcXbaJsVBUE+RbkBVI9zGv4MMdT9QLwobh/2wQ5RD994dBXWn5YLL6IFbr
         zfqP+RKn9TNuMt8hVj7G9JZkhHVfVvPXWjP2POhWXgYu4142A0yWEzfbKlUo4Wz3ZX
         Q8CdPyWQHHQxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] ARM: defconfig: drop CONFIG_DRM_RCAR_LVDS
Date:   Thu, 18 Aug 2022 15:57:14 +0200
Message-Id: <20220818135737.3143895-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220818135737.3143895-1-arnd@kernel.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

This is now a hidden symbol, so just drop the defconfig line.

Fixes: 42d95d1b3a9c ("drm/rcar: stop using 'imply' for dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4cfe795981c8..b3669cf855b3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -713,7 +713,6 @@ CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
-CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_MSM=m
 CONFIG_DRM_FSL_DCU=m
-- 
2.29.2

