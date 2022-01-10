Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E24892DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiAJH4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:56:12 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39762 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiAJHzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:55:02 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220110075458epoutp017e1aea83553b8e6e77eaaf7f12f44f8a~I2ZT-ePwC0801708017epoutp01W
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:54:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220110075458epoutp017e1aea83553b8e6e77eaaf7f12f44f8a~I2ZT-ePwC0801708017epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641801298;
        bh=qwlXQtP9F5ext8gug6klpjTMaMi9qA9lsfXndYC43QY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rN1f713miQRTqTEINUGVJH1WTjCswmK/QKV5hvr+mchARPHS+K0mQIWw2wUKsX3ji
         9zxT+Lxxv87upgy+IbZGWD4r35RVcuhJSnjUd3UaUMHeoNLHjtQ//L/D4+swsxZjA/
         S4yfEsX12AhkNvXxo9jqGxws3A+mR+4tKR5sMwU0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220110075457epcas2p418e4ff7a69f689f57ba1896c7a8b751b~I2ZTvi5Wa2010420104epcas2p4F;
        Mon, 10 Jan 2022 07:54:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JXR1n6jNkz4x9QC; Mon, 10 Jan
        2022 07:54:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.61.12141.C46EBD16; Mon, 10 Jan 2022 16:54:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220110075451epcas2p3a142aa3b5f2db818bc8b265fd43da6a1~I2ZOIFwbg3075130751epcas2p3Y;
        Mon, 10 Jan 2022 07:54:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220110075451epsmtrp249d78ef09e7f5b60ca93dea68cc42db6~I2ZOHcFWY1326413264epsmtrp28;
        Mon, 10 Jan 2022 07:54:51 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-67-61dbe64c590a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.09.29871.B46EBD16; Mon, 10 Jan 2022 16:54:51 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220110075451epsmtip19c5ed1498f431e68b8c7c1fea682593f~I2ZN62-WV2768227682epsmtip1Y;
        Mon, 10 Jan 2022 07:54:51 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
Cc:     <linux-samsung-soc@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>
In-Reply-To: <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
Subject: RE: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
Date:   Mon, 10 Jan 2022 16:54:51 +0900
Message-ID: <000a01d805f7$591355d0$0b3a0170$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQEnoo2qafElQH45GtRdqE4m1EGOfAFH2HbTAinQuYgB/g5c4q2RKNbw
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdljTXNfn2e1Eg49vhS02vv3BZHF51xw2
        ixnn9zFZHH7TzmrxvA/IWrXrD6MDm8eshl42j52z7rJ73Lm2h82jb8sqRo/Pm+QCWKOybTJS
        E1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOALlBSKEvMKQUK
        BSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd8+TqD
        ueCobsXG4/2sDYzfVboYOTkkBEwk5s16yNjFyMUhJLCDUWL+x3Y2COcTo8Skez1MIFVCAt8Y
        JY79YIbp2NP5kwWiaC+jxNTrC9khnBeMEhembQarYhPQl3jZsY21i5GDQ0SgUKJ7WgxIDbPA
        YUaJBROOs4PUcAo4StyYsxrMFhZwlzjxYBUriM0ioCqxeFsXE0gvr4ClRMOUcpAwr4CgxMmZ
        T1hAbGYBbYllC19DHaQg8fPpMlaIuIjE7M42Zoi1bhLzfjODrJUQ6OWQeNDexw4SlxBwkWjv
        8IJoFZZ4dXwLO4QtJfH53V42iPpuoOdf3oVKzGCUeHczB8I2lpj1rJ0RZA6zgKbE+l36ECOV
        JY7cgrqMT6Lj8F+oTbwSHW1CEI3qEge2T2eBsGUluud8Zp3AqDQLyV+zkPw1C8kvsxB2LWBk
        WcUollpQnJueWmxUYAKP6eT83E2M4JSp5bGDcfbbD3qHGJk4GA8xSnAwK4nw7r1wK1GINyWx
        siq1KD++qDQntfgQoykwoCcyS4km5wOTdl5JvKGJpYGJmZmhuZGpgbmSOK9XyoZEIYH0xJLU
        7NTUgtQimD4mDk6pBqaJKvlzvvSv+9OxRO8zl6qEuLVmxMm4y+/eHjnScXWd5IUEyeSlmf1f
        1y0779+0pbnP1ORtydcXornGyTJfCk1ndW/n/7zwvvfVC/NEGoWjNni8ev2xKmKdx7P4938F
        f15TVeb/VDsxjmXhyq82czW23cwvqoyb8Hmq7IRZM+/2nelyONR7TvHzomKWU0ZspcIK/8Pe
        vo1WOsgmHBqfq26s5X4jara4jEDcTV2BjSuevp7n3dG9/iRHbUJWfmXlphqZhQ3rT9z0iqqN
        23f2wwvG9gxLj/Z17+56rLq1d4ehVFCmPV8Xx7nUgMoXU7ccOdslkmjo/PI3c8qVctmXjio7
        r6/Mml+964ngAgelM/xKLMUZiYZazEXFiQAxK1ZuIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnK73s9uJBrNe6FhsfPuDyeLyrjls
        FjPO72OyOPymndXieR+QtWrXH0YHNo9ZDb1sHjtn3WX3uHNtD5tH35ZVjB6fN8kFsEZx2aSk
        5mSWpRbp2yVwZZzruMFYsFS34lnzHZYGxsMqXYycHBICJhJ7On+ydDFycQgJ7GaU2HvuIQtE
        Qlbi2bsd7BC2sMT9liOsEEXPGCVuHd3DCJJgE9CXeNmxjRXEFhEolNj4ZQ3YJGaBo4wSLbt/
        gxUJCfQwSey76QJicwo4StyYsxpsqrCAu8SJB6vAmlkEVCUWb+ti6mLk4OAVsJRomFIOEuYV
        EJQ4OfMJ2EHMAtoST28+hbOXLXzNDHGcgsTPp8tYIeIiErM725hBxogIuEnM+808gVF4FpJJ
        s5BMmoVk0iwk3QsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHkJbmDsbtqz7o
        HWJk4mA8xCjBwawkwrv3wq1EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGpgCVkxh3ca0+UKemNePGeLWqVG/q+w8Hl3Ydy+/ml9wovIOCbfHE5v+cjs+
        rHr246XGp/y9y08qLfXi1o6Y9cD+h4770oj7kb03f+f5X1VvypW+/ZfxUG+mYFa8vOE/14bn
        n06LCD5KWnNi2fHspJX7/vEEGu4WvyFeZfLOyq1iQ5Fgfju7NreurZSf70+WfXeeRJiaPlKX
        6Pf3ZT7gzJ7g+vaslf3xVoF5V0OXRJy9sfjd98iIqfOeK/v1uWmnHdi2JE5IgzveUbo2yoNR
        V/x/m26Q9Du33lWy7GILYsoepphKBmdtC6ndWZDaJ/LlSbrXgRNcsqeX/2GdFsxb3BOmJdO6
        3Wvxasmdd3J9lViKMxINtZiLihMB7bQm/BADAAA=
X-CMS-MailID: 20220110075451epcas2p3a142aa3b5f2db818bc8b265fd43da6a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220107081617epcas2p402a132bdffaf1ec6f5517c311a60c7d3
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
        <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
        <CGME20220107081617epcas2p402a132bdffaf1ec6f5517c311a60c7d3@epcas2p4.samsung.com>
        <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry for late response due to my vacation.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>
> Sent: Friday, January 7, 2022 5:16 PM
> To: Sam Protsenko <semen.protsenko=40linaro.org>
> Cc: Chanho Park <chanho61.park=40samsung.com>; linux-samsung-
> soc=40vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel=40vger.kernel.org>; Sylwester Nawrocki <s.nawrocki=40samsung.com>;
> Tomasz Figa <tomasz.figa=40gmail.com>
> Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
>=20
> On 03/01/2022 21:59, Sam Protsenko wrote:
> > On Thu, 30 Dec 2021 at 21:34, Krzysztof Kozlowski
> > <krzysztof.kozlowski=40canonical.com> wrote:
> >>
> >> Hi Chanho and Sam,
> >>
> >> I am slowly finishing dtschema for Samsung pinctrl drivers =5B1=5D and=
 I
> >> noticed that Exynos850 and Auto v9 do not define interrupt in pinctrl
> >> node with: wakeup-interrupt-controller. This is an interrupt muxing
> >> several external wakeup interrupts, e.g. EINT16 - EINT31.
> >>
> >> For Exynos5433 this looks like:
> >> https://protect2.fireeye.com/v1/url?k=3D5b66d98c-04fde0da-5b6752c3-0cc=
4
> >> 7a31ce52-358bc1856a87fe6d&q=3D1&e=3Dc9523e36-5b45-4a15-9b11-877e07a0eb=
ba&
> >> u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Farch%=
2
> >> Farm64%2Fboot%2Fdts%2Fexynos%2Fexynos5433.dtsi%23L857
> >>
> >> Missing muxed interrupt for Exynos850 and Autov9 might be fine,
> >> although you should see in dmesg error log like:
> >>     =22irq number for muxed EINTs not found=22
> >>
> >> Can you check that your wakeup-interrupt-controller is properly
> >> defined in DTSI? If yes, I will need to include such differences in th=
e
> dtschema.
> >>
> >
> > In case of Exynos850, no muxed interrupts exist for wakeup GPIO
> > domains. Basically, =22pinctrl_alive=22 and =22pinctrl_cmgp=22 domains =
are
> > wake-up capable, and they have dedicated interrupt for each particular
> > GPIO pin. All those interrupts are defined in exynos850-pinctrl.dtsi
> > file, in next nodes:
> >   - pinctrl_alive: gpa0..gpa4 (interrupt numbers 1..36)
> >   - pinctrl_cmgp: gpm0..gpm7 (interrupt numbers 39..46)
> >
> > All mentioned interrupts are wakeup interrupts, and there are no muxed
> > ones. So it seems like it's not possible to specify =22interrupts=22
> > property in pinctrl nodes with wakeup-interrupt-controller. The PM is
> > not enabled in Exynos850 platform yet, so I can't really test if
> > interrupts I mentioned are able to wake up the system.
>=20
> Thanks for confirming, I'll adjust the schema.
>=20
> >
> > After adding this patch (=22arm64: dts: exynos: Add missing gpm6 and
> > gpm7 nodes to Exynos850=22), I can't see this error message anymore:
> >
> >     samsung-pinctrl 11c30000.pinctrl: irq number for muxed EINTs not
> > found
> >
> > That's because exynos_eint_wkup_init() function exits in this check:
> >
> >     if (=21muxed_banks) =7B
> >         of_node_put(wkup_np);
> >         return 0;
> >     =7D
> >
> > But I actually can see another error message, printed in
> > exynos_eint_gpio_init() function (for wake-up capable pinctrl nodes,
> > because those nodes don't have =22interrupts=22 property now -- you
> > removed those in your patch):
> >
> >     samsung-pinctrl 11850000.pinctrl: irq number not available
> >     samsung-pinctrl 11c30000.pinctrl: irq number not available
> >
> > which in turn leads to exynos_eint_gpio_init() function to exit with
> > -EINVAL code in the very beginning, and I'm not sure if it's ok? As I
> > said, those errors only appear after your patch (=22arm64: dts: exynos:
> > drop incorrectly placed wakeup interrupts in Exynos850=22).
>=20
> Yeah, I replied to this next to my patch. I think my patch was not correc=
t
> and you need one - exactly one - interrupt for regular GPIO interrupts.
>=20
> >
> > It raises next questions, which I'm trying to think over right now.
> > Krzysztof, please let me know if you already have answers to those:
> >
> > 1. Regarding =22wakeup-interrupt-controller=22 node (and
> > exynos_eint_wkup_init() function): is it ok to not have =22interrupts=
=22
> > property in there? Would corresponding interrupts specified in child
> > nodes (gpa0..gpa4) function as wake-up interrupts in this case? Or
> > pinctrl driver should be reworked somehow?
>=20
> Yes, it should be fine. The message should be changed from error to info
> or even debug, maybe depending on SoC-type (so define in struct
> samsung_pin_ctrl whether exynos_eint_wkup_init expects muxed wake-ip
> interrupts).
>=20
> >
> > 2. Regarding missing interrupts in pinctrl nodes (and corresponding
> > error in exynos_eint_gpio_init() function): should it be reworked in
> > some way for Exynos850? Error message seems invalid in Exynos850 case,
> > and I'm not even sure if it's ok exynos_eint_gpio_init() fails. Should
> > it be modified to work that error around, in case of Exynos850?
> >
> > All other pinctrl nodes have a muxed interrupt (except pinctrl_aud,
> > but that's probably fine).
>=20
> The error message is valid - correctly points to wrong configuration.
> All pinctrl nodes should have one interrupt, if they have GPIOs capable o=
f
> interrupt as a function (usually 0xf as GPIO CON register). Why
> pinctrl_aud does not have it? Maybe the function EXT_INT (0xf) is not
> available for its pins?

Regarding pinctrl_aud, the interrupt number is not defined in interrupt sou=
rce table because the line is not connected to CPU's GIC. It is directed to=
 the GIC of dedicated audio subsystem which name is ABOX. So, we cannot han=
dle the interrupt of pinctrl_aud even though GPBx_CON registers have EXT_IN=
T(0xf) setting.

Best Regards,
Chanho Park

