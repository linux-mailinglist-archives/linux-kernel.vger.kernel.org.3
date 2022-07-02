Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D693563F93
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiGBLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiGBLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91415A24;
        Sat,  2 Jul 2022 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4C860C7C;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154D1C385A2;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=Jzw0fXE90LTUqdwEmGdDANbmLnU3nO//vKmbl/WQ7m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+wAhT1D3Vaiq9Gz6DvG6+u4eoTHxpAF8VIjCg7mDw5FvSxwI3DIlBdPU6KGUUsiA
         /aCbbIoCJupqNCTyQfLOdUmfYbl3amEm4gacdcqnedSY/s0e6KIG5O9ctaOMMwdmNE
         M2ux8LF0YzjX0cIfBs+Jyr8zIfRcSTAPvcM33lvI2KCdT1Gh5vYkczdXsUcLbPf28d
         2GU4BUscZ/Ed5qR+f9Md+4239kNfJc91dNNta2fG/LYVBLGtj3E6ve5hBs1sBEcEKo
         nsZUAXOBANwy2InfavKDJu9oSIJQTjOm1z2/4IuFVJwQFjgPFIAn4Q6JLUKCnpQp1H
         H9wYN6fu44GAQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gsI-QN;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] docs: alsa: alsa-driver-api.rst: remove a kernel-doc file
Date:   Sat,  2 Jul 2022 12:07:42 +0100
Message-Id: <3cd6b93b36b32ad6ae160931aaa00b20688e241a.1656759989.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656759988.git.mchehab@kernel.org>
References: <cover.1656759988.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file:
	sound/core/compress_offload.c

Doesn't define any docs, as everything is inside the header
file. So, drop it, in order to remove a Sphinx warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/sound/kernel-api/alsa-driver-api.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/alsa-driver-api.rst b/Documentation/sound/kernel-api/alsa-driver-api.rst
index d24c64df7069..3cf8eb4ecaf4 100644
--- a/Documentation/sound/kernel-api/alsa-driver-api.rst
+++ b/Documentation/sound/kernel-api/alsa-driver-api.rst
@@ -86,7 +86,6 @@ Compress Offload
 
 Compress Offload API
 --------------------
-.. kernel-doc:: sound/core/compress_offload.c
 .. kernel-doc:: include/uapi/sound/compress_offload.h
 .. kernel-doc:: include/uapi/sound/compress_params.h
 .. kernel-doc:: include/sound/compress_driver.h
-- 
2.36.1

