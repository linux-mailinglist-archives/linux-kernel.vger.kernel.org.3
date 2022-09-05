Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929B05AD96C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiIETMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIETMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:12:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AD3719C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:12:12 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so18708530ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=HRjuZtuMgKp7NhrWfk1BUsEhuHPCRNHn+t7EnNCzXzc=;
        b=o1GvstCYhBwaqTnwarfmJZWzq7E0OrdSPD/yTcpWd6KDjdNulAbJ4iOt3u7+nYDYWS
         83btvf6MX7y6CVPO7M6oK0OhbUYZNjwkkLzLgk6LRwv/JrT5bgxrpPGk+NFlnmISaONL
         03evkj+eKJuQekvXI8ya+u9g2emJwuFpJNv4Wg7emg5eYPOSmX9iZUGQvp1Fb0Zg7C68
         AoXyzt+0kVvMjCzCFAmXonoo+A9LK7CC9PPWeHAgOSigkXD6fNXGDYNS5DxeoXgP8YmG
         s+Usw3gma2dEgtbpC5PU+MBILVsE1Xv4hjy/Vh9FCjmE1tD2kzqVonIn8h+rWi9txBbs
         pppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HRjuZtuMgKp7NhrWfk1BUsEhuHPCRNHn+t7EnNCzXzc=;
        b=mCuiBcLygy9xLSBLn+SC0dhRGlCsgSrAfiin1d2cjX72ACaQqPu7XmPHYUMie/Ub5R
         O3WDtBkIbLd7/znNPFh1DN8xzwMjj4mxMZBrvzSGzB9jJ6EtHrP0LwmX2WlOzVz9MMxH
         K50ArGcT0gbVAJgLDMuhqzvsj4meMjU/97b+aTAsH03eeTzCA2k/ROK/mEI/S1pQqL4B
         BQApVmvg58++qogdJUEFYC6se663dRfVOFLpdwWznsjA8iITlNrqZTr7zb/dB7hqgW5x
         tQnuSTUv2rIHRnUw0Hlmu/Zd7iQj00nTIAQojmxA7c5lsP/+OmRGf1jmg7apOjEyqzQ9
         HenQ==
X-Gm-Message-State: ACgBeo2UqTxsgI43HkZ8GMOVh3etUaT+Ls6iQmWR30OWyy8zJWRPV0JL
        uSsLXqkb7NilpBwdBU5FuC3wLnpbvYBgaXGPBK+LzA==
X-Google-Smtp-Source: AA6agR6eAAORIyGUxq3s3Gl6wgrXo9i1iMAgrBbKU/MEyUUIoIjNyxNX/ShkqeOs6H0OyV+0rkatY+P9u6YwamzLEfo=
X-Received: by 2002:a17:906:cc5a:b0:741:5240:d91a with SMTP id
 mm26-20020a170906cc5a00b007415240d91amr30475075ejb.500.1662405130857; Mon, 05
 Sep 2022 12:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
In-Reply-To: <20220905145555.674800-1-etienne.carriere@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 21:11:59 +0200
Message-ID: <CACRpkdYMc2BAHgGa-uPL8za=UO_Buz04TNPbmhUvXen8H13Gkg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-binding: gpio: publish binding IDs under dual license
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 4:57 PM Etienne Carriere
<etienne.carriere@linaro.org> wrote:

> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-2-Clause license terms. This change allows this GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
>
> All contributors to gpio.h file in copy.
>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>

Fine by me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
