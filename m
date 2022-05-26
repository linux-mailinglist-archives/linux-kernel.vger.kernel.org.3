Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E07535634
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbiEZWzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349704AbiEZWzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:55:08 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24CEAD37;
        Thu, 26 May 2022 15:55:02 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QMPT6Y002848;
        Thu, 26 May 2022 22:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Bmk3kVHUd1xJvnRjeVrG4GKVhJQcOskjWQtrORJ/iTI=;
 b=Xs62hJTFT/82f5jb3kkAqZynk/5FBDKPeeoZN800wcwjIMYShnf63DOx30ItmXCzwSzS
 cvpIwEJlc9XaX3vCbxhFyHXe53t2yHsYpEK9Y0t12AFzHfD1ucECIO59L5HdoHfbCUE0
 mJzpFGaiZJgynXCeAKRTsS8df0KATKgytZAxJr5Ct+DOpXvO/yxXmyqY13Tb6dSgVk3z
 AZCYMg6jTZECd5hwQBQzsURk2JZMr7Z6uhKhlY0p/IS8W7b+KE3zrf7CUkwPFJG9iU/N
 a04ENIk71ZsX5/5U7Tc4+CX7NhZnjpw3KMPJ3/9IZVNYR5g0vXxWbsi43QuiVNhF9DSY Nw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ga271rks3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 22:54:14 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id F0CF713045;
        Thu, 26 May 2022 22:54:12 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 26 May 2022 10:53:40 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 26 May 2022 10:53:40 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 26 May 2022 10:53:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbqThO/62j9Ei65Pt8trl3EWBP8UzZbU+O7pWnv4mClVOoPD5fvJJSK7vFD+c4jvHr65PVjXgCKB4DvdQBxLw3HJHbDJvyhhjgtB7Qfjyo/00iCclWJrHVPBkqdhKT9UZDh7hjKJf8ZWFk0Gyyr++UuvxKdW1h5US2gBu0bdb8W12uT0lh1G717tglksSNR8tqDQfxtfpcWK/FhS5DnEqHpixwlORqk4jdJ8DB8PYp2g8j5kCJWkTfZ/sSHBtFRUMeFljyA1o9O+syKj4qLB6G2/K4buHv8J5Iskt0zE6TkQS/jhTk1mXpTkPuMD1hUyyGnHhfgedRpNrFsrN35FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmk3kVHUd1xJvnRjeVrG4GKVhJQcOskjWQtrORJ/iTI=;
 b=PNA8hfn1E58U0tF3Pag/p2cHN0uvPjtZCjcGIHy1nDuOP6IX1B6rCyFhbiGOZnm2JzNUGa3+3dbqcQ+Ae1Yhjdyv/u5iGI/gNN9XO4A3IAPZr6rumrYxUNzxdNX1oNOM5zZhslvimj8zJtcAIFLAspVWc6/FZdGhjffBM/rq3EXF7NIxKfXXH7ewcB1J2KLLj+9UtQQMFTAa5pmLR3oZwgeXNxl5C1DjZWvUrrOECaQGBTK1x5apJa4svv0ZjaBrmMFhkgP2MSB2vU82d1XzmiGY5OfYihyk3sTWS9aAKo4pU03JYAbmFgtf1Z2hEHLnWD5FiCosTWCz8kdtfNtpDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:45f::6)
 by MW5PR84MB1691.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 22:53:38 +0000
Received: from SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::643f:90d7:ef2f:4454]) by SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::643f:90d7:ef2f:4454%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 22:53:38 +0000
From:   "Travis, Mike" <mike.travis@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Travis, Mike" <mike.travis@hpe.com>
Subject: Re: [PATCH] x86/platform/uv: Dont use smp_processor_id while
 preemptable
Thread-Topic: [PATCH] x86/platform/uv: Dont use smp_processor_id while
 preemptable
Thread-Index: AQHYbImZaP+RHM7abU6A9/aPZMC2cq0xUfKAgAB0aZo=
Date:   Thu, 26 May 2022 22:53:38 +0000
Message-ID: <SJ1PR84MB3044E3A5C90662C2EF91A799E7D99@SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220520203755.266337-1-mike.travis@hpe.com>
 <902b4745-4ca0-9b29-6563-ed49f924a5e1@intel.com>
In-Reply-To: <902b4745-4ca0-9b29-6563-ed49f924a5e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 91c68e51-d9cf-e4f7-c296-1ab2ffa7e707
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed28d318-06b8-4258-0d72-08da3f6a9288
x-ms-traffictypediagnostic: MW5PR84MB1691:EE_
x-microsoft-antispam-prvs: <MW5PR84MB16915C296B904B475425A809E7D99@MW5PR84MB1691.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3W/EXtR10/c+giHPPCLd1wdrOdLzFvtbCA56Y9DZBoCz8y3P/5A/Km8+8JDGWIQgZ2epRna9k7cuekGS7j5HW9DBlIxRFAqV4XmW2NRuLdVlcbUhadJVuiVXnz7+pvvSVJaPELy12VJ3DPhr4gHrLn1salreC01eD26vRx/uSLenmvE4ceIdqkmIeJWMRRGRE2csEeT9hff5PheC6qUkMxrt+3N98DAEEMyEeobocnSNLdjDBJ04pKWnucTR2NqLdbp/okg3NOFA6EW4oELpxw1qZMfn/Imd8zqAEcnWfNBjov1uH7EzM+vPtjKuv59K+GGr/8gTLKs6QH1P45VWDDFvTnCKLMwdrLVJpcyPW6VWzkc800werapRwAYrCcgHHUCEFiEvAa0NyDYI456DnZ7BbA1aVUupgci9Bihd/DFQqhivKh4w8BUgx82ph5Tbg5DX8HUdthmEiFOxQ2P5yBdYdq9PGfXZ9aSAhSHcb5MvqyDy35Fc/D60XMbFUR76d/+1hbYEIWUsVQyVGYzh09f4zPk7/vR1up3EK/sItzJ5K3GTHafJW0sfZvy7hQSSZZrbaG6p1VlAn4hIPH+v/Qz4PeniX/C+BmL7NvJnt1eCtJaDNcUYY/6H0imbtIitrbBFhZ0HN1lgS2MAi275ZXQ15UKUOjNmycwuA7JuCjk54mcgLxieWlwqTazW8nr4b2ViY41h6HlIuFZd/E5nEQ1W/pEJTNc/iCFh4IGaKqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(5660300002)(26005)(9686003)(55016003)(54906003)(8936002)(38070700005)(6506007)(53546011)(122000001)(52536014)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(7696005)(82960400001)(91956017)(33656002)(83380400001)(4744005)(4326008)(71200400001)(8676002)(86362001)(316002)(186003)(38100700002)(508600001)(2906002)(7416002)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lw9av+adCvGigPgzTJYGp05QAxXcko9m/q3gTW1JjZf3StkO037AAOWTTc?=
 =?iso-8859-1?Q?Jam4ZOZEXPiVEocXsBUKgpNDs5CMFT+rARlli/u+dHS0gfDXT9Rg6mTRU2?=
 =?iso-8859-1?Q?dvoeDD7Vlt+f9Ml//zKO80YxgTfzIICG1X6+uK8OAKes/g3wp6SAFpNAQR?=
 =?iso-8859-1?Q?SDdXnVOvwAfQvFjChxZtZLcUd39fP4UkgKmu33LLE5uh7vk0sgJUfrBYM5?=
 =?iso-8859-1?Q?AwCTTJ6kMM7TikWY//6IrquR6q/UysqS3m90mv4qMtPdY2AOvX/Dz5rLnu?=
 =?iso-8859-1?Q?pI3Xm/TdwGvFAPxC5dhVBDPpfjegGGBZ5Y5p5iF0nVhrtI/NJWbHsKfo+X?=
 =?iso-8859-1?Q?HbP0h6Z97zdpW8eKp/8gKY16nAwln4LQ/h0NKiRKtxgyZVYQ2lxHMxiCVl?=
 =?iso-8859-1?Q?tSGpPfQvTreuqeeKQS0+sc+mYgx8eylZ9q7FmyIVahink06OCvjrVx8Ku6?=
 =?iso-8859-1?Q?mra98o5SWQbM/YQz0hq5/rwarcX0lGjwvetbpdKnY04vPIan7lmFcodVUj?=
 =?iso-8859-1?Q?eJKq+r4d7ydj9Rx7t7SGjqR7GRNGw1+rzpCKXi7YhWVWivEW/36+d2Ib6O?=
 =?iso-8859-1?Q?JMC5LUMaDD3TpB+E9SfqXpyDa7ewTa8GXXFXSEg+/6nhoYXT3SLGGVJ6fU?=
 =?iso-8859-1?Q?i0YnDCtzkB7Wa8otY26FqlLZ3m77kLqjwPV9//BqQ4tR8XJTkehbHNjoQg?=
 =?iso-8859-1?Q?3wmZp82Z9ENFQ8YUIgkMm89DJDh5Rmq8RIchP9LeD/H39QaDZisdve4c2h?=
 =?iso-8859-1?Q?1ediY8wPUbYmULq+TOSoatf/fNMYmpRSzccTyjNwsVRYqClGKT6cCtmABR?=
 =?iso-8859-1?Q?IzfcEVRjFbGIsGB8k1bg5BQz3+K0CS/Hk38dlCUWi6GSMx/4cesgo1wM00?=
 =?iso-8859-1?Q?iO8u56sVJKBzfh6GtUAC6Z1fcgag/v9mXFGMIckhuO7Bo56Bz1TbOs3K2u?=
 =?iso-8859-1?Q?k/9JiPr0Y7SeTR+N7DcfxDBAfXseiv53W+8SVjuWNpFC0BkvXtFOB+BaXd?=
 =?iso-8859-1?Q?7+T7wynDo3TvOC0pBMbvI/mEqcBB4+DXUKIOphT2+xMjY0Hy7NunNpYFln?=
 =?iso-8859-1?Q?iAYBjEJiMCAqKoy1u7UvCb+wbYfmvPZmkPqxu/h8hro8X5R1h5AaCXX5hy?=
 =?iso-8859-1?Q?hs5ZEJLzzBrNHsqmA84UJh86feKbgl7NKfeIShRF/VZqgXJUu+Os7pqLlp?=
 =?iso-8859-1?Q?pa/tJl/OZEIdgYfXFT9BMAk9kQ/yVQFWbCfXsstNcAFq+UOpdzr416gWEm?=
 =?iso-8859-1?Q?J2AkrTrnKkuZl+6ul89jatO2AAxu/tOp+fpDLfey2ZbY56vtAwpMHE2gAW?=
 =?iso-8859-1?Q?QCiFLrEBiMDKVZ6+5GSAdWZ6zNfpkQ6bg6A48F2dhyxEWxKTbKIKelQsRM?=
 =?iso-8859-1?Q?0bYHHjjk29Fo2/MvmHRJloNt8W/BuejNwAoXFr8h2XPf0r+6Rdp0lN5W8C?=
 =?iso-8859-1?Q?OVnNb5RmLJu+ii4Zeotn3Wj+awNLf01b3Diuzl9bpAxUlT9N7s1NVgGAU8?=
 =?iso-8859-1?Q?jLCWZG+UF+9TyGX2BgHBXsd/9kL+7jDCnKpagg7rhc3wNMC5usDrvm+lcT?=
 =?iso-8859-1?Q?v/zBIyui751St+hUwSL6zfNPaQt43+bVVWWXwdVDP/IMwtWQBzOBjrr4Xs?=
 =?iso-8859-1?Q?jvwdB58009Ao3wmvLlcZUNuvXQtSmBI6ybSQ6Y3DXfVxZ5irxQZPD8POzr?=
 =?iso-8859-1?Q?oKx8v8kNbPEyEeXeLISQC19lZgeykd9iqhNhCYmqHGDnyV9PdLBaHYaaO3?=
 =?iso-8859-1?Q?VvzAsnQXHtYYnCoByWaHVFW5LCGBbc8WzzDPxBB63lv41fRTKXxQPXjvHt?=
 =?iso-8859-1?Q?APJFEAMLPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ed28d318-06b8-4258-0d72-08da3f6a9288
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 22:53:38.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37QT278oiYsl1aNPepW/SJbgmCqC4kTWJSntqJ+JRnWogPgr6N23AKDcz+cGClkAwXb3LGViXAoLivnJZwpGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1691
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: NWEh1bsw2Z0B8gMSJgJbbQXHKEEDGaxr
X-Proofpoint-ORIG-GUID: NWEh1bsw2Z0B8gMSJgJbbQXHKEEDGaxr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_12,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=608
 mlxscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260105
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> wrote:=0A=
  On 5/20/22 13:37, Mike Travis wrote:=0A=
  > To avoid a "BUG: using smp_processor_id() in preemptible" debug=0A=
  > warning message, disable preemption around use of the processor id.=0A=
=0A=
>I'm sure this gets rid of the warning.  But, could you please take a=0A=
>quick look at the callers and ensure that they can handle if this read=0A=
>comes from another CPU?=0A=
>=0A=
>In other words, what would actually go wrong if uv_read_rtc() got=0A=
>preempted in this region?  What would this actually fix?=0A=
=0A=
I talked with the author of this driver and among the preemption scenarios =
it always returns the same system time.  And due to the round robin aspect =
of the request scheduling, getting an earlier time when a second CPU reads =
it's time is not possible.  So getting rid of the debug warning message see=
ms to be the only benefit from this patch.=0A=
