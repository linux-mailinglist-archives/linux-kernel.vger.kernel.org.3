Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78373589A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiHDKzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiHDKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:55:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F511457
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:55:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so2223958ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYiE0Wz0Ij1rq07h/DGjjvFWkIZBMv0fucBm9a2zZb8=;
        b=kZFFkw8UQyzJJcJZFrr7/0f3RoTn+BvaT9mmt1CkrpMNFBjWfpLTboW9DdLUAQ4B+P
         tOO3RDx+3EBG2XvDKKwa0UGjGMXlSDGsCNa8U/Gz1w8DdfSfEBFY9PqdIbOCjanjeVHd
         xrSe0z9jr0+Kt6DwRfrB3xHc1GEDQ9P7/POGrmuf2hDBrWUz1By4mJyVb9qabI0ET03q
         UcijC1+VwFtbp9mKAFcATE/IuYdkhxeVSrZc4dRgpRNI5D6JWkdb2gEttzOqUkmxX2I/
         opPDqjbNpXX/4MhMegGQb4Fwe2DuUjzuHF3Eje6ltcGpXFNGj+yysHboODrUrRJwJLXU
         Voow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYiE0Wz0Ij1rq07h/DGjjvFWkIZBMv0fucBm9a2zZb8=;
        b=a/hqCF1lAH8cMJadIL77/K5YWIevlt/HFtBaqGzV3ufqMkgOEiCHoBkrDQeCueUmwb
         QIJ0RjZo/5MP14OGbEIkTIVprc/7qBXMtXzhB1ddXQzO5xpBrZLwEym9tCNNXUB4p6A3
         wWG1wuV/RfbJZdEw3Imrbd+//UZfgoEu2RThLYwzzgJZNvrSSx0X/fP2nY1s/TgZh29l
         Dn+1xKtl3z/54fi4M0N1TuoPg0VSaMYEF2enyo8o3Q3MjmtTzPK7aT7F6McMuKqtgv3u
         x9LafR2hC5cal9NPnPuSDcX5GzluEjYse0ueix25Lj5k26Rre9sCcNMHDOuvIHDnU0RS
         nLOA==
X-Gm-Message-State: ACgBeo3IAhLGUysGKP1yN+asFcSby5q4jg/k2h2R1AtJY/Mv3EXf6cyK
        Fmye5mYaBvEUXCMPmcKZLE0=
X-Google-Smtp-Source: AA6agR6gFj+30Eud6y9StMXbLKhIC/bJDEgTlK0NR6xD6dYlsBhHvObVkA2EjaWCkci0Mzx3YOipTQ==
X-Received: by 2002:a17:906:6a02:b0:730:9f44:2bff with SMTP id qw2-20020a1709066a0200b007309f442bffmr973382ejc.209.1659610547708;
        Thu, 04 Aug 2022 03:55:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id y89-20020a50bb62000000b0043ba0cf5dbasm510013ede.2.2022.08.04.03.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 03:55:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: make some functions static
Date:   Thu,  4 Aug 2022 12:55:30 +0200
Message-Id: <20220804105532.7532-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes some functions static what allows us to remove the
files hal/rtl8188e_xmit.c and hal/rtl8188eu_recv.c.

Michael Straube (2):
  staging: r8188eu: make handle_txrpt_ccx_88e() static
  staging: r8188eu: make rtl8188eu_{init,free}_recv_priv() static

 drivers/staging/r8188eu/Makefile              |  2 -
 drivers/staging/r8188eu/core/rtw_recv.c       | 79 ++++++++++++++++
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 -----
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  | 91 -------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 14 +++
 .../staging/r8188eu/include/rtl8188e_recv.h   |  2 -
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  2 -
 7 files changed, 93 insertions(+), 119 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c

-- 
2.37.1

