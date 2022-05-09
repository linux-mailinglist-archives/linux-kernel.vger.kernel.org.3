Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C151F54D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiEIH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiEIH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:26:40 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9B703D2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:22:04 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEC8L-1ngZji0Te1-00AIZs for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022
 09:22:03 +0200
Received: by mail-yb1-f179.google.com with SMTP id w187so23297482ybe.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:22:02 -0700 (PDT)
X-Gm-Message-State: AOAM530XdgEBVpcq6wTpawfxh6h32h1ec4lYKp9f6hGkA0WLzAwRiylu
        R5YrmAu3fkJsWlB+0LtfDuuVdRm2vF/92FuNWf0=
X-Google-Smtp-Source: ABdhPJxt4CASAW8ZKzj36LdTWe52+0XJ2aNG9pCduw1Eludcmsn3N95TuvRDw1YMXssIPezp/9tZ2HFgWN/aJHBsKsI=
X-Received: by 2002:a25:c50a:0:b0:647:b840:df2c with SMTP id
 v10-20020a25c50a000000b00647b840df2cmr11688150ybe.106.1652080921984; Mon, 09
 May 2022 00:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220509020222.1219813-1-starzhangzsd@gmail.com>
In-Reply-To: <20220509020222.1219813-1-starzhangzsd@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 May 2022 09:21:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a14LLfOs1YFnGj=1Qt_-kLQzg9_P1XgPRLZAC7OeWpCpA@mail.gmail.com>
Message-ID: <CAK8P3a14LLfOs1YFnGj=1Qt_-kLQzg9_P1XgPRLZAC7OeWpCpA@mail.gmail.com>
Subject: Re: [PATCH v2] pcmcia: add MIPS_DB1XXX dependence
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Mack <daniel@zonque.org>, zhangshida@kylinos.cn,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZBdTcJc0+COmio6i2ceMFGs7zaP2/zeIA4VQxnfJ3BZisDHx5eZ
 VMRkFGHH7uNuqL3PV2LJbqJ2Lvh4bn25yFJ5ZoTIofQqxFBc+9KPWDEkzFiG/Iqlribc6yh
 IBpgNwjyIBYdelGdcbWtgLAaWjKZhw7zI1peC+70ohwpAUvhSnw9joOAtpLvy141j/A80sP
 zN9OBk3+Qbrw+uhsLZBqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ks146LI0jp0=:N4Md6k+BciX5ZIQFd3F2x0
 vqzI67KhZdo7OW+1H1yEr8BfZHV7PbBTm/WeyOKH7esQwvV4kTwJ6YRpfh5SQJtUB8bmBqkco
 Tkyxxp9FlZRdcNeK/QPGzX8PFbzx+AZUdTnGKr6foTqD8HsL1nC7sK9DmUVSTMc9hWq4KlOv4
 YqP6HSol0NwvEd7VlUDDAXHa2cSXpHYO9UvjX0f7G90JUKHSXiQpJWBB6QiXf7RGpp22ZBpqm
 ENzoTfGIzN2whOrzZBKD7LHtig89Ro4iS6U6A7gFUe/7A3xAbGN1xQacg9QTqOfmfYRP6aXd6
 f/TBfB9PiszmhJ8jZI+9JUYiZRW2XPAQWqNvqWZ3vvPLS1p7PxgPh0cXIcPcn5ITCDi+Dqfun
 5UtVfe1hSV5IqafQ9ReuJjZQ7YpzwnAWx+8b0V32cz4gpLIgHWzQDfS+AqfEXgOs9ypsqM+Hw
 PgkWCRM7Kjh4Q0iyZhq+ntiHTYaBiGQuJwQ+ejo28e95ztJ9xOecLMAsiw6O84xB8ozsMrGMx
 EuKIT/U6qlDCLxYdJN0vqdXysXDOt06a1LjFIjiOMB8Rd4k27vqmEuqbfYbunJnoXZ1F8ozmE
 QU6KoCqOyYcP6dND1v/CVTzDvWchHHeHmA5vRXJu9tmJ8rPdsiDK0MyKnpVBMhqlVur/Vep1O
 tVS08ckjSC4/yXKUBaFOFppuU6e3IugB+HCYwA0LrGbg/mUuXSF5ChEQUqHyzgq2vDtEntTCi
 Uz9Y8N7+1rq21ULups15CsoYZeNt3wRXKemX4gxOd3RhXliwsp+dJC6cuKaPXySBwhOwG4mVv
 4iRQqlbjV58TuU6i3yXIvTB7gyL9cEEsmHSbywR1QBRzHOiEAs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 4:02 AM Stephen Zhang <starzhangzsd@gmail.com> wrote:
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> drivers/pcmcia/db1xxx_ss.c uses the bcsr_xxxx() from
> arch/mips/alchemy/devboards/bcsr.c, which causes a link
> error:
>
> drivers/pcmcia/db1xxx_ss.c:(.text+0x2b4): undefined reference to `bcsr_read'
> mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x2fc): undefined reference to `bcsr_read'
> drivers/pcmcia/db1xxx_ss.c:(.text+0x374): undefined reference to `bcsr_read'
> mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x380): undefined reference to `bcsr_read'
> drivers/pcmcia/db1xxx_ss.c:(.text+0x534): undefined reference to `bcsr_read'
> drivers/pcmcia/db1xxx_ss.c:(.text+0xcc8): undefined reference to `bcsr_mod'
>
>
> So add MIPS_DB1XXX dependence.
>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
