Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6F51849E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiECM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiECM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:56:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D0A1EEE1;
        Tue,  3 May 2022 05:53:00 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mo6zF-1oATOS0uOB-00pc0n; Tue, 03 May 2022 14:52:59 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2f16645872fso178250027b3.4;
        Tue, 03 May 2022 05:52:58 -0700 (PDT)
X-Gm-Message-State: AOAM531lrOcqaPKF3QUmTrFCc7E4OZRtgXT1CF/8myugN+srZh06H0Tw
        T3YCLusH6gNw2r2w+QcW3+HAdPGaR4l8e+Zq69s=
X-Google-Smtp-Source: ABdhPJyv1laW6E185MTLjPzEFveupItqW/H+SSTMlTqCVUIee6w3ZqqHo0k5z6EM5wkvOIryiG8mHw/gvMCwhJyPJWk=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr15626133ywk.209.1651582377937; Tue, 03
 May 2022 05:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220421151055.6851-1-takayoshi.shimamoto.360@gmail.com>
In-Reply-To: <20220421151055.6851-1-takayoshi.shimamoto.360@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 14:52:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2pc5nUpGr_KQdhFZPm+vm5SfAzyUEy0=P3FVhfhdbNUQ@mail.gmail.com>
Message-ID: <CAK8P3a2pc5nUpGr_KQdhFZPm+vm5SfAzyUEy0=P3FVhfhdbNUQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add DT for WZR-1166DHP,DHP2
To:     SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UUz7elM+auAsRowC7ROfRfxccth75nPAVzGQ1wn0r5L/IY3OB41
 Xc8JK+/rHEf/lS6gNTmVTnZFvTtX9LLNgfVuXy/CICydWqrcEbq1oqOT3/AMyvOWVy8um0T
 vEOPvMNglkvi96oJKBoRMCgVvd0hVKIAiXQbjZHcX+00s5cgH+kC97ZpwHfqzuyc5TWVI5a
 B7fHgyqFo+QQ3imFUczUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AzyEmZ610OA=:AKIGkURKteUJ5cbywAANXG
 K2GiM89LZoSy/zAWY5C/wS3SP+1gAoLgpTqqHa7+Lmoyxom3+VKc3A6IqM86WI96tG+vqrttD
 yKxagz70iqn9a8KtOUZjw0JgDTShy07n6mwxuxZulanmE0Z9L9bWLR5yoYup8SircTDYL5J7e
 m/teKOg1WHT3FgjaXDWerXDqITEwSjmdYO0vPE4EsM1g0IrCZ3FVQcA6yb7vT8Qh2vOgutNE9
 mwaQGP3Xh6Usy8wiFONAmrz3pi0LI8uxgt+FNmM1k5x2qTET6eM7tJOdxCmZGdQX65d013rKq
 X/7TuiSsBrluXG/bl/vVV281fYzuFvvWbS3l4TouLY8q/AQiXzJtSeCmj0zK994HTtZLIdF5X
 afVwKol5roweJep8naybXlEqsPczol3C4Vy0/EozrRsyJ6wla4WYylRUciOrnqszh/q/qJUb6
 aQhfreJvix4RAczUR/ZtGW8cdiyDqeevmiKhhFYZnAmfZ1FvK89mDqVvl7crLLfK79mTNawZb
 5kDLwUDzP4q+sQCzJXCZHY/megTgIHY7oviq4g4IIuYZ5qUYbeheXTZNo5pPgT3V/n0oTpF93
 f1Wd6IM4uYH/axg1pjrntg7WtMiCA4OPLsQdUc50WC4hw/N4AuKeEi2pXRX7MiUbrlEW/t1hY
 3s+Wv7wH0cHBrAZmKPJdDUlVbq76Lwz1f3tfoED2NdKDKehc3M4R1Gk52VVclezjkzhU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 5:10 PM SHIMAMOTO Takayoshi
<takayoshi.shimamoto.360@gmail.com> wrote:
>
>   Buffalo WZR-1166DHP/WZR-1166DHP2  wireless router with
>
>     - BCM4708A0
>     - 128MiB NAND flash
>     - 2T2R 11ac/a/b/g/n Wi-Fi
>     - 4x 10/100/1000M ethernet switch
>     - 1x USB 3.0 port
>
>   WZR-1166DHP and WZR-1166DHP2 have different memory capacity.
>
>   WZR-1166DHP
>     - 512 MiB DDR2 SDRAM
>
>   WZR-1166DHP2
>     - 256 MiB DDR2 SDRAM
>
>   These hardware components are very similar to the WZR-1750DHP
>    except for the number of antennas.
>
> Signed-off-by: SHIMAMOTO Takayoshi <takayoshi.shimamoto.360@gmail.com>

This looks ok to me, I expect that Florian will be able to apply this in the
Broadcom tree if he hasn't already. Note: there is no need to Cc the
soc@kernel.org address on dts file submissions, this is only necessary
if you want me to pick it up directly, e.g. for platforms without an active
maintainer, or when changes need to go across multiple platforms.

       Arnd
