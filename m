Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6A55A3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFXVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:48:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA087B56;
        Fri, 24 Jun 2022 14:48:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l6so3157291plg.11;
        Fri, 24 Jun 2022 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cqDPhxwA+fQ6/Q7mForQQgzL/CTmM3l1w6GHFMlWWsc=;
        b=idPiRHTllzehnm0hBLvbknV90TBlRCI3c1TtxVG/gaKR2nNgm3JfmmZAiRD7u6Gmvv
         GLEZMjHof5cqw0cLzxJ+EwaJcQYFDqL67+UNL8OhhaNiFOUWX4TV+gEBvoKGNajseXy8
         C5hxZHwJmUKIAvsfzZKA/MBarPp1PVHvpDOav6ClmknikR7eyzNIJb94/4KoHA6mtjVD
         zyFvcYeUbyffIsmjJ5lduQeuZAixF2NdSJqqkDsMh9ldm0wjgHMcJLq4DPrYNraxSbxI
         YIAS/TfOvN/cgqG0RYGdycW9V++aWely890/u4gWag80dtKHuVR9gHOmHxZMoyGF4RVl
         bkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cqDPhxwA+fQ6/Q7mForQQgzL/CTmM3l1w6GHFMlWWsc=;
        b=QNfBbjLBqhj5nGgJqvSHig1GSHnpxS3eEMfgRuhbTFldqPQQQ/A59ulUiVCujmd3JJ
         9yJSNuJMARdYaM+dQ4Ww8U+df7ES9nD0bbAyGD6l2n2CYYxG1kVYckMGuGrucgmR0UIF
         46Ha+45aTPJodq0B9zEUWqKZDi2Q/jFm7CATuxgMSL5LIWOGY3b/Q9j76j/WfLfeMMmV
         5M7A6OfaYwPw+ENIzj2qD++ieWDofypjDApfeSMNtpMadj78VvtVVt9eWPax/TLBueYt
         H8bmiinCaUdxCR+606HuRoe0fgS2nE4f/VtU/NELkiNTaiG7FoYK5rhbAOUeoQwoqJMk
         oz/A==
X-Gm-Message-State: AJIora9DvN9GyvqN5OQPtS9SBi6+PjsKC0UD1Q3HZxSc9Q9yFLdqhdIJ
        LviIUkxOHyM2KaA93ZE9NUg=
X-Google-Smtp-Source: AGRyM1ul7wBE/s4SS69T9P+A3QQIyfZjNS2MajPSGhmiMqFnHhZ7UgSN4pzjQ7PhP0oJrQxIvb6Fvw==
X-Received: by 2002:a17:902:f10b:b0:16a:198f:bedb with SMTP id e11-20020a170902f10b00b0016a198fbedbmr1266563plb.16.1656107327939;
        Fri, 24 Jun 2022 14:48:47 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l189-20020a6225c6000000b005255263a864sm2204718pfl.169.2022.06.24.14.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 14:48:47 -0700 (PDT)
Message-ID: <c051ba46-8fdd-0990-ce76-0fbc7647f320@gmail.com>
Date:   Sat, 25 Jun 2022 06:48:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/5] docs/doc-guide: Sphinx related updates
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <87h7493kaj.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87h7493kaj.fsf@meer.lwn.net>
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

[+CC: Jani]
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Hi all,
>>
>> This small set of patches fill in a couple of missing info and update
>> outdated guidelines in doc-guide/sphinx.rst.
> 
> I've applied patches 1 and 5; I'm not quite sure where we stand with the
> others...

Yeah, I've got lost after seeing all those different views on RFC 3/5.

I'll post v2 of 2/5 as a single patch soon.

        Thanks, Akira

> 
> Thanks,
> 
> jon
