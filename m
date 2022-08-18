Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3C8598EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbiHRVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346451AbiHRVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:07:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D505A6D560
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:03:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so2497530plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=ELcoH5gVXXKNS9r6sQsd+O52/5TSkTBmTFm8K7ORsqw=;
        b=WQMubBKNaph5pwkxw2tnVEU0ZXHH7pZR6cqKz2+4Y3c+DRJMOIgdDbs/2ixVID2UDH
         L252bhKG5xAJo4hv5C6IBtfHRds9CMD8/2+vXivSdO3nGtQBlwD0QpJSPL2F0q7jDC2i
         rSZj8Nce0eQstqKUlGuh50H7apLZ9mCKA8o5C8S/oZooXR0XcOc86Jg5x3yGTlyN4sYk
         wSCQOcGBlIQZKHy56IPcxXtlS2ic1hlsZ1RJTn2rNtP30mQvs67WG1XR4YP0H8TtIFhh
         cPoWKCVxqtC9WDJU0MZxBCSgc8NnQUJj+x0VNHc+WQ5d2d4nWwwcMAWE2h09J93p8hkX
         Zsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=ELcoH5gVXXKNS9r6sQsd+O52/5TSkTBmTFm8K7ORsqw=;
        b=PzK+9BA0fVSqGtFXoNbivWAhJkk1Zv0x0spIAhK/3ClLH4zC8F3iz0Pbg8jC34VAFh
         KkunGo2nXUupirgGgn2Vvzd5QSjZx6sSTOxvQqJUYldyPz5VRxFokMnuUAgHlWhIYRkh
         HQ6Jbwa52tkkyFmeyiBAGij//As9O0FcpS5QAwYgSdIPnu0uxF5Bxk1YD4bXHEot8uA7
         OrgM8wC9T+45EkYHgW/uV8wkSAuxoxxGN2ZAxLVGgUW7WRpih6c/TwOy6WzGiCd6nCgk
         QuWepE2Q9c0rkYFypv9+ZK0Kn1YFbFQG0zZUUkyvZW3UTvKNHEqeOGt67OQUPv6FJnX9
         XKPw==
X-Gm-Message-State: ACgBeo2axXHat6y1zY4kuE/vsJcjM8WslBWMS7nqW6M10LBVYK15XJ4h
        lpKL/mt81RkvjLSHHtZE3AvCfw==
X-Google-Smtp-Source: AA6agR77U4vTHE89v0SovmRRB/C5pTdUWWokk9RXeAPG/OObpqvPuOsLYN1eeILaWp+6/QyC455uOA==
X-Received: by 2002:a17:902:c602:b0:170:bf85:8ccb with SMTP id r2-20020a170902c60200b00170bf858ccbmr4024845plr.38.1660856606246;
        Thu, 18 Aug 2022 14:03:26 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b00172aa97b628sm1801658ple.186.2022.08.18.14.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:03:25 -0700 (PDT)
Date:   Thu, 18 Aug 2022 14:03:25 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Aug 2022 14:03:22 PDT (-0700)
Subject:     Re: [GIT PULL] Fix RISC-V's arch-topology reporting
In-Reply-To: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
CC:     sudeep.holla@arm.com, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        atishp@atishpatra.org, Brice.Goglin@inria.fr,
        Greg KH <gregkh@linuxfoundation.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-fc4d9b57-2284-40dd-97f6-d32369b41cde@palmer-ri-x1c9>
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

On Mon, 15 Aug 2022 15:14:55 PDT (-0700), Conor.Dooley@microchip.com wrote:
> Hey Will/Palmer/Sudeep,
> 
> Catalin suggested [0] dropping the CC: stable for the arm64 patch and
> instead making it a specific prereq of the RISC-V patch & making a PR,
> so here we are.. I was still up when -rc1 came out so pushed it last
> night to get the test coverage, but LKP seems to not have reported a
> build success since early on the 13th so not holding my horses! I built
> it again for both ARMs and RISC-V myself.
> 
> I tagged it tonight, so it's on conor/linux.git as riscv-topo-on-6.0-rc1
> with the prereq specified.
> 
> Not sure if you want to merge this too Sudeep or if that's up to Greg?

It's a little bit vague what you're asking for here, so I'm just going 
to kind of guessing here but this on riscv/for-next.  I'm not sure if 
you were looking for me to just merge the arch/riscv bits or if this 
should be on fixes (just looking at the patch makes it look like it 
should be), but I don't want to send up some arm64 code to fixes without 
it being pretty explicit that I should do so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # arch/riscv bits, for 6.0-rc

in case someone else wants to send it up before I get back to this, I'm 
fine either way.

Thanks!

> 
> Thanks,
> Conor.
> 
> 0 - https://lore.kernel.org/linux-riscv/Ytac7G1zlq6WW4jt@arm.com/
> 
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ tags/riscv-topo-on-6.0-rc1
> 
> for you to fetch changes up to fbd92809997a391f28075f1c8b5ee314c225557c:
> 
>   riscv: topology: fix default topology reporting (2022-08-15 22:07:34 +0100)
> 
> ----------------------------------------------------------------
> Fix RISC-V's topology reporting
> 
> The goal here is the fix the incorrectly reported arch topology on
> RISC-V which seems to have been broken since it was added.
> cpu, package and thread IDs are all currently reported as -1, so tools
> like lstopo think systems have multiple threads on the same core when
> this is not true:
> https://github.com/open-mpi/hwloc/issues/536
> 
> arm64's topology code basically applies to RISC-V too, so it has been
> made generic along with the removal of MPIDR related code, which
> appears to be redudant code since '3102bc0e6ac7 ("arm64: topology: Stop
> using MPIDR for topology information")' replaced the code that actually
> interacted with MPIDR with default values.
> 
> ----------------------------------------------------------------
> Conor Dooley (2):
>       arm64: topology: move store_cpu_topology() to shared code
>       riscv: topology: fix default topology reporting
> 
>  arch/arm64/kernel/topology.c | 40 ----------------------------------------
>  arch/riscv/Kconfig           |  2 +-
>  arch/riscv/kernel/smpboot.c  |  3 ++-
>  drivers/base/arch_topology.c | 19 +++++++++++++++++++
>  4 files changed, 22 insertions(+), 42 deletions(-)
