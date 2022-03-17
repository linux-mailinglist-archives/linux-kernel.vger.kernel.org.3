Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EA4DC36E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiCQJ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCQJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:59:19 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7FC2603;
        Thu, 17 Mar 2022 02:58:00 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220317095759euoutp01be2f4db1af9b176f7780903843364ec3~dIpkhDH5r2797527975euoutp01B;
        Thu, 17 Mar 2022 09:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220317095759euoutp01be2f4db1af9b176f7780903843364ec3~dIpkhDH5r2797527975euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647511079;
        bh=T6TenN2I/uyDLRmMdUEMeMHXdwnk7QTMC8eQ3Q8o8cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jj9Z/cdI+qBtdL95ufFyEC6KJN8uAmszFzVQ1tuHtC5iDKyTlPrU3iXVJq0/5pp4+
         Zr3izoU6gV+WpI0aVtOPh3ZvwooPQ+kA+ZQTSPzgcsrRYtujbNm9HQWWmJnExbZ5c4
         1SBj33pZzj/oLhT+7+oB4PZ1e84+1c57uvgYH03U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220317095759eucas1p10b2422659ae2dc709f26b176ac203882~dIpkHjbaM0849708497eucas1p1i;
        Thu, 17 Mar 2022 09:57:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 01.07.10009.72603326; Thu, 17
        Mar 2022 09:57:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220317095758eucas1p2a206819e4c3e0e38f685b40df8b0ca37~dIpjny6dv1831218312eucas1p25;
        Thu, 17 Mar 2022 09:57:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220317095758eusmtrp216038a0e1495487701416f5f87b5317f~dIpjnDdtH2513325133eusmtrp27;
        Thu, 17 Mar 2022 09:57:58 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-bf-62330627a54a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.BC.09404.62603326; Thu, 17
        Mar 2022 09:57:58 +0000 (GMT)
Received: from localhost (unknown [106.210.248.204]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220317095758eusmtip1b9f4b888cc3451d6c52bec379b7f159c~dIpjXAFUZ2291222912eusmtip1b;
        Thu, 17 Mar 2022 09:57:58 +0000 (GMT)
Date:   Thu, 17 Mar 2022 10:57:56 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        jaegeuk@kernel.org, chao@kernel.org, ulf.hansson@linaro.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: security issue: data exposure when using block layer secure
 erase
Message-ID: <20220317095756.vqfdxb5gd5nvuank@joelS1.panther.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="ytpb7p6j66wf776p"
Content-Disposition: inline
In-Reply-To: <YjIm6f6pSX1CKeqb@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7rqbMZJBpMn8VmcfLKGzWL13X42
        i9NTzzJZTG3fy2ixds8fZouVq48yWTxZP4vZYu8tbYvLu+awWRz5389ocXxtuAO3x4JNpR6L
        97xk8rh8ttRj06pONo871/aweey+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfGkyU72QqWC1dM
        6N3C3MC4RaCLkZNDQsBEYtWP4yxdjFwcQgIrGCXe3T/EBOF8YZS4dmsLK4TzmVHi8/09zDAt
        K5d9ZYZILGeUOLp5KiOE85JRYuG6BnaQKhYBVYmWvt9sIDabgI7E+Td3gDo4OEQE1CSOLfUH
        qWcWmMMksfPHfbAaYYEAicbWz0wgNq+Ag8SWg+dYIGxBiZMzn4DZzAIVEtsePWQFmcMsIC2x
        /B8HSJhTQFNif/t1dpCZEgKzOSWefrjGDlIjIeAi8eF/CcTRwhKvjm9hh7BlJP7vnM8EYVdL
        tFxbBBVvYZRYf04botVaou9MDkTYUWLVn7NsEGE+iRtvBSGO4ZOYtG06M0SYV6KjTQiiWkWi
        b+kUFghbSuL65Z1QnR4Sb9YWgYSFBOYySrScrpjAqDALyYezkHw4C+FDiLCOxILdn9gwhLUl
        li18zQxh20qsW/eeZQEj+ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHf63/FPOxjn
        vvqod4iRiYPxEKMKUPOjDasvMEqx5OXnpSqJ8J55oZ8kxJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nDc5c0OikEB6YklqdmpqQWoRTJaJg1OqgSk+aVLX/Lb850ftmZnmCM/gVk+9sNzvyqKw/Y0X
        mzU2vIlYdupq+TGb2nnKq/a+j9HLFN8jIDKhU7eq7suniDz2SeeYOYW2u5422en1y1H8ztG7
        28TauO6JKPxa+ib7oXCuq18fj39N/9yFykd0v2+IfZDdq/TrIM+P8Ftffm6vFgrWlOtasn3l
        6/j7Ep9aQrbVWMw++uJK+yzmLyVNBqyrnzcW1EypsLIuz9pUfeuX+BVPFV1fviN8nzyu6Hvc
        4fgsNMlDa5qFchrrnvJZhxUS+4QkjV8kPzbbXhl5dPXcOA2uRX0nrSre6Vs+SEjiuSl36EiT
        aebSgs7tRcrbYm7z3z7d2Wnv1Pdbdn1ShRJLcUaioRZzUXEiAOisSbr2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7pqbMZJBjtPaVicfLKGzWL13X42
        i9NTzzJZTG3fy2ixds8fZouVq48yWTxZP4vZYu8tbYvLu+awWRz5389ocXxtuAO3x4JNpR6L
        97xk8rh8ttRj06pONo871/aweey+2cDm8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gnf5NzAVLhSs+7zvF2MC4SaCLkZNDQsBEYuWy
        r8wgtpDAUkaJHw/Yuxg5gOJSEt+XcUKUCEv8udbF1sXIBVTynFHi34ztjCAJFgFViZa+32wg
        NpuAjsT5N3eYQXpFBNQkji31B6lnFpjDJHHo61Z2kBphAT+g3iVMIDavgIPEloPnWCCGzmWU
        mHdnDiNEQlDi5MwnLCA2s0CZxOFTr8GGMgtISyz/xwES5hTQlNjffp19AqPALCQds5B0zELo
        gAhrSdz495IJQ1hbYtlCkGoQ21Zi3br3LAsY2VcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIE
        Ru62Yz+37GBc+eqj3iFGJg7GQ4wqQJ2PNqy+wCjFkpefl6okwnvmhX6SEG9KYmVValF+fFFp
        TmrxIUZTYGhNZJYSTc4HppS8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+
        Jg5OqQYmqUsrshe/+yKZsXr5XYtqM53F6pPXubc85/5wrOtLg1OpzRGG41at0ypeyz7TNtH5
        JeTNfW6JbuHm1dIf7zPcWfyjSLhBg0e43r+E5cY3TqO8nWYqkou+lB6b4OxVHugi9/qw0VNx
        treN+SlqTEXnN81w4FXu/7Cx12KuL5PYER8Om7aKp/sE7yjwcqn4leXdzozyyg1l2baP8/96
        sSlfpv0UNckUf2NQ9zk6q3C+QfTZUgs5/+zPWd+V7zDd8fteovft0CO5LSsan8TwnuUKndp1
        N9Dmg5bCrOAbbW68vxp1mdkire6UeFns8qjunW36+PrMn14KLReP+bvV6rJkyb1VaJ0WGZbx
        KlC2UImlOCPRUIu5qDgRANhiyHtxAwAA
X-CMS-MailID: 20220317095758eucas1p2a206819e4c3e0e38f685b40df8b0ca37
X-Msg-Generator: CA
X-RootMTR: 20220316180540eucas1p2179a720cb484c46f396978eaec8c6aa6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220316180540eucas1p2179a720cb484c46f396978eaec8c6aa6
References: <20220316093740.GA7714@lst.de>
        <CGME20220316180540eucas1p2179a720cb484c46f396978eaec8c6aa6@eucas1p2.samsung.com>
        <YjIm6f6pSX1CKeqb@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ytpb7p6j66wf776p
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 06:05:29PM +0000, Eric Biggers wrote:
> On Wed, Mar 16, 2022 at 10:37:40AM +0100, Christoph Hellwig wrote:
> > Hi all,
> >=20
> > while staring at the block layer code I found what I think is a major
> > security issue with the use of REQ_OP_SECURE_ERASE.
> >=20
> > The issue is not about the actual protocol implementation, which only
> > exists for eMMC [1], but about we handle issuing the operation in the
> > block layer.  That is done through __blkdev_issue_discard, which
> > takes various parameters into account to align the issue discard
> > request to what the hardware prefers.  Which is perfectly fine for
> > discard as an advisory operation, but deadly for an operation that
> > wants to make data inaccessible.  The problem has existed ever since
> > secure erase support was added to the kernel with commit
> > 8d57a98ccd0b ("block: add secure discard"), which added secure erase
> > support as a REQ_SECURE flag to the discard operation.
>=20
> __blkdev_issue_discard() can break up the region into multiple bios, but =
I don't
> see where it actually skips parts of the region.  Can you explain more
> specifically where the problem is?
>=20
> - Eric

I'm also not seeing it.

As I read the __blkdev_issue_discard() function it uses
discard_granularity to define the required sectors (req_sects) for each
bio. req_sects can change on every iteration of the while loop, but
all consecutive bios then start where the previous one ended.

Am I missing something?

Joel

--ytpb7p6j66wf776p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmIzBh0ACgkQupfNUreW
QU9p7Qv/UfKXFyL6aVj6F7OKUsiqBC100Z9LAW/CcxJj1VRxfvO2OF3NKt+hunId
Wct6qqrxzvTv0WG3qb0mKLkGj+hbMiJg3SuIVAYewlQHFxsmFExuACV7KFLt/wUJ
N+/tQtzf3QRwzvB5L2nQ+nn0MrS/32iStn4mpyZuR8E3FSD9ArlPB9mZdwS+Lq85
dhYMLkRcd491uYZtBZYEJ+fFtR7xbw5vy+LcmnvJoLeBjNGEiLUQCO7rXGFOBNPP
M2Kc73Jl/7wZLZOdmxEti6ecNtLkfC3DAQSM74utDZjAsunqK7PYvwPOsc288hOC
fwfZfY1+yW1cGHsu+JZQJc9bMsNfk41qmyM74cPqhFM3Iar77c6g9UC5lbY9aj3X
LiAKoVORGCH85CQb9tqi/20GLdxo2iOfM4TbcxxT8eJMPhT0PHV0JJy2C5eXwyGq
FpMgixPMKgkYxcarDwhuVLqXPtMvIBVDoVXtWZVZZeQw01DEGipmOo7VufKnnjS+
F2Lvrrqw
=4Qk6
-----END PGP SIGNATURE-----

--ytpb7p6j66wf776p--
