Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8CA5452CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiFIRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbiFIRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:17:43 -0400
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9B1C28EA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:17:41 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LJrPv5lQnzMprpC;
        Thu,  9 Jun 2022 19:17:39 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LJrPv1bNBzlpC9v;
        Thu,  9 Jun 2022 19:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1654795059;
        bh=8Elgg/SN+T6CNwEBcvTtMSfmYQEA0/ksDzG6Y3fvVrw=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=bzc9MNS1Yo9yX1Qw/ZCWX4jyhjoF5l8Yuut6gzWvv+XKfz2nGO4oDe7Ecw6ttxUo3
         Aa7lA/fyQCIFPPISj0U69JQjAp5wxSe7B0MW+Tm0EZyr4f1j2dlOnFq2RqimmYu7LF
         SxPdFHmImQwjH9473maRecsvOY5/KmeDLYuZePd8=
Message-ID: <75918f49-5670-766a-09a2-f29aef95f2ca@digikod.net>
Date:   Thu, 9 Jun 2022 19:17:38 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
 <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
 <22a067fe-795f-d3ae-fac6-7baa75393349@digikod.net>
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
In-Reply-To: <22a067fe-795f-d3ae-fac6-7baa75393349@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2022 19:12, Mickaël Salaün wrote:
> 
> On 06/06/2022 18:49, Masahiro Yamada wrote:
>> On Mon, Jun 6, 2022 at 9:32 PM David Howells <dhowells@redhat.com> wrote:
>>>
>>> There's a rule in certs/Makefile for which the command begins with eight
>>> spaces.  This results in:
>>>
>>>          ../certs/Makefile:21: FORCE prerequisite is missing
>>>          ../certs/Makefile:21: *** missing separator.  Stop.
>>>
>>> Fix this by turning the spaces into a tab.
>>>
>>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are 
>>> valid")
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> cc: Mickaël Salaün <mic@linux.microsoft.com>
>>> cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> cc: keyrings@vger.kernel.org
>>
>>
>> Not only 8-space indentation, but also:
>>
>>    - config_filename does not exist
>>    - $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX) is always empty
>>    - $(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) is always empty
> 
> These are imported helpers (not only used for this hash list BTW), hence 
> not defined in this Makefile.

Well, they were defined in scripts/Kbuild.include but they are gone 
since your commit b8c96a6b466c ("certs: simplify $(srctree)/ handling 
and remove config_filename macro").

I guess it just happens during the merge. We need to fix that.


> 
>>
>>
>>> ---
>>>
>>>   certs/Makefile |    2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/certs/Makefile b/certs/Makefile
>>> index bb904f90f139..cb1a9da3fc58 100644
>>> --- a/certs/Makefile
>>> +++ b/certs/Makefile
>>> @@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o += -I$(srctree)
>>>
>>>   targets += blacklist_hashes_checked
>>>   $(obj)/blacklist_hashes_checked: 
>>> $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) 
>>> scripts/check-blacklist-hashes.awk FORCE
>>> -       $(call 
>>> if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST)) 
>>>
>>> +       $(call 
>>> if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST)) 
>>>
>>>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>>>   else
>>>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>>>
>>>
>>
>>
>> -- 
>> Best Regards
>> Masahiro Yamada
