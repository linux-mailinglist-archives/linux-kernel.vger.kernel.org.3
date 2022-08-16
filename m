Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734559548E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiHPIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiHPIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:05:20 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63E14ECB2;
        Mon, 15 Aug 2022 22:28:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DA5963200909;
        Tue, 16 Aug 2022 01:28:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 Aug 2022 01:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660627680; x=1660714080; bh=M6/1ZM1Ic+
        C8Vmra2mooIPDUlrEFKSfGzdn/09DQyGU=; b=PEPwSGaKzfS43wRbLHr9thEzoR
        c1yMU56PmNEljoXrPNVpANyjxB1zQQtvcZb4PQKOEJnR3OAnmB66Doowlc+J4oRm
        tV8Tsh7Hw5/z6R+FSoJcw8f6jMT1F/PKLWMc0ySgGRrTkLvPbJwwyKgudbc6i5yH
        wb258FTbfk127RxpJVCe1wHJ4q4h3Z9lUe5bOOCrKw4aQ/Xg5TfzVh9BCXPpGLS1
        9HZnagUp5WeFF3gSvhrpEIX5JRw4bGyuXFprtmSg8S2F5EMmA0a/ttsOafFN+S+5
        gAYz8tkY6oRylf7u+/udUlql/rdtjVk9hGJYYMaookdI6vWilvTg3BQopvzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660627680; x=1660714080; bh=M6/1ZM1Ic+C8Vmra2mooIPDUlrEF
        KSfGzdn/09DQyGU=; b=GZ9LOO1gR491IzHHo4jzB4zUKDDQnYTBSzl+NlbjoT5s
        qUCrgD6aGqqWg1HT3gmKMjOkhEnkK6wrsGOfSr1IqNfu726Tn/TAPv7WEqrJJ+1K
        6J1hmrepCbfgdEIZUGmx8ak3Ce6NrpOeM9dQzGsCcGEMlkYA9RwX+qAjxZsZxf8d
        0kOeeIAAtSW7QMpRw7jD5ru1sxTrHZO7vzs2zcwWZq8xA/W2QiDOdILepiDY1tqH
        N89KdH+EpvvfC42WeL2WsQI6BKGjSaM4OT1TNwSYNwof3krzfyyTtTTfcmQEjlus
        g4H7RMt4E206RjVlflbVrVPcbN+69qHV1W7kSUtqXw==
X-ME-Sender: <xms:3yr7YrCsYCOHpPk7VxdZCbgiRD6fftdwFjrVKquyXsLsVOKH0At3ww>
    <xme:3yr7YhjDhQWvhZkcxC52q7Snvu2sBDpmwK0EzDklIVXSxKwduoQs0DFnQNpdg8IJb
    fimkrYFBwlqyA>
X-ME-Received: <xmr:3yr7Ymn5uyhVu27fllZsTBTWK4bf-0NpYVf66TNYxJwY0kggYyF55vkJ9teCRoVooSD6utiZCM8WPvXj7Ev4rhCPHWp3mVM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:3yr7YtzzzHnNNFsx2i0iMgr5HmAqCTkOYxMmSwojJFfgbNBi0t995Q>
    <xmx:3yr7YgRBb9JS3ZX2n_ta9gmZx6Gir5QgyNFv_rmJ8mX2JRj6uSpoGg>
    <xmx:3yr7YgbjXnaaSn9olz8bHfua1C9mUzfBHMLMEORbdRErGBdVHbCj1g>
    <xmx:4Cr7YlIc-NLsPPnNhVgLPCmwPTtQ-cqv3J-QiWD9GZ2f5jdYPPBZhg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 01:27:59 -0400 (EDT)
Date:   Tue, 16 Aug 2022 07:27:56 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v3] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <Yvsq3CPf3+ZjYyat@kroah.com>
References: <20220815165658.11887-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815165658.11887-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 04:56:58PM +0000, Jiaxun Yang wrote:
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
> v3: Use kzalloc to allocate struct cpuregs.
>     note: When Greg mentioned about static I was thinking about
>     static qualifier of percpu variable. After reading documents
>     again it turns out kobjs should be allocated at runtime. Arm64's
>     cpuinfo kobj is also on a percpu variable... I guess that was a
>     intentional use?
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  11 ++
>  arch/mips/kernel/topology.c                   | 103 ++++++++++++++++++
>  2 files changed, 114 insertions(+)
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
> +
>  What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/meltdown
>  		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..bbb7d4b51ffe 100644
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
> @@ -26,3 +28,104 @@ static int __init topology_init(void)
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
> +static DEFINE_PER_CPU(struct cpureg *, cpuregs);
> +
> +#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
> +#define CPUREGS_ATTR_RO(_name, _field)						\
> +	static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)			\
> +	{									\
> +		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
> +										\
> +		return sprintf(buf, "0x%08x\n", info->_field);	\
> +	}									\
> +	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
> +
> +CPUREGS_ATTR_RO(prid, processor_id);
> +CPUREGS_ATTR_RO(globalnumber, globalnumber);
> +
> +static struct attribute *cpuregs_id_attrs[] = {
> +	&cpuregs_attr_prid.attr,
> +	&cpuregs_attr_globalnumber.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cpuregs_attr_group = {
> +	.attrs = cpuregs_id_attrs,
> +	.name = "identification"
> +};
> +
> +static int cpuregs_cpu_online(unsigned int cpu)
> +{
> +	int rc;
> +	struct device *dev;
> +	struct cpureg *reg;
> +
> +	dev = get_cpu_device(cpu);
> +	if (!dev) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +	reg = kzalloc(sizeof(struct cpureg), GFP_KERNEL);
> +	if (!reg) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	rc = kobject_init_and_add(&reg->kobj, &cpuregs_kobj_type,
> +					&dev->kobj, "regs");
> +	if (rc)
> +		goto out_kfree;

No, please read the documentation for kobject_init_and_add() for what to
properly do in a failure of this function.

thanks,

greg k-h
