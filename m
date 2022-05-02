Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44955176C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiEBSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbiEBSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:47:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97F63D0;
        Mon,  2 May 2022 11:44:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e3so13113278ios.6;
        Mon, 02 May 2022 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kag0W5KSVm45wT2YJIgHV3pPE4Il9KPW/q5fD/AIv6E=;
        b=YYZhTjBKfWlOrPpS24xigKe2erAj7g8ET79Enx4NjPB00O1NaBeXyD6g55Pw2dBucV
         wI7zsIiq0GQaQSkW0K8EULv5LMbZmsSSjXQEbHtnnfISTf55L3M8CtmAeBBtomtv5miM
         rYIfsNyzPZvdhDYy3ClDbeIRHepfxIKlZ1NG1PtOWeG6GKfb6DzI4MizZ0hDS//eYjp0
         wySriFoYDhKKg4voV87SdhIb99FjOZ0P6CpYFcxz3FKSxqPc+aIOZx03OqfR5W8yuQpd
         EkNG0q14jo7DY0PReX3ZE1aQHnyOgGDd4tDQAo/jJggBeqPdJK/x630qNVqkKFx/8Lta
         f7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kag0W5KSVm45wT2YJIgHV3pPE4Il9KPW/q5fD/AIv6E=;
        b=A+74/6pgIDQTHuvQbQsnP3ySW856euLEUJcfLljy0skfABMXqVlJQvnEmBTUZ/PAKS
         N1q1IYdy6aCi5RGIgyYiTh0aVvOombZo3df1KTu753smKGO+9oTLAXdzX1MVPhQWVXpK
         Pm7jWGcgkKN3lzy0E2wNWSStewGUjU7YSYWlSBsVDi/YPE5saYAUXRiDONdf+lHKvTbe
         V5ELUTRXW6gTz3Ebm0Hu07K9A1OlptQckCOaJ5MiTnrusnmdfqoRIpuuxI+K+CPc8pKx
         N/adjxXVUl508n1fKScQsLFB8rqNN1rEYF5WNHpt2m4hwV7WmeiTYQyq4E401HDHczql
         lJcA==
X-Gm-Message-State: AOAM530234gkuDLql3FcpsBFKzQQR/K8fiqsbVqbe+693CIvETT+iwiW
        oPeUAhjlv7G3edb6wLEhg2NNDN8jmDg=
X-Google-Smtp-Source: ABdhPJyAgRgwSGKQgX14pN0L3BMo2qgWA4xuMMw0pRSeUrjOmrvAs68ST+AI9dv0iqIU9KHPY/J2xw==
X-Received: by 2002:a5e:d61a:0:b0:657:c106:6009 with SMTP id w26-20020a5ed61a000000b00657c1066009mr4508768iom.105.1651517060733;
        Mon, 02 May 2022 11:44:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:bd98:70d3:4542:6c6a? ([2600:1700:2442:6db0:bd98:70d3:4542:6c6a])
        by smtp.gmail.com with ESMTPSA id w63-20020a025d42000000b0032b3a781760sm3245998jaa.36.2022.05.02.11.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:44:20 -0700 (PDT)
Message-ID: <c9819833-5c51-070b-ca77-ce273aa46fcf@gmail.com>
Date:   Mon, 2 May 2022 13:44:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] of: overlay: add entry to of_overlay_action_name[]
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220501000543.1368005-1-frowand.list@gmail.com>
 <20220501000543.1368005-2-frowand.list@gmail.com>
 <YnAOEqO23BQk53vz@robh.at.kernel.org>
 <367805de-3ef5-1e1d-3711-7d21b500a886@gmail.com>
 <CAL_JsqJByh1kt13ATU0J8nYbusYu3XY3bXLwyuDg8XD6xmDkMA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqJByh1kt13ATU0J8nYbusYu3XY3bXLwyuDg8XD6xmDkMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 13:29, Rob Herring wrote:
> On Mon, May 2, 2022 at 1:17 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 5/2/22 12:00, Rob Herring wrote:
>>> On Sat, Apr 30, 2022 at 07:05:41PM -0500, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> The values of enum of_overlay_notify_action are used to index into
>>>> array of_overlay_action_name.  Add an entry to of_overlay_action_name
>>>> for the value recently added to of_overlay_notify_action.
>>>>
>>>> Array of_overlay_action_name[] is moved into include/linux/of.h
>>>> adjacent to enum of_overlay_notify_action to make the connection
>>>> between the two more obvious if either is modified in the future.
>>>>
>>>> The only use of of_overlay_action_name is for error reporting in
>>>> overlay_notify().  All callers of overlay_notify() report the same
>>>> error, but with fewer details.  Remove the redundant error reports
>>>> in the callers.
>>>>
>>>> Fixes: 067c098766c6 ("of: overlay: rework overlay apply and remove kfree()s")
>>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>>  drivers/of/overlay.c | 27 +++++----------------------
>>>>  include/linux/of.h   | 13 +++++++++++++
>>>>  2 files changed, 18 insertions(+), 22 deletions(-)
>>>
>>> This isn't applying for me.
>>
>> Weird, patch can apply it, but 'git am' does not work.  I see that when
>> I try that on your dt/next branch.
>>
>> The problem seems to be that I did not create the series on top of
>> dt/next: 5f756a2eaa44 of: overlay: do not break notify on NOTIFY_{OK|STOP}.
> 
> It should be more than just that. It was also not any base I have in
> my tree, so 'git am' wouldn't try a 3-way merge either.

That was the only thing patch mentioned when it applied successfully,
a little bit of fuzz around the few lines in that patch.  I thought
it a little weird that 'git am' didn't handle that, but it was easy
enough to rebase instead of debugging git.

> 
>> I have rebased the series on top of that patch and am sending v2.
> 
> Thanks.

I just now tried the v2 series emails on top of your dt/next and 'git am'
is happy with it.

> 
> Rob

