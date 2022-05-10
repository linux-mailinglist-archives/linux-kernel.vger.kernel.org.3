Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7DE52252D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiEJUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiEJUHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:07:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C050E22;
        Tue, 10 May 2022 13:07:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so63177wmn.1;
        Tue, 10 May 2022 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7t/dYXLOrWyPR6e0gTNdWYUxgAYSle4zMbdfPRexeZ4=;
        b=HH/0nVElAF1y1rfGeHMRJkzArUwXxGETMXm7YSwP6adEtbBrqQeCIhTK1zmfD7cxv/
         si0xd5hAK4tTB9uTqtErFdShC6u/yyHfDgw/tjkcbWerpuQ5Usk3Xm9KGLuQVC4P8oOL
         F/zxSZkEI0z9D0uaZWYkXuQc7DJCuhwH6JlSG7nIO42IB5wCXZSYzeFcZH+OkuBmZezp
         Hq6hPw3ekzzNr45+LltY3RYlJSsP90dLJ7MWbMW/zVA5v1Yv6I7cjfu5Z/jDWZRtRvCv
         JX+WluFOWXgRCeVsSovdv+e5DgAIqMBcAWsrHPNaH9anvMVX4TCVPXMtPfbbmzJ9vRDy
         R10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7t/dYXLOrWyPR6e0gTNdWYUxgAYSle4zMbdfPRexeZ4=;
        b=VVTgGLKvK3Gv3qCne+a8egOWmLEH0OncRXrPxlrhU0Z4GcuDjtwtbx3lKAXRga9IxT
         0P0U++WgWnbkTmq8G+qvS/aAEDzf2j4aZoF9PyMrlhNdJ1GGNN9VWyyzgEvGz5eGEv4+
         wREMeaUCD3gKDJJhCZfstcWFvAXsFVVRS7zvw/8f2Lh2OLyYDFOA81X3XVzLrE681iqP
         8RS6cIjlRUpnx62P0lDF7J3SyjfrytgKjqBUrhD0XmB1rzvXsWKuw51btIsyLNWLadMi
         Zf5S6ucgpp1H6dosn5MmCEedvKpaY8ul8pG3ZYNz+zjJcGfFOTrihjixssM2Fo5GJPwN
         ok3w==
X-Gm-Message-State: AOAM530Xx7Qy2LMyrVFOT2ARkdwe/tz6vU4y2ziyDWdfaWyK7nla6yMt
        Fxm5gQ7yn8BGV833L3Ehl8A=
X-Google-Smtp-Source: ABdhPJw8eBlTdeQItDiSVzgwx/oTcwDXSW+F/WbdYeS8IuSJSeObVG3fASZ44OIF6Fa5hCrhTAlAlA==
X-Received: by 2002:a05:600c:34c8:b0:394:92b4:f63c with SMTP id d8-20020a05600c34c800b0039492b4f63cmr1603994wmq.58.1652213266681;
        Tue, 10 May 2022 13:07:46 -0700 (PDT)
Received: from [172.22.204.227] ([104.28.230.247])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b0020c6fa5a797sm15013148wrr.91.2022.05.10.13.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 13:07:46 -0700 (PDT)
Message-ID: <ede9e050-3b60-ba0e-c626-044f7825adb7@gmail.com>
Date:   Tue, 10 May 2022 23:07:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mtd: parsers: add support for Sercomm partitions
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220329122016.4122899-1-csharper2005@gmail.com>
 <20220330100958.57dc4d61@xps13>
From:   Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <20220330100958.57dc4d61@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 3/30/2022 11:09 AM, Miquel Raynal wrote:
> Hi Mikhail,
>
> csharper2005@gmail.com wrote on Tue, 29 Mar 2022 12:20:16 +0000:
>
>> This adds an MTD partition parser for the Sercomm partition table that
>> is used in some Beeline, Netgear and Sercomm routers.
>>
>> The Sercomm partition map table contains real partition offsets, which
>> may differ from device to device depending on the number and location of
>> bad blocks on NAND.
>>
>> Device tree example:
>> partitions {
>> 	compatible = "sercomm,sc-partitions", "fixed-partitions";
>> 	#address-cells = <1>;
>> 	#size-cells = <1>;
>>
>> 	partition@0 {
>> 		label = "u-boot";
>> 		reg = <0x0 0x100000>;
>> 		scpart-id = <0>;
>> 		read-only;
>> 	};
>> };
> You'll need a DT binding patch and Rob's ack!

I hope that I near to finish with DT binding...

Link:
https://lore.kernel.org/all/20220510162314.20810-1-csharper2005@gmail.com/

Link:
https://lore.kernel.org/all/20220510162403.20861-1-csharper2005@gmail.com/

>> This is essentially the same code as proposed by NOGUCHI Hiroshi
>> <drvlabo@gmail.com> here:
> I would credit Hiroshi with a Suggested-by at least

I read submitting patches rules again and thought that Signed-off-by is
suitable for this case. Is this ok?

Link:
https://lore.kernel.org/all/20220510162655.21011-1-csharper2005@gmail.com/

>> https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394
> And use a Link: tag for this.
>
Fixed, thanks!

Link:
https://lore.kernel.org/all/20220510162655.21011-1-csharper2005@gmail.com/

> Thanks,
> Miquèl
-- 
Best regards,
Mikhail

