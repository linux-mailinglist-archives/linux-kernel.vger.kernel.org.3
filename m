Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4DA5A10A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241813AbiHYMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiHYMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:35:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031A52B60E;
        Thu, 25 Aug 2022 05:35:49 -0700 (PDT)
Received: from mail-ej1-f52.google.com ([209.85.218.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIdNt-1oczuz0kQn-00EhZG; Thu, 25 Aug 2022 14:35:48 +0200
Received: by mail-ej1-f52.google.com with SMTP id u15so30577386ejt.6;
        Thu, 25 Aug 2022 05:35:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo0BY3XN+xnZnI1GU0F9C2kCOeSy1f8zTwkgqo3BzBNOEOy3DUEd
        UtJ7I0jXXmWCJ4Wc35Wx0rgKe7O5MN+ZW8z4M9I=
X-Google-Smtp-Source: AA6agR7fgaLb9s7H5/Li4IutxFIzar492nAzVxOsAVeMPK8zWfEAvRnEz1Shj5SNAoM6ETiorM4CGcoYPkDi98xLJSQ=
X-Received: by 2002:a17:906:8458:b0:73d:d0e9:4b27 with SMTP id
 e24-20020a170906845800b0073dd0e94b27mr1897590ejy.766.1661430947749; Thu, 25
 Aug 2022 05:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-3-quan@os.amperecomputing.com> <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
 <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com> <673e200f-f458-7866-f956-3d5bd7160a49@os.amperecomputing.com>
In-Reply-To: <673e200f-f458-7866-f956-3d5bd7160a49@os.amperecomputing.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 25 Aug 2022 14:35:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3MU7shuBpcpRNC5L6xxQmSy8FXCX1jvYXhv-NT3PMYOw@mail.gmail.com>
Message-ID: <CAK8P3a3MU7shuBpcpRNC5L6xxQmSy8FXCX1jvYXhv-NT3PMYOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        openbmc@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CMx3gnZOfz+oDvuTsUhIquf2PXorwNr3JkTa0/7BR95mHqAIkcq
 I6ZDIYVJpxn3ngQ72l0iAwzTo4ln9hb2ugHXtGvm7xaKvz3FiyDd4UVqSAdzh6RX1khxI57
 qKyR+5n+zpZt5xN+fpFHZ1OujZGVjDPwsTH3PNTi/+r4aD9EPi7yo1K5Clw3lv0LE1PItBF
 oKtzFo6SL0RTMDpg9C0mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B7MQp7YNmHc=:cjPQDaSoBcrhHusXDe8mFM
 sDcViBtPZISPyQ8sqtdIchhgUfIqr8xoB/p7KXZXsRyf4Y56tepbGf1cqDJ6mtcR3qtpiA5E2
 rFOglaHtLTyni7z7deGBebZjaas/cKs1mHm/E+se57nUlgqp5Esyh4plplAnmz2cKeeqovdme
 l0Z+/TACPRRAOK+1wj+nzX4pRYAZlkRxVNhp1LzMXdQbtP/fqjUZK7pBZ8BbJgzfnqy9Rb9h5
 FZstQKNkaMX3Pr5Bp3wN1GV/zIU7h6LjWYi2oYBO4KkycbNy9EzCVWI9VfWFpOXV2MJvm5kCB
 PeifqGecbxcyYQ6CT6W31+ATr9/DBrAzhsTlveiq7HdSjQOciPys3JZ2gUpqscc2i492jXnUn
 CywzI0fn7p7CyQjBW82cqybxg9u46g3kldSsYvyap1raqkeHFjPXEEt9GDG5SY7vGTeL8LAuQ
 d8HSU675TJ51FRwlatsEybJMxCO5WPzHM/0s0BvxqrlFOmGKMFXoaezWT8DqrFhNUnFgTeOA3
 5cNdqoCiB+V3eq80DmH0Tdqnd3ZD7wDbJmZCz/Wd5FRaeMYP9n51tkMsZ1P8hxfTsesm1UZhR
 ucNWjbKI+NpXBh3YXNAM4giwwYY/HQgA4jjKfe/dZRexNWtn92oobRip3j/YMnslfDwKjINdi
 riRgRqSfjPXHvxWBf8oPlJn9kiHTpoS4BsvOyLBTG3H5Mx4hfqnsoQu4VGoeKgcUdVwfYbD+a
 MAond/Z86Uji/bZGG4DkPP8HkzKQpgosKVUN764wqq+RFR2ypZtPf1Bok6LzZgSmn5F5mtuLe
 v2z1Em+V+94OtJwZRlylhwZFuSxaUYLXt3ayoOOBesfrTymStIeyFb9wP8eOR5clRpgCsDjup
 BEi5/brDnJQnAPR80uew==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 10:27 AM Quan Nguyen
<quan@os.amperecomputing.com> wrote:
> On 18/08/2022 19:06, Arnd Bergmann wrote:
>
> Thanks Arnd for the comment.
>
> I think adding -append could solve the issue.
>
> But as the bootargs still exist in all other
> arch/arm/boot/dts/aspeed-bmc-*.dts should we still keep bootargs for
> this dts?

I think it should still be removed. Only 238 of 2547 set the console using
bootargs, so that would make it more consistent with the other files.

Changing the files that have the same issue is a separate matter.

      Arnd
