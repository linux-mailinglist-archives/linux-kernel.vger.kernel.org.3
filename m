Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB6521DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbiEJPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbiEJPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:13:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C9560D8A;
        Tue, 10 May 2022 07:48:05 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1q8m-1nmE9b2wTg-002GmE; Tue, 10 May 2022 16:42:59 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso182137287b3.5;
        Tue, 10 May 2022 07:42:59 -0700 (PDT)
X-Gm-Message-State: AOAM530FSQkAfD3GksMgAfQKJ8QmISIesRAaA6gDGKcnEOsIoQgIbDzT
        HedQ7Z/s/0EwdBpX8SHgGNFzKLLcJ2vDoby70aY=
X-Google-Smtp-Source: ABdhPJwxKQ6d9jt+Yv+entvJRKrKZC81R4C2ZX6MOezwKffIsRSzpa0gsgLnXqv21LvrFBjVwDYCHdd6/+Cbqv0pQEE=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr20662747ywf.347.1652193778427; Tue, 10
 May 2022 07:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220510094102.099d5e54@canb.auug.org.au> <5ca7ddc9-dfe6-a897-a0b7-09d04316cf28@linaro.org>
In-Reply-To: <5ca7ddc9-dfe6-a897-a0b7-09d04316cf28@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 16:42:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0N0EGGY7RQR2BBXk1RzUjRw9hwZmzYvKXjFb6M8kq3dw@mail.gmail.com>
Message-ID: <CAK8P3a0N0EGGY7RQR2BBXk1RzUjRw9hwZmzYvKXjFb6M8kq3dw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mvebu tree with the arm-soc tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R6Xm9aZBPlwyzKuCdFzoEYooqetSZqIaYT2iTFlpfhtiM6jQks8
 qJN1V3fA90nLiU06sEnnPLPZsGeQwi8wUROd+haLYI8GzeoBJnyDFqCx5LIIj9R+NN/5ww2
 4x1yDaxHvzoL/1a1OknZ5f2pQQm0hv0p8Hb/6zNEcL+4wV+nH3itWAJnJQVWf6GrUU71YaG
 msLmgpcvu1OLJyvIayAbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bsJ5p3zx7xU=:1qAoQCiLw33B/Ya6R62S9l
 PQfehRVmqyKAxu5BY8HOqbDNmwoEhQq7PCwCItkXUxeRTAdmTdFTChbC1jly5SN9/zgFl56BP
 A6u9UapKsOMiQcggiJQ+5DPYv3n57DH5mxMHyb8hCVLwToQGorK3w1RdZ+4vnhwnDIaIRoYUj
 CxmjafKAN5zkpYqtNp8GaLPX0P4dusH5QNfQ4Tv4+DEOhkZIvXKTx57SN0WXj1rZx5fhvlFCI
 TQw/aDd1lKCDIF3vDBakeo2vTTcrsaNA3bOXAbCXc7JQdXm/qYQhtmO5PxX7GP11kdOIOVH1/
 vZ5D1qY5cpFkcdUsX0sFVgK8j4zNFnKZ2+s5J7ZzuilUjcCV5t2R5CX80Udr6mEYjYr4vEoW2
 qegSeqGhxf19cTMcZJRbbTwHadgOtunzM5hsa6OR7xe1mSUe6KMdapjZV3l3+uLN/puHoGtQH
 QyrSERkvqFaltyiPs5e+WHAERVQG8GK6ylbhCRlszFzM1m7y2cPqe/1OFotsXJn9WAyjLGD1L
 ifbnTsdE7IAGak2Ct9U4XvSC+MFRFsCdbaU37IV+/ml+Q9fRchWc2yAzTe7XdfgzWQtZEC0DV
 KjRxP+npVObWi+d5RlCi6KxrcKQ6Qx8VnUXglZW1uCHTgrAjGUJrk/WUVW8nJPUXa0Qc13POG
 hqVtPeEn768cHmgl/+uybkQb7nz7+ioMkii1oQ9WRgA6k1CAeB4hwjIiLHRbXUTVAnQY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 3:59 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 10/05/2022 01:41, Stephen Rothwell wrote:
>
> This conflict will come to you when Gregory sends Marvel SoC pull request.
>
> The correct resolution is to take my commit 2f00bb4a69c7 ("arm64: dts:
> marvell: align SPI NOR node name with dtschema"), so the node name
> should be "flash", not "spi-flash".

Ok, thanks for the heads-up!

       Arnd
