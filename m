Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1259C275
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiHVPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHVPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:11:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FCF19009
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirdf017906;
        Mon, 22 Aug 2022 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3hrCNWdUn9eX4meCmCklSuJvFM3DauxRFflDJLK7k3Q=;
 b=GPr/TOau4m9o3vBw3+KYu49xowocv+rlZ+1b3602WkK3ngGVsYjRaQteMLxEYIdCFLhJ
 QjMfYDckWtgl/3ToF0jeoC6jfpwqz1mDXIKo2UKXWgMDAwLZwm1FwTjHGQE04AOLxnhd
 VfY9JqTNn3KZslTcz9bM2Z475dsSgK6zptXqlRVPY9mXopV39vx1xZV88cJ5ElCby0oz
 7P2kTCZCbmO5NQtsysqUQhh5HiExH4qU9CJiGWM1pDLjAaA+Mhq7J97B5MyItSDXUPvl
 MMGD24a9DzFWgNTvVGCqU/gCVxg/fHmnEW3HCYQQCzXlm3Fl0DpymAw/pAtUt/Uja3qc 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt049v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nai031868;
        Mon, 22 Aug 2022 15:06:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx0Ccq3BVWJlLrMLn/wyj1o0QKsCtlhj8qxBXzczFCtTpMzMaJNiSZEURYFTxj7Z1C0QtCcelS64xfs8tmy1jPKCfZ+33nS18MooT10QmneATBuQfpYT/gPSK9zk5gsYrqKbcw26ufc76ahVEpxDHgLi7BHoaUXVgctNBmDfjzyjqrBbDkXesfZ/zMDAxqcCpiarpfVPR5+MbfpjCf7GxUmCxNxaH2tXltwB0wZo8e4pYAkZeTW/pROb/j8BYop+/OkCr/7DIeGzLlKIP/Rw1c2qeVkPPfg/uQhHA3I8VGuFp9mcSOgfEbWj7dwEChMIZDvtZGi7USX+6IhEvdSMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hrCNWdUn9eX4meCmCklSuJvFM3DauxRFflDJLK7k3Q=;
 b=Zrvgt7AKM2ZfuEpYOmcQR4OvaeQT+7sZ5cEPrCK6RG3MgN1a8WYmhJo7HalhuVg1t9uYCDIOadtUVebobI8uWOYG/DvdzgkFRffyUc7QuaS6A6GpA2yN5xR3gTzXggDqsJKmGtvGAxaWHEStVMKoQTtHY40QR02hx27bzzJVVGYX9SMggcNRMNUPBtmbnaSA9WwAoPsqEYo3KQ2hlGw5Ikx3v87VdIpxm0s8ojpQnyEjDlNEdwPioOqvhZIm/sN9mcdb69i2khwPV8u2adY1RHRNXOpKgZ/2CvC9KWUNuXN/NqoUqQjGN1wp8wKWsf1gG71wmiZXSNwP2ZbL3bR/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hrCNWdUn9eX4meCmCklSuJvFM3DauxRFflDJLK7k3Q=;
 b=v4yr1eOmHBc7Thd6/MoFsP9OZgnIkoZyWDeAwz6L1dgv0pdCVj3XFDSkd9PnL/nsHKqWAPGq5MEhXSpDdqA6IXrSqscL3GJ8+BOK+JmUiJscFN8bUMO266vIVF8u38RjhgehxvDt/MENXlZd3hjMPk+j6WwCQ9Av6yxCssyMV7I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 49/70] fork: use VMA iterator
Thread-Topic: [PATCH v13 49/70] fork: use VMA iterator
Thread-Index: AQHYtjjALUhylvreZk6n/LUIopz1JQ==
Date:   Mon, 22 Aug 2022 15:06:27 +0000
Message-ID: <20220822150128.1562046-50-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b3c3cb2-6ed1-4d82-fa19-08da844fe4fb
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tq56x5BasT2JTaLUWZM8C7vT9fJnhgAma7NdO6ieZixBEDbPx+e3157QmzzDy55KyyeQkhPywl4uyf206Yr8y931gzmG+R6nezibjlIWlyqDbyMAjMNp/qQby79F9p2QAk+wKk68bizB4ix9701RAen8T4h42rb1v3WLQEP9s3q1w62LJzDly3WdL863uaFSVrNXPclzAE++uhPdq0W5YihXQFm57qXJiIpwQYBs79eAiaTbNB2esz1u/9ejZ/xi2QbH/GxTaBj72hCe4in7Jv+9hmCdJv9QzwyJgpDIu2QQ05ZdulE4qkSecwIc7QltzApatx0SdObTHqMMfA66CROkSaU3H4r1fG5ckRjoowyZcSUzAfKCxvxjSBWlzq8UNEnhgZU1P3pDY2WDenAnFOcqV6nnvJOMcqJ5bYaGVNEzk8tW+QyEU0Li3OsICMoVFI2VtJESYkBuM1X5Z+NqV0EPaP7H09PVtfLuZWQxKYF64rd3cf0ILLHB7YlGef/aUrz8DHKarq0oz4xjGCUyHWb9rOix+OZE8gqkK+1Ro383MpT7oBd5AmIl2KF3O/hrRXDGOcEMxvSq0LLiaylM2vP2wz8Mu/+UHmYR+j17aikOJ1cc/QTTd/jjpJqjNMR30iOECBgn93AxkOT3aPOXSRSn8fmSgM/+uP5wnEyG7qoXspc0EUITzmi7xzgTr+IlQqAL9JJdJd35OjacggoGpD5ywNxedWXNvRyP3Y3fgx6CmGSagFYfe+tNzUzScAr40U0OEyDeU7AOnUaULusYig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X6sTFrFi3oqtof3ooPoMVfhMV2I4fd23ok2c433tGH1ps2oFPLQqEbTIl4?=
 =?iso-8859-1?Q?W78vNhlS7afg8j8m72HlCcEFNnXyT8cnJE3WhP1QkvFS+UafoglpcML8Ob?=
 =?iso-8859-1?Q?Zz7xYZS5TNLcDUI23KJ6WSrySE+JTaYpTVs3BI2vyYcuNz6LovUv7IEfsA?=
 =?iso-8859-1?Q?2ByLqFAihVP6nQvTaFJpWxZtR01akzZbvEeovXgH663EOBBFD9+PfHO4az?=
 =?iso-8859-1?Q?7+MHfTuMa4i0lRjoQDVgeoinI6VYIXFtfqlQuTu3wiyiLh2eV5mo7u+den?=
 =?iso-8859-1?Q?g+tyad1TSyKIFVaUthFHKv2fwxK8+5inKzoiodEOm25BCeZptHArXjgtSQ?=
 =?iso-8859-1?Q?6LrqdcXwt5frQXCw4CWnZyPmMlFfuI1nyyTURlvoDH+xsE0ulkAVjbdDxI?=
 =?iso-8859-1?Q?sYLSwqOiUbPi0qfcOMF5AxP40zaJF+0B36+F+9b51yc0OOwQyQADKgdQ2t?=
 =?iso-8859-1?Q?ytamFYVXejrNaGuxxIjdApEZ6Xpt/HxR5catMBb8mC1mhGyoaqXV8KA7pa?=
 =?iso-8859-1?Q?VihFXxBbJosIJGguxY76xcO2ueMacnFLhoxA+x1a+kbPP52PKWhFqQ9Zg3?=
 =?iso-8859-1?Q?m0sLFH38TyCbjZIBkMuia29B9R8xemgFqh+KnHJgcw4RcDnb613ShmWe8c?=
 =?iso-8859-1?Q?Sm79aky1KRjEUeF0ikuH5ml8L6rSJH/S2tIEiCpS3XnBCZuxgQXQNpO/it?=
 =?iso-8859-1?Q?HanfOCtIPZicLS4KZeV/mk1nSNvovl7z2Y9dMpcmMvo4AxkdGADcGAEQMf?=
 =?iso-8859-1?Q?UZylMWau0azQQabcL+hj5w96JeS6JtYWWhYc2YtRwVowwuXNC0y60R/l+7?=
 =?iso-8859-1?Q?1fKqib3xZEl4pYQjVXoGdzjKp2pxl1KYRXjiS5VpZm9T6TaYDIfHfix3zB?=
 =?iso-8859-1?Q?Vg/Az1qNhKa2KiFq5Qc6B6WmoHRwhrYxIGIZuQxEZAcohBCsitWzHWIMmm?=
 =?iso-8859-1?Q?n7NyiVI/i8lU9xB5WU24tNEZsa+ysMmUopWXLcU/N4WJYVGuZzZ2Z3BtRe?=
 =?iso-8859-1?Q?s4UbNlfTQTRY7ZMeWBrOkvjepjvsDpm/2o0xYE0rahBI7sLXVq7dmBfmM1?=
 =?iso-8859-1?Q?Jb4hPI8Z6EQzXxXSW3ciEpUq1a8AZl4zNutQBxrwdmgyEuXC1pVFQ25HFm?=
 =?iso-8859-1?Q?mFNHwaVMMHKrVajK+wM2Ldycm0eiY3eiMSSfGeToep5GvVgc2/DgE5QJQ/?=
 =?iso-8859-1?Q?0z0hge8JDFiVtLwL+bXjlk1SY4oZeutAMrkWQhnxGyBTOOL4CzeV34hJhu?=
 =?iso-8859-1?Q?aJBkQbO9PG8NTgyynJoXZsk5JnwG+TyjjIJy7IAahkEDGjd1wbmoHP90+g?=
 =?iso-8859-1?Q?KR6JnH8vUPpARyx2DXpms2ipKF9ulAxuEY3DFo+0nkcpcHnNDkD0O3F5DD?=
 =?iso-8859-1?Q?pwH5fDppxBu7q6o+6yLmDoixvpQmzACDvbT/WHfxPzDlKbnks0h0iTRQzf?=
 =?iso-8859-1?Q?3agA/WWrLoEDwit3tqw6RZDCXndcpJdRLKnlo7PNVPnnx0TPAI5qnd9XJx?=
 =?iso-8859-1?Q?2C7dGdNQ8+Kvh6OiX8aDi5LICRszuElfHivmLyfeY6FKlYUlD9S+d1ZxD/?=
 =?iso-8859-1?Q?g3NY7bkGp4KaowEK7ZRgEeF/uqEBKk1QO3qist307fPwFSxo8vFu+0MJcZ?=
 =?iso-8859-1?Q?B3Ko/7tf/Jx4YrENOOs9AWmZyZYpMvht4+GdzbLFfxdrM971M59Q84LA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3c3cb2-6ed1-4d82-fa19-08da844fe4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:27.9256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjS05e/IqE21YAKXObFBi4tWxg++qPB0B1Zp1CVJc/plLpzLxvPpLp8vBDeFAgxlt9DT+o8JVtVwkR5oZIv8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=984 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: ZCu96z9geicd3NMvukpyS3bSKp9XWEn0
X-Proofpoint-GUID: ZCu96z9geicd3NMvukpyS3bSKp9XWEn0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 430f63cd7a37..49e4ab6f5208 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1301,13 +1301,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
