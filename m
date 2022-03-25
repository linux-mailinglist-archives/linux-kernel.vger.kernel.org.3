Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2335D4E6C68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357710AbiCYCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357690AbiCYCMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:12:13 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE47A9979
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:10:06 -0700 (PDT)
Received: from epcas3p2.samsung.com (unknown [182.195.41.20])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220325021002epoutp03c7eee1254da946606e66660942ee8d9d~ffbSDfDpR1934919349epoutp03N
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 02:10:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220325021002epoutp03c7eee1254da946606e66660942ee8d9d~ffbSDfDpR1934919349epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648174202;
        bh=JeyKg0UkfoLEj0vARb9q4+AYCvTCt6mrbg2MqfL/kXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uXl9si+ljYQxuuKUXtf3N2SuX4CMP0Xi4L3CpQVjN7HLN41amM4HtosgOVsYmyh+q
         oJyzZI8mYWXnm6Bn39picj/A8pVWQq//usmLfU8lBrDYHAStME8Rwb25fy8twYL6Z8
         F0WBTgh2rQKCc0qzFOWmvpXjMYcvkhlXjlkR1MmY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220325021002epcas3p1fa9cd91c170a6eb7f7978e0446e3a44a~ffbRhT3Rt0626606266epcas3p1Y;
        Fri, 25 Mar 2022 02:10:02 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4KPlsk1TvNz4x9QB; Fri, 25 Mar 2022 02:10:02 +0000
        (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220325020911epcas2p4740a9f85f00e78ac4c6155335835c067~ffah49VpF3135531355epcas2p4x;
        Fri, 25 Mar 2022 02:09:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220325020911epsmtrp17e5a9c731c851f4cf36172abb480ae25~ffahzNoFX2722427224epsmtrp1G;
        Fri, 25 Mar 2022 02:09:11 +0000 (GMT)
X-AuditID: b6c32a29-41fff700000074af-22-623d24467d59
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.2F.29871.6442D326; Fri, 25 Mar 2022 11:09:10 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325020910epsmtip183e1c00a03d5f8e7aa89d3038367c02e~ffahgY4og2894728947epsmtip1V;
        Fri, 25 Mar 2022 02:09:10 +0000 (GMT)
Date:   Fri, 25 Mar 2022 11:07:50 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <1889248251.21648174202185.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
In-Reply-To: <YjsH5Jtwd4JlXJ6g@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTtdNxTbJ4GCrmcWKw/MYLV4e0rTY
        /PAKm8WTI4vYLZoXr2ezuP7nPaNF+/MLbBbnz29gt7i8aw6bxaJlrcwWzZumsFrMXKts0XX3
        BqMDr8flvl4mjwWbSj0W73nJ5LFpVSebx/65a9g9Wk7uZ/Ho27KK0ePzJrkAjigum5TUnMyy
        1CJ9uwSujIevpjMXvOCtuHNjNksD40GuLkZODgkBE4ntXy8xdjFycQgJ7GaUWHrsNjNEQlJi
        6dwb7BC2sMT9liOsEEWPGCXWnVrBBpJgEVCVWPl0JyOIzSagJXHvxwmwZhEBY4n+s7PAmpkF
        tjJL7NkcCWILC3hJ/Hz2jRXE5gWqP/Z8LxOILSTQzSzx4XkpRFxQ4uTMJywQvVoSN/69BKrh
        ALKlJZb/4wAJcwpoSpw8dpQFJCwqoCLx6mD9BEbBWUiaZyFpnoXQvICReRWjZGpBcW56brFh
        gWFearlecWJucWleul5yfu4mRnBUaWnuYNy+6oPeIUYmDsZDjBIczEoivPcvWycJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwNR4TeTCzFNSHSeUjmuF
        83k9Lft2+vDG4OZcptnpGc+e7b51zm2bBDuvZZZEaX9Grd6qFw+3MmkwbW61uvE3LpLl2tkn
        sp/OarzZ48HXOe/y7ZwJM39PXql3xf3m3gl/HpqGLF+jra1/QfQRPxfXNMUYCf89F6/dyZfI
        3etr/4vpfX5nTfIs1UDrcLZVTEsfC9rcEC3q83p2tsXhn/8kxuu+piu+5KxyaajfNfmV9JPd
        t/ye7BT992fWwa0phw7mzVj+yb92lseurwdyFzz0vNf22qE6fNrEe9LZj9JvX+jvVXZZInA+
        cZHe+7Itix8UXm6uP6eZ1f46UGWb8kTLfIE2t7zF2x/U1v3uvWRv1vlLiaU4I9FQi7moOBEA
        SbEtERkDAAA=
X-CMS-MailID: 20220325020911epcas2p4740a9f85f00e78ac4c6155335835c067
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_602f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220304062617epcas2p2084161966aaa66d07f4c25720ec18088
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
        <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
        <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
        <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
        <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
        <YjsH5Jtwd4JlXJ6g@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_602f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 23, 2022 at 12:43:32PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 23, 2022 at 10:41:23AM +0100, Krzysztof Kozlowski wrote:
> > On 23/03/2022 03:58, Jung Daehwan wrote:
> > > On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
> > >> On 04/03/2022 07:23, Daehwan Jung wrote:
> > >>> Export symbols for xhci hooks usage:
> > >>> 	xhci_ring_free
> > >>> 	- Allow xhci hook to free xhci_ring.
> > >>
> > >> Instead of copying-pasting the name of function, please explain why do
> > >> you need these symbols exported.
> > >>
> > >> The "Why" is actually one of most important questions, because "what is
> > >> this patch doing" we can easily see...
> > >>
> > >>>
> > >>> 	xhci_get_slot_ctx
> > >>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> > >>> 	  for getting the slot_ctx information to know which slot is
> > >>> 	  offloading and compare the context in remote subsystem memory
> > >>> 	  if needed.
> > >>>
> > >>
> > >>
> > >> Best regards,
> > >> Krzysztof
> > >>
> > > 
> > > Hi Krzysztof
> > > 
> > > xhci_ring_free has been removed from v3..
> > > The reason why I want to export is for managing vendor specific ring.
> > > I want to alloc and free vendor specific ring on specific address.
> > > It's done with xhci hooks.
> > 
> > It's better, but still does not explain why these have to be exported.
> > Please mention where are these hooks going to be. Where are they
> > implemented. I actually expect all of these exports to be used in your
> > patchset.
> 
> All exports _HAVE_ to be used by the patchset.  Otherwise it's an
> invalid submission.
> 
> thanks,
> 
> greg k-h
> 

Yes. I removed unneeded exports on v3.

Best Regards,
Jung Daehwan

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_602f_
Content-Type: text/plain; charset="utf-8"


------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_602f_--

