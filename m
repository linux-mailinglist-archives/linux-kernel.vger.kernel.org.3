Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49646510179
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352050AbiDZPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352119AbiDZPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1B159787
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSwlu003693;
        Tue, 26 Apr 2022 15:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QJNif3VSSYp2DsTQKEGHn4Hh+dbe5JNxgX+/HF04uJI=;
 b=GVMqPTdnCzS7G292XhOXxQFVncH1TzgaJpc1xmIiRF9LW3fd332lAsZFpE3CagUkTyFX
 DMsWDcQfXG8Tb/poFBkYzo35FvKdhSWLZw8ZaDklQXuoK1k8ST6pJQBHSuoey2S5ZpPJ
 WTAl6bGtxIaqmu2tGg4uyL79P8wjVybrLqB/uloL9/UJGF5XD00cA1Kspr4poGM6HrWE
 /X5gJ9l7R2um3x2ONUKOuCRreN8nHnoBTZceJUj5j0d90dM9K+iEhbnsAHypK7Ag8yNO
 7uLHhmoL+bMisrv/49DnqfEEO71m5HcPt9ghto50PyLzevJDHiJRO6Txj9fYEdzjLdmc 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4p72k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Us7037852;
        Tue, 26 Apr 2022 15:07:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkumt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZipgX295OKKhocFrG4MxOD3Hgf6Fpo6sLuAgLaClhIQc220nSiZnr8m8wAniBxgQwownrOaJy3WpLmZF+8Td6SEZNV+AHJShsoSCWFxaSgRpkErzotsXVx8QBiZIeHW3mF1t0FGDS4Sx0+aqgm8iKT2le0pJdbqmBk5MhPNIifNcSIV/qkwsh50DurDdS3myI9S4a2Hl7qd4hv7BwYF7BwPU7sU76v62HRew/LHOBdEBnYeRYSWuwAxE6Yfgekfjj8PAMzwjpwnzTKXu0K2zGeMAHdIcwm+/yCh4jkUYIUpPb2G8GQP4xKZU+yc15IG8qSkMxz3mxrUuyDWDcA9TBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJNif3VSSYp2DsTQKEGHn4Hh+dbe5JNxgX+/HF04uJI=;
 b=efcGKas6Js2bDB8Jno14/r0gQbWFMgHfg/wtxWHJDEoAMkxd+qAazD2igDibJhnSOIzTRPYAR5fn5w/x3fPSmByASISDnDZPEBgxfPqJjPsQtwfL2UGOP1nP+BrT8HLSuvExKbWxi2Tn+xEbBDuwOjdU/T9K7imPUIZFLFWo9LQcWVidGvhKrtzWlTz3PefeNEL3jdnATCiU7RQT3cpzx8Z6KWAtpDTcd06ZxvyYzlA46RmJ7h6Hm/o4Sx6zXTPxcAB1OIEa/HVMGdmKHQTsSakdQbTIZxRY/x0A/Un2rEXO6rmTvxgSWQaJQTXvCrvoUbU2qPHFBfkawvZsKnCU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJNif3VSSYp2DsTQKEGHn4Hh+dbe5JNxgX+/HF04uJI=;
 b=eLLdR/7zaMIVRPwSHS4tHEw38h8WBGmhKMzYUF9mIRpFiSblMhrvywvfy+QYOGHzSLFyk5NGDJOmVvlqXNzI4vJnrwiFNnimGU35GvyY3f2OyQLnmttqmtG8WTw2GrpwJtfw1DCcXtXBvWVathjxx7FpsbJcAwle2eOI+ktquIM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 44/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v8 44/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYWX89mTOF05EPG0q89COw34pShA==
Date:   Tue, 26 Apr 2022 15:06:44 +0000
Message-ID: <20220426150616.3937571-45-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efa8e76b-e367-413c-db3f-08da279676ac
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB292962C62BB685A16A727AA6FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hp/FIzp0kJEp3XPfCbU2te2mPwzQIKdYzDd8TGd1LWqdQ3GIlNK2s4E/GQFdzOGh1tk22NrAOvZBQcVDkLo/i6GuSbe20nhW6OJy137ywroRkwiR3aqgEIRPkWlCBhC5twKtQvenhN5VQ8mK7Hc7ouQYM3ZfJikJLYgBxfWyvCi/XEaA276P3wnJClyCBkJpvweVBzbUN86Eb5xYCQ950b1kxDCA+UHDTnAumFHmewhn9+xLUVNpaeE+A5HP+A4NuWo43LB1iiultNjt7bnLH+SEzCnau0BHGMfLbfRVqjmSF5unXDP2z3mFRUdF1DRm/TixYDB6mw2lbuyEMsyPPsEPL4JeAg+ApPDfly2Npx66GMFfVq+Kq7rL+rmoRC+i2gJMtVe4NlIDt/9UCJNWnmN7fgDsI5xcPTHDNaRWUaYNFaMTfEoYrKnpEtOZ0pJOliR+yIvydvJnkR+O+Bu4Jh0o3jJ5NvwwrXnRmNi6gNfko4JjQRTx6eavMCSK4VYstSJNXLSjv5mrEAg6gS78lH54KNrC3F0sRV7bW+lHJI7dT0gsp0QaAtJb1fR/SqkNB8hn/4N60wwpTTBPxr1pN81SOtSBeuZLodfEE6YcCNqGKRRMlT9e5xUGYisdTppfhxZtsRWqz5ZQqIbtx1UpICc0OtXgsgp0To9R0ye0/VMV1v7WmDLoYFJIgDO8DFes/Rzh24ZCy1ytQKzEpOWXWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+PyjsURIXMbn8w0HSzgHYj+IsF+NjDH7lpGshOf1V9lL/2yXJXVmUFPmwF?=
 =?iso-8859-1?Q?VWfLkw8XjioZvsXYLzXYvBDvkx0cVFYkIIWbufGAv/2L3ae8gW/JIE+A3B?=
 =?iso-8859-1?Q?QaD6woAusjtw8VFtxbYwwqZYV+xH8bQysEMKUlm7jAbQGUx/BmwaXC6mRl?=
 =?iso-8859-1?Q?hDmfRJuazuXmIdCJ8DWDvNquNctXKyqXQvk7g2eZKd0LPqNx/iZnZYbRsg?=
 =?iso-8859-1?Q?KYaywGqIG2bfntyI8b8jh2LqL73V13Jtx8DiYVQ8AN3CWgR5Gh2N9w3/3v?=
 =?iso-8859-1?Q?n1C+IiwY+Av+ziRcMu7uoZqAsDmFRfkMdvLorR+aIzu2lsn3cZ3Ypd9T10?=
 =?iso-8859-1?Q?vnCwwgMCWjHNZaGWwcCLXr3/pgyoUHbLLNyYDM3Guz80qpGarvpaOQSIpQ?=
 =?iso-8859-1?Q?rSOVCf4QT2+T8ygKh0UWm/JqC7O6AqJWU5+dHZMuMe7HnNPfgB1q9kaWVJ?=
 =?iso-8859-1?Q?awBvTnRxC3YLUMYYLWtEzCjKM1bekiolSgPfBXHRSI/MtLNgIU9Y0IZj9/?=
 =?iso-8859-1?Q?VtyEdWmfL+6IMqEX23mzp43CCipmXyQOK94Plss9ydPliwI3mLiJJMjhOi?=
 =?iso-8859-1?Q?P9klsXJRIFcZ/WtBzdLvNwg/wutJEKJeryS+Xv6DK2q0DGED4VgIdzgiW2?=
 =?iso-8859-1?Q?G89vAhHVKd0LcLHCUR+5EgT0fbX1B31sUj6ElhlAo+ipubEchBVKOqZOzQ?=
 =?iso-8859-1?Q?0fp5a1LbBqvG0CdMvWWUj2mEFASGKFs9ocsYhySNMOd+IohaWcpu/DqtJs?=
 =?iso-8859-1?Q?qAvLpFnHYmkNL86zJmM0+5B/rP4VJk2mjusHxQRZPbDyF8Rtk0vGgvXGGW?=
 =?iso-8859-1?Q?vfYX5POgNOYLYAuftJ+1yGCmVzkqo+NXe85YqeIwjWQyPye8Pr6f/D8+6s?=
 =?iso-8859-1?Q?LRcNmS8T+8FLiKhi3vjU+no5DBIjSabNj7sncWZUwzwuieU5Q3j9HEOqVe?=
 =?iso-8859-1?Q?hpIz8uod94+9C/4vC/8m/ad/imu2Eudjqgp3xP0pmozZLLQUuGjXyLKBLA?=
 =?iso-8859-1?Q?1669HCCrNB51iyTmfHhqzTTummU2Hywo3rK2J3j4OnXOHjzdDlkaxoQ/5/?=
 =?iso-8859-1?Q?YEHbW0R2GRSar8LGhROrKNqyhmRSR98p2UK6ZcwED2MkyM4Xke7hYkDmwH?=
 =?iso-8859-1?Q?T9A9IqHtE21rFpGaUBGPJvK6PNtdh3/L50PCQoy0eGX6g3MQi3yH1X09iT?=
 =?iso-8859-1?Q?oz8jYMKJ9Xvu2eeH3MaeKULsRTntj0/9ro66ZB+0l8PeLo7A+e+XZKyZ1M?=
 =?iso-8859-1?Q?8G/vStz3Cmq9n8TMPhdImkDtLblnbDhtJnH8xVlbAHGjByVNH5r5ffofw5?=
 =?iso-8859-1?Q?t/hjltfaFIiY2AiSXAL5zT1Mm4UKf0x58xSw6ubcu0SXVbAl/rxmCfjmP1?=
 =?iso-8859-1?Q?lvV6NHDsTiu7adqc7Yu9LGMF/ughLbV8QTzVsdG8XSLK+U4aaI0yMZ6Oxc?=
 =?iso-8859-1?Q?OuZcAlS6BXNw4csty9J6/Ai3MfeZ41cjAy7HcTXN6f6LtBR1cfW/KUZC/V?=
 =?iso-8859-1?Q?/Z1aVDR/QVXBmR0PkALtlLFdKND++3ATPVMkQDwQ80oEC0dUNyVQJtcCzP?=
 =?iso-8859-1?Q?JNU70IGo9kg29trs97LSfcdpbciI+z94XgKcWuMV1sfP4e0ou8JHwXlxCE?=
 =?iso-8859-1?Q?Y7aPiCohFDMODPa82buYfrDrW0ZxgvpKG68WumqcKerrFwH7nvRo2K/irm?=
 =?iso-8859-1?Q?qVXYGFyD2le2jGDW/PlP18UcnNyxfcI/JAfwseyrxvg4EkwVM+DOQczub3?=
 =?iso-8859-1?Q?8wky2Ii7Dec4hN0J1sfkaH2nWwXsSikUilaQ8XukW5RrvJsVSefn1ceJTP?=
 =?iso-8859-1?Q?C5+C9DjhtBSmFJSHgl0uRkr4OKbvbBI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa8e76b-e367-413c-db3f-08da279676ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:44.2395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAeH3iw+fK7WvGtThiZ7qvcBkFG1RQKo9CC7hN5ZpXjv+Cw2Cpd1hK/EwXskl05pjP6MyG234zlGi47ywBCTJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: l3AuGYB7X1QMy2D-2HxD7qRsFKRn4YK9
X-Proofpoint-GUID: l3AuGYB7X1QMy2D-2HxD7qRsFKRn4YK9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 17e87eab7a9e..1f948af611d8 100644
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
 	if (!mm || !mmget_not_zero(mm))
 		goto out_put_task;
=20
@@ -892,8 +896,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
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
@@ -902,6 +911,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -945,7 +955,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -959,11 +969,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -1256,6 +1265,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1275,7 +1285,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1287,8 +1297,7 @@ static ssize_t clear_refs_write(struct file *file, co=
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
2.35.1
