Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B24BEC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiBUVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiBUVZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A535412AEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:24:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a23so36361028eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Y1JYlQf0cbV473Kny9YeritOSb5hB/rSnw4GQZShC3Q=;
        b=TNB2qITSlYgiYr+NrsFSdyeIKKZnFomDDXCAVdXhOKnoiJQttR99eWxvPjT9lqs7fu
         GQ7azVQPkbPMdxg7xxnlrTAspCGQUqk2lWAEgeebwkq+Zc6JZ3FaT9+egL1Y2j9W4M8W
         IQxB5ttL3O54fsYCrkCO50aCAw0H4RmGpotK6tOaTjJkcisQ3+4rfJETXgsJ49tco27r
         AAsrMeL0vOefeJqHHy7fsJF82Qzdzk8olVIYShq56/K/QFJ+52wrjuv/AB75HTWzvQNt
         pybZredvmqmuhw97eyi8NV7BHd8AnXZFan4lRq3WUUlwtmqHjxc6qmI9aBw9mPcapWFA
         Jm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Y1JYlQf0cbV473Kny9YeritOSb5hB/rSnw4GQZShC3Q=;
        b=rJ5B3iLx2O0O7ttHs/iQt2XBmD/m72YX4J/hn9osvS4pzyjNYvh5+J8UdbJprD1hcO
         +1ksp7683uXhTKRhAkC/xcy++qwpLSBe12OA9caIoiSGJ+4lpewPOOGeYFpHiL2VAD38
         Kth1KIwTRMi2SjH/pQynSETtOZj2W5N2+Y+4dWaYbPQ6xvg3gRn3yj9B64Xx/KzVvYhY
         L9eFTVvc4vvnFmgkKryo3Env6GmriDdSk3KMTbfbPiJX8Tz5YysLcBMxuD+O3Jj+NmjQ
         yl3DL3vrTVZHNCz4Z4LMY2mS+OPhheOcBKc0CvxHv0aBBIn+k/LFggfCLXekkQkzWu/i
         go8A==
X-Gm-Message-State: AOAM533Irf+fFF2xe+FEdiPjaYj7ns1LSkMsY49pIybuJjQH1dRmDujS
        OueqU9SLVQARDNrZCsFvznk=
X-Google-Smtp-Source: ABdhPJzOI8p//Z8bDDgCYEB75hv0bCndKlwVXgeKcPIa6Ahh8fotgWMbQxfrUmus1TbSxwiwWWJW9Q==
X-Received: by 2002:a17:907:3c03:b0:6cf:65ec:5f28 with SMTP id gh3-20020a1709073c0300b006cf65ec5f28mr16811029ejc.324.1645478695187;
        Mon, 21 Feb 2022 13:24:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id z7sm5694468ejl.98.2022.02.21.13.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:24:54 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:24:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] staging: vt6656: Fix CamelCase, add comments, change
 macro to function
Message-ID: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
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

Various checkpatch.pl fixes as liste below
Tested with device VNT6656G6A40
Transferred this patches over VNT6656G6A40

v2: Patch #1
    Changed EN_CFG_PKT_BURST_MO to EN_CFG_PKT_BURST_MD
    Patch #2
    Devided into three patches
    Patch #3
    Devided into two patches

Philipp Hortmann (6):
  staging: vt6656: Fix CamelCase warnings in mac.h and mac.c
  staging: vt6656: Add comment for locks
  staging: vt6656: Fix CamelCase warnings in macro
  staging: vt6656: Change macro to function and moved to better file
  staging: vt6656: Remove ftrace-like logging
  staging: vt6656: Remove unnecessary line breaks

 drivers/staging/vt6656/device.h | 11 ++---------
 drivers/staging/vt6656/mac.c    | 14 +++++++-------
 drivers/staging/vt6656/mac.h    | 22 +++++++++++-----------
 drivers/staging/vt6656/rxtx.c   |  8 ++------
 drivers/staging/vt6656/wcmd.c   | 13 +++++++++++--
 5 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.25.1

