Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4702A563FAD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiGBLIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGBLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A8215A35;
        Sat,  2 Jul 2022 04:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E94060C83;
        Sat,  2 Jul 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27343C385A9;
        Sat,  2 Jul 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656760068;
        bh=KDI1jzkUP4eh41YVnqX5NxQnMBRBjVU461+yKG5u4bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkCwDsaeoq0TV/6RUbsrb2AsN/uabFKcZCNZOy33hXiNOQrI8pDY4J7J7vOY21EBv
         ZlfS9KN9KKKSomNk5J55wrH0PC+Bbe5RkgmXOQjlIuuF6oF4pz8T5+ymmeNKAfZ3Kx
         cu4RQ5jp0i5J/x1kl/gIspKP0qj7BP4zzchs5mDIYOoAWEl0NIFOIxctkAwaZhLYwH
         oDOWv1XExLUCX73ntzMkR7aJtF6dM1nHX1iKbMVD0Jmb6FkhohqQB67Xjxv1n92AKk
         29TjYqqfEluHcQTpooOn7IXSbRdakeTEJCKXHFMYXVPAaExoaJsP5+VwaN6KF6t1Rt
         wieKFwnKLENjA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7ayX-007gsL-R8;
        Sat, 02 Jul 2022 12:07:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] docs: arm: index.rst: add google/chromebook-boot-flow
Date:   Sat,  2 Jul 2022 12:07:43 +0100
Message-Id: <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
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

This document was added without placing it at arm book.

Fixes: 59228d3b9060 ("dt-bindings: Document how Chromebooks with depthcharge boot")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/

 Documentation/arm/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index 2bda5461a80b..495ada7915e1 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -31,6 +31,8 @@ SoC-specific documents
 .. toctree::
    :maxdepth: 1
 
+   google/chromebook-boot-flow
+
    ixp4xx
 
    marvell
-- 
2.36.1

