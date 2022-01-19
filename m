Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547444933B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbiASDln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiASDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:41:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCA0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 19:41:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 133so1177054pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 19:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:organization:subject:in-reply-to
         :content-transfer-encoding;
        bh=/bWqJUussT3Xs8QfVz1+9lMk3At00DsNde7QXXoXrDA=;
        b=TXlb+JPE3CWZUR80jGpbDKiC6pGl2lupaK+4/wB7dqEyuNKWN8BvgHwt3YGIe8DFqa
         tVYTPAO3VQoY14ETF8lwTx6ClHMI5eXPc0jT5jrm+k9d3qxQdRprAV4GJMSp/QFzg/Uj
         0dMSWt3aHSZ78rZUxyUuo5QgCmXeW+ixd4gkpwt5Txx+dosXECmmyid4Esb/15lCsdTx
         a4VHf1yWcPB7JcV42iqhezbqBp7G1rV6BK+zEWilwpo6qFydOg1lBRO+OiHbi/vH5cKe
         tHpsR60KpAdQMItgCo6fSfnDpnTutXI4XsKtn5c3x+0XxNI+rz3dMKhh0kr1CNL9FF4w
         RpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/bWqJUussT3Xs8QfVz1+9lMk3At00DsNde7QXXoXrDA=;
        b=kSZ2z9SfmAOZ/zz4DzdpKdp4K/PPoyQe8PXMx0dib/6rA0iHWgjoQCUMdUpY8re7IA
         rCXbOS8GgYzJlp82jZa6OB5xvUHH2flmrb1/sogotmnzTtD5U/ahgm9ANGjLodpswqcK
         UZbeNlhxNmFogP93ncUc4JNz/uIykVWenWa9dfplMNPD4eONWz0M+D2t5C2sb8ivmN9N
         nrXWkaJTZKLRR4lL5UuT8G+1vHvfDkoSVqWHFx8OmJdiUNEknlpD4t6Erz09WGUo7sBC
         qykX14XOPAXDmRDonrJk8n0G/vI51y4o9MJN+ZahDkCNEeE+9+Por6bm2GBvGyX1gysf
         clTQ==
X-Gm-Message-State: AOAM532XM2q3ZfVW1E9B75vn+Yxfr2YRX+3MPK98SL104lW8a+6YogVd
        e7/JIhGpEUSAhYHp2DpK+bw=
X-Google-Smtp-Source: ABdhPJzsW0weChLSUSCz+HXn016DE1MvURREdhIrOtLEAJlDnUZm3fbbf25zsRCNOy0/p2hDkpyRkw==
X-Received: by 2002:a63:1562:: with SMTP id 34mr9793397pgv.15.1642563701478;
        Tue, 18 Jan 2022 19:41:41 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id h26sm18252554pfn.213.2022.01.18.19.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 19:41:41 -0800 (PST)
Message-ID: <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com>
Date:   Wed, 19 Jan 2022 11:41:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
 <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
In-Reply-To: <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/1/2022 1:15 am, Paolo Bonzini wrote:
> On 1/18/22 18:11, Dave Hansen wrote:
>> What tree is this against?  I see BF16 and INT8 in some old versions of
>> Chang's patches, but not current kernels.  All I see right now in
>> tip/master is:
>>
>>> #define X86_FEATURE_AMX_TILE            (18*32+24) /* AMX tile ...
>>
>> It's still in the wrong spot, but the other two features aren't there.
> 
> It was added for the KVM side of AMX (commit 690a757d610e, "kvm: x86: Add CPUID 
> support for Intel AMX") and is in Linus's tree.
> 
> Paolo
> 
> 
>>> We have defined the word 18 for Intel-defined CPU features from CPUID level> 
>>> 0x00000007:0 (EDX). Let's move the definitions of X86_FEATURE_AMX_* to
>> the> right entry to prevent misinterpretation. No functional change
>> intended.
>> Please, no "we's" in changelogs.  Don't say, "let's move".  Just say:
>> "Move..." >>
>> The subject could probably also be trimmed a bit.  Perhaps:
>>
>>     x86/cpu: Move AMX CPU feature defines to correct word location
>>
>>
> 

Thanks Dave and Paolo.  Just for your convenience:

 From 588c2221999c1f5860188a7cbaeb0d4f80c6d727 Mon Sep 17 00:00:00 2001
From: Like Xu <likexu@tencent.com>
Date: Mon, 17 Jan 2022 14:23:44 +0800
Subject: [PATCH v2] x86/cpufeatures: Move AMX CPU feature defines to correct
  word location

From: Like Xu <likexu@tencent.com>

The word 18 for Intel-defined CPU features from CPUID level 0x00000007:0 (EDX)
has been defined in the same file. Move the definitions of X86_FEATURE_AMX_* to
the right entry to prevent misinterpretation. No functional change intended.

Signed-off-by: Like Xu <likexu@tencent.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
v1 -> v2 Changelog:
- Refine the commit message and subject; (Dave)

  arch/x86/include/asm/cpufeatures.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6db4e2932b3d..5cd22090e53d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -299,9 +299,6 @@
  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
-#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
-#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */

  /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
  #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
@@ -390,7 +387,10 @@
  #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
  #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
  #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + 
IBPB) */
  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect 
Branch Predictors */
  #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-- 
2.33.1


