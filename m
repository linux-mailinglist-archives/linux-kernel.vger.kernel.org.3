Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A447CF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhLVJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbhLVJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:32:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75810C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:32:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso689237wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYB/TUdawN41hYHxVuDOCxwiAE7KHa4GhiWCeovy4PQ=;
        b=Bg782njsmhD9+8ghsOoxu0KpXg8jYHrQYAIkymo8IqhiV7EC2tWPIMvhZj0RIlIBpy
         mzhaBI9bDN763yxt8PtkXBI8UCJ+ljJx3awZESimjFa4ZUJRVy0S2z3oUTUY8qFNY10K
         52hczFyPtbkaqweMuXezMyvgr0mv5lNsfAmMr5FEmSzwR3TCGQbkhijVtyXThIXwL7kZ
         wl09S/tXHMHj99meo/21XRlPzMrDXVleakyIoQiJDBcYkHjej9/V7xE+xXZr2cZYmimU
         tOQMjfSkZrPgoPP6h3iWAlPOL/BrwFEAvqgQ4309Ogzrs7bc+Jg/Ad0OTuAgCtqqYXVj
         SC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYB/TUdawN41hYHxVuDOCxwiAE7KHa4GhiWCeovy4PQ=;
        b=AoWO8by/QRAusrzC/ZGQrBffl2kKOfHzo2me1KtnXdUFJFSEpdCl+54bZqHhuGozPR
         94EaC8PO6gskp9wnw0DBvIZa4tUAyQfhFhfwJF3f0CZTNZT6O8zvMExrMhVbCxinlDA8
         0F0TI0+eXhzTC7khLVnMeoBZygSj14zm4e2wq7OFRygZgMyGnqDAWesWcThKOkpWSRkO
         w+aObree4ntt7hPW7iq2DWwO6vOxCYgqzIfg0YysYzRh8Zzl/LuorlyoC6xcu15DTLBc
         RlaG+Tj+8Mf+4tnop5UJ3wcQyLjycFlFDeUNTNT1dGU0mZS/SPS5nboBee0mWrBcC7gZ
         9nOw==
X-Gm-Message-State: AOAM532SuwlvEYcSi7Vxeja6dz4yajSKAUxcqyKyxfqoifI4N/WIl7VF
        hNiuPdIWo2oDq0GOxZBH0gA=
X-Google-Smtp-Source: ABdhPJxMI1vnKBeE2v2Nm1dHkTKPyoOIvMrHVTwNqbAYkhRBrNb3plR4RJEKUrfA7Uj+UlBeESDA6w==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr278439wmz.89.1640165531019;
        Wed, 22 Dec 2021 01:32:11 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id k7sm1376187wrg.105.2021.12.22.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:32:10 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        cphealy@gmail.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/1] drm/vkms: set plane modifiers
Date:   Wed, 22 Dec 2021 10:32:06 +0100
Message-Id: <20211222093207.29342-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that "drm_plane_funcs.format_mod_supported" has been made truly
optional [1], this third version of the patch is basically identical
to the first version as no format/modifier filtering is required.

José Expósito

[1] https://lore.kernel.org/dri-devel/20211222090552.25972-1-jose.exposito89@gmail.com/T/

José Expósito (1):
  drm/vkms: set plane modifiers

 drivers/gpu/drm/vkms/vkms_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1

