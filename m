Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CA5998BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbiHSJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiHSJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:36:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86ED8E0A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w19so7763447ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=saoJnBxEaO+QQVXY4266Gj1br8WpDROo4vZ+Je19JwA=;
        b=KySJnoXIyAm5zzKyqv6CYaECOOK2i/eghNqj38+952UKaXlCJeD9umbpuBUD+DhBxA
         +7iNlZCVqVZ6lNW6BszfKDL62pbUcHmy8mMOuGdkBbHVV1AxgjiYw9JSP1hcRJwibKzD
         1KTYtaUFYf0viD4Vty+sOtD7/tIhxtP5S4Ex0Cn02m5qcb3dFvGZ86oHEzHaf+4EsMZ/
         85dlQOxZTIDKMxGvGJou26OAVXYUoEwQLe9GBU/jEc6D86noWEHdHzMNni661F4iJyCW
         xqtiNWOTGnDzySzYUQIX+Zsj1LGkevyDP8lc0rFJpZqnM96pzmQR5rrIROqM3/UpwrZP
         dR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=saoJnBxEaO+QQVXY4266Gj1br8WpDROo4vZ+Je19JwA=;
        b=2+WA1ysmXzcVc357AG0Nqv4AylYyr2btlJ7rHZBZpjPcMBbXN81E0UcBPAxJkbZmda
         /j9oUgSr60liJvZ2gp6YOPYqKQCfSMbE/Vrhki/ggLxa/kcGb68ddXH8ulRnog6XluD0
         OI6GGYk9BCqsMEhWBrk+I1g4DGU76M0JMzhAceVKyPvA6sKuWplAMaXRAsxZozWGkYeF
         0vNy7GXith6acdngakyIvXTZK1FBbvor2kTROAu7+V8evpVCHPLy7bnXzDQPr//Rig0w
         2dIn9TDWT9m0lci5wiAps8Qc9AfKlF4MFmaK+jFPlOm7FWAMhXqsT/M8sDZ0geuHlMgF
         HP3w==
X-Gm-Message-State: ACgBeo1p4yqgrb4uuyyiFLbx4RxywM8FLcrKPPoHcwlg5/Cpn7PU7hTx
        trN+buW53MhTzFkEw1ddqiA=
X-Google-Smtp-Source: AA6agR4lTrNI2mcEZvS5k2TuTODOw4yv8DGD4JjtHsZCIXKOET793eOiCfJyndbg48NHMB+TfulDbw==
X-Received: by 2002:a17:907:7205:b0:739:1735:8b9a with SMTP id dr5-20020a170907720500b0073917358b9amr4228836ejc.244.1660901766556;
        Fri, 19 Aug 2022 02:36:06 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b00734d4bd1792sm2055929ejx.162.2022.08.19.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:36:06 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 0/3] staging: rtl8723bs: remove useless files
Date:   Fri, 19 Aug 2022 11:35:34 +0200
Message-Id: <cover.1660901124.git.namcaov@gmail.com>
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

Delete odm_NoiseMonitor.c and odm_NoiseMonitor.h because they are
useless. The first 2 commits are preparation, and the final commit is
actual removal.

Nam Cao (3):
  staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
  staging: rtl8723bs: remove member noise_level from struct dm_odm_t
  staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c

 drivers/staging/rtl8723bs/hal/odm.h           |   2 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
 4 files changed, 172 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

-- 
2.25.1

