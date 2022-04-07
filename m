Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA04F89EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiDGUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiDGUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:51:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE7131F2BA;
        Thu,  7 Apr 2022 13:43:51 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MulyX-1ntOth3jXf-00rq0f; Thu, 07 Apr 2022 22:38:46 +0200
Received: by mail-wr1-f53.google.com with SMTP id a2so296936wrh.5;
        Thu, 07 Apr 2022 13:38:46 -0700 (PDT)
X-Gm-Message-State: AOAM530ai52r9ufA7kTLGlcyas14gLwlkPzi/xiF1Bx/MVbPAy5/7mTX
        mN7HScK10aw8zhSJPM6kcOobrSCmcdPlCY4RV2c=
X-Google-Smtp-Source: ABdhPJy/SgVGQPTQl0Z9Jj7qvw3Sglc2LkZldTdO5JZKiCcu9L8Hp1QDfF0ep5w8MjBFmfVBXWNB7IIvt2RfSfgvQwI=
X-Received: by 2002:a05:6000:154d:b0:207:9101:8f24 with SMTP id
 13-20020a056000154d00b0020791018f24mr802419wry.317.1649363926543; Thu, 07 Apr
 2022 13:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-10-brad@pensando.io>
 <CAK8P3a1RdHTngDVqg4KnVA3N8EjDfbpQ=cEcz_CK8NmG2EgYLQ@mail.gmail.com>
 <3c8e94e1-fb8e-0d8f-4e79-b8313a1da5cb@intel.com> <CAK9rFnwsMd1+oQ8cg8Biw7HM=R6aOudfK7Ja+E+iGVgfrvC9Gg@mail.gmail.com>
In-Reply-To: <CAK9rFnwsMd1+oQ8cg8Biw7HM=R6aOudfK7Ja+E+iGVgfrvC9Gg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Apr 2022 22:38:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
Message-ID: <CAK8P3a28ef+DgcKrMG03b5Og-W+afieoqF1zvNkXdG22qA8i7g@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: sdhci-cadence: Add Pensando Elba SoC support
To:     Brad Larson <brad@pensando.io>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:o+5RPQIna+gLLkibDSf2fxD5OHxRZ7cFKWDQu2hSxDFX8cL2ozw
 dBRBfnC3YHm3Sj26oGBZ9vZ5OibxClaK/qHQ8TzNau7RL6AFZ2dVJtULWNrkpGTotxJgnCE
 rw2CREtNEwogmnSw8BqH5JVuZTkgoA+ehLW3TUolhlboqj2OOExX/ogwHiHgwQSk8Hq2Cbz
 BNn3FJC1YDc91BAIJQiuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JiwMnTpDL4E=:wO5ksrBM4sf9BGnIYfujL7
 UZK24sW+KeZc/eg41jcx+Yx5Ky5nzwChDpKySgfivmkttaQMvv2uwSK0vSwBB13NofOU6dMGI
 niIMxCgeQeeTfgJ8uQYj1J26JmDlI3zgNzhchs3eZZ0MIZkgjSTdvWaqsOmT2lQPOE3gm5zmf
 BFzO5itUAb1VEubP8TnyOEyhhZmfXX1PS8/eQfPkxw9BBsKSpZzX0Ipxu0M/pXhbft5QXXVn5
 QTRde2/fQEjYwypYdHrTHR6dElTW6YSsuZu1RNxTlC+/ZCNwcCSaldR/uvjO7vhCKcrq3eVhX
 XxKOQwpVQY5nwsrzs5out0PXZOdgY484FKqqRxmJL8VautBAyaBxKZbWFLCGa2QUHbBqics2y
 8QNwLeTiXJthpJRObMunbojqPEB0HOmv0tVO4J0I+ewkyQXGbxNej87rQvNzT7QjFyuvS0PYP
 4cpRCkFdyS2ZcTDFB0VhzX1Tqvhw/1SqL3BIpNJ5u8Tt32bAPw2DQ4urBS6XgBXpa3tgmPwcY
 Cwkezb13+YxjxziBHfGQWHK0xWKZYQ5WEOf+kFnw9eHQ2L6R1PKFWUxSOK90HHp3yx3lgMXVw
 mWBktMHAVWLTGC02pX6tPGexYqqCisBNevWjNC5ZseMCG8Lv10gu8CVMwTNpEh0vBJx8u7Awx
 PHWbmrH/X3ZYCAxafkapjZMa8d9hZY9CLbRLy0utvAtztmc4gkWzyzGF7wp0I3FVTVeo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 7:06 PM Brad Larson <brad@pensando.io> wrote:
> On Thu, Apr 7, 2022 at 12:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > What is the relationship between cadence and pensando elba?
>
> Pensando licensed the cadence controller, its 100% cadence IP.  The
> integration issue we ran into was with the accessors where we have the
> workaround.  The initial patch added a separate Elba driver file but
> the feedback was the Elba support didn't justify doing that and to add
> to sdhci-cacence.c.

I looked back at the earlier reviews now, I think the main problem with
versions 1 and 2 was that it had the abstraction the wrong way around,
so you added the complexity of having multiple files, without the benefits.

I still think that the cleanest approach would be to have it the way I
suggested in my reply to v1, with an elba specific platform driver
that calls into the generic cadence code, but the generic code knowing
nothing about the front-end.

Then again, it sounds like there was already an agreement about
the approach you took here, so let's stay with that and hope we don't
get any other chips with the same IP block in the future.

         Arnd
