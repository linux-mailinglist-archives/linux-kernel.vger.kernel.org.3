Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F48591748
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiHLWZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiHLWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:25:32 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339711C3D;
        Fri, 12 Aug 2022 15:25:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FD785C00D7;
        Fri, 12 Aug 2022 18:25:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Aug 2022 18:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660343129; x=1660429529; bh=Rm
        oH5vq/I46MuGI9F8KRFZv8vU/H1wAMHsY9Io/i5LE=; b=fOe+2pvDLRY/2USbMh
        bb3hVdYJPWl7nTMs2GM0qCLpl7GSApcSrrCIu/e4mlbqjg81kdbMvwhcQ7oA5WIJ
        8Lo3XuoVR+3AHH35wpfAf7bAxXTZK2u/Kiq+GY5Lj3do8luLfNjlpw7nCASu1a8t
        2Tzro+BKbTIDog1eTeYdJv+XpiIs+TaDCwXAqBYGcbweoLuK3ID1+puCsEkWvYS2
        /BZEpqwgKCZTOD0NGLHmMxGQKXUfgMyxdStDapb6aZUfhLwVDq6peKfmwADYb6L0
        luDUQw+WOHwNdwPQwkA3hMMI0vgKICRNgk75YK9pxDw8zA9+aFFlqL+jfqihIg5n
        Td5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660343129; x=1660429529; bh=RmoH5vq/I46Mu
        GI9F8KRFZv8vU/H1wAMHsY9Io/i5LE=; b=VuzKFfRjJ48cE9KqPxe2qJKWL2fIO
        tfD6n5sdxWRTZ124dykuMk0tLKJfmsVejPw8eQuBVVwAt0BhVMBQkJEocgU2CcSD
        ZRu5U1k6K/cI8VUWZKuXmYW76TwfljiI5t5t/75xynyJp3oALV9qKYjHTN/SGtww
        /1xS48VAXQ7X5HGDQeLqaYFi6qkbmfyLCHQFjbS4pqwf9xkYo1/D8UeZ99kN/Rzu
        1UyBB8G2dz1Qu2ceWK1EiH3iA/B8jNf3pzdXo5EVWA5rio0eWiqCp3PPj5Mg2HP/
        2lEzg51KdXBt0YZ4kXMaY2/FcQLpSaZ6q6EmWkQ+MR1hB3dtkge73BZDw==
X-ME-Sender: <xms:WNP2Yro5YAsN4LRHe1PfrK_iyzZyco9GXW8wU74a5oLF26XnZeZw0g>
    <xme:WNP2YlrMQxcn2t8UKRwBBO6wJpfjEF1kw80wUmrVH_V_r23iOSkX_BGH349rp1Upn
    xj91_kp8ju5Z_YxwHE>
X-ME-Received: <xmr:WNP2YoM2zzfycGGWqlRooTIFnu5ye5lvLrpNNOJQ5LT4prwHRlz1vzYIQ1ij>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:WNP2Yu5T2w3QJnqX-GCjn4bxhGXn6wxwIKPsz39RYfSQmjE8u5xUmQ>
    <xmx:WNP2Yq5UdvMyKn_64w3UcAZBBms0T_2nyhmtQcRgY6PAz5EgqAecIw>
    <xmx:WNP2Ymj-xG7efCw49v8Fe3c5EGtOTpXULKrhj4xDU0bE_4jF-izeFA>
    <xmx:WdP2YqEJyuzd0yNnkYwiQ7zI7Aj6sdIAjDPs3aYHhi-hlAWZ5HObHA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:25:26 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/6] Fixes: 382b91db8044 ("asus-wmi: Add egpu enable method")
Date:   Sat, 13 Aug 2022 10:25:05 +1200
Message-Id: <20220812222509.292692-3-luke@ljones.dev>
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

The egpu_enable attribute was not documented, this adds the
required documentation.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 Documentation/ABI/testing/sysfs-platform-asus-wmi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 0f932fd60f4a..b984bdcd0c40 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -65,4 +65,14 @@ Contact:       "Luke Jones" <luke@ljones.dev>
 Description:
                Disable discrete GPU:
                        * 0 - Enable dGPU,
-                       * 1 - Disable dGPU,
\ No newline at end of file
+                       * 1 - Disable dGPU,
+
+What:          /sys/devices/platform/<platform>/egpu_enable
+Date:          Aug 2022
+KernelVersion: 5.17
+Contact:       "Luke Jones" <luke@ljones.dev>
+Description:
+               Enable the external GPU paired with ROG X-Flow laptops.
+               Toggling this setting will also trigger ACPI to disable the dGPU:
+                       * 0 - Disable,
+                       * 1 - Enable,
\ No newline at end of file
-- 
2.37.1

