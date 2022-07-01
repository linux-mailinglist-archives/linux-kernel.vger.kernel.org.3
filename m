Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3225635AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiGAOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGAOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:34:33 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E4904C8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:30:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p128so2452908iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=9cF5IqYxYj2InYMRmfggjddnYppc9EzlqbpJtswCFOc=;
        b=HODcUQLIo0DHm2SWxvgselcLa4dqArEO92qCD/gdLMJVimUVw0vou6BSTzhmjWwMYF
         1E+buAnE4rtwp0FAJX85qZ+3o2LqSI6tChHU9pxyTtzYtmhBpSp7owpv82dDVMtUeoYZ
         sta4ytKhLwiQHRKRr4g0NyOUcuF6AebROFB/JemgbaMZ7IxhFV0eoXHhscnThyXgxm7u
         eWXLEO4OiZIpuOIFJxbs1xuVlE15lZ1DdPobHLI+vafxbu0XsqKQjOZLH7Nl5FIyDwD6
         DvjVXFKvIJpLg/tYtsORHUsApO76DV7qn3AJuU1/7gtrOOQLACHhxYvOhUOXCKWBZtJn
         FOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=9cF5IqYxYj2InYMRmfggjddnYppc9EzlqbpJtswCFOc=;
        b=QqqbKIlqPxvkWQgEj0Xr6Z9NTHye9xt6GKgLrAjxq6wp9orWMvGQhOITKtPOh7htPu
         L/eyW4mtPkpd0U5Ryc5pg3J4ZB3mwx8g69OTP7y/asT1xdxGT6gYpb7bjujUXSw5a1UG
         BfxMxHaSbDTU6kXi74o1GWQjekg6XTT3KiV2QPq5KGXvqniEZM0qqPtB5xzCUKYvvxkd
         ZXctoIl/NvirX3d5URXHPWvwlVI63YJblCHslghNVbUWtVyZvSMTlsF/B4TYFQECIpG3
         5BSb9Xcf1HkjWd/FRtm3e1G6PPmTjpUyKCotDlzm8DlH9pk3ZzOmN50jqq+aYb6drTsg
         Jknw==
X-Gm-Message-State: AJIora+4aDH2sAZ4Tgfe1GoSLIxEpGgkY/czEYm0JN1mb6fp1IO7QbsA
        aCybxAlLpDlin4GhpJ2r0Dq5PYwPXJSaPg==
X-Google-Smtp-Source: AGRyM1sRv34EaaWYc7DQ/cybSSP4tt+pHpLB0OquCLm3mDR/BmnZSy7nB06i+Pl5+EtSLGZ2Xxh7qA==
X-Received: by 2002:a05:6638:d86:b0:33c:cb7f:4ecc with SMTP id l6-20020a0566380d8600b0033ccb7f4eccmr8907108jaj.28.1656685799208;
        Fri, 01 Jul 2022 07:29:59 -0700 (PDT)
Received: from ArchLinux ([240e:390:a20:ece0:3ad5:47ff:feb5:73b2])
        by smtp.gmail.com with ESMTPSA id b15-20020a056602218f00b00669b2ffad32sm10288981iob.54.2022.07.01.07.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:29:58 -0700 (PDT)
References: <20220630161220.53449-1-schspa@gmail.com>
 <87mtdu15ok.wl-maz@kernel.org> <m2bkua148a.fsf@gmail.com>
 <a5ca4db3db9ef101258cab94d6b7e045@kernel.org> <m2sfnlvwup.fsf@gmail.com>
 <87letd0wqm.wl-maz@kernel.org>
User-agent: mu4e 1.7.5; emacs 28.1
From:   Schspa Shi <schspa@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix 64 bit mmio handle
Date:   Fri, 01 Jul 2022 22:22:51 +0800
In-reply-to: <87letd0wqm.wl-maz@kernel.org>
Message-ID: <m2h740zz1i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

>> 
>> I have running some static code analysis software upon Kernel 
>> code.
>> Seeing there is possible overflow.
>> 
>> maks << 1U << ((len * 8) -1);
>> 
>> The AI don't know, len is only the value of 1, 2, 4, and make 
>> this
>> a warnings
>> 
>> I tring to analysis this, but didn't realize the real scenario 
>> of
>> sign extension, and finally sent this problematic patch.
>> 
>> I do see some uninitialized memory reads (the values are not 
>> used
>> in the end, just as temporary space for API execution),
>> do we need to fix these?
>
> You need to be more descriptive here. What uninitialised reads? 
> In
> general, pointing at the code and providing a full description 
> of what
> you think is incorrect would really help...
>
> 	M.
One example is
int vgic_v3_has_attr_regs(struct kvm_device *dev, struct 
kvm_device_attr *attr)
{
	...
    case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS: {
		u64 reg, id;

		id = (attr->attr & KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK);
		return vgic_v3_has_cpu_sysregs_attr(vcpu, 0, id, &reg);
	}

}

The funcion vgic_v3_has_cpu_sysregs_attr will read reg's value to
params without initialization. There should have no problems,
because the register value never used.

-- 
BRs
Schspa Shi
