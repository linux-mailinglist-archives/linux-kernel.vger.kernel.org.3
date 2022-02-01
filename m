Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060364A58AB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiBAInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiBAInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF59C06173E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id j2so51189563ejk.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY4/TLKg4nBDSqO8QlLkXd5EAxzP2IB0RJLZxohCkH4=;
        b=kSjzGRNv0u0sZNDxM+TD1KeebIt7Lp0PxxGaiYsh20s6vtV2lYZ2koFB3WIt5popdk
         rFKHBOJqv6/PRFd9BUNK1RBR4TT5T6ebP4hmRfIiX0WBDM/X9D/kuyYAiH7dw6WLJ12B
         eD5s2YO/Y5beEn4EAUnMLpBo37U70BGO4p9E2HbMEqDJGHUpJO1LoJDFdGucUmdC+cib
         xJWmNLHJZtv721dJRmyD2s/D3SVJzbt13gIWiRsekSe+S6f+bSuTBbmKmySrxArNI1IW
         41GAnWqS8WehcuyEZ/ejl0Y9BHlN74avMYeyD2DLRjJUJsGlOm9F5LMWuRT0+50cK9Eo
         Z1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AY4/TLKg4nBDSqO8QlLkXd5EAxzP2IB0RJLZxohCkH4=;
        b=NptHwsiv1lg+8K+mmaAh7PucyxqXDjol+JVmRoiRwlkq9jIL+/7/YGmI2TzP3vvOe+
         WOlugf/GH+BC4D2pznuUW4Q/6kEOumpjMCtgEj+pcyFqhifKMab3ZisTrO57dEcEm5Yi
         O6LDBjnVTJe2b6jz4VA4EInk4b/pKCUO70tomYhY8iwjU5EB/rHEfwW/6gS5AFGOb9em
         0P6EcQlNNAugxG+El56JdpvMJAbr9C9gUxdFvIrniWBn5xkf/bEYa5EGSpV5HQYuM2kG
         QPcNKedzjMf8riZvUEReZAnSDYeS3P0jFmTrQtArF+SZcz+13KzWTmtwlKkFSV8e/lu6
         82eg==
X-Gm-Message-State: AOAM533YxRHV2Y86tYjAKdDDN6ibsTPmqIKWc4W35KmQydMMHrzKEcg3
        g7lu7qXpU9w68e9l5t+2a30=
X-Google-Smtp-Source: ABdhPJzfiokD/cOFOfWe7SOUqFFEvlK4NMX/cdmop+vDETdD1nMiM3A+AOWc0G+OhPLola7/yfYFqw==
X-Received: by 2002:a17:907:2d0d:: with SMTP id gs13mr20169633ejc.161.1643704990757;
        Tue, 01 Feb 2022 00:43:10 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/9] staging: r8188eu: hal_data_8188e cleanups
Date:   Tue,  1 Feb 2022 09:42:50 +0100
Message-Id: <20220201084259.7497-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes some variables from the hal_data_8188e structure.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (9):
  staging: r8188eu: ExternalPA is read-only
  staging: r8188eu: remove PGMaxGroup from struct hal_data_8188e
  staging: r8188eu: remove ReceiveConfig from struct hal_data_8188e
  staging: r8188eu: BasicRateSet is set but never used
  staging: r8188eu: remove UsbTxAggDescNum from struct hal_data_8188e
  staging: r8188eu: remove UsbTxAggMode from struct hal_data_8188e
  staging: r8188eu: remove UsbRxAggMode from struct hal_data_8188e
  staging: r8188eu: remove UsbRxAggBlock* from struct hal_data_8188e
  staging: r8188eu: remove UsbRxAggPage* from struct hal_data_8188e

 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  5 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 86 ++++---------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 14 +--
 .../staging/r8188eu/include/rtl8188e_hal.h    | 26 +-----
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  2 +
 6 files changed, 26 insertions(+), 109 deletions(-)

-- 
2.34.1

