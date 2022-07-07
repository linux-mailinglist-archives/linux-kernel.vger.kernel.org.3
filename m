Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC91D56A3BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiGGNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbiGGNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:34:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FDE1CFC4;
        Thu,  7 Jul 2022 06:34:08 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McpS0-1nZYrM3AEE-00Zzku; Thu, 07 Jul 2022 15:34:06 +0200
Received: by mail-yb1-f171.google.com with SMTP id i7so32518489ybe.11;
        Thu, 07 Jul 2022 06:34:06 -0700 (PDT)
X-Gm-Message-State: AJIora+EskzTZXtVd0fRmEneRTGVHGos1q2KEFvCT/HqBOu0hC4JaL1i
        tzELlgr6qEEpZNgv5IdlkJR6srMP5aUP7OEk9ig=
X-Google-Smtp-Source: AGRyM1uVpCRoROO6rAh+vA5ak8N4SGshcVRH0JW9GvyB4UqceUAu6tZ1eCC16Bwe+GMTjR8QSqM1egSeZk3ZR5FMhlQ=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr46624953ybc.480.1657200845543; Thu, 07
 Jul 2022 06:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
In-Reply-To: <20220707132054.GA10610@logan-ThinkPad-T14-Gen-1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 15:33:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
Message-ID: <CAK8P3a0P2u+LdXcU7As=dfNbg_J2eWfhgB9TT1-xVyH0v6OM5Q@mail.gmail.com>
Subject: Re: [PATCH v3] The Yosemite V3.5 is a facebook multi-node server
 platform that host four OCP server. The BMC in the Yosemite V3.5 platform
 based on AST2600 SoC.
To:     Logananth Sundararaj <logananth13.hcl@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        garnermic@gmail.com, thangavel.k@hcl.com, naveen.mosess@hcl.com,
        patrick@stwcx.xyz, velumanit@hcl.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ff4asemPkgpc3YgLJGPo+gGxHZPG4OGQORdlP3XswYqIxQVv9m5
 0JTGQNJ2vXX18oqbh1UGTJpZNS7riFtZ2v+dLDNrH1XkSXIkkrZfjaXSef5SWwU4FmY51zc
 3GCxzBjcuJHUr9Shbf0pQzQX42Ifs9oflNzlQicmSPfeJl0s+0C+B7Cw45CwTP6Q/orK5WH
 lw0Jab6s3K9H4OLj3s/XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/KuZVDTAKcg=:/JVMEnND1FLr9TIGB4Cros
 rvifjyuwXtp+vn/NIRnsBFxErQaE/gdqgeUqJSKBUlpjuRgY205s+U1Hb815t2Q0o4/nTqmiT
 NZV+yPoYTEMlNXe9o15lXVqvOjs5a2uv+qrnsweH4OFa2P0FUiNerE7HsWR6y+X4tUyu6w9eW
 IKsyrTwGAI/iW6KXNnqaxUSd9Aa5dHRAyAeAbbs+jhgwWAF6W4/gz528mXzPYgyjkB7VBvI1o
 yq0O10e7rhwfG+MxVUsNKggEHsAWE5nXLuncz25b23iWAm383L8XHVQJ4YzPtiksHBLolmu03
 ENr+paIkXos+N6FmJTrlxeiR3AGC1+cTTvEq2VklwwzcePw0hzneP+ulg0PmFUvkmzb70DvUb
 MPrbiH6xStbVRtaDmz+u3KFCfYXlhuqyMirFPwxmXDJIleBJkKhlrxVI5V6Id57XAyD3tW2AG
 aXMxBdY1lygzt+1y0guRKqntUyWvXEuD8YCxqVhplKoING+4UR+aNg+kzIR85/6TqRbNvYpre
 IcdSN3bTLUU9v3GqvolDwpuipiunR065ZKDjGrbBYb0nzpkmuL7xCwt3cvkohECbryGInELLm
 BFKk7ayfQjuEuhQEVlWTC1lRdtkkCZpadJlrB4Bx9z+i17xICwtntFN7no0mJ3KpzehhzbS02
 GLAFnRUwxDcSsblsXBn6g5ZKF7WcbKVVGPdw4VE2owZ0pwRLz2q/MCO3y8JDSkcjgtSVsf/wC
 qzPQ8/zIUpYqx4fBy69xYbbUuON4toLMywzKXs3PkjWjXEj3Qs60MFmvfKqUTPaPO1XJyI1gj
 NvM019vy+aEtKT4oC2kvE5C6fSV0g7673HlDqWW5W4G3EjwxFN/jtetVMknU9bHD0SRIt8Vzw
 0IHdQdM8x0+V0nouyjQ5R+UgyavmiupxWwt78PqdQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 3:20 PM Logananth Sundararaj
<logananth13.hcl@gmail.com> wrote:
>
> This patch adds linux device tree entry related to
> Yosemite V3.5 specific devices connected to BMC SoC.
>
> Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>


Something went wrong with the patch description, it looks like you dropped
the subject and sent the first paragraph as the subject instead.

> +/ {
> +       model = "Facebook fby35";
> +       compatible = "facebook,fby35", "aspeed,ast2600";
> +
> +       aliases {
> +               serial4 = &uart5;
> +       };

Why not start at serial0 here?

> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,57600n8 root=/dev/ram rw vmalloc=384M";
> +       };

The bootargs should really come from the boot loader.

Why do you need the vmalloc=384M? That seems excessive.

> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x80000000>;
> +       };

The memory location and size is usually also set by the boot loader

        Arnd
