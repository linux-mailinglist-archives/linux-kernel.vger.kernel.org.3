Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC157563D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiGNUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiGNUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:15:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081F6557F;
        Thu, 14 Jul 2022 13:15:35 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFshF-1oKYMU2kEp-00HQ2v; Thu, 14 Jul 2022 22:15:33 +0200
Received: by mail-yb1-f177.google.com with SMTP id h62so5097402ybb.11;
        Thu, 14 Jul 2022 13:15:33 -0700 (PDT)
X-Gm-Message-State: AJIora/BINgNX64wIUafwdXg1rhwoOf30LbcZ5PAXg79D49u1OK2Bo4o
        +QGiONoTzHIbmiv0NFAHPXxqbB6cK61Uz8hz0Vo=
X-Google-Smtp-Source: AGRyM1ufLR1tXyfyrelM5ysCbbKNSHqOWqFASMdGq5/rYwOY4jOjwUqmCRVpkzIQCCqnubMWRWU8c8ZFrp1nxf+t2A0=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr11089451ybu.134.1657829732313; Thu, 14
 Jul 2022 13:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
 <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com> <YtBazSo/uJzFeF+L@pdel-mbp>
In-Reply-To: <YtBazSo/uJzFeF+L@pdel-mbp>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 22:15:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
Message-ID: <CAK8P3a1juHV6N2QtXaEcobWs6kQHBqqUn9MynvobyJtFFyOsfg@mail.gmail.com>
Subject: Re: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
To:     peter@pjd.dev
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Logananth Sundararaj <logananth13.hcl@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        naveen.mosess@hcl.com, thangavel.k@hcl.com,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
        garnermic@gmail.com, velumanit@hcl.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Nu50+VBE79L6k1vh34hmrBXE9wSXTcHVoQJ6lIPbEFsaLz13Egj
 OTtVtT8MOTeBK1hMNyppZXptNJYn6VXfIQCpNd/iL6efAIQD1wWNRDFS8vqeyrTModqsG7m
 IAgHBI0hPVj29kJiyLm/PVadhJXF+EGzYejq2GhH5vpZqITcQ9FgoBNOnp7fqX2kUN0MmhF
 2ZwAFUrjLx4QWfTlVu9+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f9095GWY8sI=:mBXABKAJd064BthSr6UF9f
 ETANIRubUtVpEZVw9b/XytQfpysPOvG8cFjxFj4LyrYoyjaAV7AvHOpSX8/xM/s0UMITtzMCn
 hJPQtVAPXERFbkX6sC+yTHNCcaENv7x7cUdvYRCM/nOU/CRBPFzRGMxJyn94CPph0Ml3wv+ER
 4G/xVezp0boYqYMkT9qC6Z/z90wc5odUeeA/TCeMIsede7ghSWVWybdwp4ShiSWlVwLx4IRBW
 UMXx7IpXeE2FU/FbIdzg7c5jzvhqqtF6bpLt7z7a12zFo/ggbbpnOb+gBA1ivmAsaCOCNaIr8
 FtGWmCvyC5P8K1zYqKYY0opH1GBnUGqanhdjt+0RshKG8YmnSrTilNYgrYbY1UuAP6FlIEcIJ
 HvE9aSnVrzrsGjqKfuFB68q/YMYvbR/alD5vFSeoijLjRen2S0ziwA6cghgVAhIYfUASeonnx
 H3NMhORxGjhBI6eN+vgqSj57zceGCQT3CfUXLsphq8z9Fko23t3lSdojgo1S7o7/OSJ5m1vFd
 +mrzv/Zcc2jSfLy+BYJGmNSZxjNdkTw5DWU0u+FBONUyk3GLK8YnM8SPlkbthLLGxJU+D4KMM
 EGaZ0K1D4VnEJteivpTNoYPtdyTp5upaoIFW6sfKF3YMsStAi9knwVw2hXv1Xtd+K16+WITS3
 aGgqiWi59yU8MLv/fMD7xVVOmCyUbDjDRkyZAQtMhRBZR3Rqq0P29TXWloCOWUfQOgt94rJk8
 sQdYkgfuYx23kqfT/hjggoUDXHVF1hymYE/68g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 8:05 PM Peter Delevoryas <peter@pjd.dev> wrote:
> On Thu, Jul 07, 2022 at 03:33:48PM +0200, Arnd Bergmann wrote:
> > > +       model = "Facebook fby35";
> > > +       compatible = "facebook,fby35", "aspeed,ast2600";
> > > +
> > > +       aliases {
> > > +               serial4 = &uart5;
> > > +       };
> >
> > Why not start at serial0 here?
>
> Hey, Facebook person jumping in here (using a personal email):
>
> I think you're right, it should be like this:
>
>         aliases {
>                 serial0 = &uart5;
>                 serial1 = &uart1;
>                 serial2 = &uart2;
>                 serial3 = &uart3;
>                 serial4 = &uart4;
>         };

Are you actually using all five uarts though?

> > > +       chosen {
> > > +               stdout-path = &uart5;
> > > +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> > > +       };
>
> Also: if we do serial0 = &uart5, it should be console=ttyS0, not ttyS4.
>
> >
> > The bootargs should really come from the boot loader.
>
> What if we want to boot the kernel by itself with QEMU? It's kinda annoying to
> have to specify '-append "console=ttyS0,57600n8...' everytime, or to have to use
> a wrapper script. But, it's also a source of bugs: I realized yesterday the
> dts we were using here:
>
> https://github.com/facebook/openbmc-linux/blob/e26c76992e0761d9e440ff514538009384c094b4/arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts
>
> Has the wrong console setting.

You can encode the uart settings like

           stdout-path = "serial0:115200n8"

the rest really should be passed on the command line, not in
the DT shipped with the kernel.

        Arnd
