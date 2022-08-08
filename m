Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F8958C39D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiHHHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:01:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609FB124
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:01:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a9so11295847lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TNens4dzDr8b/FfgJaaPeV+Bo1fmiGV2IZIds2mzQ4U=;
        b=wCXfwUw2QoMuar6lfHymOJQ8aEuO4kEu28Jxk6Z5wZsnirHtVyXBcML6Xyfg49wBK8
         N5wqK8o7ffRno6O91+gydq3gTYpcvPbfL2rE5+I57n90uZKwQrBcL7pKZQ7zg/sI2CM3
         mtWxa2dOBHEJanRYj1xdLXeF4mNeQzpNppgE+syKltZPk4RXkhHKlsOamOU7Fq4QPHae
         iS2KQ5I0EydknwCd7OUd5oN+aJTkJict9d/a2jrzu/nPE26mvTe8JKBK7Wv/u3BaHJa6
         xo+/NkF7qTMgFsUlRJ2DCmXaiACWTpBaYpguNQFFdfEefSByeuDHSMQxHrFsIIHRWq9K
         h+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TNens4dzDr8b/FfgJaaPeV+Bo1fmiGV2IZIds2mzQ4U=;
        b=ViQpJT/aq5b9z+RyoeKhyESBHzEYRuxsSBZ9GMsXexDMRw65xwkamadirJwa4L1gwn
         9vPajAoAXiDFof5NJYc7QvNiuH6cBeTnZAdkNIZwzTX4c5A+l0jk1HUhJJZP2R7O/Hid
         muekCoC8gSOpwRYFe8ZCJOfi1AqHPSKD6PVM0S9V+PNxCeW8qa+IRWGK5+5inHT8OKkJ
         VSgyQRGei4wsrLhYsltZZw1R5aovqX+3s+HVbZjEd4nm0SaXoHJNujSDKquMQ9utMP3N
         dCp+9b3liCF2qaq4xbzcvvvRjb/EK5/PDakpPwTy5LRMnvf6rwUMgwS63q6iMhxxw1Ue
         3kyQ==
X-Gm-Message-State: ACgBeo1y9dEiVSUA6e0PLJXf0UyR5esdfvmRNV6Lvp8voW7Det1C9xNr
        hLkU+89o7zMWMtDMouc2XmvrtQ==
X-Google-Smtp-Source: AA6agR7h9f9j7kJmy4eXv6HRMrXlzHuLszLtzEP+dX+EERyr5T4kuPtlqmFellRKW1jKlCQpBzg0rA==
X-Received: by 2002:a05:6512:158f:b0:48b:714:5efa with SMTP id bp15-20020a056512158f00b0048b07145efamr6383704lfb.354.1659942079749;
        Mon, 08 Aug 2022 00:01:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h11-20020a056512054b00b0048b12f65672sm1319094lfl.272.2022.08.08.00.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 00:01:19 -0700 (PDT)
Message-ID: <9a1f19f5-e17f-d8f6-8010-e399bdd6c6b9@linaro.org>
Date:   Mon, 8 Aug 2022 10:01:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: fix the mpfs' reg property
Content-Language: en-US
To:     Conor.Dooley@microchip.com, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Daire.McNamara@microchip.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220805125618.733628-1-conor.dooley@microchip.com>
 <20220805125618.733628-2-conor.dooley@microchip.com>
 <04b697b5-d344-0191-f511-c0f8e0c247ef@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04b697b5-d344-0191-f511-c0f8e0c247ef@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 15:01, Conor.Dooley@microchip.com wrote:
> On 05/08/2022 13:56, Conor Dooley wrote:
>> The "data" region of the PolarFire SoC's system controller mailbox is
>> not one continuous register space - the system controller's QSPI sits
>> between the control and data registers. Split the "data" reg into two
>> parts: "data" & "control".
>>
>> Fixes: 213556235526 ("dt-bindings: soc/microchip: update syscontroller compatibles")
> 
> I omitted the second fixes tag:
> Fixes: ed9543d6f2c4 ("dt-bindings: add bindings for polarfire soc mailbox")
> 
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   .../bindings/mailbox/microchip,mpfs-mailbox.yaml  | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
