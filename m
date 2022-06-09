Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33305452BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbiFIRMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiFIRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:12:33 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440C20AA79
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:12:32 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LJrHy41nxzMqHBW;
        Thu,  9 Jun 2022 19:12:30 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4LJrHx72dwzlmMv4;
        Thu,  9 Jun 2022 19:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1654794750;
        bh=2M0p8j1YB8Vaadx3dL5PEu4PAcNlmdFXJTXC8kWcu5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ta5ituWDadhYZ7PdVU7fL24nRsCvv5LKzMv/yp7i+QgAOJO5hHrwTV2qnsQqePNGN
         Ej05c4SY4B5W1Epa8SR+FNKIpvr/CWzPYnaGcFHq3urnJwWLwmJwPIIJB2mAxXMOye
         iDZ0mFBXLBUNmon+NboNyJKPaUcqacLwfspWSabw=
Message-ID: <22a067fe-795f-d3ae-fac6-7baa75393349@digikod.net>
Date:   Thu, 9 Jun 2022 19:12:29 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
 <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2022 18:49, Masahiro Yamada wrote:
> On Mon, Jun 6, 2022 at 9:32 PM David Howells <dhowells@redhat.com> wrote:
>>
>> There's a rule in certs/Makefile for which the command begins with eight
>> spaces.  This results in:
>>
>>          ../certs/Makefile:21: FORCE prerequisite is missing
>>          ../certs/Makefile:21: *** missing separator.  Stop.
>>
>> Fix this by turning the spaces into a tab.
>>
>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Mickaël Salaün <mic@linux.microsoft.com>
>> cc: Jarkko Sakkinen <jarkko@kernel.org>
>> cc: keyrings@vger.kernel.org
> 
> 
> Not only 8-space indentation, but also:
> 
>    - config_filename does not exist
>    - $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX) is always empty
>    - $(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) is always empty

These are imported helpers (not only used for this hash list BTW), hence 
not defined in this Makefile.

> 
> 
>> ---
>>
>>   certs/Makefile |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/certs/Makefile b/certs/Makefile
>> index bb904f90f139..cb1a9da3fc58 100644
>> --- a/certs/Makefile
>> +++ b/certs/Makefile
>> @@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o += -I$(srctree)
>>
>>   targets += blacklist_hashes_checked
>>   $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
>> -       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
>> +       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
>>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
>>   else
>>   obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
>>
>>
> 
> 
> --
> Best Regards
> Masahiro Yamada
