Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF358A7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiHEITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbiHEITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:19:42 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1A7695C;
        Fri,  5 Aug 2022 01:19:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 801E63200927;
        Fri,  5 Aug 2022 04:19:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 05 Aug 2022 04:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659687575; x=1659773975; bh=aB
        qjFOkmI8PL7POoRXMtjyOJErJ2AaHnIz8e0+S1/gE=; b=idSlT92q9EyUPg/nvQ
        ElPAKCQRibCOJqOBGW5LUTF0P67dhzxs0m3voxESZPbuQHxOUOSg3Fx7HCjvYxGZ
        J88N1uTB0g2ypVb65s+wiIseG+/zI+5OzMNXFjEXLJ7AIl1ku7v+/UhB7YC32eq/
        DqDmEsLmO4P/flpnsgYkvZJVaT1gWGL67S4hWeNfNJ5xJDMkl59Q/UH+5m4bcSyt
        EWBz69SpcVHdGNNbqehN1H7qDVYfBqe4B2Spfb95tQ68gwuoJn6N52EoJYx2PdGt
        3ziQhBL8NAK8Rz6PH+MycxFcnj3fyUJPU9nK0w5w5xuXajyHi+sjQ5KyFNNZPB82
        b0aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659687575; x=1659773975; bh=aBqjFOkmI8PL7
        POoRXMtjyOJErJ2AaHnIz8e0+S1/gE=; b=rwaCDdBqLz2wfAxM6Ov2BtRkADeCd
        WbTDckylZVzGP585p7dpLSWyU+gpakJS5yt1gaR992WZu7KLmMpKgbCxnyd2egr4
        NyAVsbDdAvbw5y1tZhdKMlblpDidlNuM8kKCtnlxH4sBQjW+QO7NEdgVbE4q72CG
        8JypY4wVquMr+9T9i8CU4dlRjCGUioYIrtzVFurQKjf9a0OuBp0NbLEhbSBRBoJY
        HbfdPqpWRSCckIsuA1CgIux3dKsAPBaIblFmMDsmLJsC2hqjxGfW9GMAP19nD+sA
        RpWjOpEjWTGF5JcCSSDZUoV0SdINnVX1REdbSf7lUsi+fWge5sCbdQLZg==
X-ME-Sender: <xms:ltLsYpUDcRdiJnXUrTqrfR_fiuOG9YooJFCkURGKNaCP3eYBOmc7Kg>
    <xme:ltLsYpmAqE9q8TkcyiCgb1umPgU5n2NiFDTUkQUvf2pYNe-OFh8Zzp2z__hRkJHaT
    G6llXSsQuGddu8o_uI>
X-ME-Received: <xmr:ltLsYlaPtICewcjhW1XVqAZH3b_Jv_zERfvUeWaAXdZzRxgajOj1BTza7iIR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:ltLsYsW30wH8OWFZjia1fmhacRwVKikRpF3EaI5ObKefLhaTry4lmQ>
    <xmx:ltLsYjkBIHpI5GRdNHWBDWxeCg9YQlGxbrGwl32afC7143bvSOO43Q>
    <xmx:ltLsYpdXLNCHeghneiMYSaJLF4w7R6e9uG-L8k07XrDfWVI0vuJCSA>
    <xmx:l9LsYoyc6u_oB-8Ncrr1UNZudLhwKV_zu8mzpVCSzVsnACgJLIhCwQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 04:19:32 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 4/5] asus-wmi: Document many of the undocumented API
Date:   Fri,  5 Aug 2022 20:19:08 +1200
Message-Id: <20220805081909.10962-5-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805081909.10962-1-luke@ljones.dev>
References: <20220805081909.10962-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..afcaba6c4bfd 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,53 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
+What:		/sys/devices/platform/<platform>/dgpu_disable
+Date:		Dec 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Disable discrete GPU:
+			* 0 - Enable dGPU,
+			* 1 - Disable dGPU,
+
+What:		/sys/devices/platform/<platform>/egpu_enable
+Date:		Dec 2022
+KernelVersion:	5.17
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Enable the external GPU paired with ROG X-Flow laptops.
+		Toggling this setting will also trigger ACPI to disable the dGPU:
+			* 0 - Disable,
+			* 1 - Enable,
+
+What:		/sys/devices/platform/<platform>/keyboard_rgb_mode
+Date:		Dec 2022
+KernelVersion:	5.20
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set some RGB keyboard modes and features (write-only).
+
+		The accepted input is "save mode speed", where "n n n" options
+		are:
+			* save - 0 or 1, if 0 then settings are not retained on boot
+			* mode - 0 to 12, each is an RGB such as static, rainbow, pulse.
+					Not all keyboards accept every mode.
+			* speed - 0, 1, 2, equal to low, medium, high.
+					Only applies to certain modes.
+
+What:		/sys/devices/platform/<platform>/panel_od
+Date:		Dec 2022
+KernelVersion:	5.20
+Contact:	"Luke Jones" <luke@ljones.dev>
+Description:
+		Set some RGB keyboard power states (write-only).
+
+		The accepted input is "boot awake sleep keyboard", where "n n n n n"
+		options	are:
+			* save - 0 or 1, if 0 then settings are not retained on boot
+			* boot - 0 or 1, controls if a boot animation is shown
+			* awake - 0 or 1, controls if the keyboard LED are on during awake
+			* sleep - 0 or 1, controls if a suspended animation is shown.
+						This is only active if the AC is connected.
+			* keyboard - 0 or 1, unknown what effect this really has
-- 
2.37.1

