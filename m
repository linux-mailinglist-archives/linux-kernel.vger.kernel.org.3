Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462552A68C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbiEQP1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiEQP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:27:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58A4F9C7;
        Tue, 17 May 2022 08:27:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HDsAIh003252;
        Tue, 17 May 2022 15:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LOKd4aQE8mxhfSVoNPUTD7A7ERjunYkdhYF2k2mnA0A=;
 b=TdHeuYYNKxm5ic3p7Jg+tz6kmIz5rsbHfPCRZFNPTx+ssIxjKSdJ4zkIoqX4+D/lUDg7
 uQZRvCKJ/MaPZCeU9Ka2SluniC4UIigklCK8F6UqofZyNXCHheu3x0C8q9uLPUkbP5Md
 VZyIMbVayvaVpqeAKjsCdB283vhs21DS/kq+Gs4dEgtBr6izyBC+UIp3kAY0uzLuUL/W
 Ssjkh2BuAfZRacoMBqRd91sxeTINON42sMqO0J+1NXB9EVqqfREXarqmih9ovIuvFE3x
 s/s4PYG7qHrl8aTFpwgqYdax+lmSxDY1DKe6nKTs/rWM/1YmnYjw8bdiz9nfg1eM4+BX mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aaejtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:27:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HFLwW8009525;
        Tue, 17 May 2022 15:27:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v8s7ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FACou2c3lwvFAKdOwu+FF95B/B6V+KFRZPDm6c9R5FAhLGPgF1w7Rj2lKcidhF1axKQWWi67KHK5zfuXZZOGZ83yK+DiAKzqSbSNfnGME5V+Y7Y5/+tvc6G85htDTbgEcMHoNC37T6egI71hZUSoJKwBCzKR4YlpHpj9+t9535UxrnQDqdtHfvhiNd94Nvmvs9Rz/OTPPKdobukhs2cVz6IgYYlZ7vurue8gJqkehxg0TPcXdi5U3b/1pEva8bmoMeyGkYlqQKr30gXt/9Vn1Pnd5tkWYAHYDCCUR8cfKiR5zPUzf+JWCBpYvF8JlHp9irFqcHpWqEe220tK5pZxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOKd4aQE8mxhfSVoNPUTD7A7ERjunYkdhYF2k2mnA0A=;
 b=BU2JlmCFoWwhlMoK+eVllgG255zkRizTi6jnSgoEAfHrJoGpVZoSbbBv5+yaPazFd+q/z6+OkMxj2p6cSGKRAVDIsHnoad34e+s8eHMdmoaMud+QZqaI5zr1X4MNS0gjGRqUOarb00RRNkwX5XwJglH4qedso4KH9U7GxcnfOx+7mg+7PZSxtlD9JBtDUr7DFk4WhiSOULzy6KQ801JkSm/kMkhLTnZ8W33WcW4w0VEvTBhLqdO+7i2F4uEh1PYFYnQviw0q0v1POKFkDphEGkPR6VXcG+VkMCgSgn1xqCSWNDVkE/WdjMZBeLDAkCKccsl2W2iZ8d9UMOj9L9laqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOKd4aQE8mxhfSVoNPUTD7A7ERjunYkdhYF2k2mnA0A=;
 b=Pvv+36pnbXIXTogyedwdA5FMTIiuMHPbheQSToWvtPriNiYCL+l471Y5TU0pZSi12n3jqUzb9qeSK8ubsFK161B9VH9c2SpwbF9gC8BXNln6zDRtULcusojr5qmyZaPVfOpD50fEqFmp9nqxvxzvvt3HpPchGZK4j4Ho4ZK+VFU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 15:27:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:27:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: BUG: kernel NULL pointer dereference, address: 00000004 -
 mas_update_gap
Thread-Topic: BUG: kernel NULL pointer dereference, address: 00000004 -
 mas_update_gap
Thread-Index: AQHYaO8VaP9c9T6G3ECkHQCWsCAGkK0jMz4A
Date:   Tue, 17 May 2022 15:27:08 +0000
Message-ID: <20220517152702.rttuqbgx7f4idhd7@revolver>
References: <CA+G9fYuOHwkkqTdcqGa7kazBwCOF-P0Kw0gthvAzjU0t5EVSAQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuOHwkkqTdcqGa7kazBwCOF-P0Kw0gthvAzjU0t5EVSAQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 963ddd52-de94-4ffa-1d26-08da3819b4c6
x-ms-traffictypediagnostic: PH0PR10MB4421:EE_
x-microsoft-antispam-prvs: <PH0PR10MB44216A6627DD9D1A20229971FDCE9@PH0PR10MB4421.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URyVBC77j2XTaesY73NASP7JHEDuJHIGMsfg+V++ifGwPx6WkfMiTYjsGVp3wHjgFKMay1NqfDQ934J7sxG+Q+TteizgA8ZBGANwNXAiFPw49gvwMoeOqDljIHl+/bcyFG+Edj3elQzhEqPa5v6HhlC3GKozaQbT/JTwQbqKqTF1l2ukV5r6d9IEKu/u5u0ie6wjioMVh2JLVB16nixjIyWUXonvpM7FpHkv/Ma4DZV0CsQMda2mNFpW7E//uc8aGkbXC6RrZ/8IHEOQ5KgAF1R6WEbyM0aPNv5MDAYBNSoN7OWKKh4BP33mjp7ICIn4UDLfvBJZS5Sw4inA837unQjtUw6JV7Z5bDWeTgNgztzbH/UcD3XygKWV1iRkUY4PS5OKVSt7VaegHzOBA90SaTgLGP4SBi3bKPkra4IcqLmqgee/NVL3KX7NyF4lk9blGC9ygWALNomhfMsxKvrjQ1ljYyFmp1c7mv6TSBpHMDqRZ/ZOyyCWYPb0Ib2AePObsDvG245Z1AusdYtpGNKgjTTfO80yBDwwrvOZASBXWPbtFP7aiOwITeUPFKhu4kGWOhTpOd9GcRQHJ7eDfWjvRzaPogCHbO0fAVBepOQZtXGm5tlkQrbRDF7yvm2AoM7FncKbeV8m814ueqz7qr+Taf3Z1mV/5A6NST9irBxHFolqiYFQPMdFXPd51QG1Txi+s/8qhKLTvZaLjhBVlEu2KsqclG/I6l7Jnmvp15MNHt1iF065HEni+ZpHEsd/hxzBHUBTSc3iO8ic0qkaNNnHnGgEoGxTcnK9hkPc35WRxw5FtIaz/+5zl58AYlKo6wdfBlsqe/0L4+kjwdzZZVw+UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(38100700002)(122000001)(9686003)(6512007)(38070700005)(186003)(1076003)(316002)(54906003)(6916009)(33716001)(83380400001)(4744005)(966005)(6486002)(71200400001)(508600001)(91956017)(44832011)(5660300002)(76116006)(66946007)(7416002)(66556008)(66476007)(4326008)(66446008)(8676002)(8936002)(64756008)(26005)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XnZcOBCep3DT8EL1rI70133gdYT3p0Muag7uHZVIN+eDFnYxUgK9+1EqusZ+?=
 =?us-ascii?Q?dP1ATsx0Zmsok5SiGgz371145fO8iuXPOnWle3f1vn0AlqevtxB5cc3RUnwk?=
 =?us-ascii?Q?w4ZydEqlgLTU3Rrk9lJbcXmqkxrNH8HJa0tBUJdKaVCTfrD6qnqVg3zwrTFw?=
 =?us-ascii?Q?W5eVfUJ4EJcTEc1F8G67LrI+xPn47lgdcOnvOENHBCQqswQrsOlxkYYETxvh?=
 =?us-ascii?Q?j4xbOdceYJcfl5E+gYeZkp+4rncBKhSPa63biBnjHzUltLtpJt6NKIynJMsK?=
 =?us-ascii?Q?J33bRX9S5pR48UobnXKjnR/NzFTzJ1CIWuPLTOkMf+dHQz3P8y8TpFPy1P30?=
 =?us-ascii?Q?i4HRT3BS6MI3JWeCzAx23Dj3lG1i8+Q02ZvFRJs6UYB+/rSVkkptdnOfx0u6?=
 =?us-ascii?Q?o32ayV/JttWJk/6Oba6/udKHX4IPY2hN7RkKgJ9WoPEgC5/Q6bVTJWiiZ3vp?=
 =?us-ascii?Q?LTBGZP+scV+Jn4OYeVjVdwAkx4FhT96MqizlUgbuazeW1aRZG6ZqfIY4aqeT?=
 =?us-ascii?Q?iZzc8G+xoNp2hbvmGf0Egrq/yA+uF3t7uSX6gXWlJXG1WnkI2NiPeCJkg3Rm?=
 =?us-ascii?Q?mcstd+e6bq4N3Qc2JJToFz1Q5GRcsZ56fthQPx4S50224sI/TfIy9h9IH5zR?=
 =?us-ascii?Q?v3JqJrJGdhOsHaXSjvyRLLuxXTsJVF/nqQZ0GWVeaY3WwtbiBocNFvG+YvXX?=
 =?us-ascii?Q?yK3ZZ+yQk4XTFf1DYY0uagCny9HQhfCEQ/3sVRuLmrnCZsFFB2CVRHSDT7fX?=
 =?us-ascii?Q?jK9w4EYO+yXlEYbJSt93OXM2+9TR9nK0csBgVc5yUP42kMCqQ9s/zDBYXXRp?=
 =?us-ascii?Q?K6J/oTx86vGk2waEZnPexkLuAgNvcGwtXvCdIfiuu4GfGk+EfVMEnsM3tkuS?=
 =?us-ascii?Q?3IWsx05LIEUbJUbZ+50Elk3z9UHEDqCViVew+nt75KXdHYKfTgUS6c+wbfGL?=
 =?us-ascii?Q?/4FOXw6sHR1pwYejZUKPCE2ZFoRfjxZvqRnyCfQjOsQYbJ2jr9yB/k3XWtfU?=
 =?us-ascii?Q?FAG1Vg1uUkq619hGE8cmnJAo4eL1YD++MeTbJoPNVKA8kS31pPi4Oxt4Dh9y?=
 =?us-ascii?Q?VYrM9cScoUwLs5g9Diy03IRIkUAwAfDIrOAiuYG8BYOg79Lu51zXNiYS8wlg?=
 =?us-ascii?Q?auf18R23Lj4kgQQa7YNFiHka3CmVN/EdxFUGbmEllQoKVcHV3pxRaTcPLYqa?=
 =?us-ascii?Q?lL4ybHvO4g+WvGbX7ch9ROcR7ItmnZrHSqnL8F4CNBogT8l2bpxmsow7+WPb?=
 =?us-ascii?Q?sXVMptIUgLS2VWXFsiiQEzoBPFTbmgjmPX/23aqNHOQ7czTcoKoHaetJpUG1?=
 =?us-ascii?Q?rKquuM/eNmEZp1VAEmIUM/2nvjKLTWodN1vVJ2UpLtyv9p5TyQHJt8Q7X8mJ?=
 =?us-ascii?Q?hHuugrKMc6ZMm127pWt45Kv7dnjplAivudiCLMDPpBL8xutHP/GELd4BQork?=
 =?us-ascii?Q?DuSSXHR97ndDsqwn4HJHZctIUYXQSgyN4h5hR2cSjzSkCrYdd1neFsKDFSmR?=
 =?us-ascii?Q?bffw3L0oJiAJyTtdqE5HUtY8HEsBvjsZHrZ7afrgmPyg280Z/8TW04x1IPnI?=
 =?us-ascii?Q?gMXv/4uarj7oRNwjbejRaQSses3jYeDv9nGJxJZfdvJ9JLcKgEKGVd4039aj?=
 =?us-ascii?Q?Fc9DpFRBdD/n0JCUNltsHsTSnqCZiGoOk+VPDkoNWuxwSUuZxZrakSNvHHoi?=
 =?us-ascii?Q?qmtUdiROejahcmr6tacM/tLTQaaCJc4j7mW+hdeWCf/hF9XTFA8efekNBbjq?=
 =?us-ascii?Q?ICWh/KWr8d5duhdUItlE+LJnoJXP/ds=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <088C0A3861EA7D439D0C2B9CAA299C83@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963ddd52-de94-4ffa-1d26-08da3819b4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:27:08.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRDP1oLyKvcTnPYZl5dbiInSdgMNN9e3RkWyLBWV8icEkHUiyqXavxxWjf3IHrEFP58lUgP5VEy03nh28B/wcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170094
X-Proofpoint-ORIG-GUID: pv6WaJE-eVSyjp_NsICl5VFXnqzP4ly5
X-Proofpoint-GUID: pv6WaJE-eVSyjp_NsICl5VFXnqzP4ly5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Naresh Kamboju <naresh.kamboju@linaro.org> [220516 02:35]:
> While running LTP sched tests on i386 the following kernel BUG noticed on
> Linux next-20220513 [1].
>=20
...

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> metadata:
>   git_ref: master
>   git_repo: ''
>   git_sha: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
>   git_describe: next-20220513
>   kernel_version: 5.18.0-rc6
>   kernel-config: https://builds.tuxbuild.com/296PiI1oM7N6Vk7m9lxuipmXW7B/=
config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pip=
elines/538244935
>   artifact-location: https://builds.tuxbuild.com/296PiI1oM7N6Vk7m9lxuipmX=
W7B
>   toolchain: gcc-11
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
> [1] https://lkft.validation.linaro.org/scheduler/job/5021335#L1718


I was able to reproduce this issue with ltp running:
"./runltp -p -q -f sched"

I have sent a fix out [1] that allows the test to execute on i386 qemu.

Thanks,
Liam

1. https://lore.kernel.org/linux-mm/20220517152209.3486724-1-Liam.Howlett@o=
racle.com/
