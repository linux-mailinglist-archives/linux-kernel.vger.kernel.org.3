Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC84D2E56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiCILnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiCILn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:43:28 -0500
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 8D055171EC0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:42:26 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=michaelkloos.com; q=dns/txt;
 s=k1; t=1646826147; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: From: From: References: Cc: To: To: Subject: Subject:
 MIME-Version: Date: Message-ID: Sender: Sender;
 bh=v8crHnu6Y+qNUrAz/zeSAvUoD0V1jbcWRdakFVXkW6c=; b=UvQVXJl1m0HAU3Exa9aZnGaPWn27ooStKW5L6/kmyUVfazeNUBb4tCik43zfy8cPGcelTgYH
 aKa2n4vQLVawXqkBsVVaMjS9Bi8PcdDvgl+bJYWSHTh5f+999eACKFhQIaO2/iODK9kDq0T4
 AasJhBNH+ZlbFANUQD38dDkptYY=
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI5NjYzNiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjQ4Y2MwIl0=
Received: from drop1.michaelkloos.com (drop1.michaelkloos.com
 [67.205.190.89]) by smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 622892992f1b1e8f79b09f87 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 09 Mar 2022 11:42:17 GMT
Sender: michael@michaelkloos.com
Received: from [192.168.1.236] (cpe-173-88-115-50.columbus.res.rr.com [173.88.115.50])
        by drop1.michaelkloos.com (Postfix) with ESMTPSA id 8A4EB40176;
        Wed,  9 Mar 2022 11:42:16 +0000 (UTC)
Message-ID: <e936de26-95b7-1eed-008e-8d025b638265@michaelkloos.com>
Date:   Wed, 9 Mar 2022 06:43:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] riscv: Work to remove kernel dependence on the
 M-extension
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220309052842.247031-1-michael@michaelkloos.com>
 <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
From:   "Michael T. Kloos" <michael@michaelkloos.com>
In-Reply-To: <CAK8P3a2Mr_z6h7eg1O8ZN5_qE-o+8KFFBum3CxyuDYeF50s1dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feedback.  I don't really have much of an
opinion about that right now aside from that I know where things
are in the current structure and am comfortable.  My goal with this
contribution was to keep it in-line with the current config
structure.  Hence, I put it right next to the menuconfig option
to control CONFIG_RISCV_ISA_C under Platform Type.

I wouldn't necessarily be opposed to rethinking the way platform
feature selection is presented in menuconfig.  If people feel that
most users will be looking for an rv64gc config and that it should
be made for clear, perhaps it could be done.  I would need to do
more thinking about how exactly that would look.

I do think that it is outside the scope of this patch.  Were you
working on something like that and worried about a merge conflict?

	Michael

On 3/9/22 05:02, Arnd Bergmann wrote:

> On Wed, Mar 9, 2022 at 6:28 AM Michael T. Kloos
> <michael@michaelkloos.com> wrote:
>> Added a new config symbol RISCV_ISA_M to enable the usage of the
>> multiplication, division, and remainder (modulus) instructions
>> from the M-extension.  This configures the march build flag to
>> either include or omit it.
>>
>> I didn't find any assembly using any of the instructions from
>> the M-extension.  However, the BPF JIT is a complicating factor.
>> Currently, it emits M-extension instructions to implement various
>> BPF operations.  For now, I have made HAVE_EBPF_JIT depend on
>> CONFIG_RISCV_ISA_M.
>>
>> I have added the supplementary integer arithmetic functions in
>> the file "arch/riscv/lib/ext_m_supplement.c".  All the code
>> contained in this file is wrapped in an ifndef contingent on the
>> presence of CONFIG_RISCV_ISA_M.
>>
>> Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>
> The patch looks fine to me, but I increasingly get the feeling that the
> entire platform feature selection in Kconfig should be guarded with
> a global flag that switches between "fully generic" and "fully custom"
> builds, where the generic kernel assumes that all the standard
> features (64-bit, C, M, FPU, MMU, UEFI, ...) are present, the
> incompatible options (XIP, PHYS_RAM_BASE_FIXED,
> CMDLINE_FORCE, BUILTIN_DTB, ...) are force-disabled,
> and all optional features (V/B/P/H extensions, custom instructions,
> platform specific device drivers, ...) are runtime detected.
>
> At the moment, those three types are listed at the same level,
> which gives the impression that they can be freely mixed.
>
>           Arnd
