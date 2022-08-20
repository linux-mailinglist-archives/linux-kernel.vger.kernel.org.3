Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB859AF5B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiHTSAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiHTSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:00:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12912A240
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gi31so7708552ejc.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=S4K7WddGnCKRXo7vMgA8XrMmq8iETnu9thV6SMJ5zJ8=;
        b=KgHqtvn7WP8z/GLXeqAexT061YnUJrRiquK7aPYERsIzzjLzRsxlIAndBsj1/r22ox
         Na8EcVl1MVlTu4KxnuTTy3b+9D5vwQDWzXnvun7Uwl+wzdeDgFoaty/Dfffg9KC6IxYf
         a2nVXVzEFOXRBhrNJaxOT6qrDmz5Tb0UdmpqU/7L/f0DalYHInh1/xMQoFeaSZVFhn5/
         Hir7C+ZsVNOyhVrsbcjeIotwWd+KVlrRIeuH+4HaRHEmzixKQuPnDX7vl5m9P5eJ8eqF
         6yKcckGUeRwXfQBfK3LdnT5TmJZ7+vYE1y/sQsZsPIGYlZ5mDpfNxngtNmswvAIUZ+n/
         Cbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=S4K7WddGnCKRXo7vMgA8XrMmq8iETnu9thV6SMJ5zJ8=;
        b=V8qUxC+xjZ5z6dmgtqMLgPG+V1XTx9g1fZIGXD6rXJwdoRkENJzne1I+sShVfkgs3R
         jtVwN055K4U6GcV9AJtPly7iqLNUSZxoIxqe7ybiwxsiwb45Ag64OJsW3hM94YuCfrcm
         /LRmHNGtL5GFrAM0IuXRl2EszRi2FiN2ZM1UIJR07eGqK0u/QyoIA7fNvdN7R00utBAF
         TleIEqSnFVUnlwkLtVW/aACeS1dcj3kP+JhgJVr1tZEl1qNVkP03d7sDeOB2xtgCwLG/
         E9WrinOPI6FqkqKHIEdd0oKtrN0T+DMc6gGmhpL+gBDUG9VvCSGsnFki9Khs+cKl2CsD
         cFJA==
X-Gm-Message-State: ACgBeo324h72DLizA3USgC36WgeF4mD+F3trcYG/EGodBi4BktlIP/2P
        Hd0CxUlUwL6DUa5zEOCXPkM=
X-Google-Smtp-Source: AA6agR40o6e2+2a1ybsZbBDky02ISKDVNRQfo3SSi8DJcZIX9o60XSRPX920ah4wBiCdeao7dC1Vhw==
X-Received: by 2002:a17:907:da9:b0:731:1a5:8c66 with SMTP id go41-20020a1709070da900b0073101a58c66mr8176062ejc.80.1661018432264;
        Sat, 20 Aug 2022 11:00:32 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d6d3000000b00445e037345csm4938841edr.14.2022.08.20.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:00:31 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     hdegoede@redhat.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com, namcaov@gmail.com
Subject: [PATCH v3 0/3] remove useless files
Date:   Sat, 20 Aug 2022 20:00:01 +0200
Message-Id: <cover.1661017377.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <13600e0c-bde2-198f-26c4-00531f277bf8@redhat.com>
References: <13600e0c-bde2-198f-26c4-00531f277bf8@redhat.com>
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

v2: Add new patch to remove the file from Makefile, otherwise there is
    build error as reported by kernel test bot.
v3: Squash some commits together. The patchset functionally remains
    the same.

Nam Cao (3):
  staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
  staging: rtl8723bs: remove member noise_level from struct dm_odm_t
  staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c

 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/hal/odm.h           |   2 -
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
 drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
 5 files changed, 173 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

-- 
2.25.1

