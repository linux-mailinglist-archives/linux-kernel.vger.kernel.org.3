Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1E4E1D62
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 19:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiCTSQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 14:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbiCTSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 14:16:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8B7527EC;
        Sun, 20 Mar 2022 11:15:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n35so5768846wms.5;
        Sun, 20 Mar 2022 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hBX2k7bP0JuTGs4Va/cZqoPnNWMc+mP7VB6dwkEnym8=;
        b=a7edImwHxElUp+nxiHhoczI85uybUug2XQbZiUj8jMu6GG9oZjIyONWdpgH98fh0W2
         wg7cBnyT85R9tRkGV5SQm3qjxZkdTdKD6FPHX50zQXHVP9ZsMiXplcHGGSkIicsGE6fD
         sX7DW+Psq/1IeC/wWv2uw+kMKaLkeygDVvBk7d/4hn0GGTcmvjGwyc8exMaRmZngbYFw
         0uQWQddLDXWQh34kd4kf/BBJmPkJKMTkQOAX6OSwsR2tzDfbi1dg4I6+EuEa82Xczkk3
         tyb2MIR2ooKbgL8fTjyxm6bWeha43bgPtKiXwS22r7cPQZ+5fvrANHu8IY33Q5wqXVwv
         JIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hBX2k7bP0JuTGs4Va/cZqoPnNWMc+mP7VB6dwkEnym8=;
        b=HxPyogpQUkS+jCJi291GdsEq+gcicRQh8zOZ6HlvcMbZhEXjpBTxawt69MonkwKJxa
         gJ98yLg79SwpTdE13xf+fbREvewC1lLOLZcpC8ctNoX5pIB6IJ5cNDyn5zVfnB0DNt6T
         WN3hoDtzZGsqgznPNhQfkqYGgc+TUIZ5q8ycEsEvHU7KXIUCIf1ikwD7SkgVUSByP151
         gihy7WfIIQl9+3YeEH2SQn394WIv6LLAbRJYV/IacJx2T1C1Dka1c8ddJeDd4drRTS8C
         fT0LyBB4vzFTXekQLON4iu1gQxgkWkNNS10GN7JVLJgbwIam6M2O9tgbljUvAEG/RmsT
         rpdw==
X-Gm-Message-State: AOAM53266yFL7qhHOjs9MBkLEccEH1akWL7MmOxph4fGdpBxWJcJHpST
        i4M8JtPDJTXBuuj5q6lFzda3cBPFiZB6Auq+
X-Google-Smtp-Source: ABdhPJyveFwD1BJnTecZ7BvTG+hVgQovZ0eEhZCc0YsQ1xX+FrRyk5mGeQO6lFVJvUIYkVDodWGjZg==
X-Received: by 2002:a05:600c:4e0d:b0:38c:a6da:adec with SMTP id b13-20020a05600c4e0d00b0038ca6daadecmr946252wmq.145.1647800104485;
        Sun, 20 Mar 2022 11:15:04 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0038ca453a887sm1598598wmq.19.2022.03.20.11.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 11:15:04 -0700 (PDT)
Message-ID: <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
Date:   Sun, 20 Mar 2022 19:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [patch] console_codes.4: ffix
Content-Language: en-US
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     nick black <dankamongmen@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <20220320160217.gws42lklp6ishzub@localhost.localdomain>
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

Hi, nick, and Branden!

On 3/20/22 17:02, G. Branden Robinson wrote:
> Hi Nick,
> 
> Alex has been waiting on me for a review of this patch.  I took longer
> than I should have because I thought he was expecting a technical
> evaluation of the accuracy of the sequences documented.[1]  Now I see it
> was just a matter of man(7) and tbl(1) syntactical and style review.

No, you were originally right.  I did mean both, but especially
"a technical evaluation of the accuracy of the sequences documented".
You did it anyway, so thanks! :)

> 
> Easy bits first.
> 
>> Remove CSI prefix from the list of non-CSI escapes.
> 
> +1
> 
>> End all items of said list with periods, matching other sections of
>> the page.
> 
> +1
> 
>> Fix up the busted OSC command list (reset palette and set palette).
> 
>>  ESC ]  OSC     T{
>> -(Should be: Operating system command)
>> -ESC ] P \fInrrggbb\fP: set palette, with parameter
>> -given in 7 hexadecimal digits after the final P :-(.
>> -Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
>> +Operating System Command prefix.
>> +T}
>> +ESC ] R                Reset palette.
>> +ESC ] P                T{
>> +Set palette, with parameter given in 7 hexadecimal digits \fInrrggbb\fP after
>> +the final P. Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
>>  the red/green/blue values (0\(en255).
>> -ESC ] R: reset palette
>>  T}
> 
> Yes, this was majorly hosed up, syntactically.  What you have is good
> repair to obvious damage.  +1.
> 
> I have some suggestions for further improvement, but please don't gate
> the patch application on these.
[...]

Okay, thanks!

nick, can you please resend the patch?  I've lost the original email.

Cheers,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
