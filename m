Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2904F57E9A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiGVW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiGVW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:29:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4599362E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:29:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f65so5457283pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qQS+0/2uDUBN7d/qFubcLzUiJk+1AB7JapMZbnsGnTo=;
        b=ymz9Z+KdvfBl03gc1Fa6u7Bw35/iAdwyGOk9NitejJywrvf333xwfmTq2KE1zXQ9rw
         uRV7leKjV6dMo8fW8KdkO54VJ4mb3GVoWHFobCbgMIuvwz/nZWBG3/reKjISu1G3A5q0
         s0a5v16JXEvGhFG05/pf7GHzBZ+jS4SharXqGTO2TJs20B77qyiMQP09Ek64vDlhtFxB
         JD952OJC6IdCuV/1BJHidKjifUvyU9ilLOI16JD/fh/epJYJIcH+AHxG9eFRyVDqA/xB
         8mYRPiKmszE5Qmr2D0FmQsdd07X1fUBzMDhpEvPd4Gx/0dE+IexuNHFomx7sxageNTT4
         LlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qQS+0/2uDUBN7d/qFubcLzUiJk+1AB7JapMZbnsGnTo=;
        b=tGzLhaUnu7cTypLT5gBC2afQHMvkdYcb9+PmyIENJy/mPJEAROvWHwnppovVO9veHv
         IGCE7yqFf+RJGXgxs+sGVxT0Kn87NcABtrZ3jSYZccmCpR/4GSP05Q2ko0B/A8XDdn5V
         Tf5b6J700sJ5A+oISCuPruDYzxLAN3AWk78Zvf/f/08PetYCnlKFucb0+u3DVcNd2T+N
         13iWKm8IEF9cR7SPw2kQBzEpkzn6kqlQIXhThZm9if5liGT+2rocSIRMxGuFYfb3T7Nj
         aIybJlqKso/IYTUakSBwdoUteMzEr5x98Fyp4RxtfubKxaIaVrDiRpcbtOq8LRyPHkbm
         EbPg==
X-Gm-Message-State: AJIora8ojT99cGesLmSpNQLGAyM8krQgn+MMQi8WbhZ50dojJV11ATQG
        RM2GgScX6GhAxAvvfApRhw4gbkKUUXG8zg==
X-Google-Smtp-Source: AGRyM1tzXehMOroTgcjID4NVrJjjRx438GFLKbPOhuDeMtWEycTuSPURSpIWqS04W7l5KGYA/7rvsg==
X-Received: by 2002:aa7:8c55:0:b0:52b:7233:f7b1 with SMTP id e21-20020aa78c55000000b0052b7233f7b1mr1911459pfd.33.1658528956229;
        Fri, 22 Jul 2022 15:29:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001640aad2f71sm4232383plk.180.2022.07.22.15.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:29:15 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:29:15 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Jul 2022 15:29:00 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
In-Reply-To: <e485aa49-57e3-25d7-6ac8-0eed50e0d48d@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        guoren@kernel.org, mchitale@ventanamicro.com,
        arnaud.pouliquen@foss.st.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-c9796927-03da-43b1-a92f-67e63071d7cc@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 01:03:47 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> On 7/22/22 07:06, Palmer Dabbelt wrote:
>> On Tue, 07 Jun 2022 17:02:51 PDT (-0700),
>> heinrich.schuchardt@canonical.com wrote:
>>> The defconfig kernel should be able to run Docker.
>>>
>>> Enable the missing settings according to [1].
>>> make savedefconfig eliminates CONFIG_STACKTRACE
>>> which is enabled by default.
>>>
>>> Many of the settings are also needed to run a defconfig kernel
>>> on default distro installations or to run snaps.
>>>
>>> [1] https://github.com/moby/moby/blob/master/contrib/check-config.sh
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>> Cf. [PATCH] arm64: Enable docker support in defconfig
>>> https://lore.kernel.org/lkml/20220606140103.32779-1-vincenzo.frascino@arm.com/
>>> ---
>>>  arch/riscv/configs/defconfig | 65 +++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>>> index 0cc17db8aaba..d4fffcd3cc05 100644
>>> --- a/arch/riscv/configs/defconfig
>>> +++ b/arch/riscv/configs/defconfig
>>> @@ -6,8 +6,18 @@ CONFIG_BPF_SYSCALL=y
>>>  CONFIG_IKCONFIG=y
>>>  CONFIG_IKCONFIG_PROC=y
>>>  CONFIG_CGROUPS=y
>>> +CONFIG_MEMCG=y
>>> +CONFIG_BLK_CGROUP=y
>>>  CONFIG_CGROUP_SCHED=y
>>>  CONFIG_CFS_BANDWIDTH=y
>>> +CONFIG_RT_GROUP_SCHED=y
>>> +CONFIG_CGROUP_PIDS=y
>>> +CONFIG_CGROUP_FREEZER=y
>>> +CONFIG_CGROUP_HUGETLB=y
>>> +CONFIG_CPUSETS=y
>>> +CONFIG_CGROUP_DEVICE=y
>>> +CONFIG_CGROUP_CPUACCT=y
>>> +CONFIG_CGROUP_PERF=y
>>>  CONFIG_CGROUP_BPF=y
>>>  CONFIG_NAMESPACES=y
>>>  CONFIG_USER_NS=y
>>> @@ -28,9 +38,11 @@ CONFIG_KVM=m
>>>  CONFIG_JUMP_LABEL=y
>>>  CONFIG_MODULES=y
>>>  CONFIG_MODULE_UNLOAD=y
>>> +CONFIG_BLK_DEV_THROTTLING=y
>>>  CONFIG_NET=y
>>>  CONFIG_PACKET=y
>>>  CONFIG_UNIX=y
>>> +CONFIG_XFRM_USER=m
>>>  CONFIG_INET=y
>>>  CONFIG_IP_MULTICAST=y
>>>  CONFIG_IP_ADVANCED_ROUTER=y
>>> @@ -38,7 +50,43 @@ CONFIG_IP_PNP=y
>>>  CONFIG_IP_PNP_DHCP=y
>>>  CONFIG_IP_PNP_BOOTP=y
>>>  CONFIG_IP_PNP_RARP=y
>>> +CONFIG_INET_ESP=m
>>> +CONFIG_NETFILTER=y
>>> +CONFIG_BRIDGE_NETFILTER=m
>>> +CONFIG_NF_CONNTRACK=m
>>> +CONFIG_NF_CONNTRACK_FTP=m
>>> +CONFIG_NF_CONNTRACK_TFTP=m
>>> +CONFIG_NETFILTER_XT_MARK=m
>>> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>>> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
>>> +CONFIG_NETFILTER_XT_MATCH_IPVS=m
>>> +CONFIG_IP_VS=m
>>> +CONFIG_IP_VS_PROTO_TCP=y
>>> +CONFIG_IP_VS_PROTO_UDP=y
>>> +CONFIG_IP_VS_RR=m
>>> +CONFIG_IP_VS_NFCT=y
>>> +CONFIG_NF_LOG_ARP=m
>>> +CONFIG_NF_LOG_IPV4=m
>>> +CONFIG_IP_NF_IPTABLES=m
>>> +CONFIG_IP_NF_FILTER=m
>>> +CONFIG_IP_NF_TARGET_REJECT=m
>>> +CONFIG_IP_NF_NAT=m
>>> +CONFIG_IP_NF_TARGET_MASQUERADE=m
>>> +CONFIG_IP_NF_TARGET_REDIRECT=m
>>> +CONFIG_IP_NF_MANGLE=m
>>> +CONFIG_NF_LOG_IPV6=m
>>> +CONFIG_IP6_NF_IPTABLES=m
>>> +CONFIG_IP6_NF_MATCH_IPV6HEADER=m
>>> +CONFIG_IP6_NF_FILTER=m
>>> +CONFIG_IP6_NF_TARGET_REJECT=m
>>> +CONFIG_IP6_NF_MANGLE=m
>>> +CONFIG_BRIDGE=m
>>> +CONFIG_BRIDGE_VLAN_FILTERING=y
>>> +CONFIG_VLAN_8021Q=m
>>> +CONFIG_NET_SCHED=y
>>> +CONFIG_NET_CLS_CGROUP=m
>>>  CONFIG_NETLINK_DIAG=y
>>> +CONFIG_CGROUP_NET_PRIO=y
>>>  CONFIG_NET_9P=y
>>>  CONFIG_NET_9P_VIRTIO=y
>>>  CONFIG_PCI=y
>>> @@ -57,7 +105,15 @@ CONFIG_SCSI_VIRTIO=y
>>>  CONFIG_ATA=y
>>>  CONFIG_SATA_AHCI=y
>>>  CONFIG_SATA_AHCI_PLATFORM=y
>>> +CONFIG_MD=y
>>> +CONFIG_BLK_DEV_DM=m
>>> +CONFIG_DM_THIN_PROVISIONING=m
>>>  CONFIG_NETDEVICES=y
>>> +CONFIG_DUMMY=m
>>> +CONFIG_MACVLAN=m
>>> +CONFIG_IPVLAN=m
>>> +CONFIG_VXLAN=m
>>> +CONFIG_VETH=m
>>>  CONFIG_VIRTIO_NET=y
>>>  CONFIG_MACB=y
>>>  CONFIG_E1000E=y
>>> @@ -105,7 +161,11 @@ CONFIG_RPMSG_CTRL=y
>>>  CONFIG_RPMSG_VIRTIO=y
>>>  CONFIG_EXT4_FS=y
>>>  CONFIG_EXT4_FS_POSIX_ACL=y
>>> +CONFIG_EXT4_FS_SECURITY=y
>>> +CONFIG_BTRFS_FS=m
>>> +CONFIG_BTRFS_FS_POSIX_ACL=y
>>>  CONFIG_AUTOFS4_FS=y
>>> +CONFIG_OVERLAY_FS=m
>>>  CONFIG_MSDOS_FS=y
>>>  CONFIG_VFAT_FS=y
>>>  CONFIG_TMPFS=y
>>> @@ -119,6 +179,10 @@ CONFIG_ROOT_NFS=y
>>>  CONFIG_9P_FS=y
>>>  CONFIG_NLS_CODEPAGE_437=y
>>>  CONFIG_NLS_ISO8859_1=m
>>> +CONFIG_SECURITY=y
>>> +CONFIG_SECURITY_SELINUX=y
>>> +CONFIG_SECURITY_APPARMOR=y
>>> +CONFIG_DEFAULT_SECURITY_DAC=y
>>>  CONFIG_CRYPTO_USER_API_HASH=y
>>>  CONFIG_CRYPTO_DEV_VIRTIO=y
>>>  CONFIG_PRINTK_TIME=y
>>> @@ -137,7 +201,6 @@ CONFIG_DEBUG_SPINLOCK=y
>>>  CONFIG_DEBUG_MUTEXES=y
>>>  CONFIG_DEBUG_RWSEMS=y
>>>  CONFIG_DEBUG_ATOMIC_SLEEP=y
>>> -CONFIG_STACKTRACE=y
>>>  CONFIG_DEBUG_LIST=y
>>>  CONFIG_DEBUG_PLIST=y
>>>  CONFIG_DEBUG_SG=y
>>
>> Sorry for being so slow here.  I don't have any issues with this as a
>> concept, but it makes a handful of my test configs panic on boot.  Seems
>> like something is tripping up a kasan failure.  I guess it's kind of
>
> Hello Palmer,
>
> thanks for sharing your test experience. Could you, please, provide the
> config file and the test configuration that leads the regression.

My test setup is at 
<http://github.com/palmer-dabbelt/riscv-systems-ci.git>.  I don't 
advertise it all that much because it's pretty flaky, but some folks 
have gotten it working recently.  `make 
check/qemu-rv64gc-virt-smp8/halt-kasan-glibc/stdout` hangs for me with 
your patch, that's running the "kasan" config from here 
<https://github.com/palmer-dabbelt/riscv-systems-ci/blob/master/configs/linux/kasan>, 
it just flips on CONFIG_KASAN so it shouldn't be all that hard to 
reproduce outside the setup (those configs are all additions to 
defconfig).

I don't have a trace lying around, but it triggers asan failures in a 
handful of block driver initialization routines (I remember seeing 
SD/MMC and USB storage).  I can dig them up if you can't reproduce it, 
but hopefully it's simple.

>> arbitrary to call that a regression, as I'm sure it's just uncovering
>> some issue that already exists, but turning something on in defconfig
>> that panics with kasan is going to have a bunch of fallout.
>>
>> It looks like BLK_CGROUP is the problem here, so if you're OK with it
>> then I'm happy to take the rest of these.  I put that over at
>> kernel.org/palmer/linux/riscv-docker_no_blk_cgroup, if that's OK I'll
>> cherry-pick it onto for-next.
>
> I am fine with cherry picking.

OK, it's on for-next.  Thanks!

>
> Best regards
>
> Heinrich
>
>>
>> There's almost certainly a bug here that warrants fixing.
