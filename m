Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDC54781A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFLBFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFLBF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:05:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206E67D08
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 18:05:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so4761974ejk.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaJ9A311TrSfFnoNHlPLqCJLl63tuzS6qi1yW9Cp5w8=;
        b=kTQHVU0bpZYPKroMPjv6y78xV/6snZ6DHzneUBLVERu3DtZRvjpU/FYrmEcT8qombK
         BVdXn0Wm7BouKKZ8jsgpDceZcCvo+AXYhKzWEMt5onU9HS5HRZA2R5FjJVzwoGOBeQ0w
         aFDhgV6O+zuM7BEu3gUFUGyQ0PCpZqhG9i+DxX+E/l5farDku9r0xAq3jS/ZALdMWTvb
         pSJubGLKy458RbjnBvarQtaHeznQR2kC/DI33H4eoYLt9j4NySaJNOdOAAk8gm6HDgnr
         IuqCCU8PoDSGFI+Jcw9GIf04BC4X9R3aME9HWnenv5lHaIkafttu3UBhPoGSMp2VmpSW
         WPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaJ9A311TrSfFnoNHlPLqCJLl63tuzS6qi1yW9Cp5w8=;
        b=zuohoX2uDlx+r+t9NorvId88WF6OrnFXuwcXihcQ6dUxJeZOOupddhUUaogFiyCRa/
         JKfvvYgEinArZk4K/r/rDhS1DMLaW1MF3wqYWlUIWLdjh9kDzaWrpwNm5bCfnx9xRYQB
         ULqAbbm1eaRtOXPctu1fDbkq9aBC0t8X0J3cvtW+4Wz6u9JELcIQmFPDc6+bynvmqSKm
         Is+fMt/KiCTJFKm7JdznBSLJ1hG16GeU5kNslbxczwPemb+UOXjt1JtmxZCLcGoJsDpm
         EYa14+kyKtqQmNg/o+TzGOA7/THhXEvU+UjvbG97WtlTQMy8MOqR23hmCuNMf0zX8Lkh
         eC1g==
X-Gm-Message-State: AOAM530AO8qT5cJT2F1cuBHYl6enGVHSzZnH76E/tKHXyhLna4xKyUAm
        LAt0F7rJb93YKhhZ+ad29kY=
X-Google-Smtp-Source: ABdhPJzxFval4Qok9pFwMRhEYeMibBtrQ4zyJ0h+CNNl8lq5obSDpSrDc91u949sx/WfmEzXFK7EQg==
X-Received: by 2002:a17:906:5352:b0:712:3916:e92 with SMTP id j18-20020a170906535200b0071239160e92mr6681677ejo.756.1654995925004;
        Sat, 11 Jun 2022 18:05:25 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:b802:84b6:a3f8:7c89])
        by smtp.gmail.com with ESMTPSA id u20-20020a509514000000b0042dd1d3d571sm2312297eda.26.2022.06.11.18.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 18:05:24 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Nam Cao <namcaov@gmail.com>
Subject: [PATCH 0/2] Clean up some macros
Date:   Sun, 12 Jun 2022 03:05:12 +0200
Message-Id: <cover.1654994517.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Replace some macros with standard ones. Remove some useless macros.

Nam Cao (2):
  staging: r8188eu: simplify some macros
  staging: r8188eu: replace FIELD_OFFSET with offsetof

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  4 +--
 .../r8188eu/include/Hal8188ERateAdaptive.h    | 10 +++---
 drivers/staging/r8188eu/include/basic_types.h | 33 -------------------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  4 +--
 4 files changed, 9 insertions(+), 42 deletions(-)

-- 
2.25.1

