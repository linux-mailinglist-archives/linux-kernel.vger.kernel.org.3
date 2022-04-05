Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306D64F2141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiDEDST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiDEDSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:16 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF61E3E2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:19 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id r127so9321085qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNYZrXIYQcYX1eT3yCDusiEgOPOnE1Uw+GVsGFSpvGM=;
        b=HhxfV7d6F24BtgCoeDYr+W7Q47h1cTnbmTNsJshOBMLDA38QSVFzUF3qXChkZsA+qr
         YK3Sjoi5bfRiyCPNzFPnu0paWDNMgKhoWxfzCRTecppdzgxPsNfHL4LkMZWvatE0ug6h
         roYgPaS5CL79KQ4u74x38nZ48nuRxQN1Uz/CcAnewdhDMrRC7bIn9ITILDIEYaPUB1wt
         3Hh+pBgFKAp8CjqulWWxIWJHBKDOYUC4/Uu/OEuJRUUsacof90rPvTQ4rJnOaQWWB9Sh
         bH3tnwQRi3eTNV1wu4HaErVRwC3ovYdXbqf/PWh5I6dyK+GRz1TqYLABsUPmmsqbkxpJ
         JaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNYZrXIYQcYX1eT3yCDusiEgOPOnE1Uw+GVsGFSpvGM=;
        b=etKhZavbxRDEB08UvMcL/aI0lmGD3A1aorslCv/xxVMdhuMBEnLGrHtSExPS0YF5AI
         ojxnmxEN/xwO+GZoHDMDN1Jp2HRl+Vf3jXfJWg9Z7/RbGoiTyvX10h+NmGXWqp4ou4Vt
         VZIsrUUBYWm9hLE7H3VFHeJ8rvxMWa+vroyYHkXEAvMPrdJSc4UlQJ9orcjMB6lyWNcW
         JIJgvzksY/eZT5BzoAP4eR9tg2+fXb8mVDPywIbv9m2MdZLBQZK+ZjLFmgRc/PUgoKyr
         HaMffzkQI/2DFffExcAc93Onh9yDqPSpzX1jsJotQYlvW82GgUd0CFRqEZL/qP6zFWWB
         AHDA==
X-Gm-Message-State: AOAM530Ztt6p3q9RIsninmalq2Sbg+J9IR8YZnV0r4ICRboJWWQddilW
        BVOyQipqR/XBofpTf+ISBNE=
X-Google-Smtp-Source: ABdhPJzzb9WkNhmQTDeNSDHP3FiLGAnOXs/XSaQsG23mfQpUq1r3ZCtsTczE1LWyAjyfsQjbjckwsg==
X-Received: by 2002:a37:a64b:0:b0:47c:3ad5:bf8c with SMTP id p72-20020a37a64b000000b0047c3ad5bf8cmr952478qke.13.1649128578395;
        Mon, 04 Apr 2022 20:16:18 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002eb965bbc3esm10337420qtx.93.2022.04.04.20.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:17 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 0/5] rtl8723bs cleanup
Date:   Mon,  4 Apr 2022 23:16:07 -0400
Message-Id: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
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

These patches fix five categories of checkpatch warnings, such as redundant
braces, and redundant else branches in file rtw_mlme_ext.c, which is part of the
rtl8723bs driver. False positives, such as

if (foo) {
	/* TODO: ... */
}

were not altered.

Sevinj Aghayeva (5):
  staging: rtl8723bs: remove redundant braces in if statements
  staging: rtl8723bs: remove redundant else branches
  staging: rtl8723bs: remove return from a function returning void
  staging: rtl8723bs: fix indentation
  staging: rtl8723bs: remove space after function name

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 160 +++++++-----------
 1 file changed, 64 insertions(+), 96 deletions(-)

-- 
2.25.1

