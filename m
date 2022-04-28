Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DC5128DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiD1Bej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiD1Beh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:34:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13191D31D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 18:31:23 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220428013119epoutp010abfd3efdd4809a4506c662097b1c165~p61LBqFHk2206522065epoutp016
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220428013119epoutp010abfd3efdd4809a4506c662097b1c165~p61LBqFHk2206522065epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651109479;
        bh=NxPaTgU3hgBotu3kTBv6NrutichRsP0J2zt/FVPO0bg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D3fJWhPjmaZRKMqeikj92F0T3SH+nqsBs2Khqo53YcUW0cDIZfxD3hN8ATwQGPQBz
         jkG3CP7iin5eYleoDVwl6xtrWXWv8T+Weyu8W4QycyaLWmckQcx9c9qIgDaQihPZvy
         QCClwShXvNmNQ/xykyXc/klNShHXx6yQ5P6XyO8M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220428013118epcas2p4a9414d492ba536f2c21b5df3e3101a61~p61KUjmSe1214412144epcas2p45;
        Thu, 28 Apr 2022 01:31:18 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KpdPF5Kzpz4x9Pv; Thu, 28 Apr
        2022 01:31:13 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.42.10028.F5EE9626; Thu, 28 Apr 2022 10:31:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428013110epcas2p2d8990c274b52453c2536cb60aa88f3ba~p61DAIaVy0706707067epcas2p2c;
        Thu, 28 Apr 2022 01:31:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428013110epsmtrp2a1f97f16bd325ede97e88123f4773f66~p61C-OApY0689906899epsmtrp2U;
        Thu, 28 Apr 2022 01:31:10 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-6f-6269ee5fbf62
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.56.08924.E5EE9626; Thu, 28 Apr 2022 10:31:10 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428013110epsmtip2211884cda0093b688c857d46939b1e2a~p61Cv1QC70691106911epsmtip2l;
        Thu, 28 Apr 2022 01:31:10 +0000 (GMT)
Date:   Thu, 28 Apr 2022 10:29:41 +0900
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
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <20220428012941.GF145620@ubuntu>
MIME-Version: 1.0
In-Reply-To: <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmhW78u8wkg7k/hC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2LSqk81j/9w17B59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0p5JCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PN9xvMBfdlKqYta2BrYJwr
        3sXIySEhYCJx+GcbUxcjF4eQwA5GibULrzJCOJ+AnAtNLBDOZ0aJ9Z0bgTIcYC3352mDdAsJ
        7GKU+PmTF6LmCaPEhDkbGEESLAKqEu0nb7CD2GwCWhL3fpxgBrFFBDQlrv/9zgrSwCwwh1ni
        2pIbLCAJYQFbiV9bd4I18wroSEw4+ZMNwhaUODnzCVgNp4CdxORXl9hBjhAVUJF4dbAe4oUt
        HBIb9xhB2C4SvdumsUDYwhKvjm9hh7ClJD6/28sGYRdL7PrUCvayhEADo0TjA4jjJASMJWY9
        awe7gVkgQ+LZ0acsEA8rSxy5xQIR5pPoOPyXHSLMK9HRJgTRqSwx/fIEVghbUuLg63NQEz0k
        vj3dyAYJn24mifunJzNOYJSfheSzWUi2Qdg6Egt2f2KbBbSCWUBaYvk/DghTU2L9Lv0FjKyr
        GMVSC4pz01OLjQqM4XGdnJ+7iRGcgrXcdzDOePtB7xAjEwfjIUYJDmYlEd4vuzOShHhTEiur
        Uovy44tKc1KLDzGaAuNpIrOUaHI+MAvklcQbmlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1O
        TS1ILYLpY+LglGpg8pWbtsOGU6m25gSPr8VHZiaX3xeq3fMY859uuSJiHlg9+dP70Paiw9M7
        Zh4++cDN+I3nHgv3G7WOPj4TWh/NW3yJT35nH4vwnjc2zncj5+oGTKpf3pJwSiv++fabvzVu
        sU2pKki6uHXLBXMzjaxnZt8PT6xU/ebdGdEr+GRlWfum1+YNwVILQw5OOcMlMuNbTu85C2Gj
        FAmBp+xvUraHSifK3Zz4munj974d+cs7BSKSpvp1OZvl3+WdbsJRbDXt2HKxUrd9pmWhzVue
        stzKUr7E+VAm4o+7ncJ6Zp8mUcOLfw5HpG8U2Zg9V1PDdXfPqW8cbof3l9qw/RL1aOwIOZ4o
        LfzD6vXS8BsxngFKLMUZiYZazEXFiQBmFQvSSgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSvG7cu8wkg4ubhCyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2LSqk81j/9w17B59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CV8Xf+
        HNaC+VIVS87dY21g/CbSxcjBISFgInF/nnYXIxeHkMAORolpf28ydTFyAsUlJZbOvcEOYQtL
        3G85wgpR9IhRounoe1aQBIuAqkT7SYgiNgEtiXs/TjCD2CICmhLX/34Ha2AWWMAsca5tHhtI
        QljAVuLX1p2MIDavgI7EhJM/2SCmdjNJXFh2AiohKHFy5hMWEJsZaOqNfy+ZQE5lFpCWWP6P
        AyTMKWAnMfnVJXaQsKiAisSrg/UTGAVnIWmehaR5FkLzAkbmVYySqQXFuem5xYYFRnmp5XrF
        ibnFpXnpesn5uZsYwVGkpbWDcc+qD3qHGJk4GA8xSnAwK4nwftmdkSTEm5JYWZValB9fVJqT
        WnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD06otZyasOyx/fe7nn26zmfLqLG4c
        ePD8yJv5/pM5PaNutnK5HmbaWnnouUtBmA7LypdNf6fGHur6/1P/rpzGgTu8Oz+seW0uy9fm
        vm2i3UvNtbOWx7DpiWw80vlkpcutywtbj5z9vzp73qmDjWt5P6+ZoFuakuhzN/Om1USFNPHQ
        iE1NIQ0vZb27i5q4+5NuR/Qd1t43mTnHs8FhT1jS9j+167jz/lRd/fzVumC7dq1b/8aVO478
        cA5tdpKqNFnrn8UxIzKksF93wR7u6uk+Ej9i+53fhcukh15c8GL+PDfDI0vMNL/qSVqsm6id
        8epuLUf3TY5vJ3fNaZl7SjBUm/O73sbW9pdvVjfNPWQ5aZcSS3FGoqEWc1FxIgD3xSSbEQMA
        AA==
X-CMS-MailID: 20220428013110epcas2p2d8990c274b52453c2536cb60aa88f3ba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2d861_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2d861_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 02:59:57PM +0200, Krzysztof Kozlowski wrote:
> On 26/04/2022 11:18, Daehwan Jung wrote:
> > This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> > driver mainly and extends some functions by xhci hooks and overrides.
> > 
> > It supports USB Audio offload with Co-processor. It only cares DCBAA,
> > Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> > on specific address with xhci hooks. Co-processor could use them directly
> > without xhci driver after then.
> 
> This does not look like developed in current Linux kernel, but something
> out-of-tree, with some other unknown modifications. This is not how the
> code should be developed. Please rebase on linux-next and drop any
> unrelated modifications (these which are not sent with this patchset).
> 

I've been developing on linux-next and I rebase before submitting.
Could you tell me one of dropped modifications or patches?

> (...)
> 
> > +
> > +static int xhci_exynos_suspend(struct device *dev)
> > +{
> > +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > +
> > +	/* TODO: AP sleep scenario*/
> 
> Shall the patchset be called RFC?
> 
OK. I will add RFC for this patch on next submission.

> > +
> > +	return xhci_suspend(xhci, device_may_wakeup(dev));
> > +}
> > +
> > +static int xhci_exynos_resume(struct device *dev)
> > +{
> > +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> > +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > +	int ret;
> > +
> > +	/* TODO: AP resume scenario*/
> > +
> > +	ret = xhci_resume(xhci, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops xhci_exynos_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
> > +};
> > +
> > +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
> > +MODULE_LICENSE("GPL");
> 
> You don't have list of compatibles (and missing bindings), driver
> definition, driver registration. Entire solution is not used - nothing
> calls xhci_exynos_vendor_init(), because nothign uses "ops".
> 

xhci_exynos_vendor_init is called in xhci-plat.c (xhci_vendor_init)
[v4,2/5] usb: host: add xhci hooks for xhci-exynos
ops are used in some files(xhci-mem.c, xhci.c ..) and the body of ops is in
all xhci-exynos.

xhci-exynos is not a standalone driver. It could be enabled when other module
makes xhci platform driver probed as it uses xhci platform mainly.
I thought I just used existing compltible not adding new one.
I will add them if needed.

> This does not work and it makes it impossible to test it. Please provide
> proper XHCI Exynos driver, assuming you need it and it is not part of
> regular Exynos XHCI drivers (DWC3 and so on).
>

What makes you think it doesn't work? I think it's almost proper. I just removed
other IPs code like Co-Processor(we call it abox) or Power Management because
it would make build-error. I've added hooking points in some files(xhci-mem.c,
xhci.c..) and ops are implemented in xhci-exynos. It's mainly operated with
xhci platform driver.

Best Regards,
Jung Daehwan

> Best regards,
> Krzysztof
> 

------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2d861_
Content-Type: text/plain; charset="utf-8"


------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_2d861_--
