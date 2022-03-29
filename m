Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5E4EA555
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiC2CjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiC2CjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:39:14 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2742467E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:37:31 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220329023725epoutp022177b438111f3f628a62a4325d228de6~guYUr2tFZ1388513885epoutp02W
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:37:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220329023725epoutp022177b438111f3f628a62a4325d228de6~guYUr2tFZ1388513885epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648521445;
        bh=LseEkrOba10r7Ej/ZEJ+aFuPcU3jHjgYzZGf4Lb0HW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FKQLD0oGuIi1cehb9Pe+peVU/B/GJmLwzF5+GTntVTo7ClSIkl4zDUu6kUkUO0aNE
         trtP09g1yudet7pDLiVWFCKGGBm9bSmO7ZqfTZOVMPR+jDSTyMJa0JRkOeI/BZnG9t
         r/x2xdgUdk7EWZ/gA0O1MImbGM8RZhBLjAf+duyo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220329023724epcas2p2264146bdbeea107eacea6f36e31a3598~guYUFheT60704107041epcas2p24;
        Tue, 29 Mar 2022 02:37:24 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KSDHP733cz4x9QF; Tue, 29 Mar
        2022 02:37:21 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.13.16040.ED072426; Tue, 29 Mar 2022 11:37:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220329023718epcas2p3390e740d7b77e7ad0f60b1fd7f8f8c25~guYOCpnUV2180821808epcas2p3G;
        Tue, 29 Mar 2022 02:37:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220329023718epsmtrp2d3cef55adea1c7ae0cc2c1248aa3506a~guYOBxvWp2958829588epsmtrp2i;
        Tue, 29 Mar 2022 02:37:18 +0000 (GMT)
X-AuditID: b6c32a46-be9ff70000023ea8-dc-624270de5d54
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.70.24342.DD072426; Tue, 29 Mar 2022 11:37:17 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220329023717epsmtip114d261121053626dc3ad9c2bf9850d38~guYN0s-3f3030530305epsmtip1a;
        Tue, 29 Mar 2022 02:37:17 +0000 (GMT)
Date:   Tue, 29 Mar 2022 11:35:49 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Message-ID: <20220329023549.GA174737@ubuntu>
MIME-Version: 1.0
In-Reply-To: <0366bcc4-b38d-db36-22d6-e6f33af9dbef@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmue69Aqckg4OXZC2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izjt9pZiqYyV3x8s9uxgbGCZxdjJwcEgImElt7
        zzJ2MXJxCAnsYJS4s+A2I0hCSOATo0TL9kSIxDdGiT0/LrN0MXKAdczo8oOo2csosWifIUTN
        E0aJI/0z2EFqWARUJbZ+4gGpYRPQkrj34wQziC0ioClx/e93VpB6ZoHHTBIt76azgySEBWwl
        rt+8B2bzCuhIHHq7jBXCFpQ4OfMJC4jNKWAn8X7BXlaQ+aICKhKvDtaDzJEQmMshMWPFIkaI
        21wk3k3SgHhMWOLV8S3sELaUxOd3e9kg7GKJXZ9amSB6GxglGh9AHCchYCwx61k72PPMAhkS
        b18/ZIWYqSxx5BYLRJhPouPwX3aIMK9ER5sQRKeyxPTLE1ghbEmJg6/PQU30kJj+7TgLJHju
        M0nc3nmYcQKj/Cwkn81Csg3C1pFYsPsT2yygFcwC0hLL/3FAmJoS63fpL2BkXcUollpQnJue
        WmxUYASP6eT83E2M4FSr5baDccrbD3qHGJk4GA8xSnAwK4nwyp61TxLiTUmsrEotyo8vKs1J
        LT7EaAqMponMUqLJ+cBkn1cSb2hiaWBiZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+J
        g1OqgemYdGnt5OKs//4hfRtPVmu9j/c13J9xNcxnkunst1ukZnkufX55vZJs1KrEgjkL2zv0
        Qm7fmHRpaa4+/7wH3TlN+6t3p+7/2zUx5PWR6i8+xsEXNMz+z0i+6NL6vmSPXDXHHWvZDt5f
        K94v8j0ToGkeks4YZlv2bd71aR9fuk75dWXXfLvo4utWt1JM0m7sn73t/8yJNXtszV64xC59
        ++uF7H3piqaw3MuezCl3A+SL8tIUHvOKah5UWOTAGjR111LD+5M9RQSW/TtQc6kp+cyEOTPf
        3bqyPI7vt92FPy97fr9YVLDKYcN5gyB3r1Atr/qdZ5jShcIeh8UyfTXsPJNX5rlFMWWV1IQd
        ppIBnRuUWIozEg21mIuKEwF6ZfOsPgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSnO7dAqckgxUbrS2eHFnEbtG8eD2b
        xfU/7xkt2p9fYLM4f34Du8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDwu9/UyeSzYVOqx
        eM9LJo9NqzrZPPbPXcPu0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnLNkxmKbjJUTFp2S3m
        BsaXbF2MHBwSAiYSM7r8uhi5OIQEdjNK9C2Yw9zFyAkUl5RYOvcGO4QtLHG/5QgrRNEjRokT
        nY/YQZpZBFQltn7iAalhE9CSuPfjBFiviICmxPW/38HqmQWeMkks3tjGBJIQFrCVuH7zHthQ
        XgEdiUNvl0ENvc8k0f7tOlRCUOLkzCcsIDYz0NQb/14ygSxjFpCWWP6PAyTMKWAn8X7BXlaQ
        sKiAisSrg/UTGAVnIWmehaR5FkLzAkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsY
        wfGipbmDcfuqD3qHGJk4GA8xSnAwK4nwyp61TxLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qByURzarz3yhdrg65snfpF7GpEyYU/HZk6Txac0V10adeX
        jxKlypM275E+UXJvrpKI/5beWU/nvlxZ12c3K7hxruXV0wUuxW7arT0r92337lZaKi2Vt7dD
        5ijbNrnbDFV3TspP/FzzPrX1j2iSzCpjo61Xrj16NznXVstXd9Vk/3DOLzaBQhs+JHeF7ZPZ
        2p7DFamlcMTpQV/39PD+ENmNh9U+Rx5rO2XAGGXKO3v79U3TtQVNo3fVFYmtOb2fif1n/NXX
        c9xtv2w9XqugwTBRPOJsp8fsrfl6K8y9bpmGKL5XDlsWzHv0/pZfF92YvnEHPvh001XAIEw9
        zVQ41915gXro03+cTZPn1Cc7Xt5bpMRSnJFoqMVcVJwIAMNr6WwGAwAA
X-CMS-MailID: 20220329023718epcas2p3390e740d7b77e7ad0f60b1fd7f8f8c25
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----ONjdBwygxer2qCWpL6Cfkdc2CTGKeo01bleMSM1m.vqr4jSS=_275d1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
        <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
        <ad877924-68bb-f029-258a-0cf9094265eb@kernel.org>
        <20220323023420.GC19041@ubuntu>
        <0366bcc4-b38d-db36-22d6-e6f33af9dbef@kernel.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------ONjdBwygxer2qCWpL6Cfkdc2CTGKeo01bleMSM1m.vqr4jSS=_275d1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 23, 2022 at 09:26:13AM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2022 03:34, Jung Daehwan wrote:
> > On Tue, Mar 22, 2022 at 06:10:00PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/03/2022 09:59, Daehwan Jung wrote:
> >>> This driver supports USB Audio offload with Co-processor.
> >>
> >> One do you need one more XHCI driver? How does it differ from existing
> >> and why existing cannot be extended?
> > 
> > I have some exynos specific features and that's because need own driver.
> > It's not good to modify other XHCI driver for my features.
> > 
> > Additinally, I've been developing some features with other IP or Co-Processors.
> > Extending is not enough to cover them and I think owning driver is also better
> > on structural view.
> 
> This reason is not good enough because it's not visible that you cannot
> extend existing drivers.
> 
> 
> Best regards,
> Krzysztof
> 

I could extend existing drivers as you said. It needs big change on my
driver and it could take long time... I'm going to try it. Thanks for
the comment.

Best Regards,
Jung Daehwan

------ONjdBwygxer2qCWpL6Cfkdc2CTGKeo01bleMSM1m.vqr4jSS=_275d1_
Content-Type: text/plain; charset="utf-8"


------ONjdBwygxer2qCWpL6Cfkdc2CTGKeo01bleMSM1m.vqr4jSS=_275d1_--
