Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649695A643F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH3NAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiH3NAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:00:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CEE0D1;
        Tue, 30 Aug 2022 06:00:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z20so11296524ljq.3;
        Tue, 30 Aug 2022 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TXqo6jqFFJO+5EXcJRS51k8mEsS8tkYLSHqnPARtF4Y=;
        b=oPZzQlOssH7aV8JnOiAtZ5MMqpBWfo9On8CB+QzcsUyUkQt+9OLMCtaT0hbU8LnRP0
         VM55bmQjNCPiLcwhwLdPrcFQO6ar9RjmZPn5RBf1q3L7RqXdrr+kFVODxioqWu6jC1/J
         hNiZCNmQ5BYcrEyG4+n6s0ZClh6MqaEHAHWKHHfmw7qA/HMrkH+p8/15PZBIyXmt4PZX
         g/CXh12+Hra431lQGAkb8OFYXMsIQXjXUMFB0vtI1zBCUfxnwU92f1RNDzRBC5MT8pYp
         97C1PttHqhty6DdPOFxEZKACe9TW1ZDs6NNr6ENwjj/I/25P8U+JIjj9v+9vR3tU/MXh
         p3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TXqo6jqFFJO+5EXcJRS51k8mEsS8tkYLSHqnPARtF4Y=;
        b=UMkQ+kSTXegKUGsxnNthaJsVbS8cfOwI3hFA82TpefdvdAdCJmpRow0zYT8UyNuPQf
         ylr9oPxf659wSduBUAlDaYb8hYqXh/znH+NkGfdiLgjKB5tg3km/AuPML1X+XiAAy5NO
         iJ4P/SedCRXUWfNL8jOOkk8l1XTyf7RfytjLdT+N0Do8AVz8yJn3+I0Nets8btFgm8gC
         EjM/jGhV95wDpxFKdM93LxPeSb0S1AWkAhesRAet8RCjD3U4vJIBpnsLWZCeYeho1G9t
         KlbX4ET9rQlbFlFzK5oOMHpTI4FZ373uXUUYDeD2KqrM/FEtmHXWY2hV4tkC2TlScAvq
         8flg==
X-Gm-Message-State: ACgBeo0rueFyDMFNSbB/V/6r9bMHS+oZLdcfh+7VznglvyatCsPs1rol
        7oEa2lP79wIPW/oRS4+Jskc=
X-Google-Smtp-Source: AA6agR4gabFoz6Y6E2GV+9fQpfEMIy7tx92nadUdXSnpyzXqPsDOhKtNPT1wjyy/j0v62KBAC7QcqQ==
X-Received: by 2002:a2e:8857:0:b0:261:b1b3:ab93 with SMTP id z23-20020a2e8857000000b00261b1b3ab93mr7443830ljj.270.1661864401596;
        Tue, 30 Aug 2022 06:00:01 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id cf9-20020a056512280900b00494643505e1sm1053274lfb.79.2022.08.30.06.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:00:01 -0700 (PDT)
Message-ID: <44f05a0b-01a7-775d-606c-d2f0ab94ae6e@gmail.com>
Date:   Tue, 30 Aug 2022 16:00:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 14/14] iio: hmc425a: simplify using
 devm_regulator_get_enable()
Content-Language: en-US
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <8b1193fdefb231a6d721e2bded52c48e56039c20.1660934107.git.mazziesaccount@gmail.com>
 <SN4PR03MB678420C67AA8988CF706198399799@SN4PR03MB6784.namprd03.prod.outlook.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <SN4PR03MB678420C67AA8988CF706198399799@SN4PR03MB6784.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 14:49, Sa, Nuno wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>> Sent: Friday, August 19, 2022 9:21 PM
>> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
>> <matti.vaittinen@fi.rohmeurope.com>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
>> <Michael.Hennerich@analog.com>; Jonathan Cameron
>> <jic23@kernel.org>; linux-iio@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v3 14/14] iio: hmc425a: simplify using
>> devm_regulator_get_enable()
>>
>> [External]
>>
>> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
>> add_action_or_reset(regulator_disable)' and use the
>> devm_regulator_get_enable() and drop the pointer to the regulator.
>> This simplifies code and makes it less tempting to add manual control
>> for the regulator which is also controlled by devm.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
> 
> Acked-by: Nuno Sá <nuno.sa@analog.com>
> 
> (I see that in this patch you are not using dev_err_probe(). Maybe some
> consistency in the series and where applicable would be appropriate :))

I don't think the driver did originally print an error if regulator get 
or enable failed. I didn't want to add any new prints - just converted 
the existing ones to use dev_err_probe(). I believe adding new prints 
would've been somewhat unrelated change :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
