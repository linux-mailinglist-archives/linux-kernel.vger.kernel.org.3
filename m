Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB552FF3D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiEUUSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiEUUSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:18:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749AF45059;
        Sat, 21 May 2022 13:18:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so9931754plr.9;
        Sat, 21 May 2022 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ECDza/wM60kuM1rzRXS/IlPvbAhsprpMRKVGkbqUmVg=;
        b=eqJos4Oo6ZC9fT0aKuKS5uGvS5wXcUip14am5fuOpU8pWWycJRC0lDBKDvY3vsxodn
         J8teEmpqM1yCQucklH/s0p/p4xgQdMevcxoIrSZEJAMerKZ0nLl+my3YrUvTbDwnp9E8
         0TTWZY2s3DtlLR2E70qqyBz6K1lAXAmDHXWoTvcql7Q/D4CmUyEa7vykXsU30GB7s/e3
         5u6UIlVAWJF2jLU1rCmOXV3c97KNuMq453M1hlYVokGYF4wNtCJ9Mp2Nc01fqt/KYeNc
         K6ogKcCgLC/spa3xxcHwUhIcu84L69pYNNZPNtnF2G0TCWWxwP66FgWWiSzwYEoWn3PS
         yNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ECDza/wM60kuM1rzRXS/IlPvbAhsprpMRKVGkbqUmVg=;
        b=CQ/P4a2acgeuTWAAYHm+F4heNTyiELVxcRhS/1FtHIPZBQ5sTJmntB1WzM5KpcSiVi
         Qao8/aJHTd0bNOrcu16MmvZfcHZA0ha1rH05maHegLHLeF5XuTN7EyERlsThqNnNJAiB
         wzGC++N9N1us8Cs+tgK7gHOgsXLgbXdbhjXRZJHTo7nvGZAm5JGhdithiWZQfOp6MLEC
         y36Y6jDCeTT1CW/VnA+DaCDPNM8drhWcFIuS2GjrG6+wB7Se6ziBPi+Tnuuh0IQNj6wL
         PqT/VZ1N72Zy8cN0rlxhKsGTSCG6CO/uQkD32pAPBBJktYy+ESOlTp4ZdGRmaAyap/Lo
         CY/A==
X-Gm-Message-State: AOAM531BJTPLmi0zHWgFINrcFGZf9YZP6C1ni5T4zkU3VBwvAx9WJEvz
        /VmpX7rPiMdmkppwLngJWbk/wqPhu0g=
X-Google-Smtp-Source: ABdhPJxvJJ2Fv8vVemJMHOsIGOWQ5OS6JVyBYKLyrvsGs63HtUO1PZMe8HXBAmxZrBpaqgBq/QRuRg==
X-Received: by 2002:a17:90b:350d:b0:1dc:6680:6f1d with SMTP id ls13-20020a17090b350d00b001dc66806f1dmr18471151pjb.27.1653164290642;
        Sat, 21 May 2022 13:18:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:cb52:1dc9:39a:7637])
        by smtp.gmail.com with ESMTPSA id b134-20020a63348c000000b003c14af5062dsm1867999pga.69.2022.05.21.13.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 13:18:09 -0700 (PDT)
Date:   Sat, 21 May 2022 13:18:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.18-rc7
Message-ID: <YolI/0sPArJSnlIZ@google.com>
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

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.18-rc7

to receive updates for the input subsystem. You will get a small fixup
to ili210x touchscreen driver, and updated maintainer entry for the
device tree binding of Mediatek 6779 keypad.

Changelog:
---------

Marek Vasut (2):
      Input: ili210x - fix reset timing
      Input: ili210x - use one common reset implementation

Mattijs Korpershoek (1):
      dt-bindings: input: mediatek,mt6779-keypad: update maintainer

Diffstat:
--------

 .../bindings/input/mediatek,mt6779-keypad.yaml       |  2 +-
 drivers/input/touchscreen/ili210x.c                  | 20 ++++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

Thanks.


-- 
Dmitry
