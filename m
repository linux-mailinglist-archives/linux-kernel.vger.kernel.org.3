Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD7591744
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiHLWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbiHLWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967AADFF9;
        Fri, 12 Aug 2022 15:25:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C43195C00DF;
        Fri, 12 Aug 2022 18:25:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 12 Aug 2022 18:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343125; x=1660429525; bh=WD
        JjZIPzmGrvANwtsGfu72gUriLccPqBOATCf+65cIU=; b=iqfL5OP+d/iGe+r1O1
        xwLBJN6PTV/WjEsDXW8ODZgdjXl9AJYcPQsQ9sU3OtRpxIPF8P4u51dxqiCMcNTR
        W8o5w92EElkpc6SDh7im6bNzP6Kka10MwVWg1SrPrgiiOqsPJ3vF1kfev7/A7ByM
        HMwtm7osOJBjlzD2H9jxQkZVbdFb/j4zVOVnuGsPaalNPYzfcVMO5l+Z4EUv0B9B
        jXP+cB0FM5WjHGL6vPvZFQurRD0+dt/m2J6SHcTovsqr43z5Y68rd63fkA8RUF12
        UrlHaaLHEm4zk/gJbbP+QxzOgr2XdbDLvJ1g/MMKJl0GiXjQqHgaCkkSfaqfRPSf
        WwIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343125; x=1660429525; bh=WDJjZIPzmGrvA
        NwtsGfu72gUriLccPqBOATCf+65cIU=; b=1viNpmd6647vguvt0Z0VaO9MUIbIS
        4UuCrAvaLOtzYsNroZgq34TVfIaf9kyakzC2E/4sfVp+waYsIiZ81lDIJ7EJqMTn
        t6ErfPOTkE1X28LtdR0OVgYzk8+x3IhbZ/bwhWnhMiTrRymLMyQcB3SutQubxsIp
        H4I8YrGOGpn9NdTaXIx8yrDrha3qkjU5Lba7/4R5QRioeIIqSoPejPTIwKMDoCj8
        QpBBKOZX9jk/osynLOc2H2ApUkSMTNq/SkTaAAVtBWroaA8BybJWgIeAeH0Uz+PN
        gWB8uAHihxfcPz5eYAopr3eTx6AEUdbLFdfGBEWk8kQtXnOjC4BecG/Tg==
X-ME-Sender: <xms:VdP2Yk1pEcuQACKNfD7eaDcT1YjquVUiNOD-OovXzOdsCznRJu1FWw>
    <xme:VdP2YvEf9ztjz40w4otp-VnvAUafJg6MK8IQ76KsYQf-KGVvKm3WMlY6W2GMOO6yL
    x40irGphtPUPz1si44>
X-ME-Received: <xmr:VdP2Ys53d_aWd3MEenk6cjH-Wuj_RzBVUZRkQf05OnsJIQsRaEit5detFkn6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:VdP2Yt2CTKHqtb5UhpMn1LeqPBr1Kkix1pLy3Ioo56zxj6q03tNZ9A>
    <xmx:VdP2YnEKJvGYyowK8IdWRe4VAmCQc9_d_5mZzk1makUSa9SfItF4pQ>
    <xmx:VdP2Ym-UpvluF-4DcvwDD7xWcPizi5BcokNnEH0J6KJOmJdqdwitkw>
    <xmx:VdP2YsSUgyQa_V8Ku2euLjd7mjLaHTc2KBJRtWAY-MFs_YMDC1zNpg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:22 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/6] Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
Date:   Sat, 13 Aug 2022 10:25:04 +1200
Message-Id: <20220812222509.292692-2-luke@ljones.dev>
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

The dgpu_disable attribute was not documented, this adds the
required documentation.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 04885738cf15..0f932fd60f4a 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -57,3 +57,12 @@ Description:
 			* 0 - default,
 			* 1 - overboost,
 			* 2 - silent
+
+What:          /sys/devices/platform/<platform>/dgpu_disable
+Date:          Aug 2022
+KernelVersion: 5.17
+Contact:       "Luke Jones" <luke@ljones.dev>
+Description:
+               Disable discrete GPU:
+                       * 0 - Enable dGPU,
+                       * 1 - Disable dGPU,
\ No newline at end of file
-- 
2.37.1

