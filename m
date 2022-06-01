Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A91753AE48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiFAUn5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Jun 2022 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiFAUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:43:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401C1DB1F9;
        Wed,  1 Jun 2022 13:25:36 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Ml3ym-1nX03Z0AV2-00lX9C; Wed, 01 Jun 2022 21:26:33 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-300628e76f3so29516767b3.12;
        Wed, 01 Jun 2022 12:26:32 -0700 (PDT)
X-Gm-Message-State: AOAM5323KY4YjOzYaTS7yWk0mvibF1G8urcieeLacxWOujJ0WNcBFaU4
        mBTtL13CaIYwEUDAJWFTCmK0UHhzZuJoWBwseYE=
X-Google-Smtp-Source: ABdhPJz0JApbo0Qv67wndhuM17KjFiRygdVF6IoIIcQ65oBNOgfkV7dKkoHQPvHnC/sJqYfjVswl/2RhIyt72lCR3vQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr1208726ywk.209.1654111591816; Wed, 01
 Jun 2022 12:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220601154647.80071-1-pan@semihalf.com>
In-Reply-To: <20220601154647.80071-1-pan@semihalf.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jun 2022 21:26:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2TXUd6JjSiXSZix1xL+bO-fVAbLWht-zNQV8r_Kn05Zg@mail.gmail.com>
Message-ID: <CAK8P3a2TXUd6JjSiXSZix1xL+bO-fVAbLWht-zNQV8r_Kn05Zg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add Chameleon v3 devicetree
To:     =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, amstan@chromium.org,
        upstream@semihalf.com, Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:zhaHhEGjIFru1VL46j0+tZGVaWHAQkcciH1GX2cZnvcAcHfn5M+
 Y+DCGLK6/9KjL7JM/R+qEU6PNETBlCWCFMRUwRdIsHzE4YI4OVCMBhDbKyeK60Ah5S9+Kyj
 3mgfAYbHE1dh6t94PWR6y7oPLEI4hxroOxyj5xz/nhLy0XN+wg21ltzB2Rr/mRVnOLtt2OH
 SztwIPBUDKVyb4odgF42g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qwpp7sOFPDg=:lS18uBZzeJ2sFdNI9fhC/y
 +w1OWV/C6BGT1peIMYlENFqXTnSZmLsi7khdAxeoQ2xHv1ySNVeDTicW6pglKhk+53jGjqHpM
 DoRHc3WfwrigUK9PmvaxfTU8m8mcPCivvDilzlqSuUMMXfiqR0nkbtreFjvAjr3+3pwNE3BNx
 aypmegiG69pabkgUTtxO+Ks/zRUgQHwXxSTTzSPUq9bwubR87C+0LSbMVfD/ISG5qqTj5E6yY
 rIMC7+FmKiy4A+y8bvMOtqFINPakAg5XtV1UZEL2E5tSjFi2rCEAdhJVIWc4Q+Ah7UIvRsBJ9
 47FbibD8A/0FGTQ/bL8Ac6iAtqsf9l0ozMCaoZtAdrJJPnvy6Eu4scBvsrGqqKOhyIQExRugZ
 iMsDZSiT097uVGMPbTLJM8mbSz/F3mucO2MJK2WAFn/+UaFV/XD4tXEHPCVXZFvWC/Muuugvr
 +JjQ4BmvQ998TGwNI4YoDGhxnSAA5S5hq4NPfThgmJnGrXJigTllD6nQDoVJdnS9n6O+rlzdv
 uFdiwXnOBMtFv+lgMqRxVtQreYbDVlLR4GUu+9AtznAwT58vrUVhq98BxFEVlZL7oihybDQja
 k0OsJ88BxZM4QlhPPH1qVpCXy71TCU9mOCCiMzjYmUflyFmaDbmry7cL1hhArb8Gv9ko45dpV
 iGYI2d7rLeq8pQxomYTuq5kpVYkdQ7zPoh0hv1ciZOmdFuSfKFmSujoINxSAcDcvnvSKdUf9G
 NPaRf4b0h55SDnofwwWGiAxdUihID5fKZluTHw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 5:46 PM Paweł Anikiel <pan@semihalf.com> wrote:
>
> The Google Chameleon v3 is a board made for testing both video and audio
> interfaces of external devices. It acts as a base board for the
> Mercury+ AA1 module.
>
> socfpga_arria10_mercury_aa1.dtsi and socfpga_arria10_chameleonv3.dts
> have also been sent to u-boot:
> https://lists.denx.de/pipermail/u-boot/2022-May/485107.html
> https://lists.denx.de/pipermail/u-boot/2022-May/485111.html

Hi Paweł,

The patches look ok to me, but I think you should be sending them to
Dinh Nguyen for merging through the socfpga tree instead of directly
going to soc@kernel.org.

      Arnd
