Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC448E3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiANFsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:48:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:39371 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiANFsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:48:24 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220114054821epoutp034bcc1b3878f5252e669e28eb18f07205~KDP6Xk5hg3209632096epoutp03Y
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220114054821epoutp034bcc1b3878f5252e669e28eb18f07205~KDP6Xk5hg3209632096epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642139301;
        bh=X1p948d3urtpJlqPdW8m16ZXR/ar2loRfYP3r8Kfsl8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=d8LqBGm5XUnBVtBaLXpUf4bcHlpl/X+ZVzm8y5AOwNI7Jwro+xeAdP5RP7n6uMsiI
         URNwn7FLi8K/AQrbDqY+58IbuX4csy0vHvfjf5NE3q59TDlsp/P71ajrPsicmwANIq
         ERIrVBenfsqoYqmSBimbzhT4ZySzTWvKSLX+iHTE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220114054821epcas5p4b47e131c31988fd6037a9a84b043455a~KDP578VlL1083810838epcas5p4h;
        Fri, 14 Jan 2022 05:48:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZr1p47bNz4x9Q0; Fri, 14 Jan
        2022 05:48:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.07.46822.E9E01E16; Fri, 14 Jan 2022 14:48:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220114054814epcas5p3616ca028567371af18120160419632b6~KDPzPMTlN2280222802epcas5p30;
        Fri, 14 Jan 2022 05:48:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114054814epsmtrp2402acd7717c9c658516bb090dc187e1c~KDPzOLyhv3095230952epsmtrp2y;
        Fri, 14 Jan 2022 05:48:14 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-c8-61e10e9e00d9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.B9.29871.D9E01E16; Fri, 14 Jan 2022 14:48:14 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114054811epsmtip25906b32e7d241eede493cc5f22ad5104~KDPw9j-7u2435124351epsmtip2e;
        Fri, 14 Jan 2022 05:48:11 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <c87f500e-e43e-465c-94fa-050c2b0de083@canonical.com>
Subject: RE: [PATCH 01/23] dt-bindings: clock: Document FSD CMU bindings
Date:   Fri, 14 Jan 2022 11:18:10 +0530
Message-ID: <076201d8090a$5208eff0$f61acfd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgK+Rz8NAfWcy00CRGI64ap95Tsg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmhu48voeJBnsXylm8X9bDaDH/yDlW
        i41vfzBZTPmznMli0+NrrBYfe+6xWjx8FW5xedccNosZ5/cxWZy6/pnNYtHWL+wWrXuPsFsc
        ftPOavH4+h82Bz6PNfPWMHrMauhl89i0qpPN4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6f
        N8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAy
        BSpMyM5oOv2RqWCSTEXj3n/MDYwfxLoYOTgkBEwk2q/kdjFycQgJ7GaUWPn6FAuE84lRYt2u
        K6wQzjdGie935gI5nGAdn86/ZIRI7GWUOL96IVhCSOAlo8T1exIgNpuArsSOxW1sIEUiAp2M
        Equ//2QCcZgFVjBJzD91lwWkilPAUeJA3xYmEFtYwENi5+cZbCA2i4CqxLGl89hADuQVsJTY
        P9MeJMwrIChxcuYTsFZmAXmJ7W/nMENcpCDx8+kysCNEBNwkNvztYIOoEZd4efQIO8heCYEX
        HBLPDq+CesFF4vjdP2wQtrDEq+Nb2CFsKYnP7/ayQQImW6JnlzFEuEZi6bxjLBC2vcSBK3NY
        QEqYBTQl1u/Sh1jFJ9H7+wkTRCevREebEES1qkTzu6tQndISE7u7oQ7wkFh6djH7BEbFWUge
        m4XksVlIHpiFsGwBI8sqRsnUguLc9NRi0wKjvNRyeHQn5+duYgQnbC2vHYwPH3zQO8TIxMF4
        iFGCg1lJhLe/6H6iEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4H5oy8knhDE0sDEzMzMxNL
        YzNDJXHe0+kbEoUE0hNLUrNTUwtSi2D6mDg4pRqYlp19+k52vTvXCsWVj6d/OzR7TqbaiZsW
        Xlrp6yQ3Kl2VNr6WvvwV+7zVVU5iu5bb/PzJulj5aG3zslPNH17unuEsmmoTV39Nqvj3vlP3
        SmWryvZn7r8uEVvqpH9UR0VLK8zHjJ+r/1hQ2oKlRZK29c4nN184qu4g6ijzdcLpPY2Nmhd3
        qJTemHGkZU6gDW+10bWdRvZedtGKF/rSGbKmvFq8foHFdg2X6wL79Oun79iiwZFlkvvrX6t7
        rF+3t0/TjRMM8r2Lb2f6Lgh8z98Z0jO3aaOa2u2tS4SvrdyffITde+q3WPnMHXM2WE8XtPmz
        8POG6DMffuv2GFduaeNeZCvvz6wvsffMwnecSwytlViKMxINtZiLihMBLwQdMWEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSvO48voeJBjebGS3eL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKO4bFJSczLLUov07RK4MppOf2QqmCRT0bj3H3MD4wexLkZODgkBE4lP518ydjFycQgJ
        7GaUOPb0PzNEQlri+sYJ7BC2sMTKf8/BbCGB54wS73v1QWw2AV2JHYvb2ECaRQS6GSWu9MwE
        m8QssIVJovPFGWaIsV8YJY7P/MMC0sIp4ChxoG8LE4gtLOAhsfPzDDYQm0VAVeLY0nlANgcH
        r4ClxP6Z9iBhXgFBiZMzn4C1MgtoS/Q+bGWEsOUltr+dA3WpgsTPp8tYQWwRATeJDX872CBq
        xCVeHj3CPoFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEx66W5g7G7as+6B1iZOJgPMQowcGsJMLbX3Q/UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQam3W28UQtP7Wg/b21TY3T2ePtnv2yeLYXtbTvdZXZ2
        LMu97NIWmBp35E5O6JPLuvELkrb9Mm+oEalOWuWlfPRO9RRHnt5Cd8mkH6+rLCa9nJsu/MBz
        dtGxpYdmRDIX2e1b26tUeGLbauHo45f+rOh/EaQk/FWY17SDiT8xXnRuYflkST/7Fc+vGS8y
        9DBiPMrA+HtJQPGz9ms2uzwkG93NdmQ3u8xjNAlKff/Jw/tK34z3Clqm/4v3NZllViUcybiS
        zHZU5l6+VJvBY//WeRK1E4VTSnYYh0dPnbyM8Wz/zY/79Q/lCjSkr1aSYX0aKLNS3HBFYSjX
        r8d/k6XOHhXj1q+x9Fl1a/ulMuX3GkosxRmJhlrMRcWJAGN4rGVMAwAA
X-CMS-MailID: 20220114054814epcas5p3616ca028567371af18120160419632b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e@epcas5p4.samsung.com>
        <20220113121143.22280-2-alim.akhtar@samsung.com>
        <c87f500e-e43e-465c-94fa-050c2b0de083@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Thursday, January 13, 2022 6:11 PM
>To: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>Cc: soc@kernel.org; linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
>olof@lixom.net; linus.walleij@linaro.org; catalin.marinas@arm.com;
>robh+dt@kernel.org; s.nawrocki@samsung.com; linux-samsung-
>soc@vger.kernel.org; pankaj.dubey@samsung.com; linux-fsd@tesla.com
>Subject: Re: [PATCH 01/23] dt-bindings: clock: Document FSD CMU bindings
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add dt-schema documentation for Tesla FSD SoC clock controller.
>>
>> Cc: linux-fsd@tesla.com
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  .../bindings/clock/tesla,fsd-clock.yaml       | 212 ++++++++++++++++++
>>  1 file changed, 212 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
>> b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
>> new file mode 100644
>> index 000000000000..58f341e5004d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
>> @@ -0,0 +1,212 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>> +---
>> +$id:
>> +https://protect2.fireeye.com/v1/url?k=7e607c7a-1f1d943d-7e61f735-74fe
>> +485fff30-a4acf0e03cbf256d&q=1&e=05b30de9-b535-49f7-9359-
>77edd951da07&
>> +u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Ftesla%2Cfsd-
>clock.y
>> +aml%23
>> +$schema:
>> +https://protect2.fireeye.com/v1/url?k=5c769dcb-3d0b758c-5c771684-74fe
>> +485fff30-b4007a892a5a3e44&q=1&e=05b30de9-b535-49f7-9359-
>77edd951da07&
>> +u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: Tesla FSD (Full Self-Driving) SoC clock controller
>> +
>> +maintainers:
>> +  - Alim Akhtar <alim.akhtar@samsung.com>
>> +  - linux-fsd@tesla.com
>> +
>> +description: |
>> +  FSD clock controller consist of several clock management unit
>> +  (CMU), which generates clocks for various inteernal SoC blocks.
>> +  The root clock comes from external OSC clock (24 MHz).
>> +
>> +  All available clocks are defined as preprocessor macros in
>> + 'dt-bindings/clock/fsd-clk.h' header.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - tesla,fsd-clock-cmu
>> +      - tesla,fsd-clock-imem
>> +      - tesla,fsd-clock-peric
>> +      - tesla,fsd-clock-fsys0
>> +      - tesla,fsd-clock-fsys1
>> +      - tesla,fsd-clock-mfc
>> +      - tesla,fsd-clock-cam_csi
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 6
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 6
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: tesla,fsd-clock-cmu
>> +
>
>Nitpick: Drop the white-spaces between if-then. It's easier to spot the if-
>blocks if they are together.
>
Thanks will fix in next version

>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: External reference clock (24 MHz)
>> +
>
>Drop this whitespace as well.
>
Noted

>Rest looks good to me, except the discussion about the compatible.
>
Have replied to the original question thread. 
>
>Best regards,
>Krzysztof

