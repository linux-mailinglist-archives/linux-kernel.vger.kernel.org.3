Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2553FD69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiFGLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiFGLWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:22:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAB19FAF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79828B81F6A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14474C385A5;
        Tue,  7 Jun 2022 11:22:17 +0000 (UTC)
Date:   Tue, 7 Jun 2022 12:22:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] arm64: Enable docker support in defconfig
Message-ID: <Yp805qEluR+ZmF/V@arm.com>
References: <20220606140103.32779-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606140103.32779-1-vincenzo.frascino@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 03:01:03PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..f6b8eda18498 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -18,6 +18,7 @@ CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_FREEZER=y
>  CONFIG_CGROUP_HUGETLB=y
>  CONFIG_CPUSETS=y
>  CONFIG_CGROUP_DEVICE=y
> @@ -138,12 +139,16 @@ CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IPV6=m
>  CONFIG_NETFILTER=y
> +CONFIG_BRIDGE_NETFILTER=m
>  CONFIG_NF_CONNTRACK=m
>  CONFIG_NF_CONNTRACK_EVENTS=y
> +CONFIG_NETFILTER_XT_MARK=m
>  CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
>  CONFIG_NETFILTER_XT_TARGET_LOG=m
>  CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
>  CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> +CONFIG_NETFILTER_XT_MATCH_IPVS=m
> +CONFIG_IP_VS=m
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP_NF_FILTER=m
>  CONFIG_IP_NF_TARGET_REJECT=m

The patch looks fine. It's usually Arnd who merges defconfig changes,
so I'll leave it to him.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
