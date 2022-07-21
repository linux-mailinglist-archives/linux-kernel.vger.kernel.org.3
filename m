Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975E57CA56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiGUMLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiGUMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:11:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14E863D4;
        Thu, 21 Jul 2022 05:11:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so1957835wrv.10;
        Thu, 21 Jul 2022 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgZ7b5BpqUN262iVeVVcETGdJrjMXgnEA22zRenxb6o=;
        b=A2ohSeZRbdZ3Qcmg3JePke+AqbwoYpO/aoXtGYISCSKp6uqGDJrNrD8lQYw47P29tP
         vrfJuMT6na/tKi0YA0WhrOUktK1FLYPB9y/Z4CYkBdvudkFg3uXDoFlT2BrrfyOya3p7
         wuNWW1M/GvF0ttqIEhyipiWOQJUJc4M43P6nDRmydBtO3nIoehEiLAMopqi+ZjSuqABL
         Y4Is8vJIpT4ZjGv7JbbMFNqOCLSut4be7qwhiBw7cr9I672oD0t1Pq5d04+3EfyLJuIs
         Ldx1hTLYAbAPTCpsj8DIxAKWIlp38kRUANOIOCDEeBQg+FlHoIc2kN57Lmbn99VIyQB2
         CREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgZ7b5BpqUN262iVeVVcETGdJrjMXgnEA22zRenxb6o=;
        b=jiQNc1XmA7B459lMHhWLTq61EPmJJiqo059zzjI5hs5avS4AJjZfF0eW9Cim90Red2
         XADVyXPIGGW7htcPdNkSn00OppEWdaM01bMxIw9sXTmbhOBI3aRTf+S7EvNv/jc5ImmZ
         TOkm90ug6g3f3xRPi4qE9gqWUrmrnwDL9epZw4UFGlcQlJkQ8wicqezKnz588U/VTCx+
         ri8k6X1/KaBAv4PhCm99F3hA/S95KFehpQjIXf1DXnkm3wxoJOInDzQLGtcB5n/NKyiI
         wD3/eJqsYYdbPy7BRoECj/0MDd9nyXAiOtO9aG1CgVl9lN38ub4iPLzSv0os1DjDhjTA
         tTHg==
X-Gm-Message-State: AJIora/gv/4S+KHeu0kznSZlmpmnPxfRRp5jZxGW9jiyfu3oMGeKrlJt
        ynnwRSmz5Oou8uf4qcuezDM=
X-Google-Smtp-Source: AGRyM1vNTi3XnhWi22coX9ZEhIzldh4NU7xk/NisQGW3+HRGE9AkUFoBflOJn7MakeH9Fioe1sKENQ==
X-Received: by 2002:adf:facb:0:b0:21e:4f54:9651 with SMTP id a11-20020adffacb000000b0021e4f549651mr4891337wrs.378.1658405502524;
        Thu, 21 Jul 2022 05:11:42 -0700 (PDT)
Received: from xws.localdomain (pd9ea365f.dip0.t-ipconnect.de. [217.234.54.95])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003a320e6f011sm1958862wme.1.2022.07.21.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:11:41 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: gpe: Add support for 13" Intel version of Surface Laptop 4
Date:   Thu, 21 Jul 2022 14:11:20 +0200
Message-Id: <20220721121120.2002430-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 13" Intel version of the Surface Laptop 4 uses the same GPE as the
Surface Laptop Studio for wakeups via the lid. Set it up accordingly.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_gpe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index 27365cbe1ee9..c219b840d491 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -171,6 +171,18 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
 		},
 		.driver_data = (void *)lid_device_props_l4D,
 	},
+	{
+		.ident = "Surface Laptop 4 (Intel 13\")",
+		.matches = {
+			/*
+			 * We match for SKU here due to different variants: The
+			 * AMD (15") version does not rely on GPEs.
+			 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Laptop_4_1950:1951"),
+		},
+		.driver_data = (void *)lid_device_props_l4B,
+	},
 	{
 		.ident = "Surface Laptop Studio",
 		.matches = {
-- 
2.37.1

