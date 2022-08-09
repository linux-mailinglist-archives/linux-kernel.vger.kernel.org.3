Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68358D21F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiHICvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiHICvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:51:31 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027501EAD0;
        Mon,  8 Aug 2022 19:51:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 60F0E5C01C1;
        Mon,  8 Aug 2022 22:51:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 22:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660013479; x=1660099879; bh=38
        udBJAW+pe0pQZBWrn35ZUdlsO4rdjQ4UZPBf5LI80=; b=KWZLBE9HMZDjEFNCgt
        URxlJ6EQeYcRdrc0+ZPhBRHZTqHQ+LcCQQXxPqCzi/aVrRYvFMg1ICy5qznPLKbb
        jtnCmuMGITlgqDBthEY/BW9BeB2945tGAL2Qe9ZhKCUwwV9W5B7//JbOn+YEUEBf
        LN2kXsLlwKrENONkc6ZUmL9L+rFSw+NiuFrprNTPfnjBUi7ZquwYntxsCVsUnwMo
        pIpAKQQKiovoSXQ17r03edczqnovGYHcnwcdbkIZWqwFGgLTuPgfQsEG6b3Jkz/L
        pW8GcuNHgbmKU0h5hD0bu0YmIaNsZbOvwEZ736w0v9aO/kVw2gEkc2e307Nq8TO3
        2/3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660013479; x=1660099879; bh=38udBJAW+pe0p
        QZBWrn35ZUdlsO4rdjQ4UZPBf5LI80=; b=PEUEEFHrLEO08JA4Wt9SMrrvRdcRm
        3mQxkzliS0so03pHo93NZ8YTNRHQq2FC1qcJP16ELGt+1xzzD8ZlrfwG8dOOpltd
        cPe5S9YdNu+kVt16YhgYhEE8k2L4tEapwFN5jIzTLAdfWmz3iUT0zpMFMWCDrvv5
        iLKPN3/HisKqq5KStY1WovzArOu/dJF/Z5VQWYvMJLaj2CFzQH4XSOwM71gsHEkJ
        +lYRhHOiZ/NAAGtH0ZWERP2V6YfqUPTj17svfZB639I9u6kFohdN9yXuvmkjXS3c
        hsnl5oLj+q1HH/+t1IBTpUi5Pks1J2rpouzQuRfi/eNT33Jad++W7B1Ig==
X-ME-Sender: <xms:p8vxYoGiQT-bYuX8W9OiP_78M0bpLwWqogKWreJ6ZVELKRCQb_Qhkg>
    <xme:p8vxYhUz1NuYya1WuifDxhTCQVviSiQRtkzcS13lscNjbrIg6zqq0Sll604ITgaVZ
    CNgEXYM1wI9uSwN8rs>
X-ME-Received: <xmr:p8vxYiL2-oOoWox8Zi_UKfpTjizV-vyOVwwfhQztlBGORZQ0I1LHCKECdch_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:p8vxYqHEOFNm8y4NP7TGdFoULVfEroCQH0bieNzvGVqpr9oYTgAZTA>
    <xmx:p8vxYuUihI5-QsoX5HpP1UpA8Zpml69biEW71ES271KuEcooRR0zcQ>
    <xmx:p8vxYtM1n6dXBrfgE9uOfjLNoA1MUHFVC596TEsEVv9v4ga-bblmGA>
    <xmx:p8vxYswrd0pJO0o_ab1MB38GM92cWiuDtgRzmfhehx-yDxv7ur0Q2g>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 22:51:16 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, pobrn@protonmail.com, pavel@ucw.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 4/6] asus-wmi: Document previously added attributes
Date:   Tue,  9 Aug 2022 14:50:52 +1200
Message-Id: <20220809025054.1626339-5-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809025054.1626339-1-luke@ljones.dev>
References: <20220809025054.1626339-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documents some previously added attributes:
- dgpu_disable
- egpu_enable
- panel_od

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 3e3f2dcf9bfa..541dbfbbbb26 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -48,6 +48,34 @@ Description:
 			* 1 - overboost,
 			* 2 - silent
 
+What:		/sys/devices/platform/<platform>/dgpu_disable
+Date:		Aug 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Disable discrete GPU:
+			* 0 - Enable dGPU,
+			* 1 - Disable dGPU,
+
+What:		/sys/devices/platform/<platform>/egpu_enable
+Date:		Aug 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Enable the external GPU paired with ROG X-Flow laptops.
+		Toggling this setting will also trigger ACPI to disable the dGPU:
+			* 0 - Disable,
+			* 1 - Enable,
+
+What:		/sys/devices/platform/<platform>/panel_od
+Date:		Aug 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Enable an LCD response-time boost to reduce or remove ghosting:
+			* 0 - Disable,
+			* 1 - Enable,
+
 What:		/sys/devices/platform/<platform>/throttle_thermal_policy
 Date:		Dec 2019
 KernelVersion:	5.6
@@ -102,4 +130,4 @@ Description:
 			* awake - 0 or 1, controls if the keyboard LED are on during awake
 			* sleep - 0 or 1, controls if a suspended animation is shown.
 						This is only active if the AC is connected.
-			* keyboard - 0 or 1, unknown what effect this really has
\ No newline at end of file
+			* keyboard - 0 or 1, unknown what effect this really has
-- 
2.37.1

