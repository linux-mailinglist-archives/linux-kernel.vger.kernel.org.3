Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516FA4AAC2A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380033AbiBETCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 14:02:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:40037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381921AbiBES74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644087575;
        bh=Aw2WMDEbEhlH/mZNLfkFzJ3FjsJZHx67MeYHGf5Ed1c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E0SpvTtVR4zB+1sVAyIeA5Yex7HrM8hnFx8yFn76GNvJQ3xPdTEtV2PiicJSTPssn
         CTs6y7cPyf9lyRjSz6pmToOCU7cQgebUk3lLq3spvAKBRyWrfOsQK8kfb7YDDWD9nF
         eQBMy12TPbgTLLb5QeMLjwl7rkugiF0vqSNVWmG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.75.80] ([80.245.75.80]) by web-mail.gmx.net
 (3c-app-gmx-bs06.server.lan [172.19.170.55]) (via HTTP); Sat, 5 Feb 2022
 19:59:35 +0100
MIME-Version: 1.0
Message-ID: <trinity-7a0de29e-ada7-43b1-ae8f-50da4736f2b1-1644087575012@3c-app-gmx-bs06>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v2 1/2] dt-bindings: rockchip: Add BananaPi R2 Pro Board
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 5 Feb 2022 19:59:35 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20220123135116.136846-2-linux@fw-web.de>
References: <20220123135116.136846-1-linux@fw-web.de>
 <20220123135116.136846-2-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:wtFtw4+ksp83Q2y92etl/kbPoD8QWRWOUoK1ywDfvhrdYz68Xyd1uZItuW7+kN2NdNUoZ
 aPdebyWl5vMRsIAgFgy2jS4UjyDJt2ehF1gPcG0EyypqLdZUo9lpFfuHqqK8yWGUt0TftMCzK9mE
 VugotwAhJxGnC+WVlRMwio86X5WDPXg0auY1pKBAsUdfCK9EJ3H6ZbPM7u/oqbyjOsxJqulSL2bp
 ksL3Q432k+Xa+z1EeJdydiVlK5Y+0eGYvqekkNLVKfjsbyrXzxQdah5C3LsfbXrU8sBpuUEtcvnI
 Tw=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZfuXrw71q/4=:ChBe3CXdNiA+BE9kiEo7w9
 6N/3blfcGwR9VfGH6FRU6JZ4bkHlQp8ry/OLIGjGqizYBCx1KwIXkWdiOfGyVcCzIEuj4eRwT
 8hlmsJIdNsnV0SCD9Et9KMWgUQUHlcaxcHzExdftklMxsnCdyhXiS7d+S9+cLsLcGEYoX+8cx
 Bl91e/9oY/yZuZdDVpVuTc0bOOxiWuEtxoWCxRrlLo9BiUVQiL3dgrHwi/kXXuZTV/14LL1PU
 K+uA932PyYEvqHxRmAuNRpGsvh5pTmHSjHnhM1sauyqvI75UcXxI50Ar8FDb0mg35vbG69M5J
 u6/Mr/zq0ibXqCse/6mHpOZPmNE1yOo+DXkWPtyHkHjLq1zggYNc1qW0ZhvGTtN+YgiCPOraJ
 S/N1WBC2j928AP+lz4XeffXTOBqNpwrHRr2IJUXoF5offlKluhkdi4Mu5SIFYJxqCMNpvUR9c
 42eEDDJ96jhAZecSKv6oM358msy7m1hxS1NTolGXr0v6WA9uh5RgIY6eHwX9G4mfCpH5MQmDn
 y8DL34GJvXVnB8WmXSqsvjxPGuQ0/A6/iARRDOSEwmfrveywYIViAPcOJqNR0mNnhyE7vITA5
 PjNF6PSOQLyLe8IUt4PzWBCNaRg1S/jLrN1uC7eLnwUNOkc2jE0zOD4SmfgNPZOWnUnYmnULo
 iDb7a3DbcUfRE5rZ2/1TIdWAEZOLIY6w2YBoz2XLD1aO0R07Pzq9VE8tuxF8Fr+qD/UkYgSGI
 ryq/tMgBIpso2/vYpbXDmxsAZPGJ9HhlZKhwKANMQ+aELB35qH9lmMyVldNSV5ZLttbf2uZnL
 Pc7gl2l
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

just want to send a friendly ping ;)

regards Frank


> Gesendet: Sonntag, 23. Januar 2022 um 14:51 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: linux-rockchip@lists.infradead.org
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Rob Herring" <robh+dt=
@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Peter Geis" <pgwipeout@=
gmail.com>, "Johan Jonker" <jbx6244@gmail.com>, devicetree@vger.kernel.org=
, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> Betreff: [PATCH v2 1/2] dt-bindings: rockchip: Add BananaPi R2 Pro Board
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add Devicetree Binding for Bananapi R2 Pro Board based on rk3568 SoC
>
> Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docum=
entation/devicetree/bindings/arm/rockchip.yaml
> index 4aed16176434..33d6423fe6c3 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -651,6 +651,11 @@ properties:
>            - const: rockchip,rk3568-evb1-v10
>            - const: rockchip,rk3568
>
> +      - description: Rockchip RK3568 Banana Pi R2 Pro
> +        items:
> +          - const: rockchip,rk3568-bpi-r2pro
> +          - const: rockchip,rk3568
> +
>  additionalProperties: true
>
>  ...
> --
> 2.25.1
>
>
