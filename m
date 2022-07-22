Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9435357E8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiGVVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGVVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:15:34 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A75A178
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:15:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k3so2022198vsr.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zdITWxCQbDMIFMdrHO9U0bx9NSgA44uMu1yqYgiQF30=;
        b=GuaMK1BqI3qgbBFHRkgXK2TWyArHuT0nCyVLfvgZJjtLo3xj7As6p+Iklg0EmL7zKx
         ND/6ELlRB4IwuYwQXZdhrFCe8sbCdZqR3gsbqUkWxaT0e7JjIAWNgV6svCuhQPY1D9TO
         T+q/kcDzBzO2mJqSehD5a0A6NZCrzmGdMMC71BLrev2v3Oqv80hn/DKEkGVWzz/jARoW
         FGiTWJyEDkrtt3rq0NheI94Ct/4StMYCxzoHn/N1iy3UfoRNu4PDkxw23Ems/n2dQPNv
         lqVZVRrxUYGwaiMQLPg5PnJjyj8puWyjv52zgPBfyUsro+G21aABtJozzCl1mZkcbJn6
         +5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zdITWxCQbDMIFMdrHO9U0bx9NSgA44uMu1yqYgiQF30=;
        b=wJuVaJL9tJUZ6b39j0CTZEDfrB+5Wqz+irnRCMjC4l05Q3LuUianzjOvn0o2ivUJsA
         oBdogZod7chRiYx3fr1rXPNX3FYdbJPxZ27FB4fNf64wdLEg/y/bttrADRnlzKiKITkr
         5hXFz6nzN/tRZ9LJkO4+nGwCYfi4BiIHpTNDD+GsSgmCOGlNUh/VklzlYaGIHgYTn4C2
         NtctqW6uRNVGodr/gI7MY/H+PCbbuSQa3GEX/EuQ29W4B+bDYC97lA+HiRnN+I45zxa2
         5XkQSJ8hlWNLIbh4Jrmccn0kSHkr2QYj3bXVeEHswXSGVrZffM/1QsCZ7CihmABfULyl
         7qfw==
X-Gm-Message-State: AJIora8IY+bVRI+uGgG7Z1zEdjNHtMbBJv7PhYG8y8gUnbtV8lNmWtmN
        WYHBHEV6mZHI9ELjfrA2zkAbzuR5yaPQm2hWVIk=
X-Google-Smtp-Source: AGRyM1tuBlsh9jLawLCbMAtZByli22cjEoF1sWSkYKYli+t+Ldt+/U17T9wZdfo2DRfYA9obz3Q3hs5SKaRe3MklhG4=
X-Received: by 2002:a67:d819:0:b0:357:440c:7512 with SMTP id
 e25-20020a67d819000000b00357440c7512mr720246vsj.57.1658524531418; Fri, 22 Jul
 2022 14:15:31 -0700 (PDT)
MIME-Version: 1.0
From:   Stafford Horne <shorne@gmail.com>
Date:   Sat, 23 Jul 2022 06:15:20 +0900
Message-ID: <CAAfxs74q-FvxfrCCr_arW7yRxczYJSr-ncCjTu2cufLFhizRZQ@mail.gmail.com>
Subject: Mails to linux-xtensa@linux-xtensa.org bouncing
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris and Max,

The patches I have recently been sending related to PCI updates for
linux have been bouncing when delivered to
linux-xtensa@linux-xtensa.org due to:

  452 4.3.1 Insufficient system storage

I can see the servers are still up.

Is this list still going to be maintained or should we be removing
this from MAINTAINERS file in linux?

-Stafford

--

diff --git a/MAINTAINERS b/MAINTAINERS
index e64ca0ac6db7..f313862b2929 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19799,7 +19799,6 @@ F:      sound/soc/codecs/tscs*.h
 TENSILICA XTENSA PORT (xtensa)
 M:     Chris Zankel <chris@zankel.net>
 M:     Max Filippov <jcmvbkbc@gmail.com>
-L:     linux-xtensa@linux-xtensa.org
 S:     Maintained
 T:     git git://github.com/czankel/xtensa-linux.git
 F:     arch/xtensa/
@@ -22100,7 +22099,6 @@ F:      drivers/gpio/gpio-xra1403.c

 XTENSA XTFPGA PLATFORM SUPPORT
 M:     Max Filippov <jcmvbkbc@gmail.com>
-L:     linux-xtensa@linux-xtensa.org
 S:     Maintained
 F:     drivers/spi/spi-xtensa-xtfpga.c
 F:     sound/soc/xtensa/xtfpga-i2s.c
~
