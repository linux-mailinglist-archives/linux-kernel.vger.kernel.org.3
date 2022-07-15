Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3757669C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiGOSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:15:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7F25B781
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:15:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so5104204pgs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=FgMl9oVEO8SKRSHHmHE3vUFj1wogj+2bcoxhj4n/5E4=;
        b=nz2jXIe/334gj7wb0LhDsYh3f/uoYgs3QNfrGZa4rZQqqCape282X0YX7C3UiRu2/v
         iOQK5/uLL6C5E2VBoT3y+GI9CyeXNwpzWzNM/2xUATRTYbC2R7SUqzHjISEc9bE9XJxz
         hhczVnXvkljWxObhylGhgKWNu9ZSGnuvPl2MrLVGUqbf86mkRb1DAoHhCWnyedxJidvV
         cg2IbjEK7BR8VHDnJMRyltihZeiZNhFG/S27JuX20epoCEeALhjzYij7x/Pd7ZSyEryO
         hoJ+isbiI6I57JdW2b0YJrTcnZSr9YfceSqTeKb63fivw8wIXVd96lMWvTPPfLWCeD2P
         wqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=FgMl9oVEO8SKRSHHmHE3vUFj1wogj+2bcoxhj4n/5E4=;
        b=APG5yW3PZnsCHhYheSsxC9oRSTDly8Gi7SHH/MyjZPxM3937lew4RRvdgLdWuR05Kx
         1Wh2QSl0DrzUtzcrEAllnPev+TolaDLdvEuNRoboObhRbl2xHgmxCpKzk2MjMfZsXc/6
         8AOVpoObpBRPZyRX5wHWSxjzJNe9xS4QdYCjG4vOqf8IiITvIpZogdJ3hbO2uaiI6W4S
         jdrYXJ2s9LeSXvLMvJQDEDAYiJ/ImeP79qYx3f4iTtFVF97LG4CqLyIi/TaydazfQpIB
         WmrobooEWinlAy6DU7qR60g4g91Rt+wZwzA0tLnJL1fABpQ/r9PqzFSxgtelV4Sm/YOU
         iUYg==
X-Gm-Message-State: AJIora+Wl9bf3xoB16LdDTHd4VXvS2aKBG8G5Wr/aqVPeZbplMvEMeK5
        rRJNBWZ9aEi03+Ka74zCSktaiN3Fvjw=
X-Google-Smtp-Source: AGRyM1su0qZ1nqDIsbFiRi27nd8T+z6SmrMvM1hXuyEDq9weR6Nfm/oacrBvBu7l9J2U1i5JE56FKA==
X-Received: by 2002:a63:164d:0:b0:416:4bc:1c28 with SMTP id 13-20020a63164d000000b0041604bc1c28mr13106199pgw.302.1657908913082;
        Fri, 15 Jul 2022 11:15:13 -0700 (PDT)
Received: from [172.30.1.47] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b0016bf2dc1724sm3822455plb.247.2022.07.15.11.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 11:15:11 -0700 (PDT)
Message-ID: <29565f20-400e-b64d-148f-b1e958b052e3@gmail.com>
Date:   Sat, 16 Jul 2022 03:15:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] extcon next for 5.20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.20. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.20

for you to fetch changes up to 3a06ed80265fa62eecaf519d92f1633e4f9510c7:

  extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP (2022-07-15 11:37:41 +0900)

----------------------------------------------------------------
Update extcon next for v5.20

Detailed description for this pull request:
1. Add new connector type of both EXTCON_DISP_CVBS and EXTCON_DISP_EDP
- Add both EXTCON_DISP_CVBS for Composite Video Broadcast Signal[1] and
  EXTCON_DISP_EDP for Embedded Display Port[2].
  [1] https://en.wikipedia.org/wiki/Composite_video
  [2] https://en.wikipedia.org/wiki/DisplayPort#eDP

2. Fix the minor issues of extcon provider driver
- Drop unused remove function on extcon-fsa9480.c
- Remove extraneous space before a debug message on extcon-palmas.c
- Remove duplicate word in the comment
- Drop useless mask_invert flag on irqchip on extcon-sm5502.c
- Drop useless mask_invert flag on irqchip on extcon-rt8973a.c

----------------------------------------------------------------
Aidan MacDonald (2):
      extcon: sm5502: Drop useless mask_invert flag on irqchip
      extcon: rt8973a: Drop useless mask_invert flag on irqchip

Colin Ian King (1):
      extcon: Remove extraneous space before a debug message

Jiang Jian (1):
      extcon: Drop unexpected word "the" in the comments

Michael Wu (1):
      extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP

Uwe Kleine-König (1):
      extcon: fsa9480: Drop no-op remove function

 drivers/extcon/extcon-fsa9480.c |  6 ------
 drivers/extcon/extcon-palmas.c  |  2 +-
 drivers/extcon/extcon-rt8973a.c |  1 -
 drivers/extcon/extcon-sm5502.c  |  2 --
 drivers/extcon/extcon.c         | 12 +++++++++++-
 include/linux/extcon.h          |  2 ++
 6 files changed, 14 insertions(+), 11 deletions(-)
