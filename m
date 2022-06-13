Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498354A1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351230AbiFMVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiFMVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:44:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9D63D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:44:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eo8so787398edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=o9UntF+lNWBkIEzIjLLvGVZ85sm3+wWH8i4UJo4RX/Y=;
        b=QBnLjzYlFYIqB7at45tks5394ozND8nIqDGVnvt7FHGDETvKejvhnifl6L80trZHBJ
         G7Qa+Exyq2l/I4kCvHRAvWYV3wUQoOKzkRubwuVpujP5Eufha8zW3onTKcw7JtRpsLuG
         BJ7+hbsr2qS/LDY1R10+TYFLLvZiRdXJN5U3QlUgXvYbUzRsxpgGypJYjlDBtCRPSduQ
         9fLfji6OAAgooWQWP+gR8E+f8EJPBSdd/XmKSJmZc1BdE3Ws2XBo+mIgWIDZHwilHX49
         /QR5kEwRzVGr6AFKdAdCZkpGFxU+RRBAqwombi/bWdcGGbRgBYl58bsP+rjUPnF/6mxX
         S0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=o9UntF+lNWBkIEzIjLLvGVZ85sm3+wWH8i4UJo4RX/Y=;
        b=5B9SIK2maxOYfj2YwYujU10FocRJ69eT9p3UEz3rWh3nvORjMuWIgWPV7sCeAMtDby
         Nj0Z/7ZQzGeEHL/DH8/tVfVpZw9xB5PjkiD2aW3gfhGTmfVSDuRXmmd4l9uM5TAUAxMB
         6smgddb2jzmdPlJ+TaS1d6Agp2RsM8ktSVe16+Wuyc+wnrraf1Wz6xlCm1ZbCrFvRzhb
         gMbzuLqcyeyhWuU+42yTaBwrLVtCUbAvf4ZlBnYDDlh2CFk146jBLuX4y4mhgAuM5QJS
         fREjKVUhUOsJQOuXX9FfVj7SQbFKAUzLJpLLeMvuIVYiEDDxdogwRIdsVtC4xIc6Avd4
         2WLw==
X-Gm-Message-State: AJIora8M0gzaqdf4AUBhgNvQekpIQqFI/MEezAyQSpPEMF5qAAm4XerR
        bvhFmWiDVXTODb8Fkd2gg2M=
X-Google-Smtp-Source: ABdhPJzOWtjnmSDqP6ZQi8u6wmEXcV9azPmVN4Fto3NVpuPIpkPSj4uG1823bZRQwothDlTZ+IKBHg==
X-Received: by 2002:aa7:c508:0:b0:42d:cc6b:df80 with SMTP id o8-20020aa7c508000000b0042dcc6bdf80mr2055540edq.393.1655156657043;
        Mon, 13 Jun 2022 14:44:17 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:a6e8:9f53:c608:417c? (2a02-a466-68ed-1-a6e8-9f53-c608-417c.fixed6.kpn.net. [2a02:a466:68ed:1:a6e8:9f53:c608:417c])
        by smtp.gmail.com with ESMTPSA id lu33-20020a170906fae100b007041e969a8asm4274980ejb.97.2022.06.13.14.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 14:44:16 -0700 (PDT)
Message-ID: <8201ecf4-29e6-6c97-d3a4-c99904187b3b@gmail.com>
Date:   Mon, 13 Jun 2022 23:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/1] phy: ti: tusb1210: Don't check for write errors
 when powering on
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>
References: <20220613160848.82746-1-andriy.shevchenko@linux.intel.com>
 <77a486ae-06bb-7f1b-17ab-8d60ccfbdee6@gmail.com>
In-Reply-To: <77a486ae-06bb-7f1b-17ab-8d60ccfbdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Op 13-06-2022 om 22:40 schreef Ferry Toth:
> Hi
> 
> Op 13-06-2022 om 18:08 schreef Andy Shevchenko:
>> On some platforms, like Intel Merrifield, the writing values during 
>> power on
>> may timeout:
>>
>>     tusb1210 dwc3.0.auto.ulpi: error -110 writing val 0x41 to reg 0x80
> with the patch this error continues to appear in the logs
>>     phy phy-dwc3.0.auto.ulpi.0: phy poweron failed --> -110
>>     dwc3 dwc3.0.auto: error -ETIMEDOUT: failed to initialize core
>>     dwc3: probe of dwc3.0.auto failed with error -110
> these errors are gone
>> which effectively fails the probe of the USB controller.
> 
> and probe of dwc3 succeeds
> 
> Tested on Intel Edison (Merrifield)

Tested-by: Ferry Toth <fntoth@gmail.com>

>> Drop the check as it was before the culprit commit (see Fixes tag).
>>
>> Fixes: 09a3512681b3 ("phy: ti: tusb1210: Improve ulpi_read()/_write() 
>> error checking")
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/phy/ti/phy-tusb1210.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-tusb1210.c 
>> b/drivers/phy/ti/phy-tusb1210.c
>> index c3ab4b69ea68..669c13d6e402 100644
>> --- a/drivers/phy/ti/phy-tusb1210.c
>> +++ b/drivers/phy/ti/phy-tusb1210.c
>> @@ -105,8 +105,9 @@ static int tusb1210_power_on(struct phy *phy)
>>       msleep(TUSB1210_RESET_TIME_MS);
>>       /* Restore the optional eye diagram optimization value */
>> -    return tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2,
>> -                   tusb->vendor_specific2);
>> +    tusb1210_ulpi_write(tusb, TUSB1210_VENDOR_SPECIFIC2, 
>> tusb->vendor_specific2);
>> +
>> +    return 0;
>>   }
>>   static int tusb1210_power_off(struct phy *phy)
