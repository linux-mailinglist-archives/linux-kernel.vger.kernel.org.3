Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E255D5A6CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiH3S6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH3S6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:58:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3F76759
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:58:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UI46N4016517;
        Tue, 30 Aug 2022 18:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4RlARbbseHIz+zSNbXfXIbrQkBblQ4Ovk4VFNtSRZYs=;
 b=kqAEyLON7jsPCjlROVIrB9SYncPppMEXrkx/bvRAUI4NwbEC3rs4XJwbpvuHJVJ4S4aF
 kSCiRT1CDQV2FKWUQpOByvn838tBKDm4LJ9C30FS+ZwHgiVkVb01ayN6oNotppuL8g+F
 YeJ1KqGLNCXMXiB+lc/wymyHoie39dEu0FYpgZVoC1IuMdmWDJQe/OPXVWYc1BaeA56f
 bMvZXNe0/S//F/nwMVUyXtjmnDawKmEIhu+zkuZC0XLwaB5eJqY8PIIHzYBYhBK0QFan
 Cjw+cSnjs7ciKCtAznClBD9SES2RY5LCvDOupn4/DwYAuJeV8RBunQAMO2NS9Jkpo2c6 HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0qahj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:58:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27UIXRUb038248;
        Tue, 30 Aug 2022 18:58:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q49774-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 18:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkgVe7BMTbbsGSm15QSrefevW+BTKnkF409HhF+5KfeLz2QxJvxQO/U5z9i6l2cUAIrsoWR7UPSm50NzA9600xmNsPadtr6bNLpwZfX9az9YEpne6wQ9HeqZCufjdX96E5Egtav0sdrIkyviY5/d4yYxZ0EtyJrDL0xDMLHC9Iv9XHEEYX+ytQMWP1EhV2FvVKzvQ8j350f5bNl/s2hkpMOp9ZRfVixouZjssDkxUR9ZPHFogYuxWxKFMKMGJCGPQWvGoK569U/Mix23BLIhSK9LvMHceKu2eYLh3ns9e4Cy+oMNKLocI8n3klfKYlQBhW7SEm40QPJsXF2ybG8aig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RlARbbseHIz+zSNbXfXIbrQkBblQ4Ovk4VFNtSRZYs=;
 b=FtXau2moaaxeo7QW/82hBhAXCMaEBC4UANqInvujqNpACVL69WpI0FfDvZtlA6+xv6N8C28kS9JUuqvJ50FRq93Ey5cRkDv2tAJHDcOk4Jb2WKksI65+YNwWest+MZk0tQygz7VB5hdLZPbbju8x6qb2Oa6ZPZD6ObDFo0VYGhmAH5GM3gckQLjI0WoAJ0d9M8Ku0ZgkdulsIo6U09FvlxgxXnHoi03bRjwDeCGuOt+AtIsxrS6OtoCN0iIGB3qzmzh4Q+rqXc4CHdHZIvxe03kT3itv/ju7o5fU3kV+nAbMNLDpgwlpJraW5RAGYByV3QCntQb9idz33EggRb80jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RlARbbseHIz+zSNbXfXIbrQkBblQ4Ovk4VFNtSRZYs=;
 b=R3a078Sys/JQ4KTgiJjv4FHJSCsM9rexMS96WjbRBzg8XsUIWdIZx71Wg1DXgE9Q2MNE5viXj+ZiVfMIBffrnYQWIV6hnVq/DoO1nN9rh76A0+hhCXsArpSY+7jSnQuVPpFL95HM8P2ZxE7YwV98s0r6ChF6pxjlR4436L9SKi4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 18:57:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:57:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] binder: remove binder_alloc_set_vma()
Thread-Topic: [PATCH 4/7] binder: remove binder_alloc_set_vma()
Thread-Index: AQHYu+PDQMrZoK0Qy0yO8Kcq2Jru363HzQaA
Date:   Tue, 30 Aug 2022 18:57:59 +0000
Message-ID: <20220830185751.gpudzi2pv3jpjoib@revolver>
References: <20220829201254.1814484-1-cmllamas@google.com>
 <20220829201254.1814484-5-cmllamas@google.com>
In-Reply-To: <20220829201254.1814484-5-cmllamas@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b38d769b-a5b3-4472-b439-08da8ab98ea8
x-ms-traffictypediagnostic: BN0PR10MB4918:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+6w4dAucVwGVbZrltCyMZPJy0tlHKTeEP1A36+XU51O8Ic8r20FIcTsUtISgnrfWsVI6QsFer7jyKcBEo63P8yWsXT/sNq4FhYHSfxkBbQQamlgvbK2zQjXjoZ7GPt12BCP2zArvjHkygZQ5w7/qnIbT7uq5G6R9pmf4cZObsFbg/BnZ2HUu/avV6eWTYYNsK5UATbiG9H6TzwtdZ0PEszeitgwh2dUZB9AVuV0OG+1lqA2+h3H9ugz+ujzXiwnABb0lkT5tpVXSIkjB593UZWkRjX6hqQuLsxjxnPt0cfD+tpJpOIs1b179IPHxshZMpwBVnXSMRGsnPwJCer5p9BASrK/TdSpKu0wBqMnJHpCZd17cJu1ijFOt+Dnp2NPt9UyAJcuE4+kTU3nt0mqgHwVqch8dd75UmDOd7Q85EJQRgRmkp7Co30C86b//R/c6dagRmQWebcouD436zrT7Rw5WIV9Yd1aiBp+NOusltKp/FMDNZhNu59cUoZC11ddA6ms3lioc7T/gRyOZoA/FrbI6EPKKW7eWGUejlflgrtRrbRm9YXcS/vl6WdHRt7L4juLhe9f9PwUouP+w8hWTr9DVJFvusL8F+Aa3mUrhVTxItBDFlKS3ngRu74hZ0VLbBDcxEk8Cs5qgbJEofcmAPJzuOQzojMf6OITrdLUDEtFYuVNZ33dFLryPDA3d3UGr8aoyXEqIM1w6JGGsq4jYMeAjsHExhVuSV7IPSRz4KIRfp6xNORHYycFeG/4y8y+oViGfquHIcIU/SZ/HW3GZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(76116006)(66446008)(8676002)(4326008)(64756008)(66946007)(5660300002)(66476007)(316002)(6916009)(54906003)(33716001)(91956017)(86362001)(44832011)(8936002)(2906002)(7416002)(66556008)(122000001)(83380400001)(38070700005)(38100700002)(9686003)(41300700001)(478600001)(71200400001)(26005)(6506007)(6512007)(6486002)(186003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pvc2z15y9c6mnMUCSBdfvY2U7/HXNddBL1a7PKwtwZ1SPyTWRZ0sbDXPY4?=
 =?iso-8859-1?Q?6N/5NJlWw69fnr3JX+cIycIdgXrmrG4IerHThXMast35E7g5rywHpVRSye?=
 =?iso-8859-1?Q?TaAQom+lh8O7k6ygod613tinWxg4kORfEfHx7JQPUVPCiebssdfJayKsyu?=
 =?iso-8859-1?Q?wmWfIdWOa70o6hEzRcBoFrpzg+eLrBqLIEOq3uPppkWerrZYOAwkPCs70a?=
 =?iso-8859-1?Q?rGvu/UOLRPmDrgKsqoJNSxG9PAkOIHw895tyJQ41UPbWluB0Ip/b2W3m9v?=
 =?iso-8859-1?Q?JAthbntgXL+Xo6sjFmeFj+gZPwNJc83KSjDtCGnA4OwbMVmhHDd8YlmMqO?=
 =?iso-8859-1?Q?bXQe14IEvU9Iz+UMjI81jLNg9WFSoPOgoXe++pfI+M9slRLep9oujshauo?=
 =?iso-8859-1?Q?wV8HZApiiFMB6DXtnHBjx/3p5K8+hw8J47yejC/Qn4QN8nYsJFnFgo1oEq?=
 =?iso-8859-1?Q?Fzpcs5Hep4hvRDu4HLViRO0qWvxVe7CaceGQXTtP6bNOc/lJ0XGNu/cOrJ?=
 =?iso-8859-1?Q?sxaGeM/yN5w68eAu0BMi8NoTCOnHek4K4V+iIKVM4L/2AChAu7PdeSXYer?=
 =?iso-8859-1?Q?oT+t9Z1E2sJtvrcCJnnfs4/m3M9WJ6h+NsGL/hoeuBxwZL+dQPELqg63pF?=
 =?iso-8859-1?Q?5VRUA3jCq1Mil52CrhfZNoJtq6bSVjHJvbP/8nBih1sQRokLfD5MizmGTJ?=
 =?iso-8859-1?Q?dEOXm9oXqE+i5O3YUN59uLj6V2KMUTvMMQBtRpLuqH4pSxBrq9vt5zGbZ4?=
 =?iso-8859-1?Q?k2x7/eE3R4867Q3S3dJWQJrCY7R6D5wSKKDfbWKt4C/H8D7kvM45Rasauk?=
 =?iso-8859-1?Q?Azfh/t7p/WS1XL6z/zYDp4xNwVIvCrBkqV8fm+DJpFjMvIk76cbJXbWeFn?=
 =?iso-8859-1?Q?xBB+v2FDNDf+kfMLaOr3u+LTPwLDdZa0ESQT3etCjtMyysZncsabTJRieL?=
 =?iso-8859-1?Q?dIe7JMbbDszBoZYjOP5rU1bKLdgbae5uV7AfZ+dtKIsu7Dstf+coMIJn2J?=
 =?iso-8859-1?Q?7vq+sLvpAfSWRdKPkEChOdmEpDuolJWvJ7xSOJntkQtMKDrwkLyA2kQfYm?=
 =?iso-8859-1?Q?LJ6ZEKKUoEuKEdB8Uz00V0YYG7KINIH8O/Mr6t9V20GeldfLzRa4tSS+j1?=
 =?iso-8859-1?Q?kje8D7VQBiqGV0UxaAbENtbdHfdK+tDzdr/9YHOTbSTpl9PqpbmvYocAoy?=
 =?iso-8859-1?Q?XhSBhjIih3evSWgAROetGCZe4vmFYrjDCEuUlMjSUBsEKRGCPJtcrFDLz7?=
 =?iso-8859-1?Q?Ftom+Sfjh7ssqAAqmdP4K6n4NK1af/HKoKeyRF+6XZQviooJ/Z+hFfgciC?=
 =?iso-8859-1?Q?0EAFb9h7qW8nT0jvgTku3RjjiD5qIDTP4WwhEmTSaflLbX0bWtWNMRhxBn?=
 =?iso-8859-1?Q?oe/phnnJPNh6gO3RGxcK6mJ7E8pU/HedaXhH/pXit7arLZVUTJw0HuSE1O?=
 =?iso-8859-1?Q?MOc38cuMSclzv4RNCc056bN8yIh8EhH/8Sm7bCCA+GAdSEI5RQkAugDaQn?=
 =?iso-8859-1?Q?srvewPiXy0b+au6O4F+qXadLEqJZXnIHjNH1MqloGc8oGJMjjY7LcSeF2m?=
 =?iso-8859-1?Q?AgwYPdeBd8R8icAWmnOakzq8gsLFoOl/vmgy82UhDRxpyd9vZGpl4z2LVx?=
 =?iso-8859-1?Q?hfJ7IxIKZmmS8EgudnLjiTsSSXrUtRal6lv82HyK87wgjLhi03ABf2VA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0203A38D1B51FD4EA5FD61DAB2F59423@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38d769b-a5b3-4472-b439-08da8ab98ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 18:57:59.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1e74xAY3CF6MgALZU0rjbMGjKeSCB7EW0ci2lrDvWWP3y+RtN8lMTphzSFniSXBQqR0v7a58FUTmdRpoIgJTCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_10,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300085
X-Proofpoint-GUID: kpdOpu-IY-x6_OkVCQBRXdM9yCMmuZHP
X-Proofpoint-ORIG-GUID: kpdOpu-IY-x6_OkVCQBRXdM9yCMmuZHP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [220829 16:13]:
> The mmap_locked asserts here are not needed since this is only called
> back from the mmap stack in ->mmap() and ->close() which always acquire
> the lock first. Remove these asserts along with binder_alloc_set_vma()
> altogether since it's trivial enough to be consumed by callers.

I agree that it is not called anywhere else today.  I think it's still
worth while since these asserts do nothing if you don't build with
lockdep and/or debug_vm enabled.  I was hoping having these here would
avoid future mistakes a lot like what we have in the mm code's
find_vma() (mm/mmap.c ~L2297).


>=20
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 25 ++-----------------------
>  1 file changed, 2 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 749a4cd30a83..1c39cfce32fa 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -309,27 +309,6 @@ static int binder_update_page_range(struct binder_al=
loc *alloc, int allocate,
>  	return vma ? -ENOMEM : -ESRCH;
>  }
> =20
> -
> -static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
> -		struct vm_area_struct *vma)
> -{
> -	unsigned long vm_start =3D 0;
> -
> -	/*
> -	 * Allow clearing the vma with holding just the read lock to allow
> -	 * munmapping downgrade of the write lock before freeing and closing th=
e
> -	 * file using binder_alloc_vma_close().
> -	 */
> -	if (vma) {
> -		vm_start =3D vma->vm_start;
> -		mmap_assert_write_locked(alloc->mm);
> -	} else {
> -		mmap_assert_locked(alloc->mm);
> -	}
> -
> -	alloc->vma_addr =3D vm_start;
> -}
> -
>  static inline struct vm_area_struct *binder_alloc_get_vma(
>  		struct binder_alloc *alloc)
>  {
> @@ -793,7 +772,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *al=
loc,
>  	buffer->free =3D 1;
>  	binder_insert_free_buffer(alloc, buffer);
>  	alloc->free_async_space =3D alloc->buffer_size / 2;
> -	binder_alloc_set_vma(alloc, vma);
> +	alloc->vma_addr =3D vma->vm_start;
> =20
>  	return 0;
> =20
> @@ -983,7 +962,7 @@ int binder_alloc_get_allocated_count(struct binder_al=
loc *alloc)
>   */
>  void binder_alloc_vma_close(struct binder_alloc *alloc)
>  {
> -	binder_alloc_set_vma(alloc, NULL);
> +	alloc->vma_addr =3D 0;
>  }
> =20
>  /**
> --=20
> 2.37.2.672.g94769d06f0-goog
> =
