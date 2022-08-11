Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7258FAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiHKKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:22:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD2F255BA;
        Thu, 11 Aug 2022 03:22:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E25A5C00CD;
        Thu, 11 Aug 2022 06:22:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Aug 2022 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660213359; x=1660299759; bh=GAIaaeg6VU
        Z/HXdTZ6n0jyzFEcMotm8n/nJvYfvgRGs=; b=ApZ9bWg9SsWMwb+ozmshqklWe5
        EtEq/cDUXJzHItlBUFWTcmJPwzS03MY9kQi+WsalA6LhRBAeiBMrpnsOsOpyuAE6
        rxpRDN/uLLT3aBsAvas20kNQCbWeEsGrKrZe/Zp9EqePp6XjnGYaYZG3DQzq5YdX
        6fBd6yjC398elBuUMc/DJf+XGfVHdD4mrLv3v9k1BBjt2C5GRZCQu7ddrO116KFr
        3/1ZWvF4YpEghcvfk1KLMUKDxSNA7QXEFdjnNO4oxXbwccEJFgzepKGELMBlaCnH
        tOp+vCgHOUZpQrAlD0sX9x63KT38ouAEnXmUZQCntNhSENgSXa8YIcqUxp/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660213359; x=1660299759; bh=GAIaaeg6VUZ/HXdTZ6n0jyzFEcMo
        tm8n/nJvYfvgRGs=; b=sJyotw8JmJlrtW+CAOb/FezZH6j8Z3QxeAgAk3rgWf4g
        NkJfr+p+n5RF92SAB2K4BpxCdmaCF+Ci7TLveIGbaNhNyCxotl0RWxPZ0lXusrdW
        sVDBbc6j10r3UrhJi2nWA8XFxx03ZEGOzQXGl/l23aOzOlIlprzbQOxuBdL4kRdk
        S+sWa4WA67CrceVrsv9mpGhclB/XUW8h0QF8NOrriEKpDHowiz51LCqM58zjPYeX
        4iXO3zsoAOHVINRx+oi07xxg4QAFXJ1hexIsI6DexTsieY0vR5Xx8dkyQJxVYooB
        7DOUpER1Su7AMUSzir4VvIKEwju6ra5z8Uq5XtQ7kA==
X-ME-Sender: <xms:b9j0YpR1JQIoAeU2G-PqQa7h4npVvDhZ3_0YvpgXafxrwl45f1TFVg>
    <xme:b9j0Yiwk_JWjYVgwpUeOEyxhEU6IXnjUrsCoC32A2jZzCntyHzby3XYBcOV3pWnnj
    8uz4B_ni-eNbQ>
X-ME-Received: <xmr:b9j0Yu1Gy9zCw8I-Y84hFltmGlZg_UQN7fRQpETupV73kw65JiSc4NUM-wEqXdlD38sldG0fA_3kRaTu2s0KP9u2QXPCu3es>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeggedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:b9j0YhCNpdHjXscFl5L2lUtVkN1CHD1eXM0Hd9FIQvyqI4IjCxfgdA>
    <xmx:b9j0Yig0PSc_LZY32cccK261VUFSJzKyyR-5JIk2aCDNCr8hrW0Xhw>
    <xmx:b9j0YlrBsffi10eT7dGxHf9hTs8Xj5sTArMmBaTGPdA6y0Lkggolww>
    <xmx:b9j0YrXEPeEFhbW3zKwWRMhO8AtP7jAXBwoAh7qoKzWaKHqFt55I7Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Aug 2022 06:22:38 -0400 (EDT)
Date:   Thu, 11 Aug 2022 12:22:37 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <YvTYbZnQlfzPz934@kroah.com>
References: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:12:36AM +0000, Jiaxun Yang wrote:
> Some application would like to know precise model and rev of processor
> to do errata workaround or optimization.
> 
> Expose them in sysfs as:
> /sys/devices/system/cpu/cpuX/regs/identification/prid
> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> 
> Reusing AArch64 CPU registers directory.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop static qualifier for kobj (gregkh)
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
>  arch/mips/kernel/topology.c                   | 96 +++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5bf61881f012..adf855e7bb9b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
>  
>  		cpu_capacity: capacity of cpuX.
>  
> +What:		/sys/devices/system/cpu/cpuX/regs/
> +		/sys/devices/system/cpu/cpuX/regs/identification/
> +		/sys/devices/system/cpu/cpuX/regs/identification/prid
> +		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> +Date:		Augest 2022
> +Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
> +Description:	MIPS CPU registers
> +
> +		'identification' directory exposes the Processor ID and Global Number
> +		registers for identifying model and revision of the CPU.

You do not document that this is only for MIPS processors.

Actually, why not do this for all chip types?  Why is this only for MIPS
chips?

> +
>  What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/meltdown
>  		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..0e3730f3c00f 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> @@ -5,6 +5,8 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
>  
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>  
> @@ -26,3 +28,97 @@ static int __init topology_init(void)
>  }
>  
>  subsys_initcall(topology_init);
> +
> +static struct kobj_type cpuregs_kobj_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct cpureg {
> +	struct kobject kobj;
> +	struct cpuinfo_mips *info;
> +};
> +DEFINE_PER_CPU(struct cpureg, cpuregs);

You still have static kobjects here, nothing changed from your previous
submission :(

