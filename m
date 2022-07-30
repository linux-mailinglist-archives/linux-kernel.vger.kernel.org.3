Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB402585A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiG3MD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3MDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:03:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD413DD8;
        Sat, 30 Jul 2022 05:03:22 -0700 (PDT)
Received: from mail-ed1-f52.google.com ([209.85.208.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXGzQ-1nxTzb0neA-00YgxN; Sat, 30 Jul 2022 14:03:21 +0200
Received: by mail-ed1-f52.google.com with SMTP id o13so8604554edc.0;
        Sat, 30 Jul 2022 05:03:21 -0700 (PDT)
X-Gm-Message-State: AJIora/OBC6tFrKuV2m5sj8LdpzPPbEWe2OXZbC259qQIOYNZ6guZ5wh
        o7Ybpp+jQ+S4nfUSC44JcAccBErdJnud5HcDI2k=
X-Google-Smtp-Source: AGRyM1vvvOA0nFdfHBjxY45zdeQVRdPjYgzS746B37qSIt9lT2WK8AZ9y3kgr9XwEPyH2FM5Fr62DOhaTCbVNO89/WM=
X-Received: by 2002:a05:6402:26c2:b0:43b:e542:9f68 with SMTP id
 x2-20020a05640226c200b0043be5429f68mr7635118edd.227.1659182600838; Sat, 30
 Jul 2022 05:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com> <0a0a64a7-60cc-e95d-c2e3-3c11a53a6527@socionext.com>
In-Reply-To: <0a0a64a7-60cc-e95d-c2e3-3c11a53a6527@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Jul 2022 14:03:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0egd9dupLFid9CsSygQyTK3KopB8m5LVgnUW9L1cF6JA@mail.gmail.com>
Message-ID: <CAK8P3a0egd9dupLFid9CsSygQyTK3KopB8m5LVgnUW9L1cF6JA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Update UniPhier armv8 devicetree
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:W7BRPnTZLSHXM5/GhLwnKR9HHjCI7GgFX7IAQtlIHZmmCxDzPRU
 TxV4KTSWff+Cp+IbZQ7yK1jORiiIkYC1UBD23XaIibeP30ibQWMIBZt6Qu0ISUw8loBmOkj
 EqMXs/cV8dbn99nWI7sypZjXIqQCMEAPYDWQAAVdVPsp8HCEgNSMnPUcRjUfS8WoO3mEpje
 uKfSFbSmlEiGzwwItOljw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tTZBlMdTEvo=:bj0uFCr+8LeE6bPacduCCC
 67t/Nn+BuqsybMmCR2waag4GZOcIiIAwy/ClB4tZ4/XGth8tOVzoyNMWR2IFRuWWMSnFMvhaN
 KDPSV71hMdp6js11cnHPJkt0/QdGG8AQ3hJESr2r7ABU6nqk0pgyLPThlSmmlhSx474b+hiXO
 lSv3EN5pvP+sexERLpjrROWl0wuE2u1Y7wQytHzCkEAOGxfGGTYxegYnKGdNWORWrOannMUp5
 uyEHJeMG5rgo8pc1wG85bMOPl7bnatEh69KO085jvtZuCyXpDqgY6ufYXLTPdTJUF5myzqxDK
 pKRdTJBCs6whOxgOgml5oIMOs5poeAa2zjsAT8ZkcgsJyb1YwGl4uoeWOmFKfaeVjanvp0tsW
 ZoxS936Ok2IvEvi19i3hW0iqdWiD5bKKuCW6UxnZ8eq78a4+bJWRctKZMmCYToiNwiSSXfy2J
 7qzgA9MU9mWvr1BIIIGZo7hm3VeHLAh7DiU+ZF9Zk+ArNqVb+4xJF0e5glhHOeO6lY1nGyXXE
 PIo3l7MI3+Bq8dwVOPsjcCAckIuYp3N9WoDwFp6n8YEGU6fIT/ML3UbeNU/Jk8nY5js2ZL2rr
 6gVYRnrEUKVxMgFa6uUjS1TXJ623cZwca6PW4Gh940J26uhrq/gkVqoJ1ugld+1+dv0oIPXTf
 wlnMx8ZSXYefZbQKD3bci9pAgM5lJ40XZ5frz4Ep8EavpEkLp7UZgoxLY65EbkZwSRhqNIVZ5
 3RtJmE8D0hxdqc1eMUOq62G97QshpJfY+4J2l5prCIBSdrg2VdLCmWbp5vrrgoi5bgZDznjm4
 1P/f7qLdYIcVX8+sNB6yGjFRzLXlS2QQGC+PG5msk0HBFMjicY68uMwAg6LFRfPaFoKegXJoO
 j8vhp1dLpnCQnZ1Na0oQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:52 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> On 2022/07/04 9:21, Kunihiko Hayashi wrote:
> > Update devicetree sources for UniPhier armv8 SoCs to remove dtschema
> > warnings, add support existing features that haven't yet been
> > described, and replace constants with macros.
>
> If there is nothing wrong with this series and armv7 DT series,
> I'd like to make a pull request.
> If the request is late, carry it over to the next version.
>
> How about that?

The timing is not great, as normal updates should get merged as parts
of the normal
pull requests, which I have already sent.

A lot of the changes can be considered bugfixes, and I would still
merge them if you
think they are harmless and can fix things. In this case, also mark them as
'Cc: stable@vger.kernel.org' to be backported into lts kernels. Anything that
does not qualify as a bugfix should now go into the 5.21 merge window.

Please send the bugfix pull request as soon as you can so we can merge that
early. The other updates should be rebased onto v5.20-rc1 once that is
released in about two weeks.

        Arnd
