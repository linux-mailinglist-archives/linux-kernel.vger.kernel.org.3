Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25364868E6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiAFRmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242166AbiAFRmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:42:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E8C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:42:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so3920513pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VanG3D48kv1//pBO4PWaSBkzRUvZ1tAOIiNLtvht6BA=;
        b=mVgluBj3OIqaTswZrqwBwRoYI80zdmhP9Krluqa6plRv2zdkkhyHbobqNPHM5dZrnM
         MuEJnSUpljvGk6cG6GtaWp44fANwmW4IEp1uLpFLZo+wleHf2IC3EGOqbZW48us055tm
         j16ciaHi8PR1yVyNhQjC+LFGR5tyI6xF3BthbImUaAmEjI5502uaYhgdLQaTtht03UGk
         i1awYUMtLPvJe0u/+PzUwDqVbSUPe8onneS5/xm3vpyF72LZkWZOmshIpUZ4zDmFTDFh
         2Iy5CoM4T7ybwZfCyrd+Md68FmSKol3H9gn/CJyAfj3L/HGdoBsH/jNyGAiuInz1QYV0
         Hvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VanG3D48kv1//pBO4PWaSBkzRUvZ1tAOIiNLtvht6BA=;
        b=TtlJsuCJkB96BlAZPblPIQZGHLzgcOvh/1TWfsecQRWVMkzTet2gpvXMR3kMB04GXg
         EQ4+rJSX2/nDrmS5GalkmdoWghYI/T5behrKO8w8ghzkgnmpr4AwUY/FDshAPfQF25Y4
         UOtZXecL/FKS6fuVyHhiOw5Ae9DGgok5Cl9c2xRNyfqpoUd+55aiT1D0ZeLhIdc+JZGY
         npI7doT3XzFjxYB15rIj3gfrh2KiiVFmVCDfu1fSDh1DNS631ZIjCobSLMWUkvpahbM8
         KWPVa1P7mAAqMyjYLVvWmWSI+aasTF5O7yUKpnp0rdBPixJLuburCJaqvvYvn45JYIUB
         g9AA==
X-Gm-Message-State: AOAM532FIi2ebRipbEMmK9oaDTLB7pF0MpE0glK/TG89j6gduNvuUMsj
        DCAgvZi0/ERiTAbu9n4WIeYlOcXYu/ycmmbj
X-Google-Smtp-Source: ABdhPJzX+S9sGWTDP4J9dbDiFaqhNWKGAYp3sOZpb3Ev3VBk272f3UlznDFl3pRc8jJORC9CVgdIrg==
X-Received: by 2002:a17:90b:1bc9:: with SMTP id oa9mr11260006pjb.241.1641490940921;
        Thu, 06 Jan 2022 09:42:20 -0800 (PST)
Received: from localhost.localdomain ([171.78.146.184])
        by smtp.googlemail.com with ESMTPSA id q2sm3415903pfu.66.2022.01.06.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:42:20 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Abdun Nihaal <abdun.nihaal@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: r8188eu: remove unneeded ret variables
Date:   Thu,  6 Jan 2022 23:11:50 +0530
Message-Id: <cover.1641490034.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes unneeded return variables in ioctl_linux.c,
and also converts functions that always return 0 to return void.

v1 -> v2:

- As suggested by Greg, change functions that always return 0
  and whose return value is not used, to return void instead.
- Not removing return variables in rtw_p2p_get2 and rtw_p2p_set
  as they may need to be used.
  These functions call other functions that do return error codes
  (mostly -1 and -EFAULT) but are not propagated back.
  I'll send a different patch to fix that.

Abdun Nihaal (2):
  staging: r8188eu: remove unneeded ret variables
  staging: r8188eu: change functions to return void

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 156 ++++++++-----------
 1 file changed, 68 insertions(+), 88 deletions(-)

-- 
2.34.1

