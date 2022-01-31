Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402B44A4827
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379058AbiAaNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378926AbiAaNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:31:08 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABBC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:31:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ah7so42983094ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX1odtfBD4UedrnN227KhfFXE8Bgba6hkIYrQUe1h0c=;
        b=SaRoAOB60fsaYmCYxnDhOhUmgArcJAUmxxaIREj9H0tWnfFrc0K69d6r7xb0n1F0HG
         I1/xGvQFbTXcHKZH7k+qlklRSNjMmT+M+zrH/Ys3GUvpJx/t7nqBrM+MGO9pPqDINgsp
         WL83o3Q3hSFFQ7hv/PuzKhDjwREeLjiIw5FqU22/c2ybPITahRsBuItAtnKPJCw9nTJ+
         kNWoSnBA6iKT0lXxKKYLLN/UQmn/RF+UBZAAl/Raq4yWUioTB2K/u1F54gx6pD2orfVI
         g14WieqToWSe/7bUskYnF2O13Be1jvjncBbsPel3KKQoKXybewEst+VP9HbFKc0DsJjm
         RxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX1odtfBD4UedrnN227KhfFXE8Bgba6hkIYrQUe1h0c=;
        b=lxGPKtq08QYTlCnzp0WjCX4jebBzYfLi87jx4WijR3jQwNyT5VRz4A97099ZuDvCyN
         w36ueWsAM4d2XxeqCWkoLBh6BiICxPgoBJ32agmBKTYw/YWn2qG7HMuxQOsSLPd7ZuYv
         Y+TAB84Y+Jt0TohaflzOM6KUccrbYaj6yhK+yJp4WNfaq3OYa/Y90F9c1zpF/g4d+BWU
         FEVLdRX3qJzmyJeNfF9cXHnlzBX8aZP41JAJpNQFFALJI5mnNjg6HwR6CB2D+lNHqEOi
         bg1BvjLHWmJVX32h/P2RUM8Q8B3QNikQf07qoXCmGUZ/HgadMKZbTorp5B2bPMeEEEwg
         z3XQ==
X-Gm-Message-State: AOAM5322RVjr3/Mn2sy5AG7BH0Q8fahQmlVD9xnWH3HRUOliqFXbGQht
        3mgfJPJI1ndr0jPket5pXQUHWg==
X-Google-Smtp-Source: ABdhPJzW4MoF2pfKGlg67rKihTtzC/z3fiEclnw0I+2kvgjX/tG02DgcGw/9c68+Bz7XbmrgfuECGg==
X-Received: by 2002:a17:906:6a05:: with SMTP id qw5mr17223317ejc.90.1643635867155;
        Mon, 31 Jan 2022 05:31:07 -0800 (PST)
Received: from fedora.robimarko.hr (cpezg-94-253-144-81-cbl.xnet.hr. [94.253.144.81])
        by smtp.googlemail.com with ESMTPSA id c22sm13094334eds.72.2022.01.31.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:31:06 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        skhan@linuxfoundation.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v10 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Mon, 31 Jan 2022 14:30:49 +0100
Message-Id: <20220131133049.77780-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131133049.77780-1-robert.marko@sartura.hr>
References: <20220131133049.77780-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta Networks TN48M
CPLD MFD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Add reset driver documentation

Changes in v2:
* Drop no more existing files
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..04baac692330 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5488,6 +5488,15 @@ S:	Maintained
 F:	Documentation/hwmon/dps920ab.rst
 F:	drivers/hwmon/pmbus/dps920ab.c
 
+DELTA NETWORKS TN48M CPLD DRIVERS
+M:	Robert Marko <robert.marko@sartura.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
+F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+F:	Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
+F:	drivers/gpio/gpio-tn48m.c
+F:	include/dt-bindings/reset/delta,tn48m-reset.h
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.34.1

