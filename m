Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57566580E72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGZIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbiGZIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:05:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA40D2DA86
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:04:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy29so24635147ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBehNnJT8GsO8upB51VneNbMYqsRg1ZW62nLqXxRwjs=;
        b=ux3qmfJJzCRpmOIlz05amYZpcKjRQdQpSoXtp0phrhdyP/vH1mgjUHF3Cn6q1rAio9
         sTifpvJhZaL/w1o15nmY3samMbq8yjVXooInCubRXzNUnweXBqGb7HBfR8Gj+zpCCOBp
         oQ7iNJBYQZseKBKeQ5mv5+SZV5gcJDb6ePE8xWQSg9oGJIpFn/LFsmiSHs/FfYPc29x5
         0ZrOfpuhyk+7WLYfptEqkETbazvrhXKGkhwVqtYEVIMrQRMiIeEN4MQ0GgqHsD+BL2ue
         tHXVaL4vP+mJovTLoaaKe2LMP1LY8R2jrMJvrRSVa0fyYpGWxCHVYNgCm4cQAKXxNi/u
         75LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBehNnJT8GsO8upB51VneNbMYqsRg1ZW62nLqXxRwjs=;
        b=1eROoCVddsTkPQJ86VnLtFHo9L/LaU0MNEcYotMvRs7qHeAWfWJlZCb8yt0XVV9MEe
         iTZXhEWtMjCit72Ugq2BYHIo79h5yi0muZ1CPaZciQWtHStlN1QZLWZE4vzHTbazVyZv
         TdMRqpjQcMF9hjTfBWHWkD9J/AP6Ywi1ueiwjtx7xMm0rMAsd3YbR57j6k/xPbWHAeht
         eHIfMIVSoAKXV6UkUdBu+awWSYMMRshLWp+jbdoioipctH2kIsRzwForeBUWDDHka8K1
         Yoov0gixy8vqZ8LDe3TbcMV2qHfE36NqHpH8pL38mWT+bIndJfFMzx2OkHNYqzy2Rhhw
         rOXg==
X-Gm-Message-State: AJIora95aF7N2b9IKabd4DPln4fCd6euiGg3e68LeZ+1DWvPQjc1g82q
        5s2Elg6IVgXU0L5XmjxfmJt1x7Mw2x8k8+Mp3cCchg==
X-Google-Smtp-Source: AGRyM1vHhcGel5juigG9IuL9lnmZZvwbKcwgfiDrUj2uiwtNoJw8NVE9bwIMb2MaITVezVvKoTnq3AyC7k1VJmVf5x0=
X-Received: by 2002:a17:906:5a61:b0:72b:1468:7fac with SMTP id
 my33-20020a1709065a6100b0072b14687facmr13030328ejc.440.1658822698053; Tue, 26
 Jul 2022 01:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com> <20220723160513.271692-4-Mr.Bossman075@gmail.com>
In-Reply-To: <20220723160513.271692-4-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 10:04:46 +0200
Message-ID: <CACRpkdZMFdYDssk9B7R-MH7xG8Ukp+ZQpXCRVtPRCS=SFh34mA@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
To:     Jesse Taube <mr.bossman075@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 6:05 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> Both the i.MXRT1170 and 1050 have the same gpio controller as
> "fsl,imx35-gpio". Add i.MXRT to the compatible list.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Bartosz needs to apply this to the GPIO tree, I think it can just be applied
directly without regard for the rest of the patches.

Yours,
Linus Waleij
