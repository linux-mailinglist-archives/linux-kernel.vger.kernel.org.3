Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47964D57E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiCKCFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbiCKCFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:05:20 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACBF1A6140
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:04:18 -0800 (PST)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220311020414epoutp01ab565bb08e5de79486a658d3f4a3bbf3~bMUN2d5ai2540025400epoutp01N
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:04:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220311020414epoutp01ab565bb08e5de79486a658d3f4a3bbf3~bMUN2d5ai2540025400epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646964254;
        bh=yn/Becy7OTHWdIJpnrR3Zbb4v9pqtwBMc1iKVor2yUU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fQI1SU68X7s7ffFKffL7Yqu7/iu+D7iG58I32N0JfgwhxTksJ+RDMcEuxT0v7AnyJ
         6lGZKUWUHHB1byIOP0QaojF4kpoanXu6wzUIklTkHRwxyolgUgM6mgNzl+lAiCib2w
         5i3e56igmlDAuSi3sAgBLplt0HIO4+DgO7X/RB7A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220311020414epcas1p2920740de024bae10df319c6ad80f0a04~bMUNn63j-3142931429epcas1p2C;
        Fri, 11 Mar 2022 02:04:14 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KF8PK25gmz4x9Q1; Fri, 11 Mar
        2022 02:04:05 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.A1.21932.C0EAA226; Fri, 11 Mar 2022 11:03:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220311020356epcas1p16744e21871dc18ffef3922cb59f4f4aa~bMT86Qf8h3030830308epcas1p1H;
        Fri, 11 Mar 2022 02:03:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220311020356epsmtrp28f4f96f9b182a3ec072743de5d5b7544~bMT85epPY1480714807epsmtrp2j;
        Fri, 11 Mar 2022 02:03:56 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-f7-622aae0cab52
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.E9.29871.C0EAA226; Fri, 11 Mar 2022 11:03:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220311020356epsmtip2d5f3bb49864a271307c882e31acde27a~bMT8sKU0M1520415204epsmtip2H;
        Fri, 11 Mar 2022 02:03:56 +0000 (GMT)
Subject: Re: [GIT PULL] extcon next for v5.18
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <59f03dd1-6731-87f2-7d4b-51e5058fb9da@samsung.com>
Date:   Fri, 11 Mar 2022 11:28:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <Yipx/1t0We5uGhSQ@kroah.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTT5dnnVaSwfI5xhYTb1xhsWhevJ7N
        4vKuOWwWtxtXsDmweGxa1cnmsX/uGnaPvi2rGD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54vuICa8EM9oqj108wNjA+Zu1i
        5OSQEDCR2Pl4HUsXIxeHkMAORomDE5tYIZxPQE7zJnYI5xujxML12xi7GDnAWl7/EIGI72WU
        uPP4DTOE855R4s+zI0wgc4UFdCVm79vDDGKLCGhIvDx6C2wHs8AWRonXb3awgCTYBLQk9r+4
        wQZi8wsoSlz98ZgRxOYVsJOYe3EKWJxFQFWiYw/EIFGBMImT21qgagQlTs58wgJyEaeApsSf
        Pg2QMLOAuMStJ/OZIGx5ie1v54AdJyHwk11i+9F5bBBPu0i8mN/PDmELS7w6vgXKlpL4/G4v
        G0RDM6NEw4vbjBBOD6PE0Wd9LBBVxhL7l05mAtnMDLR5/S59iLCixM7fcxkhNvNJvPvawwoJ
        Ll6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8s4sJD/MQvLDLIRlCxhZVjGKpRYU56anFhsW
        mMCjOzk/dxMjOD1qWexgnPv2g94hRiYOxkOMEhzMSiK8TaEaSUK8KYmVValF+fFFpTmpxYcY
        TYEBPJFZSjQ5H5ig80riDU0sDUzMjIxNLAzNDJXEeXunnk4UEkhPLEnNTk0tSC2C6WPi4JRq
        YNI/7D0tVss2qfDtP3e3sFPsxeZSYpqNaZwXYjSf3656KLr3gI8t77lAQ+b5TysKuXdtid+n
        zrnl8zO1jZnRTNLlTKuaGvW+ly+6teSZ1f4nSSb/BMQeWGl0ubVeKVqgdoj9XRbDnfUyEtF2
        22OmznqvO4Wfu5bNRDl9/cMi0dW8PxgyHiZ5JEpk8TJectBmF5QUSLO5YHDxy+sFK5ZP971n
        frL36+oHhgoaU/nu250N1Zunm/ZKIo9ZoJfzkr9wrv55h5LF2mJz23jetx6fODHxXIye+yJv
        w36OvRJn/bxCn7x/cDY68fIzjeZ63/1cCV/qtb7VnLyQnvX//+KqOItyRUnXxf8evPyU4/5T
        iaU4I9FQi7moOBEAmQj71BgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvC7POq0kg0dT+Swm3rjCYtG8eD2b
        xeVdc9gsbjeuYHNg8di0qpPNY//cNewefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlfF8xQXW
        ghnsFUevn2BsYHzM2sXIwSEhYCLx+odIFyMXh5DAbkaJJVsmMHYxcgLFJSWmXTzKDFEjLHH4
        cDFEzVtGiQ2fLzCD1AgL6ErM3rcHzBYR0JB4efQWC0gRs8AWRom2STOZIDo2Mkqc7rvMBlLF
        JqAlsf/FDTCbX0BR4uqPx2DbeAXsJOZenAIWZxFQlejYAzFVVCBMYueSx0wQNYISJ2c+YQG5
        iFNAU+JPnwZImFlAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJ6FpHsWkpZZSFpmIWlZwMiy
        ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOEq0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe
        plCNJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYGArr
        pXd/qWGXNDK+s/ppbotra4btB46j/cElL17pH9jQZZa6v4Hvt5518Jow3tRJYjHzjbZqMFr3
        9mkUxm1y2N9rpsboLPBs/eO1rG+bLmnJ6gvYsEkFs7k5RzPdrmkCRlmu0pTYvT/fpVZddbXn
        Vtaf47bXZOf763M2lfJO36Z/6f7hVVGh+YZ32jrzKxiCszWKfWTfP7G73n7+obrg7cNd1zpP
        M69vu20ZnV+yu21ilaLmnvNmSSfFXgduaXZ4qvcouHyn4wsrh5Adt5aHcE95qHmNl63277mJ
        QhLdLGyrUlLyGhukXrfI3hMTidkaN/GBwPbvZ4+GyZ7+4uvwyIE962qkYcqU2++YlViKMxIN
        tZiLihMBKeWpzgEDAAA=
X-CMS-MailID: 20220311020356epcas1p16744e21871dc18ffef3922cb59f4f4aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95
References: <CGME20220308022359epcas1p2d145af3c2f462bb6e69da46663c38c95@epcas1p2.samsung.com>
        <49839780-1b58-5a30-0e56-e02f7756a216@samsung.com>
        <Yipx/1t0We5uGhSQ@kroah.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 6:47 AM, Greg KH wrote:
> On Tue, Mar 08, 2022 at 11:48:53AM +0900, Chanwoo Choi wrote:
>> Dear Greg,
>>
>> This is extcon-next pull request for v5.18. I add detailed description of
>> this pull request on below. Please pull extcon with following updates.
>>
>> Best Regards,
>> Chanwoo Choi
>>
>> The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
>>
>>   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.18
> 
> You signed this tag with a gpg key that is expired, so my check failed
> when pulling :(
> 
> Can you please fix your key and get the update in the kernel.org gpg
> database?

I'm sorry to bother you. After fixing key issue, I'll resend pull request.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
