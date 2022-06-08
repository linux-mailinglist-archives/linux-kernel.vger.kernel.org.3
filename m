Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAB542B56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiFHJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiFHJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:15:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A411E44C4;
        Wed,  8 Jun 2022 01:39:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx11so17988377pjb.1;
        Wed, 08 Jun 2022 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JASAiT3vXh0ZJKWH+RJe3v1twmK34V/YWwlarnk5/x0=;
        b=mzh5bNGbHr3vGSP7PJBL66nAkjOZ/q2p2L8puGTWPsHBE8qiaedY6T1LYAjy/dViU2
         MIOWg+tV9Id8u1JadoTwdlMJTkOXPbATkDPz22j48vXFBm+UERMywzJuHCK+wvwxkrEo
         2lple/TzyYJ9gkFxugOXyrvoHHWnrzaY4PLDqr8YiH1qP5pq1LAo+nfdaLNgQxyEE5/U
         5M1a9q9Io3KBHQgg/e8YQk3u60XyR6LJGnxNTnU36cvpLQyS07qWRNhBW6bIFTMr6T1C
         XktI+luDD4TbwmretCKI+ZJESgm2qvlqjpu77Ore4mLokpYo3RBvjPVr/julwkwlBz/D
         rS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JASAiT3vXh0ZJKWH+RJe3v1twmK34V/YWwlarnk5/x0=;
        b=WXZznnKjnHdqn8aOMrPBuMwzv3wN01OriIMAV2kbyrGTDltIzp1EnofpXbboLKJcfq
         CZ9gC3rSdet9WGkncQE5jUlw5c1bEHzNYlaUaIlheOqSiOUKBvlgUHK/JtcinGKM1XLF
         ao0TsjgEyDgzrA6YW4tjee7A3W8U+GU6XrNUu237KT70tymnk0PWCYZyH04PHJQ2Bkyk
         Su/IUsYw1K21A843cPBcjvdcQauUdsmAnf6hAUuFE3TIxelwB4HHS3pe5HEGrWPL2F+g
         vSX12ERJl1JxZEso5GE1M2nLeMXzXzwZ50hVsn1kVoqC/PWW1boss2KNiKxu6o9mtEGI
         ipdg==
X-Gm-Message-State: AOAM531/sRgiXNJGRRrfLPRKu8Wvyn/o34lgWJobXRHimV7/MPaCLJ9s
        w2F+SacQ5xYd1ONVjI0ini8=
X-Google-Smtp-Source: ABdhPJz6h8AXUH2LJZjDhTb51xavtnq5fJGuXMz/UJjlqctNAsIAqj4tOG3352gD8ob9z1b304PQ+Q==
X-Received: by 2002:a17:90a:9741:b0:1e8:a001:5caa with SMTP id i1-20020a17090a974100b001e8a0015caamr8765872pjw.231.1654677597383;
        Wed, 08 Jun 2022 01:39:57 -0700 (PDT)
Received: from localhost (subs02-180-214-232-66.three.co.id. [180.214.232.66])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903108500b00161f9e72233sm13800249pld.261.2022.06.08.01.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:39:56 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:39:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: virt_to_phys outside array bounds warning (GCC 12.1.0)
Message-ID: <YqBgWoXQmzVczRDo@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

When cross-compiling arm 5.19-rc1 kernel using GCC 12.1.0 (armv7 with neon
fpu, multi_v7_defconfig), I got outside array bounds warning pointing to
virt_to_phys() macro:

  DTC     arch/arm/boot/dts/am335x-evm.dtb
In file included from ./arch/arm/include/asm/page.h:163,
                 from ./arch/arm/include/asm/thread_info.h:14,
                 from ./include/linux/thread_info.h:60,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/arm/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/linux/proc_fs.h:10,
                 from ./include/linux/efi.h:19,
                 from arch/arm/kernel/setup.c:7:
In function 'request_standard_resources',
    inlined from 'setup_arch' at arch/arm/kernel/setup.c:1158:2:
./arch/arm/include/asm/memory.h:311:22: warning: array subscript -1 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
  311 | #define virt_to_phys virt_to_phys
arch/arm/kernel/setup.c:855:31: note: in expansion of macro 'virt_to_phys'
  855 |         kernel_code.end     = virt_to_phys(__init_begin - 1);
      |                               ^~~~~~~~~~~~
In file included from ./include/linux/pid_namespace.h:7,
                 from ./include/linux/ptrace.h:10,
                 from ./include/linux/elfcore.h:11,
                 from ./include/linux/crash_core.h:6,
                 from ./include/linux/kexec.h:18,
                 from arch/arm/kernel/setup.c:20:
./include/linux/mm.h: In function 'setup_arch':
./include/linux/mm.h:2500:21: note: at offset -1 into object '__init_begin' of size [0, 2147483647]
 2500 |         extern char __init_begin[], __init_end[];
      |                     ^~~~~~~~~~~~
In function 'request_standard_resources',
    inlined from 'setup_arch' at arch/arm/kernel/setup.c:1158:2:
./arch/arm/include/asm/memory.h:311:22: warning: array subscript -1 is outside array bounds of 'char[2147483647]' [-Warray-bounds]
  311 | #define virt_to_phys virt_to_phys
arch/arm/kernel/setup.c:857:31: note: in expansion of macro 'virt_to_phys'
  857 |         kernel_data.end     = virt_to_phys(_end - 1);
      |                               ^~~~~~~~~~~~
In file included from ./arch/arm/include/asm/sections.h:5,
                 from ./include/linux/interrupt.h:21,
                 from ./include/linux/rtc.h:17,
                 from ./include/linux/efi.h:20:
./include/asm-generic/sections.h: In function 'setup_arch':
./include/asm-generic/sections.h:41:13: note: at offset -1 into object '_end' of size [0, 2147483647]
   41 | extern char _end[];
      |             ^~~~

Thanks.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
