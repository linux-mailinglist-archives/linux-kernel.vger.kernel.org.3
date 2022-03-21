Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750F24E23FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbiCUKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346062AbiCUKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:09:29 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84B1AC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:07:58 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220321100753epoutp0438af69dfc52ad2d9767d093417f2f882~eXXWNhYsr2125721257epoutp04k
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:07:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220321100753epoutp0438af69dfc52ad2d9767d093417f2f882~eXXWNhYsr2125721257epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647857273;
        bh=EQdv+mLi3PBgdEQfFCjcX0fY2+npbW6yoMgn2DjAL9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oft5IBRS3mpC+nmQjZuENkatsRpKxJC1kOxCOzvVVM+pxdDfZlBE7iSR8dCIYAUgZ
         2K452T3tap9teFNjO2HUpqqwlHF0uh3yOZxDpRd7EixTXY+peKNV2BI33XwMl0Ws5u
         duViIIEQNBYdvmJzAXfRUAAFzdkgchzohNaRRDHk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220321100752epcas2p23f34c46f801d7789f6e53469ddf52446~eXXVuiWns1541815418epcas2p2X;
        Mon, 21 Mar 2022 10:07:52 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KMVfr4mnPz4x9Q5; Mon, 21 Mar
        2022 10:07:48 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.39.10444.37E48326; Mon, 21 Mar 2022 19:07:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220321100747epcas2p4594e7196634a28bed2539390263aeb60~eXXRCevy30425604256epcas2p4O;
        Mon, 21 Mar 2022 10:07:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220321100747epsmtrp1c3bdb3b6d86780694746f124fe836428~eXXRBdg7H0163701637epsmtrp1k;
        Mon, 21 Mar 2022 10:07:47 +0000 (GMT)
X-AuditID: b6c32a45-513ff700000228cc-d4-62384e739007
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.91.03370.37E48326; Mon, 21 Mar 2022 19:07:47 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321100747epsmtip1e3253fe7e565ec9f5b3698f3269d8136~eXXQ3xrFp0882408824epsmtip1M;
        Mon, 21 Mar 2022 10:07:47 +0000 (GMT)
Date:   Mon, 21 Mar 2022 19:06:31 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 0/4] support USB offload feature
Message-ID: <20220321100631.GB62265@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YjhGKVKuPsKG80wZ@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmhW6Jn0WSwft/zBZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7N
        S9fLSy2xMjQwMDIFKkzIzlgw7zJLwS+Jijdz+lgbGHcJdzFyckgImEgse3iXtYuRi0NIYAej
        xItJ29kgnE+MEmdvbWWEcD4zSjxd9pARpmXTikUsEIldjBJND3awgCSEBJ4wSnzZVwliswio
        SnxpAhnFycEmoCVx78cJZhBbRMBYov/sLHaQZmaBDUwSJ+48B0sIC5hLzJ7Sxw5i8wpoS0x7
        spkZwhaUODnzCdgCTgFNie2XzwEN5eAQFVCReHWwHmSOhMBEDokFD+6xQlznInH6/z9mCFtY
        4tXxLewQtpTEy/42KLtYYtenViaI5gZGicYHJ6AajCVmPWsHe5NZIFNi4vRWFpBlEgLKEkdu
        sUCE+SQ6Dv9lhwjzSnS0CUF0KktMvzwB6gRJiYOvz0FN9JCY1jyfHRJY3xklui6eYpvAKD8L
        yWuzkGyDsHUkFuz+xDYLaAWzgLTE8n8cEKamxPpd+gsYWVcxiqUWFOempxYbFRjCYzs5P3cT
        Izi9arnuYJz89oPeIUYmDsZDjBIczEoivIs/mCcJ8aYkVlalFuXHF5XmpBYfYjQFRtREZinR
        5Hxggs8riTc0sTQwMTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cAUrri4ZuLh
        L/sYixecjFnTPTm7t15oT8GErQuuTti9SGxNaq1hU5IZzzI7hZBJmZoGEcoZr0yuzt0gL3lp
        efRp9c6SP32S078/XRlSJ936gyd14Z00rmImTotF0Tnq21fNXLbw1t9c6cAHnK6VLh29OhGF
        S7ose9Pn7dF8q//2qeDkoszX6s7PNZjSJ3ZEedY9sJq1dv7/vhMxRtt3rnpzyjAwv37p77/6
        nr8mdr1qZw7uz5G06yxQ1TlzolhffeXKoLXmwpKdl6vvs/8LcTkaWcDqsUvRXSs1eaqHctXv
        qRKTxASzq/zuXrZb+7Kp5Y/vwiV3us2tN98+vOjGtglzTENDpb/5vcqxOZnrwKXEUpyRaKjF
        XFScCAD1Q4vjOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnG6xn0WSwa7ZchZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl3Nr2jL1gu1jF58Un2RsYJwh2MXJySAiY
        SGxasYili5GLQ0hgB6PEhZcH2CESkhJL596AsoUl7rccYYUoesQosff3V7AEi4CqxJem7Wwg
        NpuAlsS9HyeYQWwRAWOJ/rOz2EEamAU2MUnM/r0WLCEsYC4xe0ofWDOvgLbEtCebmSGm/mSU
        mHLtLBtEQlDi5MwnLCA2M9DUG/9eMnUxcgDZ0hLL/3GAhDkFNCW2Xz7HBhIWFVCReHWwfgKj
        4CwkzbOQNM9CaF7AyLyKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4PrS0djDuWfVB
        7xAjEwfjIUYJDmYlEd7FH8yThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2a
        WpBaBJNl4uCUamCSdDDdZSKwrq3xiMye555HUv5LnhBvanrxwiLQRVbwrO33tbLLZr3K2aC6
        SUQsc5dlbV6i1lLzM8JHFDTUt3tNy9/eVMOcztctdtnFc1MIF1t/mv2CRWX31eYW99911zmd
        fLjwzYQmQ573U6IOc51SOJvG3apwVTM+nqssc+ZWM6bLp/tm2x8/b9Vr2eHiECa9116UXXre
        oez0Z27vOYQO2c327txm+eSsx+nWCO9LmyK2xDz+8NL4ku2DE7IOK1cve/djvblM22qxwz+k
        5j8zXB3+ae7Pc8uTcuzuP7266+PR1Fv/f8z9ePfUxuRWPt63ehY/yvcc6k74nvfC6WRe9s3W
        pc8awhZP+1cixHRQiaU4I9FQi7moOBEAdwxuyP4CAAA=
X-CMS-MailID: 20220321100747epcas2p4594e7196634a28bed2539390263aeb60
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_225eb3_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
        <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <YjhB7+AaEXvuUmdi@kroah.com> <20220321092409.GA62265@ubuntu>
        <YjhGKVKuPsKG80wZ@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_225eb3_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 21, 2022 at 10:32:25AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 21, 2022 at 06:24:09PM +0900, Jung Daehwan wrote:
> > On Mon, Mar 21, 2022 at 10:14:23AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 21, 2022 at 05:59:50PM +0900, Daehwan Jung wrote:
> > > > This patchset is for USB offload feature, which makes Co-processor to use
> > > > some memories of xhci. Especially it's useful for USB Audio scenario.
> > > > Audio stream would get shortcut because Co-processor directly write/read
> > > > data in xhci memories. It could get speed-up using faster memory like SRAM.
> > > > That's why this gives vendors flexibilty of memory management.
> > > > Several pathches have been merged in AOSP kernel(android12-5.10) and I put
> > > > together and split into 3 patches. Plus let me add user(xhci-exynos)
> > > > module to see how user could use it.
> > > > 
> > > > To sum up, it's for providing xhci memories to Co-Processor.
> > > > It would cover DCBAA, Device Context, Transfer Ring, Event Ring, ERST.
> > > > It needs xhci hooks and to export some xhci symbols.
> > > > 
> > > > Changes in v2 :
> > > > - Fix commit message by adding Signed-off-by in each patch.
> > > > - Fix conflict on latest.
> > > > 
> > > > Changes in v3 :
> > > > - Remove export symbols and xhci hooks which xhci-exynos don't need.
> > > > - Modify commit message to clarify why it needs to export symbols.
> > > > - Check compiling of xhci-exynos.
> > > 
> > > As I asked for in the previous submission, you MUST have a user for
> > > these hooks, otherwise we can not accept them (nor would you WANT us to
> > > accept them).  Please fix that up and add them to the next submission as
> > > we can not do anything with this one.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Hi greg,
> > 
> > I've submitted the user(xhci-exynos) together on the last patch of the patchset.
> > You can see xhci-exynos uses these hooks and symbols.
> > 
> > [PATCH v3 4/4] usb: host: add xhci-exynos driver
> 
> Then this is not "offload" hooks at all.  They are merely "support
> another xhci platform driver, right?

Yes, right.

> 
> I see a lot of exports and function hooks added, are they _ALL_ used by
> the xhci driver?  If so, please reword this series as it is not very
> obvious at all what you are doing.

Yes, they are all used by the xhci driver. Is it OK for me to use "xhci-exynos"
instead of "USB offload" on series like below?

[v3, 0/4] add xhci-exynos driver

This patchset is for support xhci-exynos driver....
....

  usb: host: export symbols for xhci-exynos to use xhci hooks
  usb: host: add xhci hooks for xhci-exynos
  usb: host: add some to xhci overrides for xhci-exynos
  usb: host: add xhci-exynos driver

Best Regards,
Jung Daehwan

> 
> thanks,
> 
> greg k-h
> 

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_225eb3_
Content-Type: text/plain; charset="utf-8"


------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_225eb3_--
