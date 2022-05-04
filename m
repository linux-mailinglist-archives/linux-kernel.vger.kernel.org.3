Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9E51934E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbiEDBRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244945AbiEDBRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8322E9E4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:13:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LNHV6032436;
        Wed, 4 May 2022 01:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=shJfpSXSWL6jqD9oqTLc8CmO6sDnzEnQe7VbIvuAtC8q/6yeat8zjv3DCM0mhznfGSjX
 aN2aEfnTZw+7y6iwEkWKnPhLSdliJNCng4whxW+/krOk2BZFm5DC2jYzHX/ihnasgTzp
 jzSfhHKYYvt3mSuYUrwoR4kkjasINM08dNfrWYa8msqSQwWy92PcNPdLB9CRxC3ZrZVK
 yxPRNr4iU2ICqRo9t8HMGaZbh69K+tWw1DT0T6/kiE2lKG+yc8XSCPWbUAxr9Bhc6i1x
 hgs6SjaYaiUcELCulqvScJ6+wXYjmYzBNbF33DgGl5e0Vtz4a24wmEYTEuF08vmyrtF6 gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJS013094;
        Wed, 4 May 2022 01:13:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bldunigIl9wR27O0J4+mwDpMU9jwVGQKcOk2YTW8KzCcE7U75xIkGTG3FTBbNntijb5BW6pRPash2AZRowSOHkRZhHP1KnoiGKNhq5/Mlsa+f224mSlH6YOxcWU3636WcFc5HRlg16a69lzc5bK8E098aRxRn71sQaZWgfaYmlpMjcwx5tQ8F0xhfNgBe7vrvCkohT5wertdss6oXj6l5333bpfnEbn6s1Bzn+4nQd30Mn5NlXytVrAyH5LKWMCEz7gztNp7CEjjuKLMi5r8Zrh7E5+5LTh7YfhzvpRJ8ZGjZP+W/Aw7MnMLNXcrXQwIkCPNG7oLQ1m27sCtHf5OPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=AuQCKg128XUkJOC7yYr8E01MlTSJvdcc0JrpsK/ywQhS7+do2GgSTxezf2lopN0LD2nNCaBHMAcpPK/hmSR86lq9fij3l4LPNJoypcsrGNC0m4uFYYFlBrum1zs2sdaYLzgJhPIYWoHoJ/wwWboqbsp+xI4SjWcT7IIqiH53kZDZu1JnFp9bVAq/0REeIwH1Aw9qioFeMqwKxdfx0RsUWHKsIIchJBO3ERrd3cCNA2ELql5LgtPw5KwL8oHdy2/rCIuaT9189gK2mdUc3mzjqGGjkoDHQDOTyxYuf3izGcsR2Un0BgUa4vHd7PUxyzd3SxzNoNvtX5FXfssHJWqu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1w5yrm3MQROUeplyTDHfdB7riWJZI1g05guZF5U5nig=;
 b=A26CYJpfmvsaXEKa8l9ChEN9fFuAPv6EwODxhUtIxpEyHb26Br396bljGqd/MqSb+yCUsJXzKFHhhS3Yd5Hw4ZUs5mZel3A/1CDhKizpGu/wdvm/EJT5hZ+O0GXwbDDFKXr4cF/Cc5Px78AxNjJpKTlbUn4VeyV7IdiTGNadQOk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v9 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYX1Q2u/+dP5PV+UuO5Z0G/LDZvw==
Date:   Wed, 4 May 2022 01:13:50 +0000
Message-ID: <20220504011345.662299-4-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b7b220-0c04-4a34-2935-08da2d6b591c
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58300C0484967010D29B017BFDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfaM095PH0tltiDQeiO9Vlc7g4N5BpQEEjjut5vea0Ia08aYdD5YjEMp8+VfnIgoapHuyWojiMdxn93UPIzMq92/Bl6pfW/AEBz/SZCTPMvM4CAEAgvA0RLXE0gJa/WenWGXolvca6uuDXWTpBRAz674A879D4/b3wF3R91rB/uOovy/1gTSC8peLVWrqSmXnXic3mXVSzWgfdwNu6ayhF1WiUNNFYhX4gXQEOCogmwfjqBLlBTG8/vvxQa78ElZifDQ6XQFD9aN5uHYNI+CqKj7kgpvQQeFKpIboM/EAkCXS1OSxKxXBIvmUkjPrMr4zH2CPwezLeEFspmjJuvAT6joOrY/KnOLjs4bbDzzrooxBpvOpmimA2UWxVvnKVCIGryf75MoFcxHBntfXuuN04F6lY+MXxrjC1iZikvR/uIlGYTg82JGxuykR4oobcZw7e8ZReQsos0p/pz9kmJL49BogZUGjlLBaEp/TdiErzL5ePT07WOBPhwTKCfIT0KfIFkSWKdP4I4aa1Rs/2UeJ7y132ZjyVR9dSvJYX4/ny5uQ7WAAo+R2fbVJ4B9E4czYay/z9jdV7qMuaFaDBijY8TYNQ7YRQ9ieEWGLNIXZo+bIAwyglLNPUMUiNzpBGkLb658i5FtcAeVLihsNy0gOcXfFOukmetSCU9rqxLfhTnr26z+hP4Bxr4jwSQFyGl9Mel46ITmd9fS13e4lwvR3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(4744005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bqdOpFacJKjuQW+JxXksabFLo9ulLRUohXG0FBXzDeZRh9kIvrKPiL2LJO?=
 =?iso-8859-1?Q?2DcQmW6PfeKj6j/gpogeNSXYn0C4ZLlKNjAsfVwsRPJMGE9wC87Tme1/ND?=
 =?iso-8859-1?Q?Dx8y0XUFhN9Y5eduewWI7euuGh7tOVxpS1NTAHsvDT2Z7sHhWe31kNUN40?=
 =?iso-8859-1?Q?H/zJ4YKEI2Y2Pp8irWbxL0yhdnCKwgmb3jJO1xd0dr1pJCMWQHQsshNfeJ?=
 =?iso-8859-1?Q?xquiWuMnrqDZVb037xIFEmiNBk0wTCZbg30C8R9lNhGjz56SnTPxDBaS0Q?=
 =?iso-8859-1?Q?DXABVzwWNY3vb0fBlmYD+38Dzn+YK1RwM+Ba1JZI2iEz2etlAT/uYIyZKW?=
 =?iso-8859-1?Q?gA6R1TvVQQJIzSJcI26KIkuYfWz52oxlb312fyLgbIKJAL7r4OTOeGARRs?=
 =?iso-8859-1?Q?MsmPFvTx4XemfnQSWaIeUAwJMwAa62eOQe++ubOddOAwAqPrJynFQMh64L?=
 =?iso-8859-1?Q?WxSW/l9hJ2VWRS9Yc0s0u9EZPDaO0Z1837X2nD/TDEWOObJ6XjuFdDmfRP?=
 =?iso-8859-1?Q?F61V8wxa/o6I9WDIQxMi2D7BhI/nbp985LOcQxzhLutiomGB1d1Al3Fuqk?=
 =?iso-8859-1?Q?YKRjCDsDDd1Gy10EWxBmCoC+w+Nuth1B7Fow7bElqYA5jzKGFFl66I7I0Z?=
 =?iso-8859-1?Q?Bt53fwaIQuWT1l4NsCw8gxGn/NXnXLF6g/FjXwuv7dbnisioFXeZukXIqo?=
 =?iso-8859-1?Q?Gi1CKXaB67TBw+Pyl1Qb4LAW3lJ1SyXrBUU0aqIQClw+ijUgfUvl6L/QsT?=
 =?iso-8859-1?Q?rszMro4eSEvgKNykKNQCxOHdgmHXaL8AElPW5kSO3SO3axQV4WQeEa8F9N?=
 =?iso-8859-1?Q?c2PwmqNahoSOs8ztIkKgMgLchAYI2AqzUzp1rS0fm/6Dihd8ck9VyiRWPc?=
 =?iso-8859-1?Q?bguOiclIHwzC2fIjL94YjjX1Y8q94pXbB2JyCeR/5kKvvEo5poWeW8+UNk?=
 =?iso-8859-1?Q?1cFI4V55CyV5aQL288uzdy3zX/v2HJBvXV+E2nbVqLDKwdow6WgpeJ6slT?=
 =?iso-8859-1?Q?rS+a2bBYGlhkt2+7DblDSSKqeSuwGh/PrEPxJTKxL5ZTtSavIzp/y0kW3H?=
 =?iso-8859-1?Q?8X6NB+3EPkgT1TnkFal0OgkOCfOeTNEFqHrIB1s5CGxA0877Lsk1vZhRoz?=
 =?iso-8859-1?Q?uG15xvBBwkFLaQwnvGb2dGXLD3pnUHUXCLdCpNekJzXxAqq40wTbTHANTO?=
 =?iso-8859-1?Q?nuhZPM1PI8Q3at6Zn/FNipmn2vy9zxWu1vtR4Iy2OlBGYL8o+RZtdm14Be?=
 =?iso-8859-1?Q?Ab20k0AFylrnIRp+ZFNg3ePvX5VKWMyyGxqEDlzpb7XrYwsL9H2kNNiy6j?=
 =?iso-8859-1?Q?VEta0I5CidgYo9kGRNA6MmgAvBKkaBOJUHEvcwEClSCYvCwWn+t5pYVp8L?=
 =?iso-8859-1?Q?NtG7pGyj6d7SmmcqBOY5sVvlLzNdlnnrOljMTB3iGSfvSmZ70nccFqholZ?=
 =?iso-8859-1?Q?GNVfAT8dOuYHpDCQnD06qQXZfYIQdnCcclqiMBiDZTQb+Oq0y10124j00u?=
 =?iso-8859-1?Q?42MteWW3GgfXZfI48XZUWal0HFw7FkOeswuoBmr18jzgXCTOcWxP/51wlK?=
 =?iso-8859-1?Q?roQdH05h/jYsxR65mnLUSxBfOoynSNkRp6jdUroAmIKpoM1auOYQp2S8Dg?=
 =?iso-8859-1?Q?d9p8bv4KpGs5uqv9jiLBZCFzW/Qq/l4xrNc4p9B84m+c9JzbAMVxRscTcT?=
 =?iso-8859-1?Q?ZnES4AkfNxSHaUN7Oo6zHZtekhETw1aFC2ISyoQ5yqLDvXOgSmC1c8IDkz?=
 =?iso-8859-1?Q?1eFlb+NO7symkNxvFRTwrlW6W5iHHRGSb9Gd1tJq01lV7E6zUTwLtmd79E?=
 =?iso-8859-1?Q?+OTkMDjg6/limVmXoFOnfLQixDY4XU8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b7b220-0c04-4a34-2935-08da2d6b591c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:50.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvbm6WMTO/EuMiqTKBKVf/JUhRn4cIoJYZHMHEuTP1PWQHLPPRV3bdPd1BdLfkOaUaLebJ3ZRuOygUSlTH9dUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: XkEAs-dySM-Tyt-uhmvvAnuI07FdoS5T
X-Proofpoint-ORIG-GUID: XkEAs-dySM-Tyt-uhmvvAnuI07FdoS5T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
