Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9A505D76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiDRRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiDRRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:23:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541F31935
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:21:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso17794240pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQ7zMObbxBwpwrmjodRH3jIXu53bzE9nhd/lk8gMVG0=;
        b=N27U19zOBTYQfhc3bgkjYTIy8VPlnXYzPv3bvnCJHxVIGdoj6Dz995yQF6LlOPCvTr
         BSsZ6cxg55iljThZtwy6r0pNbEQpmpTlAy87IBBTZdvMau1M/zmRDEh4hK1zgOBL0uge
         VENqT2H+vNAC49WV+/Z4KPqtM4awCnGbTH7UyDkEmGNHPrn0PXFedpdb7EAn/CNfdqlh
         247BiGGCsoUiN5RhPrOcsztxDbmWCYSrUsuMfIuqrO+cBMjYO4hw1D126HqZvf07pj3C
         9bNgLiJENjKHtOO/4F468dhRDAhjam2oB+ydxWBy5w0zJTJCKYyRgJfqEmG2oTnafSpS
         tKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQ7zMObbxBwpwrmjodRH3jIXu53bzE9nhd/lk8gMVG0=;
        b=KPRv7kABW5IqSfJ/UIizkwQcg8vKx4LGBMuwg4o4EAAlbJHvjodOAV1Po0+TM8NhJX
         V6JDa0uCwzEo8WTqBPjI4L83WUKDAa5ZEGmD8oPKbHULOqtR5FQ+2CdMIeYgMM5vmJNJ
         DGUEjOcp7rxY18lijU90DSGs7wC2R+VWKIwVe2ViBvanLh/anOgBQZNNUlYeiSghWxJ5
         4QCRK+GGXQvc+YHGjzutlpeoqJ30BA05N/Wku04UaO3u42JsqqUimgAoQ/JCyyxIR9RE
         fe6szyVfO4FNHit89rnJfc0tgsBM6SHmXRzvRmHDlwSyOMlsfZhqjrr2zgfbtUCEYFPA
         42xA==
X-Gm-Message-State: AOAM531MkV59Bl4ff8LKyfuX3wXiHvGgzyGeXmBb0SlZ4HTHAPnTuhT9
        kXS/0cZ/DpOIU2bzKcz2Mu/oCo7GeMG3zQ==
X-Google-Smtp-Source: ABdhPJz++PL/lJOqM3fzQXj2jrTDz43c8/cBZ4e+c+pV3rnK5BSZJnTiluFjWyDif1IdjKep3RWv4w==
X-Received: by 2002:a17:90b:1a8a:b0:1c7:c60b:f12 with SMTP id ng10-20020a17090b1a8a00b001c7c60b0f12mr13989087pjb.139.1650302467000;
        Mon, 18 Apr 2022 10:21:07 -0700 (PDT)
Received: from aliyar-HP-Laptop-15-da1xxx.domain.name ([14.139.241.88])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78f29000000b005098201d2f5sm13041394pfr.205.2022.04.18.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:21:06 -0700 (PDT)
From:   Aliya Rahmani <aliyarahmani786@gmail.com>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Aliya Rahmani <aliyarahmani786@gmail.com>
Subject: [PATCH v3 0/3] staging: media: zoran: fix warnings reported by checkpatch
Date:   Mon, 18 Apr 2022 22:44:50 +0530
Message-Id: <20220418171453.16971-1-aliyarahmani786@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address style issues found by checkpatch in the
zoran/videocodec.c file.

changes since v2:
PATCH[2/3] : Rework commit description and subject
PATCH[3/3] : Rework commit description and subject

Aliya Rahmani (3):
 staging: media: zoran: use seq_puts() instead of seq_printf()
 staging: media: zoran: else is not generally useful after a break or return
 staging: media: zoran: avoid macro argument precedence issues

drivers/staging/media/zoran/videocodec.c | 9++++-----
1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.25.1

