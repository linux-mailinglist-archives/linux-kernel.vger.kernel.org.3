Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DD58A853
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiHEIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHEItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:49:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79863205FC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:49:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s11so2469466edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=JhMedswNM5S1RMCLhtJ8ku8g6f4jDZpaY1Q94guL4aM=;
        b=R6jdXF84reG9YAMCyDfidhShh2+sRqlaiYW9esreVw6YbR7+kyez+14YhWX8Uwndho
         esu7HMy86y4yLHP8PHsA8U+czo9u2YnB223FQ/ysoLltdWMJvV+L4Vj1eJNy09B5N1j4
         CB//YmlzqR7fUSbS/tjIlf3hlZ+OB6YNuhYTLuikodMvnHHjte3+vLkIzVfDuAMekArV
         j7D0QYuWEAm9XwpDGJ2HPOUvzpRJIAfaGewWK3mmHxRL6DWOCs7BbWvshcP/TBgeRegf
         mfEQrdnD10YxeItQL8737MPgQW/Xo5q2PKW7DPunoNs1VZps+KSbE4HF5pnwjmwaj9rr
         UgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=JhMedswNM5S1RMCLhtJ8ku8g6f4jDZpaY1Q94guL4aM=;
        b=EaiYoHYpeiW2r10vneyEtuulj1ErGaf0mR3UpvYo5+ztx2gJABJBhzLicylljPv4dA
         EB8e9kn9P6hBVoZOGtsAYPCPyITyjSH544ddO1jPwsWuDnOtL0BMbIvK8DwAcwBZz+BY
         7MzCNRp3pAGW/G4GGdlcSrnglowaPEO6wMVuJoxH+sVnf4Ur+Aj2llX3zJGRt5oQKR3k
         pzEXefXDiGpGBP9olzQMs54EBrxmkhq7Mrg0t9SVsuLXBX5o32csqm+f/A3u7DvH7wV/
         4a9k1lgXxR5Lq8hul4uPfxE98n0GZp/BxqrYSH0AirrZKOQog1hCDt3ybBB7Xx1ZmAUH
         YwNQ==
X-Gm-Message-State: ACgBeo09htVngvG//xG1wri51zrR9uu7yyFmrrqs+b3Fm6LDNJJlZhoU
        gjKcFM7srKFYhqlTxRiyUNz/dGRxlaNaGQ==
X-Google-Smtp-Source: AA6agR5NdJyA1l94KXI83Ggp2/cfwLZrdzRSUIEA/Aq5qz/HZ4w/KsTv5y7moB+eZDhGV6m9eH7cSA==
X-Received: by 2002:a05:6402:5518:b0:43a:9e32:b6fc with SMTP id fi24-20020a056402551800b0043a9e32b6fcmr5962825edb.252.1659689361963;
        Fri, 05 Aug 2022 01:49:21 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id 12-20020a508e4c000000b0043cbdb16fbbsm1750822edx.24.2022.08.05.01.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:49:21 -0700 (PDT)
Message-ID: <56ae15f0-4172-a1bf-661f-1e4310ba60a1@monstr.eu>
Date:   Fri, 5 Aug 2022 10:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.20-rc1/6.0-rc1
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

please pull these two simple patches to your tree.

Thanks,
Michal

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.20

for you to fetch changes up to 5b7d1d575e3f1917cd493761781314be7bc73ef4:

   microblaze: Fix some typos in comment (2022-07-29 12:37:27 +0200)

----------------------------------------------------------------
Microblaze patches for 5.20-rc1

- Trivial comment fix
- Remove HANDLE_DOMAIN_IRQ selection

----------------------------------------------------------------
Slark Xiao (1):
       microblaze: Fix some typos in comment

Ying Sun (1):
       arch: microblaze: Remove unused "select HANDLE_DOMAIN_IRQ"

  arch/microblaze/Kconfig        | 1 -
  arch/microblaze/kernel/entry.S | 2 +-
  2 files changed, 1 insertion(+), 2 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

