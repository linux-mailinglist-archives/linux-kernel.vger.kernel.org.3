Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39404E4725
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiCVUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCVUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:03:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8514080;
        Tue, 22 Mar 2022 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647979291;
        bh=jkWDyczwmrtSepm0mjbgqC8npaXkRs4EV4Hmu1GayKw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Xew8PDYPzYzti+8nn6/C1Q4MoVZfOwSaEmtw26BcISHoDHyoJJIhgiNK5JNqAmDhH
         VHgXBksoLtpsIuOBoxoN3bcXzGwQMW60wh5xGo8d3UP4mmO2gw+RLB7Nv+GoFkFy8d
         0vN8w2/g9P1rr4QjOwiKH0MpH+Xb35biThxL5iEM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.132]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1oEN0D0Xcg-010MFt; Tue, 22
 Mar 2022 21:01:31 +0100
Message-ID: <6559ec2c-d5ac-7940-8241-01497bf32cc4@gmx.de>
Date:   Tue, 22 Mar 2022 21:01:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: linux-next: manual merge of the parisc-hd tree with the
 asm-generic tree
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220228114523.03b2f921@canb.auug.org.au>
 <20220322110925.7b295e54@canb.auug.org.au>
 <8ce9d045-c3c9-c839-7b82-9f5ccdae2d52@gmx.de>
 <CAK8P3a3hR0JP-coRBNDytC1onPUfYCUn_q148kMO5-FWvxwgOg@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAK8P3a3hR0JP-coRBNDytC1onPUfYCUn_q148kMO5-FWvxwgOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ZbFeDt4fI9LEV2I9hVSWzmPRS39ZSeKxyIoIzsF95Yz1DbuFId
 smctPxpSXGkRxVhjJgoMsr2mvdnBG2ahUjfrfMGa91qEw0byNcv8MsfWzy5oMxdGc7LPRfR
 lM9W4n3AEpcB6g0d79PXfOfIfgwymzHAS4GUdhdEEu5fe0E7v8e8ZWVUNCDWpHihXIwZRPT
 Fdzr/VHdVJBOl5Dl2190Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3gNmhCaX8A=:0Iw8svcrG4eqpsBOVgbvE1
 GeEDGL24Yv1gWCTwPQTLWfyvLgatQC6Rtz7tLhM9XROkSFTuLv7tg/W3OsoawOAOJHmmEQlLg
 hmKQj5tZXc8eRaP/aYSyHYpfM7eHvmo8Y2xAAmHOsiel6IMY3fxH+lc3j1WVbBFmo/aztiz5F
 DTGRogdjuYk4gM+LV2OlUoJpN1GpAsnJm70C7mDfImzBaEB+VOvNh5/KEiBzWgt+0zN+h3v8M
 uKODpFD7/NHtBfa9fAXr8lOqE6Vz1yyyCnLaNIMcnwhTz8aLTuogAZUkreatH93nn8pik2PMj
 ySfULaGMCGEhPBEyqiVvSuJQerKZa3luZnwc1nvOrXvsxGxc+0+eosBzfSuKMlkDi71NiG8YF
 8MXH7ivmEajfw/euOKDKDFXdpTLbTSsg3TCzQiZNd6BrfYlRcFAcWoJoAfvAE4D+BJ8q7a8+K
 7eCdw8BR7MYUsnwpvNRopxW0+9gE9yzc+sgQWj23W7smkUdvQoXS6oZMJTFNd4f/SUV3e2h41
 u6xfffeW7I4qn8ln+XTgOPNwVRrfoN2QU3DMc05ubKHEkDqvj+ASFjNwCq7umBzh7q8JhkLIW
 9K8DjrvF1M2GJsVTROlA9XgxY0a3Vb0akvF04OvQJRdZ0PW0+5Z+mcJgScAyhyxTjD+B7tZnY
 Fo41wF3kPlDyd+h2kXUKj0LAoEawjxkbq1O59CbnPOuu40UpXGp3mt3Ys+ornSNJouAazPr9g
 RvfJsqMkneiSpxpuWkmRFhb9vmNYJStN67oyL+SYdX+SIq7uWcxcTrUwMiyv0yEIqlP1OcY3d
 bFlNb9b2ypE+yO5/BOoxxC/7vpwOiQ5F5bDZb+OSPaw88ILSBEx3ExiGQobREvKhK5tk1nTdI
 enmOn4u/sIER6/yrKs/dmqtokkxlhu8ZKkDZ/feOhwJKlsUIuvWMuKfqJ26RxsQAKV/WSOnrJ
 g+M9WgyP/nZ6XfUajY5TWwG7BUPwOW2kk4oKxD71D/Xzp1H9o4dL6E4yjgdpaoKh6vwj/XOtR
 KgxNV2fKDlWjA/SUuAMsWRUfRLgYoGaSeOgZd8PXHrk2U6T1z18ch3xqZAECsVcc2HbJPmP0R
 Z3WyITi9XkJI7s=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 18:06, Arnd Bergmann wrote:
> On Tue, Mar 22, 2022 at 8:34 AM Helge Deller <deller@gmx.de> wrote:
>>
>> On 3/22/22 01:09, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> On Mon, 28 Feb 2022 11:45:23 +1100 Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>>>>
>>>> Today's linux-next merge of the parisc-hd tree got a conflict in:
>>>>
>>>>   arch/parisc/lib/memcpy.c
>>>>
>>>> between commit:
>>>>
>>>>   967747bbc084 ("uaccess: remove CONFIG_SET_FS")
>>>>
>>>> from the asm-generic tree and commit:
>>>>
>>>>   d4a767ea8b0e ("parisc: Use constants to encode the space registers =
like SR_KERNEL")
>>>>
>>>> from the parisc-hd tree.
>>>
>>> This is now a conflict between the asm-generic tree and commit
>>>
>>>   360bd6c65807 ("parisc: Use constants to encode the space registers l=
ike SR_KERNEL")
>>>
>>> in Linus' tree.
>>
>>
>> Arnd,
>> can you please drop the changes in your asm-generic tree for
>> arch/parisc/lib/memcpy.c
>> They are not needed any more.
>>
>
> Sorry I missed that earlier when the conflict happened originally.
>
> I can't really rebase my changes on top of your tree now, and just dropp=
ing
> the change without a rebase would break mine. I'll make sure to mention
> the conflict in the pull request then and have Linus resolve it.

Ok, Thanks!

Helge
