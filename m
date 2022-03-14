Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDFF4D7FCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiCNK2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiCNK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:28:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E2434AC;
        Mon, 14 Mar 2022 03:27:23 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2E5Q-1o85pv1l0w-013hgA; Mon, 14 Mar 2022 11:27:21 +0100
Received: by mail-wr1-f41.google.com with SMTP id r10so23114352wrp.3;
        Mon, 14 Mar 2022 03:27:21 -0700 (PDT)
X-Gm-Message-State: AOAM533wi1wQFKz/jjWWoA7OIi+D1FVHiKPc6L98q8OBtKOPpvcimtkL
        NbM+B+UpI1VmRhW9zYjTFTJXrifH5mXi/liRfHs=
X-Google-Smtp-Source: ABdhPJzEqI1LonVZ6bGY0Zc5X1CtCNLufMa4XfGQ0mQSVCry0VjHQXsTUbzVOBx8Utrgu6D459mOK3Qcxj1FOdSYpI8=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr15782141wro.317.1647253641105; Mon, 14
 Mar 2022 03:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-2-singh.kuldeep87k@gmail.com> <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
 <20220314065434.GA43329@9a2d8922b8f1> <20220314073102.l6vokyookzyo76hj@vireshk-i7>
In-Reply-To: <20220314073102.l6vokyookzyo76hj@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 14 Mar 2022 11:27:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1Go8xiQG=BLBmqoQiVqwkcR+T8gi0WLijzVfa3A_WuKA@mail.gmail.com>
Message-ID: <CAK8P3a1Go8xiQG=BLBmqoQiVqwkcR+T8gi0WLijzVfa3A_WuKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t28q1Kl8p8y/OBfeV9ZIJ96sVsdvnyOLTTMw9weIAt2vbSH/DUv
 yL1LMMqmRs3xnHa17t1mulBn0ysPW3mUFsSQTFwLzWwmta2M4Jku2peA2D/XSbC/XVbitna
 Kw4eQIE2bJW69R7k1wcIMMae0tpvAMLU1vkmYAc4s4+issN27rM45N5XRNH3jObAisvV+EV
 aJc70dSYzCclOWoHPyAPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xeeq591h+34=:xxQi5QwfOEbLzqbQOb2f3V
 5WlpQ5tZ+s+yu9A0UoaQGV86rl8AKvomDSy1o9kojwOGrsXfYaA3TTh2A7OrHJRmw+S+YZUOH
 e1Y+2bBDS8l4pWOL72naVxOOeopUzd6Pg2tgYERAi1gNXAQDNWJE658Wz6W4EMAp7Qurq4X2d
 mKWVYcNtqXZhfgmPgP1BYc2Onww95DRevGecy5/HEzf68E2iOs/0NctrrWUlb9DxAnpxkl63l
 MZ3zPceTRYDECdRo78FwByz+tOswz5ALs00IkcsRWBVUdaAeSV3aYYEqOUJQ7N1VgYCZmmqcT
 0dZzRo8wry92g9Ejsmzgqkf1taILTvH4/TPe1J6fSpMHiARXKIOkBkuOYFkpB+p95Scj0L/U7
 pOEBrSJUAwoJc7ur9/SuDTWkIAZ16xHxUt02n1vCDdrFC7O7sM2nvBK7W/gHUOeEQkA6LsGBC
 K0Z1TphVLVL3gMGUzGKLFeTUptRjG5Ycc0EjPIwzb2DzneVnI+2o8Tl5sVLfrWIA20BpcZDsg
 zdfP5/7ar6ZV/qQq6He85v3pAUXB9Vt/6e1jnvCqJq50x5HFUiB5F+ntGqH2wVqDN/lDFxUoh
 jlMiL5T3rMBRcouoM//J5UlgRDhI5URj0ec96mLxh8a3lL8hBgbmGm8cv28Z/V/DJ+8wEqn2g
 PfY355G6A8Bpae+CDg6cyTsYjZuLFq7yxxoIQduv7NWwxouhP5+zIUGoCIQPGhAfSQuA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 8:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-03-22, 12:24, Kuldeep Singh wrote:
> > Dma-names order matters here.
> > As per pl022 binding, dma-names order specify rx,tx and all DTs which
> > have tx,rx as order start raising dtbs_chek warning. Thus, need to
> > reverse this order. Please note, no functional change in this patch
> > apart from just fixing warning.
> >
> > Warning:
> > 'rx' was expected
> > 'tx' was expected
>
> Hmm. I see your point now.
>
>   dma-names:
>     description:
>       There must be at least one channel named "tx" for transmit and named "rx"
>       for receive.
>     minItems: 2
>     maxItems: 32
>     additionalItems: true
>     items:
>       - const: rx
>       - const: tx
>
>
> I was expecting above to allow adding the items in any order, but
> looks like the order is fixed with this.

I don't think that it was meant to have a fixed order: unlike the other
bindings that define xxx-names properties, dmas require giving
names to allow the DT to specify more than one possible DMA
specifier for a given name. This means that nothing may ever just
rely on an index but has to use the name for lookup.

OTOH, while fixing the order in the binding does not add any
value, it's also harmless as this should never be able to break
anything that worked for any combination of old/new dtb and
kernel, and it's probably easier to express in the binding.

       Arnd
