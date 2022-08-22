Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4359C239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbiHVPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiHVPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:04:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589833AE7E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:04:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEircL017906;
        Mon, 22 Aug 2022 15:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=2ShR/DE52OVTDCHEJkI92aEFWETiWDV5pBW1H8kQXbGyNWgoAX1fBSlSEfzJoo14Qodk
 YlZTL7ps05iICjk/cjPPh5aArJXuBUAJd1M3d4xLNLraMzYjoKspj0Ro+W5NRaqspn/R
 U1WYF6kFBSN8LN/rIxpcbQ2pyCCnh//g1z9VUIvpwakBZic90G1JXKkZp4vodXcUNRsn
 eZWkgY/5TykHDnOPF33pDhKGGHUA1/c2mQy0x6Cu6cTNmdKNRiEIP7c2CIPbE3EYUuPL
 CXlzdiyUy7u7vIeK0h4hGRKJCv4EAjzd5mYn/UoO55d162Jemeea+WVSBQGLXWiKN0EL PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt03y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NEV035372;
        Mon, 22 Aug 2022 15:04:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tx2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzJOWmZx+dIyqgfk+FZ8c4jsngO475Fn3XWSEZ3Sqjr+syFKFXWijHbBjBeGa/ss/d0uJDpXo3e4jb41Yr04kKWcjx7l9BNwATheDYbDlmcXMh1tFRklSUMfHkef4ptpaj3SpPvm5DaIrg7H0sjHtHEry/6RucXgfXIDHHBgznYxYrPqYe9fY7oJqn/uONKVB1J8Bcfy3pItvEpzeonISmdmCw7PfdtWna9IxqldP9yhRPCgoJywSo8Xw63edWcJiFSf3WzHvI2HJkWZrx7zJxgZipcZZ7wi6qToHjcOThYC79f4kqku0W/5vUc8B0MaU61T8usXy6xJlodBNVXNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=jjWCGFGb0K8b086CTWMVRuMArFnh9/SA0+eEaZhxmwf44GhC4tteQxtU/VTKy6MvtRQw7nDV0fYIBG2lif2NcWPs+U7G93VXICj2l4mc5V1XYJJF8MVyDQNdT1ey9gYomkbEys4VlRYsAKpTj5icoJFDA50lP0OL4jw5c1YRbBruD/rRWXv1d46z9LknHc2/2mJ+lcmlbMc4smaOIsFd3Ba31HV8lecxVNK9Lhri47chYPGY8C78Qpk83Gfnu+Qwy8SE3B0zvY64UhQarZp0a+tZTqLci7WqzXLbCmGkY8fm1pb8ilnvgKXwGCuf004/oOUF2U0L6ujSEx8txskVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=vlb1GyXpMo8yUviLwvXw4+80GQ6l4J9/W2PDmDRKaOabXbf7WMcPW4D3ymRb7ewfeHI56/f14NabPE1AgA8/Z+PkXA7gL3JsgCLDe2cpP/AfkjQIwDI+cQbfnuF9CcYEc2W5AMwDGht2agnpwbZNeSX7vUVMQrAOP3sXvv4Tu60=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:04:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:04:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 21/70] mm/khugepaged: optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Topic: [PATCH v13 21/70] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYtjh+hIkhdgumBUmFdkV9On2Nag==
Date:   Mon, 22 Aug 2022 15:04:35 +0000
Message-ID: <20220822150128.1562046-22-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e9d01c2-759a-4db0-0dd1-08da844fa0b9
x-ms-traffictypediagnostic: DM4PR10MB6063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JsQOU3gZOv1+NqtGiRz4zc7gnMC51iTo7STm4U2/c9rWqAxtYg8ghalVn1WQOwQKoHaTlwykimCGG+gxAB5D01lORWluaymk5GpSBamZbWPCm1ZfQ1XB1reP4DqC5s+PbsiMc9e58lW59vdYslGAVZWeOO2r2QjwSXcUaCyD2xXmFQLyttBcG9TEskjTc77pNG/CtDoAOq6zjjdkIVSRqSPJYazcb1eDiEcHXRljHvrZKCztVxGfq2wZ5oci/PZq1ECEg76SODSc9eXER4Po+gNvJIWHzxZH1rgC64IP/gvLqFre5gbh+4JhETs6bKMAlWE19foDg9quxX5dEMwp59aaPA7yuVOjOCp0LkNbru/mHMnMzALrreK1vJwWzeuXMHMLiWhIuJYi32+nq6EZn9c2y37yvZzK9GmWm4LXFxrKxlVoAAMUMqXiTRocnDPX5Hh4gOCAOCO0HSirRI0qtbLIAJraPG2H07764u+ErK1fbWBr4++VgO2us1tpktAVzwjLOODElu6SeV0mFzeyf/KiLxSDH5tPE8mV/Kr2WVhQeyMJtPfcge68swAX8aEvBUEyJvd6R3dmjiGrxNVZy0dh2Sa4GSvzMFN2Eqw3C2uYQX2G/BtPtcWytr4KZTlytxwFRfl4DiDBc/LjnP4BraHNCq3y+s8OXO8UaIHasO5c8pk3uiELpjM6tvt11amrz3pgn7KKTPKjYrD4yHjTmSqWlRerbAAWFmqtNcMOmaGQY/ukRXORwhFJOGZ7DNiNtCXRjP0Ql5chmZrz6Ro8Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(86362001)(38070700005)(38100700002)(122000001)(41300700001)(5660300002)(44832011)(4744005)(8936002)(110136005)(54906003)(316002)(6486002)(66946007)(66556008)(8676002)(71200400001)(64756008)(66446008)(66476007)(91956017)(76116006)(36756003)(1076003)(2616005)(186003)(2906002)(83380400001)(6506007)(4326008)(478600001)(26005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VN723eemFiB/8KyHHNLu9B5nxCkGt8p0CN2QnKldO4BNADizcyLky80nzs?=
 =?iso-8859-1?Q?oUP42SX1h7U6JTi+XhQh34TDH1LdG4RaNv6wddqP1gHLky825fFL5BZoWe?=
 =?iso-8859-1?Q?PakH6Gq1aOjtPr3o6DxQjY9ABTb9H1ObItGuJ9iXiEmjl1KYn58/m1jKsv?=
 =?iso-8859-1?Q?U4+Xfwzj8DxUkcqkVHELDdEBkVj3KSJv0eRFba4CXFBvNsdJ8h8goKyJLi?=
 =?iso-8859-1?Q?UpTzveoeBocXbAj0HukbklXYU6e4gTc39Dzbi+qe3QETiVb+AE3EMt0YU+?=
 =?iso-8859-1?Q?dwACljll1ZJmdHz9kxmYcY3Y5ybVDRs0C4l1kSnkFiStyXEQXTGh0OGdkd?=
 =?iso-8859-1?Q?fLgWH/9rVCGaEbloGpP9iLYsRv5v2EnAvvTu96mof4WZozTnflECA9mjHC?=
 =?iso-8859-1?Q?ZMWDcPg7xjNOjxphUATMfWdRnO2jbkNf7gkMevi19yfbmAEoXH6UKppmXo?=
 =?iso-8859-1?Q?NKds+SMKAyGurUQ8Y9Ktw2Fmo0N3N1ioA+dxJeS+NrvPJVLib/IldBx54n?=
 =?iso-8859-1?Q?jN52PUN3y+1uWzfTv4ng4eaoX8FX8ocnep9M669EaJz448J0ixnbtTpMYv?=
 =?iso-8859-1?Q?uDDdfZTmcoTEgCEl2OuF3jvTBSpdJYiO4sCskPcYKDIX0CBQ5CxQvDFwU/?=
 =?iso-8859-1?Q?yTM2XRvaXjPUw2pFdFQVoKx6qzLHSAq8F7q7gYVU7SZv/J4cHRMDn7leQe?=
 =?iso-8859-1?Q?wAJecEYrVwKgihPeQ4gzsU+PxYe7+0UJ66ChpccvyeSFFHDY5rAxtQOCR2?=
 =?iso-8859-1?Q?c+CFiqEteyRGbXZVpDytLUSCRLEwF8sK431DO9taRw59Z0IlaKbUf3cERG?=
 =?iso-8859-1?Q?CnnMUY6n5mdn77AahF8/TdQnHu5KMWevE12a1SF7Clp5fT2/EmibxgLvJi?=
 =?iso-8859-1?Q?ANq1Sz3g37gxQM13f0USu6xZqDgCzSZpTTODcJnqM5NsjRaMJw/q20qOhA?=
 =?iso-8859-1?Q?rODyO7MRm8rBOZ7lpb1IdtjDRCuXB/eDbCsNNDKi5W6EvpUGnSal25t7jR?=
 =?iso-8859-1?Q?Zo+7jREpOLs4eTNpmXfeMtDLEhAQWuNnITW4TsnH76H6SsQxHr8CUzZeqP?=
 =?iso-8859-1?Q?VdYZuGoKhOtzJXqKrPDdgLrB/nfkpzQDiSTOs71ZVGOvzDKRlXtPI9x0f/?=
 =?iso-8859-1?Q?+aSKrh5u3UpL4v2fpU4cimtHtpt+JxDed8E8kWVW3we8g32c623dvSHROB?=
 =?iso-8859-1?Q?7D27SYDECxkxSgMOvn05whzQze07o9rPtZKkNaLdoH26WXO1KTOYFmpK0M?=
 =?iso-8859-1?Q?3nr6xlR+QjdYBznj+kjKkgSMblB6KUsS+enJiuapDUGX4DGaTn4557xRXA?=
 =?iso-8859-1?Q?4ZeyO5dq1VNzE+NoGgGgQna/UufNzDTLjjZ1TQPRLBkLDRQqNLVAXZ/xh0?=
 =?iso-8859-1?Q?uVZhJ7Ypt053hbN/8OMQTVFD/nGIZDErOTEN3qUQCdPHy1nuoQ7bUK8x0r?=
 =?iso-8859-1?Q?VlKMgXX7IOgtbFxzME5FgLDCt04y1WegBjLfmjfllb7G5ht9wImKk0iQzE?=
 =?iso-8859-1?Q?o1+/Ln2gWj41DFsZooDC0w89nKgmTTla6bsHwdqMB7iOO+V3aGYdK20CWx?=
 =?iso-8859-1?Q?f8QxUH4EhQkQqQclEZwpJy/KfG+69GfzPaGOMa+M8DP7ObgWva89wMO3LF?=
 =?iso-8859-1?Q?dq25QPc6lthxMsGQUteDW5aT4WpRe/EHKunFOztOwnf83Sb9Kbm4Z14A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9d01c2-759a-4db0-0dd1-08da844fa0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:04:35.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwIFU6x84kq6SvSzE3FbtPPBzRI7vebR8lEQpWdZfdkCUP4G6vx0BvI9wp7Nx8z5gRuKxAOtlEy5T53ZfwwYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=830 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: iKonGBP1oS-VvWZ4GAm1SMfQhCbFbr5y
X-Proofpoint-GUID: iKonGBP1oS-VvWZ4GAm1SMfQhCbFbr5y
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

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3e64105398c3..d3313b7a8fe5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1392,7 +1392,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
