Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AEF484BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbiAEA2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAEA2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:28:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307C2C061761;
        Tue,  4 Jan 2022 16:28:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so79411026wrc.5;
        Tue, 04 Jan 2022 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=5q60KLWpl1cwBDORBh1ZcKS5zSr4xHPdx6qj2Tcyb+I=;
        b=TyMRMRczEHnqNUz+FlHuNqOGaDSt6Hjn63urKWR/MUqrVUk/X27sQ1OFjd1gm2SBmk
         W0kZsBNinnUZDNj3YJqLDFYBH81AnUS650m0oRGV9k90xJ76Wnc6A9tZOO3J6+a00Jtq
         tBd8Z5UOYa6vqdSczaIIs/dR9TkWmDPPOxqaN2qVyETMfOtpGdijWfIwhCuYI0oeQF97
         K4Eu8UwIIywcBzqkIrxs5NiUOY65DOXnCm22n+s13k8mQIR+iaoVmRwYWni7AxgiZCF3
         0SdQ3aqRRcllhCWk6DM4OdF6uAx7gCBewBjx2o6wwIbwkJYvkaNLWtxduhPkd0VSCHj8
         tH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=5q60KLWpl1cwBDORBh1ZcKS5zSr4xHPdx6qj2Tcyb+I=;
        b=03fMlZaNE3Tkij2YB21ORLqk1DgmKJkDqRG5MCPpIFRJ1F9eMuk5L0srNK8X6RutIO
         uKeEXNQdGkZzZzMJWJILuRJsg/R4jewUpd8X/WijOiWXDo/PbanidP2Gvv0XNdpSKm5Y
         gGhOS/R0hbgDdRLvGd5ePn6ZrJdbNo38+t8VRt9rNkeI3gpEzZshUuDIGYfvNvTUp093
         dZUgiZvnipiRA3mpmziE1z9ucVdkXCoCfasxNKGXb7L0rIG7gVR+UeVNTTofxRR2G2/k
         VkZQb9ap4dJNlKycBjhxt6ko+UqnIB+5uWVQElpAJFBeotbVUTpqj3qJOXTbtgMjVSMA
         Yp3g==
X-Gm-Message-State: AOAM533Yk7JBG4UGGDxGqdm0EWjpZBHTrX50s/nrExpDjzUguOjF0SwC
        CUi3Zz18ZliQlGHmo/jG1IonvWG7VWvSwg==
X-Google-Smtp-Source: ABdhPJzLKnnExMtP3qlKKrOQ+1CcNtQuJYLpFIpJVjRJhfmviIzWGKmWYMp5tky8vQ8ZzVWIrWIIUg==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr14126627wri.576.1641342491817;
        Tue, 04 Jan 2022 16:28:11 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id i12sm39893921wrp.96.2022.01.04.16.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 16:28:11 -0800 (PST)
Message-ID: <5c12dbdb-5774-fc68-5c58-ca596383663e@gmail.com>
Date:   Wed, 5 Jan 2022 01:28:09 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Subject: [PATCH v2] Input: xpad: Delete a Razer DeathAdder mouse VID/PID entry
 from the gamepad list
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cameron Gutman <aicommander@gmail.com>, swyterzone@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing my research to improve the xpad device names I noticed
that the 1532:0037 VID/PID seems to be used by the DeathAdder 2013,
so that Razer Sabertooth instance looked wrong and very suspect to
me. I didn't see any mention in the official drivers, either.

After doing more research, it turns out that the xpad list
is used by many other projects (like Steam) as-is [1], this
issue was reported [2] and Valve/Sam Lantinga fixed it [3]:

[1]: https://github.com/libsdl-org/SDL/blob/dcc5eef0e2395854b254ea2873a4899edab347c6/src/joystick/controller_type.h#L251
[2]: https://steamcommunity.com/app/353380/discussions/0/1743392486228754770/
[3]: https://hg.libsdl.org/SDL/rev/29809f6f0271

(With multiple Internet users reporting similar issues, not linked here)

After not being able to find the correct VID/PID combination anywhere
on the Internet and not receiving any reply from Razer support I did
some additional detective work, it seems like it presents itself as
"Razer Sabertooth Gaming Controller (XBOX360)", code 1689:FE00.

Leaving us with this:
 * Razer Sabertooth (1689:fe00)
 * Razer Sabertooth Elite (24c6:5d04)
 * Razer DeathAdder 2013 (1532:0037) [note: not a gamepad]

So, to sum things up; remove this conflicting/duplicate entry:

{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },

As the real/correct one is already present there, even if
the Internet as a whole insists on presenting it as the
Razer Sabertooth Elite, which (by all accounts) is not:

{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },

Actual change in SDL2 referencing this kernel issue:
https://github.com/libsdl-org/SDL/commit/e5e54169754ca5d3e86339d968b20126d9da0a15

For more information of the device, take a look here:
https://github.com/xboxdrv/xboxdrv/pull/59

You can see a lsusb dump here: https://github.com/xboxdrv/xboxdrv/files/76581/Qa6dBcrv.txt

Cc: stable@vger.kernel.org
Cc: Cameron Gutman <aicommander@gmail.com>
Fixes: f554f619b70 ("Input: xpad - sync device IDs with xboxdrv")
Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Reviewed-by: Cameron Gutman <aicommander@gmail.com>
---

Originally submitted here, now I have some time to try again: https://patchwork.kernel.org/project/linux-input/patch/b9e7cb27-1866-83bb-b453-ae265ab6bde6@gmail.com/

Tweaked the rationale a bit more and added some background
information and sorted out the links to make more sense.

TL;DR: This entry was imported from xboxdrv and it was wrong.


 drivers/input/joystick/xpad.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4c914f75a902..6c9e709050a8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -249,7 +249,6 @@  static const struct xpad_device {
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
-	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
-- 
2.34.1
