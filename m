Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA25A77DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiHaHo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiHaHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:44:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D823AE84A;
        Wed, 31 Aug 2022 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661931783;
        bh=9ycy50m2BVzr+LR+TASn5nabN2535sy01KiW7i6O5SI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f5E0Y3mnOH4y5rk5REftiX/ra1cHOrSNn2EDojkZDYQ4a6n6zWNuQ6yUqv352cVoo
         GlNrez+6fHS0CiZiAw27yIdFAIFg+xrZ3AOpmkBbsdmstxODxujF6I01Y//JNt/Abl
         uiFRZo79VNxMzMFwL3KWbo/EW6fy2U3pkZAAV8Z4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.170] ([5.147.48.164]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxlzI-1pKqZV2v0A-00zBxz; Wed, 31
 Aug 2022 09:43:03 +0200
Message-ID: <9a17ea86-079f-510d-e919-01bc53a6d09f@gmx.com>
Date:   Wed, 31 Aug 2022 09:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] usb: add quirks for Lenovo OneLink+ Dock
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824160946.10128-1-jflf_kernel@gmx.com>
 <31aeee3c-f4f1-16a8-272b-96da5d4a565e@suse.com>
 <d1a5f149-50a1-49fc-9a6d-eceffa23311b@gmx.com>
 <4b92eee0-b020-9211-2039-18ac3ac72a7b@suse.com>
 <edd97137-74a1-ee0b-d475-7c5b36197155@gmx.com> <Yw8OU8hYZuuBgrnj@kroah.com>
From:   jflf_kernel@gmx.com
In-Reply-To: <Yw8OU8hYZuuBgrnj@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:srQKQZK8ADX8KwScDmh4lqDIcInEz4EDuODcx9UEJneswEXzplT
 t896XiklipY0btbl9olZvkkYvTP4hNbU/jDhpwzUE6j1KASX10GNVMUeE8UvwL7rpum3/aV
 vKr+LR4I1APV/z6ieU0kxmBuc8CRo7Q+G5N1E5eYmG3u9n0rQHyqn6VKJwV1Lh4Q2N+5uwS
 +MuK2fFKTvALsI4hmSz3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1LCIMQoT+E=:PPssNvGUCexs+Xj4K2tnFz
 mA3mw4aYslGu1Zl05g8RDTkhW409O6BehloNq7tXfI807QzF0N6Mw1qM363sDF65zFaOhLhMZ
 Paf5NDGlc61nVsTcZMkKjPpKXFlTSkhELtuPxyuUELa6Vo8U2ZGgi4e2SFrJxIrbtLMiRLUmQ
 z0OiWyyaYBVmUQ2hT8AUDiyG7XKw+alHymCNVdlgjgPCfgWqZVhQwQ4nxumHMILD0LbATlcmM
 wYyNUBlm59oqdbaI0ouJ46y5gpj8cqOVQiHqhpaQnhr5wIXzI047Or7BjF+pstW6k9KkZ3t0s
 cIPwYZasC16j/C0UQXdeOwtdKiVvYhBcR7O/LEP3R0zJleD5nJs11v0D7mR3uR2w39ZXVUErv
 WW2PT+ywiO3qYVNrTnA5f9sS6lf+xWQOKYYlS5gF1JbaKqUghsd7ad29CinOlysDlbKnZWrWo
 g3Uwq1o10KJlsL91y8dml8BzYvDRwPzzgBjGfJSqglZbKvGS6yPA1Tjwhl2WYNCFrGmB+HwDa
 MRogB9AgYWSJGA+XPTeDodBTeMh5VuDVbUQ9ytMjKY4dKP2HnKpMhDjMVwUBJnrKJMYFd96Mp
 sA7Vat6HFSYbH/wFBDbgS5RlB5sj5g0voxA0vanQlqZaX+TNB/lCuw4xmi9r54ccQLWjQJkBN
 ldtUHQqlFyCDhJDDKpN1I6Vz9HvwL7OUIqtBePTI+mhz9ptBc3BNWOHStOv5g06QiZQQcCjdL
 C63qnYR3z5+gJ3I0WPNxefVMiZZjad0vbULfcu25hh+Y+jRS/+aPf1UGevlPRHH6oDDKQWaX8
 6xtTNjj1rzUJgWif0+ryB71BDhN6iaE1R6P0uYy9m24OQuBAC0YzI/ZxbccD4Dkt1AD/XW2mi
 MNCzh2s5GlGiKijYDgBTlIWUuzG+mw/02i6XYEhQQ22XjllWrYZnu7f5ISOlHW2BugccuI5IK
 DsjB3M/WDKSNIgTwfyIyrbiILU6ips784EvQp7E4gW3CQ7WD1Kf8odTok2CKb7C+ZY2q8bOeE
 TAJp7W5k+R9HkWLNm0Zn1iR9kpjN0IXCQq8h/UwTZNTSZdmskdU2CzbHf6/YDEo2I/zDvi0+p
 4kSi4aiG8Ut1oo2a7HzGwV7oYG9iylD384njK2ZFSc1fy7TFVV33Y8hiw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/08/2022 09.31, Greg KH wrote:
> On Tue, Aug 30, 2022 at 09:50:03PM +0200, jflf_kernel@gmx.com wrote:
>>
>> On 30/08/2022 16.47, Oliver Neukum wrote:
>>
>>> 1) force a reset after a resume and call reset_resume() instead of res=
ume()
>>> 2) block autosuspend if remote wakeup is required
>>>
>>> I suspect you are actually using the second effect. Have you
>>> tested with "usbcore.autosuspend=3D-1" on the kernel command line.
>>
>> After further testing, your suspicion is correct.
>>
>> TL;DR: the two VL812 hubs don't behave well when suspended.
>>
>> I'd like to prepare a better patch for that issue. What's the recommend=
ed strategy? The current patch works, even if only as a side effect and wh=
en there's a wakeup source downstream. It's currently in Greg KH's usb-lin=
us branch, and will land in linux-next at some point. I'm tempted to let i=
t be and undo it later in the better patch. Is that acceptable? Or should =
I ask Greg KH to pull it?
>
> I can revert it if you want me to, just let me know.
>
> thanks,
>
> greg k-h

[keeping the lists in CC this time]

Please revert if possible, and apologies for the trouble.

Thanks!
JF
