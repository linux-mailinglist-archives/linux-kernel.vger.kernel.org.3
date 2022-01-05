Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1959B485A12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiAEUgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiAEUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:36:06 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE47C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:36:05 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id e19so574592uaa.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txVFt3WvA59FUvh3yZRbarAP5GlLro21/acEq3o60II=;
        b=fb3iexS+tRtn7D63WdqlZpSd2R5xoLO6DahaWHhDUhtVpqWZg69nIqwFN1DOqvpE91
         kIEHHNa291k7kX2ELX/H/qFPbpgCKdQR4afU1fnx2eNydkIeJ4etnA3cxuQkC1UlNC5q
         LDiAG6koxNgdCCW4vzWNPWBFzxFNMDEOSUGSHumriaQhWYnMWJBA36fAjZoZgh1CpKPQ
         uSGn6wGiezElYSjDR6+71eaPiygc0bH2uUJjFUhh+4NZGnm42u4Grc0Q6djSmPoQwzss
         e2eVUZI6bhuo57u7LMIxb3/P00ge3c1unfq5xauE1EYRurEyy3CZUDpJg6j9bXf68vUj
         59bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txVFt3WvA59FUvh3yZRbarAP5GlLro21/acEq3o60II=;
        b=kRQjLmkBnkVi0KCA6tIa19wfRwjSLlUw3o8QiPXWm/k/LuxJ9guqGx87Gawe9L4NQt
         1+FS6WnpQGGFTddejxWdLmEbSstWFtXHJdtY6QTdwvd+Fto1rxyYPQRF/SWtciTG3RxD
         LpWAAsp7w4WFLMkAAcnA8ktfuK/T3yc7kQ5Ymwsfa7IzJKa5RQ+UrxD1Cchc05jNCrDT
         yL1br79S1k0g1ZN0tFSgUpPjonJebS8PqAHM3TWv2vQESBsiBkL/v4VmMFKTSAKcu1rt
         1A24bhYL+EVkzK3a+qbFFZU6EjMbUVylPbyHo7SbHnyqhBzYMmKSaXUXsztmQyh7YV0P
         +JDg==
X-Gm-Message-State: AOAM531P4gxfTGm/FXR0KxUqxz/hWr7n94bZ25KHWuUk3tkq/Dt98/I6
        SIzjZhqHzZFHMo/rHv2meKw=
X-Google-Smtp-Source: ABdhPJzLwCcp0CEqaRVb5IewVUA3D5s31K2+JNLgZ9FRX141o/fKe/iSPr+kNMiBO45GdkSo+EeXyQ==
X-Received: by 2002:a67:d014:: with SMTP id r20mr11978651vsi.40.1641414965118;
        Wed, 05 Jan 2022 12:36:05 -0800 (PST)
Received: from localhost.localdomain ([181.22.170.52])
        by smtp.gmail.com with ESMTPSA id t130sm7860vkc.32.2022.01.05.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:36:04 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, len.baker@gmx.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 0/6] staging: vc04_services: rename ocurrences of 'bm2835*' to 'bcm2835*'
Date:   Wed,  5 Jan 2022 17:35:41 -0300
Message-Id: <cover.1641414449.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set renames ocurrences of 'bm2835*' to 'bcm2835*'.

Gaston Gonzalez (6):
  staging: vc04_services: rename structures bm2835_mmal_dev and
    bm2835_mmal_v4l2_ctrl
  staging: vc04_services: rename functions containing bm2835_* to
    bcm2835_*
  staging: vc04_services: rename variables containing bm2835_* to
    bcm2835_*
  staging: vc04_services: rename string literal containing bm2835_* to
    bcm2835*_
  staging: vc04_services: rename macros BM2835_MMAL_VERSION and
    BM2835_MMAL_MODULE_NAME
  staging: vc04_services: rename BM2835 to BCM2835 in headers comments

 .../bcm2835-camera/bcm2835-camera.c           | 103 +++++++------
 .../bcm2835-camera/bcm2835-camera.h           |  12 +-
 .../vc04_services/bcm2835-camera/controls.c   | 137 ++++++++----------
 .../vc04_services/vchiq-mmal/mmal-common.h    |   2 +-
 .../vc04_services/vchiq-mmal/mmal-encodings.h |   2 +-
 .../vchiq-mmal/mmal-msg-common.h              |   2 +-
 .../vchiq-mmal/mmal-msg-format.h              |   2 +-
 .../vc04_services/vchiq-mmal/mmal-msg-port.h  |   2 +-
 .../vc04_services/vchiq-mmal/mmal-msg.h       |   2 +-
 .../vchiq-mmal/mmal-parameters.h              |   2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     |   2 +-
 12 files changed, 127 insertions(+), 143 deletions(-)

-- 
2.34.1

