Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E4E4A83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiCWBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiCWBea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:34:30 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7399
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:32:56 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220323013254epoutp03ef0aac814eee4810894413d4a05f6bf4~e3oR7sqqV0279802798epoutp03G
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:32:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220323013254epoutp03ef0aac814eee4810894413d4a05f6bf4~e3oR7sqqV0279802798epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647999174;
        bh=LgQSLT75+DUMGhM7hoYPhQN7NhaB4BUtmQGeP73ahco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2o/1037mJr6cbDEMRQIWbEQsDCbzBdFs9GflOwqGsNPIBmweKB8nBCUYZcJ149MG
         N9BDHbe7pFdfC2JeOq5OJmTxuBTvQB5XtuDVh/2/DIVQYwDDTxFFPvt+0LmwS7KICP
         xqFopgbdJPdajpYHqjcAsVh/LyzlEdQi43DPNp4k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220323013253epcas2p23426b56e21b85892285ec88ec588e6a6~e3oRU2IfD2005720057epcas2p2Q;
        Wed, 23 Mar 2022 01:32:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KNW7l4TsTz4x9QC; Wed, 23 Mar
        2022 01:32:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.8F.10444.1C87A326; Wed, 23 Mar 2022 10:32:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220323013249epcas2p375139160b6f653bb3d19153b47a4c796~e3oNE34eI1180511805epcas2p3r;
        Wed, 23 Mar 2022 01:32:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220323013249epsmtrp18cd6e2dadec88b8f1087f12657b062f8~e3oNEItQE2088120881epsmtrp1v;
        Wed, 23 Mar 2022 01:32:49 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-67-623a78c1a8bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.DC.03370.0C87A326; Wed, 23 Mar 2022 10:32:48 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323013248epsmtip27cf307613fb762d3ce533d4d7ddafc23~e3oM6tmQA0788507885epsmtip2u;
        Wed, 23 Mar 2022 01:32:48 +0000 (GMT)
Date:   Wed, 23 Mar 2022 10:31:30 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 0/4] support USB offload feature
Message-ID: <20220323013130.GB19041@ubuntu>
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdmSUqs+d3CuJ9px=vWPPdgP0scAZvKJkKDrs5O+sw6yA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmhe7BCqskgxPPpS2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz9r7oYixo5an4+Xo3WwPjJc4uRk4OCQETialv
        p7N0MXJxCAnsYJSY8nE3G4TziVFiz/pdTBDOZ0aJCfM+sHYxcoC17GmWgojvYpRYc/oHO4Tz
        hFHi9MxZbCBzWQRUJd7PfM8IYrMJaEnc+3GCGcQWEdCUuP73OytIA7PAYyaJjq63TCAJYQFz
        idlT+thBbF4BbYlTJxezQNiCEidnPmEB2cwpECjx55IyiCkqoCLx6mA9xAsLOSRmTTeFsF0k
        lm0+yQxhC0u8Or6FHcKWknjZ3wZlF0vs+tQK9piEQAOjROODE1ANxhKznrWD3cwskClxvWki
        I8TDyhJHbrFAhPkkOg7/ZYcI80p0tAlBdCpLTL88gRXClpQ4+Poc1EQPiWnN86HB85dJ4vK0
        bUwTGOVnIXlsFpJtELaOxILdn9hmAa1gFpCWWP6PA8LUlFi/S38BI+sqRrHUguLc9NRiowJD
        eFwn5+duYgSnWy3XHYyT337QO8TIxMF4iFGCg1lJhHfxB/MkId6UxMqq1KL8+KLSnNTiQ4ym
        wGiayCwlmpwPTPh5JfGGJpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtSi2D6mDg4pRqY
        9O+rcp5llHReNPOlSabyzrDfN3bVswZPD43MeHpmoZf3n4/zjaRuPqy42FvMWVsQ99wzMm6B
        8IY1AmVFd6bfWXLb7uBUX8+/4szyx848+Zde1dDRY5rZ6JZcq6emtOvDuzP6N45sW/M34+TG
        BcsWL1QWvO3LweviWOE2+9NV5Qn561nVA26cXLkpsT2pqr5KtP+y4eVnH5jnP2s+FPv6c7oA
        h4/2huVauUUmh9Td1qUXxM/z+SecXXrmTy+T748r4SvfJMSELDkxVWFmW9DJV2ns5+/pit35
        wuXTE/FIca71M5kjlmE52uFrnllE7709zyymoCL5liTjaufjGc+tfi39aryohY9pc9JtFfuz
        SizFGYmGWsxFxYkAKo6l+0AEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvO6BCqskg8kLrC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmv3i5kKzjEWbFpyh2W
        BsYV7F2MHBwSAiYSe5qluhi5OIQEdjBKvHk+hbGLkRMoLimxdO4NdghbWOJ+yxFWiKJHjBL/
        Jl5jAkmwCKhKvJ/5HqyBTUBL4t6PE8wgtoiApsT1v9/BGpgFnjJJHDt0EGySsIC5xOwpfWA2
        r4C2xKmTi1kgpjYyS2y994QVIiEocXLmExYQmxlo6o1/L5lATmUWkJZY/o8DxOQUCJT4c0kZ
        xBQVUJF4dbB+AqPgLCS9s5D0zkLoXcDIvIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cT
        IzhetLR2MO5Z9UHvECMTB+MhRgkOZiUR3sUfzJOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817o
        OhkvJJCeWJKanZpakFoEk2Xi4JRqYDpZrptqcEs6uLnGZJ7Z9FciBkrTIrY9rTKZEf7u7bpU
        Hd35zQ8+ZanbHtGOCPGYaNj+41lypadqp94954dayxZZhe/8vTerQkN5iafclqK/8tOnTbnL
        YHzjxKRVjFML34Wx7js3S4VFSeLNtLp1G9elPCsQPHdd7erZOauzV2n6eD86zVd8W/zW44Ti
        tgvG59PcKhbe/vn2kp3MsZyJtikOF/dMebRco2bxxqR9iobZ76fPbFM+PO/rphf93/I9Pu2S
        5I+8ovx9cvr/Y7+2fs3advDjpPVN4hOnmsU/cHj43+1pz6yv71XCQqp/19+xvSK81oA/PN92
        2gNTXv+M2H3Ls4xYcqffvTjtZWLHW7nvSizFGYmGWsxFxYkA1lPlsAYDAAA=
X-CMS-MailID: 20220323013249epcas2p375139160b6f653bb3d19153b47a4c796
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_237fad_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
        <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <YjhB7+AaEXvuUmdi@kroah.com> <20220321092409.GA62265@ubuntu>
        <YjhGKVKuPsKG80wZ@kroah.com> <20220321100631.GB62265@ubuntu>
        <YjhQg4I7eYWXIfgr@kroah.com>
        <CAJKOXPdmSUqs+d3CuJ9px=vWPPdgP0scAZvKJkKDrs5O+sw6yA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_237fad_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 22, 2022 at 06:05:49PM +0100, Krzysztof Kozlowski wrote:
> On Mon, 21 Mar 2022 at 11:16, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > >
> > > [v3, 0/4] add xhci-exynos driver
> > >
> > > This patchset is for support xhci-exynos driver....
> > > ....
> > >
> > >   usb: host: export symbols for xhci-exynos to use xhci hooks
> > >   usb: host: add xhci hooks for xhci-exynos
> > >   usb: host: add some to xhci overrides for xhci-exynos
> > >   usb: host: add xhci-exynos driver
> >
> > Yes, that makes much more sense.  What would you want to see if you had
> > to review such a series?
> 
> Unfortunately it might not make more sense, because last time
> xhci-exynos driver was a fake driver, not for submission. It did not
> compile, it did not work in mainline.
> 
xhci-exynos driver wasn't compiled on v1,v2 but can be compiled on v3 series.

> That driver was not even sent to proper mailing lists, as pointed out
> by get_maintainers.pl, maybe because it was not developed on the
> mainline kernel, so there is no MAINTAINERS file?

There's no MAINTAINERS file yet as you guess.

Best Regards,
Jung Daehwan

> 
> 
> Best regards,
> Krzysztof
> 


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_237fad_
Content-Type: text/plain; charset="utf-8"


------_7s4r-glDYfHz5mV2FGmC11V_HCNsCeqJGxaGPxgMNZjUkbW=_237fad_--
