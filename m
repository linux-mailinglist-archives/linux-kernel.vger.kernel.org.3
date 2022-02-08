Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC04AD452
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbiBHJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiBHJGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:06:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0177C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:06:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w20so4056658plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OS1U64O372XeRGN7+KBDv0OHFk8nFr6YHJks9Kr/ihg=;
        b=HtdXbOCUg+HSsiuOkaq3T6bEHZAuekerbf1UYs4fh1Y2XA4UXkwzzOvzh0nzj2icwd
         oHvXRxf6XI+TSN8nwA5mhmEG5oh1VOs/u1cr759BYxSiPftdRI5NMVhTSiIHI9z8Dzzr
         VtIM0J1cdB8vrPTF38pY0Jjwf96L9URnyQQC6ffPEuUsGuorawD8WmAPapQ//H4ZITfM
         OIsSbW7qjfrXmpKyAwiDNGYdEcChX6umpDYwEe9SHYk1pG1z9oQmu/uFyzWmhz8isztH
         Dq19YJeKer0d/yuy5G5V5j4jrBTj8+3ssoD7VGjrKL5UV3oBgaFuFqU3FB0NKg6Cnrh7
         Hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OS1U64O372XeRGN7+KBDv0OHFk8nFr6YHJks9Kr/ihg=;
        b=1IRmFPpMflfZtrdfZt+VPZ/JbXrN46X8nkTtlCv5xEf4fYeKuLq28bCkFYJf7jAjqr
         UdfUab00OePwRfHXLwNajq+kKHPdxvx4vzzLZEPPGlIxSkcLuyFMYndTunWUBsKqYkBE
         IxJRTIxvlHx/2TBbMNqZkXUMTJYd0TvBE8YADCnaTX7t9Eify0SxFikFR6XapiE0ATgf
         lh4QyHDJbFPVWG0vQ3nEw0q3JChzYaroDQxdl90mNQ6Wf+VY2IlRNVlqAiRVtzF9nrAI
         OVVrTpyY8pjxxraHuFES5TJEOr3ym4upd6bJhT2ZsiHd//F8o/HexDpe2YZ/voYDq3sY
         rwUw==
X-Gm-Message-State: AOAM531Ooez+7Uq75/FmTfcWKiB/qL7rzMKUaoH7OuHEWDz5OnSwmgKD
        gW22nbtOrdUOBnnD8KvINjM=
X-Google-Smtp-Source: ABdhPJx8nGnpWJy6cpl6+GbES17K6q4o6YsJkuWz36cnPcIrpMH2rMm1ZdDHYR94Xt253EJa+PjCCA==
X-Received: by 2002:a17:903:304b:: with SMTP id u11mr3430560pla.140.1644311174063;
        Tue, 08 Feb 2022 01:06:14 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id z7sm15084815pfe.49.2022.02.08.01.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:06:13 -0800 (PST)
Message-ID: <f3a9ccd2-bd6c-691a-f6c2-43fb549b3d4b@gmail.com>
Date:   Tue, 8 Feb 2022 17:06:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/cpufeatures: Move the definition of X86_FEATURE_AMX_*
 to the word 18
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Jim Mattson <jmattson@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jing Liu <jing2.liu@intel.com>, linux-kernel@vger.kernel.org,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220117062344.58862-1-likexu@tencent.com>
 <8b274c5f-6b68-aed9-117d-f89249e57e18@intel.com>
 <47362220-30d5-c513-a2aa-61187ee91c41@redhat.com>
 <bc272301-af11-621a-3bda-ee398754fd0a@gmail.com> <YfVM+xdDS76E3d6r@zn.tnic>
 <1105cf7d-0d61-3ae2-f372-3b1f80c08c60@gmail.com> <YgIvCIEeWK0wnq8M@zn.tnic>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <YgIvCIEeWK0wnq8M@zn.tnic>
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

On 8/2/2022 4:51 pm, Borislav Petkov wrote:
> On Tue, Feb 08, 2022 at 04:08:17PM +0800, Like Xu wrote:
>> Emm, are you willing to make "test-apply.sh" public (or have done) and let
>> others benefit ?
> 
> It is nothing special - just a simple script which does first
> 
> patch -p1 --dry-run -l -i [patch file]
> 
> to see whether it would even apply.
> 
>> Sorry for the late reply, and here's a new version from git-send-email:
> 
> Yeah, someone already took care of this:
> 
> https://git.kernel.org/tip/ae75fa54228162ecd65341f9780886f21f557cc4
> 

Uh, it's Jim and we have worked together on many KVM issues.

BTW, I'm not sure why we prefer:

#define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */

rather than:

+#define X86_FEATURE_AMX_BF16        (18*32+22) /* AMX bf16 Support */
  #define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE        (18*32+24) /* AMX tile Support */
+#define X86_FEATURE_AMX_INT8        (18*32+25) /* AMX int8 Support */

It would make more sense to put them in order, what do you think? Need v3 to 
sort it ?

Thanks,
Like Xu
