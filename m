Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF495520E74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiEJHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbiEJHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:12:16 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC52AC6FB;
        Tue, 10 May 2022 00:08:18 -0700 (PDT)
Received: from mail-yb1-f177.google.com ([209.85.219.177]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1fag-1nv9Y11NdY-0123Gc; Tue, 10 May 2022 09:08:17 +0200
Received: by mail-yb1-f177.google.com with SMTP id j2so29119964ybu.0;
        Tue, 10 May 2022 00:08:16 -0700 (PDT)
X-Gm-Message-State: AOAM532ylf6yHyeBsJKvV2LztCvkyKV3YsOQ/ShOQjJ+2PKvWx0qITuv
        AtiMAxGtKE6mNvFuap/IqIOv5kbWyIJCIBu96xg=
X-Google-Smtp-Source: ABdhPJxWna6rlyrTKaLzkGLXfLQ5G36EvqX7iK3snQCVCxZJEjl921KjovbWJOm/HvkmjLf51wP/GU+2IK3ZKdNeooU=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr16728943ybx.472.1652166495925; Tue, 10
 May 2022 00:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220510032558.10304-1-ychuang3@nuvoton.com>
In-Reply-To: <20220510032558.10304-1-ychuang3@nuvoton.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 09:07:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
Message-ID: <CAK8P3a1k8y8U99bBmqBYE1vYAc0q-UeaM0oLP4tTHZCpyYNOgA@mail.gmail.com>
Subject: Re: [PATCH V4 0/5] Add initial support for MA35D1 SoC
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ychuang570808@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, SoC Team <soc@kernel.org>,
        cfli0@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AfVDd0F7X2lkWYQBHKX3m/O5w1goVick1k2D/8QnsT2lZ76G6rl
 c3bztW6lGea6meDExjBavSFzRcQX7NRekcihf7PsWDQi6g6xi9iZf/zGBYbsXaHAX9kCWjp
 nTMOuSvUNCXgevEVk/lqVo+pLyGNzPVrt/fUILdJKjce1hjWZAtVsGriulv6A9yHmSr2HwA
 R9NqvJ7kDrrNhmEWx/pRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:soJ1UPUwGqA=:GOvMO455rTUxZPmYL0g3tt
 LKyZGFkdmK5Sy1bnjjo9B63HACyIlqGTIAcJ/g30MTl4adxNla4I55dywaLYW88cFNSluuLoA
 QAsgabz6a+Nkd/3HDRSRM1+Kv5JFDrput7MlWrPTG1tAYOwvenyjfZKt5s1H8CH4c0EKa9RuT
 EoBHQY8bx5VQcDofv3jg7bxihEzZr0GIKbZZ5lpyu38BWRrCyjik0rzFi0dSSEsLAWbeY9yxa
 1f7GUdAXo2h1604T2x++NXrcVAShyDUT8KH5FyZm9fktRZIw/c3W9k+6jM2AIscm/UmcKKsiP
 tF6+6Pgv5nYLOtTSjYvUHYa8XIarT/6rmy0WE3VHzVUAj/O9awxgAkNqFtudMMX1xiGWs/b5e
 ymy00fMwtMxi2qn0KdlU5I3AWbKl3WvxsE4DAOd5IetvFOqiC9hCjst7cbeQuu1htws1dBRZc
 TWSW1kGbkM60MQOQGF2QMRgz/MOkhSwtcxf9erYpua8ylyVSkIMfX1H0S/iUC0PPrG1P1X5eY
 PdMgR8SVZd8MgHUZKwLzCArcq3LTxTQOYe8cxxfozfW6o7ylkkTvCE88xlwVAvCisu7aBC11F
 8Ec9uXq+P+/gIprYA1yZUOgkVX2xLcyjGRPcGw5TXU+nVDNiq3PLjpvdHDKhWZOqw/6m/Zgig
 TKit7PqakpFD49yDtjLrjA6GfcaoPLOr+ngjLNq3+JvmKblBTZyGWUJCEPYw4Ta9lx33SmVOd
 4b93vLfGpXXZoep9YGCuru5c1ebS56oEdZBSkNr6oO6OSwTMgSI2MljGwqrFQFecTSrVmqo6Q
 rW45qrfMoc/CYG6Msf8EjMQaYKGykRbX3dN2pnfDQG2l/snbdk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:25 AM Jacky Huang <ychuang3@nuvoton.com> wrote:
>
> This patch series adds initial support for Nuvoton MA35D1 SoC,
> include initial dts and clock controller binding.
>

This looks fine in principle, but we are getting close to the merge window and
should finalize this quickly to make it into v5.19. I see that you don't have a
console device, as commented in the .dts patch. Normally I prefer merging
platforms only when there is at least rudimentary support for booting into
an initramfs with a serial console, but this is a flexible rule.

As with the changelog text for the .dts file, please explain in the [PATCH 0/5]
cover letter what the status is.

Regarding continued maintainership, we should discuss how you plan to
maintain this platform. In particular, there should be an entry in the
MAINTAINERS
file for the platform, either pointing to yourself, or adding it to the  NPCM or
WPCM450 entries if this chip is in the same family. Is this also a BMC
implementation, or is it something different?

       Arnd
