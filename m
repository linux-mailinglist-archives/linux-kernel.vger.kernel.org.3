Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2B55F056
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiF1VbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1VbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:31:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06C3AA70
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:31:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c137so10705778qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BUVqvfGep4ieIdlYkrxicAsldFM+bbGKdttpCEmvlZ8=;
        b=OuxEFschSVbs7kzAytD0FnJI9B2m2n6CqUOfKhbNc2NuPi0F9FbcZ8Uoxdb6sa9my/
         elh8iOb6hxqsQQFkwPKAEqrGokd0m6WCObgTHG2acz6hr92X80Ak758LS/binBjK5KNK
         6JSsBCssZj0bL1pyeX5a5sJtGLiFBcG5hzekTS6XSrg8B/lkDzl6sejt3iZgZFlzi4F4
         67db7d2UBs/Lt07Xb0eXPqwxnLPmsMQcG99k7JJ/ouX5vOOUFq1FRGmFmNCVEPxR+oM8
         aWiM4a1nyITBtpRzVGHM619NSLBv6MK+e9Oo3DVrW8kZLrrBoPcUW/IzXiiKmMRoWIfz
         lITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BUVqvfGep4ieIdlYkrxicAsldFM+bbGKdttpCEmvlZ8=;
        b=BOSCPVTh9jufHvrpecsCQnm2C7t/lu7kM+fqu8tc/YtCLfqCiYWf5hkJQLKQtDZ/ld
         x9VhzWv4HV5mWZ2P3S0tvtuQ+nPJuE1j+SyEOyFIIIfN5dYgOvHb3L5lRNh4lsr69crx
         vbqOJRNLQY0n9S6agolHkohhP8Jf3iABSFTiNQMgudFveL0voNAeIrhpFoDxJBZ0kg4r
         zb+aMShOy7DFPUkO7dWsIJ79U2yxoH04Ieh25kYwx3lQz6mjP5DwLk5STAECGEbYcdP3
         WIIHuzX9jfxcBK57d3Gie4XwTU/9kav1E3KdXx4dYsWxR7H6BLNYJx4Zt+X73rTI1BH7
         mvhQ==
X-Gm-Message-State: AJIora/kKMwTKzuQdR0Ld3jzLPpCdAXKJJjSoe/rdkVdpEGNWFUQpXMG
        8XY/pQUQtpmZf6sBZPTcS6/B/Q==
X-Google-Smtp-Source: AGRyM1uIMcXscWuk1ZybPJ92/FmooikuU9AnYGGIvsOgGDpvP7rIVpKbUmSNBg20L1N4URgnoUax7w==
X-Received: by 2002:a05:620a:6008:b0:6af:5d81:870b with SMTP id dw8-20020a05620a600800b006af5d81870bmr2846130qkb.763.1656451871150;
        Tue, 28 Jun 2022 14:31:11 -0700 (PDT)
Received: from [192.168.2.14] (bras-base-stggpq3702w-grc-11-142-115-210-184.dsl.bell.ca. [142.115.210.184])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm7384273qkp.130.2022.06.28.14.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 14:31:10 -0700 (PDT)
Message-ID: <19f8897b-c445-4e66-49b2-9ceca738a263@me.ssier.org>
Date:   Tue, 28 Jun 2022 17:31:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [REGRESSION] Unable to unlock encrypted disk starting with kernel
 5.19-rc1+
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Andrew.Cooper3@citrix.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev
References: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
 <YrrHwxtD2dpts7PF@zn.tnic>
From:   Alexandre Messier <alex@me.ssier.org>
In-Reply-To: <YrrHwxtD2dpts7PF@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-28 05:20, Borislav Petkov wrote:
> On Tue, Jun 28, 2022 at 01:13:30AM -0400, Alexandre Messier wrote:
>> Please let me know if more information is needed, or if some tests are needed
>> to be run.
> 
> Yeah, pls send /proc/cpuinfo and full dmesg - privately is fine too.

Here is the cpuinfo output:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 25
model		: 80
model name	: AMD Ryzen 7 5700G with Radeon Graphics
stepping	: 0
microcode	: 0xa50000c
cpu MHz		: 3514.072
cache size	: 512 KB
physical id	: 0
siblings	: 16
core id		: 0
cpu cores	: 8
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 16
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
                  pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
                  fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
                  nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq
                  monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave
                  avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm
                  sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce
                  topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb
                  cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall
                  fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed
                  adx smap clflushopt clwb sha_ni xsaveopt xsavec xgetbv1
                  xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local
                  clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv
                  svm_lock nrip_save tsc_scale vmcb_clean flushbyasid
                  decodeassists pausefilter pfthreshold avic v_vmsave_vmload
                  vgif v_spec_ctrl umip pku ospke vaes vpclmulqdq rdpid
                  overflow_recov succor smca fsrm
bugs		: sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 7585.33
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]

And here is the dmesg output of 5.19-rc4 without the revert (taken from the
initramfs). I put it on a paste service since it is too big for email:

  https://paste.debian.net/1245491/

> 
> Also, it would be lovely if I were able to reproduce this on a machine
> here but mine doesn't have a crypto rootfs.
> 
> Perhaps you can point me to the exact instructions you're running to
> decrypt your rootfs and I can try to create a usb crypto disk and try to
> reproduce it with them...

I setup an unencrypted Debian installation on another drive to be able to run
cryptsetup commands in userspace while using rc4, and was able to see the
issue. In a up-to-date Debian Sid installation (important, more on this below),
running these commands makes it possible to reproduce the issue:

  dd if=/dev/zero bs=1M count=20 of=./test.img
  sudo cryptsetup luksFormat ./test.img
  sudo cryptsetup luksOpen ./test.img test_crypt

The "luksOpen" will fail with the same error message I get on my main system.

It seems using the latest Debian Sid is important. At first, I was trying with
Debian Bullseye, but everything was working, even unlocking my main drive.

Could it be a difference due to the cryptsetup version? Sid is using 2.4.3,
while Bullseye is based on 2.3.7. I will try to compile cryptsetup 2.4.3 and
use it in a Bullseye system with kernel 5.19-rc4, to see if the issue occurs
in that setup.

Thanks,
Alex
 
> 
> Thx.
> 

