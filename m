Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC257136F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiGLHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiGLHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:49:56 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C7F9A69E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:49:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220712074950epoutp02ac8a77bc2e144b5f9323c16f729c6f4e~BBYErI88X0639706397epoutp02G
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:49:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220712074950epoutp02ac8a77bc2e144b5f9323c16f729c6f4e~BBYErI88X0639706397epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657612190;
        bh=gEwQtqGECLpxEtA+sZ5ZleXsmdODF2JoJO1Frfr3CNc=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=YWad4Kbz6XMxZN0o40wKisHF9/5YSwazKdj80d56Zgh0v7Z9uk1UMvPb9SvyfGBiN
         hDzzDEu5hiJuO7X0w/4a4kBtTNUPLGhLYTv5lQZlwo90cbIOmF6w1nBi8pbv+c8IYf
         /YkbI4W+n7sdl5Xdshn1mLbOnrDpYqInztk4QtAM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220712074948epcas2p32cf6f101cd38338544e055f6f5bf0b9f~BBYDVfanC1502515025epcas2p3I;
        Tue, 12 Jul 2022 07:49:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.91]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LhtFS19wfz4x9Pv; Tue, 12 Jul
        2022 07:49:48 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.BF.09662.A972DC26; Tue, 12 Jul 2022 16:49:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220712074946epcas2p2de643084312b94a7ea0823d8900126e2~BBYBHjb8U3191331913epcas2p2l;
        Tue, 12 Jul 2022 07:49:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220712074946epsmtrp1802d5b2acc65aa54080235f4380aca0e~BBYBGzf993222332223epsmtrp1D;
        Tue, 12 Jul 2022 07:49:46 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-cd-62cd279aa7aa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.19.08905.A972DC26; Tue, 12 Jul 2022 16:49:46 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220712074946epsmtip1f70137a1ec650255499ad7f2518d72f1~BBYA5kqP21104611046epsmtip1S;
        Tue, 12 Jul 2022 07:49:46 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Youngmin Nam'" <youngmin.nam@samsung.com>
Cc:     "'John Stultz'" <jstultz@google.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        <hajun.sung@samsung.com>, <hosung0.kim@samsung.com>,
        <d7271.choe@samsung.com>
In-Reply-To: <CAK8P3a0pCov7ZiNhG+by7PpxMdBbBpUa7TKNc9e0p-zXvqg-7g@mail.gmail.com>
Subject: RE: [PATCH] time: remove useless "const" keyword in
 ns_to_kernel_old_timeval() and ns_to_timespec64()
Date:   Tue, 12 Jul 2022 16:49:46 +0900
Message-ID: <01a201d895c3$f4955ba0$ddc012e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJDeDvkkBXeDou4pRSMa+nAkmZkTQMAn7SBAeYw4mOsfV+nQA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmue4s9bNJBrvOWVv8nXSM3eLa3ons
        Fk37LzFbfL3+iN3iz4mNbBaXd81hs/h3bSOLxeZNU5ktFh/4xO7A6fH71yRGjwWbSj02repk
        83h37hy7R9+WVYwenzfJBbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAB2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswt
        Ls1L18tLLbEyNDAwMgUqTMjOOPO+g7XgI2fFm95XrA2MDRxdjJwcEgImEq3L+pm6GLk4hAR2
        MEoc2tzFCuF8YpTY8ugHO4TzjVHiy7nZjDAtCxfNgWrZyyix5O0pFgjnBaPE65ufmECq2AT0
        JV52bGMFsUUEQiQ+nf4C1sEs0MUkMffuPRaQBKdAoMT376vBbGGBAolZjxrZQGwWAVWJu5N/
        s4PYvAKWEl+OvGaFsAUlTs58AlbPLKAtsWzha2aIkxQkfj5dBrXMSWLl2/vMEDUiErM725hB
        FksILOSQONk7GaiZA8hxkVh0qxiiV1ji1fEt7BC2lMTL/jYou1hi6axPTBC9DYwSl7f9YoNI
        GEvMetbOCDKHWUBTYv0ufYiRyhJHbkGdxifRcfgvO0SYV6KjTQiiUV3iwPbpLBC2rET3nM+s
        ExiVZiF5bBaSx2YheWAWwq4FjCyrGMVSC4pz01OLjQpM4LGdnJ+7iRGcYLU8djDOfvtB7xAj
        EwfjIUYJDmYlEd4/Z08lCfGmJFZWpRblxxeV5qQWH2I0BQb1RGYp0eR8YIrPK4k3NLE0MDEz
        MzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXAZGjhoWmxSbXdQNRo047Lb1fHM+eo
        /tN4fG3yZMbtS+esWua3//RLyz/z0q/OESyK6vt88vw5rfmMshWzeKbumvPOL8DWqjzw0S/f
        Nj52loLjsvx3pp7ozxMpdVOdoxk8iyNkbcaHHVM3y86YNv0SJ/+5yqY9qxdpFjP7qzgWrV4u
        Ym1S897oWNuDqzEab+5umH7S+ful0nkWChPLpvHUCXqddX8p6Lbn1FELBtmi09OXli06paH4
        McPk4oT9azfaVr2e0HVGxchcuNTc9Pp1hgkXW++7tq6tsrntUHTvhadqsmlHWsCXq+a3c0XE
        lbnCotosplyN7nXubXdlYSxYa55W9Oolk4lzYMABxby7SizFGYmGWsxFxYkAyPNG2TkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO4s9bNJBj/O8ln8nXSM3eLa3ons
        Fk37LzFbfL3+iN3iz4mNbBaXd81hs/h3bSOLxeZNU5ktFh/4xO7A6fH71yRGjwWbSj02repk
        83h37hy7R9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGWsvdfFWPCOs+L1y1bWBsbv7F2MnBwS
        AiYSCxfNYepi5OIQEtjNKLFz+QkWiISsxLN3O6CKhCXutxxhhSh6xigxadpeZpAEm4C+xMuO
        bawgtohAiMS6OXuYQGxmgQlMEsdv6EA0XGWUePbhG9gkToFAie/fV4NtEBbIkzh55QgjiM0i
        oCpxd/JvsBpeAUuJL0des0LYghInZz5hgRiqLfH05lM4e9nC18wQ1ylI/Hy6DOoIJ4mVb+8z
        Q9SISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS
        83M3MYKjTUtzB+P2VR/0DjEycTAeYpTgYFYS4f1z9lSSEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUyC13OVSkuXCKXHl3gr5rN7WC4RUQ/Nr1miU/ji
        fXXmjnsO+xZtL7orK/Sne11k3Web5vNz4pYv8JJ9/Yc3/qyM1G/Hpg+TDlp+v7ltRWVAc4Fv
        uUrZD59nPpG/La9eZr0trJZse8/qk3iMgHzODvEU3biP5bG9yxdcYI/cr3XO/EJX9u4H0Y2a
        y120NGfG2gZ8sJp79HSk/EnumydmHFENMf3qpqNWVvFOlS3Icucjs3gD79yfDaG3yxhd71W5
        9izK2hZbuf1WQsm9r5enNoSybXK6U2aj+fpa/PK9b/+wsMzzVGSYcz7qy2Kmz4o66g/lf/j3
        NXi4TMoSNtUv1Bbh/6KocjRSkaFE2ltbiaU4I9FQi7moOBEATZmhqCUDAAA=
X-CMS-MailID: 20220712074946epcas2p2de643084312b94a7ea0823d8900126e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209
References: <CGME20220712071941epcas2p2faa87d8efe182e9c28a924ea3de15209@epcas2p2.samsung.com>
        <20220712074705.420399-1-youngmin.nam@samsung.com>
        <CAK8P3a0pCov7ZiNhG+by7PpxMdBbBpUa7TKNc9e0p-zXvqg-7g@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > As mentioned below,
> >
> https://lore.kernel.org/lkml/CAK8P3a3nknJgEDESGdJH91jMj6R_xydFqWASd8r5Bbe=
s
> dvMBgA=40mail.gmail.com/

I'm not sure why you drop my originality but please use my commit message a=
nd put this link between --- and include/linux/time32.h if you need additio=
nal comments.
https://lore.kernel.org/all/20220531064346.51677-1-chanho61.park=40samsung.=
com/T/

Indeed you should put Fixes tag for stable tree.

Best Regards,
Chanho Park

> >
> > The =22const=22 keyword is useless, so we drop it from the function
> definition and declaration.
> >
> > Change-Id: If35bba78aa7757476e22be42afc719c27fb0f527
> > Signed-off-by: Youngmin Nam <youngmin.nam=40samsung.com>
>=20
> The patch looks good, but the description can be improved:
>=20
> - drop the useless Change-Id field
> - move the URL into a 'Link: field'
> - wrap the lines to fit into the normal width of an email (under 80
> characters,
>   ideally 70)
> - explain why the change helps, rather than just stating the keyword is
> useless.
>   In your description, it's not clear if one is better than the other, it
> sounds
>   like it should make no difference.
>=20
> With that done:
>=20
> Reviewed-by: Arnd Bergmann <arnd=40arndb.de>

