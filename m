Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A55512BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbiD1Glc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1Gla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:41:30 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900397BBB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:38:15 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220428063809epoutp02c6c402f88dadc9745da4f50af51dfba5~p-BFYNkBD1332213322epoutp02z
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:38:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220428063809epoutp02c6c402f88dadc9745da4f50af51dfba5~p-BFYNkBD1332213322epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651127889;
        bh=nxVNPAsLCklRldBcYLtWtXw5FqDCEqBe+ZZ64s0I/AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D4xEzBcy9S4VES6xVPnOY1W6L7JZVZhEuKW8/URM0erD3vrraj2ldzKramta1KDRE
         Hc8EDmFC2k7X7Km4Y+Yp/q1f34x+Qyf+ehNKXkYt5yY6ZEu7btzC/vWoa9RDr/B600
         9T+Kf7VAvWUEFamSQGeCw9aGd71uA5BYGIfmXJGI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220428063809epcas2p4639b89460c3f8e8da38fe151395905bb~p-BE2cbW60409404094epcas2p4m;
        Thu, 28 Apr 2022 06:38:09 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KpmCJ6FRzz4x9Pt; Thu, 28 Apr
        2022 06:38:04 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.66.09694.C463A626; Thu, 28 Apr 2022 15:38:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220428063803epcas2p371e1801026081f08d270f6efa8139179~p-A-8geBv1125611256epcas2p3V;
        Thu, 28 Apr 2022 06:38:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428063803epsmtrp14a55000925aebec17ad9062e79c624b9~p-A-6wP-I0375503755epsmtrp1F;
        Thu, 28 Apr 2022 06:38:03 +0000 (GMT)
X-AuditID: b6c32a48-495ff700000025de-60-626a364c177f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.B7.08924.B463A626; Thu, 28 Apr 2022 15:38:03 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428063803epsmtip2c789ece85898e18658256e8ddad8cb34~p-A-v7Gs53066030660epsmtip24;
        Thu, 28 Apr 2022 06:38:03 +0000 (GMT)
Date:   Thu, 28 Apr 2022 15:36:34 +0900
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
Message-ID: <20220428063634.GF151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmua6PWVaSwbPd4hZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxL
        t1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6U0mhLDGnFCgUkFhcrKRvZ1OUX1qS
        qpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnfF7yUK2gk6Nii3bJrE1MHYq
        dDFyckgImEj82jiNuYuRi0NIYAejxK2d09kgnE+MEqeeTmCEcD4zSmw48I4FpmVH334miMQu
        Rom+9z9ZIZwnjBL7Os+zg1SxCKhK3Pu2gBnEZhPQkrj34wSYLSKgKXH973ewBmaBOcwS15bc
        ABsrLGAr8WvrTkYQm1dAR+LAyqXsELagxMmZT8BqOAXsJF4tugBkc3CICqhIvDpYD3HRWg6J
        ExcqIGwXiXvPHzJC2MISr45vYYewpSRe9rdB2cUSuz61gn0gIdDAKNH4AOI4CQFjiVnP2sGa
        mQUyJD4ubGQF2SUhoCxx5BYLRJhPouPwX3aIMK9ER5sQRKeyxPTLE1ghbEmJg6/PQU30kPj2
        dCM0SB8xSfzr2sc0gVF+FpLPZiHZBmHrSCzY/YltFtAKZgFpieX/OCBMTYn1u/QXMLKuYhRL
        LSjOTU8tNiowgcd2cn7uJkZwGtby2ME4++0HvUOMTByMhxglOJiVRHi/7M5IEuJNSaysSi3K
        jy8qzUktPsRoCoynicxSosn5wEyQVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUg
        tQimj4mDU6qBqXRNv6bqhdV955W/qSRK6HQkTL1yg01ZNfph54vtB9/f3/xVTyzW2HjK7vNH
        UtxV1oeHWpw7U3EtzGCHsvFe53K9+s4+A0vx6KNhFcJ6k8J2hSnsnZHdvlGD65dI2s7aKx+X
        slz70f0kf+091UaftrCgfQxtAv0JGVbzJBcuLPnqUs0vt1e7+BwLj1L/4uWXJb6aHTo7Xe2j
        6jzx824ev269OR+dtLNdkF966nlrNuvo5cFq4T+/Rr6JW6EVuNHZ+b6FX7nVg0m3A5/dELzG
        yCepmXbgSE9R21U1Vtmtsp4b2sPDTBkWa22bHPknrujOq3yVgDP1yn3rq80qWgNtmef9SLIu
        818f+U7YW0WJpTgj0VCLuag4EQAc3lFcTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK63WVaSwZLJ5hZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiOKySUnNySxLLdK3S+DKmHtk
        I3PBSdWKnZvXMDUwPpLtYuTkkBAwkdjRt5+pi5GLQ0hgB6NEf8tkZoiEpMTSuTfYIWxhifst
        R1ghih4xSny5OAEswSKgKnHv2wKwBjYBLYl7P06A2SICmhLX/34Ha2AWWMAsca5tHhtIQljA
        VuLX1p2MIDavgI7EgZVL2aGmMkk0zXzPDJEQlDg58wkLiM0MNPXGv5dA93EA2dISy/9xgIQ5
        BewkXi26wAISFhVQkXh1sH4Co+AsJM2zkDTPQmhewMi8ilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOI60tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgcizPO2Dp427uxfOv6d6Geyn11VO7d77e
        /DKlVOLB5CrtxnkpP1s1/5s8Wp86l7vZ5lD1nL5jDSw9pxVUf6/U3Rh149AFhqrtB9eZF3Pc
        C08qyJv/eTXXjWeGhUnVXJcKFBebHbc3yHtx9CAro9PqHrn3Npv2258zP79q+67bbv+/hjje
        C5p6uPTy8hb+g27X79y9zqfmf/Ojz/ezSc/nLl8nlpi/d9PLMmEDx6JDBqs9juzv/v22QL9c
        /FHsI/ZCvZPi0088X9+vs2lK2YsJ87KFM/4s+DHjxhXRb837G7zd9ivNTTFfZtOztflUyFn7
        YsHskM+HViy4HGi47vThKmPrr8rpk9N+8VVe912jt1GJpTgj0VCLuag4EQBTnRZ9EgMAAA==
X-CMS-MailID: 20220428063803epcas2p371e1801026081f08d270f6efa8139179
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_30d54_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <a9438aef-78a3-e8ab-2b78-cc872447df08@kernel.org>
        <20220428012941.GF145620@ubuntu>
        <01ec9962-e210-ce47-57cd-8849cca0a9df@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_30d54_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Apr 28, 2022 at 07:19:04AM +0200, Krzysztof Kozlowski wrote:
> On 28/04/2022 03:29, Jung Daehwan wrote:
> > On Tue, Apr 26, 2022 at 02:59:57PM +0200, Krzysztof Kozlowski wrote:
> >> On 26/04/2022 11:18, Daehwan Jung wrote:
> >>> This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
> >>> driver mainly and extends some functions by xhci hooks and overrides.
> >>>
> >>> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> >>> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> >>> on specific address with xhci hooks. Co-processor could use them directly
> >>> without xhci driver after then.
> >>
> >> This does not look like developed in current Linux kernel, but something
> >> out-of-tree, with some other unknown modifications. This is not how the
> >> code should be developed. Please rebase on linux-next and drop any
> >> unrelated modifications (these which are not sent with this patchset).
> >>
> > 
> > I've been developing on linux-next and I rebase before submitting.
> > Could you tell me one of dropped modifications or patches?
> > 
> >> (...)
> >>
> >>> +
> >>> +static int xhci_exynos_suspend(struct device *dev)
> >>> +{
> >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> >>> +
> >>> +	/* TODO: AP sleep scenario*/
> >>
> >> Shall the patchset be called RFC?
> >>
> > OK. I will add RFC for this patch on next submission.
> > 
> >>> +
> >>> +	return xhci_suspend(xhci, device_may_wakeup(dev));
> >>> +}
> >>> +
> >>> +static int xhci_exynos_resume(struct device *dev)
> >>> +{
> >>> +	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> >>> +	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> >>> +	int ret;
> >>> +
> >>> +	/* TODO: AP resume scenario*/
> >>> +
> >>> +	ret = xhci_resume(xhci, 0);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	pm_runtime_disable(dev);
> >>> +	pm_runtime_set_active(dev);
> >>> +	pm_runtime_enable(dev);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static const struct dev_pm_ops xhci_exynos_pm_ops = {
> >>> +	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
> >>> +};
> >>> +
> >>> +MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
> >>> +MODULE_LICENSE("GPL");
> >>
> >> You don't have list of compatibles (and missing bindings), driver
> >> definition, driver registration. Entire solution is not used - nothing
> >> calls xhci_exynos_vendor_init(), because nothign uses "ops".
> >>
> > 
> > xhci_exynos_vendor_init is called in xhci-plat.c (xhci_vendor_init)
> > [v4,2/5] usb: host: add xhci hooks for xhci-exynos
> > ops are used in some files(xhci-mem.c, xhci.c ..) and the body of ops is in
> > all xhci-exynos.
> 
> 
> Nothing uses the "ops" except xhci_exynos_register_vendor_ops() which is
> not called anywhere, so the xhci_vendor_init() does not call
> xhci_exynos_vendor_init().
> 

You are right. xhci_exynos_register_vendor_ops should be called by other
module. It's only thing not called anywhere in this patchset. I don't uses
xhci-exynos alone in my scenario. Other module loads this on runtime.

> > 
> > xhci-exynos is not a standalone driver. It could be enabled when other module
> > makes xhci platform driver probed as it uses xhci platform mainly.
> 
> It "could be" or "will be"? We do not talk here about theoretical usage
> of the driver, but a real one.
> 
> > I thought I just used existing compltible not adding new one.
> > I will add them if needed.
> 
> Since you called everything here as "exynos" it is specific to one
> hardware and not-reusable on anything else. How can then you use some
> other compatible? It would be a misuse of Devicetree bindings.
> 

I got it. Let me add them. Is it still necessary if it is only used by
other module on runtime as I said above?

Best Regards,
Jung Daehwan

> Unless this is not specific to "exynos", but then please remove any
> exynos and vendor references and make it integrated in generic XHCI
> working for all drivers.
> 
> 
> >> This does not work and it makes it impossible to test it. Please provide
> >> proper XHCI Exynos driver, assuming you need it and it is not part of
> >> regular Exynos XHCI drivers (DWC3 and so on).
> >>
> > 
> > What makes you think it doesn't work?
> 
> Not possible to probe. The code cannot be loaded.
> 
> > I think it's almost proper. I just removed
> > other IPs code like Co-Processor(we call it abox) or Power Management because
> > it would make build-error. I've added hooking points in some files(xhci-mem.c,
> > xhci.c..) and ops are implemented in xhci-exynos. It's mainly operated with
> > xhci platform driver.
> 
> Best regards,
> Krzysztof
> 

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_30d54_
Content-Type: text/plain; charset="utf-8"


------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_30d54_--
