Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB657DBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiGVID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:03:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B789B55A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:03:52 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3B21E3F12A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658477030;
        bh=Djzg8Rc7fhB8CahLsgla9ESBnmAj4BWal3tnU/pT7yo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YmB/sCemLx/uhUq37DbKjFYGIC9UkhPLqpxP9tKN5pnFxfzVTHOj2GY13eCj7jIhf
         Ktofc7Rf7NbNG8ikhXJooc5zprpcYytdDIA/p9c7M8K4QqLKCvuOv+jE2ewhHw/zbe
         Z2f+nqJc5LgfFpV/f6xkUNV+Y79VP61sGS455MuMelXm93lM/8nHiX4Ef26SIPHUY6
         9ylXyoVQjdixCYQq1NFUErbV4dX7DFK0Qc4MfV0+D7jmuX0RnijJcOfBqgGFYBxyb+
         KA2STIBxsscQri+e/7WUCp54OACvGjtMZlDZyiFrkYIrxqLvNa2K268M3752r+5GFv
         6mFAKg//391LQ==
Received: by mail-wm1-f69.google.com with SMTP id v132-20020a1cac8a000000b003a34081050bso584889wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Djzg8Rc7fhB8CahLsgla9ESBnmAj4BWal3tnU/pT7yo=;
        b=kDcDX5sc2RpBw+cxyT3iV42m7tTBKHd9t9V2m6Q14oZbdqQJVY0Tt6TtWD+wp9k1YP
         Ms9DF2+kX8N2yTsmUytCNAwfD4ty8p7lfrQpa3UHLxjH36wUrB9+k9VxixvIu6xfn8ld
         HX26rlGLohazE/pV/r5QlJOIRCm1nmpRSwpKZrPcl4iSdKS+r2dJ/p7Ir0FYia7Pwscy
         r8P29tfH4N7nZLD+ffbdvCYvo6tMEiABfM4CinqlOYhNr9iMgrmSWfEt/XOD2Ro/AAAG
         /zqq4dt0JoLhHKOfdkNRCSolrUZy04NtLnse2PCeoTGc9y4bfp4KKZ4U9JSdVrx8TKg+
         xA/g==
X-Gm-Message-State: AJIora9MYCvnybKqLhnPjPp9cMxZ3RSqaaV9ouDfKLowZjnxgIA3rigM
        r3+3Vh9yIqYoHg4h8C14Gec+XeaPgkeYkALkn3muaXxAnPpKXDCzM1epRgXGm7HXK6hK1hLA5qY
        DAPgCsKp624EldNEA4b1PPNTd15cRFV6LPgkgXl4V6g==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr1546705wrd.552.1658477028872;
        Fri, 22 Jul 2022 01:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tA1jTiBrAxpC6qHHHD0NVIYpjlM4n6oaJb5EQyYxOibHW6WDgLQ9M4YVcHjnzYvweMnZI90w==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr1546686wrd.552.1658477028567;
        Fri, 22 Jul 2022 01:03:48 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d448d000000b002167efdd549sm3836255wrq.38.2022.07.22.01.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:03:48 -0700 (PDT)
Message-ID: <e485aa49-57e3-25d7-6ac8-0eed50e0d48d@canonical.com>
Date:   Fri, 22 Jul 2022 10:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        guoren@kernel.org, mchitale@ventanamicro.com,
        arnaud.pouliquen@foss.st.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-679f197d-77a0-4dc5-9523-f7b88a22b30b@palmer-mbp2014>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <mhng-679f197d-77a0-4dc5-9523-f7b88a22b30b@palmer-mbp2014>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 07:06, Palmer Dabbelt wrote:
> On Tue, 07 Jun 2022 17:02:51 PDT (-0700), 
> heinrich.schuchardt@canonical.com wrote:
>> The defconfig kernel should be able to run Docker.
>>
>> Enable the missing settings according to [1].
>> make savedefconfig eliminates CONFIG_STACKTRACE
>> which is enabled by default.
>>
>> Many of the settings are also needed to run a defconfig kernel
>> on default distro installations or to run snaps.
>>
>> [1] https://github.com/moby/moby/blob/master/contrib/check-config.sh
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> Cf. [PATCH] arm64: Enable docker support in defconfig
>> https://lore.kernel.org/lkml/20220606140103.32779-1-vincenzo.frascino@arm.com/
>> ---
>>  arch/riscv/configs/defconfig | 65 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index 0cc17db8aaba..d4fffcd3cc05 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -6,8 +6,18 @@ CONFIG_BPF_SYSCALL=y
>>  CONFIG_IKCONFIG=y
>>  CONFIG_IKCONFIG_PROC=y
>>  CONFIG_CGROUPS=y
>> +CONFIG_MEMCG=y
>> +CONFIG_BLK_CGROUP=y
>>  CONFIG_CGROUP_SCHED=y
>>  CONFIG_CFS_BANDWIDTH=y
>> +CONFIG_RT_GROUP_SCHED=y
>> +CONFIG_CGROUP_PIDS=y
>> +CONFIG_CGROUP_FREEZER=y
>> +CONFIG_CGROUP_HUGETLB=y
>> +CONFIG_CPUSETS=y
>> +CONFIG_CGROUP_DEVICE=y
>> +CONFIG_CGROUP_CPUACCT=y
>> +CONFIG_CGROUP_PERF=y
>>  CONFIG_CGROUP_BPF=y
>>  CONFIG_NAMESPACES=y
>>  CONFIG_USER_NS=y
>> @@ -28,9 +38,11 @@ CONFIG_KVM=m
>>  CONFIG_JUMP_LABEL=y
>>  CONFIG_MODULES=y
>>  CONFIG_MODULE_UNLOAD=y
>> +CONFIG_BLK_DEV_THROTTLING=y
>>  CONFIG_NET=y
>>  CONFIG_PACKET=y
>>  CONFIG_UNIX=y
>> +CONFIG_XFRM_USER=m
>>  CONFIG_INET=y
>>  CONFIG_IP_MULTICAST=y
>>  CONFIG_IP_ADVANCED_ROUTER=y
>> @@ -38,7 +50,43 @@ CONFIG_IP_PNP=y
>>  CONFIG_IP_PNP_DHCP=y
>>  CONFIG_IP_PNP_BOOTP=y
>>  CONFIG_IP_PNP_RARP=y
>> +CONFIG_INET_ESP=m
>> +CONFIG_NETFILTER=y
>> +CONFIG_BRIDGE_NETFILTER=m
>> +CONFIG_NF_CONNTRACK=m
>> +CONFIG_NF_CONNTRACK_FTP=m
>> +CONFIG_NF_CONNTRACK_TFTP=m
>> +CONFIG_NETFILTER_XT_MARK=m
>> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>> +CONFIG_NETFILTER_XT_MATCH_IPVS=m
>> +CONFIG_IP_VS=m
>> +CONFIG_IP_VS_PROTO_TCP=y
>> +CONFIG_IP_VS_PROTO_UDP=y
>> +CONFIG_IP_VS_RR=m
>> +CONFIG_IP_VS_NFCT=y
>> +CONFIG_NF_LOG_ARP=m
>> +CONFIG_NF_LOG_IPV4=m
>> +CONFIG_IP_NF_IPTABLES=m
>> +CONFIG_IP_NF_FILTER=m
>> +CONFIG_IP_NF_TARGET_REJECT=m
>> +CONFIG_IP_NF_NAT=m
>> +CONFIG_IP_NF_TARGET_MASQUERADE=m
>> +CONFIG_IP_NF_TARGET_REDIRECT=m
>> +CONFIG_IP_NF_MANGLE=m
>> +CONFIG_NF_LOG_IPV6=m
>> +CONFIG_IP6_NF_IPTABLES=m
>> +CONFIG_IP6_NF_MATCH_IPV6HEADER=m
>> +CONFIG_IP6_NF_FILTER=m
>> +CONFIG_IP6_NF_TARGET_REJECT=m
>> +CONFIG_IP6_NF_MANGLE=m
>> +CONFIG_BRIDGE=m
>> +CONFIG_BRIDGE_VLAN_FILTERING=y
>> +CONFIG_VLAN_8021Q=m
>> +CONFIG_NET_SCHED=y
>> +CONFIG_NET_CLS_CGROUP=m
>>  CONFIG_NETLINK_DIAG=y
>> +CONFIG_CGROUP_NET_PRIO=y
>>  CONFIG_NET_9P=y
>>  CONFIG_NET_9P_VIRTIO=y
>>  CONFIG_PCI=y
>> @@ -57,7 +105,15 @@ CONFIG_SCSI_VIRTIO=y
>>  CONFIG_ATA=y
>>  CONFIG_SATA_AHCI=y
>>  CONFIG_SATA_AHCI_PLATFORM=y
>> +CONFIG_MD=y
>> +CONFIG_BLK_DEV_DM=m
>> +CONFIG_DM_THIN_PROVISIONING=m
>>  CONFIG_NETDEVICES=y
>> +CONFIG_DUMMY=m
>> +CONFIG_MACVLAN=m
>> +CONFIG_IPVLAN=m
>> +CONFIG_VXLAN=m
>> +CONFIG_VETH=m
>>  CONFIG_VIRTIO_NET=y
>>  CONFIG_MACB=y
>>  CONFIG_E1000E=y
>> @@ -105,7 +161,11 @@ CONFIG_RPMSG_CTRL=y
>>  CONFIG_RPMSG_VIRTIO=y
>>  CONFIG_EXT4_FS=y
>>  CONFIG_EXT4_FS_POSIX_ACL=y
>> +CONFIG_EXT4_FS_SECURITY=y
>> +CONFIG_BTRFS_FS=m
>> +CONFIG_BTRFS_FS_POSIX_ACL=y
>>  CONFIG_AUTOFS4_FS=y
>> +CONFIG_OVERLAY_FS=m
>>  CONFIG_MSDOS_FS=y
>>  CONFIG_VFAT_FS=y
>>  CONFIG_TMPFS=y
>> @@ -119,6 +179,10 @@ CONFIG_ROOT_NFS=y
>>  CONFIG_9P_FS=y
>>  CONFIG_NLS_CODEPAGE_437=y
>>  CONFIG_NLS_ISO8859_1=m
>> +CONFIG_SECURITY=y
>> +CONFIG_SECURITY_SELINUX=y
>> +CONFIG_SECURITY_APPARMOR=y
>> +CONFIG_DEFAULT_SECURITY_DAC=y
>>  CONFIG_CRYPTO_USER_API_HASH=y
>>  CONFIG_CRYPTO_DEV_VIRTIO=y
>>  CONFIG_PRINTK_TIME=y
>> @@ -137,7 +201,6 @@ CONFIG_DEBUG_SPINLOCK=y
>>  CONFIG_DEBUG_MUTEXES=y
>>  CONFIG_DEBUG_RWSEMS=y
>>  CONFIG_DEBUG_ATOMIC_SLEEP=y
>> -CONFIG_STACKTRACE=y
>>  CONFIG_DEBUG_LIST=y
>>  CONFIG_DEBUG_PLIST=y
>>  CONFIG_DEBUG_SG=y
> 
> Sorry for being so slow here.  I don't have any issues with this as a 
> concept, but it makes a handful of my test configs panic on boot.  Seems 
> like something is tripping up a kasan failure.  I guess it's kind of 

Hello Palmer,

thanks for sharing your test experience. Could you, please, provide the 
config file and the test configuration that leads the regression.

> arbitrary to call that a regression, as I'm sure it's just uncovering 
> some issue that already exists, but turning something on in defconfig 
> that panics with kasan is going to have a bunch of fallout.
> 
> It looks like BLK_CGROUP is the problem here, so if you're OK with it 
> then I'm happy to take the rest of these.  I put that over at 
> kernel.org/palmer/linux/riscv-docker_no_blk_cgroup, if that's OK I'll 
> cherry-pick it onto for-next.

I am fine with cherry picking.

Best regards

Heinrich

> 
> There's almost certainly a bug here that warrants fixing.

