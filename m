Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B704E234A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbiCUJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345867AbiCUJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:27:01 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E96516A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:25:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220321092533epoutp018e260b4a308c41b46df529a4daffc03c~eWyY-Ay151955619556epoutp01l
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:25:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220321092533epoutp018e260b4a308c41b46df529a4daffc03c~eWyY-Ay151955619556epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647854733;
        bh=e8bwc2Ysxw5MN4eM2XYne32AAf/UZRzAOxexveGEtGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pj6eeYL0D6KJSeslOYVfaNSLBcUcl9f/IdEkahTLt39NAknYRq1+0/zi0UOLgKbaS
         BGhKMWftuLdWuz0WyFuqyWTu/as+q7syh+QWxpvBMr5pKq28iZGn/nx9lEWaa6HPTB
         FcgrV4C4j+BEZGS3Qr9E4HSu/rOwiLg+n1lHz3Kk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220321092532epcas2p10d70a6372d69a95910bfbccdb09004c1~eWyYcnmY00811308113epcas2p1f;
        Mon, 21 Mar 2022 09:25:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KMTk31l5fz4x9Pv; Mon, 21 Mar
        2022 09:25:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.62.25540.88448326; Mon, 21 Mar 2022 18:25:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220321092527epcas2p4d7935b4535902c27b412325ebd0f15f4~eWyTnZCk81323613236epcas2p4l;
        Mon, 21 Mar 2022 09:25:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220321092527epsmtrp2e87ba18f1e93c2e9a8fd2290161d14ce~eWyTmcP4K1566415664epsmtrp2C;
        Mon, 21 Mar 2022 09:25:27 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-8c-62384488471d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.D3.29871.78448326; Mon, 21 Mar 2022 18:25:27 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220321092527epsmtip2c105407545e6069710ade2a503c4f4db~eWyTeEG6c3183331833epsmtip20;
        Mon, 21 Mar 2022 09:25:27 +0000 (GMT)
Date:   Mon, 21 Mar 2022 18:24:09 +0900
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
Message-ID: <20220321092409.GA62265@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YjhB7+AaEXvuUmdi@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmmW6Hi0WSwe8pXBZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7N
        S9fLSy2xMjQwMDIFKkzIzmjc9IS5YL9Axd/ra9kaGJfxdjFyckgImEjsPj2JuYuRi0NIYAej
        xI/FK9kgnE+MEqf6HkI53xgl5i+7zwzTcuF1JwuILSSwl1GiY6EzhP2EUWLDwnAQm0VAVeLG
        7auMIDabgJbEvR8nwHpFBIwl+s/OYgcZyiywgUnixJ3nYAlhAXOJ2VP62EFsXgFtiY4DJ5gg
        bEGJkzOfgC3jFNCUmPLxJlA9B4eogIrEq4P1EPdM5JA4vU8QwnaRmLv6FNSdwhKvjm9hh7Cl
        JD6/28sGYRdL7PrUygRyg4RAA6NE44MTUA3GErOetTOCzGcWyJTY9qQCxJQQUJY4cgvsAmYB
        PomOw3/ZIcK8Eh1tQhCNyhLTL09ghbAlJQ6+Pgc10ENiWvN8dnjgrm48wjKBUX4WksdmISyb
        BbZBR2LB7k9sEGFpieX/OCBMTYn1u/QXMLKuYhRLLSjOTU8tNiowhsd0cn7uJkZwWtVy38E4
        4+0HvUOMTByMhxglOJiVRHgXfzBPEuJNSaysSi3Kjy8qzUktPsRoCoylicxSosn5wMSeVxJv
        aGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBySBa/Wqh2edCS6f3Gf9m
        l9ckluS8PJxiLmzNY2ow+WJE7bmUQ9MvL/TP7VxymVeK4345y6UyjeqEEsO7K5PC47e5Kwq6
        qjTOXvh8/a+aVVts218f5XI+turVjvZonpK+NUIRJuHZ1b6hfGqzOvTv+5eebWPlF1bP5fQM
        vP1k19Vgy+WHkmPrn764vnpDpMLae8LfA56lN270eFezbpdSvgavTvcfX+/XdT1yOmLXHN7M
        MH24QjG4MPf1PvEvjeyzZjzJmeCq/Dc3VPbbWm1VjpmnDY8oCTYffDn1YffRbU9etSRfXvq1
        /9BTUctXL2fd8TpYonnnZLDGQwm/2d6pN6bc1a1fLr9WO1TulNFzJZbijERDLeai4kQAWVo5
        qjQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvG67i0WSweHdGhZPjixit2hevJ7N
        4vqf94wW7c8vsFlc3jWHzWLRslZmi+ZNU1gtZq5Vtui6e4PRgdPjcl8vk8eCTaUei/e8ZPLY
        P3cNu0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBl7N0/hb3gD2/FzAPKDYx/uLoYOTkkBEwk
        LrzuZOli5OIQEtjNKPGhrZ8RIiEpsXTuDXYIW1jifssRVoiiR4wSvzp3M4EkWARUJW7cvgrW
        wCagJXHvxwlmEFtEwFii/+wsdpAGZoFNTBKzf68FSwgLmEvMntIHNpVXQFui48AJJoipOxgl
        Pi/rYYJICEqcnPmEBcRmBpp6499LoDgHkC0tsfwfB0iYU0BTYsrHm8wgYVEBFYlXB+snMArO
        QtI8C0nzLITmBYzMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgqNDS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhXfzBPEmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGpsD/Jgu3TvPetX9hOC+3qu353r+7101miMp6dWQvq/TBH52XJEO9+K6sLjs2
        51TLE/GnB4p8NyRw3PWZu9tR5FTPyaUN1+++mR+Q8anZNrl1hb6LU2vLX7W2e2tueVgu7Fli
        G1auODVf+demZpmqB1ne95XLmS8diJe+86SD1b1hafzhy4HNMrtccvJ7uqetfpPk9klpwZW3
        vbMMD035f7K74Ii7xO4jee+91q3e42+aF7LZ4ETjYoaNDy4Ky8ww+XE68XHK2ZbfjBOmqBlM
        mtwuMu3tw4dbTn8/7Ke3Po6L+bn9wbxv115eMT11ReS2g+c639y9R+u9F8838fqfueeJ8ult
        vWcv3lcQ+nLk3CRFJZbijERDLeai4kQARwF99/0CAAA=
X-CMS-MailID: 20220321092527epcas2p4d7935b4535902c27b412325ebd0f15f4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_22567d_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c
References: <CGME20220321090202epcas2p1bfa78db059c1f6f6acbbb015e4bf991c@epcas2p1.samsung.com>
        <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <YjhB7+AaEXvuUmdi@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_22567d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Mar 21, 2022 at 10:14:23AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 21, 2022 at 05:59:50PM +0900, Daehwan Jung wrote:
> > This patchset is for USB offload feature, which makes Co-processor to use
> > some memories of xhci. Especially it's useful for USB Audio scenario.
> > Audio stream would get shortcut because Co-processor directly write/read
> > data in xhci memories. It could get speed-up using faster memory like SRAM.
> > That's why this gives vendors flexibilty of memory management.
> > Several pathches have been merged in AOSP kernel(android12-5.10) and I put
> > together and split into 3 patches. Plus let me add user(xhci-exynos)
> > module to see how user could use it.
> > 
> > To sum up, it's for providing xhci memories to Co-Processor.
> > It would cover DCBAA, Device Context, Transfer Ring, Event Ring, ERST.
> > It needs xhci hooks and to export some xhci symbols.
> > 
> > Changes in v2 :
> > - Fix commit message by adding Signed-off-by in each patch.
> > - Fix conflict on latest.
> > 
> > Changes in v3 :
> > - Remove export symbols and xhci hooks which xhci-exynos don't need.
> > - Modify commit message to clarify why it needs to export symbols.
> > - Check compiling of xhci-exynos.
> 
> As I asked for in the previous submission, you MUST have a user for
> these hooks, otherwise we can not accept them (nor would you WANT us to
> accept them).  Please fix that up and add them to the next submission as
> we can not do anything with this one.
> 
> thanks,
> 
> greg k-h
> 

Hi greg,

I've submitted the user(xhci-exynos) together on the last patch of the patchset.
You can see xhci-exynos uses these hooks and symbols.

[PATCH v3 4/4] usb: host: add xhci-exynos driver

Best Regards,
Jung Daehwan

------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_22567d_
Content-Type: text/plain; charset="utf-8"


------mwmExhcEqaTMgLyfw452.zc-R1ZLcLBBgXcQdqrDAhnQ.X2v=_22567d_--
