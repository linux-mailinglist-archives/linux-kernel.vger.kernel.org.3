Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2750EFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbiDZEQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiDZEQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:16:43 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D618B28;
        Mon, 25 Apr 2022 21:13:36 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id bg9so15056310pgb.9;
        Mon, 25 Apr 2022 21:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AY731iI+S8F0M/j7fMQ9Mkrc8kLhYo3SZm7WX0TOCyM=;
        b=r1kjhNDgrhZ6RdMKJlqs9VqZ4WK+VgHu7EnJlaqjrPf8By7inmxIJJg7ybLdpiQ5QH
         HomYLOJ6n0JnU6YFaykoMcEnIxgkI4McE4uY2To7eZjq7SZHAqvjGKwJDk+Y++QUeyb6
         jQj4bOw2mXjvZ3P9QTe5fqOFeUUNd1jefUe8ptwL6hinov0aTloeO7U/tnJNcXSQi+KQ
         ZizzJNTSkDJznvp65ScWcE0sRODisi2V6GM6Z/a10ZJlEr39v06j19qMVs1G11uQYAFs
         wxE6vnTzbM8Wdeyldbp3QhelQr3ug6kC3L60zqZh5ab2OWEhhkRnPU8QgPz98qr01je0
         glrw==
X-Gm-Message-State: AOAM532xSHgALl0+tVcU+rAVbqquSjgtJqj1+udhlIptqcYGryQZHPIp
        bqQxaqaCIErIb5RUGxIxrr9LgDsJOoo=
X-Google-Smtp-Source: ABdhPJy8qxGj7WHaygIzMOklbVwTxVcEdN9ais+Mq8HJh9hfKdbPhuQ0u5BArzSL2cAFg1ODW9ctxg==
X-Received: by 2002:a63:694a:0:b0:3aa:e962:db29 with SMTP id e71-20020a63694a000000b003aae962db29mr13349550pgc.421.1650946416300;
        Mon, 25 Apr 2022 21:13:36 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id li12-20020a17090b48cc00b001d983f83959sm854930pjb.57.2022.04.25.21.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 21:13:35 -0700 (PDT)
Message-ID: <f6516c7f-16c7-689c-b6cd-ebff95e931a4@acm.org>
Date:   Mon, 25 Apr 2022 21:13:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-US
To:     dgilbert@interlog.com, John Garry <john.garry@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.smart@broadcom.com
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
 <aba8999d-276d-f9e8-96b4-5d1cc4e82c53@acm.org>
 <5485f529-e99a-0bdd-07bd-b5b559da91e6@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5485f529-e99a-0bdd-07bd-b5b559da91e6@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 18:54, Douglas Gilbert wrote:
> On 2022-04-25 21:16, Bart Van Assche wrote:
>> How about removing scsi_proc_hostdir_add(), scsi_proc_hostdir_rm() and 
>> all other code that creates files or directories under /proc/scsi? 
>> There should be corresponding entries in sysfs for all /proc/scsi 
>> entries. Some tools in sg3_utils use that directory so sg3_utils will 
>> have to be updated.
> 
> ... breaking this:
> 
> ~$ cat /proc/scsi/scsi
> 
> Attached devices:
> 
> Host: scsi3 Channel: 00 Id: 00 Lun: 00
> 
>    Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6
> 
>    Type:   Direct-Access                    ANSI  SCSI revision: 06
> 
> Host: scsi3 Channel: 00 Id: 01 Lun: 00
> 
>    Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6
> 
>    Type:   Direct-Access                    ANSI  SCSI revision: 06
> 
> Host: scsi3 Channel: 00 Id: 02 Lun: 00
> 
>    Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007
> 
>    Type:   Direct-Access                    ANSI  SCSI revision: 06
> ...
> 
> A deprecation notice would be helpful, then removal after a few kernel
> cycles.

Agreed with the deprecation notice + delayed removal, but is anyone 
using cat /proc/scsi/scsi?

> Yes, lsscsi can give that output:
> 
> $ lsscsi -c
> 
> Attached devices:
> 
> Host: scsi2 Channel: 00 Target: 00 Lun: 00
> 
>    Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007
> 
>    Type:   Direct-Access                    ANSI SCSI revision: 06
> 
> Host: scsi2 Channel: 00 Target: 01 Lun: 00
> 
>    Vendor: WDC      Model: WSH722020AL5204  Rev: C421
> 
>    Type:   Zoned Block                      ANSI SCSI revision: 07
> 
> Host: scsi2 Channel: 00 Target: 02 Lun: 00
> 
>    Vendor: Areca Te Model: ARC-802801.37.69 Rev: 0137
> 
>    Type:   Enclosure                        ANSI SCSI revision: 05
> ...
> 
> [Hmmm, in a different order.]
> 
> However no distribution that I'm aware of includes lsscsi in its 
> installation.
> [Most recent example: Ubuntu 22.04]

Hmm ... are you sure? Last time I looked into this an lsscsi package was 
available for every distro I tried (RHEL, SLES, Debian and openSUSE). 
See also 
https://packages.debian.org/search?searchon=contents&keywords=lsscsi&mode=path&suite=stable&arch=any.

Are there other utilities in sg3_utils that would break if the 
/proc/scsi directory would be removed?

$ cd sg3_utils && git grep /proc/scsi | wc -l
51

Thanks,

Bart.
