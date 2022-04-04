Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422D4F171F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377715AbiDDOiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377797AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520A3F335
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3NV014690;
        Mon, 4 Apr 2022 14:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Kf8469ZbINCOd/C9duwq2qK4gaY8qg0w9qAktMb1U+4=;
 b=uXTT6ZKQX8K2aQONDtLPQYHSY55lELQ5K/c4AmqPbmIFIiwqNaetMQJPWpcsXFWl2es3
 QD/4LDFa/zlz/xxJ+gRN9XqNXaWphHbYPrK8JHThYXCtn/ZLIcSNPj8blNge5XyRq5/9
 ak6V/pvjBGKrAJCLGIq22GZ6epyw/tvh4cQ1997jopfGeKnzGkbyDJq/jMtzH975RsDX
 ZT2qx/LXBdtUXcLNN3wnwDGcaUNUjec2qLvv9g/KuNkWsdFxlqTwzEqXdf/RLBS5Re13
 aqXBsLe2NWZNL/CbCseSV1kmZox434/ND4mrYd+N5JSy3srMA9gwxtgJ4yAVdICIhx6I lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQE2028988;
        Mon, 4 Apr 2022 14:35:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXhGS6aCkYkDl0emqUxCtsBovkZyk5aukq6eIRk4gG2ZAHz1dSKSMhyp/b66ZhM2VtREYSt1+GdaHDMDfvc0f1Ukz+UQSLY/6rhR8paYKWI3FTJvJMagdUstquROBHTj/IUiH6KwWw/oChC4HU6Rw+zKL1/RxMqrZY1CAoXaOtsyfYOWN2UScbG7JzMC0g1RlS4OQCXesedilExe5htm4s6AP6WWADCnn4KOpzTLyktIurW9J/IRqiOkDTKeUibhWm2ojn5n61+R9wfDe11kFPkkgjyGZ/L482cXcL0pUjEHvv0yjZ2GqpTBZs/HvuoMkyzIFojIUZzFwrr7x32MBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kf8469ZbINCOd/C9duwq2qK4gaY8qg0w9qAktMb1U+4=;
 b=dSvRVjFoA4YDGQMM5NZsb13zFRz7dCDPpAfBbA3KZjd9WdHHqWKVMnBhXS7tQAAQO14tyvkXwDAEWeF288+5rzvyaOVUdaNqZY73g/kdNCZLb2bGtQKj3bhPM1QfWQ9pmtkPCaDixQKoHSek6mqyA2Hcvy09Y5u8e0e8tlB08F+kKj4qq0w8ylP1m6NdnjB4+aHDjydEjDJomPIHGFDGQ8gbTopPE7rs3a/7DCsDtJsRYPRP1pC+SsJQBIlIBQTNTFWvxJomGXxDnHuUmtROiJ0cFYlA6+CHTjM48GggkRtSLbB5IM2eznYvXjKAIDFNcG9CtPDcVIK5P/giyWVWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf8469ZbINCOd/C9duwq2qK4gaY8qg0w9qAktMb1U+4=;
 b=BoDjOhgUhSr//pbe2Mwi+hzRofht2zBNqCqewHd2ftZDE/Lm6kt0Y348u38iIjUlHZAP6IfA4LUXcYnqkmfHAwmFZnny4C/MTMyzJ6iqHtsIMUh3h5a4mH2zOneAjqOBPPuYdSPQPlLibIHZqf+s/Qr4Ep664xJbcd+YxCYaF5I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 22/70] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v7 22/70] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYSDFCTdKs0SVM4k+ld8z/HsPnbg==
Date:   Mon, 4 Apr 2022 14:35:41 +0000
Message-ID: <20220404143501.2016403-23-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f387af16-42b2-4eba-4fb2-08da16486709
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812ACA506CE987E1EF0D9A9FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAeIZjQMYFN0IjVRBe/RU0swf/YIGpjZsQjw9hFwQxmAGDwydY1qhxzrESLmYw6txKQ5SwjxzuZfgr/O3gKMqdwso+urWMV9LLSp343bAE4+iPh8JFrq7cuK6Yutw9Q1PLdzBYFrIgkwRJVmttZu5AN301UntomlxHELduPnVilOgt8pSlkmSFWDQXqNtcf+8GpR5viQJNocA/rpkwOPhl/8qn+zfeDsV8/hYoB5H7zYsbyHzsMMmtv9FfGatpZqzq+xBi67dxGVv4WKrE5Y/Hl7CQGfS9LFamJWErfF4kxP60Mgedkh6JF0MMyhYdm9EaQqX/ShSrBDyuoPoLmMZLRQGrH9VE8Xz6d7WV8d7RcW//b61JY3nKXvJsZNVinjiXfdqCviezia1D1IJHeZVKzX+qUakPQkZyJlK4X/lF/se6UGVWuvUwDgEkXL+ob6U/p3T2O1ZnCblN4jfVJ99rGoM02H5ga/Fs5KhSfIRS+1SWR4xTGiTp4xKBVXSSLChUk+pOfxCe2sJwKVBgdtVYriDHUYmxnQrRVCbwFAoAXLzB8PNEBBnVUN4HBU1kl1YPR+VUfxw0AfCTs3nIIrCvx16D5vuuYDqR6InNdSHDs/m6V1vGMk80GILkwiemebBx6sFO+3DIJ7gA+cKdwUD3HBYlcxJF9WQARMd1I8D2as/4lVj6qelAQIyxDwqPpavHl54qxukPqZY4XtGSr0UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(4744005)(6486002)(8936002)(1076003)(44832011)(83380400001)(6666004)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rpPQCk1h3oTbJQU2zOFo5PU0ixk058fobEMgY+czgx8bem8Xt6fPWnoKF8?=
 =?iso-8859-1?Q?8/d41xJbViDKhiQwcPxJk6kqnFR2Jw2MT8S+DN1mGozr8B8sy3RPazX8hk?=
 =?iso-8859-1?Q?+2Yjo7HZqK7E33I/3beAktRZKq49mwDs8BSqPL37eXXEZhoVrM5WwXIFzZ?=
 =?iso-8859-1?Q?tMZtN9yg4JCTq60KCs/lQgLykQiFIF/0HaUfKrm01OxW27sKuXW48ZPAfV?=
 =?iso-8859-1?Q?bEVLbXhinpyAj80HKV6yE3AlqgIQz+CNp8rODWzONX0AYsEXEddKMcwmHS?=
 =?iso-8859-1?Q?D42paY8oWU20eILjX9c8FFYen7qwTqaMacRxOGulqdewNee7nNfANhK05f?=
 =?iso-8859-1?Q?1fCFT93kgT9cOERiubwPUMtHbz66kNQbPmdy00Gem5ezVXzeyZChXp5rno?=
 =?iso-8859-1?Q?147EVqTuRuny7zA0GhqAGVtVzJ2kp2F2KY2qnc+Oe4Mzcq8d1qtSY33T7M?=
 =?iso-8859-1?Q?i3jTemnq7d4gGmLO5vgqaYHcH+j14rbfQ4vg0/nZYJmTDaJ9Vqcx7j4uNY?=
 =?iso-8859-1?Q?K0JFbdTZ6t9nmo5b2r0enW2+HzXKQlaqUprIkaLVXpewvi76eQ3ccrZrB0?=
 =?iso-8859-1?Q?UN9cs5wMNQ5+00DiLZo3fOOUDdXqnOx5G23v9vpAqxTM5xV9AfC06mys+i?=
 =?iso-8859-1?Q?RARGbZsr4HUB7pVGDjhgVxufjsJacDrG+aR8f0c3nkVi3UmkezDijB8hdS?=
 =?iso-8859-1?Q?cWaD+NqA+stAThcNnV2jV8YgrtY4J2ar2tivjNI5vQCGnF2Bwf0j+Esrwe?=
 =?iso-8859-1?Q?WspmSgP58UK9Ri+jOM/C8rR8FhAf80uUYwnkUkrpx8Ky1ErvFTwT4aCwi6?=
 =?iso-8859-1?Q?uRlg6BYydTV84Sw9MVXW3ttJeQ0wTEc0T0WJsEdp2dsLKSySVdUvkn9+bI?=
 =?iso-8859-1?Q?ngruRHfcXMIGmxclBsNfFb6OpIzStJo8afBmjQXOsY5NZDfbwAPxCBiF8G?=
 =?iso-8859-1?Q?JzQVT0J7JuiHkVfwcbPP/tdVdm2Am+mtSlK2f0iJ13bg3uLoHLGzeKfL7F?=
 =?iso-8859-1?Q?dQASabVm1gpxtD8ocRLTRS4hnThdgJNyFJnCSikksOiZAENclOGQaFOr0r?=
 =?iso-8859-1?Q?s8S/qQUCYCEINWjDrvL8X5gLxWIaeGbdW7TiwywKTxWbbagxlKiMbFqqZm?=
 =?iso-8859-1?Q?HLjXm2wJxsGtsLw/T0HUcF22OPhWw1+zblyHysgvKgA8P5ODqA9uxoCGmN?=
 =?iso-8859-1?Q?EV/YhP1deo4+3GHhT26Ng9LVMe5G/JiRWax6btQwczFYQRDkQoC4U/zSEO?=
 =?iso-8859-1?Q?yrlCVn/HZ9ht+6ag9YzYE6NdBHu3MEAGTG0BIGblVhqMdtG0TRvrSsRJ6r?=
 =?iso-8859-1?Q?QjJy1aLKH+9sS+QgtNiZAvxAsn0zBgoGm02bNQ3gxDClKmOqvF4ysJpYFk?=
 =?iso-8859-1?Q?H7fPTiwZHeiJsCdmK8tIWbd9OBb74zC9RPZvfHTMaKm/d3KEbotWkR3oUc?=
 =?iso-8859-1?Q?Aboe2Nol1GW4K4SrD06hDqyOF4PGkpbSvA+KeqqEJHXw6logZed+FBGKsW?=
 =?iso-8859-1?Q?4uRczqtUsJoZAR0eKvvxZbNKIxLAbj/DxsblqL4qA+uIpqAkUuj7/iaVfw?=
 =?iso-8859-1?Q?f+wXOp7PTFZ9LoWU3WySUSddqKKrCD0SDqJCqI/oFBk0lnINlE+yD88JJ9?=
 =?iso-8859-1?Q?FtSPpjZiPntGB1Imk5oOWgKT3U+K7iCYOpUPk6FhKpRd9FJq0BxfkE3Yh0?=
 =?iso-8859-1?Q?0XpkSPN7hbScdi2Sj4DUPBniWWu82pIl7OybLI12rZKnMzd9xE+24qx8nR?=
 =?iso-8859-1?Q?I+lB3bK4gmofymao61gKP7+245kJPkPunqFLEDTD9SdHQcqkJ3FQDDJSHI?=
 =?iso-8859-1?Q?YRGd76RzyfzgkUnGyeejlFEJWOdGprM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f387af16-42b2-4eba-4fb2-08da16486709
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:41.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7PW1+y2QOBvkTj7+XQMeJJ+0vFNsR22B+W/AmTQBP35yyBh2x1wJRoN0CHW56nhdUs8saSKy87Dl4DRWnX5fqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=632
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: CUXcPQjUtnA6vqDRhQcQDCczdVTv3ew2
X-Proofpoint-ORIG-GUID: CUXcPQjUtnA6vqDRhQcQDCczdVTv3ew2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ae83d2440bef..65aace45e770 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2855,7 +2855,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.34.1
