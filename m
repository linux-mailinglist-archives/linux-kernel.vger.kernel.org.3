Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E873598163
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiHRKSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbiHRKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:18:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C352E68C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:18:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i19so1514459lfr.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=++KVqPTFi0Hk6JMVsmbdk5FR52khYdgoDtJ+jjwqaDg=;
        b=Xb4stJLwkH+xJP01OZOHdf3ucZGj/2sTSprqhW4Y4DSB3Zzu/0DkONlCdUGkYmnij/
         U46R2+Dpxe4UD+wd24i4IslC37esQ/FjqDrWP1nlzcpd8muNrxsklpuyS3J+bPvmUKwR
         WjgeKbazJ5UAVlUM+TzEqaNftYRLVxCA7zu/DBm8pD1zDRp46Pu3SVMdsKE5JA1r74sA
         eu/PSTBfuVpynkKIeNFe6x3g8s2TUr4LUH8dIO87rVhzv6D36F97vI7zrAbz8dwr5VVV
         OaHa1QfsaGGOW6vOocDHpaSd41i5RLW1m70enerJhyWdpO7SAr7id62S3En6HRwjE2lr
         cZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=++KVqPTFi0Hk6JMVsmbdk5FR52khYdgoDtJ+jjwqaDg=;
        b=QeQOep0ROLh3ESbpMQWirSP2yb9/aUT2K2wMrg6TiV3vo1i4mzPP1rt3O0tgH+jTng
         pnP/cJnLOBu3pcGRtGhIed3YbGXyRsc0xQNrWU8HOzstJZBTACkFcWFJLtOHShW6pz9w
         dpyrZg32OuenErP9LePpWePOPNzmBXsJP08WNKgBk2s6jEgU+D+Y8e3/7MVJ3dx6tSQN
         oek1Sfzl2tNgrfHrTAnbEixPl3jTYda20gutzM2psaKyVgQfoeCCvKbOnPctoQFOuDZa
         QF2c3GBrovGD8NqhgnAvmjOlGIaHFtTY9UW8iyraNHWC9KenPAZBnpiMBZAdbCsTNuwA
         y6Nw==
X-Gm-Message-State: ACgBeo03lv59YcWLri0Oo8xEpc+hbhcHZpf8x9lUzU8FmNwZan/8gT7U
        u3soQrwTzqTnZhixmMxlDe7BfA==
X-Google-Smtp-Source: AA6agR4ivn2pTeXMBlnkBaPsklxkFp/WBgICfGEVoevvTHlagzkjxUJ4cXGShLTrmmpDxPXuCspcLQ==
X-Received: by 2002:a05:6512:33c8:b0:48a:fe63:e4ea with SMTP id d8-20020a05651233c800b0048afe63e4eamr703670lfg.415.1660817915008;
        Thu, 18 Aug 2022 03:18:35 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id bf12-20020a056512258c00b0048a88c07bcdsm171254lfb.20.2022.08.18.03.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 03:18:34 -0700 (PDT)
Message-ID: <a6f3d97e-547a-9797-1469-bbe5d80a3bb8@linaro.org>
Date:   Thu, 18 Aug 2022 13:18:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] power: supply: rt9471: Add Richtek RT9471 charger
 driver
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
 <1660785696-9010-3-git-send-email-u0084500@gmail.com>
 <85193de5-244c-2cda-e442-656769b97b14@linaro.org>
 <CADiBU3_RUTiG0T5vEKe0qHmHHQDXyMQL2BxFA+YgL_u-VGUNkA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3_RUTiG0T5vEKe0qHmHHQDXyMQL2BxFA+YgL_u-VGUNkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 13:16, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年8月18日 週四 下午4:09寫道：
>>
>> On 18/08/2022 04:21, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add support for the RT9471 3A 1-Cell Li+ battery charger.
>>>
>>> The RT9471 is a highly-integrated 3A switch mode battery charger with
>>> low impedance power path to better optimize the charging efficiency.
>>>
>>> Co-developed-by: Alina Yu <alina_yu@richtek.com>
>>> Signed-off-by: Alina Yu <alina_yu@richtek.com>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>> Since v2:
>>> - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
>>> - Specify the member name directly for the use of linear range.
>>>
>>> ---
>>
>> (...)
>>
>>> +
>>> +static DEVICE_ATTR_RW(sysoff_enable);
>>> +static DEVICE_ATTR_RW(charge_term_enable);
>>> +static DEVICE_ATTR_RW(port_detect_enable);
>>> +
>>> +static struct attribute *rt9471_sysfs_entries[] = {
>>> +     &dev_attr_sysoff_enable.attr,
>>> +     &dev_attr_charge_term_enable.attr,
>>> +     &dev_attr_port_detect_enable.attr,
>>> +     NULL
>>
>> You need to document the sysfs ABI in Documentation.
> Can it be define in 'sysfs-class-power' or a dedicated file called
> 'sysfs-class-power-rt9471'?
> Not sure which one is better.

I don't know what is Sebastian's preference. You can wait for his input
or do similarly as last patches reviewed/picked up by him.

Best regards,
Krzysztof
