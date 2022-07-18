Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D603578273
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiGRMhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiGRMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:37:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF6E65C1;
        Mon, 18 Jul 2022 05:37:13 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MpUMc-1njt3c12iK-00pvki; Mon, 18 Jul 2022 14:37:12 +0200
Received: by mail-yb1-f177.google.com with SMTP id n74so20502470yba.3;
        Mon, 18 Jul 2022 05:37:11 -0700 (PDT)
X-Gm-Message-State: AJIora//zphf2uCO+KAzccnSf5DdE4gBJiDI+zau7+FX9gqK9Zm1wGAv
        +RVBI4NJosVuqhd7TwwYhMRKnc40Xyue74SnVHk=
X-Google-Smtp-Source: AGRyM1txCh5KSHFufIxKnjrUsQfdXMF5DhA1iW62NG52SJqnf8FXUR7Q6wJLhAzG6EEmYmN/Lvx4Nc0/ujPqwaXi97Q=
X-Received: by 2002:a81:1914:0:b0:31c:e12a:f33a with SMTP id
 20-20020a811914000000b0031ce12af33amr29924965ywz.209.1658144567116; Mon, 18
 Jul 2022 04:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 13:42:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ob26oEL=af0KpyCqA4nxHW_PaaK3azKT504Q+VrFctA@mail.gmail.com>
Message-ID: <CAK8P3a0ob26oEL=af0KpyCqA4nxHW_PaaK3azKT504Q+VrFctA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: centriq2400: drop the board
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8YS31fMgF4eo7vvPsl6ANZl2UYD0nR5fAIDTRGslVe/TQV5vfik
 /Pg/+dAL/Jslw8762vSlsJ1t0CwKYvwT3R2m/fOUjx2Z4uYCRiIZdeASQnuIgz4LSkDZBYh
 OkL3erJatS6IX6eh80hOML77vbPMg/5jmmln7aJvJay7f7orwlZMQrd2UWCiri3PTcGkDGD
 k+yeWZYxHMjq/15fFs1jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:51t5l4CIeJo=:R2lYdDN7PyKBS9Wf53NNoK
 cTneYtBECAYDqg7sxVursoDjNKhN62URw6EESffw7X526F1eouYoPW4K6V+JnOQJ4MM3Leqx4
 q7eFnVouv1Jq0RFpMCRqWdQLr14vfolsUmrfdamqz108CyZkC7Ne9/jAAOyuBVVky4Zje6lDp
 dQiQ/Nyk+tZb2CMS9fkuG8nq34PG1i50BjGDHAn9YoAfsOppBzhvYySz17bZ1+dqMNFRvRodI
 AiRgCt2F+6NB6VOeYQ1+DAKzB0Y4koHt8cugxUxjjd7AAWtkgYAIiKumWKnX9PmwfYQVZxztr
 Q2tDwzAW8KLuFAvdbHbO4vFbHMFvLvx6dJtmGn7NaI6BbVoptUPhTTZJQGSLCEhOguM+B5cBQ
 XT9LYkKITfAiI1zPyXNpX3RqmJfbmEc9ejrvzhC1KywZB67Y5mVkXwUx1G6Y4AJ4x9inGMfe2
 4QMAzdO3LkW9Nh7+7rUlxVSVe1DgjYIMkjJiYbh+34bnyNe8qMZrE1WS4ZHLonCdlF8ah1ZwE
 5dhyKHeLpr4D7A1gFbMgBRapTVx7xr9W+yogIEsOqOaL0uUFDLVmTj7PZSAZTvoOv+9ABjVAk
 ROtGL/olspWsqBs3uP86RlqN0cB6fiNpO3yYCtrh/sruJcfSycJsAkrBJ269U+3+G9NDGwboF
 8RS/eLMfBXPRI3MfCod6Z+aaL1gsu87pJz5t+g0BW1Q2lUPi9XD1k7JaLsVZv6Y3lCm1koRDC
 lQhKa9YE6Zs6GBRf/kNXHseEc/3AxNkNa9VpPGa8fhdY30itDDth3Ld93ouvNbBaY3prQmkFv
 wV72UPyQwen3P1jH4Zc8R/StfB7WCttQB+vyunX9H/Am1ia96cDmtYlNtim+dqNnz24pESfTh
 IWhfCBRfCMvjkFwFED8zN3rNCQUF85PUZfEINDN5g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 9:24 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The board is unmaintained and unused, according to Joel, so simply let's
> remove it.
>
> Link: https://lore.kernel.org/all/CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 -
>  .../dts/aspeed-bmc-arm-centriq2400-rep.dts    | 225 ------------------

I found this one in my patchwork backlog. I had expected Joel it pick it up, but
it's not in linux-next yet.

Joel, should I just apply it for 5.20 or do you want to send me a pull
request with
this included?

         Arnd
