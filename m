Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E98A484650
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiADQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiADQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:58:20 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAEDC061761;
        Tue,  4 Jan 2022 08:58:20 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4n8c-0003Z6-Ub; Tue, 04 Jan 2022 17:58:19 +0100
Message-ID: <bd81b15d-2da2-8f79-0372-ca9df9f00361@leemhuis.info>
Date:   Tue, 4 Jan 2022 17:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <2b9c093339322e2686140a486b978c0b03476f42.1641194004.git.linux@leemhuis.info>
 <87ilv0xwjn.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v1] docs: 5.Posting.rst: describe Fixes: and Link: tags
In-Reply-To: <87ilv0xwjn.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641315500;e6b44096;
X-HE-SMSGID: 1n4n8c-0003Z6-Ub
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.01.22 23:51, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Explain Fixes: and Link: tags in Documentation/process/5.Posting.rst,
>> which are missing in this file for unknown reasons and only described in
>> Documentation/process/submitting-patches.rst.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> CC: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>> ---
>> Lo! If there is still a chance I'l like to get this patch into v5.17, as
> 
> I think that should be possible.  Send me a version with Randy's
> comments addressed; I also had one nit below...

Sounds good. Comments and nit addressed and sent out again:

https://lore.kernel.org/linux-doc/c4a5f5e25fa84b26fd383bba6eafde4ab57c9de7.1641314856.git.linux@leemhuis.info/

Ciao, Thorsten
