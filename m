Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23445AA398
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiIAXQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiIAXQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:16:48 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4080595AE2;
        Thu,  1 Sep 2022 16:16:48 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id D71F24B0;
        Thu,  1 Sep 2022 23:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D71F24B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1662074208; bh=zC5DmfnmcyjofvsDiYdnGJiX2/WFvTpVfVyoJDzoBRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPl0qwAXf0jJUJ+kMF14oSlUaaHgYmePfwKdJ6N/JECv25bH/T4ovJHz145s0WxT/
         696jpqbGAgSQPzuNDCSrmx2eWqc/+3672qx65iehKUKRTdPJ9a54sYhbcDhtyfBmin
         zcjnOInu7OsDz1K4zO79Q5s4a0tRpWy2VBdF9ncZkaJi54RkuAWZNUA547z967B//r
         GA68IyuCquocxcB+Exob3uP5Vi6CmM2FT34KBjrhKtglsUsX3soruLahC9++vr3IIv
         E8UT84fh/D0RlkY34NJvGtnTBfraynt0b9XXCXMpOvhMo5e+ZYb5eiInyyZmnBd+ys
         pG4owU65/plTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/4] docs: promote the title of process/index.html
Date:   Thu,  1 Sep 2022 17:16:29 -0600
Message-Id: <20220901231632.518583-2-corbet@lwn.net>
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

...otherwise Sphinx won't cooperate when trying to list it explicitly in
the top-level index.rst file

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/process/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 2ba2a1582bbe..d4b6217472b0 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -5,6 +5,7 @@
 
 .. _process_index:
 
+=============================================
 Working with the kernel development community
 =============================================
 
-- 
2.37.2

