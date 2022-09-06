Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED65AF4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIFTx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiIFTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E3E7FFAE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZj029954;
        Tue, 6 Sep 2022 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=NEs4xz8YVuDLXaq/CCVgqa+I/wwzHu8Aj5OabE4t0LOzb/GRmGlv5M4Kwo9rHvtbv3QI
 ZHq5Wo3cLNtj/bbQQlGpQPEsga+KuwLXtdlkPBuTIUNfr9upz4iPTyj4sDsVr0shbj3J
 jyYKKv2eBt0LplDOGTivj160QgDuKjkPcxKd7IlIOFz+4hdTg3/+ptKlzef78c2a3b6B
 gPxpWYRX+Jx1TxmDi4+QhJ8KdiY5naxs1DGp+78PhISZO76JsL2I6o5lLLJTR+ChaC91
 JpAAUDfsheMX5ruhlJbFAzF/QSTuMSJ8S9dE67XUj4Elx3A6sahCsG9cJS2O2pdLMkfe /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WX039711;
        Tue, 6 Sep 2022 19:49:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntfklo+N13TPQOG2VIUwNP7V1050QUnRTlEWmifkuN5W1WUroNwa1A6pxZSReW9JagDV1lTMUE0IglJT39mpWvK5agX7tSe8ms7CNtadru6euKREvgzi0rsF45vb7D0cZ7DVmIQYQb/t81r82Q+IkGVcSlIIvunsPu1K75Mb05vZbU8I9XVzfdSfDLHcJiXLMdXTqSY/pEkVOQ2Sv8mAW2HqBasjuRexDQDfUy3fqwp1KmhUt5kWkH0FZa3Qxr8qX7q5Y9TwiQbPMT82H2RVi3jve8gvomAUkJYs2NePgblcVm1BmwISLHkJJkHMQR5bF0cg76d1kbf/ptZ9F16Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=CIv7Z5Drgg+3pmjfwMgiRNeKe2/hizRTZSw1Tt+r1+o2p6BNabGApsuwQ1+notgPiu3DR0WAaJVaq3+kH9nIlbFWwU6UGySLTeCt32Z8+nw4DQbnv1dSLSh69nrGiWp3S1W0Aoho4iO2mWsEOde3iLrt4V/v++/fU2NpJhD2+yOhQcGb0PbR+b3ZLf6n5bjMEgjDRahCRQ267zSB493a2EFePa+oRs/y1sQQzjwxVGa3jbUCMaktUFzpMyYGyeF/2T/Zm9jcc8VTrAm034OJjCLRBnhwqA66oF4sPYGwwRQYbvxwhbJBDeezQLQraC+kirSdTd2/EeFt6YnugSaIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngf70k76kRpRObHjvGvMUliwq0ETt1cTVrTppxrchEY=;
 b=kwh3yJQGLoeIsG/JzYdPtU9wJWiR0/aa8uA93e6wHFYWOuYwu2fqtgA2RGwV3LECXmkwxLOqDZpTKpeN7eEKBJy6jOj4qRHaXuIq5IOrhDhuU7Pqkspobj9ZxY9Sx2XX9pEHCNUgztl4IxT2IyY27g0S489rS1HKOCqQ4iMfIxc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 43/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v14 43/70] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYwimzZL/z5I7PC02dI3D7mIyPWA==
Date:   Tue, 6 Sep 2022 19:48:57 +0000
Message-ID: <20220906194824.2110408-44-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f4c65ee-516b-4447-1b57-08da9040f08f
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgHWynPjcDiLibgCQQi9D8qSCNb5Fpve1T70kqX5XuMSnhjxswaWQU7GRp3PmeZOPgaxKxxtwb8VcxW4uz3M1KgXJ/wzgxtGgSmi0NdeREJZdQvM10WHy5tNvXTE0Sd0T/KXU/KhdiC7Y12EXip/0adKKZrs9X4AlsjahvUgIAChTfrReIfdI+Vb/BAMQgWrbhtiYQR+7ebj+YkfDQqpodKAuA2RJ6RJTV2NCcY6kFAmYK9DE6s/RPMAFMM4MWZjZsfxWqfQWPJYZDFqHZu8aoTiesKQ09q4aWPhOoiElSCcrHwffXYY3Jz4yXl5OazjR+QcEjUvMOtl7wMe353SsM+mS2b2gtJm+B02m1QyspA11N7RxlQt1IfqNVkPfW18q4DzbSSSSyNLIyG8dGujhMnsa/ODFZhl+5vOHQq9PIMJtTfwfq+EJ1jQMBptcpI6XCgbEeW93liEgS+fpQRs58oHGpxDxBzDPvOShu9G+D2VLOekYbagYmOxh4X/2JXDfF+ze9DLctOVUbI35jiaSMRXt/ckI6MF6yPr7FViHv4dWdsDnX6xmu5XkOYsXO/aymG2MUtnvrjc5hUYcPCELACDs5kf9Uh1LKpYA3OtFD2x/CLZb/GE17SAK6ApXZan/n2fkm0Jn5gH8sCW5prTwqoTscXwDpxhnaaTeYav5UJeeasfXNPCKIK85D/QEOIZOEexQnAfHtAKoadnwMmAiMXFCv0f0iWdNenp8j5WysuIEjcJFipLBDZK2v8wGPHM0FxF9QebuEde4oS3tyWkkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(107886003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gvr4z+DilLgC1DExh6HbtIx/Fc71ZHa1Udi5SyIiQ9LBpFtHpCzMGrtFPz?=
 =?iso-8859-1?Q?ZRgfoyzThXvbRT04I+E2jEa50I7u8nRRAZ1pWzF8I9grIODg2qqqwhF2Rj?=
 =?iso-8859-1?Q?orUTBwXkZO1wJOXD9xxEE417ELkWepttAc0QCLrLK+HpUnyjbHBwhUbRxC?=
 =?iso-8859-1?Q?1quEqo/k1bBi8sdgkL627W80I3WsBvxLOPW4MojKwQqklojrvznSfh5K1b?=
 =?iso-8859-1?Q?e1Nec15yYYwBvhefV9Yq+97LD8W3gv5+7fDsmrGLuoUKYPjWU4xP0AS4XK?=
 =?iso-8859-1?Q?SpKQTawV+sZn6wYGmEIKNys6uW5RrCAQui+8sDhprkBZ+xB9Kixgs68exQ?=
 =?iso-8859-1?Q?Ol+wSb4WpZVPOr8Pmk8kuXfLc14QodyQrbJe41flNCHvytMjTQC9aLZR7r?=
 =?iso-8859-1?Q?DHL9Ua29KdrvBBuxR5MWnTPUSYl107OKmFn3mMHuokZOP0STZoxJeSxvpw?=
 =?iso-8859-1?Q?oayfN9B4aSwdfckMankJOtvh1ToiLYQyq7h5y24Y1w7sOisDbkzAJiWjXL?=
 =?iso-8859-1?Q?Mn5uo/B6Wm4THvSsaFvt60LYokAunTQlA9Gn+cgf+AxMCd9Tk88py2Hlez?=
 =?iso-8859-1?Q?53fMYHO8mwJEh4Ygo66WjRbYRxsVhmOKbc4ShuEyLU6d605WWU9TVcm7JE?=
 =?iso-8859-1?Q?7E07vVAl3hnbCPZqUzSV7IQgLZWAsSrM8FOMLH+rYpG4F/ryHcOFOlaikE?=
 =?iso-8859-1?Q?NxEWq0w4EImSwRtg0YITaD7kr7NKKWo0g6HwDGVedsUENho2qTBkxXqhJF?=
 =?iso-8859-1?Q?FyEe+hS795kfnArQK75xtJnRthOgwSWG94iXmFgxXRTCb/UDBhTdnWPtud?=
 =?iso-8859-1?Q?69/StfU6JciO+ycuK1xZ8YpxOg9cOSw+FM0/PdftGjh3AVllT3BnUARx/l?=
 =?iso-8859-1?Q?8x4sIt/ElTsIMNyKp6VKqakIl2qmEK5JUtQbtaLWYI9T5KqEvECGWahAn4?=
 =?iso-8859-1?Q?+f5NpES/A6IIJILfkDsQ1BkQyl2QShlDXKidNv6mFu1MelzKn7D9E/zNoV?=
 =?iso-8859-1?Q?PpfcS828hBqB7M3B3MbGFWiGuWn60ItGsBdq/5c/Xfc5rq9/0RSbQDb/+K?=
 =?iso-8859-1?Q?LinG/X9e6ssHSUoiwAF2f6G6mWi2F9DQNzRRlpU6X1u0t5a7xyb3VntpOj?=
 =?iso-8859-1?Q?r/hlbAIfDaCdycTUi3i6uEV5rPHOSmIJGp5VVI6UARnrMVpPPoQmTntKaa?=
 =?iso-8859-1?Q?I7X1bjRzWvlkbnvpkaXJOE3gqpiS2d2J8Dm0ykEPZW8onClgM0yMWSBXuX?=
 =?iso-8859-1?Q?uTowhtx+kPyYRQJtfnengAdrprRIRkHDSX/kUyQZtgJ9JFOR2A42pfCm0E?=
 =?iso-8859-1?Q?I0ERGuhI0URVPcVWUJ1yhG+7l/GUAmEPO+KcIpcx/Yka+FIsgsO9wKfLrq?=
 =?iso-8859-1?Q?1eES0wlVNxxDWlhXj3tztk8xfDt6LpzFNhwnVGFrG3RvwgXlJ2MmU6DYQE?=
 =?iso-8859-1?Q?QKRazePNWihXGyIrPaz1lVUCAnWtYRuQGSw1D+B4CHXDBSCo3PYNuvC016?=
 =?iso-8859-1?Q?pkAXR59NPA0bIkVNcuMKADsOVLnD2IGe6hl/fdvwT/KvL0vNDNmnMX+Xmi?=
 =?iso-8859-1?Q?k+MP/jcqq08uNkRXrTHQpZYvtQK4P/UNfVvw+W5aFMnBK3+Kn77V05Ecd3?=
 =?iso-8859-1?Q?L8sJ09dGLrz1EKgf9b2PkuaZmRHyoI4geGXVV9EdFkaSIJox93gnB5fw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4c65ee-516b-4447-1b57-08da9040f08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:57.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPDIpTwdArqpR9vzJJ3JLt4KTboIQfooCZ0CbYmjnVl87sELxhgbRoKffmtSzgMBvbcEgn3o/Rc6OX/SNAIEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: 4IZ5CGWr7eUUf3GuW5HW4L4Dz3xbi3O2
X-Proofpoint-GUID: 4IZ5CGWr7eUUf3GuW5HW4L4Dz3xbi3O2
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
index 9f70bc1c2766..8b4f3073f8f5 100644
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
@@ -876,16 +880,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -898,8 +902,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
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
@@ -908,6 +917,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -951,7 +961,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -965,11 +975,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -1262,6 +1271,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1281,7 +1291,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1293,8 +1303,7 @@ static ssize_t clear_refs_write(struct file *file, co=
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
