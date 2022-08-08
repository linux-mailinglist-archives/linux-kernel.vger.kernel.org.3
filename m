Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595DE58C5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiHHJus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiHHJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:50:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD82657;
        Mon,  8 Aug 2022 02:50:36 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id w6so6040819qkf.3;
        Mon, 08 Aug 2022 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CHwnBGdAKbmhhJxDHk3aaM0ofkDZoUEAXm8AbvSBBQM=;
        b=m4uPMfQLUFaZLoWlQVsZjZ3OBalSzne51fU4Kwe6EBPP/McVsMTWSf1ymNlbiA7JxY
         9xzZlLLuOhMD1HxN032h8e6WgOA9mXmjwW7kdqB1e+LgbCkF2rKimUC6ciLkTSsvBC0Z
         HdIRDSOJx16ya9qXuUbuEx2+DArfunEHJqO6Wv/KcOmyXqPs1iT/IF6Jp5OySS4A8Nj2
         b2AyX2uyZs5TLrUw1GBs4K9f9d1t4ExC4PKZ2WpACd6YEhXmvg9v0D7OKXKY6Na4bYM7
         Y880JC0Vi9+vUOv7yyojV4E9o0XHuFJr+GYcVdem6Rk8GKy6DnJUagwRpzXVm33FgR4z
         pkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CHwnBGdAKbmhhJxDHk3aaM0ofkDZoUEAXm8AbvSBBQM=;
        b=FmbDq7eqiSRrzK1WdLObl/OTEW7kWjH8WIiWhZFsaVm/PMq7XJYia3kGt/s75z+nwy
         9OZeV9Q1DLz0Ds6zorsC6JS9h7bU0w5uoXJhUdeBkz4VOuCuYy0scVQ4h1Y58lAmeIF1
         y9m4QJisJZrspiia/SvEKsUkz9A+Eexe5hmhR3cUu7DGizA+tP3XVHNdPdgia4Qg3VqY
         WS3AQESOG37Hn8n5l5Noe8erfxYSFKLhfSYsDDmaMBL8VkO0SAU7yRSCUYUxJBbOkPJc
         KhRepc4e4R4hibuuO5raDU7hp+AsWpiXK5cC8ctGlwkqJDAE5QTNdKKkG6H30E36zZAA
         mAKQ==
X-Gm-Message-State: ACgBeo3OUAlJ6UbBPHSp5LyMa3OYym6XB0JoPthQ23uqwx3aMlX84OQB
        ZUHv/s0YJ2fOSinhs5NDtaR6GEwHWhDNGxZtdUk=
X-Google-Smtp-Source: AA6agR6UiufbX2bvdAG1id5uzkpijJNCr5BbV6vqhTeJJdohphljx4L7qfNVjXctF/SfuApqthUJfLTskMNr8jTkfXc=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr13561200qkp.504.1659952235916; Mon, 08
 Aug 2022 02:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
 <20220728125435.3336618-3-potin.lai.pt@gmail.com> <20220731130959.50826fc4@jic23-huawei>
 <4ea235d1-46c1-87de-760f-dc4775007ae0@gmail.com> <CAHp75VcZqTpmvVV=u4t=fdx=ffzksoWVDFZmq6Lfr6DrFrB2aA@mail.gmail.com>
 <Yuf7UAVrIJCnO40X@heinlein.stwcx.org.github.beta.tailscale.net>
 <CAHp75Vfe33oJAf1j27B-pTd84kX5JNPd+e16ygLYgZjCs=ZJfQ@mail.gmail.com>
 <CAHp75VfOPgDbTdt1EXJ5+exGXCZeT9VdtcOUDt_g4fn20S2Qwg@mail.gmail.com>
 <20220806181252.7633f19d@jic23-huawei> <eb2f574d-0dd8-e2b2-ee2b-d6f60f14bdc9@linaro.org>
In-Reply-To: <eb2f574d-0dd8-e2b2-ee2b-d6f60f14bdc9@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:49:58 +0200
Message-ID: <CAHp75VfEfs+Np2XOQDWYmTACXQALGBd9aAsx7PO6Z1pa=5WpWg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 11:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 06/08/2022 20:12, Jonathan Cameron wrote:

...

> >>>>>> compatible = "ti,hdc1099", "silabs,si7020";

...

> Or if second device is so different, why you want to support different
> hardware with the same device node. This contradicts the very basic of
> Devicetree - description of hardware.

Briefly looking into the above mentioned drivers points to the above
case, broken DT principles ==> broken DT ==> nothing to fix in the
Linux kernel.

-- 
With Best Regards,
Andy Shevchenko
