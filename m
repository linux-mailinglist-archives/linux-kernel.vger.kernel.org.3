Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C25C53BD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiFBRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiFBRcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:32:08 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40563BF4F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:32:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6460B32007E8;
        Thu,  2 Jun 2022 13:32:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Jun 2022 13:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654191122; x=1654277522; bh=iVhHyOHs9s
        Ft+Gea6I99/NLj9KXC5Ni7NVI+rjhpYr4=; b=ku41WfcJm/1q57au9hfnw1Snjr
        o2zc2CKSeI8zcCv+MNqROOIebvilz8M6X+PZw3fGHYoA4+KSd+NmE7kEMv7hEF/i
        YQ7pUE7L7LPyesxe5QrYdP08zI17KW5B9tzYZ5tGcYfBzHJdhJBblvN+SF+MLpuG
        SwdBMutDMQ3PN5BtdpR2s8pP5oWYa3I++p4dfAfGWd8wIcduel7qTB3aBesr0K1Z
        ZH0dQkrK8jEJsJJOaWAaP4VXWe8qksnvW2FlhU6RFBw7jV4G4i4fUwgUt5PbI6P2
        ExXr+sjXx7QyW6JzqoJllfYCiMlmP54XXVDy891RwaeW7SGPTUrtyGsgPJVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1654191122; x=1654277522; bh=iVhHyOHs9sFt+Gea6I99/NLj9KXC5Ni7NVI
        +rjhpYr4=; b=Q4tu7g4xCx7TgEV9zy+lfHMQGbqy/uBvNqv7xlA/Y6w8Ui2Ruul
        m4F3A+aupb7xDXcgPSmH5s9Cq3L1vA+qGvRA1kCgUrQMbPX4f4H5byEMZuNtkbu8
        Juq2Djk7cPv1zW32gQ6Buhu6bUjewT7nYuvTFU6Qzcp3vVEy3iXZAj9zG8htyspS
        yTd9dfPcgWJ7J+BYC5y/Nj+yGLQotlasYD6b0lXbTpP7WAxEgYQRf7Wj+fo95zeu
        /KCBp7F+5iv+kvqZ1d0tALP2R2nGT+qZImwR8EwspKR7FM2z2iHaVduxBN9z7qy/
        +GcZmtLWjj1XEXnjR6Gtn1bCjRfIal0oSDg==
X-ME-Sender: <xms:EvSYYkupaShFF-Wl7nEVb8VhhENtvZUWHSH19irPt5nwK9hc7YThsg>
    <xme:EvSYYheTMIaG_jTHYGZ_P08Mn2IwFFTrZPPWz5ybsWbvEjZ7sxsX5_pqUxnhJVy07
    7_bgLisPt6Zp60wwPM>
X-ME-Received: <xmr:EvSYYvyiaUnY52jRB3M9W9twkQ2B2z4UTjNva2g1N-HwJLH0uJJgiAlvtK6f8GLdhbTu1veZZKLBHVl4C2pPh60LZJ8Q5dTW89ZvaT6WrOzHfibXxbrOECgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleefgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleelffdtleffgfeigeeuteevjedtjeelgfeiueegledthfdvjeevteehhfetheehnecu
    ffhomhgrihhnpegrshgrhhhilhhinhhugidrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:EvSYYnM5nDexswN_7K5QmjabxvXArotk2UzyLnAV_AFNEWB75-Vhew>
    <xmx:EvSYYk-MafXAfpYm7nijXVHsfQxSuZ2h-FQDhvQ9aSLpapX3-H7mPA>
    <xmx:EvSYYvVTuq3Foe-xecjZm5YiJyLD6Fd2W7ujJZBHqME_SowruMrvuA>
    <xmx:EvSYYoZhx4CnsyoQaBxVHLiFBmGjK0uxNdC6VZKA4DgAEmsoUUnWfA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jun 2022 13:32:01 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add ARM/APPLE MACHINE mailing list
Date:   Thu,  2 Jun 2022 19:31:44 +0200
Message-Id: <20220602173144.2263-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55114e73de26..621eeb037a91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,6 +1826,7 @@ ARM/APPLE MACHINE SUPPORT
 M:	Hector Martin <marcan@marcan.st>
 M:	Sven Peter <sven@svenpeter.dev>
 R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
+L:	asahi@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	https://asahilinux.org
-- 
2.25.1

