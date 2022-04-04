Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC974F175F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378226AbiDDOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378061AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D603FD97
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DlFTM024455;
        Mon, 4 Apr 2022 14:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=KilEw5Md/nyyIMGJ4W124Qy8/yQ2ObLbHRJb+FkZrVVXLwA/pK8odaJs12F98MKR+Cuq
 0ojvbxru3egaL275QC6N9Y4HrimSYR/mO+Bu2CmsuE1Nh9sjrQiwGggR/Q9x96P6DRsY
 dHtMGpOxqa2r50oQRmwE3kgWYEnxZoxLetBZRdxtec+yE2ee0iAcJNLeIttH11MFDa63
 OB6BeVK5FdZ46LuW4PooMT2oxQ3W2Ocxd/whmfsTmhhIkqP67yRkgjAVZbEdILHKky2J
 TMdVyVl2CZcCraNp/cLXBLwSO/kTO6/l3iDPMvlpTWbgqGTLTe9EAi8sEN3NV5dFaj6I Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceX027671;
        Mon, 4 Apr 2022 14:36:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJTDKnfJ7IFpkFBDJ/Gzmg7Q8joyL6O4i75YpWH2Z6Sqww38lNc0iy8c+/Pm3W0TQDks8SW7YdJDwR+siu0WBXJXRIY+e1P3zdG5au3AbNCzUq9YqZQWDFWkoMxpOfimj56ZXgBAHq1+9mQ83l5IRKxJB8dCyDUQNiVaueHY6d6gbvEf39KJlt9JrHc0osyg/NFNZrvrM5/rrxvkCh11WBR1w2qmT4V4YQveeTKEowOvhNcg6GJt/BtSaJcXqyz5lyTvmzCnKEe+XLRUqWxTxtVYOQxBbR+OrpSDL60/gdGcaGqb+oE+n7yW4UHESLwvl19YJVr88eEVSbWf8INfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=O/FEkBwOcqaSLeSCmHbMGl5EoY5pK5u79qWFgJmi2TLPXrlhLmzaLxgQSHU5FN8PckbHBhN3gKFPvxpmZvjpMyb9cMTHsV1kXE1tdn9EK8hkKdpQyrtkwXAsu/1H93LCLrJtywAUSpxCQahZHGdLtIfZ2XcKv7TvJtxPkTCy05Uox69k4UKmTTr0zXhsxxn0hLiN5PHmpMxIXuMgDlUeRcyWsIlGaxljx6Dt+hOFgGaECz4katQLoC61vIV1ZYGT19SMCzAFQ0xqTpUIPj0cr1UWp+s1he0oivzSD40MrDUlHLFNWwCEd9tZAg+dFVAizjFQzn9AUGB1uDVqD78iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udl56DNLtyTHz/srt+tyNwBTfvWFDlIXimZgRN2PeM4=;
 b=uKCWSAzfKPZUz3ok0M9yucaDHEtob1JJuAhQLSagRsPOtwUjf8/xl9S8HpXMcu3MSwL8awhS24qSMJCc5ctfESWpVqzjs/zWAqov3QN4UeGJjm0fpamG/1kSRlVrcVkmTKLGgqOOl2NnQAHbgaFRrYI7o67RUF+eOMTQIj6bRRo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 46/70] ipc/shm: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v7 46/70] ipc/shm: Use VMA iterator instead of linked
 list
Thread-Index: AQHYSDFID5Y0Mb9m3Eud8kOf1yoQwg==
Date:   Mon, 4 Apr 2022 14:35:51 +0000
Message-ID: <20220404143501.2016403-47-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352d23b9-63eb-40e6-d2d4-08da16487faf
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329E1EFB59EE1DD2CD8FBC3FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YD459PxsT6+3cNSQ7YAh8ibU8wKib9Ou8sFlOyKvFvHa6uWkkeefiLSzAeS0xdJ33eIBj0FWAU82cPwMP1mBeH3kbSt4hANq8pXoDsUjdfrYOkeERiNDymPM3cWQ3tLYohjv9o3rDk6cs91r3uJ1KsAmWKWiqmLINwcsyYSemRWGvTrDKtpvvFMC//8rEJFuG9qTuvqcEGatVqVn52lG+FggMQ0899rm+9LIhsGoUSKmiowSlqMZLO5ZTcIBzbtllzFYbwrCBr7MFZ/zLHQV6I09K+BZ1K3a4tFlqLvLdlI6wvnwOy3gdihy11j18FLNvTt7gLT4FCUwPL3dQO1zAeH5Ntg6SthltUsnvLL6bKQ8bJI2fm/s5CV+rl+7laGn441d2ev7DcH8eT/NeE+gzVk2Zb20dVWC/g/XO7O/kR0Nb+nlXf7TWANHcWW/EoBba79hNc+Som5YpehZrsW4U3ZAt7SImRfY6vqPmrwQoLPpLUU+MMJNzIXTjcR6wEnV2bwApn8aNFXGZyCEos0pSoQ/0Vg2OIQCCsn4M0m4U4yIZA1itsdxI2ui0Ouibs21kiWWdtcR+LGFCniPEGJzgun2HEDV0aNgqR98a8oiiNi0y7xZ7vp9zCc9skpQCYu+0nh0jFoAUivWVFA5Es+/2mEdipeQbC4juE1PfUtz6qs5jfBC/kTr8Ar3c/6RmvOin123MqYRZCftHxyY1KRApg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H9LU2q9B+uIdLQpTFyLWvO7aIR8+r6g6UMLpDg0F1EowtKgSKOQJxE2uvW?=
 =?iso-8859-1?Q?XjiMF6q7/9DKx8ycIfzR8ITYedFVk4skZ09p8CriKspcQJ9gWDxJOfxQVy?=
 =?iso-8859-1?Q?Uju02rp1waitlOGvlxoo18nMuh5uK5dW8mnmn+5w7Aj8w+rikSLaPZyh/p?=
 =?iso-8859-1?Q?3hL++XLO5P9058fIHYjRBQnem9PJepPwfPxxJYMcz5pdeQ380fEvspHa2M?=
 =?iso-8859-1?Q?8u12+EegU0uuzKlP3hgNfY/X1xtM9PNv4VNQHUNULFKfI6QnCzHlvSZywN?=
 =?iso-8859-1?Q?EMDbQc5Z4YJG0EGZES+YJ8XGj/4NgZOBg6zMK2hJk5Ic3jEFF7kz4vrTtl?=
 =?iso-8859-1?Q?kvhnHMcbHOLQylugnNFN4dvMATHKDuF5TbuX02vZ9AsuBGqOee2HcpzsyS?=
 =?iso-8859-1?Q?notRrEK4nm/ch3MCvFm0nmVNY03wx9BmJ3UE/EQO7wXrE7lGKXYEGxzsQK?=
 =?iso-8859-1?Q?qjetDTE6FO2VFAnW5IBZ7yCeVy+QcvD+gD/MHUfG1G0s3yNvVfTtKiyyO8?=
 =?iso-8859-1?Q?X6sJzM2s4IhGUdTM9U1x0zxdjGmtsBGxKwwO22X+kPBsPVli1CRqPKzoFH?=
 =?iso-8859-1?Q?39DXQejyxP53LEqZWoxaCz+SCJyG7HpibPmonHo5jWXR4WLpP8zIjI9q6y?=
 =?iso-8859-1?Q?vZW7gNxpx9VkjDDhadpvLQF/EHIjyzdnx+qd2VvD/Uiv+yq2wgGw3HNVY2?=
 =?iso-8859-1?Q?AKxcy3Nx53UQEEoJ4FHnAYjMMti340z/cAGlUhy25u6RYStT0LhOO/mD74?=
 =?iso-8859-1?Q?m/lngsdXEXPDXnJQFaguomMeZCBZS9r+aYYlAs/s462KbBsN31v3cpP37U?=
 =?iso-8859-1?Q?NuyVEKFbiJJTqkaIHYQzrG3R7OiVXnehnmVWpoIcUMBzdh7e00nxJ90ZGq?=
 =?iso-8859-1?Q?S+gl8353I4G/+9zebuTkkLiwgoYNPK9SMQAUcwqWoQvuKKS1VhNo4oPjtQ?=
 =?iso-8859-1?Q?aBsWABKMbJGCPly82g4kc+WU2qv2y2AakUUG8vjDuvta2NS8MXSkO861QB?=
 =?iso-8859-1?Q?RryajqGqbhd61ZMlmOS3nER8RfAPLYtu2SYX8pj5Lm81/iNac1FwlyZNzS?=
 =?iso-8859-1?Q?ugynfzKfCgnX/sa6+n/lXcU3C+lSjzFXCrxpU9x1K+0GVV86fuoHSdTbfR?=
 =?iso-8859-1?Q?0VGtcDKhSMvzZqNPPRIaGSDAktMnGC+IAB2hle4ofNaNuoAydOJrGw6xvI?=
 =?iso-8859-1?Q?V/nGK3uJBmqglWvtv6pYNiHtx729AK3au1n+DCVvfZ4sJzqGORQ1QKRCeN?=
 =?iso-8859-1?Q?ckMygRlYNNCt2rSKHzI2cpk6h8qSlys6pKcr/9bmu55RWaSxYpdzXHi4zm?=
 =?iso-8859-1?Q?kheU9R6rxS9l+8DbwABCHKpDxUkXaik9jogaQk6yRGHQysxzDRgDrYKvd8?=
 =?iso-8859-1?Q?NOL7cPYKv3DDjlE96gjg2ZzWwrF+hzvR5WzXCvyTYa8KiGzg0Rjwotuqwa?=
 =?iso-8859-1?Q?5bOw3ZtZNbiq56pKhZhq9q0H96F+SS9DylU27bfip3eGMGewzFduFSiaiR?=
 =?iso-8859-1?Q?7rzOKxumAr54jEHJcA8RPyRof3GOEHVsCo2zuxsAQTrcz6isg/lBY8+Z5p?=
 =?iso-8859-1?Q?tkUHC9o3ChGNdc9kTe7yHoZLbphdUiQAbNIfA/nr57wwtfbrHMtDRD0fdh?=
 =?iso-8859-1?Q?82XWkiITPxHiPJMYIaOSjQ5zvqSB5yXgFUo6fHQyYUYrgG0hiCs57wRaAR?=
 =?iso-8859-1?Q?ONNDl2Nf9md8QVl3ZJOr+/29Jco85QtaTAeev6b1f4yO/YEc14nFypcQ6m?=
 =?iso-8859-1?Q?0BTgtQ/8Hz3dapFWHAAIb5VUjwguqLH/UN7zDr5XmtPh2GKIi0xKlR79P1?=
 =?iso-8859-1?Q?p8rHPWf0POIDo5W9IooK7DmhAIsBVFs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352d23b9-63eb-40e6-d2d4-08da16487faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:51.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ghto4EY2g3iuv6D+Ew1K4PUH/rv1n6tsELlYzTs5S6/oaekNr3cmPR7+luLEhJeqsGINIiMdLnWVKOtAKtku9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: KYHYUiGAbFQ9K4w8_KegJhe8aWk9PeVA
X-Proofpoint-GUID: KYHYUiGAbFQ9K4w8_KegJhe8aWk9PeVA
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

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.34.1
