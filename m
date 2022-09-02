Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228175AA96B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiIBIHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiIBIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:06:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C23B729D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:06:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h5so2296644ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/CPr7XRW/l7oJ5TwQnKLmZtSswvlFBKkXS84mHDGoF0=;
        b=ov9NKalAZFyh2hTY2dbXszqArzlqn9GnZwUCyustVqEGsjRHlE2B+lEHUci2QWsq5O
         VvRpapuuUtNowNTe1SZ4hx+1GXq2MsAAyusyFMW9cEccUaf19D+PYWzInE+depRigNqo
         RyD/qbrxA4hF7KA0juayqdEYvFYUG6nTLg320DRnMC6jzYnBpi517gmkeDtm6g5RAhOd
         eGTFZ3np6jsUxmDuGP0G7W15ecBq5ntTGoO7p4zWgAdrckvsw4OtNVud1rPCvJe6GJVt
         WV0u3j98H9paeuHfEXZNjdT5hgUrIaWaGHpWeuOgdW3/V1mvGNCzHyTbhcIOrI2OajEu
         Lkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/CPr7XRW/l7oJ5TwQnKLmZtSswvlFBKkXS84mHDGoF0=;
        b=8GmE9kQcW3Ubk8HXH0Hvt9UztfEpsHASjIUqz6Fkrjrb4pmaMbznjCGDEnFdwXBY2D
         yFTZ+YQq6IG2jEQwJK4RP/yE4855vvYegMopchT/bdZajLShRbCD2Iz/PuZsQT+mkWQj
         cYccl5vf4Z0caIZm+vSElAVIGQHqp/JPY1wZTPftCEaD7c+Nbio2cOyZbRlYvLpbT8+J
         rakK6l56ELcPjb/9JEghvho+K0Pc/cSkW3cMgd8l/dhuKgPE2EqkcUzg5nBcSuHQq6gk
         Da9AkjNwyq7S7tJoZeDwDKd83LaL+5xsrZA4mb0W26dOnS432Uh9lBq+uUnqf7A48wcn
         i69w==
X-Gm-Message-State: ACgBeo0UU/TtOxLWo6zPz1xi7yqsJxTAPkYmdFvR7YfKNxMqmhLQhfwH
        4TfY62PovSwK6ySFg/WI+y5HPc5ksdJld8Il4kJT7g==
X-Google-Smtp-Source: AA6agR4LDNciPZtaUjUX6+2rGeSXUZhhZ0jz4kn1NPhxmpYPCdK4njNDmYFI/PgmcfJA4C22nLg5rswmxoKXLO8pMgM=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr26775363ejc.440.1662106010529; Fri, 02
 Sep 2022 01:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Sep 2022 10:06:39 +0200
Message-ID: <CACRpkdb25ikL4F499NDCrv1kf2FGvJxqDW2wk9GNQCqrbX9kKQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add support for i.MXRT1170-evk
To:     Jesse Taube <mr.bossman075@gmail.com>
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
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 8:33 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> This patch contains:
> - Update to imxrt_defconfig
> - Devicetree
> - Clock driver
> - Pinctrl driver

No it does not, I already merged that.

I think you should probably split up your series per-subsystem so the
clock bindings and changes can be merged separately etc.

Then the DTS files can be added to the ARM SoC tree as a final step.

When you send everything in one bundle like this subsystem maintainers
don't know if they can merge e.g. just the clock patches separately
and be done with their part (like what I did with pinctrl).

Yours.
Linus Walleij
