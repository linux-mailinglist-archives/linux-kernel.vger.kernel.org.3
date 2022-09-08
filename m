Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E675B1E12
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiIHNJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIHNJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:09:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F1712ABB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:09:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u6so24217983eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=LnX4aqgVDvv4QK5SQJtid2l8o9K1NG1d+zs6u1fqVxk=;
        b=nOmayWkJYg+/SXPROx6sHpXDPnA04xdnf4PBZNJCFtpz/Qyr13yVz1jxU/Mcw7Ojza
         Q71/HYmNRh7vDKITSMUqTxP8xkq4r1B6JjPsr+JZp5iTwtuGv/GOt/oORIKpH0mGjNCv
         vCm0jVfpBioeVVbPCarghmiA1OdO0K7WESYGloQ/lbIrTR2fSbcqare8Uv8/mIGhREn4
         /fa6T8e3AT7bvKRjj89PizoSxn+vcBE8wb1E5Q8C+wAMYxgKfdZFuHq6EFr+tfzB9XU6
         XpDdlKuIlmmTr+GeXgoLqMR9u34gu0suCw7il7W8oXjF0HvO5IFKcQiu7wFfwHPnk7fC
         Mg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LnX4aqgVDvv4QK5SQJtid2l8o9K1NG1d+zs6u1fqVxk=;
        b=g13iGgdM4QB7+UZQGWsdReClrdWdizSIZJ1QwS/KDb4DuFRR2lBHjt0JtnZA16LMid
         XA6yVdGPSHDO1/xfhr6y3U5PdWKJsmNV/9L4nL2MdSoZtDZuyenS9KfSgKrm3rAjeKCQ
         8n/Ns6d8me/fNNlVXv0Z1qpkDaF79E5m5FWHIsNj/5zLlyYK0CKjTne0vap0bmgns8v1
         prmsz2JUmevjKJBKY17wjARbHynmbH5HSVcZY4CYQJpXVD6ESfsZLjCtS0gMv+ty39Ae
         o4LofqOsdWr88/EF8g2YL/BycVWOagMZJ7RGZzdhY8P2U0dmS965tzL1LrGQtKCT9+sM
         pTNw==
X-Gm-Message-State: ACgBeo0nROFAJBZkcknM/RJK8fm/ToVDSQBhvRkDmnm/vkCxMk3ZyDm7
        1x3cXFbZc0Q22Bz+C4tUBKOqsmUaAcQ=
X-Google-Smtp-Source: AA6agR5edPFE9cvoFBzSJriSpzSOOImuyYXCbgd8ATz+8IF1ba1dHAIEI0Pw6xA2hrDAFLqYyancew==
X-Received: by 2002:a05:6402:2a06:b0:447:820a:1afe with SMTP id ey6-20020a0564022a0600b00447820a1afemr7145683edb.291.1662642566076;
        Thu, 08 Sep 2022 06:09:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id cf6-20020a0564020b8600b0044edf0a2deasm4847978edb.69.2022.09.08.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:09:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: some simple cleanups
Date:   Thu,  8 Sep 2022 15:09:11 +0200
Message-Id: <20220908130915.8406-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains some simple cleanups in different areas of the
driver.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (4):
  staging: r8188eu: remove unused parameters from
    _BeaconFunctionEnable()
  staging: r8188eu: remove unused parameter from UpdateBrateTbl()
  staging: r8188eu: make two functions static
  staging: r8188eu: remove unnecessary return labels.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 42 ++++++++++++++++++-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 40 ------------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  5 +--
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 -
 .../staging/r8188eu/os_dep/osdep_service.c    | 10 ++---
 5 files changed, 47 insertions(+), 52 deletions(-)

-- 
2.37.2

