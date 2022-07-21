Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407C957CAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGUMz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGUMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:55:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D939D2712;
        Thu, 21 Jul 2022 05:55:20 -0700 (PDT)
Received: from mail-yw1-f181.google.com ([209.85.128.181]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My6xz-1nIZ691wX1-00zVmt; Thu, 21 Jul 2022 14:55:18 +0200
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31e7c4b593fso15759467b3.13;
        Thu, 21 Jul 2022 05:55:18 -0700 (PDT)
X-Gm-Message-State: AJIora/r39fSxqUauWawf2AA4LKXGvj/nnBpRGhRtjm8Z7ONj43DknkE
        Pu7GtVwvdoxUeIanujkgkV16U0LJ2aFZGH1X2Kw=
X-Google-Smtp-Source: AGRyM1viYGlLryja/5f/h+YZGqrEBl07fhm4RYssoWdw+dgSQElSnDMEgUoIgmmN+X2tZwirCrjFYbJdyF9Tq6ztqcQ=
X-Received: by 2002:a81:6742:0:b0:31e:7064:9205 with SMTP id
 b63-20020a816742000000b0031e70649205mr6722307ywc.249.1658408117110; Thu, 21
 Jul 2022 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220721072415.11424-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721072415.11424-1-krzysztof.kozlowski@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jul 2022 14:55:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1j=WUq8=VZz9aY5zkPeEMaF11w4PJF7evmY_JTsFoFZQ@mail.gmail.com>
Message-ID: <CAK8P3a1j=WUq8=VZz9aY5zkPeEMaF11w4PJF7evmY_JTsFoFZQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dt-bindings: aspeed for v5.20
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CpcZVuRv3+W2TewzspBVX2apb0q9d/q4lC/3bF2YTTL79D8Xkcw
 O1LeDhxHB9PtzYxcqeTnVf4Q66eZvPYgcIYZebT+abii5pd3BwJglC0NP+EEoohfIqNt/jp
 4pGq/aaoI/P8BhTLvHXeBPCpzSLtA3eTEpaWPdjdJ92o+kGzMZC6LGq4UU+e31XQ6Rd15b5
 xRCljTkwnAmzxrwckBQ6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpwBCSfNDjw=:l7QwgNmiBRRnl1+N4NNucS
 ZcL+eQR1+EVdY+UnJ0dUnFjBkPbscHWjcAUbPC3qcyhU8zwykp+5TgkUKAk8m1jv1gR1Kgo58
 sjBrkx5KvoBTqySGMEQ6CGFyPuT70WZR6LvocrjOUgh6OSv4PObHa5/++GzzuMxX0yFAwy5WV
 RAXWYQ+HjGruLU0ITHisCJR2m04jtcbDKq4Usp8oTrjCVzq4iB31s/tmec5wQXbz8qQ8OjE2m
 qnUcQtfiCExds5oH8yE8AcpGDigE4fJU+T7LgQuWmPrEflOzYghi/9nzOibOwVQpbEmMMIX54
 iA9sSTNfw4Ki9W7z1PucWFcrfnOTYZqwpxGOBR+WjpM0mKkaI22y0888LDGiyQYmG0kMJe8AW
 Y6hqrejiAQYGYvglAaHdjDOK/mmrpWq+PTv8NPaE+T7Z2dwywJJBktuJD6euukpRlBIzL47HX
 UibQI2CFF5xJ8LP4LN2WWL563i6aDn5zpxUFHNQIMUdBr2/5vOlLaub11AzR717iG5sTUeTTT
 CCv4ow1rgNBEXOeNulwUAIf6dRJ3m9JPlR5jS780ycsGQKRs/iquKzj5azy5qkJ9l+9mhXEEB
 FWCzRgnKNcz1n8tKJufMYwDhwXlgIzwzEytZWPzfePIzxxLOJfYn1fSul9ZCnPtiZjq8P8F3Z
 q0u9w5Jyf9j+3wrthfDvZHICrgOedPUqEf3FghJ/7+UxXrNIEwAoIFRKfEULhTga+M24p5GEQ
 7TyeqbzB3V3Mc6AmQ+PTiaKXF1NnwpumJudC8xxMf+A4cP/rBBZAJ/i8BXyKissHCXZNku8gP
 o4xVHcZnMJmByTP8DXnpBTLDobN/TAcOKw4jrd7SyBQT1xqE59DnYuvZCxvP67X67e4AvjwrE
 ehovvGnB5+wskXVJhJJw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:24 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi Arnd and Olof,
>
> My two patches documenting existing Aspeed board compatibles were waiting for
> some time, so a month ago I decided to pick them up and include in the
> linux-next, so other developers - like David - can base their work on these.
> Unfortunately the responsibility for the patches was not cleared as I was
> waiting for some replies Joel and Andrew, so I also did not push them out to
> you. And then rc7 appeared and it is quite late now. That's my mistake, I
> should sort it out earlier.
>
> But anyway these were for a month in linux-next and other work [1] will need it.
>
> Can you grab them last minute? If not, could you queue it for v5.21?

Merged into arm/dt for 5.20 now.

      Arnd
