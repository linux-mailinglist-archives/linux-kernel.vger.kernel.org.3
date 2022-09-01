Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464665AA399
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiIAXRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiIAXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:16:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12909AFE7;
        Thu,  1 Sep 2022 16:16:49 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 2A95B4B0;
        Thu,  1 Sep 2022 23:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A95B4B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662074209; bh=GP+jI/OmcP1ezTMxKf+XkGnohxp5U+e1AerLNBe5NI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crN6744af9TaacEMy3wyiVXPGVCVgjiXUiNoCKjSKTg4cqJolf450MLwxRChu5WIZ
         C/jbtjatI+X9cKKku/rXJyKeFOb2GS3/lQtlnQZ5PD/RDdGrPOtq25nozehEgNuP7Z
         XU+UMCB9Qlvf/mWQ2f2fL7az7UnMgg7jjHj2+Ln/DD8qOtHhvTVlmxi9WX851W5fiF
         gK8X7UWS2mN7FQDzaq64LkhSxA+ur/UvrSQNd34Rev5sq6L+FfrF9z+lbMQaUKHLXo
         Zaru/KTBSp7/Uj24zhw8IawR7vRcZOdDw0zm8w18pAaYZMYkHLJxcGgJtUPRkRAJOb
         TPsEzn1E9bRhw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/4] docs: remove some index.rst cruft
Date:   Thu,  1 Sep 2022 17:16:32 -0600
Message-Id: <20220901231632.518583-5-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901231632.518583-1-corbet@lwn.net>
References: <20220901231632.518583-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some useless boilerplate text that was added by sphinx when this
file was first created; take it out.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 428cfd8e369b..1e983e3fa6f8 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,11 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-
-.. The Linux Kernel documentation master file, created by
-   sphinx-quickstart on Fri Feb 12 13:51:46 2016.
-   You can adapt this file completely to your liking, but it should at least
-   contain the root `toctree` directive.
-
 .. _linux_doc:
 
 The Linux Kernel documentation
-- 
2.37.2

