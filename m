Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783AB4D6D44
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 08:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiCLHq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 02:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCLHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 02:46:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3812C23404B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:45:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bi12so23592990ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 23:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4835zrpoRS2nrbhwxOavV/79b/8h8dZXR7yphVPqqJk=;
        b=TGkV97FD5HKzfpXnmTpEW/Y3rJXTQToFDLlcpuzUs2cRYWDYXdNBRlYuU7df1EjlO6
         Njo/xDuI1piuGPGhJMf/8NdaOOZUuysQQpFZB/EkFSsiljC/JpIQpRE+2j0GCgndKT1o
         9re0gBbcqmUf3/Uh3xwhrvLSrmBVgVEQY+HkYS68T7FWgbow4wLJDEAJS2hBLRmRFb/W
         +UOoMa8dLJQTHCi4eVmch/MsFWVEbzq41QFgnxYah6Gem1XhleS08pSQnBCO+VokkhQe
         oTqqAZtE4/gvT+yEEJbQIHGkMNngM+i513CjOk6mwZ4HsonNW2ju8IjCAzFFAU/x0LK8
         AgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4835zrpoRS2nrbhwxOavV/79b/8h8dZXR7yphVPqqJk=;
        b=6sfKD9KYFpFQnatGRKMtXrgHvkDSN5zvT4iwgbYBIDMO74TvTBTQjCA39Vp4LANYtM
         0/R+J8LOOa6AY+yFtLFOxsjt/gO3Dsn05S1526ud73qRbfp65Knct6iyb6+U83iGsT5r
         FRWtdGCrFy8P9dCh6cxMq8JBR+HRQhG6MJkwWyiU9hjFPqZY4mt+G0JPdeeXpdB5nxt6
         TTsI1IH5a0n/jALlOK2wtXXz9lQj+ACrp0KZ/h1bnR5k6WIEw1TME/cYkcoNxFiGX+D9
         E/T6DNOI8uDKrgjUNg5blkWJRse9nuD+JlH02any/WHl1PjRjcTOWDNEqJKQLEpM49GH
         i7gw==
X-Gm-Message-State: AOAM531Xhq9Vs7uS8+tjLMWYCQW0yM15tnYuv0AIgmP5y9SXfxoDoTLc
        VdF1+Ull/6/dOaxeFYBS9/9IkdTbLDfXyrufW8r8zHECQRo=
X-Google-Smtp-Source: ABdhPJzjtbzf7x03rRzfOfAJe3TZUOVLe4N49aaVEBcQx3Ibw5YAowY/oMZlRD2XUwIFpJXYB297Yu/qIMmSeeNAt6s=
X-Received: by 2002:a17:907:869f:b0:6da:888b:4258 with SMTP id
 qa31-20020a170907869f00b006da888b4258mr11695684ejc.720.1647071149837; Fri, 11
 Mar 2022 23:45:49 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 12 Mar 2022 17:45:38 +1000
Message-ID: <CAPM=9tyAqzcvaba2OffVt_EEP_1tQc3UV6h1J92An0uKOF1TJA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc8 (kconfig fix)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@leemhuis.info, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thorsten pointed out this had fallen down the cracks and was in -next
only, I've picked it out, fixed up it's Fixes: line.

Thanks,
Dave.

drm-fixes-2022-03-12:
drm kconfig fix for 5.17-rc8

- fix regression in Kconfig.
The following changes since commit 30eb13a26014ca640b5eb57b6d010114084d5c92:

  Merge tag 'drm-intel-fixes-2022-03-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-03-11
13:26:19 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-03-12

for you to fetch changes up to 3755d35ee1d2454b20b8a1e20d790e56201678a4:

  drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP (2022-03-12 17:41:30 +1000)

----------------------------------------------------------------
drm kconfig fix for 5.17-rc8

- fix regression in Kconfig.

----------------------------------------------------------------
Thomas Zimmermann (1):
      drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP

 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)
