Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA83351FE34
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiEINZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiEINY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:24:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C4E2CDD5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:20:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kq17so26789759ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HtoNB9b8qAI6phDM9MY0FWngDy3WU/NlhF6WY/stdrM=;
        b=YN4LMFpv9qxijIDo4TPAPru3w9yn9J1ojjAMfhc6QOzXRbFaR/WHwxl9ZbU+rCRbSB
         8nHxgw5Y98u5B8TQk1kwuQOOJJskwwcihjFCt6X9SnvcnJyISTqgkpdkpsy+ruAaQDcv
         nR281RVGw3lVkjT8M1g+m3W61RT1yibKFqLr2NwYQpS7gdOP39bkf8dVGcWQsFSJWNKX
         b/i3FkIN02ZblJPP/MpCziaoUzDrv+z4B9uIFF9srg/4A3DB/3T5qmUTSwhz4ii05izS
         DPOlLqILZjzP+sr9ldiG+UCQT/IwdF3ULGI49D0WVbhyXOjiO8XCLBeXfIpBrfUexP/w
         tK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HtoNB9b8qAI6phDM9MY0FWngDy3WU/NlhF6WY/stdrM=;
        b=TG0rfhgJ4IEPpm+Xt/J3z+OhNXqLa672GSasfkiKdhC0u/D0vexKNQbc8gK1iCnNxE
         783Cb8xvIe+HzVMvra4Da8CJCoMdI7nckIaohXvAs60yAO5gda9acQ/t06AU2WyT01rh
         gN7RNGmA+hRmm+PBh0Iv0LqMvEdjglxOmVHxIxZASKYIiDq8XKiIaUK+61ysFJGps45q
         0jkJKDCiItsPIChupIhdA1uLQ76bJ8/ojMiY4orOVj0TRe5IKowETfAZ1RSTn1Q/vwta
         zIUu+PWvckASTcDxPvA4smpQRwwSDih4IyeoSbjKBM0itZQQWE8Wzu1dIP0s537BL8UD
         k+tA==
X-Gm-Message-State: AOAM532n2pCna0b7ydCZJHlTI8rIZqkB2MQXLq5jInWKl1Am21c4JNUK
        XpGNZSINQDZ8zLBP+PXPaD44lA==
X-Google-Smtp-Source: ABdhPJyf++lTRKWtGTaHBs2TNWdGa3wFylGLs3yFySy/JAaZ6AQYHZUvObVTHnarkQhXkJCTZw7eXQ==
X-Received: by 2002:a17:906:9c83:b0:6df:839a:a6d0 with SMTP id fj3-20020a1709069c8300b006df839aa6d0mr14599010ejc.419.1652102449791;
        Mon, 09 May 2022 06:20:49 -0700 (PDT)
Received: from [192.168.0.246] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id em10-20020a170907288a00b006f3ef214e6dsm4980564ejc.211.2022.05.09.06.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 06:20:49 -0700 (PDT)
Message-ID: <d01c29c1-bb5a-281d-ef71-9c7b39e28d23@linaro.org>
Date:   Mon, 9 May 2022 15:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
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
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
 <6f28acde-2177-0bc7-b06d-c704153489c0@linaro.org>
 <4510c5dc-3d7d-fc5f-cb80-34da7dbaaa8e@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4510c5dc-3d7d-fc5f-cb80-34da7dbaaa8e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 13:28, John Garry wrote:
> 
> For some reason I cannot fetch your git due to "error: RPC failed ..." 
> which I think is a timeout. I seem to have this problem recently 
> whenever a linux.git clone has branches based on linux-next.git . Maybe 
> a git config issue for me...

Just to be sure - the link was not a git remote, but direct link for a
web browser. The repo is:
https://github.com/krzk/linux.git
branch: n/qcom-ufs-opp-cleanups-v2

>> However this does not solve the problem. The SHT has "module" which gets
>> incremented/decremented. Exactly like in case of other drivers
>> (driver->owner).
> 
> Ah, I missed that this could be a problem. So we have this member to 
> stop the SCSI host driver being removed when we have disks mounted, etc.
> 
> But isn't scsi_host_template.module just a pointer to the local driver 
> module data (and that data gets incremented/decremented)? I am looking 
> at the THIS_MODULE definition in export.h:

Yes, it is just a pointer, just like 'struct device_driver.owner' is.

> 
> extern stuct module __this_module;
> #define THIS_MODULE(&__this_module)
> 
> However I do see scsi_device_dev_release(), which does:
> 
> sdp->host->hostt->module = NULL
> 
> I am not sure how necessary that really is. I would need to check further.

> 
> Did you see if there other places which set hostt->module dynamically?

I think all SHT set it statically. Then it is being dynamically
incremented when needed and in scsi_device_dev_release() is being
nullified (as you mentioned above).

I guess this SHT->module is actually duplicating what most of drivers
(e.g. PCI, platform, USB) are doing. If I understand correctly, the
Scsi_Host is instantiated by the probe of a driver (pci_driver,
virtio_driver etc), therefore the SHT->module could be simply stored in
Scsi_Host.


>>
>> I started moving the SHT->module to a new field scsi_host->owner and
>> trying to use the parent's driver (so PCI, USB) owner.
>> I am not sure if it is correct approach, so before implementing such big
>> change affecting multiple subsystems (USB, ATA, SCSI) - can you share
>> ideas/opinion?
>>
>> The Work-in-Progress looks like this (last commit):
>> https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7



Best regards,
Krzysztof
