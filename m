Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565FD57ADBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbiGTCWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiGTCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E376D2E4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K24Mla030732;
        Wed, 20 Jul 2022 02:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=cUIiIwR+mijpKBiMPsLnpTYeziTZYw8Nbq2kOSy2iZbTee723JcgxylrhMYnTLzw9Xdq
 dneeYrKijdgNviAF7fTFIG+Xw1poHGgQ0URGh1uJrfj5Ow8Pz2qeHzS/CYI5km1dHhjo
 aZciLRAowTbUcpjnoKY+jp4y6Q1h/4e5lkkBSWI0hl5FmDihraSau0jzohiaKQK5Sky5
 juojfj+woAzuarlc/7wlAH4H6vt4Bk4TJDt2CCrx6UJyPlHqZSDUkeoAxbhq9UQj9C2X
 9WdEENaDmcZSxp2+cKvj28X5Cc2IVCnAz76ovQ15Vg0EWbtf02vTXdVqghtMuliO06hL Sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7ywa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlo002689;
        Wed, 20 Jul 2022 02:18:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/Do1wKABvvdE4nx+LuCQ8ag0XpVL+FqRU8W9bBXgyxW1RzYPCpCHQbSyZSIRZgiNhu5bR6d5Dv3kqdns9VRa2tMXipi3wO4PkdLBSo74ex2ZLrMeVU2wVZYvb4tZK9yem68YFo6JMCZqlIu0U99bCfhtbARr9WM08gBhzYMN6gPEcLwEhLB7u4T75rUQU9ILaSKt1jmPLLm3s26Ncepe4e3yR/tAq90KlAz74exxwwlD4ikf3W8NgrgFI0G0g4CuY7yEqT5Mf5yuCaQr1LTk4JiOLgL37DTd4GsLGScbfxVqow8NtTBON2SadyDr34cqqMfqOLNXP/CDfgts6g9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=BSqC4+sc7YSIzLWcrN3LtAdXV+fviZL5MegzFUGcUFSSA5NYNWp0hUbBuiL2+Aw1nUzO0x2a/n0PpjsAoOCx2oO3wppD11lx9Nq31ZSN/E927Tw7As0FWoW1v098F8T1QkjVkwicHZ+3+zrgiekSWVUFRf5Oy/ZrCYNRWC7l2DnJIU54ucKS0OLegQk5rNtCZSm81z85AfdNpq/s5ZmpDkcxvGqrRw2iwxCxDBzdvhlBl3Zx/sXWYSBD6zOLRbXTeNBNSBavItRIbMM5QuaoSzMkHGPOxyNdRop3HEFFoW2XGygYVylAd4ATOT0BRMGx5fPz1A95AAViJ+KjsnVtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1VGyy8O1NWAjWD+E0DkcKWxGiPNCVsxxsJgxA/7004=;
 b=Tn1+qPRZ79MlyCds00MXpJpbBl5gyI7Ea7HduBUUtO71f1ozjduNnSD13j4POof9rJ07rdkc5N+pEdv7SMLlcWpTLgE2Fo+6v8WCRvj0JYWIjgLyddMg6udS/BvzhDYafU+i9nLGpWNBBUkjIxgqCgqN6egJDDsTLJZNeM28y/s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v12 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYm97tI6MJzg9pyk22L+8G47vwxw==
Date:   Wed, 20 Jul 2022 02:17:57 +0000
Message-ID: <20220720021727.17018-44-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d376036-44d8-4166-ce5c-08da69f62628
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VbHJdKSE3Z/3vVkkM6w3R/pgBS0z83L4O/R82YyEVZYfhB3c7yEhqdeysY7/ovW16iKBSa3EfbgHRYIu+xxZ5DGssPfbr0EMfQhot1xyMvUmJL33BcUnZSPZy/H5FRCOsRjAAzWkfWJykJHdPo1Zix37xTU37eHwoDJ7QDffEanHmHvNdzTn7BgJNVg5QPUiD50C2V77AZnItay0zFxGcN4+rgXSN/47vJzVG6/MYTO1qFFDmidg6yD+ysgFa6rjakChoHXUSHV7BMtIdb9pCT7FfSBuLBQpQbN6FiAuHFzSHoGIIarZxFkX/JkJelONeGQ7EsUBSKq3jXJe63B8yh/RtdWe4uMIJEVhOfxqVPOmhhlROXc1L6hF1eCJ2INtO1H9bj37w+bZ8dcj+Ybb/XRTfjGDN1xvfYBAmj6O1yhWatZb9h3vAVlez2lW6RlFwRvbU6Y4l8ndQ4wqUfSxPmyUk5OgIiukhOJ7Zm9mtW/r503qeC8fa9UZ7By85n4FPB8G6STzvV6U6vZQHIoRAspeCJyt9QbGMx2lC+jT5MMGK7D73rjwBPx3LsHsnOJ8PTxW0ylzenYcXdmg9i7ME3sX5jZ7Gr8UzLVuDcqLD36FNtPnuQ+EUmgVbFX2gqJ533btBq9Crb/A224/bY1WJ32YsGQK2lS53ZZiUfRwxjPjYkUlcW6VlNSQnATBL5QVpxwD1L5cxMbetwgTAcdLjIjZosaEKclfsoc9D5AFgYTsjGwQBdeihMO7Gdku2LeNDlwkqT13eQVqOh7X+QxFNEbuNyjCrrbW1SW4V/CU7VUIQUzF/JPeqXRh/x+WG8mTpT9+f144Wwi/FFOZt+pqw2L4o3NfE++pbVIheJJFt2OOGKiXxsTdgtMh2KejiPVo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XZ3i4W0w4tWlQOyxLSKK40MA0kq2FiTQPuAxQCCnf7gEUEz/iWTe7jAXPn?=
 =?iso-8859-1?Q?TBGvfWzc+CscKTUBhvDUPx50JJN5a+MlrxBsjzzsCCSFpRcNL/jRciOcVy?=
 =?iso-8859-1?Q?GBaNKcnAXXZgUouhiX2JxW+r+XvspRdrk6yUj3wYrAJkBAiLgsY2sDwMZx?=
 =?iso-8859-1?Q?A5zwr3j1Opca8DKxkQr6SvIzIaTxzMeW8cqtBRbFOaEdmVlogoapcQZlG/?=
 =?iso-8859-1?Q?0/h/63eQUo4hm2qyBlr7U7Cza26UpRHZfwYth55zyiBq9jMML5KHsHQSN/?=
 =?iso-8859-1?Q?cjh2H9NcBbAiGWFCXic+GMiaF5mhn2kjTF5PFrTLh4YnrpKNtFMe6TPifs?=
 =?iso-8859-1?Q?6f8JcWR5J9UHXHsIpPrlFhAzP7eNaMX5TnrU2lRNyb+fYEXhb4sI6acK80?=
 =?iso-8859-1?Q?9P3NDMDeLGuBC8bzNXbxCsFAlSa12FyvCg11u56q1PS8AgZmStCZCF+wSx?=
 =?iso-8859-1?Q?NkW0nPIX+HVlwoXpeHqybpg++qaCh549xYUP1yX+V7eAv+UstQeoSNQs/D?=
 =?iso-8859-1?Q?iZ1yBBKFqvh7cK1hO5HHIgVqwLTkAOH8qQ8mn7qHbiN+ysrmHMDtahFjLI?=
 =?iso-8859-1?Q?itrUSTgsws3JMz8y3nMCWq7JbqP3T6yBwpAtIId0n42O25juI2b21fH1Vw?=
 =?iso-8859-1?Q?P69SYGJ0e04I4b1vChdmLZU+Mmy0pdXwgZpeEMHvwKqMTKtORZcnfrBhBc?=
 =?iso-8859-1?Q?8GwM4a3Jps1KzPZ+q8ta6g0PZFIn7pYGtYR7SszMixt0ahk9SjsbBHHtD8?=
 =?iso-8859-1?Q?TZ1xZbuw8SsNbc32774tyS1i3jSc33JfLBurx6E/FQvvx2QTBwv67gBqYt?=
 =?iso-8859-1?Q?kkT7tRmyeoPtDqhP+YX/4W2l7Cm0cLC70X7PDVAkm3nad0Nt1bsYFu/OAK?=
 =?iso-8859-1?Q?l8unETAUYhCwTCEq7Zdc2PdKWT0j93nO9JDFpGPzGZumEl18UsW4gAoMrT?=
 =?iso-8859-1?Q?4H98A++Cg0+lDZYbOz9OvE75pzvEqVpRRWPtMNZLEKE6EN+haG8mnbPETW?=
 =?iso-8859-1?Q?zaRnNZDGKlCF5VpSIIqWggjg1r8Aw5QN+G3Rp6VafQY3e0tiGJWqzqtu1Z?=
 =?iso-8859-1?Q?17+9jaz9S+5k+kL0G4hnF6YvDD+UgHnPM6qLOLZmGfHXZmtTCaPl/Wz9eb?=
 =?iso-8859-1?Q?NHjC6M9R+EatQFtyGWl2m85df3PtevCWeu3eoej+sYvl0H+W5QINmdEWdJ?=
 =?iso-8859-1?Q?9EllYLvVpEj/t8LqoFuWbwS/mFc9xSYlc3C2lR9QZpCbFTuDbe8DVuaTG5?=
 =?iso-8859-1?Q?DfY7Uzk84nWooCE3n263pNIhiIVGxApOaIp6TEORM3USN20ZWLaDe1mVSi?=
 =?iso-8859-1?Q?6TiBeaUnkIpG6tkHPtdpHEMElkbbzxnU1o1DaZX/vzoZvcjteEB3//8RXv?=
 =?iso-8859-1?Q?pO6MoWsKhPnFIlL4mTB+hVtjkEc+w506hLEiz9fRK45ehwC5kPl/rSs9Da?=
 =?iso-8859-1?Q?tSACwWYac1wxVYfsBjldgGBJMQWE+vIVAQwsERcwA5M6+fjWf24sX16SgU?=
 =?iso-8859-1?Q?xhbQjVO4RM4NJjnWSTrYFjHLyFyBZhCBU5lx65c2dWQqxdUeaMlccrPe8Y?=
 =?iso-8859-1?Q?ehalEdVa8lgVJmFBsyJTcvAqbks0sE6ZwsebOME1eY4PVT+chqh38VCNcv?=
 =?iso-8859-1?Q?TYljvzlLBiL3+aiFsBev6+YIimmX2gfCamcDsPFMDtj7MnES5zZhiyCw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d376036-44d8-4166-ce5c-08da69f62628
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:57.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5iMRVoNpSe9L94eG1uYJuaMoGbUoeRZiCIggIAco3xKGvmjuHmPUICy7SIqEfNs2ySAWSGcWKzZ5IJ6FeojKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=958 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: SmkFq-TS6fGKPQLyH-low1ZhbFP4DQR2
X-Proofpoint-ORIG-GUID: SmkFq-TS6fGKPQLyH-low1ZhbFP4DQR2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Link: https://lkml.kernel.org/r/20220504011345.662299-28-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-44-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
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
index 616913bb1fa7..f9c9abb50bb7 100644
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
2.35.1
