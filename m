Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A6759140D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiHLQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiHLQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653B7AFAE5;
        Fri, 12 Aug 2022 09:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A066B824B2;
        Fri, 12 Aug 2022 16:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4672C433D6;
        Fri, 12 Aug 2022 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660322313;
        bh=q+LQGQUDWTwgah/gHIGUKH/VSzB98ablADDbuzvDZew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DaWfyfIjuUHxEV2ogd6+ttE+sjHKaNy/CpzeQu2kKXiByXZtLyfbgWldxhXJ/2U2S
         Mm15hB/ij+11BP33sLB4uDevAUdrG4Dn1jnS53teKqKL+u/XTtN5UjW5FWxSATqaEU
         EMfUSgxB0/w69QQjg/nwWEEtJ1yCV5LrYDHbjh8nMmNj1umFDxurSuQGuirllt2dXR
         Zh152+ky7Ieb7P3Ui2VVzYq8BEibo5AuA+gvDWjUzbA8G9TeWK88DizEIAOcnSH2yg
         7bfPwpygUbUOySn1VQBaF59L/MevHwggsjMij13vynpIY6iK2CDU65KLchE1Yrc35k
         lKu8StzsQmrmw==
Received: by mail-vk1-f171.google.com with SMTP id s194so740757vka.2;
        Fri, 12 Aug 2022 09:38:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3VTPB4CDo9KI2N2yEul35WUmskTMX0oJsUEEx48MUniRNXWBnX
        u1Gg5pq+p/85gFx6QszoLxtahzuCYrVb464Zow==
X-Google-Smtp-Source: AA6agR5bOtmCd8QV+awVagZr3ZgQKPegm1dDNeB255ytg7BB2YmuwcapMNgNnSGw+9tCavOS9vEWjSKZJ0ko4+hwT+4=
X-Received: by 2002:a05:6122:4f9:b0:377:f03a:23df with SMTP id
 s25-20020a05612204f900b00377f03a23dfmr2294192vkf.19.1660322312625; Fri, 12
 Aug 2022 09:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811203151.179258-1-mail@conchuod.ie> <CAL_JsqLOGLZD6vrNPqDUqYypkz8xoCPJ4DA4JF-BrG=WHWPurw@mail.gmail.com>
 <46c51365-b4a5-9666-bc3a-24ff833d8fb2@microchip.com>
In-Reply-To: <46c51365-b4a5-9666-bc3a-24ff833d8fb2@microchip.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Aug 2022 10:38:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZ2N7rTb0Fm0Y8CjN8XrTkBsu2uU_TFfhU0iwjSz5row@mail.gmail.com>
Message-ID: <CAL_JsqKZ2N7rTb0Fm0Y8CjN8XrTkBsu2uU_TFfhU0iwjSz5row@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: add card-detect-delay property
To:     Conor.Dooley@microchip.com
Cc:     mail@conchuod.ie, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        piotrs@cadence.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 9:46 AM <Conor.Dooley@microchip.com> wrote:
>
> On 12/08/2022 16:33, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Thu, Aug 11, 2022 at 2:32 PM Conor Dooley <mail@conchuod.ie> wrote:
> >>
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> Upgrading dt-schema to v2022.08 brings with it better handling of
> >> unevaluatedProperties, exposing a previously undetected missing
> >> property in the cadence sdhci dt-binding:
> >> arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: mmc@20008000: Unevaluated properties are not allowed ('card-detect-delay' was unexpected)
> >>         From schema: Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> >>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >> Should this have a fixes tag? If anything, it'd be
> >> Fixes: 84723eec251d ("dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller")
> >> but idk.
> >
> > No, the common property 'cd-debounce-delay-ms' should be used instead.
>
> So it's a case of "what's in the dts is wrong so it needs to change"?

Yes.

> For the future, where is the line drawn between "don't break the dts"
> & "don't use bad properties"?

Depends...

> Only if the property has consumers?
> I don't mind, just want to get it right next time ;)

In this case, there shouldn't be any compatibility issues because the
mmc core has supported the common property longer than the dts
existed. If that was not the case, then we'd probably be stuck with
the property in the dts file. That still depends on usage in the
kernel or elsewhere, in dts files, stability of the platform support,
etc.

Rob
