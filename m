Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5E5887A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiHCG7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiHCG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:59:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47327FF5;
        Tue,  2 Aug 2022 23:59:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x10so14863264plb.3;
        Tue, 02 Aug 2022 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LJeCWMPNDFa54lhhjjni8CvJbCR1cv8BE7+K+6PQWwE=;
        b=mjUzUsPbeHIKPWm9YDLnJ8OmAZ5zDjlQPUA1SZHAEUj+Mfx/mDnJLipV/ZJOR54NUE
         0z97qt3pqKYGBWQxJKJwGNgXDB7he0S4Swdlv0HbNM+fwtcvx1kwC6Ft7JoL1uJgYjo5
         m7WpN3QDC48uieWJ0MAJAOHIHKFVKZ5F6k6uwvliNUZl6RXzx3SwBQn3rQYB9ucFgyp2
         6orx86mS8IKx+44Adhp7I/xPrGs1HM5VXlB2TQ3fP8pXmNTWurdY2hiCj0K9TnfRgwq4
         3QeAUR9VcI2MglUDwiKTF91QBPR4FGFYOy0iUPkslhfxXca50+HDYgBaJthiqwFogYUS
         g1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LJeCWMPNDFa54lhhjjni8CvJbCR1cv8BE7+K+6PQWwE=;
        b=SYlcQ25EvFXmYQmprc13rWhkOQb1k0mj1QU6Xdc/8srFZYmxQctC9VI+Zl8pGT+ck9
         1p92hzyA/HKaahz81SOMRLzWfaWQHmb4TwHk4jCb9VomXFyCivuaMRP14tvjnCTscsfH
         dFsb2CB7FxuAjtkxLUAMWwlulYw4yZ1ji8ibcV+SOycX3dJPOJrE2/1+0jRngSYQjbOu
         A7H4xl8cAP7Bqtfd4oVjDdrtK/JAsudQ9HwveSiDKcmYBRLI7MVZYgzz3RPLTna6vmP2
         1g+mM9VlKVy6k4Ho1VbR/eygISoIRXC8Oj5QiP/JKFNlXMBSba3azpP6SH6IvXeRT8yw
         YJ4Q==
X-Gm-Message-State: ACgBeo1XT7teXsSJeizYQxC/vCglmrrUYd55Xq1PCZh/EOGe+hJcakSs
        b1aDWub9iSU5Kp9ylA9SUtOPfdYli9JgQh8xcHY=
X-Google-Smtp-Source: AA6agR7x4tyrWj2jq8pw1fQVi438CHYRFx6bDJavn8MPfXnWR/2ySDbcqvnMNXHaMqwdEW2iAG7k493kb+IO2L3URXE=
X-Received: by 2002:a17:902:7293:b0:16f:17c3:e809 with SMTP id
 d19-20020a170902729300b0016f17c3e809mr740919pll.158.1659509958822; Tue, 02
 Aug 2022 23:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com> <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk> <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
In-Reply-To: <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
From:   naga sureshkumar <nagasuresh12@gmail.com>
Date:   Wed, 3 Aug 2022 12:29:07 +0530
Message-ID: <CAH_iE_3xfyPi4B+WopmZdFStQHeTb=31MqLs+aG12R=28yDuVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Aug 3, 2022 at 11:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/08/2022 15:13, Mark Brown wrote:
> > On Tue, Aug 02, 2022 at 10:52:25AM +0200, Krzysztof Kozlowski wrote:
> >> On 01/08/2022 11:42, Naga Sureshkumar Relli wrote:
> >
> >>> -    enum:
> >>> -      - microchip,mpfs-spi
> >>> -      - microchip,mpfs-qspi
> >>> +    oneOf:
> >>> +      - description: Microchip's Polarfire SoC SPI controller.
> >>> +        const: microchip,mpfs-spi
> >>> +      - description: Microchip's Polarfire SoC QSPI controller.
> >
> >> Useless descriptions - they repeat compatible. Just keep it as enum and
> >> skip descriptions. What value do they bring?
> >
> > Someone not familiar with the full Microchip product line might not be
> > aware of the expansion of mpfs, it's not blindingly obvious.
>
> Then it should be explained in title/description of the binding, not in
> compatible. This is the usual way of providing some text description,
> not for each compatible by repeating the compatible text.
Ok. In the next version I will update the bindings like below

-title: Microchip MPFS {Q,}SPI Controller Device Tree Bindings
+title: Microchip FPGA {Q,}SPI Controllers
+
+description:
+  SPI and QSPI controllers on the Microchip PolarFire SoC and they are based
+ on the "soft"  fabric IP cores.
 oneOf:
       - items:
+          - const: microchip,mpfs-qspi
+          - const: microchip,coreqspi-rtl-v2
+      - const: microchip,coreqspi-rtl-v2
       - const: microchip,mpfs-spi

Is that ok?

Thanks,
Naga Sureshkumar Relli.
>
> Best regards,
> Krzysztof
