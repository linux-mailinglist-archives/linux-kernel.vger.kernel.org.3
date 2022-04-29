Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859351511C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379295AbiD2QtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379311AbiD2QtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:49:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76D6E56C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:45:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m23so11255693ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stargateuniverse.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GdE7uxfylBXcKXRnbalSbzPRUlW4mM3vMMcpsmb6gf4=;
        b=CtzIcMYT5MNlqW4XD03LGBccJeLEF87y2+khbc6wC9VhaOX+eEK91GHhq8MnZiooXn
         2/tNBq5PE8HEREVqzCthyzDhyYLR2We+G/NHRVlxxNYpwtJd0Vf7euUmMv+YQrXP+aai
         i1IOsR60TL4oK2X5N3yZqk4vNER90Bv+hFiHll4GQUtXHtKP2eq2dZlchiOr8A9r9Szs
         tSt7R68vtoyLcywFczPVKuFyaMXPbvB2cuyxcG3Qb0kZLWIcWTb85L0aIpgzXSraoJ9u
         0jnPAQIb1InpSBgMYyQjes12uc1C4J4NfmsjlgbMkVwIiJYo79sB21Fg+ZNYVcX7tclT
         iagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GdE7uxfylBXcKXRnbalSbzPRUlW4mM3vMMcpsmb6gf4=;
        b=QEVXhpBUbOGtm0otm6WfxuU2Jtgt6JgGKA8lGUZxJaw1CYR9Fr2b9q0GpYds12wQx0
         MjVVx2xIRF5fk7DqfCMt1J1qEiQ4p7+AOEJ3Nc5jEmhldVsisMLDftrFRuS99QJlL6UG
         9ogbdbYTYwCdfrsHaRvQZohSXlyAcSFWbOZbwu5eRkAblmkaT/xKnDvl/NaDsPXAvOK8
         nOedDVZ36xhFf+CYdJIluNC3PYBSkGX0Dl8Cja3Dk7jsWz45cDRBQmBLxCBPWpwGqcPb
         BhKH4dR29fUGlTmD0iLzw7KGq7ZRYzdG9cN/Q418H+GJCnMQVF2HCeqnbW3pyITUyMzo
         FPZw==
X-Gm-Message-State: AOAM530Mpj19Wkjw2W9I09jkGjbgY2d9pSYQBADgnPI88WwJQb1YwH76
        U8XFi4G86QxUT2S2Ycs86cCieQ==
X-Google-Smtp-Source: ABdhPJzwAmysseFvxInlEq7Zvcqs6QEGDQdFtbvEXtgjMsucFYEvSYHPuXe2V7DF7bTD2VEtmrjRRg==
X-Received: by 2002:a2e:81d1:0:b0:24f:728:a16c with SMTP id s17-20020a2e81d1000000b0024f0728a16cmr55792ljg.333.1651250740304;
        Fri, 29 Apr 2022 09:45:40 -0700 (PDT)
Received: from ?IPV6:2001:14ba:9cae:8c00:9682:e720:334f:2fac? (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id z16-20020a2eb530000000b0024f3d1daeafsm317565ljm.55.2022.04.29.09.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 09:45:39 -0700 (PDT)
Message-ID: <0bf74850-fa56-9dbe-7b08-f66a9fcd39e2@stargateuniverse.net>
Date:   Fri, 29 Apr 2022 19:45:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: NTFS3 driver is orphan already. What we do?
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net>
 <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
 <CAKYAXd89Ypc09ZkuZT+w3TDscpB8_=wHY=JpZJb7LY1LDg+7Uw@mail.gmail.com>
From:   Kari Argillander <kari.argillander@stargateuniverse.net>
In-Reply-To: <CAKYAXd89Ypc09ZkuZT+w3TDscpB8_=wHY=JpZJb7LY1LDg+7Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.4.2022 3.47, Namjae Jeon wrote:
> 2022-04-28 2:47 GMT+09:00, Linus Torvalds <torvalds@linux-foundation.org>:
>> [ Sad state of affairs mostly edited out ]
>>
>> On Tue, Apr 26, 2022 at 2:22 AM Kari Argillander
>> <kari.argillander@stargateuniverse.net> wrote:
>>>
>>> I also did suggest that I could co maintain this driver to take burden
>>> from
>>> Konstantin, but haven't got any replay.
>>
>> If you are willing to maintain it (and maybe find other like-minded
>> people to help you), I think that would certainly be a thing to try.
> I can help him.

We have now discuss with Namjae and we will start this and let's see
where it goes. I will get my PGP signed soon. I really want code to be
in kernel.org so that maintainership is easily transfer if necessary,
but let's hope long and steady route now on.

Hopefully we are ready to start by next merge window.

     Argillander
