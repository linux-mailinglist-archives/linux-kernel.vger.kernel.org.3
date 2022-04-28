Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17035129F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiD1D2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiD1D2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:28:46 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418A329CB7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:25:32 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220428032527epoutp03fda4a12081491f51739c37e8188877f2~p8Y1a2bqm2470824708epoutp03x
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:25:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220428032527epoutp03fda4a12081491f51739c37e8188877f2~p8Y1a2bqm2470824708epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651116327;
        bh=H48D98mBYPeIfLM4lqAMsgIQ3kfMp5sIX5KNAX7/sHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rtCCb84PN3W0o3jBb3vRt+l49gWegqfzxGVeIy+WUMFb4U/hukFmpsWl+lIDssZyF
         91E8xGlTU4dKbHPbclqBEEZRE5gDED+21sLpCk0Q30MGBxvGf+biLTUCOF7PPk7fru
         Gf+JmAsJ0lUWJRvj7sJym0xDrosVdMqnMH1uANvQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220428032527epcas2p29fd10698612a1df9d6d5e620f5d26eaa~p8Y050BbR1590015900epcas2p2F;
        Thu, 28 Apr 2022 03:25:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Kpgx037D2z4x9Q5; Thu, 28 Apr
        2022 03:25:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.29.09764.4290A626; Thu, 28 Apr 2022 12:25:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220428032523epcas2p235eaa6070679bf999f9477a6d7ddf788~p8YxlUm2L1780317803epcas2p2y;
        Thu, 28 Apr 2022 03:25:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220428032523epsmtrp2b2bc15d6872829269e17e8f2f24a55ab~p8YxkaMTO0887908879epsmtrp2b;
        Thu, 28 Apr 2022 03:25:23 +0000 (GMT)
X-AuditID: b6c32a46-f8bff70000002624-34-626a0924a1ee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.30.08853.3290A626; Thu, 28 Apr 2022 12:25:23 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428032523epsmtip28d53c056ec7839107ddbb9209ae0c506~p8YxbE2NX1326813268epsmtip2O;
        Thu, 28 Apr 2022 03:25:23 +0000 (GMT)
Date:   Thu, 28 Apr 2022 12:23:54 +0900
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
Subject: Re: [PATCH v4 2/5] usb: host: add xhci hooks for xhci-exynos
Message-ID: <20220428032354.GB151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmkKnQEhJzk84fHj@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmha4KZ1aSwbIp4hZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6zGnrZPC739TJ5
        LNhU6rF4z0smj/1z17B79G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0HVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMvcfeMBec16g4etC1gXGvfBcjJ4eEgIlEc/9k
        xi5GLg4hgR2MEncfbGCHcD4xShxd9IkJwvnGKNE38Q8jTMuCnb/YQWwhgb2MEnNuFEIUPWGU
        +N58mhkkwSKgKtF08RwTiM0moCVx78cJsLiIgLFE/9lZYCuYBV4ySbTfmgA2SVjAVWLzhyMs
        IDavgI7E8xttbBC2oMTJmU/A4pwCmhKXXx8HuoKDQ1RAReLVwXqQORICczkkPhy5ywRxnYtE
        298brBC2sMSr41vYIWwpic/v9rJB2MUSuz61MkE0NzBKND6AuE4C6LpZz9rB3mQWyJDoO/SZ
        HWSZhICyxJFbLBBhPomOw3+hwrwSHW1CEJ3KEtMvT4BaKylx8PU5qIkeEk0vvkHDdxuTxI1P
        E9gmMMrPQvLaLCTbIGwdiQW7P7HNAlrBLCAtsfwfB4SpKbF+l/4CRtZVjGKpBcW56anFRgVG
        8MhOzs/dxAhOuFpuOxinvP2gd4iRiYPxEKMEB7OSCO+X3RlJQrwpiZVVqUX58UWlOanFhxhN
        gRE1kVlKNDkfmPLzSuINTSwNTMzMDM2NTA3MlcR5vVI2JAoJpCeWpGanphakFsH0MXFwSjUw
        KW08+kOas2jdp9URT2Pc1HM9g9bolz88+WrPzux71c9+r5POqL+0wKn8I9Pq0nUMob9iDNJE
        JNsSn79iYBFZkLhTcFau85StshOkdfgnC4pue7w99IF17uKE9OYM4ybOR3c5rju1LBD80uXf
        GmtwvfnjMrsdrO8DgmVt+o9W77tzeYr6mjYbffcZahelzrj9e7T63MP4nbPOGX1Y/zlxe+j9
        ksMvGku+RVl9PRbUI7KA/9ubR6kXZRx6F+Xv4mzYm/lCP2L9DY2kwCddtWeMMpeZnzc43uzl
        pdo98eRjiUlbd+pKhPiubG8582hTh9b7tOC6nYL5//dNUpFUtjq01vy8TILHc/6tX1fwOgg9
        VGIpzkg01GIuKk4EALz2eYBBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvK4yZ1aSwZlzahZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6zGnrZPC739TJ5
        LNhU6rF4z0smj/1z17B79G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV0Z7937mgn61iis9/5gb
        GKfJdjFyckgImEgs2PmLvYuRi0NIYDejxIIpc5kgEpISS+feYIewhSXutxxhhSh6xChxZs8e
        ZpAEi4CqRNPFc2ANbAJaEvd+nACLiwgYS/SfnQU2lVngLZPEpikfwIqEBVwlNn84wgJi8wro
        SDy/0cYGMXUHk8TJFysZIRKCEidnPgErYgaaeuPfS6BmDiBbWmL5Pw6QMKeApsTl18cZQcKi
        AioSrw7WT2AUnIWkeRaS5lkIzQsYmVcxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTH
        jJbmDsbtqz7oHWJk4mA8xCjBwawkwvtld0aSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUzemeujawIlu6/+tFlwa5dr8n0RWe/ZMbN/sAuVrd1fct2W
        zXh6jvWUePX3x3ITtJOv27G9m/Eq5HQvr/vM2qpj8n4h855N+Gq7yJ9Jc8VThu0FBzTyJI3n
        hBz5YD9r6aFFSlcyD0lUrTdc/az9selaeQaeF/INVRInJErfVYlNkiviD/1+lnn5bsPYBTc2
        h6/Pv/zlEheTx9S4G2arzc/cPznn0ZUesSDtwGuBd60/8tmV1P0TPXfkpZvo2jUCG1TNz5r0
        Slx4079QvukU1w+5qCfKa0Lbi/R050Sb2M3M7Axa/Grtk83vJDVkXXaKyBwyj/q/LaU2YC+L
        W/W7Fw58H6Ue+XJdLb9VvstyCosSS3FGoqEWc1FxIgClhccDCAMAAA==
X-CMS-MailID: 20220428032523epcas2p235eaa6070679bf999f9477a6d7ddf788
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_2ef6e_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092021epcas2p1a8d41039d9b3226f4e00f7d4bded833a
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092021epcas2p1a8d41039d9b3226f4e00f7d4bded833a@epcas2p1.samsung.com>
        <1650964728-175347-3-git-send-email-dh10.jung@samsung.com>
        <YmfHJYu9lIwz8JT5@kroah.com> <20220427090617.GA145620@ubuntu>
        <YmkKnQEhJzk84fHj@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_2ef6e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 27, 2022 at 11:19:25AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 27, 2022 at 06:06:17PM +0900, Jung Daehwan wrote:
> > On Tue, Apr 26, 2022 at 12:19:17PM +0200, Greg Kroah-Hartman wrote:
> > > On Tue, Apr 26, 2022 at 06:18:45PM +0900, Daehwan Jung wrote:
> > > > To enable supporting for USB offload, define "offload" in usb controller
> > > > node of device tree. "offload" value can be used to determine which type
> > > > of offload was been enabled in the SoC.
> > > > 
> > > > For example:
> > > > 
> > > > &usbdrd_dwc3 {
> > > > 	...
> > > > 	/* support usb offloading, 0: disabled, 1: audio */
> > > > 	offload = <1>;
> > > > 	...
> > > > };
> > > > 
> > > > There are several vendor_ops introduced by this patch:
> > > > 
> > > > struct xhci_vendor_ops - function callbacks for vendor specific operations
> > > > {
> > > > 	@vendor_init:
> > > > 		- called for vendor init process during xhci-plat-hcd
> > > > 		  probe.
> > > > 	@vendor_cleanup:
> > > > 		- called for vendor cleanup process during xhci-plat-hcd
> > > > 		  remove.
> > > > 	@is_usb_offload_enabled:
> > > > 		- called to check if usb offload enabled.
> > > > 	@alloc_dcbaa:
> > > > 		- called when allocating vendor specific dcbaa during
> > > > 		  memory initializtion.
> > > > 	@free_dcbaa:
> > > > 		- called to free vendor specific dcbaa when cleanup the
> > > > 		  memory.
> > > > 	@alloc_transfer_ring:
> > > > 		- called when vendor specific transfer ring allocation is required
> > > > 	@free_transfer_ring:
> > > > 		- called to free vendor specific transfer ring
> > > > 	@sync_dev_ctx:
> > > > 		- called when synchronization for device context is required
> > > > }
> > > > 
> > > > The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
> > > > For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
> > > > is_usb_offload_enabled ops will be invoked by
> > > > xhci_vendor_is_usb_offload_enabled(), and so on.
> > > > 
> > > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > > Signed-off-by: J. Avila <elavila@google.com>
> > > > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > > > Signed-off-by: Howard Yen <howardyen@google.com>
> > > > ---
> > > >  drivers/usb/host/xhci-hub.c  |   5 ++
> > > >  drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
> > > >  drivers/usb/host/xhci-plat.c |  44 +++++++++++-
> > > >  drivers/usb/host/xhci-plat.h |   8 +++
> > > >  drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
> > > >  drivers/usb/host/xhci.h      |  46 ++++++++++++
> > > >  6 files changed, 296 insertions(+), 18 deletions(-)
> > > 
> > > Why do you need to "override" anything?  Why can't these just be added
> > > to the current xhci_plat_priv structure and used that way like the
> > > current xhci platform interface works?
> > > 
> > 
> > "override" means above xhci hooks? Above hooks are for ring management.
> > In fact, xhci platform doesn't care ring management. That's why I've added hooks
> > not used xhci_plat_priv.
> 
> Why not add ring management ability to the platform interface instead?
> That's what you want to control here, in your platform driver, right?
>

I think xhci platform driver is separated from ring management. I don't
want to disturb current design.

> > > > diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> > > > index 841617952ac7..e07c9c132061 100644
> > > > --- a/drivers/usb/host/xhci-hub.c
> > > > +++ b/drivers/usb/host/xhci-hub.c
> > > > @@ -535,8 +535,13 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
> > > >  	    cmd->status == COMP_COMMAND_RING_STOPPED) {
> > > >  		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
> > > >  		ret = -ETIME;
> > > > +		goto cmd_cleanup;
> > > >  	}
> > > >  
> > > > +	ret = xhci_vendor_sync_dev_ctx(xhci, slot_id);
> > > > +	if (ret)
> > > > +		xhci_warn(xhci, "Sync device context failed, ret=%d\n", ret);
> > > 
> > > Shouldn't the function have spit out an error if there was a problem?
> > 
> > It just reads and sync information about device context. That's why I think
> > it's not critical to go error routime. But it needs to discuss.
> 
> Ok, it looks like this follows the other ways this driver works, that's
> fine.
> 

OK. Thanks.

> > > And no documentiaon for these global function?
> > > 
> > 
> > I thought there's no need to add documentation. They are just functions to call
> > vendor ops and there's documentation of vendor ops above. I could add it if needed.
> 
> Always try to add documentation for when you want others to use the new
> functions, as it helps explain how to use them.
> 

OK. I will add it on next submission.

Best Regards,
Jung Daehwan

> thanks,
> 
> greg k-h
> 

------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_2ef6e_
Content-Type: text/plain; charset="utf-8"


------cRiB1tpB.fFmBV12pIvwQ02nvf4VlLPxB77FAxdBOSXoNZt9=_2ef6e_--
