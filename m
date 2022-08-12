Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA86591749
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiHLWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiHLWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:33 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042711C2D;
        Fri, 12 Aug 2022 15:25:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 43F355C00D7;
        Fri, 12 Aug 2022 18:25:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Aug 2022 18:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343132; x=1660429532; bh=0Y
        iK5scLqv7YJI3+IlX7HQcxM6Vz4adJuNg5MHEkMoY=; b=pe+37fDVNB9E8ksAIX
        fjSMyuEiRzZXLhSiYsesXyRnVbR9oo4shGxys8faxW9gYSdq4IKUjUbyVP+r00cr
        xpINzgp4IdedcnIzkPghRV0j1h6+jkte+4o9NuyDtILJKtIbQhShWhOnOK8f13Jq
        SPlXHV4iZHV9APtgNZ0P0I/w17VipF80l5xBRh1SUMlKicscSFGNGt3R6lFeppEg
        FYw+R65+L06hYGb+89YNcqw9FtdI1JqiWX87r7yeNrnXGtOO1ChLYF3/RpO3fWiu
        guPKOf9+UKvviHdW2Y+mUgT0+bsLX/A0ayc/8h2FrAUeCJY7GyBKhRQxxSPnBky5
        ufUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343132; x=1660429532; bh=0YiK5scLqv7YJ
        I3+IlX7HQcxM6Vz4adJuNg5MHEkMoY=; b=mF5DR8gVl16+ytcL9Im6uyoddI30W
        DGuTGZ1hWPYOV56gWY/fB2GhoDnHQol4EdzsxlxAmnumk6UDbVvyJYB/ipfV1HqD
        rQyY37cR8Zf7tRVEvkJPivMY3vnB0GfO53llHUAiYNRkgYm/HVQywA964i1UMy3h
        Eqv2sLID+/nHPFVLQtR5Dn4vLaa5v6AOm00CZItat7tJpp3RsG8ehtfNMI3HyoFt
        KNXVl44lmRNU2F/PiKxjVVBjBwAllloNyoG8o+o3Upxz2EBZbahjkfseQqpvqg1H
        vPPyIS3Tqp5msyI3GkJFqllMzdvp2e8KB5JFXrBkwpKmhYme/BINjLeoQ==
X-ME-Sender: <xms:XNP2YkzuZprarfHHjl5CtmhkgBj46tfTMOvgficaPZSlXL33AsL8zw>
    <xme:XNP2YoTa8RWPCk6llU_caHxgFedsyDw25_ltKJ0P2PiAID5BLLi6uXH69RPs49huf
    _5XLH3K8dKJ-lHxi-8>
X-ME-Received: <xmr:XNP2YmX6XIMMm0uA1d7l09yjC3rY-NBDKCaJPqke5IPmwuz1NP_TaGyQBJW6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:XNP2YijHjCe2XOQ4_qEvitxbwP5t_PWJDHOQeLYqeMDiXDOsMTCfZA>
    <xmx:XNP2YmCAAteboUv9wMTXLiZRP38g89NCaOPRjiDqV61RPdU2uJ2o0w>
    <xmx:XNP2YjKFzeSFYRDLUfAfHh7njXpcAmc7-UVSsMC0Y8Qaeqy_nJaYjw>
    <xmx:XNP2YpM5uS99Ha5vsDgRAtkVn8YmNnhegb0Xy7qY4wlK3E9Fqk7qcQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:29 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 3/6] Fixes: ca91ea34778f ("asus-wmi: Add panel overdrive functionality")
Date:   Sat, 13 Aug 2022 10:25:06 +1200
Message-Id: <20220812222509.292692-4-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812222509.292692-1-luke@ljones.dev>
References: <20220812222509.292692-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel_od attribute was not documented, this adds the
required documentation.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index b984bdcd0c40..574b5170a37d 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -74,5 +74,14 @@ Contact:       "Luke Jones" <luke@ljones.dev>
 Description:
                Enable the external GPU paired with ROG X-Flow laptops.
                Toggling this setting will also trigger ACPI to disable the dGPU:
+                       * 0 - Disable,
+                       * 1 - Enable,
+
+What:          /sys/devices/platform/<platform>/panel_od
+Date:          Aug 2022
+KernelVersion: 5.17
+Contact:       "Luke Jones" <luke@ljones.dev>
+Description:
+               Enable an LCD response-time boost to reduce or remove ghosting:
                        * 0 - Disable,
                        * 1 - Enable,
\ No newline at end of file
-- 
2.37.1

