Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD08495C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiAUIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:35:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64199 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiAUIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642754082; x=1674290082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q8+w+zY/fos4SCamEOckILzxUl1jS3yfE7nrCAZdjSU=;
  b=GKNtQL0C/5wSmxt7I2i9EJZYX2IG5mz/JH/eQNXH2QYAoAF5pHbMpNTM
   BM4Qn7CSXvtzCoQqEC9rQ6j0r0VX+DySfpdtn1ooGWIJ1XTBUQ12oTQnX
   5xTb8vIlm8OLj0/Nsq6wtUXNdzdjqz3PzCRSIMGBoAJGVItZyGKJRNzfR
   pd8nAg3Bs+0NXMsi0VZbpLmbK4pKCeLjKDaAuK1Jm5BK7tqg/fOXFMtcx
   6kHXjEttarV0fWaalWF7NfVItpV7pYInXUp7x2uhsgLNO7guBoiHBfiOO
   /g3p9JyYzTw9acqgFhXeritbPGZ6jnI1M0GQKeA+iiF+Hi7NF+4+BbMKy
   A==;
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="192036796"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2022 16:34:41 +0800
IronPort-SDR: 10X62QFxuQRi2un8wOfLqJm2/tXe/csKP4P+gxoCzEyZAtoqGkhgojI7AWLgTRo8baNkEnuzG6
 VZQ/a33cpDHZWoXqdFiZbT+dDd0XYIGEv5V6C9vtO/DILaVEzpG068OprMM2osgc0TuyRF7QId
 ZLS3WkqO4Osq6FuwJFGECmnjDXelBcE6SaiJFRfc3qBatWz1MvyWjIE3Oyk7KyyZs7lienAlzO
 SzSwNJEHi02R0zJFX8tyHJffpkuONokVkim8szD4L2l88wztO/kvq7J0+cwOle5OIZ+tCchV80
 knxGXljT2deSDLKA038+73Rk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:06:52 -0800
IronPort-SDR: 4moM+oL/GN4+GzYbOAOSUsShVu+NgA/0RrWATnegCNd00z6C6qwjbut8FMDEQXQf/uVQev8Peo
 Rs9P6LbDZH+g0yOEQ+baagH8ZsYJ7OxelPbOHr/gYKopmkSJKIHEG0MhFDUMgcRz9olcA6LyVk
 xUtTWlRY63O7XT9EqY4Wdq1X2N/yhDzmtXkgTA+MsyQ7prgs0ft51bd+a8Fu17wT7WsY9Hr7Bu
 KX+bmIBnrQACZnZzkG58ota/TS6S+etR4ycmUzSzv7ONSYLT5pZEA982UlHS1POclsE0q59Aa1
 mCo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:34:41 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JgCNc3bwDz1SVp2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:34:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642754079; x=1645346080; bh=Q8+w+zY/fos4SCamEOckILzxUl1jS3yfE7n
        rCAZdjSU=; b=mBYTwNFWNI2gJI+EMJOK8vQ/zPGTFIxOb8hlRMRHucnDP+YTM7c
        cNhsPI1aSRlDbAhQcy18FB1qtTC4P9C4G6NmL9ktzVOywAqcmYxwZ1rRkVyAfrd5
        Q/GKJoIsFc5u8zVhoM0c2laOEJ5SBEnjZGgpZT9VFmpJCU71t0XdyCUhfA2sMxKW
        h51xd2nqdiKkrWyc1uYpBKyZNNTwakYJcW0SNyLrk+3exBpr+HS/iGC9VEK02NKG
        UNgzuVjUrp41rI4Fu+NwJovQHwpBb8wikIvWBxQTY9jogP3hAqnAaTdw4E06Fdpp
        vKZbjS7ovToZ6RIzMVfc0310N9+thni8guA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wMaN3o6Iuuxg for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jan 2022 00:34:39 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JgCNY3K7Vz1RvlN;
        Fri, 21 Jan 2022 00:34:37 -0800 (PST)
Message-ID: <6249735f-e6b7-1331-eb2b-361bb17d6115@opensource.wdc.com>
Date:   Fri, 21 Jan 2022 17:34:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [next] mips: cavium_octeon_defconfig: pata_octeon_cf.c:598:23:
 error: passing argument 1 of 'trace_ata_bmdma_stop' from incompatible pointer
 type
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
References: <CA+G9fYtq0wzSeG8YG-a+=KrbdWqHJMXk1hvq0FKeAvj9sZAK2g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYtq0wzSeG8YG-a+=KrbdWqHJMXk1hvq0FKeAvj9sZAK2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/22 17:02, Naresh Kamboju wrote:
> Linux next-20220106..next-20220121 mips build failing with gcc-10.
> 
> drivers/ata/pata_octeon_cf.c: In function 'octeon_cf_dma_finished':
> drivers/ata/pata_octeon_cf.c:598:23: error: passing argument 1 of
> 'trace_ata_bmdma_stop' from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   598 |  trace_ata_bmdma_stop(qc, &qc->tf, qc->tag);
>       |                       ^~
>       |                       |
>       |                       struct ata_queued_cmd *
> In file included from include/trace/events/libata.h:10,
>                  from drivers/ata/pata_octeon_cf.c:22:
> include/trace/events/libata.h:414:33: note: expected 'struct ata_port
> *' but argument is of type 'struct ata_queued_cmd *'
>   414 |       TP_PROTO(struct ata_port *ap, const struct ata_taskfile
> *tf, unsigned int tag),
>       |                ~~~~~~~~~~~~~~~~~^~
> include/linux/tracepoint.h:342:34: note: in definition of macro
> '__DECLARE_TRACE'
>   342 |  static inline void trace_##name(proto)    \
>       |                                  ^~~~~
> include/linux/tracepoint.h:419:24: note: in expansion of macro 'PARAMS'
>   419 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
>       |                        ^~~~~~
> include/linux/tracepoint.h:542:2: note: in expansion of macro 'DECLARE_TRACE'
>   542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>       |  ^~~~~~~~~~~~~
> include/linux/tracepoint.h:542:22: note: in expansion of macro 'PARAMS'
>   542 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>       |                      ^~~~~~
> include/trace/events/libata.h:413:1: note: in expansion of macro 'DEFINE_EVENT'
>   413 | DEFINE_EVENT(ata_exec_command_template, ata_bmdma_stop,
>       | ^~~~~~~~~~~~
> include/trace/events/libata.h:414:7: note: in expansion of macro 'TP_PROTO'
>   414 |       TP_PROTO(struct ata_port *ap, const struct ata_taskfile
> *tf, unsigned int tag),
>       |       ^~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:289: drivers/ata/pata_octeon_cf.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [scripts/Makefile.build:572: drivers/ata] Error 2
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I just posted a fix. As I do not have the environment to compile test
mips, could someone test please ? I will send the fix to Linus asap
after confirmation that it is OK.

Thanks.


> 
> metadata:
>   git branch: master
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git describe: next-20220121
>   kernel-config: https://builds.tuxbuild.com/23zIBGjQZgIYW8OnGcYjwWlj40X/config
>   build: https://builds.tuxbuild.com/23zIBGjQZgIYW8OnGcYjwWlj40X/
> 
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
> # See https://docs.tuxmake.org/ for complete documentation.
> # Original tuxmake command with fragments listed below.
> 
> tuxmake --runtime podman --target-arch mips --toolchain gcc-10
> --kconfig cavium_octeon_defconfig
> 
> --
> Linaro LKFT
> https://lkft.linaro.org


-- 
Damien Le Moal
Western Digital Research
