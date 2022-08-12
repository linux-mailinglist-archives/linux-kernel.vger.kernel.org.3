Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BF0590A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiHLCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHLCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:22:01 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5396A261F;
        Thu, 11 Aug 2022 19:22:00 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id ct13so14672170qvb.9;
        Thu, 11 Aug 2022 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=IkazLQZ84Q26kzveSL5BkqpfE1Vq+obj2HXrXNZWzT0=;
        b=VO+0YqnY+MPfIKLhNhBqriPkY9g8pax7KLqlZTmgZOCt6SdaPele3loo0fWbSal0p6
         WXLIn9xgHJvLihP6rwIVUqLUhb/qHGpLSZ2wTPFkJoYX09rn+5o2KhJjK+GMAjdOeyeg
         VTvYbxFzgx3pk9AH+g1LHmZa3puAN4RyHJqUJuOCxDLwhcUUs0EPl/yDn6w2cIgPGHal
         JiiRKUA7oSDnki1UACcPUyVFX9ITqYkn7qagAcBrR/zph2LSXPrOpa7lA3qMvatb2afl
         p+f3qixGBa4XrRfGBYJ8P8dHhYalrlSwu8DQwFdj1b5aQuKk0D5kW7jV87OsK0mDk49i
         moeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=IkazLQZ84Q26kzveSL5BkqpfE1Vq+obj2HXrXNZWzT0=;
        b=wjjITfCZYdC7mkdozCNyLJNzz+fyfnnH9Q0xLgdDS7jMCWkqIn/hQeajoGl0cdAckB
         uNIH6gYO05HZqFhLHL/RGRdIj2UMO+kbWl4fMztwhrjm58WzjsZsCNR4Jrz7aLwyARph
         waBZbYMlcpSuN/SXCOXWpDbND094qx54vFSW9MdvIcwUjrHGuMY+V1PiOr/Qf4JaFgec
         B4f91RVYwdyO1xC9PN/JEfMKksgjf9jK0wFMHgojy2xOpOk5eDLQoQQfF4w7q7USuli9
         cKWXQ1MoUxPoqACf6uBMonvaPKvFWC97SW2yllE9ckw9dKlantD9N6jK3pJozSPiNDKG
         ajTA==
X-Gm-Message-State: ACgBeo3bFAfOMV3v39DaJ1XEvorlVLV9+bU6zeUfcWbfQzgFIgeP0t3v
        taoA8ay7pAMBEpfsbkG8QTHxCvf9ulo=
X-Google-Smtp-Source: AA6agR5mc98r8PDNdy+j4WK4zZ8gl8YoS72ukeua2wDhElP57/15X+d6up0XTh8EwPZLoj++MJW7Ow==
X-Received: by 2002:ad4:5d45:0:b0:474:7373:4f1f with SMTP id jk5-20020ad45d45000000b0047473734f1fmr1840905qvb.27.1660270920011;
        Thu, 11 Aug 2022 19:22:00 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85655000000b0034355a352d1sm756783qtt.92.2022.08.11.19.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 19:21:59 -0700 (PDT)
Message-ID: <66e7f45b-2292-f76e-b9a1-3db2af8c24a9@gmail.com>
Date:   Thu, 11 Aug 2022 19:21:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v2] MIPS: Expose prid and globalnumber to sysfs
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-api@vger.kernel.org
References: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220811101236.1925-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2022 3:12 AM, Jiaxun Yang wrote:
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
>   .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
>   arch/mips/kernel/topology.c                   | 96 +++++++++++++++++++
>   2 files changed, 107 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5bf61881f012..adf855e7bb9b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
>   
>   		cpu_capacity: capacity of cpuX.
>   
> +What:		/sys/devices/system/cpu/cpuX/regs/
> +		/sys/devices/system/cpu/cpuX/regs/identification/
> +		/sys/devices/system/cpu/cpuX/regs/identification/prid
> +		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> +Date:		Augest 2022

typo: August

> +Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
> +Description:	MIPS CPU registers
> +
> +		'identification' directory exposes the Processor ID and Global Number
> +		registers for identifying model and revision of the CPU.
> +
>   What:		/sys/devices/system/cpu/vulnerabilities
>   		/sys/devices/system/cpu/vulnerabilities/meltdown
>   		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..0e3730f3c00f 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> @@ -5,6 +5,8 @@
>   #include <linux/node.h>
>   #include <linux/nodemask.h>
>   #include <linux/percpu.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
>   
>   static DEFINE_PER_CPU(struct cpu, cpu_devices);
>   
> @@ -26,3 +28,97 @@ static int __init topology_init(void)
>   }
>   
>   subsys_initcall(topology_init);
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
> +
> +#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
> +#define CPUREGS_ATTR_RO(_name, _field)						\
> +	static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)			\
> +	{									\
> +		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
> +										\
> +		return sprintf(buf, "0x%08x\n", info->_field);	\

Would not you be able to simplify this greatly with just:

	struct cpuinfo_mips *info = current_cpu_data;

and not have to associate that with struct with the kobject?
-- 
Florian
