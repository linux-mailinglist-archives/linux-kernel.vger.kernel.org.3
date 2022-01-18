Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B49492C14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbiARRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346933AbiARRPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642526134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGgVMFp2VtgX9CS88lYiEKy1GarUr4t4M/Z368/eDbo=;
        b=IjlIKzapC70wtf4rIMXE1znyhmn09+qRx/+QtYuPTmgEMTOrDDbJzS+bMpe72v0gImsUkE
        0covqwgUU3K25FOuxqpokyubC+2ztxbRd6Cv9o4k/tyrQnyvQCqMCwPBcxm9x7syhJTdMF
        9uh5hXrZyIuHYtkkyS6P6y6lqseI480=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-gUyxbgn2NWajxGtlwLdqUQ-1; Tue, 18 Jan 2022 12:15:33 -0500
X-MC-Unique: gUyxbgn2NWajxGtlwLdqUQ-1
Received: by mail-ed1-f70.google.com with SMTP id c11-20020a056402120b00b0040321cea9d4so4524485edw.23
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iGgVMFp2VtgX9CS88lYiEKy1GarUr4t4M/Z368/eDbo=;
        b=yRGGypslE1RO6TiejlrC/J3ustYchpCB2/nwkeIbPVQLZTCsOUJGqG7NzuaUWWxigX
         1oJ4JlSoZdOgH8WbOvq9xLzPExT9bcBlRplia8Ube4MnA+Rfx2yCswKu8l821lpvS4Xm
         v6Fw5vsuy3r52Bo9QrouLAUuOMFVB9KFtFzIDxz82PifvpuQaXAIZ31UFWRobZJXcfz2
         AzyNHbrYQfKJO1fHekx57CT5IHjES/0CDTjVQ6RR2Sa0TX6zEs+0vzwATzikhKMK0GMD
         p7XINcD/vAz5NxA2AxM2+S6dzhbUH0QyDhFUj+B7gIO3sXXmrXsDPbPXCM540iuM23UI
         4IEA==
X-Gm-Message-State: AOAM532Ulk8v9kpl6n6AcHm3FjpBKpDORyWpzThJC9GELj74LITZD3lT
        lzgd5uFM6bJ4+u5r7lrksfQTQoFxK0Bfzm9Od4Slx93fpYq1LogTSo+XfSXo4zT44VmknpPCO6+
        ykiS3xIbXfQYAPlz55BTVkD4/
X-Received: by 2002:aa7:d305:: with SMTP id p5mr26831862edq.201.1642526131038;
        Tue, 18 Jan 2022 09:15:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycTPPIdf1+7tCR0aAgWJHCAhex7oAJuH3u6iRzlYO/0+UQMelr2ZdalDlZRoTOYRL+M7yrUg==
X-Received: by 2002:aa7:d305:: with SMTP id p5mr26831837edq.201.1642526130798;
        Tue, 18 Jan 2022 09:15:30 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id sd4sm2337798ejb.33.2022.01.18.09.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:15:30 -0800 (PST)
Message-ID: <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
Date:   Tue, 18 Jan 2022 18:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 18:11, Dave Hansen wrote:
> What tree is this against?  I see BF16 and INT8 in some old versions of
> Chang's patches, but not current kernels.  All I see right now in
> tip/master is:
> 
>> #define X86_FEATURE_AMX_TILE            (18*32+24) /* AMX tile ...
> 
> It's still in the wrong spot, but the other two features aren't there.

It was added for the KVM side of AMX (commit 690a757d610e, "kvm: x86: 
Add CPUID support for Intel AMX") and is in Linus's tree.

Paolo


>> We have defined the word 18 for Intel-defined CPU features from CPUID level> 0x00000007:0 (EDX). Let's move the definitions of X86_FEATURE_AMX_* to
> the> right entry to prevent misinterpretation. No functional change
> intended.
> Please, no "we's" in changelogs.  Don't say, "let's move".  Just say:
> "Move..."
> 
> The subject could probably also be trimmed a bit.  Perhaps:
> 
> 	x86/cpu: Move AMX CPU feature defines to correct word location
> 
> 

