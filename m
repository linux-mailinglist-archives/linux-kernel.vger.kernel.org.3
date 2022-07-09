Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918B256CBA0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiGIVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:45:48 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A98101CC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:45:46 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 269LjU0T2266948
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 9 Jul 2022 14:45:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 269LjU0T2266948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1657403131;
        bh=aXOKja45dVtca40iHk9WQuXR+H/NtJR+jgzp7l5Qntk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qdL7SHdLKcelbFK201Bs60r2segRQXhbe77S19iNy4XtjTlIutqgRL0vVbF/QKfjZ
         +mFfsQTbamN+IwI3nmXVeN4N3el27XDUb2yatMdVOPCuqe+ftHsTXa77hmh0VcHo2e
         J3ZgIJ0mUtmyhHf3rapSAtxMCzxNCVFB8kl4jx9AHZEeH+S+1D/ZWolQ+TCB119vqa
         cPT3iueZx245DmnbpKDenLzgMZfnb4iXPTg81SFYWJAyYrJO8DC2vzhI8S23kJmGzI
         Nl4YwM4vPhSKxq6Sb6ZgL2bqQdxsi+J+YFFVwe6QNfUdogcnh5MfQ8jSc8BjTVj9gM
         2vuRnV6rn32uQ==
Message-ID: <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com>
Date:   Sat, 9 Jul 2022 14:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com> <YslPKbrmwF0uSm7p@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <YslPKbrmwF0uSm7p@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 02:49, Borislav Petkov wrote:
> On Fri, Jul 08, 2022 at 06:51:16PM -0700, H. Peter Anvin wrote:
>> #define SETUP_ENUM_MAX	SETUP_RNG_SEED
>> #define SETUP_INDIRECT	(1<<31)
>> #define SETUP_TYPE_MAX	(SETUP_ENUM_MAX | SETUP_INDIRECT)
> 
> Wait, if we get to add a new number, SETUP_ENUM_MAX and thus
> SETUP_TYPE_MAX will change. And they're uapi too...

Talking API here rather than ABI, i.e. the semantics of those symbols.

	-hpa

