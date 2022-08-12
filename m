Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2B591381
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiHLQGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiHLQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:05:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02492D1C7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:05:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f28so1330724pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=OL8SXdfa/gecLe6XgajC00LdJvk7CncrQMI/Yj1+rRQ=;
        b=OfxSRUDvj+90whqrcUf3Sw7ZWDUP9dPNKpgF05MwqwEG4M9EU1P6i5WAh0V/WVRvyX
         0xxD/FAAwnBE7J8ut7J0z1yXVpMUbyDclx6eMdosJUPtzVp3HrxPAOIkyYmejLVZcpCJ
         hWr+fxkh6YsQpNswUvB22GsJRcXRL8tW9gU7aMh71Y1QKHPAxZDA1eTQ4NUyOLsUM/o9
         8IoiBHKtN7MsjbnNT683pJrML397WDEjrIdxZ1M+hwNtkOaKuF4KjzK+u3ihRr7h7FVk
         apkgbaEKaGHABkn9cxxFLjGJt3cVQmCRJDYAsjw4UjDmF+jYoCX2GLzT3jluIsvF9V6S
         elrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=OL8SXdfa/gecLe6XgajC00LdJvk7CncrQMI/Yj1+rRQ=;
        b=UWGGTONDmOwBLEEkidcGZPkzDVi21U1R0VyvrOLbxBGryfryvvf4X8mHWy0v3B3k+d
         W0/iOByronXOuWlPKY99iWw8BLyVNt7MJ/7kPtr2LK9rAzu+CVjL0xMixJFAK5ywDsL+
         fgFeBVl+gN5ej3SR0eGiqH+Uj0ECxUMKyL/tahsWKWOk2HSQ8WlvNVQWnoKWhhq98Z0Q
         RoK4wIVjwW6f/k3HKxjyjnMqRt7/pL5oxd95Tbet4g/ytSeBcEROqO4AvnGDsCa+vmqH
         EWQDiJ/5TioUBtA58iE1nERkE/9Sa2LoZFnW7u5bmB/Vm58t4eOJ1ED94MDncSvX16a8
         QnBw==
X-Gm-Message-State: ACgBeo3j3o9GpOxsoOwfPut/sJwc894mK9OYXmLvomYFWskTNWDlK1ZL
        ejGAzH2Rqp/ii1HplkEAyBCnwTDYUj9rmA==
X-Google-Smtp-Source: AA6agR4J6AAfGP9PV3avfft0XvB5qeSkTVfYlxf30tkPFvV5Y76TZIldDkwuHe2hzeEVXh/qZj28JQ==
X-Received: by 2002:a05:6a00:88f:b0:52c:6962:274f with SMTP id q15-20020a056a00088f00b0052c6962274fmr4651021pfj.12.1660320356091;
        Fri, 12 Aug 2022 09:05:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001714fa07b74sm1979387plh.108.2022.08.12.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 09:05:55 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:05:55 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Aug 2022 09:05:29 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.20 Merge Window, Part 1
In-Reply-To: <76d4f1d3-e72e-ef2e-12d0-f241fe680717@codethink.co.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     ben.dooks@codethink.co.uk
Message-ID: <mhng-7e789be2-ce2f-41e0-935e-d966cb93ff4a@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2022 00:35:24 PDT (-0700), ben.dooks@codethink.co.uk wrote:
> On 06/08/2022 00:36, Palmer Dabbelt wrote:
>> The following changes since commit 924cbb8cbe3460ea192e6243017ceb0ceb255b1b:
>>
>>    riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol (2022-06-16 15:47:39 -0700)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.20-mw0
>>
>> for you to fetch changes up to ba6cfef057e1c594c456627aad81c2343fdb5d13:
>>
>>    riscv: enable Docker requirements in defconfig (2022-07-22 13:43:28 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 5.20 Merge Window, Part 1
>>
>> * Enabling the FPU is now a static_key.
>> * Improvements to the Svpbmt support.
>> * CPU topology bindings for a handful of systems.
>> * Support for systems with 64-bit hart IDs.
>> * Many settings have been enabled in the defconfig, including both
>>    support for the StarFive systems and many of the Docker requirements.
>>
>> There are also a handful of cleanups and improvements, like usual.
>>
>
> Hi, are some of mine and Connor's fixes planned for part2?

Yes, though maybe that's obvious given that a bunch of them are on 
for-next now...

I was hoping to send that this morning but I ran into a few snags.  If 
there's anything else missing just let me know, IRC is usually the best 
way to jump the queue for small stuff -- it kind of just gets buried 
otherwise.
