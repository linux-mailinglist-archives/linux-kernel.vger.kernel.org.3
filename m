Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC7F56362D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGAOwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiGAOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:52:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D42739829;
        Fri,  1 Jul 2022 07:52:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so2589377plx.7;
        Fri, 01 Jul 2022 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VtRn7J8UK9F1ZALx4DAzcvIjviWaAote6TFMkawwS2Q=;
        b=VrZy5l9pS2nBBfVJ8O1osCzcMfFK0+fraoX/RJvU9pOYe8DSieVkv4aMWSEfW3ASoE
         /Yo4eCXW8ww23eNOv2pd+PixLwvnrLpiUmBunDPnFxPDfsox3MH8a6tY28x6489hDEoI
         eJITqqbn6VF4X4oXKj/78Nw2QqXGuib9tFA3pBi0zL7U63/3oIMS75S6BXbI/TOQYKmG
         VAFdgC+FsanoiY5kcPPrJ5MNHv7AYusnWjH9ksPid4bs1a23ZwS84QQdc246x9Rqylju
         cbDl2CaAJQjY1jGrmQpaMAxSbJJtGVlaEiSVEweBf4LJNkG3l34sMbp6RuEXgWsxF0Yi
         7F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VtRn7J8UK9F1ZALx4DAzcvIjviWaAote6TFMkawwS2Q=;
        b=zNrzM45CemL4jAOxE3vuiiVDrkFuCsHXGzwqgd3sD87WqH9SEz0/Z4kGS1tnNnO1cA
         gaLQuJbziAi+3JeB8s6FmTlWZvWSPPRyMx9N3WbmP0j/H6Im9rju7Z1g40USdzgS433T
         G/uROioFEEuuxdPGm5iPcsO3wfYoC0cbdzWx3EHeP3Ob0yT9IJPPt+p/2yEJyNMST9IJ
         nzVpeqHrkoXPsHgFEXRdV33yVW4bBzPFlFfi3Gf1PpeKPSVFo7uOUVsvPuzFhP+z7LPM
         QV8MfPZnsLjl1x0RJFPumRa+5gR6t21qZBf+L2G7vRj9O3B4Wo91UQgGBOcco7uw5AGU
         ZavQ==
X-Gm-Message-State: AJIora/+q5uPD5cSAYK+me3orMILBcN/e4hIgratttciRyA8ExUooW19
        TlBIfNKvyVj/gMnaryawpJA=
X-Google-Smtp-Source: AGRyM1ue+gzwL/Dt44L8ploiA1VtYHi8RBPl8iVD9Lhc/Mz0cj6bn6gwIvVs7N29ocEZLZTkV6+xwA==
X-Received: by 2002:a17:90b:4a4e:b0:1ec:beae:6f33 with SMTP id lb14-20020a17090b4a4e00b001ecbeae6f33mr18671104pjb.185.1656687125619;
        Fri, 01 Jul 2022 07:52:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00188900b0050dc762818csm15856480pfh.102.2022.07.01.07.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:52:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b3dcfa3-e305-21b2-150f-e093c41d7f2b@roeck-us.net>
Date:   Fri, 1 Jul 2022 07:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-3-sebastianene@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220701144013.1085272-3-sebastianene@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 07:40, Sebastian Ene wrote:
> This driver creates per-cpu hrtimers which are required to do the
> periodic 'pet' operation. On a conventional watchdog-core driver, the
> userspace is responsible for delivering the 'pet' events by writing to
> the particular /dev/watchdogN node. In this case we require a strong
> thread affinity to be able to account for lost time on a per vCPU.
> 
> This part of the driver is the 'frontend' which is reponsible for
> delivering the periodic 'pet' events, configuring the virtual peripheral
> and listening for cpu hotplug events. The other part of the driver is
> an emulated MMIO device which is part of the KVM virtual machine
> monitor and this part accounts for lost time by looking at the
> /proc/{}/task/{}/stat entries.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/misc/Kconfig               |  13 ++
>   drivers/misc/Makefile              |   1 +
>   drivers/misc/vcpu_stall_detector.c | 212 +++++++++++++++++++++++++++++
>   3 files changed, 226 insertions(+)
>   create mode 100644 drivers/misc/vcpu_stall_detector.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 41d2bb0ae23a..83afb41a85cf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -483,6 +483,19 @@ config OPEN_DICE
>   
>   	  If unsure, say N.
>   
> +config VCPU_STALL_DETECTOR
> +	tristate "VCPU stall detector"
> +	select LOCKUP_DETECTOR
> +	depends on OF
> +	help
> +	  Detect CPU locks on a kvm virtual machine. This driver relies on
> +	  the hrtimers which are CPU-binded to do the 'pet' operation. When a
> +	  vCPU has to do a 'pet', it exits the guest through MMIO write and
> +	  the backend driver takes into account the lost ticks for this
> +	  particular CPU.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called vcpu_stall_detector.
> +
>   source "drivers/misc/c2port/Kconfig"
>   source "drivers/misc/eeprom/Kconfig"
>   source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 70e800e9127f..2be8542616dd 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
>   obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
>   obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
>   obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
> +obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
> \ No newline at end of file
> diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
> new file mode 100644
> index 000000000000..039ac54564c1
> --- /dev/null
> +++ b/drivers/misc/vcpu_stall_detector.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// VCPU stall detector.
> +//  Copyright (C) Google, 2022
> +
> +#include <linux/cpu.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/nmi.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/param.h>
> +#include <linux/percpu.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define REG_STATUS		(0x00)
> +#define REG_LOAD_CNT		(0x04)
> +#define REG_CURRENT_CNT		(0x08)
> +#define REG_CLOCK_FREQ_HZ	(0x0C)
> +#define REG_LEN			(0x10)
> +
> +#define DEFAULT_CLOCK_HZ	(10)
> +#define DEFAULT_TIMEOT_SEC	(8)
> +
> +struct vm_stall_detect_s {
> +	void __iomem *membase;
> +	u32 clock_freq;
> +	u32 expiration_sec;
> +	u32 ping_timeout_ms;
> +	struct hrtimer per_cpu_hrtimer;
> +	struct platform_device *dev;
> +};
> +
> +#define vcpu_stall_detect_reg_write(stall_detect, reg, value)	\
> +	iowrite32((value), (stall_detect)->membase + (reg))
> +#define vcpu_stall_detect_reg_read(stall_detect, reg)		\
> +	io32read((stall_detect)->membase + (reg))
> +
> +static struct vm_stall_detect_s __percpu *vm_stall_detect;
> +
> +static enum hrtimer_restart
> +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> +{
> +	struct vm_stall_detect_s *cpu_stall_detect;
> +	u32 ticks;
> +
> +	cpu_stall_detect = container_of(hrtimer, struct vm_stall_detect_s,
> +					per_cpu_hrtimer);
> +	ticks = cpu_stall_detect->clock_freq * cpu_stall_detect->expiration_sec;
> +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
> +	hrtimer_forward_now(hrtimer,
> +			    ms_to_ktime(cpu_stall_detect->ping_timeout_ms));
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static void vcpu_stall_detect_start(void *arg)
> +{
> +	u32 ticks;
> +	struct vm_stall_detect_s *cpu_stall_detect = arg;
> +	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
> +
> +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_CLOCK_FREQ_HZ,
> +				    cpu_stall_detect->clock_freq);
> +
> +	/* Compute the number of ticks required for the stall detector counter
> +	 * register based on the internal clock frequency and the timeout
> +	 * value given from the device tree.
> +	 */
> +	ticks = cpu_stall_detect->clock_freq *
> +		cpu_stall_detect->expiration_sec;
> +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_LOAD_CNT, ticks);
> +
> +	/* Enable the internal clock and start the stall detector */
> +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 1);
> +
> +	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer->function = vcpu_stall_detect_timer_fn;
> +	hrtimer_start(hrtimer, ms_to_ktime(cpu_stall_detect->ping_timeout_ms),
> +		      HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static void vcpu_stall_detect_stop(void *arg)
> +{
> +	struct vm_stall_detect_s *cpu_stall_detect = arg;
> +	struct hrtimer *hrtimer = &cpu_stall_detect->per_cpu_hrtimer;
> +
> +	hrtimer_cancel(hrtimer);
> +
> +	/* Disable the stall detector */
> +	vcpu_stall_detect_reg_write(cpu_stall_detect, REG_STATUS, 0);
> +}
> +
> +static int start_stall_detector_on_cpu(unsigned int cpu)
> +{
> +	vcpu_stall_detect_start(this_cpu_ptr(vm_stall_detect));
> +	return 0;
> +}
> +
> +static int stop_stall_detector_on_cpu(unsigned int cpu)
> +{
> +	vcpu_stall_detect_stop(this_cpu_ptr(vm_stall_detect));
> +	return 0;
> +}
> +
> +static int vcpu_stall_detect_probe(struct platform_device *dev)
> +{
> +	int cpu, ret, err;
> +	void __iomem *membase;
> +	struct resource *r;
> +	u32 stall_detect_clock, stall_detect_timeout_sec = 0;
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r == NULL)
> +		return -ENODEV;
> +
> +	vm_stall_detect = alloc_percpu(typeof(struct vm_stall_detect_s));
> +	if (!vm_stall_detect)
> +		return -ENOMEM;
> +
> +	membase = ioremap(r->start, resource_size(r));
> +	if (!membase) {
> +		ret = -ENOMEM;
> +		goto err_withmem;
> +	}
> +
> +	if (of_property_read_u32(dev->dev.of_node, "clock-frequency",
> +				 &stall_detect_clock))
> +		stall_detect_clock = DEFAULT_CLOCK_HZ;
> +
> +	if (of_property_read_u32(dev->dev.of_node, "timeout-sec",
> +				 &stall_detect_timeout_sec))
> +		stall_detect_timeout_sec = DEFAULT_TIMEOT_SEC;
> +
> +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> +		struct vm_stall_detect_s *cpu_stall_detect;
> +
> +		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
> +		cpu_stall_detect->membase = membase + cpu * REG_LEN;
> +		cpu_stall_detect->clock_freq = stall_detect_clock;
> +		cpu_stall_detect->expiration_sec = stall_detect_timeout_sec;
> +
> +		/* Pet the stall detector at half of its expiration timeout
> +		 * to prevent spurios resets.
> +		 */
> +		cpu_stall_detect->ping_timeout_ms = stall_detect_timeout_sec *
> +			MSEC_PER_SEC / 2;
> +		smp_call_function_single(cpu, vcpu_stall_detect_start,
> +					 cpu_stall_detect, true);
> +	}
> +
> +	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +					"virt/vcpu_stall_detector:online",
> +					start_stall_detector_on_cpu,
> +					stop_stall_detector_on_cpu);
> +	if (err < 0) {
> +		dev_err(&dev->dev, "failed to install cpu hotplug");
> +		ret = err;
> +		goto err_withmem;
> +	}
> +
> +	return 0;
> +
> +err_withmem:
> +	free_percpu(vm_stall_detect);
> +	return ret;
> +}
> +
> +static int vcpu_stall_detect_remove(struct platform_device *dev)
> +{
> +	int cpu;
> +
> +	for_each_cpu_and(cpu, cpu_online_mask, &watchdog_cpumask) {
> +		struct vm_stall_detect_s *cpu_stall_detect;
> +
> +		cpu_stall_detect = per_cpu_ptr(vm_stall_detect, cpu);
> +		smp_call_function_single(cpu, vcpu_stall_detect_stop,
> +					 cpu_stall_detect, true);
> +	}
> +
> +	free_percpu(vm_stall_detect);
> +	vm_stall_detect = NULL;
> +	return 0;
> +}
> +
> +static const struct of_device_id vcpu_stall_detect_of_match[] = {
> +	{ .compatible = "qemu,vcpu-stall-detector", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);
> +
> +static struct platform_driver vcpu_stall_detect_driver = {
> +	.probe  = vcpu_stall_detect_probe,
> +	.remove = vcpu_stall_detect_remove,
> +	.driver = {
> +		.name           = KBUILD_MODNAME,
> +		.of_match_table = vcpu_stall_detect_of_match,
> +	},
> +};
> +
> +module_platform_driver(vcpu_stall_detect_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sebastian Ene <sebastianene@google.com>");
> +MODULE_DESCRIPTION("VCPU stall detector");

