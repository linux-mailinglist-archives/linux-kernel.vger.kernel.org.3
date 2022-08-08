Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76F458C1F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbiHHDFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiHHDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:05:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20847BE26;
        Sun,  7 Aug 2022 20:04:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7382B5C00BB;
        Sun,  7 Aug 2022 23:04:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 23:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659927898; x=1660014298; bh=Fu
        y+PdPdHN9Bf5D4X8eofeIwHOpq0CD44GhqO7Kk5Jk=; b=XGvpbqBZOJ1FssaCkr
        kpLARtnCFM98q8pkNbqifkPso/81WaWDUKRq3U4T4zCarKooCUFMpylMX07Zrf7h
        jyDX3UuylzUzNxli04o3qdYXp28j2gjBvO3DQmPUfl4Vwgmr1pWOQrmE9VNc6414
        2Fiv9phmoiU15SPXOnk0kgyV1tcB2TWeBnmcH8n7k7d+9DGkqXRXhi4HyEOYsWS5
        /aTEPKyrcUqhhAAQrg0ZbtGUqVGh7mnA+n2L+pwnK0vfWZVj/w00e3ToVy0h7faj
        dTPQmbm3j7HSVYnL1hyc+kIyWi+aWaHnbw0vuXdiGjVyJqeBBSh3/n+Ff35SZThJ
        FNGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659927898; x=1660014298; bh=Fuy+PdPdHN9Bf
        5D4X8eofeIwHOpq0CD44GhqO7Kk5Jk=; b=UcKnjZKE4n0N6QRIshKHBEB+77v1Z
        hBon5puZgPS3NGlZtWJiJSUub+VjVM/EnWr/vRUFeiqKurrqfovSE4p/0vsiewuo
        0odBPDC/Rnzn1MYqLqpeVFnfvf0ptxd7GxIS14HzXu/USetS0zg7bxo4KU0+osEP
        7q6Wvx+v73tl2Ucl75MciDtJn3HOfIeKTH5WqPpd9+JHrcQlyG/uBfeR12A+rvJw
        eWfPML8dt9wuasvU5dYVyWrXG3ATmtCdflO+rXQL2zH8JBF2vOGegmmOOnbjTkH0
        A6QfSm2rvghuFt/pfsvXuohHIDCFRvKrV7Hxj3mz3YFgKuCfaluhkCNuw==
X-ME-Sender: <xms:Wn3wYmPbnd3wUD8bmDBokJleTso5_F3UnwYxEmA1x9kMCDqmL9oNqg>
    <xme:Wn3wYk93i5DG6YYfbPourl1b-NvT6EMZlP1FBhvWDFEBMTO-h3XOyliQKq7kX1aMc
    EGwus8oObGoO5yghxw>
X-ME-Received: <xmr:Wn3wYtQex052RASJxeA4iUJXDGBsR-BV_BknfodRoQLgoDatYywmVrgTrf5H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Wn3wYmsEzviLOl-RW2MwzFEkoPYmyJ3NJ7QQSXkrJTVT1DWM8c5YTQ>
    <xmx:Wn3wYufHlyDIowGZnnjf3486M4wRJ-HHmuNpzlhq_57xjEWJcOR5SA>
    <xmx:Wn3wYq1DFFqJcw_FXsWBQHqoiUCjs-SMeZo-b6qWLmNyvklOAXaFXw>
    <xmx:Wn3wYvpK55LCSS47gH8izaX5Yxu9l1NMhnrvOvvzYURZ2A7bSEPzCA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:04:56 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 4/6] asus-wmi: Document previously added attributes
Date:   Mon,  8 Aug 2022 15:04:18 +1200
Message-Id: <20220808030420.8633-5-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808030420.8633-1-luke@ljones.dev>
References: <20220808030420.8633-1-luke@ljones.dev>
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

Documents some previously added attributes:
- dgpu_disable
- egpu_enable
- panel_od
- keyboard_rgb_mode
- keyboard_rgb_state

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 .../ABI/testing/sysfs-platform-asus-wmi       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..66b262476d92 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,62 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
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
+What:		/sys/devices/platform/<platform>/keyboard_rgb_mode
+Date:		Aug 2022
+KernelVersion:	6.0
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
+What:		/sys/devices/platform/<platform>/keyboard_rgb_state
+Date:		Aug 2022
+KernelVersion:	6.0
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

