Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA884AF393
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiBIODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiBIODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:03:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF3C05CB8F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:03:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a8so7599132ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BowBxy6mujSqc6uDobbJd7gE25OPxJU1WR17zdO/EU8=;
        b=BXnsEfJhH0VLxc5l2+6yzTne2H+dAodEaOC7t90ck3dpcoApPfZeQw7ERDf+TMvabO
         AUyVjsh3w42IINu4lpfyKxBDJj3jGQvXewZmm44/nrdDsSeTfbPuHkyjuA8aQeIXRWbk
         YK+eKcMdcjqMdMa6tkUG1S8Qc5dyd/HPpdN9FCiXCyW57o+tCruGQP9LRNbyPgifd7xn
         Ovggwhv3jOMErW0rCok/7mdoeeLcz6Al/7fi2fKl5pBbuXO9VJU1qTvelWvzrjNQ9ZWx
         8dD9LOJXOmqYJjPbjK/VtTNpdPiq/ITP6K5IY2YaSXSiZOU2ZmlvYyr2WgV5Bt60uxvI
         vyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BowBxy6mujSqc6uDobbJd7gE25OPxJU1WR17zdO/EU8=;
        b=t1GrLDQhY/AMHBPBQ1QLteUqPlgH+k/yfSeyjRFxjXBT14bXNYxOPp1DTAwdb6EPFW
         wR11qod1yS34M6XXdhTbbdNq5/7pAFiLyPetG5aWOr8JAqJ74iWBDmS0YNim1cnRiKYs
         UY6vhcYXAhHCW3ZUuT7zRGpLrrMu/1kwNEGmLHW/4AaNbrPSEji7AIaI8WakMzxvYX6N
         C98Q01fnxNZdQwpyQ12Gb8cjrjhz2/KqAdmpZJxoMHjappuyPV6c79J7R+ZVTTto6tOm
         8yg3CziW+wxv9ZXuBulf5ANgHGiCkMpielhgwnnImZ4WDYwfKUTCeXc7VbtQUpHr8yKF
         HjUw==
X-Gm-Message-State: AOAM530M9ZX4mjEUox5LXL2gyaA/kBA2oPQpeRDy9f2dMuUqFKdoh92a
        I0plTaA5wwrBTSx2v7z+QWdfmg==
X-Google-Smtp-Source: ABdhPJx8GIenK2WVSAEcQAHLIXwXIN1cxrvW0M5u13kIK1XJWen2Q0kfxVwPnlgU4k0e5go3yIU2CA==
X-Received: by 2002:a17:907:c0d:: with SMTP id ga13mr2122813ejc.576.1644415398689;
        Wed, 09 Feb 2022 06:03:18 -0800 (PST)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id d10sm3488487ejb.22.2022.02.09.06.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 06:03:18 -0800 (PST)
Message-ID: <97825798-4071-6fef-ae87-e448e823d737@monstr.eu>
Date:   Wed, 9 Feb 2022 15:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org>
 <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <YgPHJy9NDVFr5s6w@infradead.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <YgPHJy9NDVFr5s6w@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/22 14:52, Christoph Hellwig wrote:
> On Wed, Feb 09, 2022 at 02:50:32PM +0100, Michal Simek wrote:
>> I can't see any issue with the patch when I run it on real HW.
>> Tested-by: Michal Simek <michal.simek@xilinx.com>
>>
>> Christoph: Is there any recommended test suite which I should run?
> 
> No.  For architectures that already didn't use set_fs internally
> there is nothing specific to test.  Running some perf or backtrace
> tests might be useful to check if the non-faulting kernel helpers
> work properly.

Thanks for confirmation. Once Arnd sent v2 with updated commit message I will 
queue it to next release.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

