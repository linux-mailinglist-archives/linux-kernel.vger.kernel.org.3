Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA14CA995
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiCBPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241397AbiCBPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:50:12 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F264EF5F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:49:12 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id c23so2341834ioi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YKCrWj+1zMKlxKPB/IddCWs5wzrSW0P5NglCuipbZCs=;
        b=eJxM/77B7ssFxi/0g1GKRtMpbZuhJOTlH8h19DcfwD6dL6zYrh6mfF5ZTegp7ireD6
         S+YkCiFvI10DeKstOWdhQlMoYZ28GtJblXh7FxiMKbHHFUPTug1yG9XwA/VIjY+KvJYe
         cvLD61wDFA944OtrZ73NZRdAx5JN2VLBTt0KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YKCrWj+1zMKlxKPB/IddCWs5wzrSW0P5NglCuipbZCs=;
        b=qzltpTdqBph60oD4hFBihdPZUkMLSBoT/c4Z2lXX8mRjSNvLu7aK+APB7w5FcQZXn0
         EPV4VpjLHRlIPVtsr0OMt6ol7Aok6K3CLsFXmOH3xsll9Vj0QXet+4VFe7GFG7mTd9b+
         yTphTP2yXcCQMFHLa6aquS/FyE8ALZARICxx8B/WCLiYstjCv2CHrr63LoHLeFYbUmaW
         E938nLEo2rW6Ov5iE3G6/Yq7RSz7cwLBetbljFSErGpxRwa8v82MyXTHVR3mxy8p6MfX
         PoCJ3YfG5xCvTGKnEnDykNmh4WgNzaF7XVQftKMY7XaiGVlIFddWtPpO1M5MuIUwlEwb
         TChQ==
X-Gm-Message-State: AOAM53185ImkOCDEEav0HCjtqWSRyOI/lJXbFOdFQZFqFL6ZDkyhAZ/t
        YMbGciydNbQ3dCk019SHO7DnfA==
X-Google-Smtp-Source: ABdhPJwtlAzsfpKnWWZ+BUdUXjOYZfh0Ht45nhh4y3ukmKQ/VxVRY+e/gtZDfVyzHk0kEB7Zl9JCTQ==
X-Received: by 2002:a05:6638:bcd:b0:314:9138:8344 with SMTP id g13-20020a0566380bcd00b0031491388344mr25620647jad.64.1646236151869;
        Wed, 02 Mar 2022 07:49:11 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id p2-20020a92d682000000b002c291ae0e1bsm9724283iln.23.2022.03.02.07.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 07:49:11 -0800 (PST)
Message-ID: <b4d057fd-cccc-571a-0941-061c6a26cbf0@ieee.org>
Date:   Wed, 2 Mar 2022 09:49:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [greybus-dev] Re: [PATCH] staging: greybus: loopback: Fix Coding
 Style Error
Content-Language: en-US
To:     Ahamed Husni <ahamedhusni73@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220217190722.44894-1-ahamedhusni73@gmail.com>
 <Yg6hcX6XK4Eu0KOR@kroah.com>
 <CAFjpAKqy908scQTRJPkMhEz8OyNiR3-N8XD2hiGa+VBLhUf0VA@mail.gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <CAFjpAKqy908scQTRJPkMhEz8OyNiR3-N8XD2hiGa+VBLhUf0VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 10:52 PM, Ahamed Husni wrote:
> Hi Greg,
> 
> On Fri, Feb 18, 2022 at 12:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> Did you try to build this change?
> 
> I am a newbie kernel dev and trying to understand how things work.
> I did not build this change by the time I sent you this, thinking this
> is just a style change.
> I should have tested the build. I am sorry.
> 
> Now I built the changes by setting the following configurations.
> CONFIG_GREYBUS
> CONFIG_STAGING
> CONFIG_GREYBUS_LOOPBACK
> 
> My change introduces the following error.
> ''''
> drivers/staging/greybus/loopback.c:166:2: error: expected identifier
> or ‘(’ before ‘do’
>    166 |  do {            \
>        |  ^~
> ''''
> I could not fix or find the reason for this error. Please guide me in
> this regard.

You should understand that you cannot contribute to the Linux
kernel if you don't understand details of the C language well.
And you really must test your changes (certainly a build test)
before you send them for review.

To answer your question, the macro you changed does not
expand into code that is itself incorporated in an executable
block.  The macro is used to generate entire functions in a
unified way.

					-Alex

> 
> Thanks,
> Husni.
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

