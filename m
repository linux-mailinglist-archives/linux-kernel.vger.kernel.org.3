Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76164B02EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiBJCBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:01:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiBJB7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5220F47;
        Wed,  9 Feb 2022 17:33:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i186so7611917pfe.0;
        Wed, 09 Feb 2022 17:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4sj14rtRoVmxZmbMmcizN591/avwt5U5t3eSZf+n7tM=;
        b=ZgwicGhSBoaVXgnDtEuAUBV3wsoCgxQVqCzRyOzqCeO4t3Gh6zMrqdvVA7aNESiXBj
         FD4P+Egf9iqtofp66i94rpFpD2hYWGKi56q/QgVvV8YzSTwM0CzHWWOk9DVLeZj9mMji
         VaXupk274rwzapOlDszXzrvbCg1qP1a+SPAuY4KtalsDfgetDU7mslNgI7kF6Znh2HFi
         /+G7LYh1aLx2VyMfwzZ3FnD66dovIxb+/00OL3fjF6Posn3Ifm041mQpcBg+v6hYgm2e
         itT3zuBG1ABWB/Bh5mmA3dA4BbhBU8fQXNribcA6jUHWqctNZA4RKRDKjdl2vwNmNU/+
         aYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4sj14rtRoVmxZmbMmcizN591/avwt5U5t3eSZf+n7tM=;
        b=pVajQQwTNpxuZBCsPVijKhPDBCL8VTl1tMhJK0VJsNemx4nQqIenohjyb+nt8mpsuS
         Pn1AcQ41lrUeft4CYc+TTmRRYjM255EeR7naUtm5k6Bj3nhWWudE+IzXHefrR+qev8rQ
         yhC6GegGLrvqexLSjjTQpa1LIK2Ip5Z1LZWrCg2uEXUPERPgf8EwQJuPERrHHrHwuo9E
         r2UiC5I659uFoF9+MgcxshRBI7y/m/D2b5RPichtkT8oviJOyeMxWEg2ftJ0ffth5WoV
         DUGVqiLeZxjjHred+H7pwwMFJ3Nq8hq12WW4aGWeOfzmtV+5ACRhyXngjgRLMP6yZqni
         DlCA==
X-Gm-Message-State: AOAM532ubmkoQ747ykXPOfiYrRYlitJ+XbIGl4bIur/p3NaxbbYwjAMq
        eKlXDMoyct3Jh3lZoZ41f2rXHGBDvQY=
X-Google-Smtp-Source: ABdhPJw+wmM0pA/zoRQN4pC1DaDWrD+e6be0JsxtlgnvKU3sYEUA7iWMrJ9oWwRa6ihRjBxpWqDfAg==
X-Received: by 2002:a05:6a00:1485:: with SMTP id v5mr5123698pfu.44.1644455410415;
        Wed, 09 Feb 2022 17:10:10 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id h4sm20881470pfv.166.2022.02.09.17.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:10:09 -0800 (PST)
Message-ID: <00460e1d-a76f-b6a7-ee60-fcc812f6aa0c@gmail.com>
Date:   Thu, 10 Feb 2022 10:10:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
 <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
 <20220114094535.5bb9ba94@coco.lan>
 <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
 <87bl0c7l79.fsf@meer.lwn.net>
 <3cfe6cb0-67c7-bd12-0a3c-a609f5341a32@gmail.com>
 <874k57ef69.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <874k57ef69.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2022 17:30:38 -0700,
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> On Sat, 15 Jan 2022 14:17:30 -0700,
>> Jonathan Corbet wrote:
>>> Akira Yokosawa <akiyks@gmail.com> writes:
>>>
>>>> We are in the middle of the v5.17 merge window, and I think of this
>>>> series as a v5.18 material.
>>>> Which means it won't be merged into doc-next until v5.17-rc5 or -rc6
>>>> (mid March or so), unless Jon thinks otherwise.
>>>
>>> I'd rather merge it rather sooner than that if possible; 5.18 stuff will
>>> start going into docs-next shortly.
>>
>> Jon,
>>
>> Hearing no objection since mid January, I think it is time for you to
>> merge this series into docs-next.
> 
> That has been done - thanks for your work on this!

You are welcome!

> 
> Since you seem to have a reasonably good understanding of the
> PDF-generation side of things...I noted as I was testing this work that
> we are still getting the "restricted \write18 enabled" messages.  I
> asked about this years ago, and nobody seemed to have a clue of what was
> enabling it.  I'd *really* like to turn that off if possible; do you
> have any idea what's going on there?

I think I know the answer.
The message can be silenced by adding an option to xelatex.

Will send a patch soon.

        Thanks, Akira

> 
> Thanks,
> 
> jon
