Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981A4C7115
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiB1P6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiB1P6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:58:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6C61C11F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:57:51 -0800 (PST)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mlejs-1o75lX2fGk-00iitS; Mon, 28 Feb 2022 16:57:49 +0100
Received: by mail-wm1-f42.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2533810wmb.3;
        Mon, 28 Feb 2022 07:57:49 -0800 (PST)
X-Gm-Message-State: AOAM531l1YBEHnse++Jn6wdDuelDvTv7m0BqcBCBml49+CGttC0H3MhZ
        d5fMcYeZeEpr4b4ORHfWgeF561WYP1pLr0kvyik=
X-Google-Smtp-Source: ABdhPJwWO7JpZGQq+hYomYAuL8Jmwra1m177yHdVjT4LcY+LCSudgwemaoWEFE8W+L0d9PhzW8PLwjisjmxhpCV5Slc=
X-Received: by 2002:a05:600c:154b:b0:381:8148:64d with SMTP id
 f11-20020a05600c154b00b003818148064dmr607563wmg.98.1646063869351; Mon, 28 Feb
 2022 07:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20220301025101.7fb280fd@canb.auug.org.au>
In-Reply-To: <20220301025101.7fb280fd@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 16:57:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0+fGJniopx1q5OhY9zk-PNemcUZ2XXx-JWOLGdDwmu5A@mail.gmail.com>
Message-ID: <CAK8P3a0+fGJniopx1q5OhY9zk-PNemcUZ2XXx-JWOLGdDwmu5A@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <mail@conchuod.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ck/zoYCKU8CZmRgNR+kp5gcjeL3JEJr3m7MojCX3aWfkojGUGMK
 o5tSIBOGAXqa9e5zG2wj2y1O3HdANI7jeEtwFYiVz83xCp2xUGasBW0P8Sch3MdGcuj09K7
 olwgEYYW6JD6/V4C0D6WnQRMoBw6WoPIAWY/lbz23n1a+M+6Jq0wUvTiq7C90Z4mTnpU55p
 oteGyGJEn01FheCj9szDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmZXyb50Crw=:G3VplF78o/BtsRQOWtuS0x
 ujPapp0ztPVYF2hspPPb78BgiNa4yD7IySnFG2yTzyMVYkByLNC6iSD/TNRvMgQp8/HhGcCtO
 2Ysgz9GXjHwx310t/VQpzZ3LKJdFHm8+6zYP7CxGav9llrQXNqjOZGUO+5F/EWccAyDRciBvV
 pXa+ptXTUgXqdWoIfaeKMgqGlcxbpgWTpYzeqtCIMkox4oQEYLrEo4pa4xogMqumehGjiY6Ky
 gaZqprOdnl58YmnhgFJpbvGg4y7q11J+tEmSlYsg3mREXabJinxzLtP7pWdXxF4KDGYUZJ3x9
 6G26iq1MLpFF9TR85fkxyjOqnPth6lBZO0CgiYRRG6fYv6i+lUsgQIdRitWsoObsn38Yz/rG+
 Lm23xElWECzXfIQCldz3DKLKB528T4XrRfLmODclZCOXGy7ue/B0dkGFV0wiFrTg75q1urEg9
 FVeBCeFKOHhjDYVcBeEtOUeYxJnEaxN6d7IORCvrPHFvQKwO7BH+o5m5d84DWTqUBzP59HlTw
 NRCKDbAWvYSwMzv1wo/Oap/3uHY9LKSSXSDFRUy726YFR21nEyFT8jYJKM3CUrMMrYVXvamQv
 vqabeP/YyTJ8eu3m/5JjLwDDN5434yUwzjH+bBC8/umBSHOdNW6iABgXdBDDJMdQZZIyEexRQ
 qBVb7XVmCtOVCvigG6Z7BaqjLUGSR1FYIRnFKEiJ2ELsD8JcLm/q/hyR7Jc1Fh5ZEul5CydYu
 YYTEAXeLuv6J8/eKUqgAuD8VVPHlv6tAct8URHmQmJKXdFcIzfjkA9M+ACqZAI405em5owd5S
 0e9DdxTJLFYLTlLdZqeB9pRWXJLfsq84g8CSkSloSfJ2DXLIQY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 4:51 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   ed40a635b5ec ("soc: microchip: make mpfs_sys_controller_put static")
>
> Fixes tag
>
>   Fixes: dsafsdfd0054 ("soc: add microchip polarfire soc system controller")
>
> has these problem(s):
>
>   - No SHA1 recognised
>
> Maybe you meant
>
> Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")

Fixed, thanks!
