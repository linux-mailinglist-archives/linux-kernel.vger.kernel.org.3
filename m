Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E722C4DAC08
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354331AbiCPHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354319AbiCPHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:50:41 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B825B3CC;
        Wed, 16 Mar 2022 00:49:27 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id qx21so2301959ejb.13;
        Wed, 16 Mar 2022 00:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=tUhUqhCZr3Ci9RwcBawEUsZqc3exEqG+C+hiEi1bt3o=;
        b=Qdz3pKmqBlQml7ykunNJ/2JZd3cNQv7tHehFkUAPf34XiFOrK/ikMKNpdXu8G/GVS6
         0Ue/yjavDy5/F7t96PQjwftMdCCZ9Ox161NdP8UQvaUvIOPOrv+eeWAdpRMMhWwVckvv
         eXUdgGgGv970IJy8V3q7YBrlxFrNr1OHGzW3UItTfUouFZom1PNsM4eygMYGcXG3k2t6
         2y02UvdiKXwMQdCZA5mEFPZ7PBk6lHzauVpgtlk1E7TvqITAeaSbxBnMoxiF1puw9mbW
         GuSY0kT8Q9K1RreoBFhDuq0H6Rpn50WWr0rHCQ6kdNhPLUcSR/jWo4NaHJ7566IlpY3P
         siTg==
X-Gm-Message-State: AOAM530NbhmDwpkFtUrkha0QJsuoWXoCgy5E4OOrTXjhUHz+HbdaI1lh
        0qUS4i9QmPUWo/GPsYGKYyhAhzIjjL0=
X-Google-Smtp-Source: ABdhPJyomDpckdtCRwpmmD3AhOt4xIymEoU15tK2Y1+NiAVFCV2W9tXei0gENoMkOVoEhK47YRiRsw==
X-Received: by 2002:a17:907:1c10:b0:6da:6316:d009 with SMTP id nc16-20020a1709071c1000b006da6316d009mr25815337ejc.621.1647416965904;
        Wed, 16 Mar 2022 00:49:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y20-20020a056402271400b004187d967b1asm564659edd.84.2022.03.16.00.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 00:49:25 -0700 (PDT)
Message-ID: <af1c7dd1-d86d-d737-643e-1f20a19c3890@kernel.org>
Date:   Wed, 16 Mar 2022 08:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@qq.com
References: <20220304100315.6732-1-wanjiabing@vivo.com>
 <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
 <87mthw2o93.fsf@meer.lwn.net> <YixE4K3ScGL3v5yQ@kroah.com>
 <eee93a4c-2629-af0f-03b3-4379a128c7dd@kernel.org>
In-Reply-To: <eee93a4c-2629-af0f-03b3-4379a128c7dd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 03. 22, 7:16, Jiri Slaby wrote:
> On 12. 03. 22, 7:59, Greg Kroah-Hartman wrote:
>> On Fri, Mar 11, 2022 at 02:06:00PM -0700, Jonathan Corbet wrote:
>>> Jiri Slaby <jirislaby@kernel.org> writes:
>>>
>>>> On 04. 03. 22, 11:03, Wan Jiabing wrote:
>>>>> Fix the following 'make refcheckdocs' warning:
>>>>> Warning: Documentation/driver-api/serial/driver.rst references a file
>>>>> that doesn't exist: Documentation/driver-api/serial/tty.rst
>>>>>
>>>>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>>>>
>>>> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>>>
>>> I've applied this.  But I have to wonder why Documentation/tty exists at
>>> all; is there any reason not to move it all under driver-api?
>>
>> No reason at all, it should probably be moved someday.
> 
> The only reason was that I don't completely understand what "driver-api" 
> should contain. To be presice, documentation of line disciplines, tty 
> buffer and tty internals (which is all contained in Documentation/tty) 
> doesn't belong to "driver-api" IMO. If it it preferred to be there, I 
> can move it, of course.

Returning to this: staring into Documentation/index.rst and 
Documentation/driver-api/index.rst. Looking at documents/paths they 
reference, I still don't quite understand what is the rule to put the 
stuff to either of them.

What I used to decide to put the tty stuff to the root is that it's not 
only driver-api documented there. It documents also tty internals and 
implementation of some line disciplines.

So, now I'm confused why it does NOT belong to the root.

thanks,
-- 
js
suse labs
