Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6694C6B57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiB1LyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiB1LyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:54:13 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C43878C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:53:33 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M89P1-1nL3ge49nn-005E81; Mon, 28 Feb 2022 12:53:32 +0100
Received: by mail-wr1-f44.google.com with SMTP id v21so15009772wrv.5;
        Mon, 28 Feb 2022 03:53:31 -0800 (PST)
X-Gm-Message-State: AOAM532jb4LvTK7tumPZFcgkY46yQq1hcseE2Lsi4sS+4kDPVtZ65BBg
        zc02auoftu0Fyc8K1/xnKA/thp9wlOLNGKikFpA=
X-Google-Smtp-Source: ABdhPJykAt6ihZgqOZKp9oNRnHFW4qiCzKkcVBlncurWtBDcvGWcAcmcw25G6Q51i8qymETmBLx0d9QsS0YF+zInvuE=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr13619242wro.317.1646049211645; Mon, 28
 Feb 2022 03:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20220228074547.3c0371cd@canb.auug.org.au>
In-Reply-To: <20220228074547.3c0371cd@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Feb 2022 12:53:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0VkTROBxO7mLSsiquY9E6A-Jy4dG3a=SbtgVMHEO6knQ@mail.gmail.com>
Message-ID: <CAK8P3a0VkTROBxO7mLSsiquY9E6A-Jy4dG3a=SbtgVMHEO6knQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Romain Perier <romain.perier@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UInjd2IomjEIWr2e3cQcCoUXpivGIEh0UT1Fuarjo/zxVauiyZ3
 7US2Yn5QdzsYgzfvB11e8m0IYHM2SGyi/ff7pr5NDiywKgXcug5wMh/bapOUe9qvfvDhouM
 4MY2gJguFDHItLjC9WrqBZWk177Gf+bFH2oKaLQrkpixgjL2GKDyn8FcvpPI+qWNAjUtUL6
 /P3u2H+sr57OD3a6e5PuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8+8uoTQ2+A=:5Ito98WN7E2IgNozHLT8Iq
 K3ySWzVFsTkNIHfxSd2GXykxl9yRLu22KNUZjd4dd9Czow1GaRxd2We9O6e064Zxa+7eXfcxm
 EJ0yFsI6fKY32hbVr32RvGN6IHvSvS8Oo7jXdKbdUtc8MjsTlAm/8VDYNN1ftA7QpP4wGtsrx
 hFdCDivn7uRyv9ziXr7Pf7phumnrHxvKel8tfqU5+1+voQjOBcLMBZqp3J7NySvrf+bADdw3F
 db51lffSDoJoHy58L2XreZdWNg9ckpI+CdXFu+dNQ726189Mn6xh1JyzZJRYyTOoVee5cyt4H
 xHscErNm42M6+CaaYaAtJrHSPR3smefg5X2fQbOsuSgT+uW8BKk3ePGL5xt0oW5jSxHfp60FI
 IB7zk8oxlTjS225FB7p5zzo6ud9HYcZ5hzjPDWKUtvHbKfaKjoDylXXntiDq4n5GTbXNhVuxm
 cWiGLbrtdaaAkVc3JtIUX6tH31Ns77K9VSTUJU/WIQF1OstsPfAWp/HW/IsPudjLQI5qQSX72
 ZIpq39dQt5kxPqJiMy3mskKyXY68s7ZK5OTcInjhJhZovuli40XnctpqIDP31J2dEFleCwRO8
 vHCxdrGFUGtzAbtKSASwgwTIZ5eEEgcOeLZ3bFy8XypKxJHBVMxIG5mOUuplX6I88duHuqjLS
 aIUSsHgpOtB2h4oUE+1qbm0Yk/YKScR4DPiKTbu5VzcQmrPRbCfVpxVcXTnzbCQJ8A4cgchk/
 bEezMe1U443h49PtJrlXvJWllQyTZScu2c8mG5fECx7h3eGG47+Qg8yiFpFiFHFqeh39WQ7aQ
 iem7TdVSlloC6kVlu9UlldFdrV1VmF+ws4A9Y6VfR3F7MQKQJ8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 9:45 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   4fcfd917c9eb ("ARM: mstar: Add OPP table for infinity3")
>   9affaa4ad7cc ("ARM: mstar: Add OPP table for infinity")
>   79f700c24b13 ("ARM: mstar: Link cpupll to second core")
>   62a2718bf4c2 ("ARM: mstar: Link cpupll to cpu")
>   6979b5fedb92 ("ARM: mstar: Add cpupll to base dtsi")
>   c952e5075de1 ("dt-bindings: clk: mstar msc313 cpupll binding description")
>
> are missing a Signed-off-by from their committer.

Thank you for the report. These are now far down in the history of
my arm/dt branch, so I don't want to rebase that any more.

I see these patches all have Daniel as author and Signoff, with Romain
providing a Reviewed-by and doing the actual commit. As both
Romain and Daniel are maintainers for this platform, my guess is that
Romain ended up rebasing the tree without adding a signoff.

        Arnd
