Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ABF518282
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiECKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiECKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:49:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243625E8A;
        Tue,  3 May 2022 03:46:06 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuF4v-1o6fdx2cY9-00uVlI; Tue, 03 May 2022 12:46:04 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7b815ac06so175216487b3.3;
        Tue, 03 May 2022 03:46:04 -0700 (PDT)
X-Gm-Message-State: AOAM530SHApsi5p4D3Wx1ZoWrXfqN/TgkqydF9WILkkbIYLyoO2DiLeu
        7tv5+SxIHt/QPkY5s48HwaLwDCsG+/350+/aG2c=
X-Google-Smtp-Source: ABdhPJylICN3Lkv4MnajtKZ/mtz5v98V10dI0vpMrO0w3cw4ngaYj64jqdkCQYAkS/F2fDxRL5svru9bENy/YJPD9Ww=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr14878150ywf.347.1651574763350; Tue, 03
 May 2022 03:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220502204050.88316-1-nick.hawkins@hpe.com> <20220502204050.88316-7-nick.hawkins@hpe.com>
In-Reply-To: <20220502204050.88316-7-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 12:45:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2rzmVrpnf2r73iXB=T06OMOsgwyq1i8z7swuOW-q88eQ@mail.gmail.com>
Message-ID: <CAK8P3a2rzmVrpnf2r73iXB=T06OMOsgwyq1i8z7swuOW-q88eQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>, nick@hpe.com,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wXneJVDhHANw/r8NfxFZJbswJ5oULr5QQoJSkOab5zb02IKUsK3
 hU48wlq9luJx9Qoaz/y6lqRqo5n7oJNPBxLfvqaj8nctFIQCVlU5tKgYq+02fahppNXbB0V
 Vzj9eLNbGpAh7x+eGFiamO7uSy7tAvhbGGakj89UvhYf0/J7GwIXwYt1dyUmuerSLd9EFMY
 H0Wcb1padTZHYgf0IaKNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7hyjKbR4LJ4=:yf7szBniFb+nnTPpUNum3x
 /XO7jhSGCpyiLmiCadG31blS20eHeYAMn9tTRqC7f4TYpSzPbtuDNaQDWsv7vulp6usimvrsx
 3/n1QFpAEAxZhjLtAJADndzm8sh3Fep68O9JuocpLwUH5Gha6tjnMtO43MwRQ6DzFBc7bzit9
 e/Gmp5CKq2mSC7K1tNdsBdhnlFW8lbnuRbpyNq5LW0k7lP4AK7sgQBonBr1dMD0aCN8A1Dyhh
 gJ6Bn+Ygv+0F82GgVo6ueAm6FVA3vibtefDhwHMJ0Vk14e5rBJrATbGx/F9DrnrOTKLmog4k8
 0x4jQg7NE5aZb+GTYkgTUTTpNfZTMGzOuA9er1/t2S9hFbqqwHfb4h974TR1QLLhQFGh4glrz
 cKQLLAACQnE7wTFvixDR+Dza0rNSNA2ohxi27f9VQvqwkgNTvcrCB/UFzCW+pxVl0BagwViNF
 xdarzmVSKhOxKhNkXRt5Nx9DfEIy4jALh7yy6/3trRIlOfCLMxy+3kxs8Ma28gTLD/OwtcXX/
 26Fh0wpYqf2C5q1USwjheQwcXM6DzmBbZNBvkQ+KX48Z0yyLRmGnuhrbosyRpbBVYcQYJLdJF
 ZFbRiqQ6QCJHK3IThp9su3qWoEqPvSZjh3dVb1or9qWVRgwmr1GHGnYy+oLvpklWtduLOcLK/
 SFDJoukHhU1x9hjN71WbME6yd1AA7dlyyOxnsOzEIcNrJwta3UX5l9T05vbL05byv4bjrjq3j
 qYvpm509Jw64fu9QPLx21yaXVvAdlvkzZDHkAVKMG9G/nOG3dFFDdQjqFjVNf8068ETD3m24h
 fTDWaDGuqUlYGboIlcFPOiJol1gdX4b/7BYWg9dgo+02cYdGA4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:40 PM <nick.hawkins@hpe.com> wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE DL360Gen10
> + */
> +
> +/include/ "hpe-gxp.dtsi"
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       compatible = "hpe,gxp-dl360gen10","hpe,gxp";
> +       model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
> +};

In the board specific file, you normally have "aliases", "chosen" and "memory"
nodes that define e.g. which uart is used for the console.

> diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
> new file mode 100644
> index 000000000000..7a99e174e4b3
> --- /dev/null
> +++ b/arch/arm/boot/dts/hpe-gxp.dtsi
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE GXP
> + */
> +
> +/dts-v1/;
> +/ {
> +       model = "Hewlett Packard Enterprise GXP BMC";
> +       compatible = "hpe,gxp", "hpe,gxp-dl360gen10";

I think "hpe,gxp-dl360gen10" is misplaced here, if that is the identifier
of a particular machine rather than the SoC.

> +       memory@40000000 {
> +               device_type = "memory";
> +               reg = <0x40000000 0x20000000>;
> +       };

If the memory is outside of the SoC, it should not be here.

> +       axi {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               dma-ranges;
> +
> +               L2: cache-controller@b0040000 {
> +                       compatible = "arm,pl310-cache";
> +                       reg = <0xb0040000 0xFFC>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +               };

The length of the register area looks wrong, this is usually the full
4KB area, rather than leaving out the last four bytes.

        Arnd
