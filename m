Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB65115F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiD0LBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiD0LAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:00:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E727F295A74
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:39:24 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427092033epoutp0116cda0f2b5dc9fd8cfaed4f29ce85f28~ptlldZ4qK3174831748epoutp01h
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427092033epoutp0116cda0f2b5dc9fd8cfaed4f29ce85f28~ptlldZ4qK3174831748epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651051233;
        bh=uHuk2jzRv4faPDHj7/LQeeM7U/vi7yJfEjSidx0RGcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USweGqhDzocveI7Qkx2rPrchi1dkUQXaBIOGQO4hRJLMw/YX5ROQDBiN6v8QoQHTO
         99MGni1JmNqaKIxfUBbaFrS6/z3IPf8Elc7XpcZu5qp75ArCkeHWG8QnU2whIvMgA+
         CrAnDnxQ8fQxpXiFuvpluvL8OJgJh9UGYG7+UT8w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220427092032epcas2p2bb5bd42490885cdf3e33c8bf99916cd8~ptlk97piN2894828948epcas2p2z;
        Wed, 27 Apr 2022 09:20:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KpCsB2ydFz4x9Py; Wed, 27 Apr
        2022 09:20:30 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.81.10069.EDA09626; Wed, 27 Apr 2022 18:20:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220427092030epcas2p4331983f6be56984568c628ee298d4a4a~ptliZrECX2509325093epcas2p4q;
        Wed, 27 Apr 2022 09:20:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427092030epsmtrp1d76f803eeb8d7d3527ac646031ff9f17~ptliYURO52762627626epsmtrp1f;
        Wed, 27 Apr 2022 09:20:30 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-06-62690ade5443
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.86.08853.DDA09626; Wed, 27 Apr 2022 18:20:29 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427092029epsmtip10ed5c5b596d5c874b10c3198cedeeb61~ptliMOlp62491024910epsmtip1_;
        Wed, 27 Apr 2022 09:20:29 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:19:01 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4 4/5] usb: host: add some to xhci overrides for
 xhci-exynos
Message-ID: <20220427091901.GC145620@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmfIIo6d1CkhkQS3@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhe49rswkg71/hC2eHFnEbtG8eD2b
        xfU/7xktzp/fwG5xedccNotFy1qZLZo3TWG1mLlW2aLr7g1GB06PBZtKPRbvecnksWlVJ5vH
        /rlr2D36tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoJiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsaCaTIF+6Qr7l/oZWlgPC7WxcjBISFgIrFqfUIXIyeHkMAORonJ
        szW6GLmA7E+MEn1PbzNCON8YJZ6eOcsGUgXScPvaDVaIxF5Gid0T9jFDOE8YJSZcOMcCUsUi
        oCrR838tO4jNJqAlce/HCWYQW0TAWKL/7Cx2kAZmga1MEveb37KCJIQFgiXaHq8Aa+YV0JFY
        ePA7M4QtKHFy5hMWkFs5BTQlDp0yBDFFBVQkXh2sBxkjIdDLIfGiYTsjxHUuEte+HIK6VFji
        1fEt7BC2lMTL/jYou1hi16dWJojmBkaJxgcQx0kAHTfrWTvYIGaBDIlpZ88xQsJIWeLILRaI
        MJ9Ex+G/7BBhXomONiGITmWJ6ZcnsELYkhIHX5+DmughcfD7JEZI8AJD8cge/wmM8rOQPDYL
        yTIIW0diwe5PbLOANjALSEss/8cBYWpKrN+lv4CRdRWjWGpBcW56arFRgSE8ppPzczcxgtOq
        lusOxslvP+gdYmTiYDzEKMHBrCTC+2V3RpIQb0piZVVqUX58UWlOavEhRlNgNE1klhJNzgcm
        9rySeEMTSwMTMzNDcyNTA3MlcV6vlA2JQgLpiSWp2ampBalFMH1MHJxSDUxGkYI84j8W9L7I
        FjmV3TpVxvOGza3jrWIiZ0sWXlP7WNrYrKwgv2yl+jWdK0XHWkXUjV1TL8o6v7zas69QReur
        uJDQTv1TRcsKz+w06b4qv22bR6PMPd4p9VcSirs3x4sxzvxyxcu2mb+db8u0l788lC8YFuT2
        /djxwjEzdVLrmhU/ZhueYD7xqDLsRMKyj+dq3q5n3LZjhWX/2peeRUsPfK+o+ebQc4e/zvn/
        n/Tu17m1+p+S1fO3Jb3KOum2LmBlV9zX6oOWchWWrfL7O+K0v056pzGpOdbY413DRu01R5x0
        nHd82dOXdGPGyeobMnkJE3eWG+84/uicaL+47aFmB/44zT0T3zo9jnrc91CJpTgj0VCLuag4
        EQBWKlzZNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnO5drswkg8tbLSyeHFnEbtG8eD2b
        xfU/7xktzp/fwG5xedccNotFy1qZLZo3TWG1mLlW2aLr7g1GB06PBZtKPRbvecnksWlVJ5vH
        /rlr2D36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/LZ7WwF/yQqdn76ztbAuECki5GTQ0LA
        ROL2tRusXYxcHEICuxklbtxYywKRkJRYOvcGO4QtLHG/5QhU0SNGib6dr8CKWARUJXr+rwUr
        YhPQkrj34wQziC0iYCzRf3YWWJxZYDuTxNaWSBBbWCBYou3xCrBeXgEdiYUHv4PVCwl8Y5S4
        /kgOIi4ocXLmExaIXi2JG/9eMnUxcgDZ0hLL/3GAmJwCmhKHThmCmKICKhKvDtZPYBSchaR3
        FpLeWQi9CxiZVzFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBEeGluYOxu2rPugdYmTi
        YDzEKMHBrCTC+2V3RpIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTLZXDR2WXnwtL6VtnZKjd/dgule/sP2yRY+q3T6tPvhNljXicdela+nie09nF052
        ORu+k/dO17xJ/z5WaX160zzbbZnF9ElZ233bvhTwPXxcUSZ36RP/8907Kua9dnNpEzp04+jD
        idK2Yh39W1Pq6wo0/zqvz/uz4Kj47UdmPxkm77voP6F9hcFFxhUFSl9f/z3/gm+PyLXnrZ9l
        hM5WqS87V3NsxkZfA2vt5cLMYbsbC7I/vjmdfiSx1+Nc3eGfLfNfWimWXAl+OVX3bEPJ4r0z
        OU83icRs2Xzg+iRWnUXr3p9rk1xQ3b426Mm+yfYVYTrtPdrLksXK6ha1cnqLT9ZcUvpry2s2
        B+/1EWYnJwcqsRRnJBpqMRcVJwIAxwehCfsCAAA=
X-CMS-MailID: 20220427092030epcas2p4331983f6be56984568c628ee298d4a4a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26d0c_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092022epcas2p2c016c83b21e41c7bcd4bdfbb95e464c0@epcas2p2.samsung.com>
        <1650964728-175347-5-git-send-email-dh10.jung@samsung.com>
        <YmfIIo6d1CkhkQS3@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26d0c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 12:23:30PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 06:18:47PM +0900, Daehwan Jung wrote:
> > Co-processor needs some information about connected usb device.
> > It's proper to pass information after usb device gets address when
> > getting "Set Address" command. It supports vendors to implement it
> > using xhci overrides. There're several power scenarios depending
> > on vendors. It gives vendors flexibilty to meet their power requirement.
> > They can override suspend and resume of root hub.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/xhci.c | 6 ++++++
> >  drivers/usb/host/xhci.h | 4 ++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 5ccf1bbe8732..8b3df1302650 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -5555,6 +5555,12 @@ void xhci_init_driver(struct hc_driver *drv,
> >  			drv->check_bandwidth = over->check_bandwidth;
> >  		if (over->reset_bandwidth)
> >  			drv->reset_bandwidth = over->reset_bandwidth;
> > +		if (over->address_device)
> > +			drv->address_device = over->address_device;
> > +		if (over->bus_suspend)
> > +			drv->bus_suspend = over->bus_suspend;
> > +		if (over->bus_resume)
> > +			drv->bus_resume = over->bus_resume;
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(xhci_init_driver);
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index 3a414a2f41f0..5bc621e77762 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1947,6 +1947,9 @@ struct xhci_driver_overrides {
> >  			     struct usb_host_endpoint *ep);
> >  	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
> >  	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
> > +	int (*address_device)(struct usb_hcd *hcd, struct usb_device *udev);
> > +	int (*bus_suspend)(struct usb_hcd *hcd);
> > +	int (*bus_resume)(struct usb_hcd *hcd);
> >  };
> >  
> >  #define	XHCI_CFC_DELAY		10
> > @@ -2103,6 +2106,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
> >  		       struct usb_host_endpoint *ep);
> >  int xhci_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
> >  void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
> > +int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev);
> 
> You do not use this function in this change, why include it in here?
> 
> Please reorganize your patch series to only include what you need for
> each step, as-is it's kind of out-of-order and might not build at each
> step along the way (or it might, it's hard to determine...)
> 

This patch is to add function pointers. xhci-exynos or other user could use it.
If I reorganize them as you said, all patches depend on xhci-exynos.
That's because hooks and override are only used in xhci-exynos for now.
I don't want user driver effects common files like xhci platform.
I've tried removing dependancies.. That's why I split patches like that.

Best Regards,
Jung Daehwan.

> thanks,
> 
> greg k-h
> 

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26d0c_
Content-Type: text/plain; charset="utf-8"


------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26d0c_--
