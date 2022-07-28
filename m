Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E05836A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiG1CFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiG1CFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:05:49 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371058B76
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:05:47 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220728020545epoutp01a1b12489d58081ce29092a638c95cf7a~F3AN0kx7N0539705397epoutp01E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:05:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220728020545epoutp01a1b12489d58081ce29092a638c95cf7a~F3AN0kx7N0539705397epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658973945;
        bh=1InYW9LDjayr9obhARBap5Y8WSK1Ro6VLWIWpFHXP0M=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hEWykS1MZHdW+VRC0io1V3UMxZ38UZtNxPuaKMTf/GYkcybY53ctdKnorwdOcP6sh
         x9C1U7VGHG7RKUCYFGA7PMJmPIDdXt5ZW2sIaUTlnbUkGrMQDLaAusPsHflc6VrpGH
         jW/RavAWQixsRvnC+w3jFk0zucJKgPXm780wYlEg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220728020544epcas1p3f624512369e78847539cd7f89b456779~F3ANkT21Q2519125191epcas1p3B;
        Thu, 28 Jul 2022 02:05:44 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.234]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LtYs35qf2z4x9QF; Thu, 28 Jul
        2022 02:05:43 +0000 (GMT)
X-AuditID: b6c32a35-733ff700000025b9-2a-62e1eef77a41
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.A4.09657.7FEE1E26; Thu, 28 Jul 2022 11:05:43 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH 1/9] trinity: Add base driver
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiho Chu <jiho.chu@samsung.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yelin Jeong <yelini.jeong@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YuE8JNjIBNdg/kkX@kroah.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220728020543epcms1p22f45bba0006bb9fcf04d697d9a2d5ec2@epcms1p2>
Date:   Thu, 28 Jul 2022 11:05:43 +0900
X-CMS-MailID: 20220728020543epcms1p22f45bba0006bb9fcf04d697d9a2d5ec2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmru73dw+TDL4t07X4O+kYu0Xz4vVs
        Fu+7dzNbXN41h83i+bTrLA6sHr9/TWL02D93DbtH35ZVjB6fN8kFsERl22SkJqakFimk5iXn
        p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp29kU
        5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGecX/uRpeAeZ0VH/xHG
        BsbN7F2MnBwSAiYSD+Z0MYHYQgI7GCVm9DJ3MXJw8AoISvzdIQwSFhYwlTjb2MwCUaIk0XBz
        HzNEXF+i48E2RhCbTUBXYuuGu2A1IgKeEr8mrQaq4eJgFuhhlFi99zEzxC5eiRntT1kgbGmJ
        7cu3gjVzCmhKHHi7FCouKnFz9Vt2GPv9sfmMELaIROu9s1BzBCUe/NzNCHInyJyfV/RBdkkI
        TGaUOHniOCOEM4dRYtqGd2wQDfoSZ+aeZIN4zFdizmxRkDCLgKrErMfdTBBzXCSuvfMHCTML
        yEtsfzsHHAzMQKet36UPEeaTePe1hxXmkx3znjBB2GoSh3YvgbpYRuL09IVQV3pITJ1ylR3k
        GiGBK8BgWPmEbQKj/CxE6M5Csm0WwrYFjMyrGMVSC4pz01OLDQsM4fGZnJ+7iRGc6rRMdzBO
        fPtB7xAjEwfjIUYJDmYlEd6E6PtJQrwpiZVVqUX58UWlOanFhxhNgd6cyCwlmpwPTLZ5JfGG
        JpYGJmZGxiYWhmaGSuK8q6adThQSSE8sSc1OTS1ILYLpY+LglGpg4hes+MM/f8q+sguTPnx0
        jMuwdPpvtORZvNypg4q1B4uyBSM6J4pVZuVVtbH9OiXe/NbqbtDvn4vvsO55fX/R9jXzdmq7
        vxab8TZLdv2Mt+7zP0zcry3GfLXI/Yiw3vvlM1b19s+db+ZhEnU4peRU888327IPzO9ayzrR
        e5XkmRC+NIHmF/nGt3f9OSd1bEHuEReXjFrFSrdp73eZGK2+fEnTuDFz56TWqS87bNLCSti2
        TX56bxLHJAOb75HmD3OFJmz2+XNHoz37odSu31U3K/sP1KVkTGu+9pb/kf5JH+EyjQnrtFPv
        q1if3OnD2b+j4EV4uc2lW9Wnsratf23xWzD1vl619vTG5LNOs8+stlFiKc5INNRiLipOBABd
        dNkc/gMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a
References: <YuE8JNjIBNdg/kkX@kroah.com>
        <20220725065308.2457024-1-jiho.chu@samsung.com>
        <20220725065308.2457024-2-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcms1p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > +	help
> > +	  Select this option to enable driver support for Samsung
> > +	  Neural Processing Unit (NPU).
> > +
> > +	  This driver works as a base driver of the other drivers
> > +	  for Trinity device family.
> > +
> > +	  This option should be enabled to support Trinity
> > +	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
> > +
> > +config TRINITY_VISION2
> > +	tristate "Samsung NPU Trinity Vision 2"
> 
> What happened to "vision 1"?

It's designed before Vision 1, but its products are still not yet
released. The two have different target neural networks.

> 
> > +	depends on TRINITY
> > +	default n
> > +	help
> > +	  Select this option to enable driver support for a Samsung
> > +	  Neural Processing Unit (NPU), Tinity Vision 2.
> > +
> > +	  This driver enables userspace system library to access the
> > +	  device via /dev/triv2-N.
> 
> What is the module name?
> 
> Where is the userspace library code that talks to this?  Any
> documentation for this interface anywhere?
> 

I believe Jiho will provide documents soon; however, the userspace
library code is at
https://git.tizen.org/cgit/platform/adaptation/npu/trix-engine/
, which is shipped with 2022 TVs.

Cheers,
MyungJoo
