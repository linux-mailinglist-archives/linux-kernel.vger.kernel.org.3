Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B888A59FDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiHXPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiHXPEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:04:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7659925B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:04:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCsKlI027182;
        Wed, 24 Aug 2022 15:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xuZjOhdhuvK9F8pjbVQAqWMeOPMfKvp8heN6fY7GBNI=;
 b=rPdyFKg82Y4NFhZfPmVVOsUQRabbwolMq0WyWQPSL6xX+EElsHhNEdz6u6G3eI+TuBYT
 Gf9BSshh1lkXPwc5nTlkA49VT17gWKR7NLiGYPqlr30wdDQuQiYIWxkQReMJpdhfSRTl
 zQRQ7neB2BN+tfSYyUCwZ/5/eQ2VfJ6FeCLFRm7dt5XI4gUzAptgBpU2uoFgjrvWeFGC
 9OC9rsatOrTqceiZOy7zscmKyus0kPy7I4jIrklm3OzJp4tuE/3CSGyVdJ/v3dwHD4Q2
 wsTK9DB2g3//4Q7XfqXAf4kQs7QmRjIH8rorg3y5i9a+M4AfSB8/d+Xi/ZhAPDUsHcSz 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23uu5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 15:03:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OEp47c023107;
        Wed, 24 Aug 2022 15:03:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n56bfsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 15:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwcwQmbZHoZWmMrFrmnVKfEg/MdEPz18rCeJJSElVMx8Iy+3clwr7b9zM89WHs7M73B/kd8tq8h0hwAZfHv6Somyfk5LcccJBRyJKoKXvFmv9RLVKjfaC/En+FJhITkrJqXIuov2P3NpwD6fZOfYUHZKfI1ulexdlQY2sVhnp5GuVK5ryt5zw6VLFnkPE0O82Tz/wAN0t3Nb0HK2CCmEHG3Sh0oHAJMH+ya1niY+D7MhzY04ocerUVDMTyn0LhO+BU1s452Ck6SN3EchNO4yLqm9qUWkmWDyChxxVao7dstCmTEzvDaClBgKaSq+rqZ6696yhoMYn3i8xzImSuCjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuZjOhdhuvK9F8pjbVQAqWMeOPMfKvp8heN6fY7GBNI=;
 b=j8tuJy8paNOxP7ffHMHzFaPUqjQnovImShYEubfHRGBBnn3dBEw4/M8fqsw5LQTXHGUL7BGJu+ebCWu3O/AolboVJsYBNRfWiYkZyuKPQmuSUyua9yBrj5g2tS04wWiI3EPtZvkBZPaXSugOtW6AbyaKGnklOgu/5n6Szu6s1jaj7LY0M2YJzwCeSAJMYgYIkHnnKw2QKhyfFp4RQH0G25aN/kafif2wRfHPgAnExxGvFhYJ531pLEYGvnwzYaKhWPb5iW8/YeECqDC8QGTYIZ5YwOCxYwbxl1ThUWkPXaSSFJjUyq0oKvh7UYpywy1nHpHdjrRrUz2fuGo6E+cTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuZjOhdhuvK9F8pjbVQAqWMeOPMfKvp8heN6fY7GBNI=;
 b=YzY5Gan9JfbflERChQC7LVAwxxo4HKYdYY9KREKiiPP3PxKrtW5Ls/rE9Kk34n6YZKJKN/73tZnjZAv5JUNLRuH3kvFl5ZzwX77fzwWiGDQKZqN3JfwyPIPnZij1qr7uiyG4Km2M1AlfBMSAbb5GzNYKT09OtQ9/rxjqTQRg5us=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 15:03:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 15:03:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: [PATCH -next] Maple Tree: remove not used entry in
 mas_preallocate()
Thread-Topic: [PATCH -next] Maple Tree: remove not used entry in
 mas_preallocate()
Thread-Index: AQHYt5LEuzzpkctuQUiY7b4uZVtQUa2+JjQA
Date:   Wed, 24 Aug 2022 15:03:40 +0000
Message-ID: <20220824150332.mikvmqelqm6thiiv@revolver>
References: <20220824083044.3236796-1-yangyingliang@huawei.com>
In-Reply-To: <20220824083044.3236796-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc712318-673c-4f5c-f1aa-08da85e1d45c
x-ms-traffictypediagnostic: DM6PR10MB4330:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LChYHqJX/Mk64gcxR2ecpLiX3nkRVEduDCA3/P6E7CC0/fS4gQ+GIBa5Bt5RnJJtor0hWQKjDh0aXl8+vX67ovxTu1mgG5sRuZHN3vvy2y/W1lTSP8Fe/HjEXdTJLZvVy9CT68Qzaz3pCFvWmOT95C3x/zJG8aODLaOMpsbs7nbS1Jg15k/MuSALG1mDKfdiLfTHpH8vMWkLsDdNgIS2cI0bSRV9f8Uddiya0K7g7ick4zdTMOUuepkHYNBdpPkecnVqA5luNwe3mFZ6r5SmPOPHKpgkzLwaX0s9v7pq4XBCQFIK4jt9gyzKL3J4nk/o9aKU0CG7Z5ePxvOcV045z6NNQPmglj0L6lc+HInGwwrkbhZPN0byy2avKhyhrHUBNH5KC8U7wVtNOnrGEmIv2REtOn86Dy51i+4oZ8DHVpV3sunUeEuv36vV7GJIORfs/hTw0eVet2Nqh5RgZ6vxGkex1xPa7Xh7ZD8VELS/3HiwWkonXEf2uOm+/W/bO/3ukAjc5OXf+rAf01be+zjhW7hbM1oQl+ZCrh85bKaz9gXdQN//IPA+rlcDPcDTinbtn1ZUq957DHo6fWvC98HfpfUtpFFg9tCk7pj7V2c8Zuyq9wJcHzZVH8I6/un8r/iGd7eCJAKMI9zlOaii++LmRub2oIS9+8x8yhAHCjEkAcJ3TWq4A7aXuAKyxl78X5u9otkAMDbWuO1ED5PMT11HSyccVxEAba9q3/f+yp40SzOOyYIz8+aeAB87PgZJf4FtM2NYVTqe1/ob/5E0H4JOrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(39860400002)(136003)(346002)(122000001)(44832011)(1076003)(41300700001)(6506007)(9686003)(86362001)(2906002)(38100700002)(38070700005)(6512007)(26005)(186003)(33716001)(5660300002)(83380400001)(4326008)(8676002)(66556008)(66446008)(66946007)(76116006)(91956017)(66476007)(64756008)(6486002)(71200400001)(316002)(8936002)(478600001)(6916009)(30864003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K2UgyxNWNHL2SlpOPAZnEBEgjrjTCiCHntwTAdzRC7GmON0d1kzrK9zaMJWB?=
 =?us-ascii?Q?nY7e8/nHUQlG3zJor8QehAURW5j/wZA0M5d08BQarY4RdoK7mBJv4VLz4TQD?=
 =?us-ascii?Q?cfCFlgEVqBDlNGL7NnqYlwN+yQek8pLCes/bLqbV4Oe1HX1JC9KUUjwRyfO6?=
 =?us-ascii?Q?1jxp6k3Ucc19fhatJpFC4O4gqHbq1fFe3g5+12x68dPOZ1UN+FBVscZMbBgD?=
 =?us-ascii?Q?Dt10sWD2gsLkperwJXMEKf8z/o+XutKC8Dyfiw7oBlzdtWi9KSy9AM+pDY4f?=
 =?us-ascii?Q?qjjgLdiyrMPSzdgQ6ZlzWanJSmgHwbrA5vHCOukc9pENmInKEYujgsMJW5/t?=
 =?us-ascii?Q?loLdS+s3JJm+koy5jS6c/Q4KkOZACub2mn27YskfMTxnmrfGNvQcRyw2py+g?=
 =?us-ascii?Q?hDafUIrrpqzGe3sk4FmZgq4bRrvdu0DVQhoPI9lcZJpLqeSaUvb2/LDiICh9?=
 =?us-ascii?Q?Bzngx75iFHkKMR+iGWn6ENY3R5ejl0YCv3lvlFfT/p6XfgfbhxzhstAMBcsJ?=
 =?us-ascii?Q?AaG20u9Q5Im3wGpNZdP7KcYBjs7jqGrWqsICWQ4ZfP9plk05U3l04N+nfuqC?=
 =?us-ascii?Q?1bF+xk9vIN8oJHNAI+UJsH+gSDMeIKMCSbTRx9hcXd+wANc9nj2UmpLmEqX9?=
 =?us-ascii?Q?NCMXlKdOdKmSUKJnfj9JlCfK/24QAgT0DEdxqENEHjFK921O9Vi3qeqHHmEj?=
 =?us-ascii?Q?8Jqp78Rlht/KaWCJo9+yZvsAhZVLC5ttaiZ1h3si8uFXAD6u773Iw/gcBGtJ?=
 =?us-ascii?Q?Xoy58CkC52urM6jeMh34qxDoOEvCRTTvrCSXTNPj37gsnN3ofyhDVPRjpkmf?=
 =?us-ascii?Q?LF4ihx9/fU1QLNkrHi3tWk7pg8ShpUYt2n2jy0ChFoOtUX3WVO/dOUi1vwdZ?=
 =?us-ascii?Q?2/itlW5B5G3xUMXcvh8BKjfPQwuLnxO66CQ8AAJkWJQw2ImQAXWYGYsfgG/I?=
 =?us-ascii?Q?nVkUatvuYWsOmjdowMWVCh3MumAN7OTsargw8sXD/em3DCSQUZRZbq7bYk5i?=
 =?us-ascii?Q?koSgCyleBEKT4QMF3FFAMI0xY5iViMdvHZkoU1OYo8bEQtUNM0wlsSXOJrID?=
 =?us-ascii?Q?rRwzV1/DgVnCjvvckNkM9YsIerskf2EAPlHMUqgHYZqupdcklkq9pOb2dvA9?=
 =?us-ascii?Q?ueOcdT5hYGUVh8xJf+TX/9NGWJLPgdg63bHLvoRKKlkDijQlDOg+UB4SZxT+?=
 =?us-ascii?Q?OHej+bxmc1MkX+3Ioc7zqQApjOFfNzHYnzIKHvUxHB3cACzppZz6sWW+OpPe?=
 =?us-ascii?Q?WfjXvJSXvM4k9vsqgCFG11quQ5LVxCBWF72f3t6vCy62I395FvGCOzyv8gyG?=
 =?us-ascii?Q?mh5ijYeXjXIbPM0egSUqlYscSIHzsoTjPNHgOtx2e8USrNtNb//BT6rXy17z?=
 =?us-ascii?Q?aTUKYklZn3EJghEhenevnTLlXKh7od0pDyiwrsMb0Y+nDwXr1I5x8PZ4cGdz?=
 =?us-ascii?Q?LYejg1DU4sIxF4agX+hGUTJ+AO42BFBuPtt1zHAmJgGyAsbY3MHDfaXgZr02?=
 =?us-ascii?Q?UhfvHq5YzB9GBpsMwsZy4wp0t5Inn0t2olleZGigjpsukai4QFA+iiwFndBy?=
 =?us-ascii?Q?Abs5RAdeQPvDB4z947mQETyrlXPspPedJDY50rKrGIeVGQsZCYABzggt1m+S?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C797E352754595419A5DB9D486A885EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc712318-673c-4f5c-f1aa-08da85e1d45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 15:03:40.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSDPWp67DvFxw3jHGweP99gljKv6YJQLD0kyATfGQeX8q9dg4FHW0PwtNaj+tCYD4CEbgpEBJKpwyZiEmszicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240057
X-Proofpoint-ORIG-GUID: _1L593UTD5UjJesylkUvOzOUZyan9Qn3
X-Proofpoint-GUID: _1L593UTD5UjJesylkUvOzOUZyan9Qn3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd rather not do this.  I am passing this information in so that the
API can remain the same for when this information is used to make the
preallocation less greedy.  Currently preallocations are done expecting
the worst-case, but with a correctly configured maple state and the
value being store, the allocation calculation can be more accurate.

* Yang Yingliang <yangyingliang@huawei.com> [220824 04:23]:
> 'entry' is not used in mas_preallocate(), so remove it.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  include/linux/maple_tree.h |  2 +-
>  lib/maple_tree.c           |  3 +--
>  lib/test_maple_tree.c      | 32 ++++++++++++++++----------------
>  mm/mmap.c                  | 14 +++++++-------
>  mm/nommu.c                 |  8 ++++----
>  5 files changed, 29 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index a30e03b06bed..61871480d125 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -456,7 +456,7 @@ int mas_store_gfp(struct ma_state *mas, void *entry, =
gfp_t gfp);
>  void mas_store_prealloc(struct ma_state *mas, void *entry);
>  void *mas_find(struct ma_state *mas, unsigned long max);
>  void *mas_find_rev(struct ma_state *mas, unsigned long min);
> -int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp);
> +int mas_preallocate(struct ma_state *mas, gfp_t gfp);
>  bool mas_is_err(struct ma_state *mas);
> =20
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp);
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e1743803c851..2adc12a83caf 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5707,12 +5707,11 @@ void mas_store_prealloc(struct ma_state *mas, voi=
d *entry)
>  /**
>   * mas_preallocate() - Preallocate enough nodes for a store operation
>   * @mas: The maple state
> - * @entry: The entry that will be stored
>   * @gfp: The GFP_FLAGS to use for allocations.
>   *
>   * Return: 0 on success, -ENOMEM if memory could not be allocated.
>   */
> -int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
> +int mas_preallocate(struct ma_state *mas, gfp_t gfp)
>  {
>  	int ret;
> =20
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 4f69e009a015..80d1754de23e 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -35549,7 +35549,7 @@ static noinline void check_prealloc(struct maple_=
tree *mt)
>  	for (i =3D 0; i <=3D max; i++)
>  		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35558,18 +35558,18 @@ static noinline void check_prealloc(struct mapl=
e_tree *mt)
>  	allocated =3D mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
>  	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	mas_destroy(&mas);
>  	allocated =3D mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
> =20
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35577,25 +35577,25 @@ static noinline void check_prealloc(struct mapl=
e_tree *mt)
>  	mn =3D mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
>  	ma_free_rcu(mn);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	mas_destroy(&mas);
>  	allocated =3D mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
>  	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
>  	mn =3D mas_pop_node(&mas);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	mas_destroy(&mas);
>  	allocated =3D mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
>  	ma_free_rcu(mn);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35604,12 +35604,12 @@ static noinline void check_prealloc(struct mapl=
e_tree *mt)
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
>  	mas_push_node(&mas, mn);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	mas_destroy(&mas);
>  	allocated =3D mas_allocated(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35617,21 +35617,21 @@ static noinline void check_prealloc(struct mapl=
e_tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
>  	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
>  	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
>  	mas_store_prealloc(&mas, ptr);
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35639,14 +35639,14 @@ static noinline void check_prealloc(struct mapl=
e_tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
>  	mt_set_non_kernel(1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=
=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) =3D=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
>  	mas_destroy(&mas);
> =20
> =20
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL) !=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated =3D=3D 0);
> @@ -35654,7 +35654,7 @@ static noinline void check_prealloc(struct maple_=
tree *mt)
>  	mas_store_prealloc(&mas, ptr);
>  	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
>  	mt_set_non_kernel(1);
> -	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=
=3D 0);
> +	MT_BUG_ON(mt, mas_preallocate(&mas, GFP_KERNEL & GFP_NOWAIT) =3D=3D 0);
>  	allocated =3D mas_allocated(&mas);
>  	height =3D mas_mt_height(&mas);
>  	MT_BUG_ON(mt, allocated !=3D 0);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6445fd386f04..63a03ce1d0bb 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -473,7 +473,7 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
>  	MA_STATE(mas, &mm->mm_mt, 0, 0);
>  	struct address_space *mapping =3D NULL;
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	if (vma->vm_file) {
> @@ -539,7 +539,7 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
>  	/* Only handles expanding */
>  	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
> =20
> -	if (mas_preallocate(mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(mas, GFP_KERNEL))
>  		goto nomem;
> =20
>  	vma_adjust_trans_huge(vma, start, end, 0);
> @@ -712,7 +712,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
>  		}
>  	}
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
> @@ -1937,7 +1937,7 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
>  		/* Check that both stack segments have the same anon_vma? */
>  	}
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	/* We must make sure the anon_vma is allocated. */
> @@ -2018,7 +2018,7 @@ int expand_downwards(struct vm_area_struct *vma, un=
signed long address)
>  			return -ENOMEM;
>  	}
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	/* We must make sure the anon_vma is allocated. */
> @@ -2310,7 +2310,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
>  	mt_init_flags(&mt_detach, MT_FLAGS_LOCK_EXTERN);
>  	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
> =20
> -	if (mas_preallocate(mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(mas, GFP_KERNEL))
>  		return -ENOMEM;
> =20
>  	mas->last =3D end - 1;
> @@ -2678,7 +2678,7 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
>  			goto free_vma;
>  	}
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		error =3D -ENOMEM;
>  		if (file)
>  			goto unmap_and_free_vma;
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 214c70e1d059..0befa4060aea 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -602,7 +602,7 @@ static int add_vma_to_mm(struct mm_struct *mm, struct=
 vm_area_struct *vma)
>  {
>  	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  		       current->pid);
>  		return -ENOMEM;
> @@ -633,7 +633,7 @@ static int delete_vma_from_mm(struct vm_area_struct *=
vma)
>  {
>  	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  		       current->pid);
>  		return -ENOMEM;
> @@ -1081,7 +1081,7 @@ unsigned long do_mmap(struct file *file,
>  	if (!vma)
>  		goto error_getting_vma;
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> +	if (mas_preallocate(&mas, GFP_KERNEL))
>  		goto error_maple_preallocate;
> =20
>  	region->vm_usage =3D 1;
> @@ -1358,7 +1358,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
>  	if (!new)
>  		goto err_vma_dup;
> =20
> -	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
> +	if (mas_preallocate(&mas, GFP_KERNEL)) {
>  		pr_warn("Allocation of vma tree for process %d failed\n",
>  			current->pid);
>  		goto err_mas_preallocate;
> --=20
> 2.25.1
> =
