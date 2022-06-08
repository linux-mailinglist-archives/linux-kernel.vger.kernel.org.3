Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449C542391
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiFHFR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiFHFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:17:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1403E3EB5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1092B823D1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593BDC385A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654655113;
        bh=FFUsWJioa9nIPPM8bqcIBRB9CBFD39TPKbZIvc2KBN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JweZY38lc/IH1xS8/w/hd7k/5rvefAaDbenP188Qo4FVzJfPXMYzOe91LO1C5g30d
         sT6zQKuFDOppB1phUYSW7UbNr+Gwr7taG+1GMkFT1eWh2Bt4GNUrKLqRGl6Wl8BB/x
         HOMTOgexoRfLyvWXsMerGxA4lhvq/Py/u3VVrbRT3J91UCoFHzZx1V8K1bbaqyftBr
         IOFFkjFurWmagqI53uN+cMI1TfTksnDjpou8iCO73agOsqKULBj9JBic/NOFWAJmVO
         PmdY6I6kYcgKyos4iSPVASFusKhT34xblUh0HQGlNMc9u0k18MRbF5ZA8bgKnAirGR
         TR55Py6koypiQ==
Received: by mail-vs1-f51.google.com with SMTP id g6so126522vsb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:25:13 -0700 (PDT)
X-Gm-Message-State: AOAM531/olzTQiXylsBgTAoU6Avc+Lw5od9pEkWEqpvpzWrpA0MUQdsL
        QB4c/f3qGwgaYEcWylaWIce2ejRw5OdQiAwl4WM=
X-Google-Smtp-Source: ABdhPJyUfZWfRw0ONbZzXO4qPm+eUiyMkQLQt9K9e/s2DKEOTQQenrj32/GCeEQX9vOIE375u7guH8/5fkrHLZWh1o8=
X-Received: by 2002:a05:6102:292b:b0:34b:9fad:2b63 with SMTP id
 cz43-20020a056102292b00b0034b9fad2b63mr9689277vsb.51.1654655112251; Tue, 07
 Jun 2022 19:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608000251.55271-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20220608000251.55271-1-heinrich.schuchardt@canonical.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 8 Jun 2022 10:25:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQoGgrN7Tus8qpOgSMC2XATM0ymTb8Fwt4v1QkwMUda4A@mail.gmail.com>
Message-ID: <CAJF2gTQoGgrN7Tus8qpOgSMC2XATM0ymTb8Fwt4v1QkwMUda4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agree make docker support default in riscv.

Acked-by: Guo Ren <guoren@kernel.org>

On Wed, Jun 8, 2022 at 8:03 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The defconfig kernel should be able to run Docker.
>
> Enable the missing settings according to [1].
> make savedefconfig eliminates CONFIG_STACKTRACE
> which is enabled by default.
>
> Many of the settings are also needed to run a defconfig kernel
> on default distro installations or to run snaps.
>
> [1] https://github.com/moby/moby/blob/master/contrib/check-config.sh
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> Cf. [PATCH] arm64: Enable docker support in defconfig
> https://lore.kernel.org/lkml/20220606140103.32779-1-vincenzo.frascino@arm.com/
> ---
>  arch/riscv/configs/defconfig | 65 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0cc17db8aaba..d4fffcd3cc05 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -6,8 +6,18 @@ CONFIG_BPF_SYSCALL=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> +CONFIG_MEMCG=y
> +CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CGROUP_HUGETLB=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_CGROUP_PERF=y
>  CONFIG_CGROUP_BPF=y
>  CONFIG_NAMESPACES=y
>  CONFIG_USER_NS=y
> @@ -28,9 +38,11 @@ CONFIG_KVM=m
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> +CONFIG_BLK_DEV_THROTTLING=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> +CONFIG_XFRM_USER=m
>  CONFIG_INET=y
>  CONFIG_IP_MULTICAST=y
>  CONFIG_IP_ADVANCED_ROUTER=y
> @@ -38,7 +50,43 @@ CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
> +CONFIG_INET_ESP=m
> +CONFIG_NETFILTER=y
> +CONFIG_BRIDGE_NETFILTER=m
> +CONFIG_NF_CONNTRACK=m
> +CONFIG_NF_CONNTRACK_FTP=m
> +CONFIG_NF_CONNTRACK_TFTP=m
> +CONFIG_NETFILTER_XT_MARK=m
> +CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
> +CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> +CONFIG_NETFILTER_XT_MATCH_IPVS=m
> +CONFIG_IP_VS=m
> +CONFIG_IP_VS_PROTO_TCP=y
> +CONFIG_IP_VS_PROTO_UDP=y
> +CONFIG_IP_VS_RR=m
> +CONFIG_IP_VS_NFCT=y
> +CONFIG_NF_LOG_ARP=m
> +CONFIG_NF_LOG_IPV4=m
> +CONFIG_IP_NF_IPTABLES=m
> +CONFIG_IP_NF_FILTER=m
> +CONFIG_IP_NF_TARGET_REJECT=m
> +CONFIG_IP_NF_NAT=m
> +CONFIG_IP_NF_TARGET_MASQUERADE=m
> +CONFIG_IP_NF_TARGET_REDIRECT=m
> +CONFIG_IP_NF_MANGLE=m
> +CONFIG_NF_LOG_IPV6=m
> +CONFIG_IP6_NF_IPTABLES=m
> +CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> +CONFIG_IP6_NF_FILTER=m
> +CONFIG_IP6_NF_TARGET_REJECT=m
> +CONFIG_IP6_NF_MANGLE=m
> +CONFIG_BRIDGE=m
> +CONFIG_BRIDGE_VLAN_FILTERING=y
> +CONFIG_VLAN_8021Q=m
> +CONFIG_NET_SCHED=y
> +CONFIG_NET_CLS_CGROUP=m
>  CONFIG_NETLINK_DIAG=y
> +CONFIG_CGROUP_NET_PRIO=y
>  CONFIG_NET_9P=y
>  CONFIG_NET_9P_VIRTIO=y
>  CONFIG_PCI=y
> @@ -57,7 +105,15 @@ CONFIG_SCSI_VIRTIO=y
>  CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
> +CONFIG_MD=y
> +CONFIG_BLK_DEV_DM=m
> +CONFIG_DM_THIN_PROVISIONING=m
>  CONFIG_NETDEVICES=y
> +CONFIG_DUMMY=m
> +CONFIG_MACVLAN=m
> +CONFIG_IPVLAN=m
> +CONFIG_VXLAN=m
> +CONFIG_VETH=m
>  CONFIG_VIRTIO_NET=y
>  CONFIG_MACB=y
>  CONFIG_E1000E=y
> @@ -105,7 +161,11 @@ CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_EXT4_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_BTRFS_FS=m
> +CONFIG_BTRFS_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
> +CONFIG_OVERLAY_FS=m
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
> @@ -119,6 +179,10 @@ CONFIG_ROOT_NFS=y
>  CONFIG_9P_FS=y
>  CONFIG_NLS_CODEPAGE_437=y
>  CONFIG_NLS_ISO8859_1=m
> +CONFIG_SECURITY=y
> +CONFIG_SECURITY_SELINUX=y
> +CONFIG_SECURITY_APPARMOR=y
> +CONFIG_DEFAULT_SECURITY_DAC=y
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y
> @@ -137,7 +201,6 @@ CONFIG_DEBUG_SPINLOCK=y
>  CONFIG_DEBUG_MUTEXES=y
>  CONFIG_DEBUG_RWSEMS=y
>  CONFIG_DEBUG_ATOMIC_SLEEP=y
> -CONFIG_STACKTRACE=y
>  CONFIG_DEBUG_LIST=y
>  CONFIG_DEBUG_PLIST=y
>  CONFIG_DEBUG_SG=y
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
