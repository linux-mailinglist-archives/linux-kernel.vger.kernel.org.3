Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2B520845
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiEIXVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEIXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:21:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8E4BBA8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:17:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c11so15230747plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PU4arDubhm1mzoeAqk+ohB9PA5pICkopZ+sBRgK14Kk=;
        b=7fY6KgqJhEepDJm10bht2MW1aTCNWa43SllusX6jo4tXsf49BXlV78tOsGgFq+tJ6J
         coM5YuJnbKDyFwjqNfRt5B84ZqBoeIj+pD4e0xX42FMUShP+tDfWeVxdH6ziHSa/MGTq
         9rBTEaBXZxkX6XABsGex6Ana6VJHyDYc3kFHXAYA7Cin0hBA7vLdubdrxhsnmKIcEHOU
         /VpHHc2oKthf8FS9poqau+omXaGTZWmSYGvUwt/uZJv58sa9m0icsvXRTiXi4qH1KUir
         p79FGtnnL5poT5LGHLi9biSKTVtpt9HHkcBxBV1I/+wDt/gJMxnXifCAcjbQoCuifuEy
         zc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PU4arDubhm1mzoeAqk+ohB9PA5pICkopZ+sBRgK14Kk=;
        b=ipYtEXUopgFv19ZRHFZPyOeGeBQKCvhX1Yd9N2eezral565zoauWas2BdeKIGAW4R+
         CbR6lNFOlZEk/ve9ic6gprf3nuCYMIemgBt7Km2e7sto57SdFamG+CkUV6fnaqcj5CAp
         zSBhtz0upPyJkgtutIPriAWGXBcjsD6XiXO0+CjUSP992e7PWNa3W+xNUnBkc2n9YEtK
         bVfhkhVSNW+zZ848lWwYMAVGBIVdref51y2uMEZ6jszp7GM9i/ARv9oBprjLyaLuhk7T
         DQK1Hh+EzGWZrBZCNF2idmCL+n76RrNIxT8o/ZWDnoi+jUomRI2vApqY5wCzIiamwPD9
         8Nvw==
X-Gm-Message-State: AOAM533D7lxmQSAqNLNhtyMWACiZV34ekvpuFcew05pHRt247qwQ/ojz
        j9VIVidlcXMZuu3M+OV07bIDYA==
X-Google-Smtp-Source: ABdhPJwqDxGwEZbmXACLYvDOlColRDAsLIHv+sM+2WP6mnY1nLaqlf0CiPDWRtwPWKNu35JLsr5Mtg==
X-Received: by 2002:a17:902:ea06:b0:15e:8367:150b with SMTP id s6-20020a170902ea0600b0015e8367150bmr17410856plg.167.1652138235381;
        Mon, 09 May 2022 16:17:15 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z1-20020a17090acb0100b001dc7623950csm268949pjt.11.2022.05.09.16.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 16:17:14 -0700 (PDT)
Message-ID: <1b504dc0-a5c4-06c8-e7b2-b3a859e15ad9@kernel.dk>
Date:   Mon, 9 May 2022 17:17:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net> <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox> <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox> <87bkw6cpvo.fsf@meer.lwn.net>
 <Ynmd23nhC3KHHX1i@equinox>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ynmd23nhC3KHHX1i@equinox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 5:03 PM, Phillip Potter wrote:
> On Mon, May 09, 2022 at 04:17:31PM -0600, Jonathan Corbet wrote:
>> Phillip Potter <phil@philpotter.co.uk> writes:
>>
>>> I was yes, the point I was trying to make (poorly) is that your patch
>>> conflicts with Randy's patch which itself is not yet in linux-next, as
>>> normally I send everything together at the start of the merge window to
>>> Jens, as I don't have my own kernel.org tree yet, and usually I only get
>>> one or two patches in a cycle anyway.
>>>
>>> This is not your fault, you couldn't have been expected to know this in
>>> retrospect, and I should probably look into getting my own tree/GPG key
>>> sorted to alleviate this problem in future.
>>>
>>> In the meantime, if you're comfortable with the idea, I can just resolve
>>> the conflict myself when I send the patches onto Jens this time and
>>> include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
>>
>> So I'm a little confused by the state of everything at this point, but
>> I'm assuming that I need not worry about taking these changes through
>> docs-next.  Please let me know if that's not correct.
>>
>> Thanks,
>>
>> jon
> 
> Dear Jon,
> 
> Yes, that's right. Makes sense for the whole series to go together, so I
> will fix up patch 3 to apply alongside Randy's patch (which I see you've
> taken now) and send the whole lot through to Jens as the merge window
> opens. Thanks.

I'm fine with taking these, and if they need fixing up then all the
easier, but patches from maintainers should be sent in well before the
merge window opens. For doc updates it's not that important, but please
do send them in at least a week before 5.18 final happens.

-- 
Jens Axboe

