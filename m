Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4750FB22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiDZKlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349763AbiDZKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:39:38 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D126AC3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:28:46 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220426102844epoutp0297fc4c898f3e798670eda44008097efa~pa31j_o9W2147521475epoutp02M
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220426102844epoutp0297fc4c898f3e798670eda44008097efa~pa31j_o9W2147521475epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650968924;
        bh=slfFrq6nRcUqQc5I3UtotE7GYa2j2v4WbRizaECVYmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QkNEz4HpPBtNKSu7V97s32JED8rFH0I1wPythazfDxQjeebj2bm2mXolX6qtK7mPV
         cjhWn++qmXnPj0o75yc4fZBkIThpD0snkp9lbiV1bRHI+badAhikt+6GEBGOmCfV9Z
         Pc2DXCwZCiDHcn/AgkWPG85JkjGOz9Wg5jqJhF+k=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220426102843epcas2p1895572de54cc338805db4cbb216a5fc0~pa30034VX0522805228epcas2p12;
        Tue, 26 Apr 2022 10:28:43 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KndQK2L60z4x9Q6; Tue, 26 Apr
        2022 10:28:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.43.10028.959C7626; Tue, 26 Apr 2022 19:28:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220426102840epcas2p44a3622bac0d91e8dfba39f014ec62cc9~pa3xcBbWh3173431734epcas2p4X;
        Tue, 26 Apr 2022 10:28:40 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220426102840epsmtrp20378ac0d2233955e1dd0036bc7711a96~pa3xaHBqa1951619516epsmtrp2x;
        Tue, 26 Apr 2022 10:28:40 +0000 (GMT)
X-AuditID: b6c32a47-589ff7000000272c-3d-6267c959eed7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.5B.08924.859C7626; Tue, 26 Apr 2022 19:28:40 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220426102840epsmtip1a4d52c5567c75abe2e9daa1a36c47602~pa3xOLUnU1314813148epsmtip1m;
        Tue, 26 Apr 2022 10:28:40 +0000 (GMT)
Date:   Tue, 26 Apr 2022 19:27:09 +0900
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
Subject: Re: [PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use
 xhci hooks
Message-ID: <20220426102709.GA175152@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmfBSLDiZGkvu3sG@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmuW7kyfQkg29rBSyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDxmNfSyeVzu62Xy
        WLCp1GPxnpdMHvvnrmH36NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ39qXMxZ8EKronbOGpYFxG18XIyeHhICJxKct
        b1m7GLk4hAR2MEpc27WVCcL5xChx++VCFgjnM6PEgYcNbDAtV972s0EkdjFK/L64A8p5wijR
        /G4SO0gVi4CqxMKXN5lBbDYBLYl7P06A2SICxhL9Z2exgzQwC7xkkmi/NQHI4eAQFoiU2NBv
        AVLDK6AjcWTjLFYIW1Di5MwnLCA2p4CmxI8du9lAykUFVCReHayHOGguh8SEX8UQtovEmjOb
        GSFsYYlXx7ewQ9hSEp/f7YV6oFhi16dWsDclBBoYJRofQNwmAXTbrGftYM3MAhkSnx61MYPs
        khBQljhyiwUizCfRcfgvO0SYV6KjTQiiU1li+uUJrBC2pMTB1+egOj0kts0QhITON0aJT/O2
        ME9glJ+F5LFZSJZB2DoSC3Z/YpsF1M4sIC2x/B8HhKkpsX6X/gJG1lWMYqkFxbnpqcVGBcbw
        uE7Oz93ECE63Wu47GGe8/aB3iJGJg/EQowQHs5II71TVtCQh3pTEyqrUovz4otKc1OJDjKbA
        WJrILCWanA9M+Hkl8YYmlgYmZmaG5kamBuZK4rxeKRsShQTSE0tSs1NTC1KLYPqYODilGphW
        7ejZ4Zp357jadeYJTwxbP111PJi4/urk8iTB7fsDVjOGCh/q48xrMev7/vrz7s0LjxipTpj/
        uz5LXNUhMM7s47MptdNnvN76ytBwjsPGlOe/DxbO3jJdhVnJsEH29L2ngb81Iw51zSleVLAr
        Y0cXx32Tl4/KX7r1T5zanPRDfPWOj4Z3Bf1beu+uzZridbHcqLKYS5xV2S0q6s6qipve0zau
        brTP9LqZnh2nbiyusnoN748aSzG+04ZSj04rC7PWxSh9Ytd3Lkl5Kh/+1JTreHNi35aSHW/v
        9+Tc4hYX3xYb+cFp6VZhvUNR26W1fsevi5dek3WzVd/+2JGHvOwdjRL7Y1l6uc++Dd3g81iJ
        pTgj0VCLuag4EQBBm80KQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnG7EyfQkg2U3OSyeHFnEbtG8eD2b
        xfU/7xkt2p9fYLPY+PYHk8XlXXPYLBYta2W2aN40hdVi5lpli667NxgduDxmNfSyeVzu62Xy
        WLCp1GPxnpdMHvvnrmH36NuyitHj8ya5APYoLpuU1JzMstQifbsEroxX7feZCjYIVCzo/s3Y
        wNjP08XIySEhYCJx5W0/WxcjF4eQwA5GiT2L3zJDJCQlls69wQ5hC0vcbznCClH0iFGi7cAO
        NpAEi4CqxMKXN8Ea2AS0JO79OAFmiwgYS/SfncUO0sAs8JZJYtOUD0xdjBwcwgKREhv6LUBq
        eAV0JI5snAU19BujxNTvv1ggEoISJ2c+AbOZgYbe+PcSrJdZQFpi+T8OkDCngKbEjx272UDC
        ogIqEq8O1k9gFJyFpHkWkuZZCM0LGJlXMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
        R4yW1g7GPas+6B1iZOJgPMQowcGsJMI7VTUtSYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T
        8UIC6YklqdmpqQWpRTBZJg5OqQYmo0JWFfafnOxPl8gmV/NVlLOa8S85oNixyohJa75k4S63
        4EsLD1gUXZoet6Y0NkvxppuouFduq8/ekExduUcFQbNaxDaHrLI86d89LaZAedMEhUdPghTO
        3n5yp6ytyytXuiFg4XQx1ajgTx+nttgv1Wwtz4r3eRm69FhJ9ZoGx0NnssMVf3zc+HBp8nyv
        hHdrNrRe0We4wv9d6nL3kjDWuZ8uLtW1nfTuF/OPjdHdnHx8j9T/TDL+sPSL2cs1yZPNTzCe
        MzR+b/nbI7L9x3tO+fNBm16+nMfvP6+Q/ZG+Q5r0x8wQ7kefl81q/KcU9ETYOlTgwrXqlsNH
        VLdE2v04yeSqEs+/+6zP+ydsU5YrsRRnJBpqMRcVJwIAkJ0V0gcDAAA=
X-CMS-MailID: 20220426102840epcas2p44a3622bac0d91e8dfba39f014ec62cc9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_19fa2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092021epcas2p4071f2b7621558a015579131990486a3c
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092021epcas2p4071f2b7621558a015579131990486a3c@epcas2p4.samsung.com>
        <1650964728-175347-2-git-send-email-dh10.jung@samsung.com>
        <YmfBSLDiZGkvu3sG@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_19fa2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 11:54:16AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 06:18:44PM +0900, Daehwan Jung wrote:
> > Export symbols for xhci hooks usage:
> >     xhci_get_slot_ctx
> >     xhci_get_endpoint_address
> >     - Allow xhci hook to get ep_ctx from the xhci_container_ctx for
> >       getting the ep_ctx information to know which ep is offloading and
> >       comparing the context in remote subsystem memory if needed.
> > 
> >     xhci_ring_alloc
> >     - Allow xhci hook to allocate vendor specific ring. Vendors could
> >       alloc additional event ring.
> > 
> >     xhci_trb_virt_to_dma
> >     - Used to retrieve the DMA address of vendor specific ring. Vendors
> >       could get dequeue address of event ring.
> > 
> >     xhci_segment_free
> >     xhci_link_segments
> >     - Allow xhci hook to handle vendor specific segment. Vendors could
> >       directly free or link segments of vendor specific ring.
> > 
> >     xhci_initialize_ring_info
> >     - Allow xhci hook to initialize vendor specific ring.
> > 
> >     xhci_check_trb_in_td_math
> >     - Allow xhci hook to Check TRB math for validation. Vendors could
> >       check trb when allocating vendor specific ring.
> > 
> >     xhci_address_device
> >     - Allow override to give configuration info to Co-processor.
> > 
> >     xhci_bus_suspend
> >     xhci_bus_resume
> >     - Allow override of suspend and resume for power scenario.
> > 
> >     xhci_remove_stream_mapping
> >     - Allow to xhci hook to remove stream mapping. Vendors need to do it
> >       when free-ing vendor specific ring if it's stream type.
> > 
> 
> For the static functions that you are now exporting, they need to have
> their functions declared in a .h file.  If not, you now get warnings
> when you run sparse after applying this commit, right?
> 
> thanks,
> 
> greg k-h
> 

I didn't get warnings in my environment. I tested to build default config +
xhci_exynos by make command. Is there compile option to check it?

Best Regards,
Jung Daehwan

------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_19fa2_
Content-Type: text/plain; charset="utf-8"


------hGW09vigct5GtelhzIuvqVc_4Oej0kyi.rk8YCr72wPxMaPi=_19fa2_--
