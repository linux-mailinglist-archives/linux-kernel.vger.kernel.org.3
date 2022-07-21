Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764AE57CE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGUO6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGUO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:58:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E433ED7A;
        Thu, 21 Jul 2022 07:58:00 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z22so3197923lfu.7;
        Thu, 21 Jul 2022 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48PlfsC87xgFu6A92LtJ5PO1dJ4kaDHkINOovFfDkwI=;
        b=jOOxlfnRvbCZ54WpoHg9f6j0WWPb4mOgb6DPHpl1JXM8/1EtC/pmNX6nneVoC51CE6
         7hDyGBSgjf5gVtlx4RmW8EKwOYFumvU+Knb78WZ0t1DM88NoNJLWUXI8XsROBjv2JVw1
         k7/1oQ1n6AbfrN3z9MQqKXRkj/sngRVP7Isa61fvysu4PjPRfJLSVRSb9aZg6iGDww9m
         4SORq8AgnSSIMt9NnlPLOyN6eohuoTVri2RzLwsfMUmOwmhWkaxzPPIHhzOhCx9motxW
         6kts1jBQ5PUzBj0YG637X6LCn/lPet2QMbJelyVCCNehe/ktHl6jE97uvTKAUUqgnbr7
         uhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48PlfsC87xgFu6A92LtJ5PO1dJ4kaDHkINOovFfDkwI=;
        b=bbLd43BIk9DJV/KW29gIEQEWW4k1bZGx/gbkvoZadvS3jlIVI9QXULIxNBRWTboP02
         +VSs1wMOyblbw55mcGVKu8rq8gFxutaeASgpnGw98O05kWqxa87mve014fa6WYjEVz7d
         szIhfoxL17Yow3vARZGiUvoBXenTrScBFT1drvq67NJCxRkSJyyNyk9fLdEDQkQONGwP
         992eMOl6+7qt5cnQK/wprwuy1EczZC7Yt7cwvqLS5TiNgI1309UEO7iOXoOVkpetWv0b
         i2+EuTyoHJMdMJXGLMExhipPezQrMN2rwXwsRNvuwbJGEfhFxWJOXATa9YvviKxhN83B
         4IDw==
X-Gm-Message-State: AJIora82H7Cqg/mxEuREQa/luUCCcZAhYYNCP+MY7ZAewLYXuoV96L84
        N6DohWyCYWywC86QNGJBpxYtfzwiUfJA2fSGdww=
X-Google-Smtp-Source: AGRyM1so6n4gTYaLLCB4eCt3XhqNcW/fDZPw9v13mtTTC/UlcWvIIhAFY0fQE7tGnHBgOYDnWoBRmXZWxR309iZ3Ppg=
X-Received: by 2002:ac2:4897:0:b0:489:f2ad:1191 with SMTP id
 x23-20020ac24897000000b00489f2ad1191mr21156290lfc.25.1658415478569; Thu, 21
 Jul 2022 07:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220721101556.118568-1-tmaimon77@gmail.com> <20220721101556.118568-3-tmaimon77@gmail.com>
 <YtlCAvJK/pb4PbJ6@sirena.org.uk>
In-Reply-To: <YtlCAvJK/pb4PbJ6@sirena.org.uk>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 21 Jul 2022 17:57:47 +0300
Message-ID: <CAP6Zq1hULj49g55N+gMf=nULzEcH8LiuHzUUhAiBHhCQ7iSpMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
To:     Mark Brown <broonie@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
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

Hi Mark,

Thanks for your comment.

On Thu, 21 Jul 2022 at 15:09, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 01:15:56PM +0300, Tomer Maimon wrote:
>
> >  Required properties:
> > - - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
> > + - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
> > +                             "nuvoton,npcm845-pspi" for Arbel NPCM8XX.
>
> You've not updated the driver to accept this compatible and this doesn't
> say anything about fallbacks.

I will make sure to add the compatible to the driver

Thanks,

Tomer
