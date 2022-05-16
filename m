Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88733528B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbiEPREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbiEPREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:04:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F535245A6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q18so15006203pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmD1Y3FuSgJFnbljMkxDOtUVVLs24UFlNCPaPsg6xOY=;
        b=Mh07LbtqoTeCVzsFhz/vKKMlTjLn+MMrEPpLv1VuUjVqt9ON/ZoDq8BYXo3v5jo1tL
         oYA1O2VagGZBN1lbL2YkJaprYSqCCRuz5ZbgJPNGipo3WRNXOHhM8eJy7AZoBtGIarG3
         bGQzjnFQGbGYnbZSdd029qdmApixmfnf+RM/x5eUDavFmJ9jgMi/MtJJsNqGCLtHVbW2
         Ro/Z5fknq8ACOysBGTQTYZbXiVn8R7uAV8Sv4OENewlkgnL97Bn7qj7sGELUipW5kDX+
         ERVkix+JnxgcJE/aYHzyu3c8x95TuyG3OmWebaxj8xS9cseMOa1ENN81qBrHRCDYqsvh
         mhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmD1Y3FuSgJFnbljMkxDOtUVVLs24UFlNCPaPsg6xOY=;
        b=FnfFsL1oqKGo9UFsw0chLJWReeqBoqfxODo8xMkoYU4MpExHh+viAPWF9Y4e6TALwn
         mgECnhBD+ra50a9049ByWks1VTsFa+QN11zzmWAIUiZaVIHNjP9kffCSqySyOW8UC10U
         ARdg36sEMU/k+AiwgVVUYKVEEDsTjaaFuTpsBlxbLkg95pOBIv3TdpCJS5uhbKtkHLvS
         3uLSPP2lg2XXDf0WPqYp6KpMcNn+Z7tpJtL94dcUOVcgzRmfYhD9qgh4jPQ1KAUbHsCS
         V3V9ii0j3elnyaG4C6YrcM6j6IKMORU23M2YSXNNzZkgci8gQyIivNDaQT7Etga33REU
         1lLA==
X-Gm-Message-State: AOAM533p5gP1GXYw3UoSXQT3RRveJvs/nahftZXWvxPfACTHDSDEuStc
        fhP5ILraf3NREd8seDElnoQ=
X-Google-Smtp-Source: ABdhPJzXz7U3mrkdPNE1Q6j+ppNQpbTwg9CnxGJza60znNlJ2sutBjB/gEyoPenHlCLbbPgLCv0k7w==
X-Received: by 2002:a17:90a:4fe1:b0:1de:fc11:331e with SMTP id q88-20020a17090a4fe100b001defc11331emr16790099pjh.145.1652720667833;
        Mon, 16 May 2022 10:04:27 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:6465:4732:de67:bb26])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm7141292pfb.118.2022.05.16.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:27 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: fix checkpatch.pl warnings
Date:   Mon, 16 May 2022 22:33:03 +0530
Message-Id: <20220516170306.6008-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes following checkpatch warning:
    WARNING: Comparisons should place the constant on the right side of the test

Compiled tested only.

Vihas Makwana (3):
  staging: r8188eu: fix checkpatch warnings in rtw_p2p
  staging: r8188eu: fix checkpatch warnings in rtw_pwrctrl
  staging: r8188eu: fix checkpatch warnings in rtw_wlan_util

 drivers/staging/r8188eu/core/rtw_p2p.c       |  8 ++++----
 drivers/staging/r8188eu/core/rtw_pwrctrl.c   | 12 ++++++------
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.30.2

