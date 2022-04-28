Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855FA51281A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiD1Ajz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiD1Ajy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:39:54 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37212AE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:36:41 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220428003638epoutp039261d41ae7139c97eb5af9ad9bb03b3a~p6Fbg9dQG3031030310epoutp03j
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220428003638epoutp039261d41ae7139c97eb5af9ad9bb03b3a~p6Fbg9dQG3031030310epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651106198;
        bh=cuNmeHjkTDigCdImWYoRRkO+aXi4A0pKb644/1zrh8Y=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=prA2XcD+ig+vItfv/riozafTOETDyLguK1ATzw4fVyilOquE8QFefBYeVDuvH6pE7
         0W7BN4savm/oQLkHGqsy1dSxqTWM0pEzS9hrxM1fVkcUj1n32dzXVYo76gSvgVKk2A
         ZPnE6CoEDSynqltP2QIcf7BPQ6+tHn6Q4MMMqLTE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220428003637epcas1p4d3e208228409e140c18143ba45146085~p6FbHgCXB2876728767epcas1p4C;
        Thu, 28 Apr 2022 00:36:37 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.227]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KpcBF2Zs6z4x9QN; Thu, 28 Apr
        2022 00:36:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.ED.09935.591E9626; Thu, 28 Apr 2022 09:36:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220428003637epcas1p4875f98a2a9d02c357c53da8b9d158f04~p6FaYcwJl2611926119epcas1p4T;
        Thu, 28 Apr 2022 00:36:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220428003637epsmtrp1666415aa435addad278a8f08e82126c3~p6FaX5HkM1614816148epsmtrp1_;
        Thu, 28 Apr 2022 00:36:37 +0000 (GMT)
X-AuditID: b6c32a39-f4dff700000026cf-44-6269e19569df
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.0C.08853.491E9626; Thu, 28 Apr 2022 09:36:36 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220428003636epsmtip2c4171bcaa675da13ee5f13693a8ef073~p6FaOHLtf0296502965epsmtip2S;
        Thu, 28 Apr 2022 00:36:36 +0000 (GMT)
From:   "Bumwoo Lee" <bw365.lee@samsung.com>
To:     "'Chanwoo Choi'" <cwchoi00@gmail.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <67b840a9-c656-c871-afc1-84d2ec2c0fc3@gmail.com>
Subject: RE: [PATCH V1] extcon: modify extcon device to be created after
 driver data is set
Date:   Thu, 28 Apr 2022 09:36:36 +0900
Message-ID: <002701d85a98$04baa7e0$0e2ff7a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNb99UO79BynOYx0bcRqoTKMNLqzwCvQeNtAo+rT0ap40jegA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmnu7Uh5lJBgtWC1tc//Kc1eLZUW2L
        y7vmsFncblzB5sDisXPWXXaPvi2rGD0+b5ILYI7KtslITUxJLVJIzUvOT8nMS7dV8g6Od443
        NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVK
        LUjJKTAr0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5o3NDGVrBeuGLVub2MDYxTBboYOTkkBEwk
        7h7uYO5i5OIQEtjBKPF8M4zziVHixJkfLBDON0aJ9r8H2WBaumcsYIRI7GWUmP18CxOE85xR
        4u+8wywgVWwCWhIL58xnA0mICCxhlNjcc4kZJMEpYCtx4cJOJhBbWCBW4uDpTjCbRUBV4nZH
        B9BYDg5eAUuJBSsDQcK8AoISJ2c+AZvJLKAtsWzha2aIKxQkfj5dxgpiiwg4SUy6tIsJokZE
        YnZnG9gPEgKP2CWe7DkF1eAi0XloIguELSzx6vgWdghbSuJlfxuUnS6x8sodKDtH4vX9dkYI
        21ji3du1zCC3MQtoSqzfpQ8RVpTY+XsuI8RePol3X3tYQUokBHglOtqEIEqUJbofvGCCsCUl
        Fj+9AzXRQ2LF/AuMExgVZyH5chaSL2ch+WYWwuIFjCyrGMVSC4pz01OLDQtM4bGdnJ+7iRGc
        ELUsdzBOf/tB7xAjEwfjIUYJDmYlEd4vuzOShHhTEiurUovy44tKc1KLDzGaAoN9IrOUaHI+
        MCXnlcQbmlgamJgZmVgYWxqbKYnzrpp2OlFIID2xJDU7NbUgtQimj4mDU6qBydjqeShThN7V
        ujj3REGOB8ufTnkzd/0mr9BPb3wZ96drlEiJ+OqbJnA8CJOrfjg32faiu2vhmRPrHtldX3ci
        85dl+vq06XP/yb9duFrg0l+bB/vaLQKMtetXF4gwnAhb9K7UJ8Pr3qrfTqWSVWF9TxKOzqzV
        nHj8qPWrpvlmnDorYx9u8qnaW7/GQ7l2s9TbbanBs1pye93miu7ZZXWhf8n9rsN2ugLJ844m
        h9RsdAv8u+7SiT86+uEbF/cfbWre9+zpISfd+BA/Dp+XPNu2uaT7nm78s33Judj1P6Z/Kkz0
        iek4tsAg3+eE2T+D3NnXY2+xXzVTnln9Xb9Zpvfy8jcPY+Zvrzq3Psu1zP22nxJLcUaioRZz
        UXEiANs2FEIRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvO6Uh5lJBhvXW1pc//Kc1eLZUW2L
        y7vmsFncblzB5sDisXPWXXaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyriz8CZjwU6hinnT
        u5kbGJfxdzFyckgImEh0z1jA2MXIxSEksJtR4u+lWWwQCUmJs8sfsXcxcgDZwhKHDxdD1Dxl
        lNje8ZIJpIZNQEti4Zz5bCAJEYFljBKnF2xlg5v06uBUFpAqTgFbiQsXdoJ1CAtES6z/ugss
        ziKgKnG7o4MRZAOvgKXEgpWBIGFeAUGJkzOfgJUwC2hL9D5sZYSxly18zQxxnILEz6fLWEFs
        EQEniUmXdjFB1IhIzO5sY57AKDQLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgmNAS3MH4/ZVH/QOMTJxMB5ilOBgVhLh/bI7I0mINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJtGynPDJ5popjvKXUuxU+2/stq5Z
        2aC48L3nZG4tn/sCJl3KBldu8PZLx7NVW09/6aij+65mwbbs28+nzp9ZJ3fClbWhUMZliXyq
        WFiAuqEomz7/krtS0x718vzae+7x1gNdC+K+mH7+drHv4OvIJ/MepVsGB95Ufn8isuN45pdX
        n9hdWh8ztH59+Ws3Z1mMY9K3OO59VeujROU/q26bLrUm+rN66kMu9f8WSVpbTGczrtrCNvfi
        gTcs59aUTLtox+VwPWLxz/5ji+a+f8OdanpXYMLsjsRtGQ8lee06Ds6+f11N64ZUnXmkfklv
        hM+U2SkJAcuf3jjr+Mj6qa06a/cTi/CeU63nKxe/j+mdrcRSnJFoqMVcVJwIAH2mUKjwAgAA
X-CMS-MailID: 20220428003637epcas1p4875f98a2a9d02c357c53da8b9d158f04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca
References: <CGME20220427030050epcas1p377eb744ed82b0e4a80747da6229fedca@epcas1p3.samsung.com>
        <20220427030005.706-1-bw365.lee@samsung.com>
        <67b840a9-c656-c871-afc1-84d2ec2c0fc3@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

Thank you for your kind detail guidance and example.

Best Regards,
Bumwoo Lee.
-----Original Message-----
From: Chanwoo Choi <cwchoi00=40gmail.com>=20
Sent: Thursday, April 28, 2022 8:16 AM
To: bumwoo lee <bw365.lee=40samsung.com>; MyungJoo Ham <myungjoo.ham=40sams=
ung.com>; Chanwoo Choi <cw00.choi=40samsung.com>; linux-kernel=40vger.kerne=
l.org
Subject: Re: =5BPATCH V1=5D extcon: modify extcon device to be created afte=
r driver data is set

Hi bumwoo,

On 22. 4. 27. 12:00, bumwoo lee wrote:
> Currently, someone can invoke the sysfs such as state_show()=20
> intermittently before dev_set_drvdata() is done.
> And it can be a cause of kernel Oops because of edev is Null at that time=
.
> So modified the driver registration to after setting drviver data.
>=20
> - Oops's backtrace.
>=20
> Backtrace:
> =5B<c067865c>=5D (state_show) from =5B<c05222e8>=5D (dev_attr_show)=20
> =5B<c05222c0>=5D (dev_attr_show) from =5B<c02c66e0>=5D (sysfs_kf_seq_show=
)=20
> =5B<c02c6648>=5D (sysfs_kf_seq_show) from =5B<c02c496c>=5D (kernfs_seq_sh=
ow)=20
> =5B<c02c4938>=5D (kernfs_seq_show) from =5B<c025e2a0>=5D (seq_read)=20
> =5B<c025e11c>=5D (seq_read) from =5B<c02c50a0>=5D (kernfs_fop_read)=20
> =5B<c02c5064>=5D (kernfs_fop_read) from =5B<c0231cac>=5D (__vfs_read)=20
> =5B<c0231c5c>=5D (__vfs_read) from =5B<c0231ee0>=5D (vfs_read) =5B<c0231e=
34>=5D=20
> (vfs_read) from =5B<c0232464>=5D (ksys_read) =5B<c02323f0>=5D (ksys_read)=
 from=20
> =5B<c02324fc>=5D (sys_read) =5B<c02324e4>=5D (sys_read) from =5B<c00091d0=
>=5D=20
> (__sys_trace_return)
>=20
> Signed-off-by: bumwoo lee <bw365.lee=40samsung.com>
> ---
>   drivers/extcon/extcon.c =7C 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
(snip)

Applied it on extcon-fixes. Thanks for your work.
I change the first letter to capital letter as  following:
- extcon: Modify extcon device to be created after driver data is set


And better to use the correct version on patch title on next and then add t=
he changes according to version as following:
If you describe changes under '---', it is no problem when git apply with g=
it am command.

For example.
=5BPATCH v2=5D extcon: Modify extcon device to be created after driver data=
 ...

Signed-off-by: bumwoo lee <bw365.lee=40samsung.com>
---

Changes from v1:
- explain what are changes


--
Best Regards,
Samsung Electronics
Chanwoo Choi

