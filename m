Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB1510E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356962AbiD0BvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356939AbiD0BvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:51:01 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4667349F17;
        Tue, 26 Apr 2022 18:47:52 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 933C365FE2;
        Wed, 27 Apr 2022 01:47:51 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id 875124D4BA;
        Wed, 27 Apr 2022 01:47:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id 1A8SeDgBqeFU; Wed, 27 Apr 2022 01:47:51 +0000 (UTC)
Received: from [192.168.48.23] (host-45-78-195-155.dyn.295.ca [45.78.195.155])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 5A6B84BF89;
        Wed, 27 Apr 2022 01:47:48 +0000 (UTC)
Message-ID: <726c8764-c3fe-99d9-d2ea-6a4ab8a198d5@interlog.com>
Date:   Tue, 26 Apr 2022 21:47:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-CA
To:     Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
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
 <f6516c7f-16c7-689c-b6cd-ebff95e931a4@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <f6516c7f-16c7-689c-b6cd-ebff95e931a4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-26 00:13, Bart Van Assche wrote:
> On 4/25/22 18:54, Douglas Gilbert wrote:
>> On 2022-04-25 21:16, Bart Van Assche wrote:
>>> How about removing scsi_proc_hostdir_add(), scsi_proc_hostdir_rm() and all 
>>> other code that creates files or directories under /proc/scsi? There should 
>>> be corresponding entries in sysfs for all /proc/scsi entries. Some tools in 
>>> sg3_utils use that directory so sg3_utils will have to be updated.
>>
>> ... breaking this:
>>
>> ~$ cat /proc/scsi/scsi
>>
>> Attached devices:
>>
>> Host: scsi3 Channel: 00 Id: 00 Lun: 00
>>    Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6
>>    Type:   Direct-Access                    ANSI  SCSI revision: 06
>> Host: scsi3 Channel: 00 Id: 01 Lun: 00
>>    Vendor: IBM-207x Model: HUSMM8020ASS20   Rev: J4B6
>>    Type:   Direct-Access                    ANSI  SCSI revision: 06
>> Host: scsi3 Channel: 00 Id: 02 Lun: 00
>>    Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007
>>    Type:   Direct-Access                    ANSI  SCSI revision: 06
>> ...
>>
>> A deprecation notice would be helpful, then removal after a few kernel
>> cycles.
> 
> Agreed with the deprecation notice + delayed removal, but is anyone using cat 
> /proc/scsi/scsi?
> 
>> Yes, lsscsi can give that output:
>>
>> $ lsscsi -c
>> Attached devices:
>> Host: scsi2 Channel: 00 Target: 00 Lun: 00
>>    Vendor: SEAGATE  Model: ST200FM0073      Rev: 0007
>>    Type:   Direct-Access                    ANSI SCSI revision: 06
>> Host: scsi2 Channel: 00 Target: 01 Lun: 00
>>    Vendor: WDC      Model: WSH722020AL5204  Rev: C421
>>    Type:   Zoned Block                      ANSI SCSI revision: 07
>> Host: scsi2 Channel: 00 Target: 02 Lun: 00
>>    Vendor: Areca Te Model: ARC-802801.37.69 Rev: 0137
>>    Type:   Enclosure                        ANSI SCSI revision: 05
>> ...
>>
>> [Hmmm, in a different order.]
>>
>> However no distribution that I'm aware of includes lsscsi in its installation.
>> [Most recent example: Ubuntu 22.04]
> 
> Hmm ... are you sure? Last time I looked into this an lsscsi package was 
> available for every distro I tried (RHEL, SLES, Debian and openSUSE). See also 
> https://packages.debian.org/search?searchon=contents&keywords=lsscsi&mode=path&suite=stable&arch=any.

I was talking about the _initial_ installation. When I install new versions
of Fedora or Ubuntu, or play with a "live" CD (usually a USB stick) one
of the first things I do is get a terminal and then invoke 'lsscsi'.
Invariably that second step fails. And on a "live" USB stick you can install
lsscsi but the next time you use it, lsscsi is gone because those "live"
USB sticks hardly ever have persistent storage set up. [Why not? ..
typically the rest of the storage on such a USB stick is un-utilized.]

> Are there other utilities in sg3_utils that would break if the /proc/scsi 
> directory would be removed?
> 
> $ cd sg3_utils && git grep /proc/scsi | wc -l
> 51

Most of those are in the scripts/rescan-scsi-bus.sh which, judging from the
number of patches and additions it gets, has quite a bit of use out there.
The rest are in my dd variants that are mainly setting /proc/scsi/sg/allow_dio
which has no effect in my sg driver rewrite.

Doug Gilbert


