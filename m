Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766BD5341D7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245538AbiEYQ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbiEYQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:59:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC6A5029
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k30so30947251wrd.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=PN7c+ZsciJ/kEOjPj7CShyBj/DLMdY+SeuzKoJuV+aZs00rsfGtKPxXYuXkDBJ+S65
         +uM95I3LPBfkBnNJtlsq3Hb54Vee//W2JCMtzVXiGtQO50V488NIYCi61azqiCWc6O3c
         Q5lU3W83LYTjnEIjbwpSasu8MmFtG9SIpezhIsHVO5szkxK6XNck9CfoRN9NbVUaLhQ8
         rYnP9qSQ9RsaMMG4frzZhL/yat5iLtRzzgeCf/MMbJh08/WMAAcFYYbFqaqpNUYbIOLm
         zw8NrHxtN81kOAdgF/FzYqXwubENk2rIRCDyHk6nuO2yj17cVhEWMQAi40vrNhwTac3X
         RwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=Ma0De95uiazuXv5U8wISaNfiR1XUeT00lTKJjojY4L/YDjlqx+fNY9r8Z4pUoV1oDF
         m2OBQMpMaRvRkCfBU6PHvV2q3BtLUi/QQuVHBxj0ekL0LFpKutNJ5Piu98PmI5PfRy48
         3CmKOX2gZvoVQrbenJgxs8ZUe3eL5/DJ7pN/IoYf3IhEYdyKyYdjuNBK9sHFAoCgVgBH
         6iRJUKfaleLmQaNcAsz9Mw9KiH91BvhNCvYhRpWrBksdvagwI8V3iYpntA8BQVAu11Cl
         nzMg+ZfVULwSkH8NXLOPvG5YN+3UOyh1LmWL7syo7anawVinVDURxYQ3KKFuFY8+ADdJ
         vGdw==
X-Gm-Message-State: AOAM531lfjyf6fl2srgeZu6As23Gsyqm9ivWXNuurwMo69/tPydHkj8V
        bbZcXIqEhJlL+TsSCVNoe9S02gwRYO2SI3ZFS20eF87p4ZWsnfcz
X-Google-Smtp-Source: ABdhPJybIyWNzIkBX1luV1MnU9OIiN8pAZht74AaILdEoJbIQZLlkTffZeSVmkFeLQons+gYVBsMhKaLpMV+YAPqwYA=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr28019559wri.90.1653497938850; Wed, 25
 May 2022 09:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-5-brad@pensando.io>
 <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
In-Reply-To: <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:58:47 -0700
Message-ID: <CAK9rFnzHOTg9BR-KY7rQttN2Cu2SYqAXfjXLYsH+RKYO8Su01g@mail.gmail.com>
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> > Document the cadence qspi controller compatible for Pensando Elba SoC
> > boards.  The Elba qspi fifo size is 1024.
> >

> > @@ -48,7 +49,7 @@ properties:
> >      description:
> >        Size of the data FIFO in words.
> >      $ref: "/schemas/types.yaml#/definitions/uint32"
> > -    enum: [ 128, 256 ]
> > +    enum: [ 128, 256, 1024 ]
>
> Is 1024 valid for other controllers? If not, then probably this should
> be further constraint in allOf:if:then...

I'll change this to allOf:if:then so that the 1024 deep FIFO is
specific to Elba SoC.

Regards,
Brad
