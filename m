Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAC4BEAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiBUSmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:42:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiBUSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:42:02 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1C79FDE;
        Mon, 21 Feb 2022 10:41:20 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h16so17079333iol.11;
        Mon, 21 Feb 2022 10:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPbcd1/NhCAAAXexGb2akd0xI9b+JXr35tB1hE0MYvY=;
        b=aurpFARF3u8vRj9YCYpxPKEQF4arrDZ8yPWYsLQJAPaamhiPfiFgSfr+0d5G4EQPHF
         /WmIvsk/7jdL8wAcdIEgqWItC3e7PXPDsLPopyerpYrddjSGk9hWzXWex0zal7ZyiccS
         AbIamappttSoOcYuXGivybbATwbfp/1OWcj/RBqdJV8StZD7rRek37+XuRE8J0DMyMQa
         BWQxLeErhTt1WpYXk98wgsEAVZciI8yGrp5K4SMrjmEEbrjfO13YPR/Ap4ZYNROXOPno
         YMKo3DC24CSveWzvdMvKcbmsJu4yM1/lDGtWLtARFCzFKohOjQsjpOvIDkFfvXFa5+qX
         l4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TPbcd1/NhCAAAXexGb2akd0xI9b+JXr35tB1hE0MYvY=;
        b=tv/S85hTjms1PE8AZpYZtxMIP9NxNdNWAMf0NJr667vawwrGoBQ/noaExNbzIogRxF
         Cu3JkyKgB/SqvH1N7vwLfQfoCbUUf95OZi0QC2ecJqGcuQDCTAJIHzgDvthFnY+gQMEF
         1v9rp5c58zMzX3Cl1tYE8csmRNLwAYD8lk6cS5ojas3Kz7aJPAkTFAnUxDTgKmHkWyVr
         I8UTqrCbRghOc3QYeIpVQAuTfOBJ/Cf3Bm3kAb1c2UaOVZSycD5Y/+eNLnwNuxhObMF2
         /dH0BhCocNxfKInWcZXZkzKc8zG6eILiTSXZtecV6iOSfOMmqv/N92LliubFgt7amAzB
         rzaw==
X-Gm-Message-State: AOAM53029L5E/KXU9caxNFlEEheLj+aAq1/N+WIx06bRsPOq8/0u3CMl
        02XwOU7QGAKxv7vcFqlB5NtYHcPK19yp5g==
X-Google-Smtp-Source: ABdhPJxPKloxiPkCP1z30xbEhgf1Goo9OAiF/ntl0W+8LtUIgaUp8AdO+ymmiu/d2/MbuP8Z78uQoA==
X-Received: by 2002:a05:6638:1926:b0:310:a9f0:a222 with SMTP id p38-20020a056638192600b00310a9f0a222mr15676144jal.55.1645468878999;
        Mon, 21 Feb 2022 10:41:18 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:898c:5f39:a542:754f])
        by smtp.gmail.com with ESMTPSA id c2sm8312346ilh.43.2022.02.21.10.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:41:18 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2plus_defconfig: Enable ISP176x USB driver
Date:   Mon, 21 Feb 2022 12:41:07 -0600
Message-Id: <20220221184107.2321951-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Logic PD Torpedo baseboard has an ISP1763 USB controller attached
to the GPMC bus.  Enable the driver as a module.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d933b787d934..550e280c0411 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -576,6 +576,7 @@ CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TUSB_OMAP_DMA=y
 CONFIG_USB_DWC3=m
+CONFIG_USB_ISP1760=m
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_SIMPLE=m
-- 
2.32.0

