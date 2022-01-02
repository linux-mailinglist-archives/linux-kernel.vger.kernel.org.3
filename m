Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284584828E6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiABBog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 20:44:36 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47798 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbiABBof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 20:44:35 -0500
X-Greylist: delayed 1985 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jan 2022 20:44:35 EST
Received: from host81-132-12-162.range81-132.btcentralplus.com ([81.132.12.162] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1n3pPE-000Ckv-Cj; Sun, 02 Jan 2022 01:11:29 +0000
Message-ID: <a140390f-26b9-72ca-32d9-ac64e9944169@youngman.org.uk>
Date:   Sun, 2 Jan 2022 01:11:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] md: fix spelling of "its"
Content-Language: en-GB
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
References: <20211226022411.22437-1-rdunlap@infradead.org>
 <CAPhsuW5sC5bi3CfAtL1iwHHUbHvsVc0f0y6rn7szK1okBAaEWw@mail.gmail.com>
From:   Wol <antlists@youngman.org.uk>
In-Reply-To: <CAPhsuW5sC5bi3CfAtL1iwHHUbHvsVc0f0y6rn7szK1okBAaEWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2022 00:06, Song Liu wrote:
> On Sat, Dec 25, 2021 at 6:24 PM Randy Dunlap<rdunlap@infradead.org>  wrote:
>> Use the possessive "its" instead of the contraction "it's"
>> in printed messages.
>>
>> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
>> Cc: Song Liu<song@kernel.org>
>> Cc:linux-raid@vger.kernel.org
> Applied to md-next.
> 
> Thanks!
> 
For the benefit of non-native English speakers, the possessive ending is 
NOT " 's ". In practice it usually does tend to be, though.

The regular historic possessive ending is -es. An apostrophe replaces 
elided letters - and for whatever reason in modern English that "e" is 
almost always elided, hence " 's " :-)

(Which is why the possessive plural ending is usually a trailing 
apostrophe. The possessive of (plural) cats was "catses", now 
abbreviated to " cats' ".)

However, with the word "it", the irregular possessive form is "its", and 
when you see " it's ", it's actually a contraction of " it is ", the "i" 
has been elided and replaced by the apostrophe.

I remember seeing a big sign outside a shop where they proudly announced 
they had been granted a "Certificate of Excellence". And in about 20 
words, they had the word "its" six times. Spelt wrong EVERY SINGLE TIME :-)

Cheers,
Wol
