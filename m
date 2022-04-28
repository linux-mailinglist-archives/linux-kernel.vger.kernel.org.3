Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2C512996
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiD1ClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiD1ClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:41:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9D2613C;
        Wed, 27 Apr 2022 19:38:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKRx9L011286;
        Thu, 28 Apr 2022 02:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2udExkuQFweTIAIiOSV28yNSpD23/RW6ADciRzxNu18=;
 b=JIYmWHpzv3JKZXDezB71K++Xp/9o91AWWLKF2BDAQsDwyEM1168be06Q/iROBBxBIuiE
 +Sb2NiV+qM+sO4PudkoParROQNcI8E3RbFlULcFRkFpc4/40HCo7pIixxVziwXnS4UvR
 qF0mTZKM68eoNqottNhyXX36XJQICtj9tqxE7W16lixvUZlz2buWt2m3XeroPIWg2zzL
 /uPHyHE2M5hQKm17FkrgEhlk/yggsufLC06AGO3RaCN2ktA9nAwlVUyzTeA6pn9ByUyX
 WaSg3YatuN+SffHy6uXlaxDXgFdGmIak20pd0yxRMgvYj6STFJwTIAPIkd25d1DuIAzW 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4jsh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:37:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S2UbKc028652;
        Thu, 28 Apr 2022 02:37:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymyn42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H65BQkOuii9tp+S8DGBEtZmdMaWR30YQ6StePNUj/RcQiM7HTGDgM+J+BYK0vDHVuYwbsnugIQo16Kf/zmaWewWv7/v98C0XBf0x4p6HyD3ISVanE6xOxIonCI/YPh13BBD2VoxMw7OuONI71cQPQqay+lZffmuBGratW3SmiW8rSObnm1Nj7VBUyJh64PQsTFA9EGe0RQrTNNueqLSIx1uQLG3HRxBObqtIidvfcAwLReyTiur2KTln8uCjyxbectLk/AMDcNfXW5x/hEuoBhguUd6/kECwbGdquUI5TveWdccDQDEyr2M+uBJ9Moe3siWJ8Ovx5jgpG/YXD3KLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2udExkuQFweTIAIiOSV28yNSpD23/RW6ADciRzxNu18=;
 b=EUoXC2sfjL/wGYKiYneqzXaVz/Gr1tkHtqtvNI47D9bdk0uGDfAWluglYKKRdYW/uN60JWMU8vwHat94V8BvMSHH9BcuHa9qZyPifCV0klOvvnvarj0d3blLrpWgd7113zNeRUwc4OflbyMMBknagNB34jh+pBTjUcac8JOYU5kBHsdUO8tAaMhtaQ2BqVNt5PyEqD5NKDN/Z61civzTrkMzvsnvP2uSvS6FCPy6YOnmoq41quo6yOU/ntdbT0o0Dp5zv4ose6LVZ6MBOjbyelHZZlblRTXGZALQoHwg8RzQpGg+yL8NZ1mMIeXloItwsoZ2hCN9SAVZvS+ciq1ovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2udExkuQFweTIAIiOSV28yNSpD23/RW6ADciRzxNu18=;
 b=KDkmiSfvscOZkZbCauk4bNmwYmdZjt5CVn8WyGNDVGscNHLDGdhtvzd8PQV+cuTW4RKsU9w8Q3q+/UmrSh/Er1ShYY3AC4Xw4Bb2nnYIvvo0TKEJfaJ1upHlOfBYp5AybwouXujaOMbQXvwwBDkVTesf/Ijqh1swvcnA9U5Ahos=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 02:37:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:37:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Thread-Topic: linux-next: Fixes tag needs some work in the mm tree
Thread-Index: AQHYWogggqtvLXIe20WcktU26sRjq60EnM+A
Date:   Thu, 28 Apr 2022 02:37:53 +0000
Message-ID: <20220428023743.qaxoj7nrrp5buixn@revolver>
References: <20220428084239.06ebf49d@canb.auug.org.au>
In-Reply-To: <20220428084239.06ebf49d@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 247b3978-c0b0-4977-ac21-08da28c0184a
x-ms-traffictypediagnostic: DS7PR10MB5215:EE_
x-microsoft-antispam-prvs: <DS7PR10MB52152FA08449CC76F272252BFDFD9@DS7PR10MB5215.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aj4EgHi+sLeY4/0XRnrcP8QvdcPVRMJElQWkbQuPgsb+71pVmqibcf73PKvFwnMqlfIT5olq0Obbgx9qs1WKFInal95QANAysFPfN9wmKKadXWiYp0TLCFYXDJJDk8lTHBD8XEcLiiHAYZ8anU5SKJ+2mvpN0e5Xze49tpCkWJiZ61CTwaMbP8e9+n2lyWThl1jcMLjzyID8E0MdORVscgIDCuycY8FpmMISF/eXllGkiDj+2HudP+51aGq+kljiKmxYEW57E6+JieLVMvi6Jd3CLy7pLrZ/dTl5QBr1yecHGRE2haFa2CCoY7+r+l2jOVVYVvOe5pcdAw0hdVuENqcUk6+lgpaZH7XKMAMmzdQuDYfWG3VR9m37teboXZkKoGOqSUj2ouQoHHKiDiQDdNF6ZgtnDSHvqlVuHnQOsZ07IszgeVbkhczVj+ap44RYhGd4WKTJctfj29TF2VA7mYozwNpqE7CnVNrB6Ut78iQwj5tNNjgmaA1eknXd96SuR/h6fh6FNxdc+6ejULMl9dt5Eh/GgNIiXAIA6cmwfmrwhgJ+1QDhKpRst5hDv1EUs+1t9+4ZHyF24HZ5W+IxHwcqT2A45++uEc458sh8zXLUiFhvNDHmCEEq2DOiZvGOs7fGdWusB+PxX0KJf/YMiAqo+eaaEYpMHxkMzewq+B0GtjziktGcoG3sPcxSywEJm4dHC2c/CXYwewznvVpxtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(91956017)(33716001)(2906002)(5660300002)(66476007)(316002)(76116006)(4744005)(186003)(66946007)(66556008)(4326008)(6916009)(83380400001)(8676002)(66446008)(64756008)(8936002)(54906003)(86362001)(71200400001)(6486002)(508600001)(38070700005)(38100700002)(1076003)(26005)(122000001)(9686003)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bFV8zL4uZhGGf6ePrTYlAOJvCUzO3KdIoccauzfSQYj7sv3+8beWEWZGWWxm?=
 =?us-ascii?Q?paZHCPGtksmICmHrtX5JHPg6M1czAu5uCEfVxZBcaEqBGJ6knX1VAqcHAR4f?=
 =?us-ascii?Q?Y7QsdSM21s2+lDB4B5hsuVJkoLupsC7ZXAwe0SrZ8uNNQm8lQxQANH3504Gw?=
 =?us-ascii?Q?NvU0tC4KL7HnH8rx3/lrFrkiOZV1UFol5tnHQSgqlMaC0sFoNGb7r1aMMi22?=
 =?us-ascii?Q?x0XADT9eR5Tvaa6d2lZSsfIm0bKwGwayDkCYJlTU1TVJK3OTAVZg/29SxLKz?=
 =?us-ascii?Q?SUpHGfl+l4fggXG/0wYqzJeM2puar4PMmWRlES5Ul7Qrtayn5aY2u2ydM4w8?=
 =?us-ascii?Q?bQ1bjix7QJFtaY6YZesrfuD2QSCZQ5TwlTFIZD6taIZEDKaClJ9WmyXoOHIM?=
 =?us-ascii?Q?Y9ePTWvLraFoM4KwEf32apnhEO1gEDcNx4o3Y7jYhHteYXPour2/PonDa6Eu?=
 =?us-ascii?Q?/s4oMapU5/gX7adXsICZ33ivkcUL73zzPwJkTagkrzviteyAW8svTgwAqOBq?=
 =?us-ascii?Q?skWNI3Uv6GUIBKtqkdu52Gag81XaHgBMzZtl1TXCm1EyRGf+z7WBOTH9tH7B?=
 =?us-ascii?Q?DmTthhH4GVOLwDKZGC0YiO8snm0vrKM1arVbTBvZMJHWbbwAqGp6zwXH5pUM?=
 =?us-ascii?Q?p7w5xNYL362ZOqviiM7Y+H3lrB+GmsZ4HIarO16TIXwR67CgCIrwLYp8EhI0?=
 =?us-ascii?Q?yq4OaHp3wFLKDV6WM2cTeFkJQ+QXY/0uR8LthE482NC9g+sFZJkNM0oVLVYy?=
 =?us-ascii?Q?aR8xlLCL/bZ50R5Re12/hbSsq5CC4iHZnCV00M9fVfk17f2j7jg+xjXjavH+?=
 =?us-ascii?Q?D2NjO10BNsNIZ2HR7coIU6a6Rwf31VOTKtaMAsHUIl6hI5l0ttR72I/FhCGZ?=
 =?us-ascii?Q?evNzk5j6xKLlybuWg1JNMRcpKrv1QTXQgbxYVtC18cpdkNpfNJNrHKEaTL59?=
 =?us-ascii?Q?/ZQ/5/29ns591gYE3wWnOvco+RAOW1mfDrRSIUF7CMeG/gSDDrzPg/W5EZK/?=
 =?us-ascii?Q?f6oSn9xyA2JAObUOUmeMauZZM8BhTskd3sgtSa7dkeI5xd5FyOwxlJyVohuL?=
 =?us-ascii?Q?SbWrRnPf0iZoxWb88DwJRnMVmxcX98n0LD0S0gMKTyS2KxEo0/4mCfOeF6iP?=
 =?us-ascii?Q?bvndGDK/uve0rot54EgNtWd61DzIqNOzbdJGR/M1jsxPOAEywHks9YeshnAf?=
 =?us-ascii?Q?TYDihh9T7CPaw+3gmXSidPDqLPsL67KBxkA8G3Qiiq06bu4JCP3VmV7qYehc?=
 =?us-ascii?Q?Fk6qFoIPavq1koGH8RPmDV4FmikWo9daOE6sKpwD9Ft8klWmOOM2tdNS8J2K?=
 =?us-ascii?Q?EPUQq37ZafW0Em6I+k+WplBclq2mFRwZxfed5xhDylOhPqVuzET+ugHnXzRg?=
 =?us-ascii?Q?EPGw7qXLmpK1l6ty5lxaiQXoNqlzv+HB/66e6hzUV+4viGa1Rwa81Ki+O1x2?=
 =?us-ascii?Q?+HkbUTLGMuDLnECLflSIoqlNL0QrdxEZ3axLlSs/DValkzTWz9+CKJ2OvlAK?=
 =?us-ascii?Q?ym72byXURuWSqTL/vXZy3z3o/zWEw7zJZapSp074itr0NTE5WHbgVDDuQg0A?=
 =?us-ascii?Q?ACny+dGhxmFj1qnPm89jwkIdwWDwUNShbTGgHaxVOtaZim9c16+/ASt3Msg9?=
 =?us-ascii?Q?A62zV3rhn24bWngD8ibD3k31otbp8ye7pXCkZ5SEZW02oJb9F+uIZT821faE?=
 =?us-ascii?Q?6hTdj/qbGShvH1ge8o7dlU02m/uWdsrAgw6s81FkpVPW+5QWXk/NR4vEgfVM?=
 =?us-ascii?Q?Pduu1EO5Yo2J/5i8MfZedN8qVYlK7yA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3922107623BB44B90DA7F675F6211B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247b3978-c0b0-4977-ac21-08da28c0184a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 02:37:53.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgoNGsUEEADrQKezY8GITOMNNs/SvP4fjYdJC0cHJINYhY2QHz2pExKXcDerG4AKlvXyHRRo8/6uDFFMbdLsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280012
X-Proofpoint-GUID: MRRHqAwuOBdsAIaXY1CpocFgRU4l_pQz
X-Proofpoint-ORIG-GUID: MRRHqAwuOBdsAIaXY1CpocFgRU4l_pQz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [220427 18:42]:
> Hi all,
>=20
> In commit
>=20
>   bc7608890065 ("mm/mlock: use maple state in apply_mlockall_flags()")
>=20
> Fixes tag
>=20
>   Fixes: 0d43186b36c1 (mm/mlock: use vma iterator and instead of vma link=
ed list)
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Maybe you meant
>=20
> Fixes: 1dfcb33e7c19 ("mm/mlock: use vma iterator and instead of vma linke=
d list")

I did.

>=20
> This is a semi-automatic notification - I know this is just a fix patch
> that will probably be rolled into the patch it fixes.

I'm sorry but there will most likely be more of these since I used a
side branch for my fixes today.
