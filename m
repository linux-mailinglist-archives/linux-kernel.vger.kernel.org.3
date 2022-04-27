Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C275114ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiD0KqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiD0KqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:46:02 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3F284DB6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:29:28 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220427095116epoutp032d217dd899e6d1d15c13a5d70d4ca407~puAZsoK8L2124521245epoutp03V
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:51:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220427095116epoutp032d217dd899e6d1d15c13a5d70d4ca407~puAZsoK8L2124521245epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651053076;
        bh=toikZkWvgf3TsW9HrpdB/VW96mbkCmI+ZUJJ8BdL1vY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oKlUGyhpOlKUaS5HfmvWAtn5CJoiHntwnjdbKDSR8pE0TBMthXJO2ENOJFEYUi1B4
         tGGeGKhAWcX6xZtrYvQe/7Nb4sQAP67ErtIvZzRGQ/fGGz9MZMK/89copVrDV1c+rx
         oZtuho034IMCO5n5P/yYkBpm30vbl5qf9neAyVf0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220427095115epcas2p129811a3526d13bd86a48d685ea82ef9b~puAZLkMeY1310213102epcas2p1B;
        Wed, 27 Apr 2022 09:51:15 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KpDXc0hgjz4x9QB; Wed, 27 Apr
        2022 09:51:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.04.10028.F0219626; Wed, 27 Apr 2022 18:51:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220427095111epcas2p3b20b677d07fb99f738a83acf4107638d~puAVB7Ndc1069310693epcas2p34;
        Wed, 27 Apr 2022 09:51:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427095111epsmtrp2a0b011af334c469215f0fad5470eae86~puAVBK16f0395603956epsmtrp2O;
        Wed, 27 Apr 2022 09:51:11 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-08-6269120f9538
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.1D.08924.E0219626; Wed, 27 Apr 2022 18:51:11 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427095110epsmtip2bcb9ed1ed08fea0ed034674121200c58~puAU2Sz5L2747927479epsmtip2V;
        Wed, 27 Apr 2022 09:51:10 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:49:42 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 0/5] add xhci-exynos driver
Message-ID: <20220427094942.GE145620@ubuntu>
MIME-Version: 1.0
In-Reply-To: <3ce5f3b8-3c6b-1e83-94c2-84f4ad8aa9dc@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmmS6/UGaSwY4XshZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnfGxfwl7wX/JitbX91gaGC+I
        djFyckgImEhcX/iItYuRi0NIYAejxMb2LSwQzidGieYn8xghnM+MEo+WNTHBtCzad5oJIrGL
        UWLBt0VQLU8YJb4s+M0KUsUioCrx9cxFdhCbTUBL4t6PE8wgtoiApsT1v9/BFjILzGGWuLbk
        BgtIQljASOLW7nVgRbwCOhIr56yEsgUlTs58AlbDKWAncf77QSCbg0NUQEXi1cF6kDkSAis5
        JDa/bmGHOM9FYn5fDwuELSzx6vgWqLiUxOd3e9kg7GKJXZ9amSCaGxglGh9AXCchYCwx61k7
        I4jNLJAh8ezPGVaQZRICyhJHbrFAhPkkOg7/ZYcI80p0tAlBdCpLTL88gRXClpQ4+Poc1EQP
        iYvLlrJDAugco8TJ2RfYJzDKz0Ly2iwk2yBsHYkFuz+xzQJawSwgLbH8HweEqSmxfpf+AkbW
        VYxiqQXFuempxUYFxvDoTs7P3cQITsRa7jsYZ7z9oHeIkYmD8RCjBAezkgjvl90ZSUK8KYmV
        ValF+fFFpTmpxYcYTYERNZFZSjQ5H5gL8kriDU0sDUzMzAzNjUwNzJXEeb1SNiQKCaQnlqRm
        p6YWpBbB9DFxcEo1MC0KPH/t5R1HmYI1trvq+NvXFKdnxwRyaPXUfDnGdd8scsGK/d69u1bt
        /+74oidyykqmpV8Xxa1Mmf19Uqno8yb5FW3uOh2xNycdSRPyPHReWOxFy8lWNkYj1mLBO0yx
        ylPL4rdy/5H53XLobdTMSFPHD17Jrx4Y3j2wNP3bjvWPXj2LSZLgLVXYIHD06s7pE7IPcO1Q
        cZtk/kkx91njy1jOHV9bjV5K8NTVrdCqFlVJuft9Z2IYr9GCbrnK+ZtuV09J/3Og6vKciCqb
        r5+znlvXn3ZiVd565pvAx/dFdxcymT0ziN3ccsZLTdKSJe/jn8A/LYfSz//W/ft1zqX8w4wF
        LxblMO5+ESn7PejDxH9KLMUZiYZazEXFiQC4FJXWTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvC6/UGaSwYKvjBZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKWD1d
        smC/eMWZf1YNjCuFuxg5OSQETCQW7TvN1MXIxSEksINR4tK2rWwQCUmJpXNvsEPYwhL3W46w
        QhQ9YpTo/PQaLMEioCrx9cxFMJtNQEvi3o8TzCC2iICmxPW/38EamAUWMEuca5sHNlVYwEji
        1u51YEW8AjoSK+esZIaYeo5RYv7jFUwQCUGJkzOfsIDYzEBTb/x7CRTnALKlJZb/4wAJcwrY
        SZz/fpAFJCwqoCLx6mD9BEbBWUiaZyFpnoXQvICReRWjZGpBcW56brFhgVFearlecWJucWle
        ul5yfu4mRnAMaWntYNyz6oPeIUYmDsZDjBIczEoivF92ZyQJ8aYkVlalFuXHF5XmpBYfYpTm
        YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwKQQdTvm26XQ7yui95wyWS4RrJneFnqF4bJX
        dld7QvDVF6V1po//vYm9vFBF7NikS90LzzNGehiFtD/d+KtGYYLBg/PaP/009kUEndqV0jmp
        5f76H36bFy+akfcsPTdhaeCxB1Hr5no8XGjktnrjr6urry728A4simf+ufXRwceFz3X4qmcu
        Tvq/ak5HyS8+3Wtn9shrnw8V2WlZa5y3mWdXmO+7afFVTxu/HD+pGLYg/fik2oZIVy3ZeRkf
        eGoenW7eI6ig8cpZ/Vzy3zdzex0X2+rqveg4fXlj/CrOSQt+zekyONYjlG5q6baReZXNrLMO
        zZOXHj4ou1TqoXrUp+/Cv9/ny0tzyXEyfHi9WbpXiaU4I9FQi7moOBEA2wgTcxADAAA=
X-CMS-MailID: 20220427095111epcas2p3b20b677d07fb99f738a83acf4107638d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_2720f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
        <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <3ce5f3b8-3c6b-1e83-94c2-84f4ad8aa9dc@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_2720f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 02:46:14PM +0200, Krzysztof Kozlowski wrote:
> On 26/04/2022 11:18, Daehwan Jung wrote:
> > This patchset is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > driver mainly and extends some functions by xhci hooks and overrides.
> > 
> > This driver supports USB offload which makes Co-processor to use
> > some memories of xhci. Especially it's useful for USB Audio scenario.
> > Audio stream would get shortcut because Co-processor directly write/read
> > data in xhci memories. It could get speed-up using faster memory like SRAM.
> > That's why this gives vendors flexibilty of memory management. This feature
> > is done with xhci hooks and overrides.
> > 
> > Changes in v2 :
> > - Fix commit message by adding Signed-off-by in each patch.
> > - Fix conflict on latest.
> > 
> > Changes in v3 :
> > - Remove export symbols and xhci hooks which xhci-exynos don't need.
> > - Modify commit message to clarify why it needs to export symbols.
> > - Check compiling of xhci-exynos.
> > 
> > Changes in v4 :
> > - Modify commit message to clarify why it needs to export symbols.
> > - Add a function for override of hc driver in xhci-plat.
> > - Make xhci-exynos extending xhci-plat by xhci hooks and overrides.
> >   (vendor_init / vendor_cleanup hooks are useful from here v4)
> > - Change the term (USB offload -> xhci-exynos) on subject of patches.
> > 
> 
> You received comments already that you need to base your work on recent
> Linux kernel and use scripts/get_maintainers.pl to notify necessary
> parties. This is the fourth patchset and still you did not do it.
> 
> Maybe there is some misunderstanding or trouble using
> scripts/get_maintainers.pl, so could you clarify:
> 
> 1. What is this based on? Output of: git describe

url = https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
fetch = +refs/heads/*:refs/remotes/origin/*

or

url = https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
fetch = +refs/heads/*:refs/remotes/origin/*

> 
> 2. What does the scripts/get_maintainers.pl print when you run on this
> patchset?

I don't see your name in xhci even for whole usb/host directory.
I see same result on above 2 gits.

jdh@PlatFormDev3:~/works/mainline/linux-next$ ./scripts/get_maintainer.pl drivers/usb/host/
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM,commit_signer:170/184=92%)
Mathias Nyman <mathias.nyman@linux.intel.com> (commit_signer:52/184=28%,authored:25/184=14%)
Alan Stern <stern@rowland.harvard.edu> (commit_signer:30/184=16%)
Chunfeng Yun <chunfeng.yun@mediatek.com> (commit_signer:23/184=12%,authored:21/184=11%)
linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

> 

In fact, I manually tried adding you as you commendted previous patchset.
But, It seems you changed email id and domain..

Best Regards,
Jung Daehwan

> 
> Best regards,
> Krzysztof
> 

------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_2720f_
Content-Type: text/plain; charset="utf-8"


------s9reHD3dvq.Swzu4OgS99nNlXP7CLa0djtt04wdzZepsPVyA=_2720f_--
