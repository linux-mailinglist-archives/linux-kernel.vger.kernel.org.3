Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E94787C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLQJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhLQJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:35:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:35:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so2193680pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 01:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=be0vTiBSHbASqFB/ShnJrgEh928WMCh/W4l+DT1GIOo=;
        b=pzZ22XLLLkG8mnd3u7BlHWsq2p4Og4cBM+JWRYTcharzGv2NDELQ0KkmY+f+GyWWMK
         49K3bRXbL7s7xS30na29Uc964zp3Emw6ac4/tL4JreZU3SsKhBwRwCShltFnPhnZYvVq
         UZr/tpDVURtDy4m14tBLxkUsi/KcCb5yl/rDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=be0vTiBSHbASqFB/ShnJrgEh928WMCh/W4l+DT1GIOo=;
        b=Ddz2VcnKprZHr/stlvhcTCAdkCeF028TpdpX+g++ydkUHQOANYkAjPymqSnLLd5zIq
         mBJkH+IkIEf5WQZ+EYLp8rj0pnAEEYFfEb4TFlBMKwYkr1AifLyalKOFuhJ51kgfM9Sv
         i8mgmB/fDiwEVGLo6DYgkNODjbY5ONsxuKVGSSbplEf0annpYMg/Yf2Qrcmj4h/zylfs
         zXbwl1CmMWomJx0RqO2dItYn9gURChVcTuiR/EljRxxM3yVNvyh/S1F3AYirIaTUqId9
         ksxedNTG+itKwHPgC3kMH/OoYwgh/Mb9vwRB1hRYLBvsH41hoi4kRYp2j0e1dXRnGA+j
         ihzA==
X-Gm-Message-State: AOAM532pAtoDo7DTIg9D+EEfFqEh7PfeqTBpoEDJw73/Xtr+JVzhVJtm
        ygSXxd5ONb7NFqiL1iU0i4YGyA==
X-Google-Smtp-Source: ABdhPJzLPlF5G5H/cCcWn84VJr/91NjsDassclrzmeGo7K3UZlNI/6WZyGCGUc0Vd4gzZQO2/7CsNg==
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr2862140pjb.34.1639733730440;
        Fri, 17 Dec 2021 01:35:30 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id o9sm7650143pgs.65.2021.12.17.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 01:35:30 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, romain.perier@gmail.com, livelwh@outlook.com
Cc:     linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: Initial DongShanPiOne support
Date:   Fri, 17 Dec 2021 18:35:07 +0900
Message-Id: <20211217093510.3674590-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few device tree bits to support the DongShanPiOne
which is an SBC module based on the SigmaStar SSD202D.

http://linux-chenxing.org/infinity2/dongshanpione/

Daniel Palmer (3):
  dt-bindings: vendor-prefixes: Add prefix for 100ask
  dt-bindings: arm: mstar: Add compatible for 100ask DongShanPiOne
  ARM: dts: mstar: Add board for 100ask DongShanPiOne

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 ...nfinity2m-ssd202d-100ask-dongshanpione.dts | 25 +++++++++++++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts

-- 
2.34.1

