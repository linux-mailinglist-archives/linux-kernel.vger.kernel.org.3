Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559D4D22F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbiCHU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiCHU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:57:29 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B24D617
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:56:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso489571pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bF1HEb4hQ/k+ib8dpChTtvtb+CH2Jji8DmJRbjZMzTw=;
        b=BpOabioy+Xmzf6o470njed3G6kgCN7E2fzRVoYriSX6cGI/piyAKvdvCX0HLbQcclg
         qKljPt14k41dZ+/5mLjXQnUY/+3At32L0Gq9yfmJNGllOI68E98fin7+SGsh9hbylhWh
         rGyl3I1nn2R2rvgCxM+IP0TmGtnMogTHS7u/BpPK/DeWqDYiSPq6I+YeYRWb0Iszcr8t
         xL5+M6TO80ChYg1jzceBnzKS7a2AhOEiikVW7jGoNXqMVuWmnzheeouE2l8iqq93hwdJ
         jJc5ISRbF0erRR6TRiL6D/DnRJszs64o7PSzIWdaBUUhA2b1SDzpKztWOzExpEmJJAdS
         o3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bF1HEb4hQ/k+ib8dpChTtvtb+CH2Jji8DmJRbjZMzTw=;
        b=6G/16MV8cv/olEfoTXg+9oVXqnDjjrd/lCQ/J5XA/JOOQGGphczqFFFSGAo7f0Sfpm
         yqU+OVo+tWCInm5ZJC+H4kTBMXd0W2aBX8fecwX+p/GJ55KBbYrmll/YMGAlrL3+CGZB
         L/DsjT0ncUx214VIv2w2DbSAK4Pxi/pV4aP92srTDX7Dp/YF+S71CyYsRWKC4imNILYU
         U+SFHd08bXrC4SHkws3aEKqfMhF2vMMoMA/CovU+hDArxt++cuR2qoRPzbw/2EJeJJxF
         jedwIQQJBYHssQ+MZ0Av4o50RLJ3soQdOh+O7upLmJ4vfJhSod70+LviNv7w37FGzm+O
         9wsw==
X-Gm-Message-State: AOAM533ivO4epyhQOVPUrK/dOJpRM4dSdFCCFQhDtNTupzNLgxYnqJeF
        6ORgHceeXYm+Jga8/OKZkazZO1tEXzoNUA==
X-Google-Smtp-Source: ABdhPJyYCSMFRB25ISa8tma4k+MrwF+TJGeCpy8kkKm47LntfvId+7RmCBY4yiOLpOU9xFOXhrNzig==
X-Received: by 2002:a17:902:8a97:b0:14a:c625:eb2d with SMTP id p23-20020a1709028a9700b0014ac625eb2dmr19419454plo.26.1646772991323;
        Tue, 08 Mar 2022 12:56:31 -0800 (PST)
Received: from localhost.localdomain ([103.85.9.4])
        by smtp.gmail.com with ESMTPSA id u10-20020a056a00124a00b004f741eb11d0sm1252661pfi.149.2022.03.08.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:56:30 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: improve error handling
Date:   Wed,  9 Mar 2022 02:25:08 +0530
Message-Id: <20220308205510.48431-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This patchset improves error handling in rtw_init_drv_sw() and
fixes some memory leaks.

Vihas Makwana (2):
  staging: r8188eu: call rtl8188eu_free_recv_priv from
    _rtw_free_recv_priv
  staging: r8188eu: proper error handling in rtw_init_drv_sw

 drivers/staging/r8188eu/core/rtw_recv.c   |  1 +
 drivers/staging/r8188eu/os_dep/os_intfs.c | 60 ++++++++++++++++++-----
 2 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.30.2

