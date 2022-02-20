Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58F4BD175
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiBTUay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbiBTUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:30:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13C522D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so27876720eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=dlG18bj99ERjBOy6kSTcERQdUmxCadRteA/b+q4I8ZA=;
        b=CPG5N4iqjLnPDIkNp+CwkhD3MdeSNJtQfOzDry/tuDfuKF9OMRfCGcw417Q6gNsWE9
         qGQNGO3GfbFqcp8MkJQeGL8c7irF2uSmM/3/2QKb+JK/7nXB8JUoGoJ3Imm3A1Cef2ax
         wuFuVHX3vwFYDrvv0thldfA/sT88umGwBibi7oKXmxj2LmA+M332WeuaB4wEeUrUcS7z
         zDmz1VMi+9zQ6HjrI+0bmL9TMVvWHFy+U5TWRDVyflw2SgDo6uDaX5VpXWZJ7n89oZXE
         LLjIEqrK2pwbgUTvL/omUKLjjCBWmH901WpcICDxIHvwsh6PQgBfZGE6vH8wF5l+TmvM
         11bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=dlG18bj99ERjBOy6kSTcERQdUmxCadRteA/b+q4I8ZA=;
        b=BJyWW+eu56ZBXMU/Rbsan+aG6ErX+FfLOATEZsO30sj5yIBQFrXhnnz0koRg/iRqSf
         wRKeX4gJdRc3EDBECDBbckrFuqT4Hdkeg+00gGsgKojp/ndsPOS64zZRseAbPEpOMJx7
         i0Jew/l+it0aIXr5OsZhhoYJ0byFVbHks+Sidcow+vD/YpbHc9egi4Ne+QC0WYrBU0NU
         olZruxlNGXOwV2eThib7neqHMYZm/KWXclC1qr8wOTTcBeQO/Z8cpVQBGRAoP4Ihxh9K
         AaO+efkWkfz8gFtOrNGWxHTfw+32awHW1Sg+ipslG9K2XC4Hzfdsrr7DTEuPcK+6QArg
         gGCQ==
X-Gm-Message-State: AOAM533MeTyx7ikP8uac6nH/pjMG6SD3VWdgpyLM3WNpfkn3i3Q6oSfU
        s31UWsFRcd+RLSbPKjRKcLY=
X-Google-Smtp-Source: ABdhPJzCg1GsTzm/Y4Fl1EH0/KIQ7cbs3XpyXIVGzX4DHCeE14l1XxWWVjrzo/27U13fdaMQe+OLWA==
X-Received: by 2002:a17:907:138e:b0:6cc:f1aa:a8fe with SMTP id vs14-20020a170907138e00b006ccf1aaa8femr13150921ejb.25.1645389025651;
        Sun, 20 Feb 2022 12:30:25 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id e17sm4467279ejl.68.2022.02.20.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:30:25 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:30:23 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: vt6656: Fix CamelCase, add comments, change
 macro to function
Message-ID: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various checkpatch.pl fixes as liste below
Tested with device VNT6656G6A40
Transferred this patches over VNT6656G6A40

Philipp Hortmann (3):
  staging: vt6656: Fix CamelCase warnings in mac.h and mac.c
  staging: vt6656: Add comment and change macro to function
  staging: vt6656: Remove ftrace-like logging and unnecessary line
    breaks

 drivers/staging/vt6656/device.h | 11 ++---------
 drivers/staging/vt6656/mac.c    | 14 +++++++-------
 drivers/staging/vt6656/mac.h    | 22 +++++++++++-----------
 drivers/staging/vt6656/rxtx.c   |  8 ++------
 drivers/staging/vt6656/wcmd.c   | 13 +++++++++++--
 5 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.25.1

