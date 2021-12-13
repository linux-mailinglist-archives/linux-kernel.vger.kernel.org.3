Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3448472A10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbhLMK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbhLMK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:27:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D8C01DF13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n8so10800317plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGPbS3ptpBIcspU7gfa8wTdMihj1/K3FQePm6Jj2a18=;
        b=n4W8+INQiqKuO54BVtoc7ZlB77fNFPAgtFVxN/xdXWXzE0ojixqsah7MPgvurkOb6r
         +UtsZIC1TBf+ogqAnUdwjlXZLGrUedgcaWAWnWWg+8PmTsOSC8c9i3e3d+ZfJPyRy8uQ
         ITTTlGZWyqvi2vjjRuYy/dZHLHcoVkS65AnDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGPbS3ptpBIcspU7gfa8wTdMihj1/K3FQePm6Jj2a18=;
        b=RoJfwa2Rkz58B8ZhKPfTI/T7667IjhD6xuL7vorqhURemkNujHbbjd4LPXmI2KcGD2
         D8ZaENMccaZaARk/JDcyaHIGm0f91v3eDMtQCUuUMgC/TgkWv0PvEqBKDlVfFDwJpoVS
         CaU6pRhJNjECWnzJHqyXdDqIb689AYYBhIlPsVibW8fUQwSvamaW0EwpO+ldrZBdGDaa
         /Nt+05QN9VP7wx8u5mqVlKTT70mT/duFmD6HcvVFWcDR0tJFmueNUKm+y7GQ3o+O1RPh
         LeTeA9vfIsnsqfWWkkhyJnYXHdYMxgDvaAk+yyGFSo1V06ki22hJeWCtsHVy42hBtabK
         0CGA==
X-Gm-Message-State: AOAM532KljE8K7eUpXM3+TMPtopgu/J8KOwS1SLH204cqqYdbXk84GuH
        z38mTyjlVmlPY+rnlyV/lP+Jif6LCJKwxg==
X-Google-Smtp-Source: ABdhPJxQO6GGkSA5nbBRrUUT0ZxaXAiaRWUDRWJlPmSjCn0sY8+ZitdbJ3EkmNVE0pW6juNXlpDSxg==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr43406785pjb.172.1639389687703;
        Mon, 13 Dec 2021 02:01:27 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d185sm9953767pgc.58.2021.12.13.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:01:27 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: Initial Miyoo Mini support
Date:   Mon, 13 Dec 2021 19:01:09 +0900
Message-Id: <20211213100112.1791192-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few device tree bits to support the Miyoo Mini
which is retro emulation device based on the SigmaStar
SSD202D.

http://linux-chenxing.org/infinity2/miyoomini/

Daniel Palmer (3):
  dt-bindings: vendor-prefixes: Add prefix for Miyoo
  dt-bindings: arm: mstar: Add compatible for Miyoo Mini
  ARM: dts: mstar: Add a dts for Miyoo Mini

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../mstar-infinity2m-ssd202d-miyoo-mini.dts   | 25 +++++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts

-- 
2.34.1

