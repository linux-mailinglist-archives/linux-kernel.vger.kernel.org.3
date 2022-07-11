Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE4570A33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiGKS5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:57:28 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC4286E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:57:27 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a20so3550514ilk.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Fgbmw4uDNZm6f7Vc/Bsq7a4PLO0LnPjodqYsQmzIdk=;
        b=A/DvD9KRP9krYQo+DRJrHbiJB7xiDCRxuT6mthX0PxWijJdEFZlpbC5xlM0pbb1RX5
         bAxQ+2Y5FIUFC5NBWJPgveogalEmJ0jrcfj2jG3GjMI/CiI2IGWxi4ghl/ouDprBCUbB
         aeXqe4LalLkPFtcC3QO1+dltzSduinsbaTP0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Fgbmw4uDNZm6f7Vc/Bsq7a4PLO0LnPjodqYsQmzIdk=;
        b=yZ4+5yaDE7dGgaP5+A2pSQyIIURk+yNh0TXjpHd61I4ruXWIixzqnOOVgckLnD7KGU
         W3JvaPx7krLOHiL/VwHoDBKLSa1q/N3gL/3gIeguag8qCBZTC5YNcZbaOmqpUlqbhcpV
         Df0nrft9VMezOpP6zOOwTkgtNkOVfyi3RCdgKGuY3m0BeDKKUyG33znGeF36psdSgRuK
         O7soxycJ+X1UIstqmbvEjhUZWPm6lbAONomPL/n7cs6sAl1O4D/T2FTfKytL7aDHdHo2
         fKIzAK+aNnFxai4A37/qyBwWi+G7zre6I2gqLVY9/ozeRBcplvg94p6+PQ0+LSdyacPv
         dDwg==
X-Gm-Message-State: AJIora+WT5+saagVdjspNZuHtfLXhx2A4/DYADBrveNAB1ftnVirM7Ze
        KJk6jn9qY4Z0rGe221fK3r4huuSiGfS1MA==
X-Google-Smtp-Source: AGRyM1sVZES2YR3faa48MS8RCvVxvUPsXZ7hq7rtSzKygK6KwbhLBUysi45Zwayp9AWIjHCgI4/JpA==
X-Received: by 2002:a05:6e02:11a2:b0:2dc:3cef:d430 with SMTP id 2-20020a056e0211a200b002dc3cefd430mr10246851ilj.279.1657565846695;
        Mon, 11 Jul 2022 11:57:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p25-20020a02b899000000b0033de67b2ae3sm3230063jam.122.2022.07.11.11.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:57:26 -0700 (PDT)
Subject: Re: [GIT PULL] Linux Media vimc update for 5.20-rc1
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <7e719640-80e6-b3ab-751a-156b8e74d87b@linuxfoundation.org>
 <20220709111450.12e1dd61@sal.lan>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <28dbdf2b-3960-16c7-ff5e-30ea112e3f5e@linuxfoundation.org>
Date:   Mon, 11 Jul 2022 12:57:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220709111450.12e1dd61@sal.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/22 4:14 AM, Mauro Carvalho Chehab wrote:
> Hi Shuah,
> 
> Em Thu, 7 Jul 2022 10:28:37 -0600
> Shuah Khan <skhan@linuxfoundation.org> escreveu:
> 
>> Hi Mauro,
>>
>> Please pull the following vimc update for Linux 5.20-rc1.
>>
>> This vimc update Linux Media 5.20-rc1 consists of enhancement and
>> cleanup patches:
>>
>> - add lens to vimc driver and links it with sensors using ancillary
>>     links.
>> - add documentation for lens
>> - changes to make the code readable and maintainable.
>>
>> diff is attached.
> 
> Please also send the patches individually to the media ML, as reviews
> happen using them.
> 

These are already on the linux-media mailing list and have been reviewed.

thanks,
-- Shuah
