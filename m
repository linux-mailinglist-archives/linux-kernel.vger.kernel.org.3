Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C358049D70E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiA0BAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiA0BA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:00:28 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA02C06161C;
        Wed, 26 Jan 2022 17:00:28 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id k14so1216324qtq.10;
        Wed, 26 Jan 2022 17:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oOvSBbWCPiHxycWnE6d9U3dqPlTna4pm8BiP7zmWn/o=;
        b=Aax+YLnYbz42JEIfuegpzY8AYIjXBMB07z+IQ3FBAtIHnFe0jyayWfG9fVMhzsbhi2
         Z5n5z7uQrTSAVx1wbHqza4+2ZaZLUZrrrqItGMiwrcCSk9o1k+SC4VwBC0ojsx6t9fgG
         kVp3ZAbGjAAsAWssovBowXeYzz2VWgEBVCEjJCgkQ6du14MDc4rnND0u8oIskexFPgng
         Vh02pF15Rgb8bJxRIxwtTolQL7n0BdykX2iRHqRO44k5Pqgfnv22anaji/u3cB++pe2H
         0vwsOpb+vRs0McYGzIK7p5HmGN7SX+LSBuj2LCEfQ+lPEHZ0+PehjEEu/zTn+ohP4Wx9
         Uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oOvSBbWCPiHxycWnE6d9U3dqPlTna4pm8BiP7zmWn/o=;
        b=jTw1FAgZE9LcQuWFz+eIgkVEvPRX/5+JazEphGEoINSZTmde78i6C+yJZVWO/9kLWs
         JzhaQZP1pNktu2f33f8Qo/HC8O02nap7jCBTCGrHsr0PK31BeSwOw1kjOisqoxVwKLD6
         s+qHRTfMdjchC0De7FSa+J3WulpqCd01Z5ZKPsxwG110pEpSC39BJNd5c8vOS883SVK4
         USVCaVFri1z9oGcINcI4lxtfuKhXi0ZjQTLeEt80b6w8fJHMVDIDY+b6Now+L+PZNIFO
         ulMZ3/LogK/LMIXQyO4KJmSv9jFFWl8BAhXdM/tFz6xtMPhKw27IVdJG6emI9VQKOISy
         6ZwA==
X-Gm-Message-State: AOAM531M5tMhMkEUky1XHRSke4bNusG+2vvMahGCP4EYjp66nbx9k6nk
        WrQmA5qIQYXE2g1NuoLaSMpC7YsANuEsaw==
X-Google-Smtp-Source: ABdhPJzMh8f+/jHW866ULny/PNfJYdkK92/oo7Yd+Kdq9AK7cCJ/+uFNSyYwJ9XYHEyJIcPKi5Giaw==
X-Received: by 2002:a05:622a:284:: with SMTP id z4mr1070975qtw.612.1643245227707;
        Wed, 26 Jan 2022 17:00:27 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id n2sm483389qti.59.2022.01.26.17.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:00:27 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Quartz64-A fixes and enablement from 5.17-rc1
Date:   Wed, 26 Jan 2022 20:00:20 -0500
Message-Id: <20220127010023.3169415-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Evening,

This is the first of several patch series for further expanding
Quartz64-A support.

This series has the following patches:
Fix the ddr regulator voltage.
Add pmu_io_domains to permit sdio and high speed emmc support.
Add sdmmc1 node for wifi support.

Please review and apply.

Very Respectfully,
Peter Geis


Peter Geis (3):
  arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage
  arm64: dts: rockchip: add Quartz64-A pmu_io_domains
  arm64: dts: rockchip: add Quartz64-A sdmmc1 node

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 60 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

-- 
2.25.1

