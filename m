Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2208A51141A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiD0JMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiD0JMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8689611150
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:09:30 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427090835epoutp0160831a6d958273f20c373de44607a188~ptbIyKeat2121521215epoutp01v
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:08:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427090835epoutp0160831a6d958273f20c373de44607a188~ptbIyKeat2121521215epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651050515;
        bh=W6ILaf7Op7t9xWdyJQ1Ei4NIkaeozKfDPPFG01/YXnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UkR/GuDERcnH4rzndmTyASQiyLQKpnrwKPeqGSnVf6PGvFxHlKWN37MUp4y9gKACb
         1rUvTIlixcvABCoWk7pv+P16n58GWQM4IUjnXKD8jPOM9aCVfMlEZXqL5XVtuzahjJ
         PTGQ6WEeYRHL0RE6w78Vo8zCUnhAHCExHHp68sII=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220427090834epcas2p16bf57563d96ac77e55f910d3c7c27c24~ptbIMLvFV1984119841epcas2p19;
        Wed, 27 Apr 2022 09:08:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KpCbN1m9Sz4x9Pr; Wed, 27 Apr
        2022 09:08:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.A4.09694.D0809626; Wed, 27 Apr 2022 18:08:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220427090828epcas2p4f02e589b9ea122276e96c072dc8ab4d8~ptbCptis33224732247epcas2p49;
        Wed, 27 Apr 2022 09:08:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427090828epsmtrp140d6e2062024b6a42b429e9e2637818e~ptbCoSQwV2080920809epsmtrp1U;
        Wed, 27 Apr 2022 09:08:28 +0000 (GMT)
X-AuditID: b6c32a48-495ff700000025de-9b-6269080d04c7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.54.08924.C0809626; Wed, 27 Apr 2022 18:08:28 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427090828epsmtip189767ba1ef59753476e7163f4ea1bf86~ptbCfEsEF1609916099epsmtip1Z;
        Wed, 27 Apr 2022 09:08:28 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:07:00 +0900
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
Subject: Re: [PATCH v4 3/5] usb: host: xhci-plat: support override of hc
 driver
Message-ID: <20220427090700.GB145620@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmfHV3V/wf9Dsn6l@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmuS4vR2aSQdtkYYsnRxaxWzQvXs9m
        cf3Pe0aL9ucX2Cw2vv3BZHF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo9ZDb1sHpf7epk8
        Fmwq9Vi85yWTx/65a9g9+rasYvT4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
        UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DolhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
        ToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG26dljAWreSpWzprI3MC4kauLkZNDQsBEYtWc
        6cxdjFwcQgI7GCUmrHkM5XxilJg4eyU7hPOZUWLqoWmMXYwcYC39U/kg4rsYJToX/2GFcJ4w
        Skz5/4QRZC6LgKrEqkv7WEBsNgEtiXs/TjCD2CICxhL9Z2eBTWUWeMkk0X5rAjtIQlggUOLf
        4gesIBt4BXQknr5iAgnzCghKnJz5BGwOp4CmxK7Wh2AlogIqEq8O1oOMkRBYyCHRPW0aM8Rx
        LhJvV7JBvCYs8er4FnYIW0riZX8blF0ssetTKxNEbwOjROMDiNskgG6b9awd7H5mgQyJi1/v
        Q81UljhyiwUizCfRcfgvO0SYV6KjTQiiU1li+uUJrBC2pMTB1+egJnpIzHq/Fxqg3xgl9p89
        xTiBUX4Wks9mIdkGYetILNj9iW0W0ApmAWmJ5f84IExNifW79Bcwsq5iFEstKM5NTy02KjCB
        x3Vyfu4mRnC61fLYwTj77Qe9Q4xMHIyHGCU4mJVEeL/szkgS4k1JrKxKLcqPLyrNSS0+xGgK
        jKaJzFKiyfnAhJ9XEm9oYmlgYmZmaG5kamCuJM7rlbIhUUggPbEkNTs1tSC1CKaPiYNTqoGp
        dctCpY+eXDY/ViStXejzmvmv8YLze6QD5fq9/W+K3r9/LOKr5l2/C+fXNsrbTuvdw5+Zsnrr
        pI7CwMX6NZN7vpUcvOg1v7xq67NzjFOf7cg5mN56aYJgY3jai9xJW8LXaase1A+6t6U54kyA
        QJyL2kym1PTV95eLPd59xFlqdoBU68mn93d4yTIxfErPF+ZbmjorSV/b+NX+ibbZgZ3Bz+K/
        WXssOiBe/WX1s307Ymerl16a+mn3I2EjwZ4/XsJvdnjzrTpqbWbWantlRXDluj3BXYZmji42
        0QHbf1WXdlp1d999Zd+R3do0f0Ht1RqRfL7jJ0V7M6YKza7ZmPprv4v748XK8+sm3opbss5J
        iaU4I9FQi7moOBEAi7l84kAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnC4PR2aSQc9PLYsnRxaxWzQvXs9m
        cf3Pe0aL9ucX2Cw2vv3BZHF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo9ZDb1sHpf7epk8
        Fmwq9Vi85yWTx/65a9g9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+PMpC2MBa85Kz6f+sHS
        wNjF0cXIwSEhYCLRP5Wvi5GLQ0hgB6PEyl+X2LoYOYHikhJL595gh7CFJe63HGGFKHrEKLHr
        /g8WkASLgKrEqkv7wGw2AS2Jez9OMIPYIgLGEv1nZ7GDNDALvGWS2DTlAxNIQlggUOLf4ges
        IJt5BXQknr5ighj6jVHiUO90sBpeAUGJkzOfgA1lBhp6499LJpB6ZgFpieX/OEDCnAKaErta
        H4KNERVQkXh1sH4Co+AsJM2zkDTPQmhewMi8ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
        dxMjOF60tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Xug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgck1zfPb4c9J+uYurbok/KFcWzT4cwZDP1SHVdsTB
        fd25U82Cu73OzpKIfFvz27KseXbA1P+L5h749GqD+bZvq5h4JQNcNrcozgkxCi4umP3a5NSG
        UHtXtguBmj0ddra1qwpnXbqYfljzo+6+WoUZVz21pr6tzNY2M18pHXEx/K+Db3rE2pkeSyZ9
        NVl3OPHB4a47VR21YdlnhJcn+Eas5OTrXfujTe/emxNeB/ZcUFkREnkuSWdteKFCYf7q1ez+
        W/4teGd3Q9Sswaj27vSkD/f4jodH37wWZsjhNdvr3NXrFe0cxSuOODl/+jhfa7OIisVy+zKr
        Nfvfehvv6Vx0s/x1k1lgubHND5vUyYa5SizFGYmGWsxFxYkAnauCjwYDAAA=
X-CMS-MailID: 20220427090828epcas2p4f02e589b9ea122276e96c072dc8ab4d8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_26bfb_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092022epcas2p2da47c0c20feba6c96037e125289475f9
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092022epcas2p2da47c0c20feba6c96037e125289475f9@epcas2p2.samsung.com>
        <1650964728-175347-4-git-send-email-dh10.jung@samsung.com>
        <YmfHV3V/wf9Dsn6l@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_26bfb_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 12:20:07PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 06:18:46PM +0900, Daehwan Jung wrote:
> > It helps xhci-plat driver increase usability. Vendors could use functions
> > in xhci-plat mostly and use some overrides to do what they wants without
> > modifying xhci-plat driver.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 6 ++++++
> >  drivers/usb/host/xhci-plat.h | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index a5881ff945a6..6efa3169bf69 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -173,6 +173,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
> >  MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
> >  #endif
> >  
> > +void xhci_plat_override_driver(const struct xhci_driver_overrides *xhci_vendor_overrides)
> > +{
> > +	xhci_init_driver(&xhci_plat_hc_driver, xhci_vendor_overrides);
> > +}
> > +EXPORT_SYMBOL(xhci_plat_override_driver);
> 
> EXPORT_SYMBOL_GPL() please.
> 
> thanks,
> 
> greg k-h
> 

OK. I will modify it on next submission.

Best Regards,
Jung Daehwan

------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_26bfb_
Content-Type: text/plain; charset="utf-8"


------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_26bfb_--
