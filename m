Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48F354243C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiFHGDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347902AbiFHF6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:58:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD404227CD9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:25:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so106411wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 21:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIB9Zoi6oSsV28Eb5tHcA3tLyAqAFY8VH40TtTHLgNU=;
        b=LOFTU1tYU5/Z1f5XGipGNjbflsQWOwUgwu5h05VFcytZtP6op926WHFJR1SVt38ubI
         AB/A4U9bs9IbmGfiD6URbfkNTLnb2KDBmrK4vZfn/PgyMissRkPgpPxv1/1o0eRg8W87
         pa/JX6Z1LLCNJFWBO4ShyFK+OUJ2ls/8hW1eRI32wlViSokKJybJZkCXb3AfHmDgFOJN
         EjeX8IpEvE23MxI7GBvzLNmXyrST6KbVrs6Kg2pQ4Q4THJorFLIzgr/smOKfwZ7XWpO+
         +ul/IUFaVxun47PvYKcUxLOMOWTOoVHpnE3MgGZufyZG2wwCIY4NGDf+PEmNST5GXdk4
         W/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIB9Zoi6oSsV28Eb5tHcA3tLyAqAFY8VH40TtTHLgNU=;
        b=IrZ5Wu3FxnQjcL/hZtmso7CGG62b2kAkYf/LqfvwCUuPdUn9z9s1hiijNfAPu/ltXG
         DEiAWN1eHEfcaK0OTn0UMJUENmx8365S8ZAY83crb20NPiXrjEezKDbfX1gp6I8g47GF
         +tAnhthSLLIaikt68wNmIvrsAUB41VSfbWbjnnOxnwu8XtZxt6IzUIKlJ0IIL/XZLyFS
         GWeQ/ETWHrfrBoBiVzIGz8kvkb9WWOYDc2R9Czm1T2Vo1t2IwRIvHXgffj07WmxygK9o
         01CDmjwWrWAJFzdLCqo66MmagR2O9CBuKQwMAFGyMG6Qdyjc2pe0E6JbZEoQyoD2popK
         Otgg==
X-Gm-Message-State: AOAM5302uXWADiVlI6p7Yx+lBkpiEZCDLWqKXtNvuCBNc+H4l56zX3g4
        5EGFIxhVi8VDTAZrYFocSS4ivIqgkKv0lVZZVHKdafY7LOuDuQ==
X-Google-Smtp-Source: ABdhPJxq7M69jQtimnYFsucGxQbS4qbMg3gTWP97of3HmIV//mhzGdHJ2pfrWPDz3n3UVRArNL1vVl/iFRZblKmK8YI=
X-Received: by 2002:a05:600c:5112:b0:397:53f5:e15b with SMTP id
 o18-20020a05600c511200b0039753f5e15bmr32914425wms.93.1654662320293; Tue, 07
 Jun 2022 21:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220608000251.55271-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20220608000251.55271-1-heinrich.schuchardt@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 8 Jun 2022 09:54:21 +0530
Message-ID: <CAAhSdy2Brfc-Pz3wmZxwocQr1g5TpWWWVVhmeCYbEj5t=3NcKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: enable Docker requirements in defconfig
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 5:33 AM Heinrich Schuchardt
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
