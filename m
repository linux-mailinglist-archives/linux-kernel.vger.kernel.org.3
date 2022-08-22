Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D61C59C268
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiHVPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiHVPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D923F334
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVKq022015;
        Mon, 22 Aug 2022 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=BndGsZIi4WUSCPkBxcSeV7c+X1od8dFf+U8sB8dO62In6yHi9zJZvMD1H96nQHK8BCWU
 9ufXjpKtNIpFta/Y9iSNPFaaTnG90M6azX/zLVnHMJxAJCXXsV/XG3R+iKIki7PAUz14
 GhwWJbrtuOJgdo8gcE022NjRmm8YRIcjifTv9WGv8BC5y4y5py1eF6HcUYJEyd9IXXHZ
 zmQtzlNSbKtvRb6GWtXeCq69UjpPTFNUmjeJF/tyZxpDPeGRiXNI/t9OYjFU9YG3Ll8m
 KiRgxBkLU8Vd0ETKnL3/hxNPLfLulnuT0npZ6zNvDOkoD5SBUjPzFHhngyY6hyv0Jzj9 rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NdV035436;
        Mon, 22 Aug 2022 15:06:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u1em-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+KUzrXreHKGgAXtAGPUFr7DDjx0WuDp2Vd7yK6SDII1AgSa1PqVk3bGd+60fyKxboEgSLfnCr+CNXL0UUuAF6b8f/dpwRGs7z13QcJuXJSE/uGX+B7Qj+x7BFconA0M4Ihu99LJY5y4uUrPR+s/Eiw2DV5StbYjuTSuc18F9edaHoKwUYa1YtpVXj41pQ5FaQwYCyNQvmeLWYKoHJH6pcWVjVYTm+MGQhxCcH74Eyw6TuffjH/9Pk/43MLqhzuSzoqfpkYFBBNu3/9ThmM1wMT2U3en6ehCYp1m30rZJ7ANVJ7A68rgwqg4vX0+GlSq38mb5dY7eFtu9Ul7PhWMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=a9P9uS0lGMWZSmf/oUF0r0x1lRw11zUQ/S3YMjOZ7aKyZbZDlI2ncdgrrr8wlBPpTrZLdYpPwnvUCixKZWfzwl4IGpxKpjbGixQxlPj7xEgIdv4DCkBQEg6W5I2oXpLyYtCGXup+KS2FOye05XF7pdqCBXKU5UkLBaT8yTl3EpZbI63WiRZJqNzjUqvn2wyhHgKcgmC538W3YY/4YvVqZTPmWQ4TiebelOrb3BaNQ3fODDFSSkapy4031D1KlFw2gjOASCn5HKYnT+y6pbSaDOx4w5DkHqbmtd0ZJGiRoISbW1h6Dl0HTZKuY3mgFsV97MSUlXoNmXkOsxW+zjPldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pBJLhHwM0A2U3t4MwuSjK0HGrq8NrNzfnQpio4j0EY=;
 b=Bxg2C7Hgi4SVKCVtfErLhAfmQXdB1lvE9GCg+k1FpItem18wcgSRDn5L/y8+eOxXMFHSkhWn9bQL0HGwzi7/4G9pbRfpTMG8o3XK79KKCMJnlXyNcxbSZXVRAtFmx1kfFV+iKY1337Y2wAusCSd+jEepmoAtYnXkfIwqpX01tmM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 60/70] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v13 60/70] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYtjjDr9thXBIL3ka2djT0vP0CZQ==
Date:   Mon, 22 Aug 2022 15:06:31 +0000
Message-ID: <20220822150128.1562046-61-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd73a3fc-32bf-4a9e-cb83-08da844fe7e3
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89SvIBFabW8H/WCEqITtDKcIcbIwtzWGWR43Fz7RN2MGj0hjXKErlIwYZlCkAhu30muIarOpXtPj0/FcSF1tkSfPbRERXcjqZ/lASFxZx0ghznsVClevcVn+cMhK+jH5cC1siyzXgvqPGs6gQm6D7Yc5T9Cu1dQcdNjqCsI5tDOn3e+xGZV9cH87I1j6UwSrM4o3Gl2A5fp5Kw+6B6qyOJbeykNq5RsaEM4BpDP4Ke2pPMAmi8KYFqBFYG/t+PGFwJgX4W3OhUTWVcmky3GmSDf3WxyBNKfdd6cUSbLUsKHFxrokmExRs1KEFG8ICqvX0UyiIuDBO2CxxSPygBEMuHGjlRFfR1O9rWIzPa7MCDzZo9V40UXBisHkhfJhdZh3zY7qkOG3MdUabx+PCb2RreeaCKhj/QeaT53RsYZiI6q5kCTcHfRkxpD2UWc3xUsxerxzOt2RUyp597MSuF/Nw+pzDgXLS7BtyRxEICfpq2pKfbMXjKnB1F0NkTxtaWhO2GrxAq2ygCtfdu4RS+sXz8O0LayRRU9QPCP/S4oBCA18AKlBiywLQD8zfBwwoGGRTywTZr5Ymg1jLjCLp34cVVkzukzGu1Wqk6TmY7iAw22BlX/ffBgWV3wPW5nEx4m2iBVBpGQ5C2h7XyAwHja8TGDQEpx5+xw4AuTQkS64PKwrv2Ef92Awc0etoXyKMN9VF779MT75Al4METOveW+AqpoGsD6LK3PSkUyevmKZWKsafUPGrguj+WsMnLq9SA2+zfxNMLbp3U+/uJrkcHVyBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b7NJQZDtZJmJcE7aiZcpyxpYpABJ/8ll0U4w0THVe5xTFWn9HkJSjRcygU?=
 =?iso-8859-1?Q?t4RpI39c4giV2WmGjrN7f8FyJOQ4Qqp0r1Bi4ulaGmbnZCUYKyeTK35TtH?=
 =?iso-8859-1?Q?apYL0ya25U3SW+A6lkkte7oL8bACtYl3gIdBMPhnzBIsy87Ws9uH1wS1TH?=
 =?iso-8859-1?Q?bZT9H7vgnd0iwi+nw4SNzENC3jyJWsaJWneVYO2HJApcE9webQyZxVqyfm?=
 =?iso-8859-1?Q?VgDbq+Hp+nrcfGrjVbyb9TkSia7AyNsDe5esbkIexTle9Z/JIRqvAcaXfD?=
 =?iso-8859-1?Q?qkESK+6IcllL7kiEq/u7ybjEEjHJOIyugF34OdwcRuHutzh5DGXCrQa4VM?=
 =?iso-8859-1?Q?RWt+HdBMpcvbzmBXnRxy+SXWvqgUwFHLW4t/lqT52tKkKJQpOh+sd7CwV1?=
 =?iso-8859-1?Q?51ZLL/ctfrWC2V1UvJBp59F4Kke263aupuV7Txv/mw1oSSg7PvaXijhITb?=
 =?iso-8859-1?Q?xEszK1E3LcJfEFWopVu54v2Tobw8YgxBphkoIXKORthfYA4w8oCx8HQIkG?=
 =?iso-8859-1?Q?5OZ3IMJCSagcsRD0Zg4mCb+E9fsJXkvTeoArG/1i/YS68sE1WTW/qpAswb?=
 =?iso-8859-1?Q?gGQNLHBfHis7UpQdnf0PF1rCoponIgrrKIEkoklGvuwRKsjHXoheHbaub3?=
 =?iso-8859-1?Q?uUapUBJlSGQ2GQKZM8QsOZG3j/9rQ4sqI4F9oje/CQqxZZk5OYSYoY4MEp?=
 =?iso-8859-1?Q?QeLQdU4n9k8a8DlkTAtOGX/i/6RFjmIuy1bGLJysCVfmzeIA6vGmp2NVld?=
 =?iso-8859-1?Q?yFiP2ham1txYEC8juc6Xj+LqqhFpolvydRex3r5OAc8I4H539O5f9SW3t6?=
 =?iso-8859-1?Q?qAxJV7I23QISGWZ40FYIu1nIx0ekF77LcQwecvdISFxc7wLBo8h3eFk6MA?=
 =?iso-8859-1?Q?RXI5i8QT/4Vv61c48/jbXsSz7qZeR23dhr2e3Q7jBMco+znTyz4H0tkv/O?=
 =?iso-8859-1?Q?y/LwuppOgax9lGGZROrGpbF9aec4LL1dkuPb7S3aK7K7K0UY+K9Jy5LSCx?=
 =?iso-8859-1?Q?PM859hKg5DfjQemwAodRbnnSqHkWdUE9GKe6cM2//r/+5PnbAcTDEmDEcI?=
 =?iso-8859-1?Q?R/uOybdYQOs/yOoiCqxo/bmitLi+pCCgDDwLbeTtEjq983SrfmtcYTt8vH?=
 =?iso-8859-1?Q?ilVShomQamQ6IGUgY4h3OgYec7c/l05mxzbhrpxZuzV8eCx8uUaV+gWD+u?=
 =?iso-8859-1?Q?6AkeKHHv+j0rMgkMt0bo74sJvqcM6htx5xJu+FAX6tWvPTFZ1BkaifmPFx?=
 =?iso-8859-1?Q?3mtf6LBjRPRTdxXGJGMDovFJ11PbOoyJE1uijbNGaDMFHO0U/za9fcZFbP?=
 =?iso-8859-1?Q?NZ3v8Qbv/+RJTFDhmRMf1JH40ynUqCTirkLDfVMd7Rx2Ouwddr8IiL7huW?=
 =?iso-8859-1?Q?A2nQ2t/0bPmIZcAaKEVibHxT229Fjh74eug05AqRcoeKcKCmfq2BVEDI47?=
 =?iso-8859-1?Q?hy59aNTMNmf6oNbfbdyoU9bQzbMfnnDu4pBL3v6ct6ACl5OM9bSd0uHVVM?=
 =?iso-8859-1?Q?rpVkWDmDpNyf3yWekr9WsIcUx2CFiD9i2Fw+XN3gAWIR/Z42JlCsNmwNka?=
 =?iso-8859-1?Q?U/szbr9dtOt62635R7eRD1B5jJHSXmOZEG5mbLS6lpU5vzFNRoBoNBARo/?=
 =?iso-8859-1?Q?Nx9z4Kq1GQ7g+QMhJcmkWR3DXzYE4pwoCbiyy7SXd4VEvoJnhrSZtq3g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd73a3fc-32bf-4a9e-cb83-08da844fe7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:31.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Zem7kVk4patgJYQo3bygSSGXqeBLjKZ+mMPdS9qY26Rn5HZPtc7Fg5oz1nUiFFhOfg9pieAHaV+P/DcjQUZhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=894 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: Mrq7nvzXC6ZCa0P6jHaWfZXrNgN27UVC
X-Proofpoint-ORIG-GUID: Mrq7nvzXC6ZCa0P6jHaWfZXrNgN27UVC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
