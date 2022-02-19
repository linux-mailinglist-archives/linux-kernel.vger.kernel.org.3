Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54A4BCB07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 23:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiBSWgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 17:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBSWgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 17:36:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2140936304;
        Sat, 19 Feb 2022 14:36:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso11740120pjj.1;
        Sat, 19 Feb 2022 14:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=lYOOnZvBquyK3ZpLli+07NeGxbB9GhktMXo1LQUp0ow=;
        b=Axx8UdHqOdEglPC/gBTglvuNaRZBpQ+uTc2LsI/e+V9824sLGw7Y69CLJK+zOI+F0F
         W9XSm7DwwgEtmv3vKisqYbMlkB3ovWICpL8BLOh4ucntGlQwF6uEi23483hIqWX1QR3H
         3ue8OmOiI1ph3iYRZs1oUrM2Mm88+1sbvWXC0v86FkbkaJnlHAD2GNkMaAjkSNPJI8G1
         weXpxM/nJ0UL8z2IPIhiwy1wW5mNiGcUfuGXoIpLkusE6XdN0FsYlFH8+n0k1ZESMJIr
         alnMv1n0nelHkb+XUitDi0cJ9kyjr+w3hxuGB1yl/PaHjKomfmc61LK3iJB++1iRvWaA
         RXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=lYOOnZvBquyK3ZpLli+07NeGxbB9GhktMXo1LQUp0ow=;
        b=CcLAVV4hN7u6Bz+/HfHr3MFSP2DKHtL1fpuEBRuGz4Fb1Rlskno48wSSKixD7nz2Tg
         iD+BWGUIh8p8b9a0KpF0keemwQkWCXvmNGb+jaWz6aiUQjEQHmGg6BYqRElcKJw4E7Rd
         CHtsuzsgH1pib6Tt8+H59f98XbkjWI3IRzzizwLF1H4VaCARL/6oddrjd1X/BAX75c5J
         mseDqlTGrfESUs6WJSnO9PrURAS6OygrjUD3Mm5iP2LAAuSzR/ScDkJP1smUo+HBupg+
         WmAjEJZMAcVw7Ks/TSq4zfZH2z90tTJ6YuItPXKDAni6xggIysBfT3+0eyhBOzq7DY6O
         1IkA==
X-Gm-Message-State: AOAM532E9CqNsn5wodY86feXdcsywSVRteLQ1qVd7Rc1tQwa+c+wn5lP
        ba98mynxfqYnmHzzSvf7/q0=
X-Google-Smtp-Source: ABdhPJxo5fKNtUbFthCAnyUtWN9owhNvhpnl7sQ0v9LaLBZAfPOvnTJz0fCWbOvXiWBtOLIIo6qwlA==
X-Received: by 2002:a17:90b:2251:b0:1b8:c4cc:2057 with SMTP id hk17-20020a17090b225100b001b8c4cc2057mr18668176pjb.193.1645310179360;
        Sat, 19 Feb 2022 14:36:19 -0800 (PST)
Received: from google.com ([2620:15c:202:201:838d:dd9:2070:e4c7])
        by smtp.gmail.com with ESMTPSA id g14sm2550738pfj.80.2022.02.19.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 14:36:18 -0800 (PST)
Date:   Sat, 19 Feb 2022 14:36:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v5.17-rc4
Message-ID: <YhFw3yaB6CCihNEN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a fix for Synaptics touchpads in RMI4 mode failing to suspend/resume
  properly because I2C client devices are now being suspended and
  resumed asynchronously which changed the ordering
- a change to make sure we do not set right and middle buttons
  capabilities on touchpads that are "buttonpads" (i.e. do not have
  separate physical buttons)
- a change to zinitix touchscreen driver adding more compatible
  strings/IDs.

Changelog:
---------

Dmitry Torokhov (1):
      Input: psmouse - set up dependency between PS/2 and SMBus companions

José Expósito (1):
      Input: clear BTN_RIGHT/MIDDLE on buttonpads

Linus Walleij (1):
      Input: zinitix - add new compatible strings

Diffstat:
--------

 drivers/input/input.c               |  6 ++++++
 drivers/input/mouse/psmouse-smbus.c | 10 ++++++++++
 drivers/input/touchscreen/zinitix.c | 12 ++++++++++++
 3 files changed, 28 insertions(+)

Thanks.


-- 
Dmitry
