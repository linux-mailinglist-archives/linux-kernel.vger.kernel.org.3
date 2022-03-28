Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E04E9645
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiC1MMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiC1MMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:12:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4546177
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:11:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so28206886ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=p3WqA2Vt0jZAym/U0O7alTlMruI2NoihwdZhe+rrgS0=;
        b=msd/+Z5YWFSkIu6vkX9X5+ytPoI0xYxu3owYdNOW9AuQkV/h9++HMP6B/PvHZqQE7q
         Eob8Qux+E+Tz8/UD4JHl+dYYo4hAh0W0wkaWIYV9rS6GVdELmFq9Aw9/QzooP2c96MnD
         7fFwtVSBCXmLEwwUFgaSW92EuvFOBwM7a4weZ32jRx7imQwyg+AUjZf2pf7aCwGPEQ8v
         zXwzsz1i0i/EMnHT4wKi0zdy4l4uWpzUcr8R/K0BxBg98S7Yt4McMQcy9FfP3lP4L6cE
         EHu9oX+67lP4if+Wqx7ZZUM4/Prvy0sp9eVkvRf4QVo0cWGAnBoMA+AxYJNVPDTcZlFJ
         pkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=p3WqA2Vt0jZAym/U0O7alTlMruI2NoihwdZhe+rrgS0=;
        b=TLC0+UGE4ffklUYptiR1OyTa3n0YeGDnmx3Ls6urHCRyhoHnSR6CJv8LmK1gK+oaDu
         atE1SZR4izeGFXH8fh6gUnxPtZduwJNTuvACv4deREfVVe5p2Wlx1IAMKH8axFbTIDI/
         xoyXeER5L6Qp+aLF+bw6uPW27TiCa3hs0GXXJZuyjP0bhvl2K3pkQjYzaLg0hFj41AB3
         gHAuGX5+rm4sec5r5s4JrFzNXbgp+OWcdFX0qS5KBIAHngh8Udt/bHrxTYJ8SjLdbPLW
         8IBxlEynI9ILF+wlDrV4UpOwh3hWVWIRGGvl70q2VZJUrBiB91AyR3Y/ScTk/ZllaxOi
         oVQQ==
X-Gm-Message-State: AOAM531iuq0i5uHmzeMoYkkBLnbEEUtN2JUcSmvHnxjc0ybRmZId7om4
        f8HchrbFnUlTHz7Jp01911oygvjlESlxYg==
X-Google-Smtp-Source: ABdhPJxQTT74nxo/XuX3ODFEeZZaPChrRpC2Fk0tpinf84QOpQ8l53e2TsM8a6xClZuyt8xZ9sO6Zw==
X-Received: by 2002:a17:907:e87:b0:6df:6a26:e17c with SMTP id ho7-20020a1709070e8700b006df6a26e17cmr27333589ejc.666.1648469459758;
        Mon, 28 Mar 2022 05:10:59 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm5852684ejo.190.2022.03.28.05.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:10:58 -0700 (PDT)
Message-ID: <04dd8f40-84eb-2c31-5b16-33ac60024b7f@monstr.eu>
Date:   Mon, 28 Mar 2022 14:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.18-rc1
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

please pull these 3 simple patches.

Thanks,
Michal

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

   git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.18

for you to fetch changes up to fcc619621df50f63b641b18536f908b05d6782a4:

   microblaze/PCI: Remove pci_phys_mem_access_prot() dead code (2022-01-24 
13:11:34 +0100)

----------------------------------------------------------------
Microblaze patches for 5.18-rc1

- Small fixups
- Remove unused pci_phys_mem_access_prot()

----------------------------------------------------------------
Bjorn Helgaas (1):
       microblaze/PCI: Remove pci_phys_mem_access_prot() dead code

Jason Wang (1):
       microblaze: fix typo in a comment

Xiang wangx (1):
       microblaze: add const to of_device_id

  arch/microblaze/include/asm/pci.h |  4 --
  arch/microblaze/kernel/signal.c   |  2 +-
  arch/microblaze/pci/pci-common.c  | 49 --------------------
  arch/microblaze/pci/xilinx_pci.c  |  2 +-
  4 files changed, 2 insertions(+), 55 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

