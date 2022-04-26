Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3179550F394
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbiDZIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbiDZIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:23:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F5D39BA6;
        Tue, 26 Apr 2022 01:20:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so1581044pjb.5;
        Tue, 26 Apr 2022 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HTkhVCwB81oItW36nLwVzqqoPPJpYzHgpYIkMsBEsWk=;
        b=qde4ACVjiYLawr37T6PT5dksdblUsoa1GgAxmw56O26epijv0fY5S/aos5REMDWYCG
         JfIuyZni5momoXAwCnCqNE+ZEUOtQaLV19GuctsTU4aLJGXnT/qF3KC6QbqbvAKrPHJe
         XMXKNSxyAd8FVND+DY1oRO3ry5GQH9u5BJSCMrmatwAusRSHP1C0raAXQS+DFn6Yrs38
         3KrwPVzaaNMQhUgyC9dmAOVYb9nTfvd8zFFHDNuWfkjdt7/PpwasisaDSz/1t9OeczwD
         1MyxnHDs6zYoDccHszD7bPBNvEFOkwPT13kdjB6QdIFe61KwUWd5WPYP9h8vt8FzIu9N
         tAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HTkhVCwB81oItW36nLwVzqqoPPJpYzHgpYIkMsBEsWk=;
        b=hCysq6tAqzlEGxUpOsCvso2DS+MUTBkxVy9xJZFmMqDdbY74uK7sogsa5+OBXl4kRs
         qHlvNV9MBQ+4n1cSHeoZ7/AEyfQpBWuco0HZsXehC8fk7lrOXy5JzocQeNxqPX5nFWH1
         /Xo5WYKxn9t8fDdMcTwqf98LKRviYF0IWXLSSLqBcX5zp9Ht4nvbxwMxwJVyasK1uVT6
         tewF2tJqYTGfhbbvSpVX9MNa7HuRHQobZybKfioChPfAzN4fXYslKsYNWeiaSqtgrlt/
         KQKJ0wEtPFgV6wwoCX959T/QQcLayU5MHNYzf6xVk2AjTSV+aeJInhI26u/q5OizY92T
         YAUA==
X-Gm-Message-State: AOAM533U+F8WWSG2tPHc1BiOw0VCJikibwyAEM/H2g0S3vmXQkv4dT31
        iLdXhRnwPl2054yDr6crhlI=
X-Google-Smtp-Source: ABdhPJwXqDMtVIFw0QkmLuBxcx6aLiJkCFN1IFwubZCd4py0WHhuQkHE3qlR2hKfthPTTcPsxfFYHw==
X-Received: by 2002:a17:90b:4c47:b0:1d9:88b2:1995 with SMTP id np7-20020a17090b4c4700b001d988b21995mr7575724pjb.80.1650961224288;
        Tue, 26 Apr 2022 01:20:24 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm14947128pfw.188.2022.04.26.01.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:20:23 -0700 (PDT)
Message-ID: <73d2f4cb-9f38-ac33-b4c0-c4d3b465bf8b@gmail.com>
Date:   Tue, 26 Apr 2022 16:20:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     baihaowen <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
 <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com>
 <049ccac8-c394-0cdc-c2ed-4ea91cab6439@meizu.com>
 <c498b2a7-8f0e-4f6d-10ba-49c4c7794ff9@gmail.com>
 <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <0be9fe6a-b01e-b355-9283-6ad8372932d6@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/22 09:17, baihaowen wrote:
> 在 4/24/22 11:16 AM, Alex Shi 写道:
>>
>> On 4/24/22 10:56, baihaowen wrote:
>>>>> +        ======          ==========      ==================
>>> hi, Alex
>>> I can apply local.
>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0001-docs-zh_CN-sync-with-original-text-Documentation-vm-.patch
>>> 应用：docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
>>> ➜  linux-next git:(heads/next-20220421) ✗ git am doc_pageonwer_patches/0002-doc-vm-page_owner.rst-Fix-table-display-confusion.patch   
>>> 应用：doc/vm/page_owner.rst: Fix table display confusion
>>>
>>> I think git send-email will change format by my select. I'll try to resend.
>> Send to yourself only then get it from your email client and try applying. 
>>
>> Thanks
>> Alex
> Hi Alex
> 
> Could you tell me how do you do when you get a patch from email ?
> 
> I get my patch from email and then copy-patse to a new file, then git am xx.patch.

Don't do it. copy usually mess the format of patch.

Saving the patch email from many kind of email-clients as raw file, like thunderbird etc.
Then using 'git am xxx.patch'. It will work. In fact, git can handle the plain email patch well.


> It will notice 补丁格式检测失败。
> 
