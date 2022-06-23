Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979C557DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiFWOZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:25:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A503616B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:25:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NEBsLB003411;
        Thu, 23 Jun 2022 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9ooJF1fxC0suDWa0+8V8jP5bdImcLIevgopec66QRZY=;
 b=f7Cs4Bs3DJqSkdtp1icdosX59dSpzgvpplLCKM1FNy0c7ZQZ3AoqZjn1tW7s1KS3mGrU
 CUO6FOhrtJKVLBF/TJerwl+JNsczyJZlnaTmS0xx1wg058Iu8sFiUwTuYg5RsOuqpycS
 O7At27iN4HtPCVDVWSaRq1+rhaMnGYGP6wPT4bl47/Acv55d+5TciaZa5lAmmR7eec3/
 Ejhzl/obxnzMLErGFeKfWqBXLL4IFi81VDXsVp8/XXf3XvMCDSN3HaAo9qotU/L7Khd6
 BXZX3ucjLVwJbqql2pziUi142qIS9K1yqmsDLPgeunglsN/SaGI4gUFSfKfVCcYsVnK4 Pg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u39jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:24:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NEGvSi016136;
        Thu, 23 Jun 2022 14:24:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5epwk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKsikDUF5/Ee54N+LPxPn8ij89CJVjGGYubnZVn+zwYkhhEsP/9Sys38uX72dM67xuW+p3btPG85a7yUYha/UdWHXqkXt6cej0crX5QcqIwH3m5J93CEEyGVOPn4TFhILPLTBV0KSudtcuhSq29hQ7IQkdgiHuRv+3tM+yQ9xAVdFY9EaRxyJcSS4lqhQWV9JIT+SREn5YEjdcUaFbhv74aSar8wfZCDWyKdSpk4hBUoDAXPmGJ6DrLYYbHZOumVVWtomq7ErEoSIoBiAintF6dYYuBoPIDwRo+8n3bGtIppI14pJGDjzIjfqf1El0kTCfbQBK4k86sbb3vA6QrJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ooJF1fxC0suDWa0+8V8jP5bdImcLIevgopec66QRZY=;
 b=IBN/aHGXlc7+lZoM4k+xW3vOL4PoC5di5GnTTS+xbzWiQLhoD1zhWAOtBBzX66QfYO4Og2RKe2UQZDz7geELF/RTS98dw5wO9RH6tmyZEr+4aIaGHPYoRftaV+2q4H+WlNATe+lmdpI+YKJdr5nmu8TCuRmE3ZfmgpwG23Gbi17EKhH1WedcKK8HB7zkb6B1acNQ+xnOhFOGgEZhCvznEpBqfZIKtQAnWg7NxHgCV0ZEuHTO845JZyzhNXN3nHuugkcDy63zz9Aweez29LKfDW2TlAmr0fqh1aP1FG8KBFnxD6jsYn24mrc/TxSCH6PK28tgFjAuJl+YxXm3rek+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ooJF1fxC0suDWa0+8V8jP5bdImcLIevgopec66QRZY=;
 b=Ge29IduViUy4Ot0M1zOjnux2sC2iPvwnpkO4093ZrFmWUsiWql4EzFELEqZozCtDYedBv+yqShgBWtbkHm3BSNbviYmkn7VWqlt/LdHKMI6TQjN9jdzcf6yvDy0sCAtdljMwnVysvFUJnktka7kyhvvWzENZbrDqqwIPt9rHA/8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2277.namprd10.prod.outlook.com (2603:10b6:910:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 23 Jun
 2022 14:24:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 14:24:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] mm/mmap: fix error return code in
 do_mas_align_munmap()
Thread-Topic: [PATCH -next] mm/mmap: fix error return code in
 do_mas_align_munmap()
Thread-Index: AQHYhwW1Rspy0W4wPU+yChCTjkUD9a1dC86A
Date:   Thu, 23 Jun 2022 14:24:27 +0000
Message-ID: <20220623142412.ooltag26kcbqy7am@revolver>
References: <20220623134237.2127440-1-yangyingliang@huawei.com>
In-Reply-To: <20220623134237.2127440-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab74535-3f18-4d21-97fd-08da55241458
x-ms-traffictypediagnostic: CY4PR1001MB2277:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB22774B4247CB12D438C70472FDB59@CY4PR1001MB2277.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgocxMN8tmelayiTSV5XQFbenWPtX2JgifJNVTAmafAu0HLNjLMv9juGp+iLqCrvJrjHMSJ/Fle6Pdvi068G2MYUbWubKTNC2Y0H+KmTAhltumnKfoQQXa0TtkL2dWNEN9+W1qX+H+1/N0sZn3EsW3c/tJUJTjXqtCwdS9AWahouq8TqYAhpXML4Ttht8DOrEj/aYYnB9mgzcaS6HkmZ8fzltqie6IIxqxEGHzdzg5R877n9/Fpj9KGu2xJ9nBAJrU/ei+fmYwldjCEUwzOEE6JL/C6NRqISYSvDiy+z7gEGm8Qd7V0EQwnKAutJUGMbW1f8jtLrzng12N8sz/kPX4G8rZxEx2/0SeGujpPfdmZv+NbmbB376qnCumUN4cStusXa9tBeoyaAUUewvmszRjZbZ24/zdPvKWgk8TW602KNqFE1G15U0mK1KQnD+BmTbHQo5tb1oNuf82LYFdtzXaKw/7JDyd2qB6xsefQghZ8rzVuoDiDovzZOO+oxWX5I14/5uQBCxAlPPKalfXGATKkD1+YwPq2h6smdP9HaqDFOqQCBkgoNenKNXynVEKxf0wrWoAz4YFlj5tONy2vLSBmTn1dAue2P82CxOolng2EA01QeY34tqplrKw5a3F5MqwFV2tvLycF5qox+NhC/6OBptID46B6OJhvBkwWMKc7NDNgEd8CNM3lUU+qgmmCF8vOOkwpD9BUvRcV7+0i3/NXPnJQ36L0swhDfTkJs9+0LJVJQWQnCchNN3wxa5EEx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(478600001)(33716001)(66476007)(26005)(6512007)(5660300002)(8936002)(66446008)(41300700001)(66556008)(6506007)(64756008)(6916009)(66946007)(71200400001)(6486002)(44832011)(38100700002)(316002)(8676002)(76116006)(2906002)(4326008)(54906003)(122000001)(38070700005)(83380400001)(107886003)(186003)(1076003)(91956017)(9686003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/GOgFb2SwHRpLE4AIzX3FONvF5qGXbsLZpJDYIPwIXgwavKzp6z/+KrJdd19?=
 =?us-ascii?Q?hRmIT5ccI0P8OFL2geJEe3BWgHxznccX/3piagHtCs2bnm+fm4VB0hyzi9Hr?=
 =?us-ascii?Q?dCtjN6gKZPlnG6I9LU95V+eG2/NS2pOIcJfgVYBVfJrw24HrQ7d6tY13sakr?=
 =?us-ascii?Q?HdlhpXvrCRneaL+1YSib+E/UShwVWvb6LJfBDiCzUSfqj5KvLz6rKv5Y/ZA/?=
 =?us-ascii?Q?nG7WRm+eMhU89OqP2/pt5XhKsQ+NG/DNy+CP4oLyejqNLh+7tVe4cCE633Q7?=
 =?us-ascii?Q?kdAJYxQcoEdlpZUF6ljby+M1DhImCIl3mO2NsmI6qXCWuofUnneXcWhfb0kC?=
 =?us-ascii?Q?QT8mR96dp9odL8S79o853tt3Aa+W5SyD4DJHittj3kqFIQglNu19NY+RXGcU?=
 =?us-ascii?Q?i4ArMjFVoH3rcCIvbYqAfuzadljc0k5JQIUwDyA6h62/Y+BRoh60F+KQ6Rh2?=
 =?us-ascii?Q?zxsLwh4ZOM5yzkqE45/AAE+W66CLwNolUSxzsz6lvDfRnrw1onbRAtpN3ksC?=
 =?us-ascii?Q?PO2zj7kG31vYEoMkTRlpPg7mBxjgjUucV22Gp0aXdIr8dGFChvO/HZjqI/TW?=
 =?us-ascii?Q?N7JTCsLFrYx8wwF+nYpNkQKY3FVU3iHnsh+KOOcMIwjg9o1PmPE6u/zB5mOj?=
 =?us-ascii?Q?RaTwMEobLEvuI5lDL7oCn4eEByOFxkIk8BQFFmKaG95694pNYdh7D6ZvAj/F?=
 =?us-ascii?Q?j+2jivW45ciFCaZe8W50MFoZWd/t7eQMit3qFZV4RTsFIKDLjuY0KELrt1xm?=
 =?us-ascii?Q?ajIde9C4XujX2xQGi22lmJRRv/8/hQC3hpRcaiXxh1d6GxoLkwA0Hxw6uGkq?=
 =?us-ascii?Q?zseSnkMMR0hxa7n6JbeiUxIzjswecTkWakSeZGWTdoG3TpPolii7endtM4N/?=
 =?us-ascii?Q?dV4U11MuZ2kIywKgJezd1+t3Rtgg6gQryAYBV/QSKqgU1ZuB/N74NdXWQ1dm?=
 =?us-ascii?Q?5V/60tPLc7KKvoYMTwqmzr1UAfRwZO4ppX5CHnYaSdxFVKIFqGMuSHCaaTJB?=
 =?us-ascii?Q?G+DAG/HKfqqIZoGBSFnny6AGTgkd0lHe4vdMT0i78SoUanPXnacp2MM2xwML?=
 =?us-ascii?Q?dDQ7hXC7gl26sxrrIIwQcmYa0jQjUjsnLxSQ0nvPE4WtK9OcRqlbXvpwdnXo?=
 =?us-ascii?Q?h14Qv0N5c2Eq06tRs/gLJ41AwlmDdNkEjOv/4PRMQmRxUqhcPhk1Ljmczglx?=
 =?us-ascii?Q?7xc9xPmDoSUshOAiMe28V5+fUrq3e6IZSqlWNnKu+hpYOm2eULWK8UM6xYxv?=
 =?us-ascii?Q?9xuuDHBuX8ZQNCIigQWrEOtvCi/rix2EEXzn3+YYjfF4OsIlWIyWC6DTWnxB?=
 =?us-ascii?Q?ez2jEiLTFojYTzhJaUaJVi4cJzvsm+L0icKvLgdcJHU56l8/OzK7SFRrGotk?=
 =?us-ascii?Q?Q4sKozLERPyY3N6/M4wnCYd8z6V5nK21e+bhEtWRTgDAJYPhef3fEzDtu1aa?=
 =?us-ascii?Q?KhI2S3JBUrT2cXE7BVQ6NR2/JZZ8oBrMBoWlekrWvQWY6Cw5ydT3Rh/YUh1P?=
 =?us-ascii?Q?UfZP0t8PWl2tXVf5alyubRGjT8HzK0dpVMrX6eHEye8AcHcfYtzWFw1q9CoB?=
 =?us-ascii?Q?C/gZHGk7BzONpCVPzocn1g9mCO1QXhjLybP+Rm/y6SIco2Ap3kgLF87mnWmr?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF51E30F0452684C8727CC22312E9686@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab74535-3f18-4d21-97fd-08da55241458
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 14:24:27.4724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDtIVHewpRNmtgMORyC20VZWRGihLe3I5TXPy09sLvcuMJZRp7UgcT2YvyBeu0RbwGqzABFomAR99F/e7c8hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2277
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_06:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206230059
X-Proofpoint-GUID: ERrr4fgyncoVs-gfkct0Txh2-wo-M1Uq
X-Proofpoint-ORIG-GUID: ERrr4fgyncoVs-gfkct0Txh2-wo-M1Uq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I actually have the same patch sitting on my branch, reported by Dan.  I
have been testing this code before sending it out.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Yang Yingliang <yangyingliang@huawei.com> [220623 09:32]:
> Return error code when munmap_sidetree() fails in do_mas_align_munmap().
>=20
> Fixes: 81f5504dfb36 ("mm/mmap: change do_mas_align_munmap() to avoid prea=
llocations for sidetree")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  mm/mmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1bdf56804048..bb978061a790 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2427,7 +2427,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
> =20
>  			mas_set(mas, end);
>  			split =3D mas_prev(mas, 0);
> -			if (munmap_sidetree(split, &mas_detach))
> +			error =3D munmap_sidetree(split, &mas_detach);
> +			if (error)
>  				goto munmap_sidetree_failed;
> =20
>  			count++;
> @@ -2435,7 +2436,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
>  				vma =3D split;
>  			break;
>  		}
> -		if (munmap_sidetree(next, &mas_detach))
> +		error =3D munmap_sidetree(next, &mas_detach);
> +		if (error)
>  			goto munmap_sidetree_failed;
> =20
>  		count++;
> --=20
> 2.25.1
> =
