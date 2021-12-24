Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1747EF67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352860AbhLXOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhLXOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:12:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36495C061401;
        Fri, 24 Dec 2021 06:12:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj24so7807394pjb.0;
        Fri, 24 Dec 2021 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtPf/Iw3oKW7SjqgJKtt+Q5d6Jb37vINBRVmuoZAHlw=;
        b=ENc6ky9e/mt/VRWpBsDP/fT+YyPj602j72RD0InZqfV4ILpG9XdJYMiYd+/SP4Rutz
         jjIEw7ZD8vEHFsdIW+Rl5y5TCsAMPxqDcJr+tghirPYRPDL8xErWN+sT30KOVtTUi7ak
         MDhyEXx3fCZhPt/SSCbYL5zmXaYN7Ol8WHHfvBpqdft8Jzi/d4O/UsEMQOFrtHinvP+j
         n1/wV4KoiF+JMLM8VPvmqfqK9LN0nHWUkaI/X+RUC4E35aB6HdDzV2oraogH7JPOtaz2
         aOElZjNaxQYRfxkkWv4iNlKHv3LdXKUrEHpPfj09oc4uYhYUqiiV1K2PJcGy1y9VOvKx
         IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtPf/Iw3oKW7SjqgJKtt+Q5d6Jb37vINBRVmuoZAHlw=;
        b=kJ4DUne/E0GXlRToVspX/5+CvqOzNH3ODlIWvjqWXfq+EChkPdU6XaCSsu809Uwqds
         kUrotimT6wUuXiuIWZ8jab/Y0ycsvYPhUhka2VBcnIhifXgTTIYmr+mwDRWu2eqCDqyZ
         LMIMHqg9KsRRKTg1XXjIaBYvH+jEmDVnibmpNFGxp9RhgfjRKjDDoVckSuaUG9Tcftdd
         jHHnnUDouL2eZVN+bpGSmkWaWaTtkmTNviwqEiEPGkD6dRpjDs/3oLk4JG5zHY4qzW93
         DWXKaKUGDFosKkXR28awVasdjlnFHG8d1Noot6pjBfWxTbbOx6N7+/9vodJGyFTT+REy
         0chg==
X-Gm-Message-State: AOAM532u7M3gYOj30eb1He5ptXT9UKTMfwwDM7vC7GBAnira2NiCPA4M
        5jHd6iAtYwlBrxESaP5Qxaw=
X-Google-Smtp-Source: ABdhPJwuHNQ5wIihLXmE4RhuD5G0B9yFVj7TU/csvtFs8majuv8qgopdCGHaYHkmq75cFt+ukir3Ww==
X-Received: by 2002:a17:903:2302:b0:148:e4c7:5573 with SMTP id d2-20020a170903230200b00148e4c75573mr6824405plh.109.1640355150821;
        Fri, 24 Dec 2021 06:12:30 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:800:94db:99e3:c3c:2dfc:8554])
        by smtp.gmail.com with ESMTPSA id h7sm9919140pfv.35.2021.12.24.06.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 06:12:30 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     kevin3.tang@gmail.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        dan.carpenter@oracle.com, zou_wei@huawei.com,
        lukas.bulwahn@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] sprd drm cover letter
Date:   Fri, 24 Dec 2021 22:12:11 +0800
Message-Id: <20211224141213.27612-1-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
  remove the selected DRM_KMS_CMA_HELPER in kconfig
  drm-sprd-fix-potential-NULL-dereference

Kevin Tang (2):
  drm/sprd: remove the selected DRM_KMS_CMA_HELPER in kconfig
  drm/sprd: fix potential NULL dereference

 drivers/gpu/drm/sprd/Kconfig    | 1 -
 drivers/gpu/drm/sprd/sprd_dpu.c | 3 +++
 drivers/gpu/drm/sprd/sprd_drm.c | 8 ++------
 drivers/gpu/drm/sprd/sprd_dsi.c | 3 +++
 4 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.29.0

