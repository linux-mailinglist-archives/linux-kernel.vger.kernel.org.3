Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86564FA5A0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbiDIHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:40:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477E6571;
        Sat,  9 Apr 2022 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649489861;
        bh=MLqA3bnD2sMvw0EFvGKTdpBOi8GVnKh839oLfjb5qm0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ibVpGGokpc0x3q4ZPpBOxHvxJAVVYRPiQ/jdV53cZSk0Cy941XiYhmJUPLXDHgG7L
         7khuseEwRalTI8HEJDs0B/42CYLYGj2P/NcKTxAddqvURI41rB+Pz5G9bHKsigkz54
         sUIUAbw420cdyjGDLZlfEiWlWzcBwhT+KLQHvIug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.154.105] ([217.61.154.105]) by web-mail.gmx.net
 (3c-app-gmx-bap35.server.lan [172.19.172.105]) (via HTTP); Sat, 9 Apr 2022
 09:37:41 +0200
MIME-Version: 1.0
Message-ID: <trinity-75c90ab6-a336-4f5d-972a-364b7f32c597-1649489861756@3c-app-gmx-bap35>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Aw: Re: [PATCH v5 3/5] arm64: dts: rockchip: add rk356x dwc3 usb3
 nodes
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Apr 2022 09:37:41 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-7dbd5148-923f-479b-9eed-a75f000456e5-1649489032880@3c-app-gmx-bap35>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
 <20220408151237.3165046-4-pgwipeout@gmail.com>
 <trinity-3ae2b0d1-a3f0-4c64-acb6-2fb4fa0b36b3-1649434480623@3c-app-gmx-bap48>
 <CAMdYzYrK2KV1svrHS=zMjGYh=dUis-JKjgYHaeOB4LQWXM1+4A@mail.gmail.com>
 <trinity-7dbd5148-923f-479b-9eed-a75f000456e5-1649489032880@3c-app-gmx-bap35>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:z/nqLKYmkEa/D6QLwIweufO8+//GvIEoMyUmvk4PEUw4hOhRdR58XNl9ZcaZoRF10YTfE
 GI8gT7DcJBKmHQhZK18pXGPg7nYkrBG2iy0zr4MmTkUXqg6XIetoIjL3dNDCFfDYewS44ubGyM1O
 0rOzzu+WgpOolwXgDPPoRIPbeCw4ae1sTje2esvhDHvRX9KSPj8NjWjpjMOODIjH3S/CgkuKTQFT
 4BAJ+nof0JCfAhGGMv6mqrG2ETvzo8AuL3VMee00mKew3IcQ7n431PYfD4xNZueqCrdaK7iJbsw+
 js=
X-UI-Out-Filterresults: notjunk:1;V03:K0:oxuTRLnR7JY=:MgqnI2P9sCNVrc0XfAWXhc
 /7KXjxsC7Q4Fce74LPvGO7xR5D8AUrH3FW5MB+hHusc+TPPccytR+xoU/kVf3zODmA+5hyo3b
 h6ZA99/4oxEi/FEX0Vr3rbJ86jv7Oi2LpXdDXPOlnhuAYXELGl033AvzT+lNqc0W5G+FDM/ZV
 sz0NMOR3qXbZ1JVchRJlJKCpoSgV2CP654PsAtIYBviP4ECpgD38xsHWfSOfWW9hz9/lpOx4T
 VSyCaWE5L6053i3Na5qCGaT2NKNQigMMz8A7Cupk8qK0iIlDGfTkO0esb0ayBA9CYh1dT+FG8
 oN7/4n13a9wPAZCUNTCp+nf7BLxA3BOx3/o+1sJrS4OV7jIr4LLqywKri6yrA/aPEXM7fXSP9
 tRkYlXtj2rz7G+18p9rAMWBRGWRNybnNY1ICF1XB5y3h0Q34sJIzkedN7lmBKIVY6YgB9bqLW
 ivtCmSkYNidgXzPb1nYti4+/Q57yIyfvf/YKE2EQkqwciv5OoTKuqac0GJnp0d/vjRaqxEJIa
 f+vXQ19m2NfV0RARRBUVUexMrAYGU5k3RDCK/VWcMRi5zmSsl8nnB+JPf5W3xY7HOUctN1UPS
 Zf1n0xwZ+joZ90N7Q6ciWqmBxkr2RgsTb/ahBWQHoWq1wggKbcd0CcnRHgtJ/kU/FlnerVjih
 Z+EGvUegoPT3U6VCXqUJCziinQzrY1PIBVz6ufcIQv7ixcG06MjXidQC6Hakn9AJw44XiMZ0g
 v44B21Ll2RP6JWpywpbgh8uMHoE6DM+xKU8rsOtdMrfTIjDaSGPfamVbaQKQEB8g8mPlT2dfS
 4MMAjhj
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it,
these Patches require different clock names

ref_clk =3D> ref
bus_clk =3D> bus_early

after renaming usb works on my board

will send an follow-up patch for this series

regards Frank


> Gesendet: Samstag, 09. April 2022 um 09:23 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
>
> at least i nailed it down to these 2 commits in drivers/usb/dwc3/core.c,=
 without them it works
>
> 5114c3ee2487 2022-01-27 usb: dwc3: Calculate REFCLKPER based on referenc=
e clock
> 33fb697ec7e5 2022-01-27 usb: dwc3: Get clocks individually

