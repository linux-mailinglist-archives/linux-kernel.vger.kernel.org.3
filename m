Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCFE522A29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiEKDGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiEKDGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:06:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF411289B3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:05:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so864316pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zeXQEtR41vW8oV0uB8lf+EcTnJUokpOmF2JIIH/qaxo=;
        b=MQ8A09vGXiI6pmL3YaUyeC5Oqv1jMNQWEZ8p2FpvrjTyzhUK2OhV196QHRtaU9G1Z8
         6vcc6nMoCKaCDu+yGcqz1uEFPpi2sFW9cEuy7seO2OtcoXI2GWopNAsnDWk2330MWATX
         tKmnG9iUTpFc5bbNu/Zo+puitiblgj1awr/jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zeXQEtR41vW8oV0uB8lf+EcTnJUokpOmF2JIIH/qaxo=;
        b=MKtvuMt/W1/8Q+ZKsSRJQ4Yttf8orkjdpwDj5qVjJ1YraEwpGGcFG2vmUz24fLhxId
         bAXYT7umH7Azg14GvpJxTypQvoK1eb/aHoRV/ewZ4lu3PANMTlirTge1oWvxvFcyUtLA
         sgBvdRCWxO5XwN/ieXi4YuXLWVzZ4EeQ+n8gNCcdTpfYaSI6IEK0DicAfazEkp7G/iP2
         wx2ioyMi8HHNw9ACCpuwJV4R0TegGSbvlBcJE5BVqnhscHnuBPkgFJzQQlyspxUtBv4s
         raE73rj60kReDqyF7wW1NbFmrKzAYL3bico2vJbXFfHLgv+7HQIMxRsSYYvmiGCZFXZD
         Geug==
X-Gm-Message-State: AOAM531fQeuPIa1mQSG3PvhfIgkWAqBekJXR5Iilq49ZnvduE7LepDrG
        sKvXbbc5cO3dxNRIaQAwlmVq3g==
X-Google-Smtp-Source: ABdhPJxLwv6ESDyVK2tUjxF2N76LlATJd4VPEY3UK/13lQBjg60uUZ5/EhmzInRXXzPNiEDUhotLmQ==
X-Received: by 2002:a17:903:230e:b0:15e:d0a1:922f with SMTP id d14-20020a170903230e00b0015ed0a1922fmr23587196plh.75.1652238359188;
        Tue, 10 May 2022 20:05:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0015e8d4eb201sm372188plp.75.2022.05.10.20.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:05:58 -0700 (PDT)
Date:   Tue, 10 May 2022 20:05:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 05/13] stackleak: clarify variable names
Message-ID: <202205102001.7EB50CBE18@keescook>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-6-mark.rutland@arm.com>
 <e1cf0177-40a0-ffca-6be4-57fd97860c4a@linux.com>
 <YnpiPWYqkA7RW3lm@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnpiPWYqkA7RW3lm@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:01:49PM +0100, Mark Rutland wrote:
> On Sun, May 08, 2022 at 11:49:46PM +0300, Alexander Popov wrote:
> > On 27.04.2022 20:31, Mark Rutland wrote:
> > > The logic within __stackleak_erase() can be a little hard to follow, as
> > > `boundary` switches from being the low bound to the high bound mid way
> > > through the function, and `kstack_ptr` is used to represent the start of
> > > the region to erase while `boundary` represents the end of the region to
> > > erase.
> > > 
> > > Make this a little clearer by consistently using clearer variable names.
> > > The `boundary` variable is removed, the bounds of the region to erase
> > > are described by `erase_low` and `erase_high`, and bounds of the task
> > > stack are described by `task_stack_low` and `task_stck_high`.
> > 
> > A typo here in `task_stck_high`.
> 
> Ah; whoops.

No worries; I fixed this when I took the patch.

> > That was also the main reason why I reused the 'boundary' variable: I wanted
> > the compiler to allocate it in the register and I avoided creating many
> > local variables.
> >
> > Mark, did your refactoring make the compiler allocate local variables on the
> > stack instead of the registers?
> 
> Considering the whole series, testing with GCC 11.1.0:
> 
> * On arm64:
>      before: stackleak_erase() uses 48 bytes of stack
>      after: stackleak_erase() uses 0 bytes of stack
> 
>      Note: this is entirely due to patch 1; arm64 has enough GPRs that it
>      doesn't need to use the stack.
> 
> * On x86_64:
>      before: stackleak_erase() uses 0 bytes of stack
>      after:  stackleak_erase() uses 0 bytes of stack
> 
> * On i386
>      before: stackleak_erase() uses 8 bytes of stach
>      after:  stackleak_erase() uses 16 bytes of stack
> 
> The i386 case isn't ideal, but given that those bytes will easily be used by
> the entry triage code before getting to any syscall handling, I don't believe
> that's an issue in practice.

I am biased and totally fine with choosing a solution where 64-bit
improvement comes at a 32-bit cost.

-- 
Kees Cook
