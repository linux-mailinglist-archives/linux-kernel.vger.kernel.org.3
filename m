Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DBC4F5C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiDFLXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Apr 2022 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiDFLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:22:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC3547CDE4;
        Wed,  6 Apr 2022 00:43:33 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFsd7-1nmEnM3hqJ-00HNtg; Wed, 06 Apr 2022 09:43:31 +0200
Received: by mail-wr1-f41.google.com with SMTP id w4so1820729wrg.12;
        Wed, 06 Apr 2022 00:43:31 -0700 (PDT)
X-Gm-Message-State: AOAM533IjTKvRVuFr1hpf6jVR0dbpC0/ev/LOyYjVm64OGy6k0xQK0PI
        v8edVyjyzWFukyGufgdR/NfbTxoZYWajygNpRG4=
X-Google-Smtp-Source: ABdhPJypJul9cdCELa/1AnvYtkz00lmeff9mRrfOlzOzJtIgInlf166z4d0cq68yNgLel+5mgKe5/LD/ixwy4Exk7RQ=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr5368683wrg.219.1649231011518; Wed, 06
 Apr 2022 00:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220307091923.9909-1-ychuang3@nuvoton.com> <20220307091923.9909-4-ychuang3@nuvoton.com>
 <2669852c-5bb6-1edf-bf58-ea815f54d50f@kernel.org> <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
In-Reply-To: <ef8efda1-e985-0684-470f-7acf9b8a5e93@nuvoton.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Apr 2022 09:43:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Gbr4PoJbPy3BEQ=T3iJo9kQdjes7+0UK5vnc4CDckSw@mail.gmail.com>
Message-ID: <CAK8P3a1Gbr4PoJbPy3BEQ=T3iJo9kQdjes7+0UK5vnc4CDckSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:cod3+ULkmqjUacHdjf5UZW7aCbxyF+7tIg50DqEUz8mEsXgH0sl
 uZKrEa6zhJMhYJ+vGs9nAV1CW04UrMXbEVt0YCqzrDyWToIib8QKuNBFmMDcg/Q3ETQOFth
 oJK9Xp+jE0vgxkzxalCpqTdd7uQrP+B4YIybLbsDzACQqOoZ9kVXTHxpKJLnEvKwBN0i9Lm
 3wb9zc3rsZUkeo/BkXBSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5IAkjZISys=:FngXoHQq/KgkR9R5mahVcA
 tRM+t/sQsia7jhhwHJjc8DxunLAd8SwsJtA4kbZzkEk+sks8gtes3EIbkmzfj9eQKN3ssHxaT
 VEh2zd187vBhBzauTLu64YJjRJeD0dmKI3/6Qt4fsAqcPRQluT62AaQLTHQSoLN5N6XK2VEoe
 oJFNmkx2jr3amWhBDOx76iA6Siz8b6yMlWlikjRtLAhI+Mt3WdnhhXOaGwbhK+k4KwDNprEn1
 pqID0q0ITYy0VTdNhM1nvaw0lRD/pYX/aiHRYqdbDu2e1u6tEmus9cQ5CsQa4U/DG4qm64KB9
 GlpZGzMQ6+aPamjFLeeQrOUmFMV8Iev760I1+GbtQbAYr7ZAMFGDg5k3mYSb+CZ6HF28BRQvo
 NUM5XppSwArBHs4B5/VKpgFnuiLeNFcTWKQLjVUL8AFbtDZqLr6Qd81QaaD250KDyvbX5YyDg
 2x/PhGu+qA/BlPWYxbsS0L8fL/u9KNSiYzMh25Fcyh9w/yMJLd+c8WhDz8a2JCwJQTYMXLgDX
 1pftjyCeO/s/SeEmUK377d/NNccKtoQdI6TqFBQWJlSek36O3YfQ0m/EysRUZakb6Kgh73ZR/
 kVfdDJlFd8SCetz2Js0xLDmYAgnHsAPRoBA3XV9iiyygBaXEibGX6fe0di420kp41iByQNdmV
 glv9LFocZn3eom/ZVN36Rnp3LMfgo+cad2eTRG5tYzah488eM5AM2CxtIBj2SqtKFemd05C3b
 ne5cE6mtnWccz8HtvWQJvBGLej4znt75LRlcHLPYth2gIYQkLAjJfpyQOGxI+c8jAWsodtbD9
 XFts5fc6XHqhBjKyOF5rvHisCR/Y61aEuT7tfM9DWvMmV7sLe8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 4:58 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
> On 2022/3/7 下午 06:25, Krzysztof Kozlowski wrote:
> > On 07/03/2022 10:19, Jacky Huang wrote:
>
> I would add the following to end of arch/arm64/Kconfig.platforms, and
> add the
> modification to this patch series.
>
> config ARCH_MA35D1
>      bool "Nuvoton MA35D1 SOC Family"
>      select PINCTRL
>      select PINCTRL_MA35D1
>      select PM
>      select GPIOLIB
>      select SOC_BUS
>      select VIDEOMODE_HELPERS
>      select FB_MODE_HELPERS
>      help
>        This enables support for Nuvoton MA35D1 SOC Family.

Selecting SOC_BUS and the gpio/pinctrl stuff is ok, but please don't
select the video helpers from the platform config, those should not
be essential for building a kernel.

       Arnd
