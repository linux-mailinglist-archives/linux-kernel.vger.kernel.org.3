Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA63F5AEF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiIFPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbiIFPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:39:09 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07B2A248
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:49:39 -0700 (PDT)
Message-ID: <d30c98c9-b0bb-2b99-c4f0-94b3e46040d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662475777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vKfDObdG6YvwMUOT+NGjuSPIDBSl/+OGS7uJUe/yCJk=;
        b=PEAC/pxfxBmpiaTHnan+GUhay2drgZlqqkDzgylZ3lENzn4GyiZvEHFR0iz5TRFv9XOiyd
        0ysPyzxJtUH3TBTKKcD0W6w4QpP2uy2EfS8ANfvV7HVJBcfp0a7bHnYSXz+J6ULQvJgB41
        QuC5uE6V6ED89VHNOZFqgOjUVfdJQYU=
Date:   Tue, 6 Sep 2022 17:49:35 +0300
MIME-Version: 1.0
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
Content-Language: en-US
To:     Nick Kossifidis <mick@ics.forth.gr>,
        Yixun Lan <yixun.lan@gmail.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>,
        Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr>
 <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
 <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
 <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
In-Reply-To: <75409de5-2351-3ab2-5162-33ebd8d30749@ics.forth.gr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 15:23, Nick Kossifidis wrote:
> On 7/2/22 14:35, Yixun Lan wrote:
>> I'd also like to try kexec on unmatched board, and encounter the same error
>> as Alexandre Ghiti reported, generally I'm using almost same cmdline
> 
> The kernel-side patches have already been merged upstream, for
> kexec-tools there are some people working on fixes, I'm expecting
> pull requests on the github before I do a pull request upstream. You
> should be able to use kexec without initrd.

Dear Nick, Yuxun,
first of all thank you very much for your great work.
Could you please clarify about state of makedumpfile on RISC-V?

Thank you,
	Vasily Averin
