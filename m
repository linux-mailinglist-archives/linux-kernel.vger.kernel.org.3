Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1E5A2293
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiHZIGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiHZIGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:06:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F39D4744
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:06:30 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-33dc31f25f9so17136457b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7Mq11P25bR3wlSS6rhp/KK7HEHcVP2nqSIE7qecBSHI=;
        b=A6bJ+AnhSeKOqL2xoFgZgqXmcNg60G7gBzknU5skktv31cbrZtiqklVBvs+nmq2jBm
         y6mTIeVsVgtR5v+CnFSal6nO1qBaDJMjwBpArsPYg63W9RrTb5QhdkZMrcMdTmgS5jkv
         PMo5OKXzNGhw7zJ1mOVDZwD2NFY60tqzH//Wul+1voGYIhOKpA/VvmtTNtQXnVHsK7a3
         BcWq3qzH65wl9D4aFjgTkN1zLOTRuV259Th5v16GqLTjQZyxO+JmhDNCEB4Q9PRuIt9J
         NjkE58DwKus4IgFslbGcg0EtNvBEX/paL9LgvEz0rilkjPBepSdq5S1JAQvLlAqunZrs
         1WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7Mq11P25bR3wlSS6rhp/KK7HEHcVP2nqSIE7qecBSHI=;
        b=QXdlwDqF7n5Y0rCdOnsNz1eC3emVglZzG2AyHvEuTDgORXY23DKuQJhZejzqixAR0U
         5+0OCuciCuEDi3DRzr5q+wqTRBZ798VjJLSaBYPIkKdvp/xMmcX1fHQdcQW9ymaR18cP
         DaErGnM4KUTOJptKzRo29J7mYNVLSo3ogzNytmGwGtAjLtX60FmhJtLxSwK5F2OOm6Bx
         WHCKJ1NoJQjlwL3UuJRXFGKQs/fv7g0geD+pFLbEkyUQZnIABk3fsWKYnbf8xjR+qUjB
         m9AdhEPN8E7MaHnA5vM8BYUDEIIWKKE9+20qegxUCxj5ETWIT5h/y6A0GtscHIFYrxga
         J+dw==
X-Gm-Message-State: ACgBeo13eSef+ylS+TPYDTEM+MXCBVUUyUEy0+jNZ88pv/srAYmVd7L8
        wHenImIeRN71XI3vUChNGgqJyZWy8IGxapEU8DynKw==
X-Google-Smtp-Source: AA6agR6FRbsPnMzYQMsuZG4nfrnAtmeF6GVqmVA9wFaaxz61tGMBwBc+pUgqKF23zqjXCnnpgwdYoweEHrVV87xeqLE=
X-Received: by 2002:a81:9296:0:b0:33c:ba30:6ff8 with SMTP id
 j144-20020a819296000000b0033cba306ff8mr7080387ywg.285.1661501190206; Fri, 26
 Aug 2022 01:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-5-bchihi@baylibre.com>
 <05fa19f7-7997-51c3-767f-c40cb321d2a4@linaro.org>
In-Reply-To: <05fa19f7-7997-51c3-767f-c40cb321d2a4@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Fri, 26 Aug 2022 10:05:52 +0200
Message-ID: <CAGuA+opoKKvQvC0aij_L1t8BQG2rHJDwx-U=XjgvaqK5Bg-WdQ@mail.gmail.com>
Subject: Re: [PATCH v9,4/7] thermal: mediatek: Add LVTS driver for mt8192
 thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

Thank you for the feedback.

I hope this information will explain better the LVTS Driver.
I will add this like the following.
Is this ok for you?

[v9,7/7] thermal: mediatek: Add LVTS driver settings for mt8195 thermal zon=
es
One Clock and one Reset for Thermal.
Thermal have two domain : CPU related (mcu) and non-CPU related (ap).
TC : Thermal Controller to control the thermal sensor's HW behavior.
TS : Thermal Sensor for measuring temperature the HW module.
thermal
=E2=94=9C=E2=94=80=E2=94=80 ap
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_0
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS4_0 - vpu1
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS4_1 - vpu2
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_1
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS5_0 - gpu1
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS5_1 - gpu2
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_2
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS6_0 - vdec
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS6_1 - img
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS6_2 - infra
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 tc_3
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS7_0 - cam1
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS7_1 - cam2
=E2=94=94=E2=94=80=E2=94=80 mcu
=E2=94=9C=E2=94=80=E2=94=80 tc_0
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS1_0 - cpu_big1
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS1_1 - cpu_big2
=E2=94=9C=E2=94=80=E2=94=80 tc_1
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS2_0 - cpu_big3
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS2_1 - cpu_big4
=E2=94=94=E2=94=80=E2=94=80 tc_2
=E2=94=9C=E2=94=80=E2=94=80 TS3_0 - cpu_little1
=E2=94=9C=E2=94=80=E2=94=80 TS3_1 - cpu_little2
=E2=94=9C=E2=94=80=E2=94=80 TS3_2 - cpu_little3
=E2=94=94=E2=94=80=E2=94=80 TS3_3 - cpu_little4

[v9,4/7] thermal: mediatek: Add LVTS driver for mt8192 thermal zones
One Clock and one Reset for Thermal.
Thermal have two domain : CPU related (mcu) and non-CPU related (ap).
TC : Thermal Controller to control the thermal sensor's HW behavior.
TS : Thermal Sensor for measuring temperature the HW module.
thermal
=E2=94=9C=E2=94=80=E2=94=80 ap
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_0
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS4_0 - vpu1
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS4_1 - vpu2
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_1
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS5_0 - gpu1
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS5_1 - gpu2
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 tc_2
=E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS6_0 - infra
=E2=94=82 =E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS6_1 - cam
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 tc_3
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS7_0 - md2
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS7_1 - md3
| =E2=94=94=E2=94=80=E2=94=80 TS6_2 - md1
=E2=94=94=E2=94=80=E2=94=80 mcu
=E2=94=9C=E2=94=80=E2=94=80 tc_0
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS1_0 - cpu_big1
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS1_1 - cpu_big2
=E2=94=9C=E2=94=80=E2=94=80 tc_1
=E2=94=82 =E2=94=9C=E2=94=80=E2=94=80 TS2_0 - cpu_big3
=E2=94=82 =E2=94=94=E2=94=80=E2=94=80 TS2_1 - cpu_big4
=E2=94=94=E2=94=80=E2=94=80 tc_2
=E2=94=9C=E2=94=80=E2=94=80 TS3_0 - cpu_little1
=E2=94=9C=E2=94=80=E2=94=80 TS3_1 - cpu_little2
=E2=94=9C=E2=94=80=E2=94=80 TS3_2 - cpu_little3
=E2=94=94=E2=94=80=E2=94=80 TS3_3 - cpu_little4

Best regards,
Balsam.

On Thu, Aug 25, 2022 at 7:29 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Balsam,
>
> On 17/08/2022 10:07, bchihi@baylibre.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> >
> > Add LVTS v4 (Low Voltage Thermal Sensor) driver to report junction
> > temperatures in MediaTek SoC mt8192 and register the maximum temperatur=
e
> > of sensors and each sensor as a thermal zone.
>
> Thanks for your work
>
> First of all, the patch is way too big.
>
> The organization of the data is hard to understand.
>
> Could you give a description of the sensors, how they are organized ?
>
> I can see the there are 'tc' and each have a group of sensing points? Is
> that correct? Do have the 'tc's a shared clock? etc ...
>
> I have another email with the comments inline but without more insights
> on the hardware it is difficult to review accurately. This driver looks
> more complex than the other ones I've reviewed. At least that is what
> looks like with the different macros names found.
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
