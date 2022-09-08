Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155045B2290
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIHPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiIHPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:39:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2CAE869
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:39:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a8so6797023lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/qBH6KKCOo4Rcx25AYdQ3+VqjrDHctqta1bBs0dfmFM=;
        b=klnczWHHrHQd2d/qHTuSqUJtUBuKG008LZQIOAmCkUS5l8AhHFyaASpbz0yKFzM9v8
         yT9KtKzkatdPj/CzMRUHveM5HYY/aZexRpsNNHCsnZNsmhsCh+x2Uo2VaJ+YuiG41u/3
         X5MiTDaKjMhq2AfyGnJYvIPwL1tJgtX2D0Q5iVc5iVSMsTAb7ng32XiR+POQljbQeR0o
         0q+5Gddt1MvAIfI8GlLRS9/yYN+eUC/UPLwd4SdyFgg4oXZ11qw/T5IhYzIpWrNk2AW6
         q3gRIVieQsMgdw8VjczFLMvZLddX8bftOB6G2K8bIS19X0mk9Zl/LHjuA75nkWxYImZj
         p+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/qBH6KKCOo4Rcx25AYdQ3+VqjrDHctqta1bBs0dfmFM=;
        b=TbhtE0JHZsa97D8EWeU8DrtWBYoNXHE47+zeqblooo65Yra8os8Jrlu5/1OmZQke8P
         lY8nj5HRr8/muRWjPtiQfPzknQiYyrh+43B0VFIgt8xbIuk5jq82068WhlnLWPb+OSg6
         3YDXUBynQKmpIhoHV1R6+swIVSj+JUtNXCIT6bZYBm6HDi8A7iiG0rpermI30tFXJ40K
         FMhvTar0rYOYLbu7I6dgH+1sxmPx8D1OfnTRBWV0qay+IayksRG7euSExJ7fKLeLnitZ
         yAfw57c52Kjy+/qTuQucR39EuCOtM+x5Ho3hXXoZ568eu9LMPiMzCDq6QJc1KhzQ4y/G
         u8Fw==
X-Gm-Message-State: ACgBeo0dM8uu82vnAd9Yy0SfGCDovw1smw/U4mq4oJFs6+P/c18W/bP8
        GY1pG3n+38OBef66eWDcEmObsg==
X-Google-Smtp-Source: AA6agR4EP2j4iDhlAbs3f/SgHcGY0oi4XQLRglC+LXjLmaxGtFOjzJUuwIeZknz7bqXYrG6Yq+1nlQ==
X-Received: by 2002:a05:6512:220d:b0:494:70c1:45dd with SMTP id h13-20020a056512220d00b0049470c145ddmr3143409lfu.325.1662651546517;
        Thu, 08 Sep 2022 08:39:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y5-20020a05651c220500b0026b2094f6fcsm468368ljq.73.2022.09.08.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:39:05 -0700 (PDT)
Message-ID: <2f83d3d3-853f-96fe-0613-b524a8d99010@linaro.org>
Date:   Thu, 8 Sep 2022 17:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Content-Language: en-US
To:     Jerry.Ray@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
 <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
 <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
 <42c193c8-5edf-4b00-9f76-34b9cc947dc8@linaro.org>
 <MWHPR11MB1693A5AF16E14FFA06D80653EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
 <dc22442d-83c0-e6b7-a356-9a6e8e4d8a83@linaro.org>
 <MWHPR11MB1693DCB1AED7F08CD1A85F70EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MWHPR11MB1693DCB1AED7F08CD1A85F70EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 17:32, Jerry.Ray@microchip.com wrote:
>>>>>>> +     chosen {
>>>>>>> +             stdout-path = "serial0:115200n8";
>>>>>>> +     };
>>>>>>> +
>>>>>>> +     clocks {
>>>>>>> +             slow_xtal {
>>>>>>
>>>>>> No underscores in node names. Override by label.
>>>>>>
> 
> I am not at liberty to change this as both node name and label are defined in the sama5d3.dtsi source file.
> If there is a way to override the label, please share the syntax as nothing I have tried is working.

Override *by* label. Not the label. Just like all things are being
customized.

&slow_xtal {
	...
};


Best regards,
Krzysztof
