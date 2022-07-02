Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3D8563FA0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiGBLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiGBLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE715A2B;
        Sat,  2 Jul 2022 04:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A12D9B823FF;
        Sat,  2 Jul 2022 11:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F014C341D1;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=RlxAXGPPXB8Zng+0XJtcVht/MUZbmaw3OOytm0zauQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLu26mdS90n5KcO20qdF1lidYC71S1Yda+tQxqfRY0OTpDn4NWepHZemVM+xx+xp3
         Ap/mq1hMvcZvY2fbHQHDQEdW5zJDVcN1HBFSLn4X/FgD8XhtFr+BvQgOFLEQZYw1pU
         4hDlZZVNmY9LWXa0wgRrmNWtc+fuFvaGKsWjiW/m580tK/JptiaAL7D2LamlnTIyc0
         SQiTngqwH8boEku50sAqKNhDbrKrEMjcdJfA1UnflXQkyef5i1Ap2m6EaFd6K+k8DJ
         MKJ/HGzDFkq9UHezuQdByBuqMvdTbQJaiM2/Y+dMd7CBhaHS3Y+5T49e1WyJwuHjRm
         Ps34PLWxVV0uw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gsR-Rm;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] docs: leds: index.rst: add leds-qcom-lpg to it
Date:   Sat,  2 Jul 2022 12:07:44 +0100
Message-Id: <9a221f19feed460966fd8e330ce1aeed2a2fb372.1656759989.git.mchehab@kernel.org>
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

This document was added without placing it at leds index.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

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

