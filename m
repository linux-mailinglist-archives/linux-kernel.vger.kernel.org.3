Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED64F50DC72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiDYJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiDYJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:25:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE223BDB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:22:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dk23so5052072ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C+My26IIBkGHnWqzT5e9buhiPYzGS0kFzEbKHclvwks=;
        b=h19q9rjY0D6I4icTltt3JNTdIkZkWj/qR1q6wKwitvu1LQHwQXfcdR0dXCMzxIWeGT
         SWKRbOWBVMNwTdOhQAQDXXNQi4v7jOK/TC0Pqjr2/CjEuKpFLrKaAjTWO00ATyL1KfYF
         xK3pDmaEzDYzRsETeVDGTVpnXpa/IJNZFCPf7yJGpndq4/c+6JeaCN9Kof/QngF3Hb9V
         jZfDRMO/Sq9+k99wai3yPq6cFng0edfccCIXKOGcDYHD1BHNW04dGFJUIXG9gTUU8poe
         tCwquSd5fpa0PdG3ga7FMAkKTeaqMGgKQNdYgcDF0ByaDQsScV6ZdddQgLVIvxz0rjFJ
         qFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C+My26IIBkGHnWqzT5e9buhiPYzGS0kFzEbKHclvwks=;
        b=snKBizW30KvOEpc1KY5i5zEp7/yxJXEO6O5r8P8z+RJbt7LraUMZpagfjHnZDcT3cT
         lcqBhNPfbMV+oMFkbVd7z6xFQ2bBxfX4rc8ATGu5oRCxwJhGn0oB1akj8PMjDYQDoVFq
         dBD+ShdYYRNtg7SPdhiNe/LAjiwgxER2q6YtM+V8+Y80TdpjPkaFfCF5w0sAIYIBfIa2
         Niqjcji6WyLqoaXPmo9amzAEkayp0qOspC0XPHE7OD/j8Mtd3e97EFVc0DBoi+j4r1KC
         JBe4nb+NR1baLLwfuyD27fFXcZ9sOx3ZGCd7xXxb/G4mcmjPDHkxZPIjvbpdiajppUut
         bJQg==
X-Gm-Message-State: AOAM530T71KC0q1+AcJVn4QtYxVLImRyNVUb9DYc+NH/ghqyN4tuBRPB
        XTvy0VCV2UrtkFu+JUPTHm8cHw==
X-Google-Smtp-Source: ABdhPJw2y1QUfvUQT+8ZNrtW+ktihEmwITibW19pkg4hT74JLMh/1lQfxcnOGzJSCpHTl6aUbzmkiA==
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id o27-20020a1709061b1b00b006f390445fb4mr4740378ejg.763.1650878570269;
        Mon, 25 Apr 2022 02:22:50 -0700 (PDT)
Received: from [192.168.0.241] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b004229daeaf37sm4309599edo.40.2022.04.25.02.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 02:22:49 -0700 (PDT)
Message-ID: <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
Date:   Mon, 25 Apr 2022 11:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 10:58, John Garry wrote:
> On 20/04/2022 08:03, Christoph Hellwig wrote:
>>> The standard flow is:
>>>
>>> shost = scsi_host_alloc(sht, )
>>>
>>> // modify shost, like
>>> shost->cmd_per_lun = 5;
>>>
>>> scsi_add_host(shost)
>>>
>>> Is there some reason for which those two drivers can't follow that?
>> I think they should.  Method tables should not be mutable data.
>> .
> 
> Hi Krzysztof,
> 
> Do you have any interest in going further with your work and trying to 
> change all SCSI driver instances of scsi_host_template to be const? I am 
> not sure if it has been attempted before...

I can work on this, but what about the SCSI core modifying the template?
For example scsi_proc_hostdir_rm(): 'present' and 'proc_dir' members.
Where should they be stored? Should they be moved to the Scsi_Host?


Best regards,
Krzysztof
