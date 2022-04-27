Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802795115FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiD0LDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiD0LDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:07 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B03FE7DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:44:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220427092601epoutp03fcd3686dc4a0e0d4e9d59f76248e4e2d~ptqWp2huO2927229272epoutp03c
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:26:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220427092601epoutp03fcd3686dc4a0e0d4e9d59f76248e4e2d~ptqWp2huO2927229272epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651051561;
        bh=LVrAR6U/FmmnHSDtHKemvGeAtbfv/7CTfOZEnLDa1bE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IwSpYMY/ePj5Bf9opeBvQ0bCPmwn98i1h07qwkPg++ANAlFrz+hnlXebhFkiyXtgI
         +C96wZTqr1ceJwKfmjbDirnyw/Rkqcayd76RqwChxZmo0MXX3e4lIUfGR/RkgRQwJo
         bqsVWkJMpp+rFQki+0CueK/HMlnjaoSSR0FX4+mo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220427092600epcas2p1ef72bae7579196aed349d50004b0c7b7~ptqWJcDbR0411504115epcas2p1y;
        Wed, 27 Apr 2022 09:26:00 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KpCzV4Gx7z4x9Q2; Wed, 27 Apr
        2022 09:25:58 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.69.10028.42C09626; Wed, 27 Apr 2022 18:25:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427092555epcas2p2013960eebe2e43d045e3861b381080de~ptqRdCmbh1819218192epcas2p2W;
        Wed, 27 Apr 2022 09:25:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427092555epsmtrp11c6c0f7315f832da43351963065ae01f~ptqRcMnWt3063430634epsmtrp1W;
        Wed, 27 Apr 2022 09:25:55 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-74-62690c247cd7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.2B.08924.32C09626; Wed, 27 Apr 2022 18:25:55 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427092555epsmtip15dacd806532fd3cb35a3550ec90a69d1~ptqRT90_E2751627516epsmtip1S;
        Wed, 27 Apr 2022 09:25:55 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:24:26 +0900
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
Subject: Re: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Message-ID: <20220427092426.GD145620@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YmfHtFFIJp6z7ysK@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmqa4KT2aSwfSd/BZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6zGnrZPC739TJ5
        LNhU6rF4z0smj/1z17B79G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0HVKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMT9cWMxes56rY/vQYcwPjRY4uRk4OCQETiZev
        XjB2MXJxCAnsYJT4v6mPGcL5xChx8UALVOYzo0R3x10mmJaFd7awQCR2MUrMPTqbCcJ5wihx
        eE0vO0gVi4CqRNO9nywgNpuAlsS9HyeYQWwRAWOJ/rOz2EEamAVeMkm035oA1iAsYCvxa+tO
        RhCbV0BHYs6tOVC2oMTJmU/ABnEKaEosmzcRyObgEBVQkXh1sB5kjoTAQg6JCw3TWCDOc5F4
        sqODHcIWlnh1fAuULSXxsr8Nyi6W2PWplQmiuYFRovEBxHUSQNfNetYOtphZIEPi3+71zCDL
        JASUJY7cYoEI80l0HP7LDhHmlehoE4LoVJaYfnkCK4QtKXHw9TmoiR4S355uZAOxhQS+MUos
        aQ+ewCg/C8lns5Asg7B1JBbs/sQ2C2gDs4C0xPJ/HBCmpsT6XfoLGFlXMYqlFhTnpqcWGxUY
        w2M7OT93EyM45Wq572Cc8faD3iFGJg7GQ4wSHMxKIrxfdmckCfGmJFZWpRblxxeV5qQWH2I0
        BcbTRGYp0eR8YNLPK4k3NLE0MDEzMzQ3MjUwVxLn9UrZkCgkkJ5YkpqdmlqQWgTTx8TBKdXA
        xCouvregyizrzLSVLglWr7XXLy1NuffylYj1brdXOlNmtNbZxAryf3LV7cswrciT3FWdn1va
        G7zDfoHp4t4N305w8u22+8QaNjPXt09gi7BDSurlX4fOHZdXZnh3dPe2Bk93mf4g14wnzztO
        Ste/9Q5qcI3h131a2SPReyqrWnRt9RomH54jvQeltX8cul3W8Ua3UvD0l4PiRSdZTk+cmhvQ
        FclaM2FZoW/qlLj029F8X578cH0/aXNBqZl/pNveU6ZxCS4ixb6rF5bd/5VxTZ75q5m/b/Tj
        pbtfuT+XOj694c6ClmLd3w9MlF+Fvqz7f0cocPaj4jv3RSPmhSX7fXriZrZT7INc2OOkZ+ZK
        LMUZiYZazEXFiQDrMj29QgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSnK4yT2aSweFDEhZPjixit2hevJ7N
        4vqf94wW7c8vsFlsfPuDyeLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6zGnrZPC739TJ5
        LNhU6rF4z0smj/1z17B79G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8ad5llsBe/ZK9a0dLE2
        MK5i62Lk5JAQMJFYeGcLSxcjF4eQwA5Gibfn/jNBJCQlls69wQ5hC0vcbznCClH0iFHi/dyn
        jCAJFgFViaZ7P1lAbDYBLYl7P04wg9giAsYS/WdnsYM0MAu8ZZLYNOUD2FRhAVuJX1t3gjXz
        CuhIzLk1hxFi6jdGieYH61kgEoISJ2c+AbOZgabe+PcSqJkDyJaWWP6PAyTMKaApsWzeRBaQ
        sKiAisSrg/UTGAVnIWmehaR5FkLzAkbmVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsY
        wTGjpbWDcc+qD3qHGJk4GA8xSnAwK4nwftmdkSTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDE+dP1q7cNaxWCwSO8/EKmuddmsh1uafyeKSt7fTLbL8+
        ybEG+Ujkf5j3+F7ZLC6RV4e3+u7QUF1ar2m1+5aD7/8327s4PLet+jzrbGLkr7lCx4wcpfXm
        8bmxnWS5PZXhq9Y1u8Mram7LmFjsvpo3l2PPi/JZQeKXzt1rkr/4MPFjSGFFziueunkHp5/Y
        aicpUHOt8baB4jyHV18WnG2YvLae0d05g7H5pyTHoq2/nf7OsO4KSf7eHidp8STOM+R5QMFM
        z49JNi9vqnx2N126wi6i8MWxe4vezrX7bMO4nvf4okktUZM6/G/fn+rUtXBSvlSm/vsJs+a5
        xZ1nnRCXX6e2o/jA30mq07vzLol1rlNiKc5INNRiLipOBADj43VDCAMAAA==
X-CMS-MailID: 20220427092555epcas2p2013960eebe2e43d045e3861b381080de
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26dc2_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
        <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
        <YmfHtFFIJp6z7ysK@kroah.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26dc2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 26, 2022 at 12:21:40PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 26, 2022 at 06:18:48PM +0900, Daehwan Jung wrote:
> > +int xhci_check_trb_in_td_math(struct xhci_hcd *xhci);
> > +void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg);
> > +void xhci_link_segments(struct xhci_segment *prev,
> > +		struct xhci_segment *next,
> > +		enum xhci_ring_type type, bool chain_links);
> > +void xhci_initialize_ring_info(struct xhci_ring *ring,
> > +					unsigned int cycle_state);
> > +void xhci_remove_stream_mapping(struct xhci_ring *ring);
> 
> Why does your single driver have global functions?  That should not be
> needed, right?
> 
> And these are odd for a driver's namespace...
> 

Those are exported in 1st patches. it's not good to include here as you said.
Let me declare in xhci.h instead in below patch.

[PATCH v4 1/5] usb: host: export symbols for xhci-exynos to use xhci hooks

Best Regards,
Jung Daehwan.

> thanks,
> 
> greg k-h
> 

------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26dc2_
Content-Type: text/plain; charset="utf-8"


------kYpNrMA5Q_pRug.oZbu8Kwk_59qkkrrEmQqQB0Vp_jfuzgSx=_26dc2_--
