Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915274E1AC5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 09:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbiCTIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiCTIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 04:22:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3764BFDA;
        Sun, 20 Mar 2022 01:21:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q14so3034534ljc.12;
        Sun, 20 Mar 2022 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H5jqTsReHjJpHbnZQQczWjSuTqgW0vC/dZTYtBAjSnc=;
        b=EPr3LbdzLYezPN2YQME62GNvv4acBq0u420N6LQEEBYBigFexkTSTeivHD2BFSoRKA
         TBDYmIfSod8wh4bWAUOo7bxtCzbU5aRVZFpY4vI/6LK09LNyCXVxxzFDYRzqQ0KTjb4T
         ZTgZbAex8YYSFEEbw3r0czvOmIdCcu4Wj5WH5zlMcDeYcpiZBiZu0oipMx7bsft7O46Z
         fClGWrXcsyovrAHcRkHXrscHGTXt+kOzO73KeuxufoWt+GoGnOp4mwdlMMz0JwZuokc0
         QYKg+tSYAzdoTQyF20bNaaDtlztEUkM95tG5tSkeR60z/yi7PxuNIVdBShLA6zd+gjSz
         PPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H5jqTsReHjJpHbnZQQczWjSuTqgW0vC/dZTYtBAjSnc=;
        b=ULxkanb4t5cwWSUFtaZQGLWH+6cCoWq9ded4+j0FTg/E+4QzgzT7L6HZIN4HLzEde2
         4SouQk3U+GzsOu7d850Ta6rns8WT8HA9l6aOX2bz4kfmtFJ2Mrblqw0kYVWQVJRfdDKF
         gv6sK5AKcbxrPwIsnXpO9wCG7cGjRlYbwdwFeMhgYipNX6sWmP8hjsH+ZzpdR18W+moS
         T6T5m/VV78mRpQIlKM1TusCOFa9HzQrcs82xbkAhMet9bltwma2reAHWQKPr5bNJmwQg
         IwB+BJjxTnG3xEJfbyJ99zKP82Q5sJDHrdYRrhMpoPZDvVynODoRwj9uLKziWCh/0ogt
         ioeg==
X-Gm-Message-State: AOAM5309ldlJU2xGAJlSvZbsIonNy0HKhQCFaIhW6uVtrZuzXtc8g2kG
        0nOPQ8vE5WjljgPVijYYsUm9RcwEv/xdEQ==
X-Google-Smtp-Source: ABdhPJyw/MvUqES6wCAvnMJzwx5rx3Rs/R3I4PaI3L3m2x9GWui8eCx2CTqr1K2n1TEwNhy4wu/DYw==
X-Received: by 2002:a2e:2a45:0:b0:246:430d:805 with SMTP id q66-20020a2e2a45000000b00246430d0805mr11487117ljq.439.1647764457911;
        Sun, 20 Mar 2022 01:20:57 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.78.200])
        by smtp.gmail.com with ESMTPSA id v29-20020ac25b1d000000b00448ac0a2d88sm1501433lfn.47.2022.03.20.01.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 01:20:57 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] ARM: dts: lan9662-pcb8291: fix pinctrl node name
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-8-michael@walle.cc>
 <cf2a6d1a-bf98-e382-2623-e44e5979ca29@gmail.com>
 <e7467fe3a8dae5f5af84d595a0c4ab16@walle.cc>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0e791aa5-4ff1-8348-04fb-508a53246de1@gmail.com>
Date:   Sun, 20 Mar 2022 11:20:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e7467fe3a8dae5f5af84d595a0c4ab16@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 3/19/22 2:38 PM, Michael Walle wrote:

[...]
>>> The pinctrl device tree binding will be converted to YAML format. All
>>> the pin nodes should end with "-pins". Fix them.
>>
>>    It does end with "pins" already, right?
> 
> It ends with "_pins". Please note the underscore.

   Ah!

>>> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board pcb8291")
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>>  arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
>>> index 3281af90ac6d..3c7e3a7d6f14 100644
>>> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
>>> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
>>> @@ -35,7 +35,7 @@ fc3_b_pins: fcb3-spi-pins {
>>>          function = "fc3_b";
>>>      };
>>>
>>> -    can0_b_pins:  can0_b_pins {
>>> +    can0_b_pins:  can0-b-pins {
>>
>>    Mhm, I can't even see what is changed here... :-/
> 
> The name of the node, s/_/-/

   Indeed! I must have been blind then, sorry. :-)

> -michael

MBR, Sergey
