Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816A4F1745
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbiDDOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378012AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC063FBCA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3Nu014690;
        Mon, 4 Apr 2022 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fwtK36HHOW/mb4BC8hZdyq6LXeflaO4unzvj1WxPdNk=;
 b=m5gyjHUQn+zB3c39QwrcR1dxGTqzwr+PhLZCE56VMkzmXsJUSA8tfgpZyaAvhE24YFt9
 EaqRYxfEf1pLCb3oyU7NiAbYHNX77CtQjVL7l68/Ny/nbW3qFz2Cryb81tm8vEnL79p5
 lWd4fzDRpNUv40t1q1cbZG70oHWKwdsnSTkP9Avi67JkG4AIlx4r0N89bd1GWFlR6EKD
 X2gc5cVC3N/NfPjfOcKhqj/SBpRnnQnR3DmK0tL7YgIpwz9T1TcibVJ3PcE/akyWvmDA
 9lesHln41IuQ11wwXDZp/gGYmJ2hpFccdGBor10xA45s2b5/go3+0f0TxTy4p580+xTG kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceV027671;
        Mon, 4 Apr 2022 14:36:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c97BLIBiaxAhvA4ZJUOG78UTCYSYxDANBXwujCmr07FCwPaTWb5UmVjpAWI8Q5tpc3q/kahwaJK4y7wiJAvhH22Yv/lWo1cY3Eeq4py2KbZ5ZTi04+fUC2mhARGVggUfXQV3QBXSJu8gmW749kZUF50ztL6gB9/9tR8HrFoSnvdrCa+6heNIYLZifpubyHIWcRrvo24fKqsvW/7P0WB85jowcdprSQuSnEWKODAdi6Brw96oI6qrNsI09HnVX6UgRCDYxiQq9xZTzPpXSO9Clz3bHKTAROqYrtqtxDNGah3hMpXJTN3gvMeNlXIO/qS9Rusbse1GvftEnGNiDv+Stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwtK36HHOW/mb4BC8hZdyq6LXeflaO4unzvj1WxPdNk=;
 b=W5FIchk29TLU+hseSKO72onrkSHdpNXH9nMWiIgog79Z39SK8YW8J9BxvBI+tFcdoYlAUNZbkylzfgvY+mQjS8kiqS30zNKe4rFglA9+bGKwg3q+LRBkz1cKs50HyCcqRxYGNLqHKuAyoFcjJQKbNt8VWPV1acD8+nSaV7wdFIZRc+OcSLghuph9ttgDcXvCv4bW3C79bMogUeNQvSm9gFMAXBEWGg2MO9oO7DlsLSQVq7xylQy0nYx+JfGYaj6YoEmr/Vgkg48REFoCYs8D64IE/THd1tRP8VyB9M93oseWS3iQcEcucoDTGvmyfTRG4TyK6FPAGKBKJXB/vNA0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwtK36HHOW/mb4BC8hZdyq6LXeflaO4unzvj1WxPdNk=;
 b=ykngaYQ0XiVLd3ou7HjJoWa/GhhvM+IBmZmjNpqUTIHrJnBfyVnjiY3asRi6ENvR0RO0AUCjkrBZn7KikXv+tx1EVCumglYNhTk1yv/iEe/Dd1ur4d0zuuP0hRZ9DCIBmUIxFiFrEaWh7BzaWAaTAvFWteDeZ4Tuom2mmZladJk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 44/70] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v7 44/70] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHYSDFHmD1A+PMbb0OWNgIVw6Bbcg==
Date:   Mon, 4 Apr 2022 14:35:50 +0000
Message-ID: <20220404143501.2016403-45-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12502046-e37b-452e-1617-08da16487f2f
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB532923E081DD77124A19C180FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vOSulINiqKOPwVrJjQYdYEgekA95oOnndt+aH0QxqXV66YsMJQ0S1y340RjMnbe6Ktvcoa2B/WMW/dqhWaUfZxS6BVj2bs6Yyv1+3EclbsK+u4kbZsVVqJGfs54MZcGrPlC1XEI7Hr6aEK32i61Cw1XUXVhoCGibCIGqY3x9YSnpWNIdBquuwPMQQ8YxhYoBW3xvcLxtyr11vj2Ik1LaehAF8cz4s4gKkcSI51DziSy4HCOkvKHYCYG4vcxEp1W3enWKegjX3OP2iEc6sSOXM9WFEtggK3GwcNvl7vidtHAlFya1c+dMPHh65i7a998ZRFkxhvWI9faHyw4Pla6806KI09Iz75Gk7e4I78AxYF85tpD4PzxrBcRPM+Gn6KWSMBSf6NFVjkFzEJro9nnFes9sD89bUm3e2YR274ZWOmQlR54nFu9LYdhZmlnQf4ekL1g8tQoR6ZGPEtwE42ReJ0bH2ER5H461oDtWLG+f+Hif/o7RVwqzdL6UWaX0x7MFIBnKH8Jlj6cS3taj77twkUH29IFleXnt+5QMljbdF5Do0W2S0IzlLXqw3M+KmBS4uH6iSjbQZp/6AOwG3ul/BVlKfN5YBvIaive4puc9eKGqfSHHwHCJEzgkGvSsQ32U1mfrCVUbwuc3qZ5n7clZIeb5MaQfRpm/lCGHJ3fRS2KI0a/WXlpFyzEsSYicv75ZXv0hCtxEvc1hBgAnLliukw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cQJX3XDMeWFmPZlg6SEIfWUjkanMy6cntCh7ipL90cetAGeQpxa8HEYpBT?=
 =?iso-8859-1?Q?HWijlUIKv2Hx7+mg3A0ZruiKxWBygWE0m+bvHB6zz7qoDCInA1x/rYmgQT?=
 =?iso-8859-1?Q?bF02CktSzR5M0HOH46A5zVZT0fSjPU0P7f5R2tVR4IskQ9fZG2JR8bIUtW?=
 =?iso-8859-1?Q?9lii2/3dMGHrOkZJvZvofn9JnmXHpUTB/R2kSQrSVF6vQdokWpsXM1zUZF?=
 =?iso-8859-1?Q?Se2xOomd9wDgmPayTum79QNFVa84oxL5HfMIT3/nxHSqZCHJ9NOBqVsxMJ?=
 =?iso-8859-1?Q?gJ22uUnU466ywUH1jPQfmZ6aEFk116UFGk2jThrfrMN1s/viUskz88lltE?=
 =?iso-8859-1?Q?uT7QoIzxb2yaj3vjxBcyimBy3ejl+PlXtu3GZ2Bmu1qB25sOHHwxb1dx8d?=
 =?iso-8859-1?Q?PwAXjTxuFQUYLyEzxJxHemJKJPYixQGGbMOSWQ67vDMVLII3seeLslmYzC?=
 =?iso-8859-1?Q?9sZpp7Ca5w2XwZmBuz4anv78Wnio/fzgXtzeFRlrO+87qYpFZs/aXxB4U9?=
 =?iso-8859-1?Q?R3f89iVL8kKb2z/62rM5v7nEwJLZ9fvLo9h6lakLvqsfC7hssjRpqZEDte?=
 =?iso-8859-1?Q?jTVLEg2kBl7MXy2LUyA40A1RYncjsiAj+oSet6O4j+ou+kA1IuAvVWBEKI?=
 =?iso-8859-1?Q?LurygxYx3aZN/oqOHLZDukWsXpJEGbNJVIZjOdAVKUv99z++7q5RiD+DoE?=
 =?iso-8859-1?Q?egsrLg/gAv9YTaL7ekm8Wi0jWY/W9iN3elLTvq/Ryd8rmfYjuZd6MICett?=
 =?iso-8859-1?Q?3ehwXpfGAYZCqSPkkkegjAF2Nb9ieBm5PxABhLW/ST3RgkFeSZHnQKRYYa?=
 =?iso-8859-1?Q?3xVQSPbzxc3yw4IKJV8CUS9CMY89VDFVlMJEI520aeHoF8nVfd+XtIelcD?=
 =?iso-8859-1?Q?NTz/R1WmhevFF2JAk3LvSWdne3NRNeOXuvCmOQQIXTiUILI3Jq7FZI9tSh?=
 =?iso-8859-1?Q?EFNvd2Yub7675Gryq9c3ScRiO3rthZhSd3P+r+IFagOa/AwW6omL+Bj2dt?=
 =?iso-8859-1?Q?Z/1ID0FFrWTXIYdsfOAstDTv9PTDD/neEldtJVWPZLW2wlFSLQFPJ+3LTh?=
 =?iso-8859-1?Q?bxVk4pst0vUIVdmtjZXc2TKTosloMRZhN81elL4h6zOtOp1BQS93thOau3?=
 =?iso-8859-1?Q?Bf1prkN66s4TyxYxb2d1Thc67Ili1cLQ9QDg8usKI0DcMIxk3kuEy5PYbs?=
 =?iso-8859-1?Q?REtINs5yg31IgaT8aEd/4kb524FtbOjad38+LxS7NEjlIvuiEkijuevEiK?=
 =?iso-8859-1?Q?Qfu7ryG1Cv7/JWCcWwbEHLT66MHdBDnIo4Ihaj5ocTVXFtBnKEaN7I+AQf?=
 =?iso-8859-1?Q?bdHD/MrJIJibnYs6RSAMH5OphiBcsSug7IzZgM2BFRx8cttQkODSGjou2b?=
 =?iso-8859-1?Q?lBr6OyyGHI//63vOgTHH36xqiHt6KxcsCabTPMs1unCZR2DjrGoey1tQPd?=
 =?iso-8859-1?Q?lUGVM3q0JmhhpXrkxmq47M2nk+Tu12A0nB9TO+8jlCh5ZyPkoiF8y0oOly?=
 =?iso-8859-1?Q?36cm/wnweodHb+yPH688NZdVksjqqvPsiNCuxqRonIwA5yBcw0jcrK+WNi?=
 =?iso-8859-1?Q?1ik6YkR2q/4tMXOXIGLRTK25kfao69JoC3+GdBn9MoP2XXp1m2ThDqOaE7?=
 =?iso-8859-1?Q?45tsQpF20WXlpGMsGRp+gG02/nAQw1GaaMDMdfozI1lFoWMN3EwO/bFvBl?=
 =?iso-8859-1?Q?UedfWKj80Y2e3AclngE5lNg8nvGXxLgg4yVNE3LpDZ3YrzIfv+o4im5s/N?=
 =?iso-8859-1?Q?88pJhkaJFlK8Be0obEtMX2U9yTTJKntPeYc1H+slQynQxcHPS6UG0C/abV?=
 =?iso-8859-1?Q?AsgibnL+Bx3q1Pb84sp4cM6RjA+r80k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12502046-e37b-452e-1617-08da16487f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:50.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGmdfefnYjiCzDk0vZBfOlbVsrfUjHrcNz+f5FKKlLA3eoLJEYOZ7xpUHObrPq7FilDrj4WWneqBDjMbp8AO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: lmnGdZdJ-5Dhx5i_T2EqhDkTqWbzAa9D
X-Proofpoint-ORIG-GUID: lmnGdZdJ-5Dhx5i_T2EqhDkTqWbzAa9D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f025c8496cb7..7a14939c6c62 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -872,16 +876,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -894,8 +898,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -904,6 +913,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -947,7 +957,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -961,11 +971,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1258,6 +1267,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1277,7 +1287,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1289,8 +1299,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.34.1
