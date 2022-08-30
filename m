Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392725A5BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiH3GjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiH3GjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:39:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4591C79EDE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:39:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n17so12833995wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc;
        bh=mNuvuJblGgM9erVe7VcLK6pPLtsf0LmqJmZgGgV3TEY=;
        b=4JZcJU5Kk16NjSy/F4gIG+ZROwRDQaEaxk1TBxGeyVmhVZBBuI6MlZntdzUydskp0Y
         K2QLeLkibCJDa+iqJgONHz3Yp7okPWStEX6X/5KZddbDfK+ogKTKEomSOc//pbZKU23J
         8uoC5jijvaDy3zUtqNZBca90oR8FwjUXcnJwam1TiKWROB2VKLm5qsQEQQVTfCoyuOSo
         TB9WV0mEclmgLdHmsxiMyeSjoeoL/4wR2W6Tc4qo5E2oSQ91RoiQc7DSXCFs3KjxTG0O
         KPNWhSKWgMsvyl+JPG2BdMjDjlwa2ZbqCc4THp+M00xceZQUQOQSNS1b9CbV2R5lgNHH
         NtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc;
        bh=mNuvuJblGgM9erVe7VcLK6pPLtsf0LmqJmZgGgV3TEY=;
        b=DNiWbutAkNcjRfaejK+q6Lhy20J8DpKN1myaMYCiLQpYpN1fxYpivLBaRdICKYNyvj
         YWfoUHscj6lx6AwjKtk7chPIJibIyLd37XnjIoR4IRYnnQK4DeQ3tcD6Abv8rVZ+6vgH
         dxumSiYh8I28dZ6QhctoMdIJLgcHVZbupwPilJ2xL0mWRc3tzm3TO31EoksnMx+xHegE
         OaCo2PbuzLtkHzQn95ixX2eHc1ERY3BAkBQQ6U3j2Div4C5IjETWwe8U6YmQGKgQcPkf
         5CzYPjmXMAwJJvkAYUYqEKku6K+jQiUhFZxkLyWcpJF0ymUMKdilWUBpz0DbaCfJytD8
         RhIg==
X-Gm-Message-State: ACgBeo3SD7dJuHl5MT80KxtA5K09Q6PJvZr7UKgnUqLtC3jsVSofV0Lr
        uDFXOqiV+nEQhcbP2I//um+zgw==
X-Google-Smtp-Source: AA6agR62NkzOlArUrEk7k7uj4nn6Sn+TSr+IpCcQazgLhmOgjmRiJzUtmuBSZR6cyJwtWRmU9owjjw==
X-Received: by 2002:adf:fa4e:0:b0:225:8616:be3a with SMTP id y14-20020adffa4e000000b002258616be3amr7730934wrr.234.1661841545776;
        Mon, 29 Aug 2022 23:39:05 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a83b066401sm10964211wms.31.2022.08.29.23.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 23:39:05 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-3-yu.tu@amlogic.com>
 <19654574-bdc0-9fa5-6465-fc88b20e20c5@linaro.org>
 <c223a85a-b76e-0e82-9a8c-6b60588dc03a@amlogic.com>
 <1jmtccz0f4.fsf@starbuckisacylon.baylibre.com>
 <edc9b0bd-6c69-0562-05ca-db0496897cf1@amlogic.com>
 <1j1qszv0wa.fsf@starbuckisacylon.baylibre.com>
 <72631035-58a6-23b5-1f7e-f1643b120432@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 2/6] arm64: dts: meson: add S4 Soc PLL clock
 controller in DT
Date:   Tue, 30 Aug 2022 08:36:00 +0200
In-reply-to: <72631035-58a6-23b5-1f7e-f1643b120432@amlogic.com>
Message-ID: <1jy1v6z14n.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 30 Aug 2022 at 14:05, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2022/8/29 17:43, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Mon 15 Aug 2022 at 14:17, Yu Tu <yu.tu@amlogic.com> wrote:
>>=20
>>> Hi Jerome=EF=BC=8C
>>>
>>> On 2022/8/10 21:32, Jerome Brunet wrote:
>>>> [ EXTERNAL EMAIL ]
>>>> On Fri 05 Aug 2022 at 17:39, Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>>> Hi Krzysztof,
>>>>>       Thank you for your reply.
>>>>>
>>>>> On 2022/8/5 17:16, Krzysztof Kozlowski wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>> On 05/08/2022 10:57, Yu Tu wrote:
>>>>>>> Added information about the S4 SOC PLL Clock controller in DT.
>>>>>>>
>>>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>>>> ---
>>>>>>>     arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++++++
>>>>>>>     1 file changed, 8 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64=
/boot/dts/amlogic/meson-s4.dtsi
>>>>>>> index ff213618a598..a816b1f7694b 100644
>>>>>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>>>>> @@ -92,6 +92,14 @@ apb4: apb4@fe000000 {
>>>>>>>     			#size-cells =3D <2>;
>>>>>>>     			ranges =3D <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>>>>>     +			clkc_pll: pll-clock-controller@8000 {
>>>>>> Node names should be generic - clock-controller.
>>>>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-d=
evicetree-basics.html#generic-names-recommendation
>>>>>>
>>>>> I will change to clkc_pll: clock-controller@8000, in next version.
>>>> Same comment applies to the binding doc.
>>> OKay.
>>>> Also it would be nice to split this in two series.
>>>> Bindings and drivers in one, arm64 dt in the other. These changes goes
>>>> in through different trees.
>>> At present, Bindings, DTS and drivers are three series. Do you mean to =
put
>>> Bindings and drivers together? If so, checkpatch.pl will report a warni=
ng.
>> Yes because patches are not in yet so there is a good reason to ignore
>> the warning. Warning will never show up on the actual tree if the
>> patches are correctly ordered.
>
> I think Binding, DTS and drivers use three series and you said two series
> is not a big problem. Three series are recommended for checkpatch.pl, I
> think it should be easy for that to separate and merge=E3=80=82

No - There is only 2 series. 1 for the bindings and clock drivers and
one for the DT once things are in

>
> I've sent it to V4. Please look at V4 and give some comments.
>

That's not how it works. You sent that before v3 review was done. There
are still comments that needed to be addressed

Given the time it takes to make that review I going to completly skip v4
and I'd like on the comment to addressed before you send another version


>>=20
>>>
>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>> .
>>>> .
>> .

