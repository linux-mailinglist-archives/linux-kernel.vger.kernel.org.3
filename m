Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C548201F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbhL3UBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhL3UBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:07 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e5so52342042wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lEVdYlzZfTaki180D8atXlsL/EBivmN1Gj1imf7WQ8=;
        b=oIVpwi1LF5eTKikUrWdbpaoj9pI9gXvIxBK6yvL17bTigNVdUW1pKf1D8d/GPHNxkn
         JC2KBk9kgWfKNo61rbq0tNF2LV4uE8iQShdBe13WzCmYNz2C/mEvFAVDnOz6IU6NhhDm
         1GNdQWsueWhDqk/rLaE0kwU4ley5gzmsF1CySLPEQc0ytucekjc8S/0LrdVs2HhsSzN+
         M1QSfHL3N2IzkE001mK1Untz2eEu+fg85YDNk2jyIxUc+csA0/vY6LM1AyOrVUMLjoFW
         dBp0j1Zn+KwteQoUe5mpu/I3U0AqavZ7uhCuaemPukjuYw5sPYLDxkLgfypBS2WZmsyt
         STPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lEVdYlzZfTaki180D8atXlsL/EBivmN1Gj1imf7WQ8=;
        b=yYQZMgydNMSehciIcYlNcCU6ZR0KM3SgufkkRlD4QEb02QnAKoF48pPJNGGY2vQTmV
         BSlARXwM9mNbdDCgl0FkAOkY2V094OcVwNpH/n9fsAkft+zaVE9UpEeCxNveBot1Wvp8
         ruYBQqk5JgnYICEe6WzKVxjZiP3aZF36aSZqEab+3QBqohT+c5bMUo41wXh/yKgNwsoy
         Te7A7YIaiHrIll7xfGxU+VdpJp0ASBJS7MuPAKxPu/V8hwQ/bhIobAO8BDRNWZ+kL3x0
         6TXAfzD7KawzsAndeDE6FwL/iKqAYhBm6rGeo7F2PB4AzgGU3q0U80fv4urRu5K1NhMR
         KHOA==
X-Gm-Message-State: AOAM531Ny9gh5fQW608peJ0czwE+rt+lI5xmtfkZeTsUUv24bGK/52tg
        QTBI1/wkNaCoSS5rcQpBaOM=
X-Google-Smtp-Source: ABdhPJz3YyOlFd4kL21Rw92SNWkwx+qIiiQ4xiYMKJ7WT3VOlWvKFgw8AZ38MXSIEZBmFwP8F3+X3g==
X-Received: by 2002:adf:a35d:: with SMTP id d29mr26202624wrb.264.1640894465542;
        Thu, 30 Dec 2021 12:01:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/7] staging: r8188eu: clean up struct hal_data_r8188e
Date:   Thu, 30 Dec 2021 21:00:52 +0100
Message-Id: <20211230200059.13406-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused and set but never used fields from the
hal_data_r8188e structure.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (7):
  staging: r8188eu: bRDGEnable is always false
  staging: r8188eu: UsbRxHighSpeedMode is set but never used
  staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
  staging: r8188eu: bAPKThermalMeterIgnore is set but never used
  staging: r8188eu: remove unused fields from struct hal_data_8188e
  staging: r8188eu: IntArray and C2hArray are set but never used
  staging: r8188eu: FwRsvdPageStartOffset is set but never used

 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  3 --
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  8 +---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 15 -------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 10 -----
 .../staging/r8188eu/include/rtl8188e_hal.h    | 43 -------------------
 .../staging/r8188eu/include/rtl8188e_spec.h   |  7 ---
 6 files changed, 2 insertions(+), 84 deletions(-)

-- 
2.34.1

