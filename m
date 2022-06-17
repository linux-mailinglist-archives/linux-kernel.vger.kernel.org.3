Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC154F6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381845AbiFQLkT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381617AbiFQLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:40:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93946CABC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:40:16 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuDsZ-1nhbm73XYb-00udEk for <linux-kernel@vger.kernel.org>; Fri, 17 Jun
 2022 13:40:15 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3177f4ce3e2so16076507b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:40:14 -0700 (PDT)
X-Gm-Message-State: AJIora85ottscSapDca1NxQ7Oz8vbF8NOt5TbEKcseeARR0Ahl/aCkFF
        WQRjGKQNfcRFBfjz2bJI7zvP0h2gshu/u8+dlUc=
X-Google-Smtp-Source: AGRyM1vlnn4lxtCKDOQYJthDA/6WJPY9HLjuSRhXPkjh9BoYTT6fsyXS9MF8bTJzDmFLdbwhKUgGnU9CDMgZNcHssLA=
X-Received: by 2002:a81:190f:0:b0:313:43b8:155c with SMTP id
 15-20020a81190f000000b0031343b8155cmr11360101ywz.495.1655466013671; Fri, 17
 Jun 2022 04:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220609213513.88479-1-j.neuschaefer@gmx.net> <CAK8P3a0-m1iQ2bP+dsoGTPZGMNBKqB5a6315jdgaT3tuR4WfTw@mail.gmail.com>
 <YqxJLhkCQ2WcHdAp@latitude>
In-Reply-To: <YqxJLhkCQ2WcHdAp@latitude>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jun 2022 13:39:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2EFF57VqYgAtHe-2A6ttENpGmB_zqd+gYXAjg61gQhHg@mail.gmail.com>
Message-ID: <CAK8P3a2EFF57VqYgAtHe-2A6ttENpGmB_zqd+gYXAjg61gQhHg@mail.gmail.com>
Subject: Re: [PATCH v4] soc: nuvoton: Add SoC info driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Hector Martin <marcan@marcan.st>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:SniDFm6Lk9ksRv67wu9d1kAOmxCKI6IO/+b95g07cEuJi6hKydZ
 3G3DPgd5kF90cSbi+esTq5hoISxiPS+OIJDsyY9jlHJLIu8CLVsgSK4+vSBD3nEe0lXwWjv
 hC0EdGsMc3ESaeV3Hkut0BDzUmsK86j+YP/l/tFiB7pGoATF+NzOWlyYYJgh0yAac2iJ+4B
 4yrSuftubEBVGkljghMGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:id9iWKEB9CY=:iAD47urKURgSh8ThCdTO04
 iXA9L2aBXSd1N1TjbcsKtbPyQBZzZM/gSORrWBo3TDOsr8i2ySeb/CiylEphePu/MorguLvG2
 F5SvPtYFSugRbdY8l7RgYsrhx4f0VBHBltOtOUAMdLURJahRV508/RmRpimHqp1oapxBQVeSQ
 a0oDOKMUvma57zhKoqzfrfvalOGPfnyH7a1kvtXi9zP7CK9Yw+/xTjiLHl3eKBMhsBIstotZ6
 HCGB88DOvuTsJGJP8DQrauvA3EvoiALmtCj9/UDnt9Y8y5ak0Kq0WM7Xy7xdxeb0ozYwj4baL
 7TZKtQ/4+aOE7OkCnsSfOVaq7pDuDsxNhzGFbGu8Vfg3PI1trrcbtan2wcWUsvyAGrr9aaZMP
 p8w1xumaqlNoq7sszhp7RiTO8lSyFAwajitYqGg7apdPZNZCrnIrsk59ZUaS+6+z24XHXkdIo
 22xJ0SVJdMEhFSuPk0DeKgGo9tbWhkI/i5L9hG1AzhC0tEnVVTY7xbHplz5xne4pLfQsPLW/j
 ccoWPtWS2uo2miUztooJsoacAXMNOzHBiBXBbsmmIpTIDNx0Lwdb2D2p1hkNr5Fu9K/65NBdw
 /VSa5EQtxmDmJEfDd9kBgnRtHZHa7OAwnGZSZARVBxX0tN36k+vdEng4c+4foUb0AdLf52hBZ
 FugyNzAgoUDjxZfWWB5Gm6kEs3lmG1M31oVDzN5z431Ui+S9qn6jgs7ccPlNmjRcJmVYkW5KF
 mdBzW+AZJfSgBj5XcWmFKDBf57QhosYYGN0fbjwOwKrZuxzPmcQ8df+AC/B2tTOZCUsnX8Lf8
 XtC9egLRkR2HgKEpd22mT4b9TlAcM41NR8/ace3U1jIbO3T7ZTTwfmBov7xxzfy4maFswwQc7
 j8r4diJea+C5h5vW1Onw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:28 AM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> > Just add the trivial cleanup function and MODULE_LICENSE() etc tags.
>
> The right thing to do seems to be to unregister the SoC device in the
> cleanup function. Is that what you mean?

Yes, plus kfree() the soc_device_attribute, or make it statically allocated.

     Arnd
