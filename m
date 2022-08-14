Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3B591D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiHNANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:13:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB91CFE5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CFE1B80AEA
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 00:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E72C433C1;
        Sun, 14 Aug 2022 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660436024;
        bh=3/bvDMNO/jZcAOVv4E2gLPeVbB0hP/hG+SHXMbuPssk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=piJUX90mNjAC1+qqtRfzWFM56KIujtm/9k29BNbO8OgyRnI4KNDOcdQNzw5jlvsUE
         KyClrX0+a3Ci2I4ca4VPP4SCcfw5kv3/dic0L8okbDF5+cleQl9DoAxqIbRPgA9rOX
         sVTti0JKHIL+eX14pEIJDSaupWXiiI9Lolw1+XroTCFyfE2CKTwe5iK2/3D6myxZv/
         SRdeBimE2m17/sbDOXJp77CBSgjtE23fYLtqCnEhmactXB2d4V6icFbM0bcbxhnctg
         BXskn4nfkfAH1bK/24o2sN3poa+NVt4ZaqAYoCU+BegP4AxiMcrdWFREj4qDF29w4+
         zgFpoagdb0haQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 92E5527C0054;
        Sat, 13 Aug 2022 20:13:42 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 20:13:42 -0400
X-ME-Sender: <xms:NT74YrWSQwQnxLHOZNmgIZpuegxEVq4fDsoF-zUkkLJrDrUui5c8fA>
    <xme:NT74YjkxZgPRybdDL5cANU60J9emn604PEOiLnHanjQEkIDu6TZHk2VdNFuC5R_zj
    lAs3KjuoZ-xQyGv-6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:NT74YnaDqAh_P6KLFVyy4-bIPrdzZ5Kc_MGczh5Hh3yN8iNcBwto1A>
    <xmx:NT74YmVph98S5iZP_YC4H6tgnlo4-q4LKU1uLPu504nnTRHaRE5SFg>
    <xmx:NT74YlliuNAHJR6ez2bCiLSAJJ6LUxiAk72BWkQy-ulVhK-IGtwMPg>
    <xmx:Nj74YrV7kkkgoHjz_hiPQrKXoT3bVnrUflagxwxMlVJnQQQdKldi4A>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D744031A0062; Sat, 13 Aug 2022 20:13:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
In-Reply-To: <20220813223825.3164861-6-ashok.raj@intel.com>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
Date:   Sat, 13 Aug 2022 17:13:13 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Raj Ashok" <ashok.raj@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Aug 13, 2022, at 3:38 PM, Ashok Raj wrote:
> Microcode updates need a guarantee that the thread sibling that is waiting
> for the update to finish on the primary core will not execute any
> instructions until the update is complete. This is required to guarantee
> any MSR or instruction that's being patched will be executed before the
> update is complete.
>
> After the stop_machine() rendezvous, an NMI handler is registered. If an
> NMI were to happen while the microcode update is not complete, the
> secondary thread will spin until the ucode update state is cleared.
>
> Couple of choices discussed are:
>
> 1. Rendezvous inside the NMI handler, and also perform the update from
>    within the handler. This seemed too risky and might cause instability
>    with the races that we would need to solve. This would be a difficult
>    choice.

I prefer choice 1.  As I understand it, Xen has done this for a while to good effect.

If I were implementing this, I would rendezvous via stop_machine as usual.  Then I would set a flag or install a handler indicating that we are doing a microcode update, send NMI-to-self, and rendezvous in the NMI handler and do the update.

> 2. Thomas (tglx) suggested that we could look into masking all the LVT
>    originating NMI's. Such as LINT1, Perf control LVT entries and such.
>    Since we are in the rendezvous loop, we don't need to worry about any
>    NMI IPI's generated by the OS.
>
>    The one we didn't have any control over is the ACPI mechanism of sending
>    notifications to kernel for Firmware First Processing (FFM). Apparently
>    it seems there is a PCH register that BIOS in SMI would write to
>    generate such an interrupt (ACPI GHES).
> 3. This is a simpler option. OS registers an NMI handler and doesn't do any
>    NMI rendezvous dance. But if an NMI were to happen, we check if any of
>    the CPUs thread siblings have an update in progress. Only those CPUs
>    would take an NMI. The thread performing the wrmsr() will only take an
>    NMI after the completion of the wrmsr 0x79 flow.
>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 88 +++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/microcode/core.c 
> b/arch/x86/kernel/cpu/microcode/core.c
> index d24e1c754c27..ec10fa2db8b1 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -40,6 +40,7 @@
>  #include <asm/cmdline.h>
>  #include <asm/setup.h>
>  #include <asm/mce.h>
> +#include <asm/nmi.h>
> 
>  #define DRIVER_VERSION	"2.2"
> 
> @@ -411,6 +412,10 @@ static int check_online_cpus(void)
> 
>  static atomic_t late_cpus_in;
>  static atomic_t late_cpus_out;
> +static atomic_t nmi_cpus;
> +static atomic_t nmi_timeouts;
> +
> +static struct cpumask cpus_in_wait;
> 
>  static int __wait_for_cpus(atomic_t *t, long long timeout)
>  {
> @@ -433,6 +438,53 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
>  	return 0;
>  }
> 
> +static int ucode_nmi_cb(unsigned int val, struct pt_regs *regs)
> +{
> +	int cpu = smp_processor_id();
> +	int timeout = 100 * NSEC_PER_USEC;
> +
> +	atomic_inc(&nmi_cpus);
> +	if (!cpumask_test_cpu(cpu, &cpus_in_wait))
> +		return NMI_DONE;
> +
> +	while (timeout < NSEC_PER_USEC) {
> +		if (timeout < NSEC_PER_USEC) {
> +			atomic_inc(&nmi_timeouts);
> +			break;
> +		}
> +		ndelay(SPINUNIT);
> +		timeout -= SPINUNIT;
> +		touch_nmi_watchdog();
> +		if (!cpumask_test_cpu(cpu, &cpus_in_wait))
> +			break;
> +	}
> +	return NMI_HANDLED;
> +}
> +
> +static void set_nmi_cpus(struct cpumask *wait_mask)
> +{
> +	int first_cpu, wait_cpu, cpu = smp_processor_id();
> +
> +	first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
> +	for_each_cpu(wait_cpu, topology_sibling_cpumask(cpu)) {
> +		if (wait_cpu == first_cpu)
> +			continue;
> +		cpumask_set_cpu(wait_cpu, wait_mask);
> +	}
> +}
> +
> +static void clear_nmi_cpus(struct cpumask *wait_mask)
> +{
> +	int first_cpu, wait_cpu, cpu = smp_processor_id();
> +
> +	first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
> +	for_each_cpu(wait_cpu, topology_sibling_cpumask(cpu)) {
> +		if (wait_cpu == first_cpu)
> +			continue;
> +		cpumask_clear_cpu(wait_cpu, wait_mask);
> +	}
> +}
> +
>  /*
>   * Returns:
>   * < 0 - on error
> @@ -440,7 +492,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
>   */
>  static int __reload_late(void *info)
>  {
> -	int cpu = smp_processor_id();
> +	int first_cpu, cpu = smp_processor_id();
>  	enum ucode_state err;
>  	int ret = 0;
> 
> @@ -459,6 +511,7 @@ static int __reload_late(void *info)
>  	 * the platform is taken to reset predictively.
>  	 */
>  	mce_set_mcip();
> +
>  	/*
>  	 * On an SMT system, it suffices to load the microcode on one sibling of
>  	 * the core because the microcode engine is shared between the threads.
> @@ -466,9 +519,17 @@ static int __reload_late(void *info)
>  	 * loading attempts happen on multiple threads of an SMT core. See
>  	 * below.
>  	 */
> +	first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
> 
> -	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
> +	/*
> +	 * Set the CPUs that we should hold in NMI until the primary has
> +	 * completed the microcode update.
> +	 */
> +	if (first_cpu == cpu) {
> +		set_nmi_cpus(&cpus_in_wait);
>  		apply_microcode_local(&err);
> +		clear_nmi_cpus(&cpus_in_wait);
> +	}
>  	else
>  		goto wait_for_siblings;
> 
> @@ -502,20 +563,41 @@ static int __reload_late(void *info)
>   */
>  static int microcode_reload_late(void)
>  {
> -	int ret;
> +	int ret = 0;
> 
>  	pr_err("Attempting late microcode loading - it is dangerous and 
> taints the kernel.\n");
>  	pr_err("You should switch to early loading, if possible.\n");
> 
>  	atomic_set(&late_cpus_in,  0);
>  	atomic_set(&late_cpus_out, 0);
> +	atomic_set(&nmi_cpus, 0);
> +	atomic_set(&nmi_timeouts, 0);
> +	cpumask_clear(&cpus_in_wait);
> +
> +	ret = register_nmi_handler(NMI_LOCAL, ucode_nmi_cb, NMI_FLAG_FIRST,
> +				   "ucode_nmi");
> +	if (ret) {
> +		pr_err("Unable to register NMI handler\n");
> +		goto done;
> +	}
> 
>  	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
>  	if (ret == 0)
>  		microcode_check();
> 
> +	unregister_nmi_handler(NMI_LOCAL, "ucode_nmi");
> +
> +	if (atomic_read(&nmi_cpus))
> +		pr_info("%d CPUs entered NMI while microcode update"
> +			"in progress\n", atomic_read(&nmi_cpus));
> +
> +	if (atomic_read(&nmi_timeouts))
> +		pr_err("Some CPUs [%d] entered NMI and timedout waiting for its"
> +		       " mask to be cleared\n", atomic_read(&nmi_timeouts));
> +
>  	pr_info("Reload completed, microcode revision: 0x%x\n", 
> boot_cpu_data.microcode);
> 
> +done:
>  	return ret;
>  }
> 
> -- 
> 2.32.0
