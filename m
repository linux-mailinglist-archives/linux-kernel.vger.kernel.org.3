Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7594894A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbiAJJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbiAJJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:00:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138FFC061201
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l25so14476160wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aJrQvaucM3vbI19RzhFuKD4Vi8PiNlReESprnBZDTQ=;
        b=LXT7PgxzvRrrSXLL23VkVRAbW45cusxk08YzR0/zC6bJS86LjyjNliiyoUbLG3whyy
         JimGJmKuDCgandbtTmgQG6pj2KW8m6MZb5KBWkfnxQtpciIU9SeQZ7i6a+F9Two4xtFV
         SXNNEFiHvxQrIi0s410UF6mZ+3AyM1nPp3ZBE4MXR3UHUiODZ38FyIi2IABZoThs9WRh
         GWfMFJmf9JCK18UG/bAGi/myDduEYyehr8yvQW9hGT+CGWUrcKqJ3lwhBIcjJ+E4QVY4
         +wWdsl9eNT50zPZOsvDoMOO7+Sft4Uc/EvyA1hDuCaThYBO8itRBuWPqe+kvqaNtl9Z7
         lLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aJrQvaucM3vbI19RzhFuKD4Vi8PiNlReESprnBZDTQ=;
        b=3Od3k63WVqoYoXC03R6AJPVPfTlvnlAq/2qgllXKiYGYRLYQXk8tMiPSB83eeg4GZu
         DZq3M8lslPfwiZTaXvKgcIjNgQRbnKcDEiwEIuWVicjcb1oDrl7fuB3dmBIOS2DyLUEi
         eln38iX657bVoY/5PBlyfzDqTOtfDG650eYud/lduVJNHTbAv7kziNu/KdOSwk0NaBo/
         x975zE2Ruqk3msLBKxwjsVDKnI7O+gXonG34b21O3twLyDMmXClghPczqIfmF11L509Y
         EdKqUZdx5RagE9YqXrgQkPWaAeEivLZoEcektsbhjHVFmVhtqMRLI1FG+Esmbe5TqNlL
         lMMw==
X-Gm-Message-State: AOAM532SqQ/8Nscxby6Hxw1VoqHRIVS7Hw7+CRqE6HZcb4LEXHfTKiLv
        qI8T2D98uke9ygMJ3UTh35EcN9zsEV5qdg==
X-Google-Smtp-Source: ABdhPJwGsVHOmhzBXFQNEmaZ9h8U0eqe18R3RwplYZjEYvonz6BCx0ppia6Dy8wj0k5EAQSqS9PCpg==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr6844461wrr.106.1641805222149;
        Mon, 10 Jan 2022 01:00:22 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m15sm6263287wmq.6.2022.01.10.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:00:21 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] staging: r8188eu: further per-file DBG_88E cleanups
Date:   Mon, 10 Jan 2022 09:00:13 +0000
Message-Id: <20220110090020.6800-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has more conversions/deletions of DBG_88E macro calls,
per-file, as I've continued to chip away at them. This converts almost
200 calls to standard kernel macros/functions such as netdev_dbg and
pr_debug as appropriate. It also deletes several calls which simply
aren't necessary.

Revisions of this patch set:
V1: Initial set.
V2: Corrects rtw_mlme_ext.c patch to remove empty goto label. All other
    patches are the same as V1.

Phillip Potter (7):
  staging: r8188eu: convert DBG_88E calls in core/rtw_ieee80211.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_xmit.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_iol.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_mlme.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_ioctl_set.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_mlme_ext.c
  staging: r8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c

 drivers/staging/r8188eu/core/rtw_ieee80211.c |  36 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  10 +-
 drivers/staging/r8188eu/core/rtw_iol.c       |  10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      |  95 ++--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 431 +++++++++++--------
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |   4 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      |  30 +-
 7 files changed, 345 insertions(+), 271 deletions(-)

-- 
2.33.1

