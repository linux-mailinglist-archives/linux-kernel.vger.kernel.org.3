Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88503483106
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiACMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:31:13 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E9C061761;
        Mon,  3 Jan 2022 04:31:13 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4MUY-00075C-2s; Mon, 03 Jan 2022 13:31:10 +0100
Message-ID: <b7cc0cd0-887e-fd19-d570-1182ec5e7b14@leemhuis.info>
Date:   Mon, 3 Jan 2022 13:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
 <7a9999a4-257c-3428-779e-0fdbf02d4782@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: 5.Posting.rst: describe Fixes: and Link: tags
In-Reply-To: <7a9999a4-257c-3428-779e-0fdbf02d4782@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641213073;74904e5c;
X-HE-SMSGID: 1n4MUY-00075C-2s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy! Thx for taking a look. Your helpful feedback made me CC you on
the RFC on a document about regressions I sent today as well. Feel free
to ignore it, if you're not interested.

On 03.01.22 08:36, Randy Dunlap wrote:
> On 1/2/22 23:15, Thorsten Leemhuis wrote:

>> Lo! If there is still a chance I'l like to get this patch into v5.17, as
>                                  I'd
>
>>   Patch itself is unchanged, patch description slighly changed. Might
>                                                  slightly
> 
>>   later submit other changes from that series seperately, too, still
>                                                 separately,

Note to self: avoid last minute changes. :-/

>> ---
>>  Documentation/process/5.Posting.rst | 29 ++++++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
> [...]
>> +A third kind of tags are used to document who was involved in the development of
>                 of tag is used

Many thx, fixed all of these locally for v2.

Ciao, Thorsten
