Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD753EC77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiFFNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbiFFNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:16:24 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A2337A9E;
        Mon,  6 Jun 2022 06:16:23 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so12559517pjs.1;
        Mon, 06 Jun 2022 06:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=haH1xGwhj/wZTEqY+orLGoeCGd0tL/KLJasnsNbhTtE=;
        b=jdjkMrbtmFWn6pBFRLcUYvSZ7ufVSrB6PkFz8aJmJXo35hzO/heuTJOebe4JKhlIkX
         XqGOmuGd82PYYYTiWb/YokVeVp9bMORP2y2WktgvrVdrzNIcOKpY41UxMLMZufsZuBJa
         lp5u+oDwoqoAgny4Ubs1ej6Bp5r0z1DtT7wIFUpGQb7Xbp22CXhytMCN4hagfQweEjlD
         pwAGqQniu6vEOESbJgbEEvUAI/Vf+CZOAUExqFkbKLfOUYbGQk8kohZuLGUQ0TSGATbo
         D5R6a6S/K0EdtHF7JuJFoegI8Ecf9IlNaT6G5TEu/9MyjKLa/IqorwXsZTZbI92+Uu91
         qE1A==
X-Gm-Message-State: AOAM532sgX0ZOVKDpyB5OEdlOEedKClChojfqs4ikZxAZwOAsCtuAPX/
        SWbNcOT5wF5XsIicmxGK30U=
X-Google-Smtp-Source: ABdhPJzllokqDgNkPKCfrAp7djJclpbLsYrv65dsb7FFR7bMvYPum2ICUju4mffaQ35qoAmnj7c7yQ==
X-Received: by 2002:a17:90b:4b0f:b0:1e8:53ac:ec51 with SMTP id lx15-20020a17090b4b0f00b001e853acec51mr13717685pjb.78.1654521382753;
        Mon, 06 Jun 2022 06:16:22 -0700 (PDT)
Received: from [192.168.51.14] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id bf7-20020a170902b90700b00163c6ac211fsm10478642plb.111.2022.06.06.06.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:16:21 -0700 (PDT)
Message-ID: <2677b02e-b2a3-7c79-2e62-acf1acbc8ff0@acm.org>
Date:   Mon, 6 Jun 2022 06:16:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
 <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
 <DM6PR04MB65751A3B1D0BA4467CADDA93FCDF9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a4746c67-fa74-8af1-3f2d-7853e9fae8a6@acm.org>
 <3c400db6-d251-c4bd-b019-b9dc1d807212@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3c400db6-d251-c4bd-b019-b9dc1d807212@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/22 19:48, Damien Le Moal wrote:
> On 6/5/22 12:55, Bart Van Assche wrote:
>> On 6/1/22 10:05, Avri Altman wrote:
>>> As a design rule, sysfs attribute files should not be used to make
>>> persistent modifications to a device configuration. This rule applies
>>> to all subsystems and ufs is no different.
>>
>> Hmm ... where does that rule come from? I can't find it in
>> Documentation/admin-guide/sysfs-rules.rst. Did I perhaps overlook something?
> 
> I am not aware of any writable sysfs attribute file that can be used to
> make persistent device configuration changes, at least in storage area.
> I know of plenty that do change a device setting, but without saving this
> setting to maintain it across power cycles. Do you know of any such
> attribute ? I was under the impression that sysfs should not be used to
> persistently reconfigure a device...

I don't think the above is sufficient as an argument to reject a new 
patch that introduces a sysfs attribute that changes the device 
configuration.

Thanks,

Bart.

