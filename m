Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC02A5129EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiD1DYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiD1DYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:24:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008CB6AA63
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:21:32 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220428032130epoutp0299a4e1a4fb0ad975dd1adc3b04f0af6e~p8VYwYl-72164321643epoutp02Z
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:21:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220428032130epoutp0299a4e1a4fb0ad975dd1adc3b04f0af6e~p8VYwYl-72164321643epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651116090;
        bh=qLP+UZc7EifN9V67tnV264MsHZBf8baSTTk1XlJZFC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=deBAU5ydP1bTEp7gprCVV+BOTtl+3a/0vxOps/jn/8hXwsF47r/XRsvsPsCpKGqCF
         /pdjBvATyfCbhysjNa3r3mWO4TF0gAh8a4ctEHGO1RJisJvo//eO9ZwoUYD+u7cUR5
         4xr9+0LGQHfGwyPqA1N9E8RKIwQpcL42fzQElqPU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220428032130epcas2p4fcc2ae7dcc385d3756ef7641696b5d60~p8VYMWZtR2967929679epcas2p4m;
        Thu, 28 Apr 2022 03:21:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KpgrQ503Zz4x9QQ; Thu, 28 Apr
        2022 03:21:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.7D.10028.6380A626; Thu, 28 Apr 2022 12:21:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220428032126epcas2p46afc20be5d8e04a05bd6da2102ba0113~p8VUSJRRU2969329693epcas2p4U;
        Thu, 28 Apr 2022 03:21:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428032126epsmtrp163c71214ef3ca569c2550470b3044880~p8VURGBrF1589315893epsmtrp1a;
        Thu, 28 Apr 2022 03:21:26 +0000 (GMT)
X-AuditID: b6c32a47-573ff7000000272c-a5-626a0836543d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.B1.08924.5380A626; Thu, 28 Apr 2022 12:21:25 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428032125epsmtip2ef4817dc72342b83fdfc8ea3d4b29391~p8VUE98Qw1017810178epsmtip2R;
        Thu, 28 Apr 2022 03:21:25 +0000 (GMT)
Date:   Thu, 28 Apr 2022 12:19:54 +0900
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
Subject: Re: [PATCH v4 0/5] add xhci-exynos driver
Message-ID: <20220428031954.GA151827@ubuntu>
MIME-Version: 1.0
In-Reply-To: <fe81598e-e2de-5923-248c-5fb3ad7e70bb@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmqa4ZR1aSwYl2dYsnRxaxWzQvXs9m
        cf3Pe0aL9ucX2CzOn9/AbrHx7Q8mi8u75rBZLFrWymzRvGkKq8XMtcoWXXdvMDpwe8xq6GXz
        uNzXy+SxYFOpx+I9L5k8Nq3qZPPYP3cNu0ffllWMHp83yQVwRGXbZKQmpqQWKaTmJeenZOal
        2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdqaRQlphTChQKSCwuVtK3synKLy1J
        VcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzvix+jNbwXGZir+7XjA2MN4S
        72Lk5JAQMJGY1bqesYuRi0NIYAejRPP7PWwQzidGiT9rnzJBOJ8ZJfbNfMwC07J10g4mEFtI
        YBejRNcFO4iiJ4wS1371soEkWARUJf7NXc4OYrMJaEnc+3GCGcQWEdCUuP73OytIA7PAHGaJ
        a0tugE0VFjCSuLV7HVgRr4COxJRl3ewQtqDEyZlPwGo4Bewktj44BbSAg0NUQEXi1cF6kDkS
        Ais5JPp+/GaDuM5Fom3qNCYIW1ji1fEt7BC2lMTL/jYou1hi16dWJojmBkaJxgcQ10kIGEvM
        etbOCGIzC2RIXJ23jh1kmYSAssSRWywQYT6JjsN/ocK8Eh1tQhCdyhLTL09ghbAlJQ6+Pgc1
        0UPi4rKl7JAAWsokMfvCG8YJjPKzkLw2C8k2CFtHYsHuT2yzgFYwC0hLLP/HAWFqSqzfpb+A
        kXUVo1hqQXFuemqxUYExPLaT83M3MYLTsJb7DsYZbz/oHWJk4mA8xCjBwawkwvtld0aSEG9K
        YmVValF+fFFpTmrxIUZTYERNZJYSTc4HZoK8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6Ykl
        qdmpqQWpRTB9TBycUg1MzPfOHZMOk06Q3VPrrpHCtO5VCdtzp24Gptlfr5up5P2X23Q62LXn
        uX7c3vzmX5sfmkwUD8/KlZx1vohNm4vX7+VPj59ms5rf3dQXWcJaILtoYnYu8/Jg/ZZDvPXR
        pZ9qw+edUgyaL9yxQf3gYyauI4wFp4+dzk9xyO13lnPnrwq5snrn4qCJu2eWTNmpL/laQzxK
        KNf/q7f428iS3z/3SQnoeRxo77ZkPbebt3bGeXOP2d+lUswnt3RJrfp78pjuwch/weantkbp
        JXHue7zbUJ1749WwAOP1J34HnTncv8T1i7ynUdQSRwGPD6L/1tY/9py9UZtjRk2MVELaP6tk
        ofXzLbiC521WDz77ZoESS3FGoqEWc1FxIgCVhYXmTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvK4pR1aSwbVZ1hZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3WLj2x9MFpd3zWGzWLSsldmiedMUVouZa5Utuu7eYHTg9pjV0Mvm
        cbmvl8ljwaZSj8V7XjJ5bFrVyeaxf+4ado++LasYPT5vkgvgiOKySUnNySxLLdK3S+DK+H7q
        NWNBu1TF3I3yDYybRbsYOTkkBEwktk7awdTFyMUhJLCDUeLenU+MEAlJiaVzb7BD2MIS91uO
        sEIUPWKUOPztN1iCRUBV4t/c5WA2m4CWxL0fJ5hBbBEBTYnrf7+DNTALLGCWONc2jw0kISxg
        JHFr9zqwIl4BHYkpy7rBmoUEljJJTN3pDREXlDg58wkLiM0MNPTGv5dA53EA2dISy/9xgIQ5
        Bewktj44xQYSFhVQkXh1sH4Co+AsJM2zkDTPQmhewMi8ilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOIa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeL7szkoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgaq+2l16zPYnVKjj5qPJpqytVXcnPmKc5
        FQQbSq6ruP/4W2BDyNt7exSv3a+ymLTnx5e9rwt2L9h1lTvhYdqfJ70sQUaPQv5yLd8a6tp6
        4pPdpGi+lZVucpXLTA3zIycac1saT7cx7bgg3+fDZ8WWnhY8u2f2puVr5tfY7NRfeNTFIXT5
        non9yx6+ab3LffddnvZ+gR+i3A47akM6S/cteqx7ILby+kTZa5FLuOa+OS1p5dT9/5Xx65K7
        VckrW7oUz/pO7uF4EPUvT/ge87/JBya+u9ShfOeKsXsW56a4f9n6u68s5vtZ0Psj432jz9Tc
        f9OUniW5Oe5+vfVpwsuYM+uuhTuLtxznv+rlovpKS4mlOCPRUIu5qDgRACsg2roQAwAA
X-CMS-MailID: 20220428032126epcas2p46afc20be5d8e04a05bd6da2102ba0113
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2eae1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a
References: <CGME20220426092019epcas2p2ef5dfde273edaaadc2ff74414f1b2c7a@epcas2p2.samsung.com>
        <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <3ce5f3b8-3c6b-1e83-94c2-84f4ad8aa9dc@kernel.org>
        <20220427094942.GE145620@ubuntu>
        <fe81598e-e2de-5923-248c-5fb3ad7e70bb@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2eae1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 27, 2022 at 08:24:04PM +0200, Krzysztof Kozlowski wrote:
> On 27/04/2022 11:49, Jung Daehwan wrote:
> >> 1. What is this based on? Output of: git describe
> > 
> > url = https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next
> > fetch = +refs/heads/*:refs/remotes/origin/*
> > 
> > or
> > 
> > url = https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > fetch = +refs/heads/*:refs/remotes/origin/*
> 
> Thanks, although it is not what I asked for. It's not the output of `git
> describe`. To get the output of git describe, execute commands in the
> shell in the Git repository on your branch with these commits:
>   $ git describe
> 
> >> 2. What does the scripts/get_maintainers.pl print when you run on this
> >> patchset?
> > 
> > I don't see your name in xhci even for whole usb/host directory.
> > I see same result on above 2 gits.
> > 
> > jdh@PlatFormDev3:~/works/mainline/linux-next$ ./scripts/get_maintainer.pl drivers/usb/host/
> 
> That's not the proper way to get list of people to Cc when submitting
> patches because it does not include the contents of the directory and
> contents of other parts of the kernel which you might change.
> 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM,commit_signer:170/184=92%)
> > Mathias Nyman <mathias.nyman@linux.intel.com> (commit_signer:52/184=28%,authored:25/184=14%)
> > Alan Stern <stern@rowland.harvard.edu> (commit_signer:30/184=16%)
> > Chunfeng Yun <chunfeng.yun@mediatek.com> (commit_signer:23/184=12%,authored:21/184=11%)
> > linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
> > linux-kernel@vger.kernel.org (open list)
> 
> So either you run it in wrong way (not on the patchset but on some parts
> of tree) or you still have it based on some different tree.
> 
> I just applied your patchset on linux-next and as expected output is
> entirely different:
> 
> $ git format-patch -5
> $ scripts/get_maintainer.pl 0*
> (... skipping entries which you pasted)
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> (maintainer:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM
> ARCHITECTURES,authored:1/7=14%,added_lines:4/25=16%,removed_lines:2/13=15%)
> 
> linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
> S5P AND EXYNOS ARM ARCHITECTURES)
> 
> linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
> EXYNOS ARM ARCHITECTURES)
> 
> 

I got it. I could find your name only on my last patch.
(v4-0005-usb-host-add-xhci-exynos-driver.patch)

When I submitted 1st(v1) patchset, there's no xhci-exynos driver patch.
That's why I couldn't find your name there. I've added it since v2 but I haven't 
got maintainer again but just use previous one. It's my fault.
Let me correct it on next submission. Thanks for the comment.

Best Regards,
Jung Daehwan

> 
> > In fact, I manually tried adding you as you commendted previous patchset.
> > But, It seems you changed email id and domain..
> 
> Up to date email is printed by scripts/get_maintainers.pl. If you don't
> use that tool but add addresses manually - might work, might not.
> 
> Anyway, it's not only about my email - you did not Cc relevant mailing
> lists, which I mentioned weeks ago as well.
> 
> Best regards,
> Krzysztof
> 

------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2eae1_
Content-Type: text/plain; charset="utf-8"


------qfoLneH-bA4OZ9oHdTyx3iGNIh7cCFW1WhPixvfI4kv0vTIJ=_2eae1_--
