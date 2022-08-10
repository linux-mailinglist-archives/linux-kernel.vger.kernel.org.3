Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290358E48E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiHJBfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHJBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:34:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE636E8A6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:34:44 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r69so6460269pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=TlNKkwKDBQ+04BfJnUXiFCzysd/fVDo0WONXG26HlxA=;
        b=kqVSeQzsjQpfBVvbN73SjVRJadGQFow/DtfCgkHsTLZnK/efYxkfTr8S5WoeyCXjHV
         pe5pjauoZUEvr2KMzs15jEEB/2dc7rlzAwyBXXNWQ39UIOrJlAou8r2WoD1UzKoivPyP
         uaC9z8srgJClFgBT8tceQCTeqOTEPrDp0g+G1/WiOVraHOejiCDooY2j72K6Td29c5G4
         uBPEvj6spTRqqkvERkdM3TXd7jpvDHSugwHocceRzgc+mT2aJVvfarbcA+u4hPxcml5l
         /+nM7HbagbRO36FdH1muL9P7A72JN9MrehnoN2+IuJ4zl0FWztPJjtupeXKyHIzB31Gz
         8hJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=TlNKkwKDBQ+04BfJnUXiFCzysd/fVDo0WONXG26HlxA=;
        b=W6Rv3V1JO3KeFMsjisJH7o0/5VFNI66AqyUGkFbWAis0MUABdzP2BzcMacl8vwz4jP
         F81EJ0PjsTUNoP/cOFsZwnVvgykglgQxzrRj4sOvjZpjlmZkVljtE7YQIPlhn1NS3RTm
         8Buf5fhoRtoNmQ5LR0d2/TTCPakCKlCQt6h3yXIjB5TDVa37SBY3SaY4Br1jd3lwCvPu
         tjK9jcz6aoQFlAqvedYAtAMCLVAoiLUPJoiG6LhrlvJ3rNMlB6URDVhpPZMD15+rXiII
         2B6RsFe2yX7n6gQShZhCFUtQ2vt1qyt2uol4B2jumRPkpKNGrxqmUAiu4b3aKfc2GXmI
         HjBA==
X-Gm-Message-State: ACgBeo2i4QiDZxbm7J34fiEEHmwtvUdyR5DazngZRGLwQl6aJGUTfp2q
        UuAuBv8mxXroEiSab4nA/Vg=
X-Google-Smtp-Source: AA6agR7hnxxrUhlrsUca76wvZ5vD6JSnVFWcZLhmUg3OpMtnIt260/2O4etXR+QWOyCDd5/FzQMYzg==
X-Received: by 2002:a63:6406:0:b0:41b:f291:2cbf with SMTP id y6-20020a636406000000b0041bf2912cbfmr21957291pgb.96.1660095283683;
        Tue, 09 Aug 2022 18:34:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b0016f057b88c9sm11538048plg.26.2022.08.09.18.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 18:34:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
Date:   Tue, 9 Aug 2022 18:34:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net>
 <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 17:42, Saravana Kannan wrote:
> On Tue, Aug 9, 2022 at 3:30 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
>>> The uevents generated for an amba device need PID and CID information
>>> that's available only when the amba device is powered on, clocked and
>>> out of reset. So, if those resources aren't available, the information
>>> can't be read to generate the uevents. To workaround this requirement,
>>> if the resources weren't available, the device addition was deferred and
>>> retried periodically.
>>>
>> ...
>>
>> This patch results in a large number of crashes in various qemu
>> emulations. Crash and bisect logs below. Reverting this patch
>> fixes the problem.
> 
> Hey Guenter,
> 
> Thanks for the report. I'm kinda surprised because I had a pl011 probe
> successfully in my local testing.
> 

Maybe it only happens with qemu emulations, or with certain configurations.

> I'm wondering if you are having an interaction with some other changes I made.
> Can you try pulling this series in and see if it helps?
> 
> https://lore.kernel.org/lkml/20220727185012.3255200-1-saravanak@google.com/
> 
>> Additional information: The decoded stack trace suggests that the
>> "id" parameter of pl011_probe() may be NULL.
> 
> That's strange! I'll take a closer look once you confirm that the
> series above doesn't help.
> 

That series does not make a difference.

Guenter
