Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4BE576714
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGOTE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGOTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:04:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA813E06
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:04:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sz17so10531597ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bv2dOhFfF2dk3rLWdihNlfJKNevFVvMuIuaBR1GrWRE=;
        b=C2TKJm5IFjGEWJD7Q5OSvM7ms789VUE4H0SshdOsXi3HBldXepa1WRPnnUZ3nQBm90
         3zhmtQC7b9aYbi4fWkgPIttqG2M1era+PHqkCZW+8RpCvSlU+5B8cPssYmOIGo/632Xa
         +aVeXZnSE97zEg767JEi34Keyf5Vlka4VFLlN0625atSzEXPcLlWIf7wke1im0r8X1OZ
         D94rXiwPs/C4fjZazbdxyZ+h+HkPbcs1HMzJlDu6oY60Pu0A7aR++StIjYgJrLwMt/rx
         KxWjGMUripZKRDqbL8CqH72TlXYi3OcXSCYACwmgIzpo3lOUnrSBTBXXxgX1x3r6tMEn
         nL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bv2dOhFfF2dk3rLWdihNlfJKNevFVvMuIuaBR1GrWRE=;
        b=wrNsrUKo+w7LTxt3A0C9pW6u4s3PteoPfMLvxDPDXQXDekvJpd7znaau7mS7RObTKP
         bqeSjbdsOpNwMCHnKM23Baj252UOhLPXk4A2pnGKNB0P/PMQHOb9A5OSELRLUg6v7B9k
         0pL1VWptR35R/6hsKSvYDWtYHKJ+w3O5mhjfTqMuTQNE++SNQtstVw/3/L6EFJ0Uowuu
         CsHlj/RkEU++4DgoUjkR5Ag1sk8znSdCV5QHSKm2GrpupiiDu4tYBioyfDNXl/x9Bxe+
         M+zHd6iv53Xdrre1YFWzJH/9V0MD51vCabyL05MPPulRQJGg/Bt1W4540aeiYqSk9Nn6
         /ygw==
X-Gm-Message-State: AJIora+bij+/jz0pyyo0TgEW140lT1e12vRB633ymbL2RKzjv3PaFOTk
        EHvdPQJYinYgDG7ws9Y8Sbg/iw==
X-Google-Smtp-Source: AGRyM1tPel0R2mg91POFeBUbB4WlNmAh0eE483+HEoJ5xuYhHXc/h54jUcmOslGngJBsu7eYtwFQaA==
X-Received: by 2002:a17:907:9605:b0:6f5:c66:7c13 with SMTP id gb5-20020a170907960500b006f50c667c13mr15273977ejc.66.1657911862212;
        Fri, 15 Jul 2022 12:04:22 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id u18-20020a05640207d200b0042dcbc3f302sm3276938edy.36.2022.07.15.12.04.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:04:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
Date:   Fri, 15 Jul 2022 21:04:20 +0200
Cc:     wens@kernel.org, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF7CC548-88C9-4889-8A41-8E99C31EF81C@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
 <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
 <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.07.2022 um 20:57 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 2022-07-15 19:11, Robin Murphy wrote:
>> On 2022-07-15 18:16, Christian Kohlsch=C3=BCtter wrote:
>>> OK, this took me a while to figure out.
>>>=20
>>> When no undervoltage limit is configured, I can reliably trigger the =
initialization bug upon boot.
>>> When the limit is set to 3.0V, it rarely occurs, but just after I =
send the v3 patch, I was able to reproduce...
>> Well this has to be in the running for "weirdest placebo ever"... :/
>> All it actually seems to achieve is printing an error[1] (this is =
after all a tiny 5-pin fixed-voltage LDO regulator, not an intelligent =
PMIC), and if that makes an appreciable difference then there has to be =
some kind of weird timing condition at play. Maybe regulator_register() =
ends up turning it off and on again rapidly enough that the card sees a =
voltage brownout and glitches, and adding more delay by printing to the =
console somewhere in the middle gives it enough time to act as a proper =
power cycle with no ill effect?
>=20
> ...and apparently the answer is yes, it seems to be doing exactly that =
(see attached). But seemingly my SD cards don't mind, or maybe my T4 =
board happens to have more capacitance than Christian's R4S so my =
voltage dip isn't as bad, or both.
>=20
> So it seems like the solution here might indeed simply be to remove =
the regulator-always-on which doesn't seem to have any reason to be here =
anyway. Without that, the enable stays low until the MMC driver probes =
and claims it, which is then massively longer than the time it takes for =
VCC3V0_SD to ramp down completely.
>=20
> Robin.

Removing "regulator-always-on" has the effect that the system freezes =
upon reboot. There may well be another bug slumbering in the codebase =
that is circumvented by 1. adding a delay in the code and 2. not turning =
the regulator off upon shutdown.

