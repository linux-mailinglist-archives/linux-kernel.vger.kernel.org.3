Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9A47F698
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 12:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhLZLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 06:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhLZLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 06:25:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C75C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c66so7897962wma.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfySaQF3GaGT3rKhp9bzdbdDRm7QyTsYlFaa9SIqgGk=;
        b=qT65bImUN96BSUsorxOakT1Pmg3FQcOtCRO8UOzh45/+T06C3mZuMn0Fw+gQOU2F21
         soEjAjCbxIVI4iZZnAsvS9VvHfGJKBXRCf6NmwN0G130W+OZaFKnH7EZnkrdHkgwHROP
         +0KZ6T+OlQgI72s2f6TBshRmysdplrfFcFkDAyzkTGmYZURMW8d1LMFqaaleqd+3rlMQ
         0RlSdf0Dcd9KhEK2cf8yjWFGIyXH/znLFv6huY92C7k1icypdPx6UWBCUOSuSZwu6vg6
         kWmA2y2c1dWmV7bC/lIKDWe6XAQxmMAhNgTLhJ9hRliz+ENdROWuc90jenrwx80PqFzu
         yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfySaQF3GaGT3rKhp9bzdbdDRm7QyTsYlFaa9SIqgGk=;
        b=bw6EcVIomEebxVg5ZCQOqksPiERqb3RKnofFM+F61xQOLn8McC5fT83D4eOmoFMnQx
         03xGmbZEvXELEhFH3REiz3q+bNHhGzVAf3w9DO8h/hDDqmFOzMMTnHCOQcUNRKWo6fX7
         Ovbc9H4hQSeIDjNWcL3Q1g2Q+TA4lYLWolOrxTUiMsTrHI7FEtItoOJiFIbqNrT5847j
         ugph0b0MWZr96Lld7OhEp5/8qxamsRYu0mh5/MM3lQlR/HHJw3ph57KH1uinpWYmVPqc
         FKV06KxLCSYUuDyLREtzn4J0SI7RJVZ06bhohk0Gc0yOrTisDdouYE27ZeU8KI3FyahD
         g1zQ==
X-Gm-Message-State: AOAM5326J80Tgh3GjmTjM4wlZc0UkN+Q4MxfxI3Su3ciwPHlrjPolGkP
        vEalkdpidfmuXq4qn+ZVOP4=
X-Google-Smtp-Source: ABdhPJw59MvLvZ2RZ+XzSNYkTilLCKgdLom4W7pXuZ8fRzh57pIUaKcZzFzTnlj18iy9FRBp2KTB3w==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr10128651wmh.161.1640517912047;
        Sun, 26 Dec 2021 03:25:12 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id g12sm13654743wrd.71.2021.12.26.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 03:25:11 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     contact@emersion.fr
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/6] Add missing format_mod_supported functions
Date:   Sun, 26 Dec 2021 12:24:57 +0100
Message-Id: <20211226112503.31771-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset supersedes [1]. Now the title is a bit misleading, but
I left it this way to (hopefully) facilitate the maintainers' work.

A little context: Originally, I sent a patch adding modifiers to the
VKMS driver and Simon Ser kindly reviewed it and pointed out that
"format_mod_supported" was missing [2].
I asked if the docs were incorrect or if it was a bug in
"create_in_format_blob".

In the first version of this series, Simon Ser and Dmitry Baryshkov
agreed [1] that the code should behave as documented and
"create_in_format_blob" should be changed.

The second version implemented the required changes and drops the
"format_mod_supported" in the drivers that can use the default
implementation. [3]

This third version fixes a compiler warning and adds the reviewed
by tags.

Thanks,
José Expósito

[1] https://lore.kernel.org/dri-devel/CAA8EJpqJ-tWmb5Ba6XSK59toCtLb3nRRmVH8da4Ud_rrRYytmw@mail.gmail.com/T/
[2] https://lore.kernel.org/dri-devel/20211216170532.GA16349@elementary/T/
[3] https://lore.kernel.org/dri-devel/20211222090552.25972-1-jose.exposito89@gmail.com/T/

José Expósito (6):
  drm/plane: Make format_mod_supported truly optional
  drm/plane: Fix typo in format_mod_supported documentation
  drm/simple-kms: Drop format_mod_supported function
  drm/i915/display: Drop format_mod_supported function
  drm: mxsfb: Drop format_mod_supported function
  drm/stm: ltdc: Drop format_mod_supported function

 drivers/gpu/drm/drm_plane.c                 |  9 ++-------
 drivers/gpu/drm/drm_simple_kms_helper.c     |  8 --------
 drivers/gpu/drm/i915/display/intel_cursor.c |  8 --------
 drivers/gpu/drm/mxsfb/mxsfb_kms.c           |  8 --------
 drivers/gpu/drm/stm/ltdc.c                  | 11 -----------
 include/drm/drm_plane.h                     |  2 +-
 6 files changed, 3 insertions(+), 43 deletions(-)

-- 
2.25.1

