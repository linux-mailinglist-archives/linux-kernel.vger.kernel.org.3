Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B75878FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiHBI2w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 Aug 2022 04:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHBI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:28:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E6275F6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:28:45 -0700 (PDT)
Received: from mail-ej1-f50.google.com ([209.85.218.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdevh-1njjdC2tyj-00ZeiT for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022
 10:28:43 +0200
Received: by mail-ej1-f50.google.com with SMTP id i14so5922052ejg.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:28:43 -0700 (PDT)
X-Gm-Message-State: AJIora+JVZ2o+GRymj6UA2/eR+PzEveFae5lmwo/FNSFe+P+EhvMwRrJ
        dbLkV8rmFzTVtwv7MF7rAwnLMVXE2pUFuwsRo7Q=
X-Google-Smtp-Source: AGRyM1sBgrA1UdcarZllVCRo42OFkmI9ilCikiNnJYMZ6OZZnO0W1vtMDHkMoPHBQLfE86HembsdnedooK68PmLoDLU=
X-Received: by 2002:a17:906:dc89:b0:72f:1d4f:cea8 with SMTP id
 cs9-20020a170906dc8900b0072f1d4fcea8mr15821217ejc.654.1659428923342; Tue, 02
 Aug 2022 01:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220722090929.mwhmxxdd7yioxqpz@pali> <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
 <20220723150702.jecerkhxhy65dgww@pali> <875yjld2oe.fsf@mpe.ellerman.id.au>
 <20220725125256.cg6su4d2ageylvp6@pali> <e2487668-b6d9-9ddb-1bb4-9f4d37fae1a7@csgroup.eu>
 <20220725201009.gwuchzswcqaxntrk@pali> <20220725215416.GV25951@gate.crashing.org>
 <20220726083406.tcjvny6d2di6q7ar@pali> <CAK8P3a2iM+RoySWEC2e0==rwBSVrZoRa8c4ADyFNB24JZM=hkw@mail.gmail.com>
 <20220726134405.GX25951@gate.crashing.org> <7e7feffd-1f22-83bf-1c74-4ec48d973514@csgroup.eu>
In-Reply-To: <7e7feffd-1f22-83bf-1c74-4ec48d973514@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Aug 2022 10:28:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0GFeWY-SuXsbP9z8CZa_8tL9FT+8Xx=VVUA2KhdTT6gA@mail.gmail.com>
Message-ID: <CAK8P3a0GFeWY-SuXsbP9z8CZa_8tL9FT+8Xx=VVUA2KhdTT6gA@mail.gmail.com>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:qSgu8G8+TlTjN0+hOvpIF78yXmTc5lqXBs1ckY1eE3tw11Os0mO
 qOTrEKdEXsggcZ+Pj0vIzPMdMxQ62FsoxFGNZNxK8wgM/0P3TG2CHekcS8WJuDL9240zKaB
 FRU5iw2h/52rrJdIltJEK8nCTvHf2PJE835fdC5Z6DaEQO9fznU5vDogkYRpZhgAWX0VnW8
 2cRlQ2d1YtxFQenboP6Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4z4Jbkwx1u0=:65G5PUh18Zn0zCAlQXhsb8
 t5xlaw8mCew9Zu90F4We56Arf52a95L14QVtj4mtWuHENYh7ABUD8kepC4Z6d7GvTBpSWPnVI
 JHbxeDZKFkHTkNMQPCLmqxNq4VIAnzvTuvojxuESRxD2+mok3JN+mzYpsBAmIpGLTmhuKSzIq
 SyhtMOy1uq39WNoDTZYOKof1VKXklixeLGtW8okXtJeM8pGrrxGbh/ETQo+JqS2k0EKPUK7mW
 ZQ7Cj3Me927OWGjHkqc5LF62WamFN3sRsmuNk87gQ62OpeiqPHnVHH40sOwYOh80JfUOtLhuq
 tcUxtP6GrfJ8KI7ZnGYlSIDmd2mJ5E/E0T7XPfALkF2NXFmCiDbLQsPS5QXeMTw7z8pT8hluj
 gi6YgJ428hkxN8HNd6Q0AXa0ItXdGU4NuAY4Mg96pxMv6O0JPSRi/gTYcEdFhChsWkMrBLUWJ
 tGY2XcSfsR2wUX22voGlelBV5pTRECax1bTapQ/+jH+7ccktAcVZcLi17/QimBxiemh5yT496
 tCeaCvp0g/T/X6lGVjn8EgJoz0/VDl9JOuDw90GdHosiJTob2YtrWjeKtSVrXOxrWyzeooBR9
 zoOS5SflCqHXUK5dQKP5pAO0T0IyIznJBh4tpJIAEeclRc2iDwaFEAMyodEVnYK3Q1Wd/L6SL
 tw9Df9CYbJjLPML1syPM6hi8qlEueyaYrRDLLWqo7ukzMpgNmIs4wGuSWG67ljwERyElF2ouY
 Tsbbjt0+GJRZfhCYwJpDvqW5zS5NMre0V1S1RWgz9xp3uqgiVXorYg1HIvLe2v6q0/iECKuEa
 pYAl7aetFbAMG7WSbZZbyZGp3awptVQJovRh4uyoUpRTJS14gw/WMxXlJSsH+BsEUvfMJgOBl
 TSmAreEv2tL7uvzyZYaA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 8:47 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 26/07/2022 à 15:44, Segher Boessenkool a écrit :
> > Whoops :-)  We need fixes for processor implementation bugs all the
> > time of course, but this is a massive *design* bug.  I'm surprised this
> > CPU still works as well as it does!
>
> "Programming Environments Manual for 32-Bit Implementations of the
> PowerPC™ Architecture" §4.1.2.2.2 says: "Invalid forms result when a bit
> or operand is coded incorrectly, for example, or when a reserved bit
> (shown as ‘0’) is coded as ‘1’."
> >
> > Also people using an SMP kernel on older cores should see the problem,
> > no?  Or is that patched out?  Or does this use case never happen :-)

It doesn't get patched out, I think it's just not a combination that anyone
tests on. The few defconfig files for SMP 85xx tend to be e500mc (which
is incompatible with the older cores).

> Maybe unlike e500, older cores ignore the EH bit and don't mind when
> it's set to 1 ?

Pretty sure this is the case. My interpretation is that Freescale and IBM
just interpreted the spec differently at the time and were not even aware
of the difference until it was too late.

        Arnd
