Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA75AD5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiIEPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiIEPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:02:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E585018E;
        Mon,  5 Sep 2022 08:02:52 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M4JeB-1oVUbb44Cf-000POP; Mon, 05 Sep 2022 17:02:51 +0200
Received: by mail-ej1-f52.google.com with SMTP id fc24so8639693ejc.3;
        Mon, 05 Sep 2022 08:02:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo1VlPcvJ+xWWEd7pO4eWHUq8HyXbIrcAVMATqZQt7wL5u0XIUj+
        cVs4W3ha/TUScq4is/DkI7iNRXeWwN0i/iluyjQ=
X-Google-Smtp-Source: AA6agR5wJ1aL84FxA8QRwytzUhGkLyN55SpvraWEbihzBC5xXhOPokDXApu6UWIH1+rv+572pCGRZ7UtcPnLm4vD2w0=
X-Received: by 2002:a17:907:7242:b0:741:770b:dfc6 with SMTP id
 ds2-20020a170907724200b00741770bdfc6mr27267865ejc.203.1662390170467; Mon, 05
 Sep 2022 08:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220826130402.2207808-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20220826130402.2207808-1-arnaud.pouliquen@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Sep 2022 17:02:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a32sEFFAm=-6RJEkBiwUOTBozHXKAoJqJ3iiR0_QGZUzg@mail.gmail.com>
Message-ID: <CAK8P3a32sEFFAm=-6RJEkBiwUOTBozHXKAoJqJ3iiR0_QGZUzg@mail.gmail.com>
Subject: Re: [PATCH v3] arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YR6o/FEFRV8zaAlkjXnqoG0EtH7RHlUoIN5MV5esjETmMnplrWF
 2G8x9bBuLORDoiVsjt12OdFmUHc4HUhawaqsKk7SZi+xJ/iagRQ9AVSdNuJdhgbicHeGhVn
 5vp1LAUyoAaME6eRbXjtN/5GHxKEoURpAhRJzWmrckzKVUzP30xq/mwND6WyAlh1xyJQYDL
 k7baTjliAkzg/xDrkBgfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JIKZgL4ybGM=:HDts/lexEzX4GJym1/0BXf
 FxH1WknTQ1AHXHhuMO5AC4X/1vXGO9/ZFMi4+NHBYBVFXibcZuV5a4Tj9Bv1udftyhLpXxZa6
 MG07xE4aLhjmSbCmSxqGYzOXa1sSZoxTykIQDPr1W5rqnLDL9LUwC4Zc6c2o83NCCcz4wN34Q
 mH6U/TwJZSfVjcAXeLeDvAUP1XsEDu/RXiFeOYFix4AHayvXmqRxuiVJlBjGxNFbiR1QHxybJ
 6csJWyi6H641I5+E7iPdhKcczP2EkOGNzcanL9MYFag+ouP4daK7X3V7nxfSPQykMhHXhP86A
 JzrLn6LmWRPz7XGGu24t32QqvMUVeYgHUNAGB4IpOlD/CreLZLPpq+SgKeadTWFiQrQhci2lp
 G+7CkbYVl1WC5zpvEvDnb+s0ZI8eNSSe2ig6tCekv5yY+wb11inS0EXKA/dTcxdS/c+j11Je3
 X0zaUHe4zH23Chjmm6PaT0D+eKXztP3iFB+v4QmVL8MUAZKqj1XB8FgYCqlXYzaYfR3zETZ/y
 9S79N6dY8Frwg5kmtQAePETGZZac0v7FZFvwIJKFn9S8tvY8ZtFgtXI4MBbApJ5IcqPqwH+7j
 t4oJykf6hSPXxCGSvKBpuByKluqQvWI4prERygdy1YLXecz4IrluAM9wfcEyuf+T6vGfx9F2b
 JZP++XBlT97ZxsfRHSNH+1EazgctKEYpuC3df7KMzlRmVBWXU9WLTop0dn34HsXlAcR5mJosI
 Ja4S7DmRMq+bY0acDVG70HoU8Qf9Rrp1WrMCXIbUP3rVhGSUhvFjLir5EEGFvRgEkfEidoYui
 UsHaud3Eem+NtXyqkPEmGrtd3QDQUv/A1dIKUbSgO5NIvrAN/yuFONdxN9fNRwMWLAp+H8aso
 45NV5lGMuK/8iOhz06qfNorQri84SLfoSd4a25QGOaXEHpK8eeD1Li8J/4PFvV
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 3:04 PM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
>
> Update vs previous version[2]:
>  - resent after rebase on Linux kernel v6.0-rc2.
>
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/b301b3f5-f0be-47b7-4789-f9914497b819@foss.st.com/T/

Applied to arm/defconfig, thanks!

      Arnd
