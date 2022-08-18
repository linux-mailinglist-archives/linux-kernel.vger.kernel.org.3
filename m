Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C5598259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiHRLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiHRLd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:33:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA673F302;
        Thu, 18 Aug 2022 04:33:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x10so1442627ljq.4;
        Thu, 18 Aug 2022 04:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XV7o6VoA/foYENhSlwcR9LzNfzuZL9zSnfMTcBdlzkU=;
        b=DLLTtzRMoFSzlvDXNfWAs/5b6nkGZeYQQBFmtNHPM77XjF/MNDQTGJgCecdRKoXUXN
         tzQwxQZ1Minx4+qxe+GDvMjSQIYH49V6JCsZ3KlWyBmwtJG2AHcWIGimOZnagojXqp5U
         xFZbxiKQ0y+BPviS4vBVpSzoQl9MQSUS1MpH0G7pcS0TcxA61A9FEdSYYIXKui87zisL
         P9atfk3nRnh7wTq4O1w1SCzLh1UwKabAx222sHPJ8+2CeJNFVXEBSatzKqX8A1zUpOpc
         KO/taku9ptszlejU7vGtoXm9jXp2hrf88vsRUCWfJNMc63tQOXJoaDxnHGgJtazzuTuR
         k/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XV7o6VoA/foYENhSlwcR9LzNfzuZL9zSnfMTcBdlzkU=;
        b=56ApuCa22nsECMZRAbyIPo69eM0kmLMAM1teMHWkZNL7OJyukEVvoxJggR5NBmI/dJ
         ok6kwEtrwm1q0zbCXpUhwvJppMoVEKnJNo7V9CC2qiaIlIhs33awiDDASZwikUQOgjux
         8QZXjy0jy5rncKGZ0uoqlCG9TER6o/eBaj6W9Ysjcx1ZwLztYNy/AIkflaAJMVnBHJSs
         3+PpCxWA5x2GtKGwTY/Y8fF227bEby5qHHXAE9yb10vSK6Vaxve5mZMFbYu+I3bqtbFc
         Ue3Ynl/gpdPHqMP9OYwfHcGEbzaB2WJuroUkjVDhrrGNQy5tYT/tp0+xDaPFhDHFHe6+
         b0EQ==
X-Gm-Message-State: ACgBeo38dMo20JRIG4tY5VaJzkjRUU4lm7NefpY2okoPLLLHiJCXUmDH
        LWQtgyUtDv8XbKPfyTjeaAQ=
X-Google-Smtp-Source: AA6agR4Vh+SHdQBIyBHvoqdFckErTl5MnC7H2o375cqIoP3U2g2zgTH9t3HaTX7yjMvi9hGCS1viPw==
X-Received: by 2002:a2e:a4aa:0:b0:260:5889:95f7 with SMTP id g10-20020a2ea4aa000000b00260588995f7mr755509ljm.530.1660822435325;
        Thu, 18 Aug 2022 04:33:55 -0700 (PDT)
Received: from [172.16.193.151] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 18-20020a2e0912000000b0025e08d58e75sm190940ljj.133.2022.08.18.04.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 04:33:54 -0700 (PDT)
Message-ID: <52d307d7-04f2-89fd-ff4b-9a6c0d247350@gmail.com>
Date:   Thu, 18 Aug 2022 14:33:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     dri-devel@lists.freedesktop.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk@vger.kernel.org,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>, linux-iio@vger.kernel.org
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <166057828406.697572.228317501909350108.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 8/15/22 18:44, Mark Brown wrote:
> On Fri, 12 Aug 2022 13:08:17 +0300, Matti Vaittinen wrote:
>> Devm helpers for regulator get and enable
>>
>> First patch in the series is actually just a simple documentation fix
>> which could be taken in as it is now.
>>
>> A few* drivers seem to use pattern demonstrated by pseudocode:
>>
>> [...]
> 
> Applied to
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/7] docs: devres: regulator: Add missing devm_* functions to devres.rst
>        commit: 9b6744f60b6b47bc0757a1955adb4d2c3ab22e13
> [2/7] regulator: Add devm helpers for get and enable
>        (no commit info)
> 

I was planning to send out the v3 (where IIO patches are no longer 
squashed into one). I didn't spot the above mentioned patch 2/7 from 
regulator/for-next. I'd just like to get confirmation the 2/7 was not 
merged even though it's mentioned in this mail before re-spinning the 
series with it.

Best Regards
   --Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
