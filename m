Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80417538BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiEaHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiEaHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:10:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E468990
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:10:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id wh22so24790992ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=BRbXu6m33l9xOYN6oZLICV8uXrRApTlLMoTq61AAB5o=;
        b=LHjgkW/k+1B3d7ZP04bLh02sSFYSJgEJiTVvm2cecNZ/kLERWWcFOzZkrXlQRCDaZN
         r3alxmuzish3yaur6QWFfj6s9wbpHKmd9GP+TUYoctHuVV5np5yixqaPqx37PoWRBakt
         MT0LtMRD+4hfAbozveOf74DzVfVtdf/tEw+itU4Bzf+j6+BiiAmwTZV40a9SNgYwEzNx
         cySwj+5s5bUROYiU8FPo7DK5DTPO2g1rAJd3Gy4G3TmFLHq/lS7I5w+8KP15L8lQZTIx
         yuBnB+ngn0NySOrqWd2Gf8SRFUpEppDSRpDTkQnHx/flwCl7wTIT+TzYBfrqGZ5bOdur
         vwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=BRbXu6m33l9xOYN6oZLICV8uXrRApTlLMoTq61AAB5o=;
        b=rru4vdzaEwmF+Pyqv5Gh7UoB6sSTp/SpYgR3taNYLdfklDnFWrgYpJuKzGq7uXimZm
         y3wCpKZW5Bu2CLQ7sTUZvBbZfisopMCoO5TspqQoCqqN9jP3veC8Zo+wrdh+hzF1wKCA
         1O9v/T9hx95NFvqcN1TZqVBN/4zet6ZRS1n9AFeTQEq3S8svo9+zA6bgjSrvNu2JaZ2R
         7XL6bt5KgI9crIGHbX+SoYqClBODtWU3s2PMuN2pdKcdF3/WpeOXBuAIlpjENlLkpFVu
         i9L4AAXJF6BNyNr9KOL27qKoQ2Ac9OStP6R5YQMU2krNR7NLMaVEKEm/ggli56EFD7Wf
         Ssvw==
X-Gm-Message-State: AOAM5333SV7pNkC+lEgWgFb0JT8K6x+8CFgNZMV9KoVHCHVnXhCsL7M3
        bdmZjT0TDAuFIXN022l734dBnhkccDe8iA==
X-Google-Smtp-Source: ABdhPJxgIJGOy9JplmXmTBkg4kpqC8A2SXGQH8VDggXmRDsNDY5aTCdEPixVtnkTFIo82goS2wKHvQ==
X-Received: by 2002:a17:907:94c3:b0:6ff:8cd6:93d6 with SMTP id dn3-20020a17090794c300b006ff8cd693d6mr5673812ejc.118.1653981020957;
        Tue, 31 May 2022 00:10:20 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906371600b006f3ef214e14sm4616762ejc.122.2022.05.31.00.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 00:10:20 -0700 (PDT)
Message-ID: <9bfbc0fb-ddd2-d65c-f9ac-2a2696581c71@monstr.eu>
Date:   Tue, 31 May 2022 09:10:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.19-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these patches to your tree.

Thanks,
Michal

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.19

for you to fetch changes up to 78b5f52ab6f6074a6fe2f27122e2165f32d6a143:

   microblaze: fix typos in comments (2022-05-02 08:36:10 +0200)

----------------------------------------------------------------
Microblaze patches for 5.19-rc1

- Fix issues with freestanding
- Wire memblock_dump_all()
- Add support for memory reservation from DT

----------------------------------------------------------------
Julia Lawall (1):
       microblaze: fix typos in comments

Michal Simek (5):
       microblaze: Use simple memset implementation from lib/string.c
       microblaze: Do loop unrolling for optimized memset implementation
       microblaze: Use simple memmove/memcpy implementation from lib/string.c
       microblaze: Wire memblock_dump_all()
       microblaze: Add support for reserved memory defined by DT

  arch/microblaze/include/asm/string.h |  2 ++
  arch/microblaze/kernel/kgdb.c        |  2 +-
  arch/microblaze/lib/memcpy.c         | 18 ++---------
  arch/microblaze/lib/memmove.c        | 31 ++----------------
  arch/microblaze/lib/memset.c         | 33 +++++++++-----------
  arch/microblaze/mm/init.c            |  5 +++
  6 files changed, 27 insertions(+), 64 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

