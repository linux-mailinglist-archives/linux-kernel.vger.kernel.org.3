Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D8A5129F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242167AbiD1DbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiD1Da5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:30:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6C633BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:27:44 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220428032742epoutp011490d7a0ee1320b9ed0db473c67f9b23~p8aywrqkr3132931329epoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:27:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220428032742epoutp011490d7a0ee1320b9ed0db473c67f9b23~p8aywrqkr3132931329epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651116462;
        bh=d6SVNnFvo7+6RGSSzXl4AonTFR8/xDVfvg13QxlkVto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ehZ1jTuL5jOdxezUuHsRAoTbCDthJ+jDQTNwHfGLS60sldtb3uVxXJBQf/oSjtdLo
         pk3sZv3aiml5fFxTYFrSytFxuIU/aWRvN78tn33FYDgyeTsBnROfn2sM3jnIVr2o88
         7xpEaT5dIAxKyy3X96/vixEFxJpz/HYcjnyUpYNY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220428032741epcas2p30a7ccf217830c8d3bbdbd8a487d5fa36~p8ayC0PNR1440814408epcas2p3Y;
        Thu, 28 Apr 2022 03:27:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Kpgzc2VHwz4x9Px; Thu, 28 Apr
        2022 03:27:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.7A.10069.CA90A626; Thu, 28 Apr 2022 12:27:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220428032739epcas2p4dd4eadf06717ca32dea6fcc3f2393fe6~p8awToEHt2397423974epcas2p4F;
        Thu, 28 Apr 2022 03:27:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428032739epsmtrp2bb173fc6b03f23042d9d8ffcabf91af1~p8awSlbSm1030510305epsmtrp2G;
        Thu, 28 Apr 2022 03:27:39 +0000 (GMT)
X-AuditID: b6c32a45-a79ff70000002755-12-626a09acc26c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.42.08924.BA90A626; Thu, 28 Apr 2022 12:27:39 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428032739epsmtip1bfb140d40e83c37a0ce2e0c047d7e253~p8awHZeIL2356723567epsmtip1O;
        Thu, 28 Apr 2022 03:27:39 +0000 (GMT)
Date:   Thu, 28 Apr 2022 12:26:10 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <20220428032610.GC151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmfHiEneCRlnJA3e@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmue4azqwkg/k/+S2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDxmNfSyeVzu62Xy
        WLCp1GPxnpdMHvvnrmH36NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZuy5vZCx4x1Wx7vhrtgbGFxxdjJwcEgImEtcf
        /GUGsYUEdjBKHLtb08XIBWR/YpQ4+/grC4TzmVFiUtsyRpiOk08fQSV2MUpMf7WQDaL9CaPE
        riM1IDaLgKrE9umfweJsAloS936cAFshImAs0X92FjtIM7PASyaJ9lsT2EESwgK2Er+27gTb
        wCugI9E85RkrhC0ocXLmExYQm1NAU2Li1QtAQzk4RAVUJF4drAeZIyEwl0Ni9b92JojrXCSe
        b93AAmELS7w6voUdwpaS+PxuLxuEXSyx61MrE0RzA6NE4wOI6ySArpv1rB3sCGaBDIlp5ztY
        QJZJCChLHLnFAhHmk+g4/JcdIswr0dEmBNGpLDH98gRWCFtS4uDrc1ATPSS+Pd3IBgmsb4wS
        X3ruME9glJ+F5LVZSLZB2DoSC3Z/YpsFtIJZQFpi+T8OCFNTYv0u/QWMrKsYxVILinPTU4uN
        CgzhkZ2cn7uJEZxwtVx3ME5++0HvECMTB+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosP
        MZoCI2ois5Rocj4w5eeVxBuaWBqYmJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCU
        amCaeTD//DNe1fWFyrHCC+snP1rSG7MiuDVQ4/XKwCX2Ns1zQ/vtI7IF/LZNKLgiFpy1TiLl
        vE2gpvrbva5iemZaBvez+E4ILPz0Rqtkotu8+LmaiZvKuc9tuRTVcSYoPsX7h4hX5V9PW48T
        /AGtS+b4mhjWSCR8s1hdEJZf3PZp3ZfOAzV/i3cKJLBwPZMzcU8xX+z9Wavq3hx1gTnqyz6W
        nZ1+ees5heb/EnfmqT64VfW6b0qx9tKZ75haTU13PwlSl1guuvP/1/Rfz4KsLd0OvVu1u2xd
        eY5N6caGdseGqtUhqx76eLnNO7a4gf/f1oXspkozsp7ofnjko39kj53y+UnvYvmlq2MFvzaF
        SCmxFGckGmoxFxUnAgDDA2/rQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnO5qzqwkg/5vGhZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6zGnrZPC739TJ5
        LNhU6rF4z0smj/1z17B79G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bthywF6zgqnu2ey9LA
        eJCti5GTQ0LAROLk00csXYxcHEICOxglZh1bC5WQlFg69wY7hC0scb/lCCtE0SNGiXWXfrCC
        JFgEVCW2T/8M1sAmoCVx78cJZhBbRMBYov/sLHaQBmaBt0wSm6Z8YAJJCAvYSvzaupMRxOYV
        0JFonvIMauo3oKnfZzFDJAQlTs58wgJiMwNNvfHvJVAzB5AtLbH8HwdImFNAU2Li1QtsIGFR
        ARWJVwfrJzAKzkLSPAtJ8yyE5gWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIj
        RktrB+OeVR/0DjEycTAeYpTgYFYS4f2yOyNJiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBiYmmycZdz9PPzV1dnDK76DqkB8Ly3pOpa0Wf22yevJcx3mf
        vM1nOT1J7zn2PevMv1s9ps0C1x4ee/U5fIPBhtSae+oGlRP3PPiVHqi/Pz26SXZ/27Qni4yi
        b0WcdUvsantUFMe/eZPnbvM7AZuDb1yLOTwv4Vq74/Hdt7dc/2qxerJf+lrfX/cLf6j2v/f6
        9VBbWYDF5O6nZvfbSlauH+UZbx289aFjB+/e6CMp8w55MKQvbt6dtyJ77vV7QWxfGz4Zt5rW
        TjPN/bbQw2AHR9u72L0Wvz089XduXCNysO23/23uzee+Gj3R4t/qVigf37BxgZe+dmLY09g4
        MzfT8JVvYvd5Sde9L/9Tf6c+Yb2BEktxRqKhFnNRcSIAYe2u1AcDAAA=
X-CMS-MailID: 20220428032739epcas2p4dd4eadf06717ca32dea6fcc3f2393fe6
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_2ed9d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <YmfHiEneCRlnJA3e@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_2ed9d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 12:20:56PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 06:18:48PM +0900, Daehwan Jung wrote:
> > This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > driver mainly and extends some functions by xhci hooks and overrides.
> > 
> > It supports USB Audio offload with Co-processor. It only cares DCBAA,
> > Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> > on specific address with xhci hooks. Co-processor could use them directly
> > without xhci driver after then.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/Kconfig       |   8 +
> >  drivers/usb/host/Makefile      |   1 +
> >  drivers/usb/host/xhci-exynos.c | 567 +++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci-exynos.h |  50 +++
> 
> Why do you need a .h file for a simple single driver like this?  Just
> put it all into the .c file please.
> 
> thanks,
> 
> greg k-h
> 

Yes. I will do it on next submission.

Best Regards,
Jung Daehwan

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_2ed9d_
Content-Type: text/plain; charset="utf-8"


------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_2ed9d_--
