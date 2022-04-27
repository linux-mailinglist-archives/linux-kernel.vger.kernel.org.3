Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CBC510EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357095AbiD0CPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245545AbiD0CPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:15:40 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993D41F9F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:12:29 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427021227epoutp015096fd23f3dc653ff2e87ab778052a60~pnvz3MaIb1461614616epoutp013
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 02:12:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427021227epoutp015096fd23f3dc653ff2e87ab778052a60~pnvz3MaIb1461614616epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651025547;
        bh=0xKMt0dth//1sSAVFMOVRC/5a7GyV79msXh8HSh/flM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=DFrY9A4G0Ic8Nfv1lva5VD1OAWaJpq1iWAP9c/ptwvAx7rsx0OjfOUW3jeTHwx5eF
         IF4UGKlI/EGr/Cx11xyK8l92OYVo4aoKXJHLylZMM261NuoUgdeprpXu1F2cMNxdAL
         zY4sfCiRSpMjiCLzwQq6PYYbQzzuJXzaJfnsWECY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220427021227epcas1p49c14251aa06e5ae166d5f993223f13ab~pnvzm5I433178031780epcas1p4q;
        Wed, 27 Apr 2022 02:12:27 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kp2MG70lpz4x9QG; Wed, 27 Apr
        2022 02:12:26 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.F6.10063.A86A8626; Wed, 27 Apr 2022 11:12:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427021226epcas1p2e1a991bf9f58298bb4476c87c9064bb0~pnvy37cRM1438414384epcas1p2B;
        Wed, 27 Apr 2022 02:12:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427021226epsmtrp11b00d82476f9619d22c97932e22f2fa8~pnvy3Nt3G0104201042epsmtrp1W;
        Wed, 27 Apr 2022 02:12:26 +0000 (GMT)
X-AuditID: b6c32a35-1dbff7000000274f-73-6268a68acd48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.34.08924.A86A8626; Wed, 27 Apr 2022 11:12:26 +0900 (KST)
Received: from bw365lee03 (unknown [10.88.97.170]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427021226epsmtip16460a3afc85e50623a8a95382e4e7a65~pnvyqJeod2115021150epsmtip1Z;
        Wed, 27 Apr 2022 02:12:26 +0000 (GMT)
From:   =?UTF-8?B?7J2067KU7Jqw?= <bw365.lee@samsung.com>
To:     "'Chanwoo Choi'" <cwchoi00@gmail.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <6f07e65b-339a-1ff7-1959-9ea4758d5244@gmail.com>
Subject: RE: [PATCH] extcon: modify extcon device to be created after driver
 data is set
Date:   Wed, 27 Apr 2022 11:12:26 +0900
Message-ID: <001e01d859dc$3d4d6870$b7e83950$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN4yMk10aQ8kdeD9OhaFXryx5/BvwITpb9EAcNqtAqpo24wsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmgW7XsowkgzsbLSyuf3nOavHsqLbF
        5V1z2CxuN65gc2Dx2DnrLrtH35ZVjB6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
        FqTkFJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8+qFXcNa04kj3GeYGxvsaXYycHBICJhIL
        vk1nB7GFBHYwSszeVwZhf2KUuLTSuIuRC8j+zCixeVMLK0zDnpvLmSESuxglpj6cwQrhPGeU
        mPttNzNIFZuAmURH4xoWkISIwBKg9p5LYAlOAVuJZU2HwUYJC0RJrL+0ECzOIqAq8XVfM1sX
        IwcHr4ClxKE2EZAwr4CgxMmZT1hAbGYBbYllC18zQ1yhIPHz6TKwMSICThIXrm5ngqgRkZjd
        2QZ2nYTAW3aJ1st7oc52kZjSPBOqWVji1fEt7BC2lMTL/jYoO11i5ZU7UHaOxOv77YwQtrHE
        u7drmUFuYxbQlFi/Sx8irCix8/dcRoi9fBLvvvawgpRICPBKdLQJQZQoS3Q/eMEEYUtKLH56
        B2qih0TnlIUsExgVZyH5chaSL2ch+WYWwuIFjCyrGMVSC4pz01OLDQsM4VGdnJ+7iRGcCrVM
        dzBOfPtB7xAjEwfjIUYJDmYlEd57ihlJQrwpiZVVqUX58UWlOanFhxhNgcE+kVlKNDkfmIzz
        SuINTSwNTMyMTCyMLY3NlMR5V007nSgkkJ5YkpqdmlqQWgTTx8TBKdXApJPiNHOG0cTyXJlU
        lu6bcbyJu0oCcnXiNN32nFv1QzkxP0HqwR3VzIvdOxgYTkh+VSv/xNn5ZMlFXXGxWB/3uZqf
        D/v6H/56OML+zYk9TDzbuztkNjTWqtX5n8qboi25ryrvXM6hWQrbP3yz2L/ewcXgdcE21a+3
        W1ZqlXI8VxJd+aVzRfTG5dvXL8g++s/mqjxTc9/Ze0caEpbpfzKTu84uWyDm6PprL49nDPfm
        bdPebQ84/f6oefyVXMk3V8zWVDcwRvj9+tPS/dcgblJ1b2yOYFDaks2HqvInd1eq8bxieN6z
        I1AjdW+tmPf2cvanTy9amDVHzf1pPO0ZUxhX9ablNye6MCdxHTWzZvqjxFKckWioxVxUnAgA
        BlwpLQ4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnG7Xsowkg2Vn5C2uf3nOavHsqLbF
        5V1z2CxuN65gc2Dx2DnrLrtH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZSya0c1e8NK44saU
        A0wNjG3qXYycHBICJhJ7bi5n7mLk4hAS2MEo0XbsOAtEQlLi7PJH7F2MHEC2sMThw8UQNU8Z
        JTZtfMAIUsMmYCbR0biGBSQhIrCMUeL0gq1sIAkhgb2MEr8uhIDYnAK2EsuaDrOC2MICERL7
        pzxjBrFZBFQlvu5rZgNZwCtgKXGoTQQkzCsgKHFy5hOwG5gFtCV6H7YywtjLFr5mhrhNQeLn
        02VgI0UEnCQuXN3OBFEjIjG7s415AqPQLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDK
        Sy3XK07MLS7NS9dLzs/dxAiOAC2tHYx7Vn3QO8TIxMF4iFGCg1lJhPeeYkaSEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUwhSo7Wu/bmbZ838X1CZn6q
        slvn05ANSnaz/nxlV78msuyln/LHS7NXnbfV/uX6YbNi+Vbnie5bMqaeV/hSyf3is2rIxoaE
        vuwEpfR0poStfW9m26yUPZUk85hX5HfhIzZhvmP9YuVaCS+E1pw6uuLXxeO7w8+4by+c/1Jn
        XmXbNc3/UUJbk67snb4gLXxjv7rRuUhdiTvmcse2xwcWKv/bXSidNWttrHxuxi6u2f8ePvFL
        Km/e+FvxxtLYhftfm1w7oHLI8/H/9HX6LRY+LVvWT9v9cOGTvMlyd1KtGCT8QlxahY1OtMlU
        /SqdU2/WVvKdNa56j33FCQHD/VoTzv6ZVv9qXlZw2E/R3Zbr599UYinOSDTUYi4qTgQAFvJj
        5e8CAAA=
X-CMS-MailID: 20220427021226epcas1p2e1a991bf9f58298bb4476c87c9064bb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169
References: <CGME20220331030336epcas1p3b8bf7b1841d4b246030b57b668312169@epcas1p3.samsung.com>
        <20220331030324.42621-1-bw365.lee@samsung.com>
        <6f07e65b-339a-1ff7-1959-9ea4758d5244@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi chanwoo.

Thank you for your review.

Actually, I thought the same thing as you first.
However, it was a problem because dev->devres_lock was not initialized and =
devm_kcalloc was used, and this patch was created instead of using kcalloc =
instead of devm_kcalloc.

In your opinion, if I use kcalloc instead of devm_kcalloc, there will be no=
 problem.
But, I think the code of the following part should be supplemented.

1. alloc edev->nh when edev->max_supported is none zero.
=40=40 -1224,19 +1224,14 =40=40 int extcon_dev_register(struct extcon_dev *=
edev)
+       if (edev->max_supported) =7B
+               edev->nh =3D kcalloc(edev->max_supported, sizeof(*edev->nh)=
,
+                               GFP_KERNEL);
+               if (=21edev->nh) =7B
+                       ret =3D -ENOMEM;
+                       goto err_alloc_nh;
+               =7D
        =7D
2. free evdev->nh when device unregister.
=40=40 -1314,6 +1318,7 =40=40 void extcon_dev_unregister(struct extcon_dev =
*edev)
        if (edev->max_supported) =7B
                kfree(edev->extcon_dev_type.groups);
                kfree(edev->cables);
+               kfree(edev->nh);
        =7D

I will re-raise commit after testing.
Please let me know if you  have additional concern.

Best Regards,
Bumwoo Lee.
-----Original Message-----
From: Chanwoo Choi <cwchoi00=40gmail.com>=20
Sent: Wednesday, April 27, 2022 2:09 AM
To: bumwoo lee <bw365.lee=40samsung.com>; MyungJoo Ham <myungjoo.ham=40sams=
ung.com>; Chanwoo Choi <cw00.choi=40samsung.com>; linux-kernel=40vger.kerne=
l.org
Subject: Re: =5BPATCH=5D extcon: modify extcon device to be created after d=
river data is set

Hi Bumwoo,

Firstly, I'm sorry for late replay.

On 22. 3. 31. 12:03, bumwoo lee wrote:
> Currently, someone can invoke the sysfs such as state_show()=20
> intermittently before set_drvdata() is done.
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
>   drivers/extcon/extcon.c =7C 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index=20
> d27cd9f88f86..74fee04bd764 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> =40=40 -1224,18 +1224,13 =40=40 int extcon_dev_register(struct extcon_dev=
 *edev)
>   		edev->dev.type =3D &edev->extcon_dev_type;
>   	=7D
>  =20
> -	ret =3D device_register(&edev->dev);
> -	if (ret) =7B
> -		put_device(&edev->dev);
> -		goto err_dev;
> -	=7D
> +	device_initialize(&edev->dev);
>  =20
>   	spin_lock_init(&edev->lock);
>   	edev->nh =3D devm_kcalloc(&edev->dev, edev->max_supported,
>   				sizeof(*edev->nh), GFP_KERNEL);

Actually, I'm not sure that it is proper to use 'edev->dev'
by devm_kcalloc before device_add. When error happen between device_initial=
ize and device_add, I think that it is not properly handled such as free th=
e allocated memory automatically.

>   	if (=21edev->nh) =7B
>   		ret =3D -ENOMEM;
> -		device_unregister(&edev->dev);
>   		goto err_dev;
>   	=7D
>  =20
> =40=40 -1251,9 +1246,14 =40=40 int extcon_dev_register(struct extcon_dev =
*edev)
>   	list_add(&edev->entry, &extcon_dev_list);
>   	mutex_unlock(&extcon_dev_list_lock);
>  =20
> +	ret =3D device_add(&edev->dev);
> +	if (ret)
> +		goto err_dev;

On this case, need to delete entry from extcon_dev_list by using list_del.

> +
>   	return 0;
>  =20
>   err_dev:
> +	put_device(&edev->dev);
>   	if (edev->max_supported)
>   		kfree(edev->extcon_dev_type.groups);
>   err_alloc_groups:


I recommend that move device_register() position after dev_set_drvdata.
And then use kcalloc instead of devm_kcalloc as following:


diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index d27cd9=
f88f86..80e5bfec1131 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
=40=40 -1224,19 +1224,11 =40=40 int extcon_dev_register(struct extcon_dev *=
edev)
                 edev->dev.type =3D &edev->extcon_dev_type;
         =7D

-       ret =3D device_register(&edev->dev);
-       if (ret) =7B
-               put_device(&edev->dev);
-               goto err_dev;
-       =7D
-
         spin_lock_init(&edev->lock);
-       edev->nh =3D devm_kcalloc(&edev->dev, edev->max_supported,
-                               sizeof(*edev->nh), GFP_KERNEL);
+       edev->nh =3D kcalloc(edev->max_supported, sizeof(*edev->nh),
GFP_KERNEL);
         if (=21edev->nh) =7B
                 ret =3D -ENOMEM;
-               device_unregister(&edev->dev);
-               goto err_dev;
+               goto err_alloc_nh;
         =7D

         for (index =3D 0; index < edev->max_supported; index++) =40=40 -12=
47,6 +1239,12 =40=40 int extcon_dev_register(struct extcon_dev *edev)
         dev_set_drvdata(&edev->dev, edev);
         edev->state =3D 0;

+       ret =3D device_register(&edev->dev);
+       if (ret) =7B
+               put_device(&edev->dev);
+               goto err_dev;
+       =7D
+
         mutex_lock(&extcon_dev_list_lock);
         list_add(&edev->entry, &extcon_dev_list);
         mutex_unlock(&extcon_dev_list_lock);
=40=40 -1254,6 +1252,9 =40=40 int extcon_dev_register(struct extcon_dev *ed=
ev)
         return 0;

  err_dev:
+       if (edev->max_supported)
+               kfree(edev->nh);
+err_alloc_nh:
         if (edev->max_supported)
                 kfree(edev->extcon_dev_type.groups);
  err_alloc_groups:
=40=40 -1314,6 +1315,7 =40=40 void extcon_dev_unregister(struct extcon_dev =
*edev)
         if (edev->max_supported) =7B
                 kfree(edev->extcon_dev_type.groups);
                 kfree(edev->cables);
+               kfree(edev->nh);
         =7D

         put_device(&edev->dev);



--
Best Regards,
Samsung Electronics
Chanwoo Choi

