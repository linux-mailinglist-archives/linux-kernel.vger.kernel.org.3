Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA135AC148
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiICUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICUFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:05:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502A2CDFA;
        Sat,  3 Sep 2022 13:05:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y29so5160058pfq.0;
        Sat, 03 Sep 2022 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=XIYPkRvxAVyJZ8758VPMnQXXVzGY/2gLg8W5CxBNhEQ=;
        b=T64co4pFrl6pvsmMK4pHYGKtxLF5UILMRpxu0XFUucSkQltpeRNSXClldoJnhE6Iav
         RmUNi/YdTeW9NzifnRhYeJNIvSVcu1FPiMhE48fHQgWNgvarcNIoAn7dKXmYXwJqWZxX
         IVCosSBslKT8u24lgnzqMiwzPcBfaKKJakKpznp1+vSjue0OKSeB0r++kOhh3TR2UCXB
         f0kVKdTEH9C6DvYEj3JtrLDCyP9H7cQaMAd5WXtBA1tIqwxa2OfPTprdtcCXZ7ejn/Yn
         s4ichU1oyUn5Xl1wCNIPBdczv/9X9YNZWPb4TKT2mUT2zrz3+TW9NP434mV28VDCEap+
         e+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XIYPkRvxAVyJZ8758VPMnQXXVzGY/2gLg8W5CxBNhEQ=;
        b=u7goWqWshYCn7vx7+gR8Pyg8pMwuQ3dcnapguze+k+8K5hs6Ib3i/mOeg2MQbyouts
         ek/Hup8/jbfffwdAaEjQeLIedgjCEfy+spixb9gM/JLtr/I9707AtAEu6bRdL65vzBFW
         NI/VILP1J+s4a6zRGnkqqsJuE4cCgw8fD8QW+Zi9TCp8yZAkNaZ+Td197oBDndR6HFWW
         8cz1+gV2Br/FMr61GHV2g+hlivTPspfpxzkVNn2CDW7+HEMICC7rxIIf53wiQGtOGhu5
         tjhXJaAHgu8C8SMWTRXfjUuB6Bluw6YH2lSPZWW4lVDWkyBeerT+lVJqhN/llAcUtxIN
         WxXg==
X-Gm-Message-State: ACgBeo0ntu7KykEgwdzun8frsfU/PrvPYHyNwgKdjG9vG74FzPrjUM7F
        WPdatdhMSkWXt/ntOpsrRCiD84IxrGQ=
X-Google-Smtp-Source: AA6agR5+ildvk3EZSHxece2o1QbD39BSM+BUHnqMaYvLdPje6gI/fFJU3uzL5ocVwCNqSIet+96WOw==
X-Received: by 2002:a63:83c7:0:b0:42b:b618:31b4 with SMTP id h190-20020a6383c7000000b0042bb61831b4mr28923640pge.607.1662235519074;
        Sat, 03 Sep 2022 13:05:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id nd10-20020a17090b4cca00b001fdc88d206fsm157460pjb.9.2022.09.03.13.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 13:05:18 -0700 (PDT)
Date:   Sat, 3 Sep 2022 13:05:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.0-rc3
Message-ID: <YxOzfPVU+ogFrEb8@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.0-rc3

to receive updates for the input subsystem. You will get:

- GT1158 ID added to Goodix touchscreen driver
- Boeder Force Feedback Wheel USB added to iforce joystick driver
- fixup for iforce driver to avoid hangups
- fix autoloading of rk805-pwrkey driver.

Changelog:
---------

Greg Tulli (1):
      Input: iforce - add support for Boeder Force Feedback Wheel

Jarrah Gosbell (2):
      dt-bindings: input: touchscreen: add compatible string for Goodix GT1158
      Input: goodix - add compatible string for GT1158

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/input to INPUT DRIVERS

Ondrej Jirman (1):
      Input: goodix - add support for GT1158

Peter Robinson (1):
      Input: rk805-pwrkey - fix module autoloading

Tetsuo Handa (1):
      Input: iforce - wake up after clearing IFORCE_XMIT_RUNNING flag

Diffstat:
--------

 Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 1 +
 Documentation/input/joydev/joystick.rst                         | 1 +
 MAINTAINERS                                                     | 1 +
 drivers/input/joystick/iforce/iforce-main.c                     | 1 +
 drivers/input/joystick/iforce/iforce-serio.c                    | 6 +++---
 drivers/input/joystick/iforce/iforce-usb.c                      | 8 ++++----
 drivers/input/joystick/iforce/iforce.h                          | 6 ++++++
 drivers/input/misc/rk805-pwrkey.c                               | 1 +
 drivers/input/touchscreen/goodix.c                              | 2 ++
 9 files changed, 20 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
