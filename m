Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAE48824E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiAHI1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiAHI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6CC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so13859873wrg.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4E8jaiZ7dEeM8qAJaXi8Fcn8hzo1yKBv8Ma6YtpsuIg=;
        b=RlEyiuJG4M5Kbe9dJJ8WpP1wMzQA7sKBi0par8RdgiEoC/2vB6ExHh7HUoiMbw8jMT
         W+evjG4pbiaxw0V94GlMrcj1OtleVO41hbYQ8sw/EORDpderAOi2itqm9H05kwgTL7YW
         jL0zA/wCFZU7tEHWSw71dkEdkZZNVv73JaQY4LFRKX4fqhuZOeXEegXbzQmISZkWBy2U
         xz3IGuJrVC0r1nrJZ1HnbmsMFNfTkbvrtv7eWxYPb8J/0NciymXS/8RryAoO/jiZyCFn
         uXVAwpPNp2vUtsD32BB7wB7huDmsDR0osjQJnLg74a0giFM6TH3sufX2Kc64rWJwszCT
         Ehag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4E8jaiZ7dEeM8qAJaXi8Fcn8hzo1yKBv8Ma6YtpsuIg=;
        b=pamrxWrSoV7z2Uqr7tFnvasSSJ93j0MK7WbgUjULuGfmoh4+NLVf7Ft2F2KDG8/SHU
         yxrQW2YQL8iPPFv4KU5XBYd+B+aOskG12WFXrz8T/qEZsqdmlNi8FtEXCL1qbtYtPIV5
         ga54MOVIUu8b1r9fdTFmGAwwhvM9D5Qi/okTpDKq2utUUY+4vntQqTxx2rWMU+aFLYmV
         5KFb72AImnEljKQoz4VEgBY7VgRrZp+bX7Bv+dxyT5YGc7vKuNjLolr3A9CTZpr2UjMM
         JiuexedxpEE93S66ONjbIjYX+yuCxZW66mjAPMd2l/aWTvGAs3ET79PaA2CBWgljH9cF
         viCA==
X-Gm-Message-State: AOAM530J1lElLWHgI4aR4o+v+2SqM/DryFyCy3ZJfzrnYFnpQjqGJFnk
        uI/DaTfK67r/e5Defr4mgGU=
X-Google-Smtp-Source: ABdhPJz7iO2/QykfmzMWMYYaO0cxOYQBFMJN0ZrPK6LNDJaBvGx6Z1h3g/n8CcZowWjij9d67eXOAQ==
X-Received: by 2002:a05:6000:1e1b:: with SMTP id bj27mr13678224wrb.648.1641630462689;
        Sat, 08 Jan 2022 00:27:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: r8188eu: remove some functions
Date:   Sat,  8 Jan 2022 09:27:31 +0100
Message-Id: <20220108082736.16788-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some empty or unneeded functions from
os_dep/recv_linux.c.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (5):
  staging: r8188eu: rtw_hostapd_mlme_rx() is empty
  staging: r8188eu: convert switch to if statement in mgt_dispatcher()
  staging: r8188eu: rtw_os_recv_resource_free() is empty
  staging: r8188eu: rtw_os_recv_resource_init() does nothing
  staging: r8188eu: remove rtw_os_recv_resource_alloc()

 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 17 ++-----------
 drivers/staging/r8188eu/core/rtw_recv.c      |  7 ++----
 drivers/staging/r8188eu/include/recv_osdep.h |  5 ----
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 26 --------------------
 4 files changed, 4 insertions(+), 51 deletions(-)

-- 
2.34.1

