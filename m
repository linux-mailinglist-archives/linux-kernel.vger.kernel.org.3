Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793E581A59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiGZTdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiGZTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:33:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9012778;
        Tue, 26 Jul 2022 12:33:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so16587911lfd.9;
        Tue, 26 Jul 2022 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fR1dczgLxpZ02G+EclfekDkoYiKhvbST8mgypurlcnY=;
        b=m3lc4+qIWX3T6M2+KKp6mZF2S4BCl6PzktWcterEKkqck7dVWQjN49xWIcn8DPTaPM
         GdbaC1JjvyEiZre6lcBKIOl7BpqUJnYAkluWn/m8I9y6i6+G6pro26Oy5KlLIeUPFcth
         e5Jth3X/Cpk5T3XXCjeDcMnN88PxQAHDW4UUhjB+E/J3R/kIHFjEc9/1Iy47/rM5NzLT
         l9Efe5mvMPXfL0cQ9x1ZhWzUqUh1s04FT5iAYcNXxLBemPMamjx2nJ6zKR1flgmdG0FT
         huG71wIpondJOGxz3jq7PdGAVn0dr1EwxoYx8oCq9d1jRC+8LQzCXeFcZJM9zRUMBTmU
         LScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fR1dczgLxpZ02G+EclfekDkoYiKhvbST8mgypurlcnY=;
        b=uFxUB7CfhWUWdASCIzPKYzgOCKiKuta9FaEK3xDZKNbpLRW8L1BQ/vyBcATKfqSpSC
         abR0GLtWKJ5p9WwE0fbsDCzC7Mo03TqogPRWLopG6/p0Q19WFZwy6U3jfh9H7u0I+AB6
         7uITVPc0r0AOjYTkRbAqY05K+ni7dSW19Nc2FvTmAW/QDemzsiy2u2lrDUnjTm9yYQRs
         vf4MIRNxAXPMzT8CcnCADB3pM0iFehPdBaPkL2jJDvacDmZspkZWY3HLjf6qLkdEMBR5
         qLuZQV2uXrQ0ax6AuYktZtVUmkvBlwNHkdMbKNtQew2hhAk471DfQtuSiWrJZsawd9E+
         /VSw==
X-Gm-Message-State: AJIora/CVmukk+9LAjJkwImpnPY+L4nQRzSOHoqLzB6PurfJr5ly2ZEA
        4SN1MZ98NajC4m7WNWIYRnOHLA/ZTr1PWHuvtkY=
X-Google-Smtp-Source: AGRyM1sO/5Vm+fBeb2gt2lsBqm4kaXr1AAok8SnmnIdPf3F0WsG3UoMQ+b6lvQ1SzSmAUALwPzOPXIAh4swyRdGzqy4=
X-Received: by 2002:a05:6512:693:b0:48a:7c23:1896 with SMTP id
 t19-20020a056512069300b0048a7c231896mr7355400lfe.111.1658863988371; Tue, 26
 Jul 2022 12:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220722114136.251415-1-tmaimon77@gmail.com> <20220722114136.251415-3-tmaimon77@gmail.com>
 <afae04e0-76a3-1bcb-5b47-9944fa9ab2c0@linaro.org> <YtrvyyMGm64hFG5j@sirena.org.uk>
 <0c8688d5-b0c1-8cc1-ec27-292acbb38dfc@linaro.org> <YtrzF9BFJrXfxiz0@sirena.org.uk>
 <CAP6Zq1iRowFv4qg=AqdVmBRRx5p4-5AaC1G-aZs=2LnOAOELXA@mail.gmail.com> <20869b88-41f3-9e9c-347e-17c3d01baa5d@linaro.org>
In-Reply-To: <20869b88-41f3-9e9c-347e-17c3d01baa5d@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 26 Jul 2022 22:32:56 +0300
Message-ID: <CAP6Zq1iHCL9Krjw-wYKrG1K_yzwj-_qNROYxhogvkDjk+gCL-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: npcm-pspi: Add NPCM845 peripheral SPI support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

Thanks for your explanation.

On Tue, 26 Jul 2022 at 12:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/07/2022 10:44, Tomer Maimon wrote:
> > Hi Mark and Krzysztof,
> >
> > Thanks for your reply,
> >
> > On Fri, 22 Jul 2022 at 21:57, Mark Brown <broonie@kernel.org> wrote:
> >>
> >> On Fri, Jul 22, 2022 at 08:47:24PM +0200, Krzysztof Kozlowski wrote:
> >>> On 22/07/2022 20:43, Mark Brown wrote:
> >>
> >>>> ...with a fallback list required by the bindings so the driver actually
> >>>> binds.  Note that bindings are currently not in YAML format so there'd
> >>>> be even less enforcement of that than normal, and as they're currently
> >>>> written the bindings don't require fallback.
> >>
> >>> Yes, the bindings document should be rephrased but we were living like
> >>> that for few years. :)
> >>
> >> The binding document as it stands only has one compatible, there's no
> >> existing problem with it other than the YAML conversion.  If we're
> >> adding something new that requires a fallback we should be explicit
> >> about that rather than have something that's actively misleading where
> >> previously things were clear.  I don't mind if we add the compatible to
> >> the driver or document the requirement for the fallback but we should do
> >> one of the two.
> >
> > is V2 good enough? adding the compatible to the driver and the document?
> > Or should we use fallback?
> > If fallback is choosen, can you explain how I should do it?
>
> I propose to use fallback. The preferred way is to convert it to DT
> schema and then add new device support (so two commits). Other
> acceptable way is to rephrase the TXT so it clearly states desired
> compatibles - one for old device, two for new devices. There are plenty
> of examples in current sources.
Appreciate if you could clarify.
in case we use DT-schema, we dont describe the fallback like we doing
in txt document?
I mean that in the yaml file we should describe the NPCM PSPI
compatible property as follow:
  compatible:
    enum:
      - nuvoton,npcm750-pspi
      - nuvoton,npcm845-pspi

If yes, how should the user know that he needs to use fallback incase
is using nuvoton,npcm845-pspi? only from the device tree?
>
>
> Best regards,
> Krzysztof

Best regards,

Tomer
