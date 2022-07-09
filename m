Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888C56C8D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGIKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGIKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBB4B0DB;
        Sat,  9 Jul 2022 03:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A428360E1F;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F5C341D1;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=zey4tGTYwo+i6XOOpjzV+Gd4H28ji3iNCU1YJEXf/64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHks/kKkzMDW2J7nd/eCLW96GmHhCGBjFXbq7AATqDMh+wDx0ZS1ilQ+X6EjuiB8F
         VPyPOvtEZ/NEjYT6tkbki0H5K+WubVpy3yKPJ0VcYOxCXhJuB7MCOh7khOFW+TfLRK
         G/dgshM2sWsvgiCaxMusDH6mrs9CFm05/RRAANzq90v6Em21YCiJ1UbdsHpvZSfkSi
         twD7ASb4hpeVRLcOm9CF8VVfTAquxrMgBWKqMfnivh2Ic0c98z5IkZhDVKWFiLDgBr
         ksWMCm31TJoaiKE6IBY9msW7tM8gFVL+FHQ8w7ghriBJbhCzhjngqH96HyCvD6uYOC
         1pKtRH/ur3TBA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EHS-Or;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/21] docs: leds: index.rst: add leds-qcom-lpg to it
Date:   Sat,  9 Jul 2022 11:07:33 +0100
Message-Id: <a876a10e02107babbdfb9dda5daa0d8c83ae5049.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document was added without placing it at leds index.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 Documentation/leds/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index e5d63b940045..014e009b0761 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -25,4 +25,5 @@ LEDs
    leds-lp5562
    leds-lp55xx
    leds-mlxcpld
+   leds-qcom-lpg
    leds-sc27xx
-- 
2.36.1

