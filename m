Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121DC5912F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbiHLPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiHLPau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:30:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD184E019
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:30:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 73so1065502pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=9rQM1/BORK4sGy5Cwj1d1mPdoYhgdZ1Ue14VRkIr/3c=;
        b=VYd2zME2kVQ3dNi1AM8RbXHQrvVLNoxksuBzD4pzX37xqHjpeyvwxPsmkJ9FKwn1IG
         cJ/8VUCHCfyvSk+cJTNEbXu7PHu5KkKEmCAP8mrHH1P8WyWbd6WVLcbOxkEAtAdYJA3a
         7Tmp2hfHoE3PGO9t4Ta96W/mgA3JGonyYYQ6cD5pDg/TXoS97BhV1Q2JCGoGfNH7312m
         MJCcvIKHOg0Et1cAIChVWMqUhDzbG4YzRoAb2ST6Vfi2JZ/KOLjCbN5LGHGD+F8tkNMr
         vwYEnxzJFcgb4BoZV8nLDm1BgAAzN6eCQvTjzLprJvotF4odTOdwxdw1p5qSNhIigGTy
         aHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=9rQM1/BORK4sGy5Cwj1d1mPdoYhgdZ1Ue14VRkIr/3c=;
        b=bHjRbSekoh2tHMJfCD+mDNlAj5vGhEsume0MxnD+u5t4kci2Me85dfV5gHFfCdOlja
         ZvUNMQPTXm9JBT6hWHJ5hcJQC0Kdqbt/TnwyCsAxJeDh5xwXdQMTuTvqsQAQSgEh7sAy
         Ecu+hR314O4ZU6pcBMTxjm5ETRH9Pla/3LC0NLGoJA4Rsb6vC4rCtkfEXUpy8xnVgQ2Q
         0cCFbCHq+bJIMVYkCEOfjzhRunftndczyYcseLTQ2wQMQbinK95ViLmzv05AaytSXc3i
         +gtm4xfk8PxN0I2DfyGKwOPjb9B0pI7hVQafaCwSv4vEhz8sIB8lBdLHIGgBm3KoI56u
         PUrA==
X-Gm-Message-State: ACgBeo28IDHhFskNQYBo19rjHpfxS/o/MLkuu4xAIF2GJH3MXFdQapFY
        4vzUo3SHwGkKQxqeTtFpN8j7bFPRxBk=
X-Google-Smtp-Source: AA6agR5Nwc2R9qV7nE+WqYc4U9XTi7JmxYjbIeFAGH6+BzdeNIXk8Jb/NDaAu0cW2w0bRFWPGzHCVw==
X-Received: by 2002:aa7:8253:0:b0:52b:f4f7:bc55 with SMTP id e19-20020aa78253000000b0052bf4f7bc55mr4475911pfn.4.1660318249199;
        Fri, 12 Aug 2022 08:30:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j125-20020a625583000000b0052e987c64efsm1799185pfb.174.2022.08.12.08.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 08:30:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c20eedf-4fa9-9cb1-b232-3bc490c1be7c@roeck-us.net>
Date:   Fri, 12 Aug 2022 08:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
 <YvUzpSAQDktDPRbR@google.com> <YvVWEIn8veGL9Psa@google.com>
 <20220811195234.GA4018948@roeck-us.net> <YvXhJRlHN9OAIA5l@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6] amba: Remove deferred device addition
In-Reply-To: <YvXhJRlHN9OAIA5l@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 22:12, Isaac Manjarres wrote:
> On Thu, Aug 11, 2022 at 12:55:08PM -0700, Guenter Roeck wrote:
>>
>> Ah, it must be triggered by one of the configuration options I have enabled
>> on top of versatile_defconfig. Sorry, I should have checked. Please try
>> with the configuration below.
>>
>> Guenter
> 
> Thanks for sharing your config options; I was able to reproduce the
> crash after copying your config options to my repository :) The
> following changes fixed the problem for me. Can you please give them a
> try on your end to see if they work for you too?
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 90b31fb141a5..0315bc2853ef 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1117,7 +1117,9 @@ static int __driver_attach(struct device *dev, void *data)
>           * is an error.
>           */
> 
> +       device_lock(dev);
>          ret = driver_match_device(drv, dev);
> +       device_unlock(dev);
>          if (ret == 0) {
>                  /* no match */
>                  return 0;
> 

After more testing: the changes above result in qemu sx1 boot failures.
There is no crash, boot just hangs.

qemu command line:

qemu-system-arm -M sx1 -kernel arch/arm/boot/zImage -no-reboot \
	-initrd rootfs-armv4.cpio \
	--append "rdinit=/sbin/init console=ttyS0,115200 earlycon=uart8250,mmio32,0xfffb0000,115200n8" \
	-nographic -monitor null -serial stdio

with configuration from
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/qemu_sx1_defconfig
and root file system from
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/rootfs-armv4.cpio.gz

This is with your other patch applied.

Guenter
