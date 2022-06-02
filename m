Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA253B7E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiFBLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiFBLfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:35:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746887231
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6E2AB81F1A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF8BC385A5;
        Thu,  2 Jun 2022 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654169747;
        bh=4z3pP1jvTcwknOkkQ24cJlmjWlGeX3HBRp6VKpbDZPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EkN1EHDbs+yEEfCKF2aLlaN6qaEUFYa0Q0AzvNexu5JWq8zvd8YP3kC2n2G5Z1ina
         lHpdzpbg5ymzZXyqlno6+aKisy/IHsq6VPvr4TXOrLx6obDEjP0XaJo7Ow55F3e7jI
         0PMg+xZbasT0gK6k/w+rlQQYIQWIFHaG6nqlf49cM6b/PBDjUFmUqAeZ0sxsAprj0A
         6y55PdkuBKBlKx9dxKTT/5gPDUOn4an6MwFd4n77Ry9Ugp4HuswQ+6z+Oamo+oL+py
         TU8voxra5SzxhYp+kyliLYpFgKBUaY4IY6qDQpr28uxm+5SUD9cJJbkUwdZClT/8TB
         tEvX9qfuEcOjg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nwj7B-00FBXg-3M; Thu, 02 Jun 2022 12:35:45 +0100
MIME-Version: 1.0
Date:   Thu, 02 Jun 2022 12:35:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] irqchip: Adjust Kconfig for Loongson
In-Reply-To: <CAAhV-H6ZoqSty=yaAUPMg1QTamfwuYODB_mxf_o=HCJ1boawQg@mail.gmail.com>
References: <20220531115942.1686812-1-chenhuacai@loongson.cn>
 <e7cf33a170d0b4e98e53744f60dbf922@kernel.org>
 <CAAhV-H6ZoqSty=yaAUPMg1QTamfwuYODB_mxf_o=HCJ1boawQg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <11542d9318062155ae5dfaafc7b14bb6@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenhuacai@gmail.com, chenhuacai@loongson.cn, tglx@linutronix.de, linux-kernel@vger.kernel.org, lixuefeng@loongson.cn, jiaxun.yang@flygoat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-31 16:53, Huacai Chen wrote:
> Hi, Marc,
> 
> On Tue, May 31, 2022 at 8:52 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2022-05-31 12:59, Huacai Chen wrote:
>> > We are preparing to add new Loongson (based on LoongArch, not
>> > compatible
>> > with old MIPS-based Loongson) support.
>> 
>> Please drop this blurb from all your patches. It adds zero 
>> information.
> OK, will be removed.
> 
>> 
>> > HTVEC will be shared by both old
>> > and new Loongson processors, so we adjust its description. HTPIC is
>> > only
>> > used by MIPS-based Loongson, so we add a MIPS dependency. PCH_PIC and
>> > PCH_MSI will have some arch-specific code, so we remove the
>> > COMPILE_TEST
>> > dependency to avoid build warnings.
>> >
>> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> 
>> No cover letter, no indication of what this applies on, no mention
>> of how this relates to the ongoing irqchip review.
>> 
>> What do you want me to do with this?
> Sorry about the confusion; as suggested by you and Arnd, these two 
> patches
> are the minimal changes required on irqchip's side to make the port 
> build,
> without introducing any non-reviewed pieces of code. I originally 
> wanted to
> send the patches then quickly reply you in the asm-generic thread, but
> unfortunately I lost Internet connectivity at my site until you have 
> replied.
> 
> You are knowledgeable, and have taught me much; I owe you many thanks.
> However, as my native language is not English, I realize I may sound 
> impolite
> or inappropriate from time to time, making some of you unhappy. 
> (Actually I
> had to ask Xuerui to translate this reply for me, in case I get 
> something
> wrong again.) I'll try to improve in the future and I hope you'll 
> understand.

No worries. English isn't my native language either, and I somehow 
developed
a thick skin when it comes to perceived attitude. So please don't 
apologise,
and keep working with us.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
