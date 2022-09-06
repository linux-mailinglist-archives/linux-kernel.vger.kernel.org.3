Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A35AF4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiIFTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiIFTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926FB11A0E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:05 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdJM7014146;
        Tue, 6 Sep 2022 19:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BZnjbaUSTjJ/6p7vbMKZdVcxvqlp3466v7AZ/ss49Wg=;
 b=RhtgV/WAjq6BD5nHGHJy2ui1I1rv/sqQA2TRoozYJuyuofHB9JI47J/S0rDTGmJ/hOSU
 dnJ7olKlHzUxF450a8mEd7CAK3euNBRk+0xTSHxej+v1YJd9XwclCEO3AyDDvogimElx
 3nHqEUTHdZ0scDhY1p9nBZA237Sa3qJymLiFEr9BYs/k1KFLNbooghXUqW08PrKBjzRZ
 bScwTAu0TPXoUyICH68ll6ZtFrdCWGazVNTnFAdkwlpJby4i9ylc5StegLaErYHX7UbM
 7VRCKp44qOM7xpiMrYiaez0umoMbi6V8juRbfQtL9wDxscaaJgv5Wkq1JJeC8j68V0wq pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eyp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5Wa039711;
        Tue, 6 Sep 2022 19:49:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxr2EvSWvPJm0ZUfjPafjavZDysIKRCoeQj0dHI/iyg+zcYd1Ngwxl5UuJjYtR1wDKXN+6+dDNy6l68QrIJHIkPi8+rNqd/u56Wiga0LRQsMcFZN7DN9C1IaDkK0xmZRB7Hfr+pPLaGeqzZbWhRQ6TAlfR7wfnhGUzUXodRcwk03mmFODhZZ7hjnYUwmYgw+aAREU0QwMMmvVTFQ0Mi6zFBLYjDuUXWq6op20MH0C8LCowknoWlJNhgkTwHDOgsm08k1ZCy+r3IGgcdYIVgoh9LAOTZ7sEcVM3slzREX504djUDnNojHZs76q3hJcypnzHLYpb5C6MUTtmH9RO9hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZnjbaUSTjJ/6p7vbMKZdVcxvqlp3466v7AZ/ss49Wg=;
 b=TaCKBZGwg0/JdcHdSg3Wkq8TIW4hI6BTaWiriegQIreP1GXq5XqXwgE7iMzzpJt0oqzfocvSG3x416iQ/+nYGqsPXHH7Vap3iaDPT0kZDub8KEuZU+DNE5wHnfJf2U2yK5KlZH8gBn/aJc1I4loe8Q6N6AmosKyQJ6GvLRq6syavqnnLqtvHFUnawi2zcexlbk+8LRd5soJFIgZaESqu3DMsk/gjq88q7dt7Ja3iGu98zcafExpVAxGeArYSUx8rBrYSUMgiehOL596y8uMGSOCvXJcxGQ6bXawvavi9oLlMm0BTjha+lhCkv7kmMITjqjTaIR9elEgcpm2f3g390g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZnjbaUSTjJ/6p7vbMKZdVcxvqlp3466v7AZ/ss49Wg=;
 b=u1YHw1GcESwpqj/dgb2XEWMQBgXKyTA3hSI0N/57TEgJqaso/5fdI26HbPc9Eq6jpBHj1lccGWyDWBjvnVmOsSXcp5LR8c1BueUH9u+egYAMYIbnUwEDY2x1LnuJjIHNh4/MZDExl1KQt0psorrh4NljUFJvi7/JdVXYcSC/QHQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 46/70] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v14 46/70] acct: use VMA iterator instead of linked list
Thread-Index: AQHYwim0BAyoIFmsekyOi+VZaS2Xjg==
Date:   Tue, 6 Sep 2022 19:48:58 +0000
Message-ID: <20220906194824.2110408-47-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c4d5bea-e3cf-4b2e-0b9d-08da9040f187
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tl3SsT8Et+1GCjiVeIoshyMYD4Z+pbi/vxa6eoJtl3MdGrCJOzw3za5S9KESdJA+LI0/sVILzWa7XuWeV/j5W0SnYVApos7CosUAYrcPfq+dPraNmTVZwV8KrSs2ET8aKMVJ5aO5MnEs3Dbme2N+4ALGH0lowoa+1Mse2gFGL/mzPzx/3yF5EPy5qp3Ug1lyAVfQ5kfO+hcF6WIWz4Ly/U6ZCHdVS3lL/5wtXzwjx7e0zUcSjrlhAONTtj/YSsM4mUbu8+DsknigGB+EXPVsUonhSFwZu7P0QQSt1xE1xKibYUaZQNnsK7Ll23sLWA+QHJ1bcDaGB9Z/g4+bm1sXnOLsPSJpBZslkk2QXiA8vi9U1JyiFQezrVPqphHzDR7nKNv7DeLQNa8PxVpBKasdok+ft0hvnNnj8bjA3Qp6yOJ1sQlYvTgv87TyE5X0GdjoWwOi9x1LTT3SOv+JogWUCAflFbUWqdocsaJOJG4louCGPo1n+CbDyvRYszBDs9gaOc3s8QfWL/k8Dia1/AOwYUPl/kKe+sS9FmUiRf9z8TSzrkS5o/ePQ85cZTyJj1c9lXy/5p3HAMJcgCLFHqre7xI9wSdkZWIKhzkvdDILgGtqjGhOTWGnAv+Pw7oXo81qIqaeybrnW/rc5U0RIZ45vhF78oalJZEleM0har6WzjSxS3NdRGwPXJPLDmKTqwOqt6LWindiuy/73kI4ZBpWHJBXD176haoOVMSKOgneXsUtvt6F3h0qskseoP4oioGf3y9EL+aKRecSHGYbfNWw0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4744005)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ds113tjp0pu8Y+8WXT9WItgNXzV4AJ28z+TfhhtJ9swu5KplVpfrdcRsgc?=
 =?iso-8859-1?Q?DXomdui/LHdQiUX6HSQ+amvjhpxt3lkK0rQQBVKPWeTJL2xmBOxn/sBqBW?=
 =?iso-8859-1?Q?znTJ/0P5Ryi+AV3VhIC361uYeVEYkkfVOr9ESGF2zTtgxsKQHkm15CyyaC?=
 =?iso-8859-1?Q?IW8rCa4MUW/2zjgeuKXtwv9FCJvhqfN6p5diLRrSF2WJCzdUxg7UJSeGvN?=
 =?iso-8859-1?Q?hIN6Zme29doCoVahEfyrjaUnc2S4bbJwmx9CXkyYSCiJ+KZJX41jzlB4JG?=
 =?iso-8859-1?Q?8jw2pNJaLVzFXUXtnZvB+WrhcogmTnLx+WD/KOGVJXO3B6oDsViK2M5oj7?=
 =?iso-8859-1?Q?gZfqUJ0HxRH93idmCIHH0M2CClaYdmLQNDUesGD8Cw1wMkoLrCSSMPWIY9?=
 =?iso-8859-1?Q?dVvEpyrSMxIAOrcoGK3nv7xfl4IXpKhbJuBSpkWRM+fIoE96TLecnufT4G?=
 =?iso-8859-1?Q?vU+V751RpBQFdl4feb2/D/Y163XqRe9fr0ua/1TSmKa+XFL6ICF+pDH/D3?=
 =?iso-8859-1?Q?vm9pcNZocb8jpb6f82zE5IvaC36V1CI/SmOJ+ZK/CNNh8xAQw/To4mvnrI?=
 =?iso-8859-1?Q?O72Vbbl55XnroOL2ORXKBENTQWB7VpXsALBeooDeSOy+mWT9YDTXR4tLwc?=
 =?iso-8859-1?Q?eJE0UAg0/vYe8om9oF1c2HDEeLoHU6c3EKEaVDqZVPdRzCNYb+G0laKSri?=
 =?iso-8859-1?Q?vzFTpq4JDjMSbykSWd5WicwXiPmtAATd9rT/o+6EYvt6He0h0lX2g7LQMd?=
 =?iso-8859-1?Q?ceDKtzp1sjSelEz/fHSX9c7dZZymvJMQzuKTyTjH5gbIXqahP9oqB2fs9X?=
 =?iso-8859-1?Q?eqzbS427d826QjCfVT8r3fhDdjNWFZrpavn2kSiZFnbetyKrmDy/NJk+GE?=
 =?iso-8859-1?Q?HM/HX6kxUPVGhf68hVyO8/n0ZQDPudNTFOoQFHIXli7jxTq5D8R+TC26nG?=
 =?iso-8859-1?Q?ZW0HvdOa2QXMKqCew+Dm9CqJd0v+CYLlbrWLkpPFtF/dAUJwJ1B5pTyg7T?=
 =?iso-8859-1?Q?3rgX1bw5iyF30syRDbERC7FudkfwGgWVD5/Jc2ZUM0TejPFN6oioWjvVRy?=
 =?iso-8859-1?Q?vvbeDI7hGKuSat/UmjQTxmNVYHf5A+sp79NFmEA/cXNACg+NTPHrwpzG9v?=
 =?iso-8859-1?Q?XmxxlGyXvsOokm77mUj7wUEGCNPsA75LbisfbXiUoGpWuy8tqs4tZy6/7I?=
 =?iso-8859-1?Q?Pqs55aV/RTCM/iGp43b0GqpT8l0mGf4i49zNsn1T2MKmEMPZR3Wzrf4Ymd?=
 =?iso-8859-1?Q?30UOvFgk07ksLXa+dvtqzzhWoNNAtBDUBNLGqe0j0UDQ8YYhDvsRVUZXrX?=
 =?iso-8859-1?Q?vFQBzktTDjAj2I1Z0DqQbGsetpWoeuEXGv9YKjCgujZSDaua0IwoLZyTU2?=
 =?iso-8859-1?Q?HScG7t+Qw9J1iasFdJWrhDXFrhk+/HaRur5QrKONkTmj1l/6n+QZFwz1++?=
 =?iso-8859-1?Q?EcOlBDagqfHK7hdgZ+PIW6UuWW+CRKEBmVGYkD39TlPO6gAV199yAD5poq?=
 =?iso-8859-1?Q?UzIAiz23ZSvByWXtX54jQM4fVEKVkoqIDc4vl36YOYKqINdIFkEejCi+GY?=
 =?iso-8859-1?Q?cQZdijssIR4iapjmOf3Agi7Aj2ZlxhAE41h6Tyq0Oq0ZglsWsu3R6nPATg?=
 =?iso-8859-1?Q?Lw0HTPrgAgBbysEkdB+kUE34YjHGofKPH0WxGtqT9GXc+bFPlWIv4pWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d5bea-e3cf-4b2e-0b9d-08da9040f187
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:58.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozQ3KOB4FSa6cj12wvxqo2FSQ5ZcI+8hspuILfZMnmvPnkiocMMecpvws/0VvAquJAACgz8OwxVstRbDAAjvfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: y_LLFjN7wOgc16rXzPLoG7T7VhVXJY80
X-Proofpoint-ORIG-GUID: y_LLFjN7wOgc16rXzPLoG7T7VhVXJY80
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

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 13706356ec54..62200d799b9b 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -555,15 +555,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
