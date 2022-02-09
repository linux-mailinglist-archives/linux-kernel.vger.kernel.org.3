Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FCC4AF6DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiBIQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiBIQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C17BC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso4110299pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPW8mVCw4MrqTJ8vozaqP06taDowj1TVJJcqIK2tj1k=;
        b=pzxJLP6rtImsQ3liqEAeYv+fquczQUi6O4B+tI22FsHC/ueGSL9nm+5mUJcZF/WaXK
         rq2uhqnO9ByYYdrFaLJ4iZijv3dTFEJpLkiSJ54zqht2D3GYkx4WK1tW3+HhWJUt+OIo
         ir+7strdRwypmmrN7XLijsZcIqOZTGk88t3nVUA1HZkD92VErcLObQ9VCj7dvvVVddNK
         nhrXf8J7ssk6RSBslUjaykn9zvTLibCIxqCD7v0H+WXSfa9Ywa6LluLMrLufN+zL+PAd
         9RVvQLeuvF8+jCbERXJ3jvmX5vMwNfWwg0rCakJnCucRurqpEXnwStny4w+sGFdVXSrJ
         hB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sPW8mVCw4MrqTJ8vozaqP06taDowj1TVJJcqIK2tj1k=;
        b=sgBCItpaN89LV4DyZUaHUa8JrrgcfoYyXX2xMFMJkZ7LQeHg7KjVHU7YOaSP0zxUa0
         GeJX5OHEXb4vgjuCxefJ/hc29LRJNNacu5Of5X3k9VUfhZ+Ef6nTVVfthRN8+CQyf1J7
         0BOw3f7v1hlNCEC6JKgMrL4T8z7v4AqXQb40F0VQVimWF+BgNJIk6L8G1nY+W3ND+XUl
         yneu8wXIk6wBRf5bS79JnLnihZcNuLJzUufhdamjwOt/Q0LafbzNBWqhhiaqQITtRkYW
         nWXvG9QBzbIRGiTe9HGuXLJesGKdQsKXFqWn6tGsdCCQopY/izYltnqbxiDqMl6gfwqZ
         0BKA==
X-Gm-Message-State: AOAM533/4Z/weTaB0GcNO4MBsCetvJWH1HUx2sBp9SOzRzJ0Zsnlw5qD
        2A6ZrN9rBF36HjYTfSsOtjE=
X-Google-Smtp-Source: ABdhPJyYFCCz/u7zAow5JFgjk9HWwix4smcsFPf2aKDHDxGGTbAo9NDYuic0Ampcj6fzRNR7msJteg==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr2938454plr.59.1644424641789;
        Wed, 09 Feb 2022 08:37:21 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:21 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 0/9] staging: r8188eu: set of simple cleanups
Date:   Wed,  9 Feb 2022 22:05:58 +0530
Message-Id: <cover.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series removes unused struct, function arguments, macros
and empty functions.

Abdun Nihaal (9):
  staging: r8188eu: remove unused struct zero_bulkout_context
  staging: r8188eu: remove empty function
    rtw_get_encrypt_decrypt_from_registrypriv
  staging: r8188eu: remove empty function rtw_mfree_mlme_priv_lock
  staging: r8188eu: remove empty function _InitOperationMode
  staging: r8188eu: remove empty function __nat25_db_print
  staging: r8188eu: remove unused argument in __nat25_has_expired
  staging: r8188eu: remove unused argument in on_action_public_default
  staging: r8188eu: remove unused argument in chk_ap_is_alive
  staging: r8188eu: remove unused macros in sta_info.h

 drivers/staging/r8188eu/core/rtw_br_ext.c     | 15 +-----
 drivers/staging/r8188eu/core/rtw_mlme.c       | 13 ------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  8 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     |  5 --
 drivers/staging/r8188eu/include/rtw_mlme.h    |  2 -
 drivers/staging/r8188eu/include/sta_info.h    | 46 -------------------
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  7 ---
 7 files changed, 6 insertions(+), 90 deletions(-)

-- 
2.34.1

