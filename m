Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4A4D8520
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiCNMf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiCNMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:34:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077691D0C0;
        Mon, 14 Mar 2022 05:32:42 -0700 (PDT)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MsZBb-1oHj3y0IhP-00txXw; Mon, 14 Mar 2022 13:32:41 +0100
Received: by mail-wr1-f47.google.com with SMTP id r10so23716488wrp.3;
        Mon, 14 Mar 2022 05:32:41 -0700 (PDT)
X-Gm-Message-State: AOAM532iDPmTogaBAEXkFjYhD7HLQRjB7xg4y6unFo/KQgLZAx/yC4yI
        njwgWDcCQ92vKa3kFg2CMG+ypjwooRjFFPhLL8U=
X-Google-Smtp-Source: ABdhPJxkFLmHM1om+Pm/EdZjlu/oHNDpfpDjWiz13UF+c79mJMkNbH3uFQXob/61v67y1ilq+j5Sa2dGjBYC2XD0inI=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17319150wrh.407.1647261160730; Mon, 14
 Mar 2022 05:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com> <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
 <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
 <4f39f086-1932-1729-8761-d5c533356812@mleia.com> <dc599cae-7245-73dc-8050-14ec6c1336b8@arm.com>
 <f497fb65-3568-cda2-f086-2275b50daf4b@mleia.com> <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
In-Reply-To: <faea4c0c-e20b-c043-6f74-95af8177e8bd@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Mar 2022 13:32:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1KLHwABtXwu-8Kg-GyKbETz1uRhdCz5edELOGG7JdaMg@mail.gmail.com>
Message-ID: <CAK8P3a1KLHwABtXwu-8Kg-GyKbETz1uRhdCz5edELOGG7JdaMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, Arnd Bergmann <arnd@arndb.de>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:BRidD3s+k4ddX6FhmA6r0KsG1DRPklEV0cUP5rL1bxizBW85MUG
 hAQEoY+ttglGkEf02F/7+FPXVxsS87loPbm3FiMgFVnrEgYLBn2gvMYg+HNuVL+ln6KZgyq
 P4bsBDfdfuun6O9a8qtG8+BESlBwJwD9sCsEshjjLWISbzswFed5NLB63lZy6iftvuQ6709
 XUp8VTe4L9n59J7gaaFtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WlnscOXg3k=:4A1f8uYndxT0vn2XHeEaBa
 9M4qC1XjUpWZbu6aNwzKSWSKeGVGHwwGPR2E06lNNMmb7FdxgC2opO+LsARCmR/u1uDuHXToP
 IeM3yImU2CPisHkk+X2ie+GxuH/hyo+uXZrPVf0p+tI3g/GLsZP9NlMMB6S1i4O3hQqqUNxVi
 e3D7O6sWwvuK/iwvjWlZCWas0y2Zd++oEY7SKwf/9NtmFeuup+XtW/0JYIaubNRTr1X6vRG7B
 D5m7NK8BPB3LLSzYHsDCLyXQh8AP9DBGY7vXgoNOTi3knaRCZVQVJbsb4u4vu4nBdP0gEJJ+W
 ZwVFhygNRY3cXKiub2FPRdLoIS7Ba9Ljg64O6xj+oTU1ElKzHkYXybRfZo4pIHVbpI7aWfDOd
 xwAZbndtOl5IVnDaAGpFYESn1JYU8Jfomw1iVCTSKcez57SOY0SgG1qtZX2RptVxYbSZiEc+o
 O+Pi6o6NKTLr66NDIGSrrCd9GMG05rP/B+Hp3DKJ8RzzzVVRSl/b3LRz+QBUinhAMZJEK/Soy
 pIueCUi0GzY0D9OKn8OxQncoyA5v4+ECf9ZcnejZCvQeUvH6SrkspLwd8UdrmvYpgp6ArQ8SY
 2kgiYIhLIAjDfPje3gO1nipB7QKLvb3Qbey/z+4hfNLztm1h9J7Qv1222P5GlPZvkuKDvypm7
 0ywFODZLlsNvuqmPZQ04wqIcITtITCY/JJEp5CYEuAceCmorP48/e4Q8L+usHGoZVXv8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 1:20 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-03-14 11:50, Vladimir Zapolskiy wrote:
> > On 3/14/22 1:43 PM, Robin Murphy wrote:

> >
> > Thank you, it explains, why "apb_pclk" is required for all PrimeCell
> > controllers on the SoC. Nevertheless, in commit 93898eb775e5 it was
> > misidentified with the sspclk clock, the latter one is the only clock
> > explicitly utilized by the driver in 2015 and till today. Fixes in dts
> > files should be preceded by a fix in the driver.
>
> There's nothing to fix in the driver, though. In fact it can only be
> working today because the Linux driver isn't very strict and simply
> assumes that the first clock entry is SSPCLK *without* considering its
> name (other consumers of the binding might be stricter; I don't know),
> and because presumably the HCLK happens to be enabled already anyway.
> Changing the driver behaviour would only stand to cause functional
> regressions.

We can change the driver to look for an sspclk by name first, and
then fall back to the first clk if none is found. This would be backwards
compatible and allow new dts files to have an arbitrary order, though
we still need to be careful about changing the existing dts files after
that, to avoid breaking older kernels.

       Arnd
