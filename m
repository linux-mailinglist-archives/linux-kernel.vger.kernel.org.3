Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC84816BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhL2Uv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhL2Uv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k18so9843099wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+w/0DPocm9k0GSpXvxdlfmQQFWX62L0w+etSyEbhZE=;
        b=nLJ/u4Dzj/KRfqnzrBoIlPOgkdUMurbKc+ZciWpeagh5i2dxpr5ESWC3x2J6YBbAdX
         47ItxCUvm/fLwl/5p4Nej+1oMa8hZsGOBN1o7rjDAmYp+FOnQw2Mry2gr2Ttk14BWFWZ
         4XsFbl3dVDmVwXRnNQYRjiIhkb3k73ZCwK686J6kZFx9n/AIHOrerwiJgVbGtacepuMx
         /SibnHi9P43511Oo/4TZQgolJoYgW8TYOLUOEHHNwfiDa9IcVcXrVe0nSldMzQmBamgV
         DcT8rapfd+JuJao9RlBz/OsnOYoxkRP5CfYpn6p64LYSUQA+RcG4QpcNiGTNZdV/r5kk
         T/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+w/0DPocm9k0GSpXvxdlfmQQFWX62L0w+etSyEbhZE=;
        b=FBTdGmKJvwGk/JMih8bMWNtfsT/VZ9m2UCbc+XuxDmD1ljpm5wbjPx9G6cY1jKhjfP
         1zX7118YNABZmYa7I2KyR/eEO/iBC/CqDVyxwDcDmvm0go/vScIaEBliBpP354l6gJRu
         /yH+lB6R0wzfn53sQM/kQfpaJStV7Efo9mfrZV8UtnOSgP54OZRhKB9jPbnFPF29RQwe
         rAhoGiBdEP3/PDkrsbAexYC5zabMXRbM0axG49FRXUybJj5vwNII7PHJ1IscR725vUv6
         dm60Nka37fSd01CI4D0vwvOhCaZvDAQ6LqH217JmMnWQvRruxEiKk0Mg9Z8KZqvV6p0W
         zA1A==
X-Gm-Message-State: AOAM532Z5Yy1edzTC/l9Hj8VY+Lb0hq2cgSfHJoQhb2qI9AqigjQ14B3
        f++lJP5NuRyHiSsKqq6QHpGPzmEP6jE=
X-Google-Smtp-Source: ABdhPJx3Ys2u6SmNHo6xV7YUFziwlUJCSW1qIB2Z3C13etTLSKxMHubMlKWWo2qH0/fj1aBnw4FmJw==
X-Received: by 2002:adf:aa9a:: with SMTP id h26mr21711756wrc.437.1640811086409;
        Wed, 29 Dec 2021 12:51:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/32] staging: r8188eu: remove odm_interface and odm_precomp.h
Date:   Wed, 29 Dec 2021 21:50:36 +0100
Message-Id: <20211229205108.26373-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes odm_interface.c, odm_interface.h and
odm_precomp.h. The motivation for the removals is the ongoing effort
to get grid of the hal layer.

Patches 1-11 remove all wrappers from odm_interface.c and finally
remove odm_interface.c and its header file.

Patches 12-32 remove prototypes from odm_precomp.h by making the
functions static and finally remove the header file.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (32):
  staging: r8188eu: remove ODM_SetMACReg()
  staging: r8188eu: remove ODM_GetMACReg()
  staging: r8188eu: remove ODM_GetRFReg()
  staging: r8188eu: remove ODM_SetRFReg()
  staging: r8188eu: remove ODM_GetBBReg()
  staging: r8188eu: remove ODM_SetBBReg()
  staging: r8188eu: clean up coding style issues
  staging: r8188eu: remove ODM_sleep_ms()
  staging: r8188eu: remove ODM_delay_us()
  staging: r8188eu: remove ODM_delay_ms()
  staging: r8188eu: remove ODM_CompareMemory()
  staging: r8188eu: remove odm_interface
  staging: r8188eu: make odm_ConfigRFReg_8188E() static
  staging: r8188eu: remove unused prototypes
  staging: r8188eu: make odm_DIGInit() static
  staging: r8188eu: make odm_DIG() static
  staging: r8188eu: make odm_CommonInfoSelfInit() static
  staging: r8188eu: make odm_CommonInfoSelfUpdate() static
  staging: r8188eu: make odm_RateAdaptiveMaskInit() static
  staging: r8188eu: make odm_RefreshRateAdaptiveMask() static
  staging: r8188eu: make odm_DynamicBBPowerSavingInit() static
  staging: r8188eu: make odm_FalseAlarmCounterStatistics() static
  staging: r8188eu: make odm_CCKPacketDetectionThresh() static
  staging: r8188eu: make odm_RSSIMonitorCheck() static
  staging: r8188eu: remove odm_TXPowerTrackingInit()
  staging: r8188eu: make odm_TXPowerTrackingThermalMeterInit() static
  staging: r8188eu: make odm_InitHybridAntDiv() static
  staging: r8188eu: make odm_HwAntDiv() static
  staging: r8188eu: make ODM_EdcaTurboInit() static
  staging: r8188eu: make odm_EdcaTurboCheck() static
  staging: r8188eu: remove unnecessary comments
  staging: r8188eu: remove header odm_precomp.h

 drivers/staging/r8188eu/Makefile              |   1 -
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  17 +-
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |   1 -
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   1 -
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   1 -
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 234 +++--
 drivers/staging/r8188eu/hal/odm.c             | 890 +++++++++---------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |   2 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 118 +--
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  58 +-
 drivers/staging/r8188eu/hal/odm_debug.c       |   2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  63 --
 drivers/staging/r8188eu/include/odm.h         |   2 -
 .../staging/r8188eu/include/odm_RTL8188E.h    |   4 -
 .../r8188eu/include/odm_RegConfig8188E.h      |   3 -
 .../staging/r8188eu/include/odm_interface.h   |  42 -
 drivers/staging/r8188eu/include/odm_precomp.h |  54 --
 .../staging/r8188eu/include/rtl8188e_hal.h    |  11 +-
 18 files changed, 635 insertions(+), 869 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 delete mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_precomp.h

-- 
2.34.1

