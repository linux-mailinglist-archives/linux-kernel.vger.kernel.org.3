Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A34F1E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbiDDVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380652AbiDDUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB75FD0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:48:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q26so4940971edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=oSPKjJEXpR8ZygxdI2fFCg0aO4+x2fKb+7cSs9wJlWA=;
        b=pbvAQYx+hG9bKJMK4uwgVCaQEMZOIUeLgvpTtPPPCWEqnX3yvZ7V3a7fs3rqgDrvIe
         cpwsBHqT6X7uTknE2lA4tw4szXj8YpqBYNLLGG+vjXnjw0EWTPaYSGTLWPzNoesu+x08
         lWNSR7tPXjmZHAgkK42SuabRStHU5/XDx1rbseciQD8xyuqj1vh02MfaKp4DjRu6mJAo
         Yy/POyg/bLGuYqmR9eB2yZOPqVbc6O3JXnGzW3FGLWQgRe6Ccs3tADsY0F2iw+V+ZZBV
         o0y9S0IAPTfx6cFW+WUZFjrSdVcxzQW8oP8rUwizjiM3IgaeiOG1J2WvGGBrfPNokeWs
         cu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=oSPKjJEXpR8ZygxdI2fFCg0aO4+x2fKb+7cSs9wJlWA=;
        b=lqFLm9u2FnC5Cb5A0X2HjV9Wj5oZ2K3X8LVhkjkFVu67m6IGuBsed+jWhlKSwpCbkd
         fc3hIpMAbdrRcG5eZUcZLihaOI1Z19jA163p67nQ5h3UKCYYFCRzrfcPpOb3Qfd18Rug
         tOJf2fQ7BlyvOtuJ8I4lDKHCPESWGLKktu5BWitCWD6X3AZk5jMaiH4l+nZH8nx25Jnv
         TgKOSdvCgg95XORWfJkJxLu7gW8yJU2biatXsp0bjE5TlK802ecq06WGwjdFgvOVnHtx
         WP2iRa/bUvheL82SMKkfhAih7J9m4EwRROUQ+cdSQMvMo20CbtgJzBHiQaitMLX7smYo
         xiJw==
X-Gm-Message-State: AOAM531kVBLi/A8YXF8b/22ywDgDMw6A9li+LIhm8+w9ssjGFsILFVAI
        Wb0E+9jKAKwvvnTkjF47gupyDaU9Vo4=
X-Google-Smtp-Source: ABdhPJzaOScMIpUbkzhVH+5rt+NUH42tP5lvytCaMcRvvdxICEaZDlT4kyZQT1SUfUUSlqkuPLmyyg==
X-Received: by 2002:a05:6402:3593:b0:419:7a2d:4b0b with SMTP id y19-20020a056402359300b004197a2d4b0bmr2044719edc.39.1649105312661;
        Mon, 04 Apr 2022 13:48:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id y17-20020a056402359100b0041926ea1e12sm5960734edc.53.2022.04.04.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:48:31 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:48:30 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] staging: vt6655: Fix CamelCase in upc.h and started
 in mac.h
Message-ID: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start fix CamelCase or do-while{0} issues in macros by
- removing
- renaming
as both issues are not accepted by checkpatch.pl

---
V1 -> V2: Merged first two patches into one.
          Patch 6/6: changed from (macro to function) to delete macro
          Updated cover-letter description

Tested with vt6655 on mini PCI Module
Transferred this patch over vt6655

Philipp Hortmann (6):
  staging: vt6655: Remove unused macros in mac.h
  staging: vt6655: Rename constant definitions with CamelCase
  staging: vt6655: Rename macro arguments with CamelCase
  staging: vt6655: Rename macros VNSvInPortB,W,D
  staging: vt6655: Rename macros VNSvOutPortB,W,D
  staging: vt6655: Remove macro PCAvDelayByIO

 drivers/staging/vt6655/baseband.c    |  16 +-
 drivers/staging/vt6655/card.c        |  60 +++---
 drivers/staging/vt6655/channel.c     |   4 +-
 drivers/staging/vt6655/device_main.c |  30 +--
 drivers/staging/vt6655/mac.h         | 293 ++++++++-------------------
 drivers/staging/vt6655/power.c       |   4 +-
 drivers/staging/vt6655/rf.c          |  14 +-
 drivers/staging/vt6655/rxtx.c        |   4 +-
 drivers/staging/vt6655/srom.c        |  18 +-
 drivers/staging/vt6655/upc.h         |  47 ++---
 10 files changed, 172 insertions(+), 318 deletions(-)

-- 
2.25.1

