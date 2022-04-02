Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15A4EFF65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiDBHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiDBHbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:31:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C6174E86
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:29:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bh17so10116500ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=VIsazpZqnc9Y6800sSSLJKWoimkfCmom/y4Xr16gegk=;
        b=bsCXpJ6tYDHiHBqAzfmVkNECsspN+abP0vlSk+dBDHGL1Mat8nUzWD5iSJI0hMv/rz
         pNpn6zwq1HUHAgISc73i7IBhz9Gixzf/uaCDxHNvqwE+giMbaoaZVLMjKH4jEzNJ4Sc9
         Ol6lEIw6iUhBhsM8mNKeSxH45VtBRr7ZIpeykAjLrdgUTJTdHGT+lq93Q2AokOr0em14
         Crlt+QAv8PdaURIUZBbwDGEsWwL4PLafw4uElDUO3R4xgpIOcJx8o0nCFDQJz7k5i/3K
         /4+RIFcikVKwdNJmeOZ1WVhTH2ZLX7XodYQYLOFQTKPybRIL0wYxLedD0ndyJm2hWbRJ
         vlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=VIsazpZqnc9Y6800sSSLJKWoimkfCmom/y4Xr16gegk=;
        b=oWMjj4jpnhOiopckRSK5ql6Yg7quPikT+eeaZI8Wy5TpvCYVMlO7n2ASMjAgYlEaHH
         Pu7iHBkWZlWjrEJJS74HIfhrUDPN2Se+hY+6FQhBhGxs/XKY1xlq0CzfrvVjYgKUrnrf
         gyiZnYvt7Nw2bQ2oDPv5vWMGDaKkSg5LMjaFSzRvxNseOw7CqXth7gn0UwOWppVx+XfM
         iZLs+eaz83Rg8WbJWOH5GLlPZG2naZuKu8jVzNsW2Lx9KTDst4oqlqliEZPtk782mdWg
         iqackU8LNEKSOYltB0HElh0AVooIFU2Og/3ZBKioXU7KIqRqedHTZs3DNXVoPw2kYB6X
         ipig==
X-Gm-Message-State: AOAM530zuUovfvBatqB5j3jQTB+8OnYwqf0IxZgeHWcT7laCqWmlj4Ec
        OfbTxlx5cWmsP7P5huiWtfYiEqt2YrM=
X-Google-Smtp-Source: ABdhPJxHqaCaMIYZnIwWusSw2HTc8081FvcxjQRcWNnDBAEjpeQOfCI5ZjGnaUAAklQu/Y505Rks5g==
X-Received: by 2002:a17:907:6d96:b0:6df:f199:6a7c with SMTP id sb22-20020a1709076d9600b006dff1996a7cmr2889889ejc.137.1648884557355;
        Sat, 02 Apr 2022 00:29:17 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640205c900b00418d79d4a61sm2148118edx.97.2022.04.02.00.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 00:29:16 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:29:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: vt6655: Fix CamelCase in upc.h and started in
 mac.h
Message-ID: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
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

Start fix CamelCase by
- removing macros
- renaming macros
- converting from do-while(0) macro to function

---
Tested with vt6655 on mini PCI Module
Transferred this patch over vt6655

Philipp Hortmann (7):
  staging: vt6655: Remove unused macros with do while(0)
  staging: vt6655: Remove unused macros with CamelCase in mac.h
  staging: vt6655: Rename constant definitions with CamelCase
  staging: vt6655: Rename macro arguments with CamelCase
  staging: vt6655: Rename macros VNSvInPortB,W,D
  staging: vt6655: Rename macros VNSvOutPortB,W,D
  staging: vt6655: Convert macro PCAvDelayByIO to function

 drivers/staging/vt6655/baseband.c    |  16 +-
 drivers/staging/vt6655/card.c        |  60 +++---
 drivers/staging/vt6655/channel.c     |   4 +-
 drivers/staging/vt6655/device_main.c |  30 +--
 drivers/staging/vt6655/mac.h         | 293 ++++++++-------------------
 drivers/staging/vt6655/power.c       |   4 +-
 drivers/staging/vt6655/rf.c          |  14 +-
 drivers/staging/vt6655/rxtx.c        |   4 +-
 drivers/staging/vt6655/srom.c        |  29 ++-
 drivers/staging/vt6655/srom.h        |   2 +
 drivers/staging/vt6655/upc.h         |  47 ++---
 11 files changed, 186 insertions(+), 317 deletions(-)

-- 
2.25.1

