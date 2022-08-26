Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25525A31CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiHZWOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHZWOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:14:49 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164764F8;
        Fri, 26 Aug 2022 15:14:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3E9C17C0;
        Fri, 26 Aug 2022 22:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3E9C17C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661552086; bh=OyiopfThtdomtve3fpoPeW+r+ghhtyJEsNLXRZsU+ho=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jjyBpx9zVmKScFU1b8voamtvXx/rM7FXoHHXOLEK5O7eT30q3W0NajsFrYyoJAbd8
         SllrmLvsBufQ0ETvEE77Nr3wHZWZC65G6d059v8e4aUkZ5/x5UNVrnYzMcuLEN4AYx
         OOhvCTx8ZgETZC/0qUWSMk4sq+XNDMhnAQr3q8vLAgQ/lQSBsfFRcf1nX+f2I91kBS
         U2y6uY4EFZ9/zN3PCq3/U2MLZJS4EjdVe12wNFRAFlGJbEAURFopD5nMFUwTx0oeRU
         vwDLgZ2ivLLHSW+x2EA4hsmGTZwYkBtWIFM+w7il/hOkb/MKI1oAFMZcfPGZnKJ4js
         sDuiQiIGnKB7Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>, menglong8.dong@gmail.com
Cc:     sfr@canb.auug.org.au, bagasdotme@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
In-Reply-To: <874jxyu32m.fsf@meer.lwn.net>
References: <20220826160150.834639-1-imagedong@tencent.com>
 <20220826135839.39c7711f@kernel.org> <874jxyu32m.fsf@meer.lwn.net>
Date:   Fri, 26 Aug 2022 16:14:45 -0600
Message-ID: <87zgfqsld6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Sat, 27 Aug 2022 00:01:50 +0800 menglong8.dong@gmail.com wrote:
>>> From: Menglong Dong <imagedong@tencent.com>
>>> 
>>> Stephen Rothwell reported htmldocs warning when merging net-next:
>>> 
>>> Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
>>> Invalid C declaration: Expecting "(" in parameters. [error at 19]
>>>   void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
>>>   -------------------^
>>> 
>>> Add __fix_address keyword to c_id_attributes array in conf.py to fix
>>> the warning.
>>
>> You'll need to CC netdev@ for the patch to get into the net-next tree.
>> Since this is a pure Documentation/ patch get_maintainer.pl did not
>> produce netdev@ in the recommended addresses.
>>
>> Please wait for a review/ack from Jon before reposting, we need his
>> permission to apply this patch.
>
> I could also just carry it through docs; I'm about to send a set of
> fixes Linusward in any case.  I wanted to run a couple of tests to be
> sure, but I don't expect any problems with it...

The patch is clearly correct, it can go in via whatever path seems most
suitable.  Let me know if you'd like me to push it; otherwise:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon
