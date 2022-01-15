Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A693448F91C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiAOTnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:43:18 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55057 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbiAOTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:43:17 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1n8ox2-002dgO-Si; Sat, 15 Jan 2022 20:43:00 +0100
Received: from p57bd9aec.dip0.t-ipconnect.de ([87.189.154.236] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1n8ox2-003ZOJ-Lz; Sat, 15 Jan 2022 20:43:00 +0100
Message-ID: <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
Date:   Sat, 15 Jan 2022 20:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86: Remove a.out support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
 <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic>
 <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <YeKyBP5rac8sVvWw@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.154.236
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav!

On 1/15/22 12:37, Borislav Petkov wrote:
> On Fri, Jan 14, 2022 at 08:35:53PM +0100, Borislav Petkov wrote:
>> On Fri, Jan 14, 2022 at 08:21:36PM +0100, Geert Uytterhoeven wrote:
>>> I mean that I can rip it out on m68k.
>>>
>>> Who's gonna take care of alpha?
>>
>> I'm sceptical anyone would:
>>
>> $ ./scripts/get_maintainer.pl -f arch/alpha/
>> Richard Henderson <rth@twiddle.net> (odd fixer:ALPHA PORT)
>> Ivan Kokshaysky <ink@jurassic.park.msu.ru> (odd fixer:ALPHA PORT)
>>
>> which leaves me. I could give it a try.
> 
> Well, on that old thread from 2019 people expressed the wish to be able
> to run a.out binaries on Alpha. Let's see whether that has changed in
> the meantime.

Checking on the message I sent three years ago, it didn't seem that I was opposed
to removing a.out support, but that I would be happy to help test the patches.

I don't have any particular use case for a.out support either.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

