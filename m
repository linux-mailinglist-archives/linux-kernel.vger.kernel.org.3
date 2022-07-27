Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87328582179
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiG0HrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG0HrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:47:19 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A14641D2F;
        Wed, 27 Jul 2022 00:47:17 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 0B6AE185A22C;
        Wed, 27 Jul 2022 09:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1658908035; bh=nMJRiQz8sdq37K3By/jwSel0MJCt70iFldCqppiihXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EjAKUsN/xP9zSCit9yXBiHscph76OBMs8BE0tje2Q04acHMdIHnYuNoGtE2lZnp2s
         9z76a/uunHHXGsRWnxl8IM8sltp8kufIeG9zse3Mjgd0AaoJgtA7DKc1q3o1R7Gzdg
         7oQujLDxibqCEe7JtBTv7iK5xlwW1OuHhAjN1/ow=
Message-ID: <f77a82ec-e970-d8d6-5196-6253bc72bdc2@schinagl.nl>
Date:   Wed, 27 Jul 2022 09:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: en-US
To:     Nicolas Pitre <nico@fluxnic.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <1163467-64s-p66r-r077-35s058258150@syhkavp.arg>
From:   Olliver Schinagl <oliver+list@schinagl.nl>
In-Reply-To: <1163467-64s-p66r-r077-35s058258150@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 20-07-2022 22:21, Nicolas Pitre wrote:
> On Wed, 20 Jul 2022, Miguel Ojeda wrote:
> 
>> On Mon, Jul 18, 2022 at 8:56 AM Olliver Schinagl
>> <oliver+list@schinagl.nl> wrote:
>>
>>> Secondly, and more importantly so; you argue 'who cares about people
>>> with disablements, atleast its equally hard to read everywhere' which is
>>> a very poor argument :p
>>
>> No, and I want to be __very__ clear about this: at no point I have
>> argued "who cares about people with disabilities" or anything like it.
>> It is insulting that you even suggest it.
> 
> What "people with disablements" have to do with this anyway?
> I don't get it.
If you are talking to me; simple, reading disabilities (dyslexia being 
the most common one) are real :) and code-style heavily impacts those.

For example, I have a really really hard time reading 2 space indent, 
especially in larger code bases. Also, CamelCase is very very hard for 
me to read also, as is statements without spaces `if((x<y&0xf)||z>a)` 
for example.

So codestyle affects those with reading disabilities, but not well known 
to the people without these, which is why I was raising awareness.

Hope this helps to explain things?

> 
> 
> Nicolas

