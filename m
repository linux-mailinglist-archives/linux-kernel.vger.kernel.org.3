Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113045A7408
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiHaClq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaClo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:41:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500168E0CC;
        Tue, 30 Aug 2022 19:41:42 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l65so2790280pfl.8;
        Tue, 30 Aug 2022 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=AyUhgo/bWbZxoGOekJY4CZRgIM4gQ4dSwEtg53FDKBw=;
        b=EwNOgWAGUOOrrvS5GJMcRXKJUMiNjNlYJUE14G31XF4XcKA7b7b0kWX7O2KNSn2TZE
         doDVD+m5FqeVTtTTdpybW+BLoblIIn6ETB0Q8sH1EHtXJC7xvX+TxB17ugNPJdb0d5qR
         6/f6yvrGz09PNwVyS1aHiBcq4EgkG3sg+rZJFP1MzwGWKCGH8DSsEQxFI+CKQhe64XUf
         YnRFkx4ZxCDYT+CgaoPHDngoe7m8SmZgRBEAQdGBK/H5DTK2p5YFEQR4XlagLNzED/i+
         nqIZgv3NwWARQM7AalCMdkvVinh4ve00D8VJcSTpiVT9wV6HqQAKbKpuVKmX95ULjZvC
         w4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=AyUhgo/bWbZxoGOekJY4CZRgIM4gQ4dSwEtg53FDKBw=;
        b=BH2hb+AgJZKkLVgmr5UG5oR2mtiq7R3qPW0u6Mj6KoD7TAVWhyeGeWA9uQfsTCsf/3
         uAAiZpfbZK9Hdv0+bzdFdc4qt+jhMTWoowGp008yMDgPw9dyX0wLSJHMcp+QZbphkpMj
         B82gRZmJlsPKFRulk45r9DimsYgfhJax2jfsPYWUlSEP3rcL9PWWqykSdQrWTV5S7UV0
         6EJeYgEe/KrMYRvHnYp/QZStYscCL0FAr1swG3L+ygxsE1AGzsOOSNK2rFE6YsHlv5Cv
         6O7pwtwG08jF5PuSomJiZ4Z8Rk/FZefCVZv322Bid65IcqITlMQFDarS9joz9MtK0Ira
         DTLg==
X-Gm-Message-State: ACgBeo1F3gpdkfqYtlHz/K+eOVgD0/w0c1FSTVDCrJf4ncYYusk2+T5n
        k7Rjqs1GyVA0e6ppUMEltYg=
X-Google-Smtp-Source: AA6agR6ENIK2j6c4RTccCTDp7YfYP23sf0fEXuDKBOwzpXcGVXGsiwKfywaaEgfDj+gw2wDx16QB2w==
X-Received: by 2002:a63:148:0:b0:42f:f103:4d18 with SMTP id 69-20020a630148000000b0042ff1034d18mr3570661pgb.521.1661913701848;
        Tue, 30 Aug 2022 19:41:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu14-20020a17090ad18e00b001fdb16ab182sm258190pjb.46.2022.08.30.19.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 19:41:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a059f0d-708a-91b9-16a0-722c8227d311@roeck-us.net>
Date:   Tue, 30 Aug 2022 19:41:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/19] hwmon: (mr75203) update pvt->v_num to the actual
 number of used sensors
Content-Language: en-US
To:     Eliav Farber <farbere@amazon.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, rahul.tanwar@linux.intel.com,
        andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-4-farbere@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220830192212.28570-4-farbere@amazon.com>
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

On 8/30/22 12:21, Eliav Farber wrote:
> This issue is relevant when "intel,vm-map" is set in device-tree, and
> defines a lower number of VMs than actually supported.
> 
> This change is needed for all places that use pvt->v_num later on in the
> code.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>   drivers/hwmon/mr75203.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index 0e29877a1a9c..f89f7bb5d698 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -605,6 +605,7 @@ static int mr75203_probe(struct platform_device *pdev)
>   					break;
>   
>   			vm_num = i;
> +			pvt->v_num = i;

How about the existing assignment in the probe function ?

>   		}
>   
>   		in_config = devm_kcalloc(dev, vm_num + 1,

