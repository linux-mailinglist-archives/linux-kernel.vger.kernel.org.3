Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA5584728
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiG1UpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiG1UpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:12 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5D2736;
        Thu, 28 Jul 2022 13:45:10 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id D199A185B6D3;
        Thu, 28 Jul 2022 22:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1659041108; bh=sRx6mGd0303ZII+oO6mGwJJLQl14UFRwzsiN7PVXODI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FOt8x21Z6bw3LuZdK6m0JupoRUGI/KDf+41PDQHiRX4C2mZXnipYCEeg/ctcd0Az9
         8y4dS87aj1ThxyPSgxiZQoSjYpLZU1UeRCaixGocCeaJqvBxp2pGKF1HPKL08vZMse
         9cLLEGyp72ZWDMjxhekSJh2C19xokcit8dgU4SW8=
Message-ID: <5bd688b0-7694-0a96-67e6-7137c018c9a5@schinagl.nl>
Date:   Thu, 28 Jul 2022 22:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net> <YuJ8lWGKXEk03u3M@kroah.com>
From:   Olliver Schinagl <oliver+list@schinagl.nl>
In-Reply-To: <YuJ8lWGKXEk03u3M@kroah.com>
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

Hey Greg,

On 28-07-2022 14:09, Greg Kroah-Hartman wrote:
> On Thu, Jul 28, 2022 at 11:21:14AM +0100, Gary Guo wrote:
>> Rust requires braces around branches of if expression, and C doesn't.
>> So in kernel coding style you often have:
>>
>> 	if (condition) do_something();
> 
> That is not a valid kernel coding style, and our tools should catch this
> and prevent it from being added to the kernel tree.
Are you sure? I'm not sure if this isn't true today, but I've certainly 
seen old code where this definitely was done. Was all of this cleaned up 
in the last 2+ years?

Olliver

> 
> thanks,
> 
> greg k-h

