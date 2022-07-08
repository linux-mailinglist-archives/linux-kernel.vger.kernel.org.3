Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCA56B572
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiGHJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbiGHJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC04FD134;
        Fri,  8 Jul 2022 02:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E7DB82547;
        Fri,  8 Jul 2022 09:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B004C341C0;
        Fri,  8 Jul 2022 09:26:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pkqND3Bm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657272393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9HeHlnsW1JkxCnRYtTnfqUp3XvLQS0O+ZMfaM6JuHTA=;
        b=pkqND3BmqSbPOit4Mj5DT7X7YDRtI4zI7ej6QO6XmUtlnWTRQiztuwTVTxkSF4floPVPF3
        wONKVWOSD1FRpYgm/JX3WWShHVacfbrE/ETIJDTaYNshOkRnXfUF96isK0PDZGi0pY6E2f
        VAZd8GYkwetZVfgCFTQ883t1gkuyj4A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 38c5eef7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Jul 2022 09:26:33 +0000 (UTC)
Received: by mail-io1-xd33.google.com with SMTP id n7so8623580ioo.7;
        Fri, 08 Jul 2022 02:26:33 -0700 (PDT)
X-Gm-Message-State: AJIora+BySM/lK8OjemrfbfLRVAe/P3JwA7bF6jt6m566hljETBJb10q
        IJ1RanavNkBFlXEegIctnK75eJQrECYP/0EkNyI=
X-Google-Smtp-Source: AGRyM1sLt4kVkbV8Gy6AgNOWbg/i+iKMh6Rjk1K7PZRGWXSuBZYL3v1vJfikjc33S9848G5nx2yxV9as9TJsIF5FCNU=
X-Received: by 2002:a02:9709:0:b0:339:ef87:c30b with SMTP id
 x9-20020a029709000000b00339ef87c30bmr1513477jai.214.1657272091980; Fri, 08
 Jul 2022 02:21:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:16cc:0:0:0:0 with HTTP; Fri, 8 Jul 2022 02:21:31
 -0700 (PDT)
In-Reply-To: <YsfnDyOaKXA3iIj4@zn.tnic>
References: <20220708171030.135b12cd@canb.auug.org.au> <YsfnDyOaKXA3iIj4@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 8 Jul 2022 11:21:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9o052ooE6pC-Sa4EzohW7yRdepNy0zZAFFX6qr9Q+MoHA@mail.gmail.com>
Message-ID: <CAHmME9o052ooE6pC-Sa4EzohW7yRdepNy0zZAFFX6qr9Q+MoHA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the random tree with the tip tree
To:     Borislav Petkov <bp@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan McDowell <noodles@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/22, Borislav Petkov <bp@suse.de> wrote:
> On Fri, Jul 08, 2022 at 05:10:30PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the random tree got conflicts in:
>>
>>   arch/x86/include/uapi/asm/bootparam.h
>>   arch/x86/kernel/kexec-bzimage64.c
>>   arch/x86/kernel/setup.c
>>
>> between commit:
>>
>>   b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
>>
>> from the tip tree and commit:
>>
>>   c337d5c7ec9b ("x86/setup: Use rng seeds from setup_data")
>
> Why is a x86 patch in the random tree?
>
> And it doesn't even have a single x86 person ack?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=c337d5c7ec9bc1d11006fd628e99c65f08455803
>
> This is not now the process works.

Sorry; I pushed it there temporarily to kick some CI to test it and
forgot to remove it.

Jason
