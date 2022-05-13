Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91775264D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381317AbiEMOiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382584AbiEMOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:37:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1312016DC
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:33:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEDQTI003183;
        Fri, 13 May 2022 14:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GcaIRztfRswd1xX0os1bGQS55FDQqtwpk4P/7zPKu4U=;
 b=uh2hXcDw7gjniF7+qau7qLqmt5nG2EWNEYzweBrtErH/WmHtUfQmDGJs2la6+t3GN3/D
 EWBXVN90OYeNed2/rALO9w0HUtgBJZUj+xwhKVHBGaiqSyCz7W5u/NLqlxHokO2pObct
 UmM3ZSq07+MJ1TrpFGcAYgBQLBdPfMeMI30y5bkQkYT3r3ko+ElHoi/cybtGJrhwRC1v
 2BFxfbRzLCaydWeyJXA3rhqlgPDqAT7CTRjLQHniGNFrivxEjIO7y6Tb15FWUi8p5vRN
 H1h+ya0AZvtMYuA/zIOBK7EQBLVmoLbXdZJ4oXFQX4kHaQmejSBN1ALy9Pa9kPWnY0Wj hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04ps4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:33:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DEPkXw003138;
        Fri, 13 May 2022 14:32:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7d171q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr3Lpnmi4pXBrbKlQCny12QFKIJuKXBR8pDCy9MzBVNUqsQnsHSK++h9e8dtYOLQ1ZCKBm4Kw8t4PM1eEgG09xyLpxPRaa37fKWqli9xPZHcvozG16+XpVmSAYLJuxK+GkQwxlIXH7gu5JwoVII6jBS0VA/DQ9gLrN8gNOryr7JgT9ukHIrS+6hUTxKSKYLPzYkTt5VO8DwVH4IaMB5Xgt26cps9gV5VAG9mDgWt5SrgTZBR0FXtYCUGhkBW87wK3nWbaCnscYLY4PhRGbT18yrsYVj8QPGOnKGthMlcl5+D4tUINqOiLA2lHQTmZKEhL2ocMbxcRBu1/corHTBiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcaIRztfRswd1xX0os1bGQS55FDQqtwpk4P/7zPKu4U=;
 b=Hgjp8GGOsU7xONnNmSSLyMxmqMF5EHP32U4ljNPZVh+Zfp3UuaZL9O8jlkIr9pdRfUbPqb0jZGT2cl5G++DwgPMNFfS3KEVBAwHqfect7fCHlTiM0KgIL/3RPLmILbOibuZeDE7UlNvUQpdluhm1rkxQqBx7iGUp34rI/L73WcEyvi0OAso4+LlJ9HrSsWfESKQYKTXN5cxqr/PCMMnfNrDOOk2PownQXjwgHKyjMt8IIuTGw3lh0lRKBhIhjlshKJxdJtNMGPQiD6lQcVP+RKWpy0mgjTNd9+e89BDoURcNoytZdKri6ChU2AB/LVquHrOQGnI5a16MsHtw6qkWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcaIRztfRswd1xX0os1bGQS55FDQqtwpk4P/7zPKu4U=;
 b=JwqxcBz+9iuUsXHPkXykbEKOYxV9NQhvlE9hmFMpPlGvvUYcIVpMu2kE5jyBN9pIZtpv3eaTzBXhpYMLsHkxxo6pgivS6qaC2aQYs4bejeB3kSLEUAyl+D/9RwFaRsdJBthzyrOsqVeHpfQC+OvnFugEj72+I+Osdr0MrmsDf6Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1299.namprd10.prod.outlook.com (2603:10b6:404:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 14:32:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.025; Fri, 13 May 2022
 14:32:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH] mm/mmap: Fix potential leak on do_mas_align_munmap()
Thread-Topic: [PATCH] mm/mmap: Fix potential leak on do_mas_align_munmap()
Thread-Index: AQHYZtP0s1FcGwbLQUKRqSIXxyhDeK0c3vgA
Date:   Fri, 13 May 2022 14:32:57 +0000
Message-ID: <20220513143246.jfqvxwr6rejsdfou@revolver>
References: <20220513141548.2019143-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220513141548.2019143-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98f26f85-8174-4137-e9c2-08da34ed7956
x-ms-traffictypediagnostic: BN6PR10MB1299:EE_
x-microsoft-antispam-prvs: <BN6PR10MB129915AEE89B846251C2BC06FDCA9@BN6PR10MB1299.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ibUZUS4Btq7duk3EwY8KYp+Q0N808arZGpkjKe89Q4IqH5YETj+hTXD0ZU966Mo9UOdnUFe4QSfijVSJ4o23xuXWTDfNSr2yLmLcFnrzv+bE7q6DgkT/0laJ+Hy8D1hTtDLOkbHqnc9MYJGn0sv7yJgQvT3BLXJOc3qfjLxriN72LHrl0jgbp0mKZjppi+hzVLrBLUUK+/5ZT1GA5KyKV5KItpyaaQQjhUMFOunowVUv9h9IyqfMxkj1Jo3HjNvehV5eS07e0gNqEeReVlqF08r+7B7nV25Z3KPCv7mdp3RD9Mkr8wf+E4bsNkZrZwiWy3jBGst5mBWCmdbN2YGRTyCe3EoDIbCaqnvGQlkWhC21ed8ypbaRv0ndYEEaxw5wxQEwpbDHXb0YONFJRVT0laSbFCI/S6ajWyEbo5tomszNCkkuNtw3sqo3j8gP7XwgqWxQQ8eMV+8MZm+H8VEstwdogILea0a15uY5QWrEB8aY8SRzZBXuEU06NrPsaND+IsDNwHqYbGvGMBd4bal/8kHugkBHneofigyoT9/ECz7HNCNCBUUC2BUUm03RBI3FIKr1EGomGQL0Thhe0H7emWnwbkrxzQsJ6P146vjc10xKYsTXNw57V8ZDM1hNaXavRt2IHPR/93d0FgWT3edU1Qa5WzGXs7z/18U1KIttAd9pNSkOvxkyDRhpdMT4nU3SIuzcp+IoAHYUJ6GY3vekg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(4326008)(33716001)(71200400001)(8676002)(9686003)(26005)(86362001)(6512007)(6486002)(44832011)(2906002)(6506007)(122000001)(38070700005)(5660300002)(508600001)(8936002)(186003)(38100700002)(316002)(66446008)(66556008)(66946007)(91956017)(110136005)(76116006)(66476007)(64756008)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BwH5NbK2jqEZddAPDmK9J55wxIt7l1kfhZVfGMq7cEzKpW2As+e3ynaubmMo?=
 =?us-ascii?Q?vSx84UGuOlN/2o7GBHCVT1PFAAOmgi3Kl2UGa2doKvQAbtgbsv3SqujOzC4l?=
 =?us-ascii?Q?n3wVb6UCJn6xyUsWaxpRG0Tcw9s7529Rxjk52SBaPi3V5m8cIsH3gp3OgpUt?=
 =?us-ascii?Q?BbZEuYxW6SJ0e7aul3rZvlg8TpZ8VTrQO6TEBzLI7S64y6sz9XofwjITQmav?=
 =?us-ascii?Q?Px/lAKlyOGCwsO9LCCT33o4cCJ/42znCDdbgpXtrRtqWaqofED3EzSXsE1Yd?=
 =?us-ascii?Q?ynMFXSP/15jKm//GGhYYiUYLz8Eef5zWqGv93+iD06jEm+UWOKcQTBaUd79G?=
 =?us-ascii?Q?GtHIiywBQDHoNEQl9WEpqvePyZ66g14ar5tqgY0Pqf05oiKWU/rKG+XfOT2w?=
 =?us-ascii?Q?88WyvzB3Gea40NU58yI75NYQpqbxPvpBi/zKm16lkl5+UNQs0rfHiqyXMTd4?=
 =?us-ascii?Q?YZyd0XswnFT9sTYEsPhqFz0IAwv/AR57PjZd0foOSU61nwEAfiq579tbondr?=
 =?us-ascii?Q?fnST1D0hkoD7ir0GIcYVpeEnLG3wXHAeVAmeE58pt8c31bdPP006QHDQwKSK?=
 =?us-ascii?Q?ifeRMd3nhm0mdEkWLmfounI9Mtm7lIhPkO5dBuMFTEMwInhmVoO3Xf59xoNJ?=
 =?us-ascii?Q?iLsiiR9dHPW8oBGy8Ybp4MLeEaPUBZ2ebsPsaqOHzTGYqDVgpcnuHSVf0Y6C?=
 =?us-ascii?Q?S4xAL0GzV+XoUkupqvYaPF9/pM4Dh1/RakYE67i7kxSPfLtBPBEB0kq0mmDn?=
 =?us-ascii?Q?lfxSIl+Ku36TMDeTbFruiBlQoUSL21za3ySgweZ1UmuU776jxfyq+Cvfnecu?=
 =?us-ascii?Q?YuzYOzD7iMKCeoCaVXVRhsg07IR88uOiP1DTfuOLgQkUYkDENEQlIahlqANo?=
 =?us-ascii?Q?rugXDpTLEitqGwf9LtMQ3IXOmqxdGYuM0UnKr9J/c7+0WNlYf3tKthrDKfxa?=
 =?us-ascii?Q?ZkB2AqYvA0RK5ocGdK6dRk5RzV/UUdi9K6RY+Fj4TsGrlSELtH3YnWB9AcFa?=
 =?us-ascii?Q?1Qzw1xm55emjuoocrqvqB/BbLRYNdwnKHUY6/yVHHq1Skk+zyIhl+LamP4Jn?=
 =?us-ascii?Q?0PleRJjaYXAxxmW82AA8gjRMMI4fFesCoSThS5WAJ9garFSav/m1/0PLE4Dv?=
 =?us-ascii?Q?rZ1M2su9hrHpnlC+YmLZWqPTDBH/qhTiSl9osEmSSOM1fTjXYO9y/ugmbe7E?=
 =?us-ascii?Q?D9SXdGDSaOVObevuSurTsQilGRDyKwPxZRp+xTD62vhAJtJatDEdBqrpoSMM?=
 =?us-ascii?Q?IPt+pyuyUiEC4ECZwo2n4lOwCUDZNUsmQUM4AxKLSJ4PQkeZlMFrFtUFJgL0?=
 =?us-ascii?Q?aXSpuqhzUgsyci83rqHwDcINiZ0YPomcQ6+HYeyr+/My5Zv+loXRggydoahY?=
 =?us-ascii?Q?DZQl0pbxHtXvZoB7mSuaGaUgYvXRa4meUSZWBqhV3ceqFZhPksErXgvTHYxM?=
 =?us-ascii?Q?s4HdmAJO1nuRjrD9oHAZkFcowQNUAmIEbXtEsd8cNmp1bfz6XsFw1f+0It6M?=
 =?us-ascii?Q?UYb5jS8jwYrUmhZQVQIkhpAEZxoOg85zervxk9zia3fkljNoxW/TqMH34o/F?=
 =?us-ascii?Q?M8JR1Vy6qVDXwXwwMeVhIc8XB34m84ne8bNjTEWV2PUB40Je/7w0LiEDfgIu?=
 =?us-ascii?Q?7mr1kJMkv5vLeVz9gxoQruGe4aSSqYWLvqezhykmzOmLLVMjbkX2r/yCMe5x?=
 =?us-ascii?Q?uVyrcPFCjK0aY7zxtLEAZtlvFe3AHyiLLMB0I2p3gATVel3O7Jpdk8eEVztv?=
 =?us-ascii?Q?B65bzowxreVE2E3QiGUpKgzkJ3KtDb0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1BBB6B0E85D7C4B90967858A5FF19DD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f26f85-8174-4137-e9c2-08da34ed7956
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 14:32:57.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLZXGPAiMO9I/msz8WTSzQovW9lMr00o9Tc1QPKouvGmmqIBF+kYosHhLJecNBqJg72MsJjzchGENwUxsxcuXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1299
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-13_04:2022-05-13,2022-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130063
X-Proofpoint-GUID: H_Mds4XMnzJqYlHVpy_3l6UZtNngZspb
X-Proofpoint-ORIG-GUID: H_Mds4XMnzJqYlHVpy_3l6UZtNngZspb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam Howlett <liam.howlett@oracle.com> [220513 10:16]:
> There is a leak when the system is low on resources and fails to
> allocate enough memory to complete the munmap task.  Fix this by adding
> the necessary free operations in the unwinding.
>=20
> Fixes: a760774e7b7b (mm: start tracking VMAs with maple tree)

This is the wrong fixes.  It fixes "67/69 mm: remove the vma
linked list".


> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ebfd71a79814..9d41df730b22 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2365,7 +2365,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
>  		return -ENOMEM;
> =20
>  	if (mas_preallocate(&mas_detach, vma, GFP_KERNEL))
> -		return -ENOMEM;
> +		goto detach_alloc_fail;
> =20
>  	mas->last =3D end - 1;
>  	/*
> @@ -2504,6 +2504,8 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
>  map_count_exceeded:
>  split_failed:
>  userfaultfd_error:
> +	mas_destroy(&mas_detach);
> +detach_alloc_fail:
>  	mas_destroy(mas);
>  	return error;
>  }
> --=20
> 2.35.1
> =
