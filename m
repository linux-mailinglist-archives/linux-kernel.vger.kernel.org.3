Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E45A95C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIALec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIALe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:34:29 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8211151AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:34:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662032064; bh=9K/ubU5/lJjGhiEptyCyT26bzZBKS5AKwNVg/nBi83E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QSOcuJpz14lYalHW0hwAbrV86WhHflonxSZNXVfz/7SWgKa7GOJPPC0tbM5v6qdPP
         N2GOxWzXjIesNZIdh4BEnDZRrllg8T8DIyr5G6TIhE+IuvvaPo4nSjxJUiT0ZqQNZ8
         BG1lKixb8MlkqZgL/JqpzD64vyoELj8omM92efVc=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 2/2] MAINTAINERS: Fix file pattern for ARM/APPLE MACHINE SOUND DRIVERS
Date:   Thu,  1 Sep 2022 13:34:15 +0200
Message-Id: <20220901113415.27449-2-povik+lin@cutebit.org>
In-Reply-To: <20220901113415.27449-1-povik+lin@cutebit.org>
References: <20220901113415.27449-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is what was meant of course.

Fixes: 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f91a6b62f2f..895e8ace80dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1905,7 +1905,7 @@ L:	asahi@lists.linux.dev
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/apple,*
-F:	drivers/sound/apple/*
+F:	sound/soc/apple/*
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
-- 
2.33.0

