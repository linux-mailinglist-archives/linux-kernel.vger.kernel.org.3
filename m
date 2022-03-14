Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179554D7AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiCNGRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:17:17 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE7731915;
        Sun, 13 Mar 2022 23:16:07 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id qx21so31415878ejb.13;
        Sun, 13 Mar 2022 23:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vVQ7/RX3b4FeRF4kns2gAsNW6oRAqmWEX9RQ/L41Fdc=;
        b=pzTq//lWeV6itqWyz5nDigKENa4SoyO1DERjABmb2SLnp6PicorfzZqOUbn0aHGNUz
         JSHtsGlIn4HJXEq9dxIpmnF7u1oAYbxER6ldb1lMFDanlqcp+iTYlKOD+0y7eZVo0w0E
         5wBVRxmLDOmqzJSMnhLO5D3OCewJGMoGz9kNnX+3TvqYoEmNxPBmd24WUUKavHcwp56l
         m2wRhCdh5FsTak5tipHC1pwVkkhZOhm/79mJVNBAqy/uKljnFrMd44+wuojLqydeEw8J
         ewCjIoaECWoyB2s+GW09bKlKUGCPTbhq9fYJAJMtCB6y1oOcmJYeXU/VKtzPt0lvyjG4
         g5TA==
X-Gm-Message-State: AOAM533ehFrnA5D0mk7QpEQEki1+/HlBSpPg6jd0x8JcVg1BQOfED3PM
        sfwDykA50X/KWYZbgQlsrXM=
X-Google-Smtp-Source: ABdhPJwnQVi5pXVeDQcmpt7UdavAlXBY819ipKUWTAe9wkAVFz1owCvuM7nh61awRyRSroMx0dkPPg==
X-Received: by 2002:a17:906:d29b:b0:6da:9e4d:bb7c with SMTP id ay27-20020a170906d29b00b006da9e4dbb7cmr17885990ejb.155.1647238566405;
        Sun, 13 Mar 2022 23:16:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id sa13-20020a1709076d0d00b006ce3ef8e1d4sm6227953ejc.31.2022.03.13.23.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 23:16:05 -0700 (PDT)
Message-ID: <eee93a4c-2629-af0f-03b3-4379a128c7dd@kernel.org>
Date:   Mon, 14 Mar 2022 07:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@qq.com
References: <20220304100315.6732-1-wanjiabing@vivo.com>
 <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
 <87mthw2o93.fsf@meer.lwn.net> <YixE4K3ScGL3v5yQ@kroah.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YixE4K3ScGL3v5yQ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12. 03. 22, 7:59, Greg Kroah-Hartman wrote:
> On Fri, Mar 11, 2022 at 02:06:00PM -0700, Jonathan Corbet wrote:
>> Jiri Slaby <jirislaby@kernel.org> writes:
>>
>>> On 04. 03. 22, 11:03, Wan Jiabing wrote:
>>>> Fix the following 'make refcheckdocs' warning:
>>>> Warning: Documentation/driver-api/serial/driver.rst references a file
>>>> that doesn't exist: Documentation/driver-api/serial/tty.rst
>>>>
>>>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>>>
>>> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>>
>> I've applied this.  But I have to wonder why Documentation/tty exists at
>> all; is there any reason not to move it all under driver-api?
> 
> No reason at all, it should probably be moved someday.

The only reason was that I don't completely understand what "driver-api" 
should contain. To be presice, documentation of line disciplines, tty 
buffer and tty internals (which is all contained in Documentation/tty) 
doesn't belong to "driver-api" IMO. If it it preferred to be there, I 
can move it, of course.

thanks,
-- 
js
suse labs
