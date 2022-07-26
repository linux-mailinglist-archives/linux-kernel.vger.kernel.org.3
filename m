Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7C580947
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiGZCKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGZCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:10:02 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC02255A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 19:10:00 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220726020954epoutp0229c7fd1682f11b6cdc4ae35683dd8845~FPxRn7_rr0261402614epoutp02a
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:09:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220726020954epoutp0229c7fd1682f11b6cdc4ae35683dd8845~FPxRn7_rr0261402614epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658801394;
        bh=cJQgMnFowcNxtwMVYvUQBZ2CH//fIvn1D5UAmwoJmaY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=sqYtjLQQMPx0c2NhMyFAktjWAUjooYqzeArcLKHOBaKr0zhhT0QZEMs+jTur+hyrD
         lscEUajsMkNikdtyw5/k4dbRuJZHdBy4fVxOR23u9ROyIEHDC7SDz2wg31AzdtXqg6
         lO1gYXtLfsquGrv1Zr0NHi4lCRYywoz2rfIRaZig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220726020953epcas1p476e398b9a12ca681307b7825eb027d20~FPxQ7za8G1926919269epcas1p4p;
        Tue, 26 Jul 2022 02:09:53 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LsL2n1fD0z4x9Pt; Tue, 26 Jul
        2022 02:09:53 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-b0-62df4cf1eecf
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.B5.10203.1FC4FD26; Tue, 26 Jul 2022 11:09:53 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 0/9] Samsung Trinity NPU device driver
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Oded Gabbay <ogabbay@kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7@epcms1p5>
Date:   Tue, 26 Jul 2022 11:09:52 +0900
X-CMS-MailID: 20220726020952epcms1p59c06fabb55776e195dcbeac549c98ef7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTX/ejz/0kgw8P2C0ezNvGZvF30jF2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLPb1fGS0eD7tOosDh8fvX5MYPTat6mTzuHNtD5vH/rlr
        2D36tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
        ycUnQNctMwfoICWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpe
        XmqJlaGBgZEpUGFCdsa7Ja9YCs4wV5y9d4+5gfEjUxcjJ4eEgInE9E+rWLoYuTiEBHYwSvx6
        d5i5i5GDg1dAUOLvDmGQGmEBO4m125ewg9hCAkoSDTf3MUPE9SU6HmxjBLHZBHQltm64ywLS
        KiKgInFxqQnISGaBw0wSy5ffZYbYxSsxo/0pC4QtLbF9+VawXk6BQImH06ZB1YhK3Fz9lh3G
        fn9sPiOELSLReu8sVI2gxIOfuxlBdoHM+XlFH2SXhMBkRomTJ44zQjhzGCWmbXjHBtGgL3Fm
        7kkwm1fAV+Lv7EVgC1gEVIF+fAe1wEViQ8syMJtZQF5i+9s54HBgFtCUWL9LHyLMJ/Huaw8r
        zC875j2BhqGaxKHdS6BulpE4PX0h1J0eEjPWXmWEhNtzRolP14smMMrPQoTuLCTLZiEsW8DI
        vIpRLLWgODc9tdiwwAQeocn5uZsYwelRy2IH49y3H/QOMTJxMB5ilOBgVhLh7Uq7nSTEm5JY
        WZValB9fVJqTWnyI0RTozYnMUqLJ+cAEnVcSb2hiaWBiZmRsYmFoZqgkzts79XSikEB6Yklq
        dmpqQWoRTB8TB6dUAxP7qmgrlnU/1k7MD9TJOsEutDs902PN2UtHX5080nR9s9zjR908V4SL
        ntudrOnXY1rcHekpumEll9g5PeaXByJvCs+1TPPt87tnyBEnFMZTKW8bM/XW8cWdW97ckOpw
        0zv8klt7Pldq4+ZnOblFUwJOab8pL5hn/f2Y8KNXgr4ySQczRLJZNV4cDHMUUIl7Lv3K6vRH
        +a0sqxRD89UCazekqdxdu/rwHI8N5w8/PPuEv2Hm1qK4JdcFfPfwMkXMP3N1ZenlVzsfvng0
        efn+/UsiNopcU5BXYnH/5Bgxp3OVvuXLS0+qv3Mu+RBz1fny+r66i6sM4uI43iVsenbcJsBg
        UdUL+ftc82YUlbKrzElVYinOSDTUYi4qTgQAXFvRgBgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065308epcas1p2f6de3d74792854bb312cca4b310badac
References: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
        <20220725065308.2457024-1-jiho.chu@samsung.com> <Yt5cFBgiTLwGXv17@kroah.com>
        <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> Why isn't this submitted to soc/ subsystem ?
> Don't you think that would be more appropriate, given that this IP is
> integrated into application processors ?
>
> Thanks,
> Oded

This series (Trinity-V2.3, V2.4, A1, ..) is being integrated to multiple SoCs,
not limited to Samsung-designed chips (e.g., Exynos).
It's a bit weird to have them in /drivers/soc/samsung.

CC: Krzysztof and Alim (Samsung-SoC maintainers)

Cheers,
MyungJoo
