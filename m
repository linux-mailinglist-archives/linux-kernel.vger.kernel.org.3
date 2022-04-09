Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF84FA767
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiDIL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDIL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:59:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF01CB0E;
        Sat,  9 Apr 2022 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649505409;
        bh=v2/xJ7yto9BmCfd00GAKmMJNCuq5Souzk3hwnLPMWcc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LSTwAdCroFkqACPFFmDVbWXFphpW6RBq59c1ddGthV5a/ryIhbxB4UvHzJm0ixyeR
         U9ssmsJVX0yX6vOnYjezwFRwd75+qIDzTP9za5D4dNr1uNCf26A4cdn515FxaEo0Lc
         gJgxTWdWZUyBRgV4jFn7SssmIslCxPNi//G8IXsM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 13:56:49 +0200
MIME-Version: 1.0
Message-ID: <trinity-da7d86cc-5703-4657-858c-f241e5f0a6fd-1649505409042@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re:  Re: Re: [PATCH] arm64: dts: rockchip: Fix clocks for
 rk356x usb
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 13:56:49 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <4232341.5fSG56mABF@phil>
References: <20220409075147.136187-1-linux@fw-web.de>
 <CAMdYzYqx1iUuEe9FPpUTgL0L2i=Q5Sq2+0oiSYzqkV6noQ8BFw@mail.gmail.com>
 <CAMdYzYqaGe9_GbRCvG3kvLpNsVfVqGNkg=YYgbVR90Qtcs9YSA@mail.gmail.com>
 <4232341.5fSG56mABF@phil>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:IpO6iEatWIxd338hHRF5AGz8rNo4DAr/13bwlpwbcBkjfcy7yL02zG1I+1zX3LCi0/8hi
 7sG089SdN79CJ/5wSouKpXJDvRGXCITX9wP7etALmwlmAgqOlRx21lzg/RKhxs6Mf0Eke9hJIlld
 pYnlXHihiP84w6FXkQNhA8VgaikP+U3oQw4mdiJqasbJ/bB9q8R1UEkBLHWRbMP9GRb/FpzERBc7
 a3G947ISBK5Wk9PpklhxJTQS3Pr567bwyBn7HiLPkDuCwuLilXxgQWZDd263cthJ1YIKeB8jkeUX
 7M=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ceG3UwnHoAs=:pHlwaSspH0+O9pfaynPKeo
 yNyGFkpxcEYItEbLIMbUVEltaghh2bMXdz4mHqGZcwBwDXVL6BgXJaVgCGHXVo/SFZlmyRk7S
 ND55sSTK60b50Gwm237kOYG/z3PWbhNXAyKs1fB9keZEi34sRrppkUJxIqyC7zY1tMF297eH4
 OiXPYfLYywBJhNSGSfOUPeX0rHcprgeW7NzsDMqZP8hFWQ8xagObZc8TpN0vRVHLpfbOQBGO6
 Faf0CbFxDSNZV9Uy4p14m6fcK+PTDsZ/udzeZDcNbMgVpLA492ak28LKEYY7xDvVwgdv3MxYV
 xDxY3pOKmJjgoHZb1zGuQRhR2olXEv5y4bsdQGdbNXAwpIafdC9b9h72El4llkfhrpvUqF9Sf
 ey6sKnXhH36lH7zOgKZ3KLk+wILkPT9q0shOxbH7U6J4or0vWsQdZLHbbfto/eLoUQKgriU3t
 yXvFpO5IzKiVXQeJS5d0+GA8HkCkoIW3Zzlbybslrk5P8mRdtCNhzKuqYvi4yRfWoz0VZ+xlF
 hmFDWuMnDoxqeaMK8XGqVvWqJ8Zptwo3PDf2Bt7tqG4MJhMwdhq+IxhTWZbWGkl4BcSmMCZWw
 LMKJFeUTPFiaD1r2Ijh+FYHm/iwJSRHTJ3o/j5BKaFhzIykRklsbJrY1Bsmg0WDJwBuV0sj6c
 gZjfua55wlVNCFjAIDIK2x8t2gabCiHqZTZqpJeGqOo8kAxGtKH8KFixaoi9YChvkwNpfDKm6
 tbp1ryMg+IP1baF+sRp8Nwqfz62GDpRE/RmTNGaBbT2UXPjeme+UpNOzEBe4zJDvUxyj+IALN
 JenhYhU
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

so to not break the binding and other boards the right Patch should be lik=
e this

+++ b/drivers/usb/dwc3/core.c
@@ -1691,17 +1691,17 @@ static int dwc3_probe(struct platform_device *pdev=
)
                 * Clocks are optional, but new DT platforms should suppor=
t all
                 * clocks as required by the DT-binding.
                 */
-               dwc->bus_clk =3D devm_clk_get_optional(dev, "bus_early");
+               dwc->bus_clk =3D devm_clk_get_optional(dev, "bus_clk");
                if (IS_ERR(dwc->bus_clk))
                        return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
                                             "could not get bus clock\n");

-               dwc->ref_clk =3D devm_clk_get_optional(dev, "ref");
+               dwc->ref_clk =3D devm_clk_get_optional(dev, "ref_clk");
                if (IS_ERR(dwc->ref_clk))
                        return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
                                             "could not get ref clock\n");

-               dwc->susp_clk =3D devm_clk_get_optional(dev, "suspend");
+               dwc->susp_clk =3D devm_clk_get_optional(dev, "suspend_clk"=
);
                if (IS_ERR(dwc->susp_clk))
                        return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
                                             "could not get suspend clock\=
n");

but this needs fixing dts using the new clock names

this is a link to the series moving from bulk_clk to named clocks:

https://patchwork.kernel.org/project/linux-usb/patch/20220127200636.145617=
5-3-sean.anderson@seco.com/

regards Frank
