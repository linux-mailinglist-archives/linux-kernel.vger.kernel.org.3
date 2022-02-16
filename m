Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32F4B9177
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiBPTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:41:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiBPTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:41:00 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D7E2B048B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h18so5725950edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qkw5lRjf3nabe8ZscLlo0xJJCuvMix/6SLYQZbaisbw=;
        b=NiEcxFmqrBNp3AKMfYTqWtWbl4/TxXVVBB64QLSnBna2+TOy0BnFV3jwVfmVAzom5n
         XivpXV1UjX4mTALjoyfPANAIQBWWFNZw/Mr2zGQJhxJs/qbtZFYKQVL8DvqEtDlOuqpz
         3l+W6pzYjfOtSwaYpDJN3pkdu52qivLGD7+4iOtp4nBjyOqB9ILlDgo2VgFgwSpApY/L
         WPa0rQFGNMT+vaBhYsGe/reLWvqR0DznZAyP2hTg0nfBaVKhLqyHdhQ/I78Ku6Ars9S3
         lCZj4Ln2pBEkCxFFBRVr22t0q46RxOjkHRAuvr7MqD/6EEAlVT1JkJXvdCHhqWLXkrky
         1e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qkw5lRjf3nabe8ZscLlo0xJJCuvMix/6SLYQZbaisbw=;
        b=7oh1JoYrHX5sfO3of5aBXVazrQxixaLSMztRUdnNhd1N2iBhoB1G2fmzEJkGsHWpOk
         h8PiqB/8+198VsZUbJ6Ul7j9lfSMIoekKRiBAhco6L8bGpjhgn/td9ur1Af+mofk9lvu
         VYXYAMQFHXumMHwZIUpNTSIcC8aEFOGCa50jETO3ORNXcu9C/0K/igJiOJoidkUPixiZ
         0V5cd0JPeK6b0n3PKrMCwl8SgOe/5H1l+1NGfY4v9dEENZwxtE+UE7CUfkSuCajWtmpt
         CznQ7x31Dm/T9Nr1uJO3zqdw9eCaNEkbhjUTwonRTAD9A0j9+vdbPVV8v0NtOyO6H2YU
         7J0Q==
X-Gm-Message-State: AOAM5310tANPmfv5wn/4BC6PrirMLMR5CL39nPKfrAVZaFUCj6JRNfrY
        s8mBOSLekEoiV1AO1akMRKqF3cfkvX0=
X-Google-Smtp-Source: ABdhPJzSroogHTpd71ByMH/Z0a220F9XaYcVaZVAW+hYrmU3kuou/Ilv3IoLJMhPsJiZdTOFxxsP5Q==
X-Received: by 2002:a05:6402:2065:b0:407:eb07:740 with SMTP id bd5-20020a056402206500b00407eb070740mr4615493edb.406.1645040446340;
        Wed, 16 Feb 2022 11:40:46 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8c.dynamic.kabel-deutschland.de. [95.90.187.140])
        by smtp.gmail.com with ESMTPSA id z18sm276910ejl.78.2022.02.16.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:40:45 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: remove dead code
Date:   Wed, 16 Feb 2022 20:40:35 +0100
Message-Id: <20220216194038.6762-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series removes an unused enum and some dead code related to a
variable that is always zero.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (3):
  staging: r8188eu: remove unused enum
  staging: r8188eu: bCCKinCH14 is read-only
  staging: r8188eu: rename CCKSwingTable_Ch1_Ch13

 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 16 +++------
 drivers/staging/r8188eu/hal/odm.c            | 38 +-------------------
 drivers/staging/r8188eu/hal/usb_halinit.c    |  5 ---
 drivers/staging/r8188eu/include/odm.h        |  4 +--
 4 files changed, 6 insertions(+), 57 deletions(-)

-- 
2.35.1

