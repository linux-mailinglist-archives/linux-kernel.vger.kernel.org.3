Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151254F1BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380759AbiDDVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379223AbiDDQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:47:44 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342635DFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:45:48 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id D043FD847F8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:45:47 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bPprn4FwC22u3bPprnBDnR; Mon, 04 Apr 2022 11:45:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PvOuKe3VYlx98pU3fvtPHpnIy8LCRmoajzdinROj5NE=; b=Xu8onfvEDpQdIZ3BVod020rxdk
        tQMu8IrsOWj9aZFbzzsFOZnlmA29iNKCQ6c1nMx79xcLNdnlK7J91JWQU/E0Yiq4KMSzVa42m6wS4
        oARlfvK6KKH6KbmihrQcVYSM9/xDxnLCcKlQ01Y7MqpU7UNS4hCRUsBcK7hgVfKnDNWJY0sdMQfER
        aI5afOQSQbSl1aQGH1puQRYg9WCO1Gkhkt4w3u/F6zTDYwvzWLCmymt4xDLbaE2soHpQN54duS1+l
        qy+mOCrPCSNzHPNvk3MM29YZoZsMu1Rpyghp+9/Na5H8UdWxfskJG6C5eTZZqjhnmh1m88KOjC2Vj
        nqXc5fUA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54722)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbPpr-002TwF-Fk; Mon, 04 Apr 2022 16:45:47 +0000
Message-ID: <ea840ab9-0c20-8c06-f7d4-bb9642a63500@roeck-us.net>
Date:   Mon, 4 Apr 2022 09:45:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
 <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
 <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
 <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.18-rc1
In-Reply-To: <CAHk-=witgMUS8To6wijxdbQ+QEH0gcHSYV6Y=yzOdb=Q4h9PJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbPpr-002TwF-Fk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54722
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 7
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 08:32, Linus Torvalds wrote:
> On Sun, Apr 3, 2022 at 9:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Oops. Sorry, I thought it was big endian. No idea why. I'll update
>> subject and description and resend.
> 
> I see your updated patch, but for some reason 'b4' is unhappy about it, with
> 
>    $ b4 am 20220404134338.3276991-1-linux@roeck-us.net
> 
> causing
> 
>    ✗ [PATCH v3] staging: r8188eu: Fix PPPoE tag insertion on little
> endian systems
>    ---
>    ✗ BADSIG: DKIM/roeck-us.net
> 
> your DKIM looks fine on the messages I see, but now that I look at it
> on the mailing list, I notice that your DKIM really is very wrong, and
> has a lot of headers that a DKIM signature should *not* have.
> 
> Your DKIM signature includes header names that are very much for list
> management, so by definition DKIM will fail for any email you send
> through a mailing list. Headers like
> "Resent-From:Resent-Sender:Resent-To:Resent-Cc
> :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe" etc.
> 
> The DKIM setup should protect the meaningful headers that matter to
> the sender, not things that the mail system will validly add when it
> passes through.
> 
> So the DKIM header list should be things like
> ":To:From:Cc:Message-Id:Date:Subject:"
> 
> Not things like "Sender" or mailing list things.

I tried to tell my provider, but to no avail. Until now I used gmail,
but gmail will disable that ability by end of this month, leaving me
in the dark. Lose-lose situation for me. Right now I don't have a
useful alternative that doesn't require me to change my e-mail
address completely (or setting up my own e-mail server which
is a pita).

> 
> Anyway, I was going to just commit it directly, but with the DKIM
> verification failing, I was a bit less eager to. And then I noticed
> that you used "be16_to_cpu()" - which is technically correct - which
> doesn't match the other code in that file.
> 
Another lose-lose situation. Larry tells me I should use
be16_to_cpu(), you tell me I should not.

Either case, https://lore.kernel.org/r/YkPK/QmLAp3BkygY@sckzor-linux.localdomain
is a more complete solution, so you might want to pick that one.

Thanks,
Guenter
