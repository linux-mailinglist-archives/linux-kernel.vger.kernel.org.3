Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF4C576794
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiGOTiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiGOTin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:38:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBC638D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:38:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r6so7565129edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EcHI0RFme1P+FHdB6sWN7r2D7IfzNHh0dba57jzLiec=;
        b=PVXIyx1Jlo5l6dsDhDIeAOd52cDUe7BouKInskEDgw8F3WFBCdhmvz5PfRtKvdKW/Q
         EfXTW+WHLZIdjdc9lyi5A7r3n5erxOZ/T/gqpmwD5/EnofvbaSNz07NwKK9UpEs554sx
         oo8GPoaNK6MZMEhkEv39Aw5p1G3EBnVHea05lqXnaXP+rlaQfkpWttPoqd0YnL6KhmF2
         lnzGUXm/xRRhVUKh2ooV37jau1IJjnD9J/9byJZ1BJqRVt60YyD61RkZU9LTOm/6CTM+
         rAqQTki+ZLUhz2rcrbFTSUVUjKPjvfIwnGvhbSSd1cSUihw5EPCcblzhJOaYisyKfxnr
         tsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EcHI0RFme1P+FHdB6sWN7r2D7IfzNHh0dba57jzLiec=;
        b=R26mxxE4Vdo62Wb+vUPQPvxkSQg6Rv9zo7wpzjtSvlLk19W0b9zY4FspzTkbAg8W6U
         XSVxSiP7hesD1UlynbqNhx2jn6sEJxP7ttFl5+Jp2RajL/wrGam0rmMbOFNoRfTDRvng
         1ziPHxnYIHJWDeFVVIMF2FC9jGY7zv9rKJLgsoMyMVz5Rjrfxiy6HoVRIOo77JHmkP5q
         jt/MGYLY+km5jD4kEv+HECiHI7iwJXWOikQoxOwZvGEg6DXzcSzuOprtdcu5wTR8Flzv
         oC8t1w6NgNFHC1kkeyE9uGBF2I5xUEm4lHpA8pLOz5DbF5Y7dlrj3J7V+K2qLJ+0sSqp
         l93w==
X-Gm-Message-State: AJIora/p7uGnKe11SuzEXHCcc1Ave0PGbm0I58+hHbIv3HmvtoqFq2/z
        nJvmHD4KlLGnFfrw9lfkzE0=
X-Google-Smtp-Source: AGRyM1t7ZLWeZqKRDMnbSZm440nvKe3q7hq5HnywN8/NkfbVf3xIOHWfjSVlGbYdoxccZXlAOXhWPg==
X-Received: by 2002:aa7:dcd5:0:b0:43a:70f7:8e4d with SMTP id w21-20020aa7dcd5000000b0043a70f78e4dmr20604931edu.85.1657913919826;
        Fri, 15 Jul 2022 12:38:39 -0700 (PDT)
Received: from [192.168.1.4] (78-3-70-107.adsl.net.t-com.hr. [78.3.70.107])
        by smtp.gmail.com with ESMTPSA id cw11-20020a056402228b00b0043a8f40a038sm3370511edb.93.2022.07.15.12.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:38:39 -0700 (PDT)
Message-ID: <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
Date:   Fri, 15 Jul 2022 21:38:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow device
 open
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Daniil Lunev <dlunev@chromium.org>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
References: <20220704000225.345536-1-dlunev@chromium.org>
 <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com>
 <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
From:   Zdenek Kabelac <zdenek.kabelac@gmail.com>
In-Reply-To: <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 15. 07. 22 v 11:36 Mikulas Patocka napsal(a):
>
> On Fri, 15 Jul 2022, Daniil Lunev wrote:
>
>> Hi Mike,
>> Thank you for your response. I should have probably added more context
>> to the commit message that I specified in the cover letter. The idea is to
>> prohibit access of all userspace, including the root. The main concern here
>> is potential system applications' vulnerabilities that can trick the system to
>> operate on non-intended files with elevated permissions. While those could
>> also be exploited to get more access to the regular file systems, those firstly
>> has to be useable by userspace for normal system operation (e.g. to store
>> user data), secondly, never contain plain text secrets. Swap content is a
>> different story - access to it can leak very sensitive information, which
>> otherwise is never available as plaintext on any persistent media - e.g. raw
>> user secrets, raw disk encryption keys etc, other security related tokens.
>> Thus we propose a mechanism to enable such a lockdown after necessary
>> configuration has been done to the device at boot time.
>> --Daniil
> If someone gains root, he can do anything on the system.
>
> I'm quite skeptical about these attempts; protecting the system from the
> root user is never-ending whack-a-mole game.


It's in fact a 'design feature' of whole DM  that root can always open any 
device in device stack (although cause some troubles to i.e. some lvm2 logic) 
such feature is useful i.e. for debugging device problems. There was never an 
intention to prohibit root user from 'seeing' all stacked devices.

Regards

Zdenek

