Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BFE4FC623
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiDKUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiDKUve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:51:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8952BD4E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t11so6348578eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=/SwEI7yeod7vIHsEt/SEyrggYWJg5pRwDInFyaB3kIM=;
        b=DI+d/1O/q/swLPnQajtr9yBUXl7PXdVud4vQM2teEzWp8lk28m/iWlb4p9d4p3Gbjs
         DJjgigMMlLNiNbQ4MLOVNnffviC959IVbBL0UCzoOhArUBKU2F8bHCiWrsAyd7TOZfrR
         uK32d7uK6BmiLaB95Fgziv1CFzjzjtN+/q37xAn4OgD3Pq4GdbkSYl9z4XMz2i8aMQn0
         +iYKCwTJ7+pA7NYdNsSWc9HLYZ2b14Hq2pUJ1qrOd5iTJWjL9+7NDG4HIDPIfm4bEoCK
         CmqRIACDMJz9AIUBv56bzga7VyQE6XJFddOTUAcPyuCd8x0lisENB8Sy9mnqGEv/HIs8
         Km6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=/SwEI7yeod7vIHsEt/SEyrggYWJg5pRwDInFyaB3kIM=;
        b=8LXSjkSGDbRRKCgT0RBu0bO4YFLZe8m3SOPgGm3+a9zisjd+MMrfdKP9poeLqEVAI3
         kwkpxW2UDUEDpEwB9Ou7n4+0+F2y2fW1FFqsifU9qgm5kLa7ihT/g4pnqmPzFMYp1Me2
         sIBvsshygsnZEIpjXeGejgA5zl2DLii4gq4nfD+cg95t2pgeKbPNVNuVZA39nBPGu37v
         NpPJ1W315p22zEjwA/tbW4t3pedQirbRfX2Qf1PXtHi1VPQt7ldcOPOFPfPDK2UGGoLn
         WkMqAhpUoaKyY45jdpBTlJ9oOntIuv2RgkSxuQ8KfPGbrwinGdClcuXkNvSZNwwtNiBN
         gN9g==
X-Gm-Message-State: AOAM5303M1awQsWDPWmCRgP40SLAQuCW3LC9MuqdNt5zfHRQulSzPmwT
        BLdyeK3w+m/BWoyAZwULdoU=
X-Google-Smtp-Source: ABdhPJwo/fyC6ehmNFu/hDcYp+kdDLUNQvul1Et4C1nyeW9tSG+5fgKqjn2DB+WhGLA1YveNQ5ebvw==
X-Received: by 2002:a17:907:6093:b0:6e0:dabf:1a9f with SMTP id ht19-20020a170907609300b006e0dabf1a9fmr31797083ejc.424.1649710157027;
        Mon, 11 Apr 2022 13:49:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm12400232ejd.18.2022.04.11.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:16 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] staging: vt6655: Fix CamelCase in upc.h and started
 in mac.h
Message-ID: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
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
- replacing macros with command used in macros
as CamelCase or do-while{0} are not accepted by checkpatch.pl

---
V1 -> V2: Merged first two patches into one.
          Patch 6/6: changed from (macro to function) to delete macro
          Updated cover-letter description
V2 -> V3: Removed first two patches as they were accepted.
          Replaced macros with command used in macros.
          Replaced only one macro per patch
          Updated cover-letter description        

Tested with vt6655 on mini PCI Module
Transferred this patch over vt6655

Philipp Hortmann (7):
  staging: vt6655: Replace VNSvInPortB with ioread8
  staging: vt6655: Replace VNSvInPortW with ioread16
  staging: vt6655: Replace VNSvInPortD with ioread32
  staging: vt6655: Replace VNSvOutPortB with iowrite8
  staging: vt6655: Replace VNSvOutPortW with iowrite16
  staging: vt6655: Replace VNSvOutPortD with iowrite32
  staging: vt6655: Remove macro PCAvDelayByIO

 drivers/staging/vt6655/baseband.c    |  16 +--
 drivers/staging/vt6655/card.c        |  73 ++++++--------
 drivers/staging/vt6655/channel.c     |   6 +-
 drivers/staging/vt6655/device_main.c |  40 +++-----
 drivers/staging/vt6655/mac.h         | 139 ++++++++++++---------------
 drivers/staging/vt6655/power.c       |   4 +-
 drivers/staging/vt6655/rf.c          |  14 +--
 drivers/staging/vt6655/rxtx.c        |   4 +-
 drivers/staging/vt6655/srom.c        |  18 ++--
 drivers/staging/vt6655/upc.h         |  31 ------
 10 files changed, 138 insertions(+), 207 deletions(-)

-- 
2.25.1

