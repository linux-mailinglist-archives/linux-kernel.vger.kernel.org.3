Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EAE4E3D00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiCVKz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiCVKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:55:24 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A863C8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:53:55 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KN7dY5r4xzMqKr0;
        Tue, 22 Mar 2022 11:53:53 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KN7dY0vhzzlj4cP;
        Tue, 22 Mar 2022 11:53:53 +0100 (CET)
Message-ID: <fa6dd51c-52c3-f7d1-b845-ec7266494410@digikod.net>
Date:   Tue, 22 Mar 2022 11:54:59 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220321174548.510516-1-mic@digikod.net>
 <20220321174548.510516-2-mic@digikod.net>
 <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
 <YjkP5d6e6SU8BPtO@iki.fi>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1 1/1] certs: Explain the rational to call panic()
In-Reply-To: <YjkP5d6e6SU8BPtO@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/03/2022 00:53, Jarkko Sakkinen wrote:
> On Mon, Mar 21, 2022 at 02:23:54PM -0400, Paul Moore wrote:
>> On Mon, Mar 21, 2022 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
>>>
>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>
>>> The blacklist_init() function calls panic() for memory allocation
>>> errors.  This change documents the reason why we don't return -ENODEV.
>>>
>>> Suggested-by: Paul Moore <paul@paul-moore.com> [1]
>>> Requested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
>>> Link: https://lore.kernel.org/r/YjeW2r6Wv55Du0bJ@iki.fi [1]
>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>> Link: https://lore.kernel.org/r/20220321174548.510516-2-mic@digikod.net
>>> ---
>>>   certs/blacklist.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>
>> I would suggest changing the second sentence as shown below, but
>> otherwise it looks good to me.
>>
>> Reviewed-by: Paul Moore <paul@paul-moore.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Mickaël, I think since your patch set was not huge in the first place, I'm
> considering making it part of rc2 pull request while I normally try to
> avoid any features after rc1. It's anyway throughly tested, and generally
> has been around for a *long time*. I've even tested it myself a few times.
> 
> Just trying to be responsible as a maintainer and if something does not
> feel right, I don't  try to pretend that "I get it", if you know what
> I mean. This fully clarifies "not getting it" part :-)
> 
> Thanks!

Thanks Jarkko, I get it. ;)
