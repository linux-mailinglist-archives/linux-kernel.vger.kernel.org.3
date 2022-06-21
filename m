Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F751553C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354731AbiFUUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354720AbiFUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3702D1C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ8opG004752;
        Tue, 21 Jun 2022 20:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JEfA7TueiDgfp5h1U06IfqgtjfOFfAG9vBixdDcPJwc=;
 b=IrbmpkDlcb5DWVd0imRzcxpreDebFPg3ui1nh4C8kFVOvIpiZImatwsf7mqfRXARkTQm
 1p+HLjMYubYRqpKTvA4ClUwhdSUyM6Tp+bWSgUcp+gapuQ/fBjXrHVIC9uYGpLpaUajr
 yrydLBLYnECbn3BbL7zqC8kPwD/HZ3kwBSO9ukz+1SzwsqE/8GBhUHXfAI0DgUkS4LoT
 tpDg64LCkXh6cNRARNtMV60hiseiGJFpAkGochttC12eK9ev+uoD2WsHHmOxfTwAiU4A
 RgKtBv9EmiKfXQgdwVrJFl76+5wNP3MRVyqtRw8de/me2OV2w3LZ4pTrGUkkbwDw4Rje tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYF001682;
        Tue, 21 Jun 2022 20:47:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCALOa1LK/nBKGf9feE6p/DoUAlUpP6SwTPsC/BzOwTmKlk2A7Tme6ssmqy4a6S0IIBdow4YKP/f7Z/TmCnI14eMeBFRkwZDbanGMjKKc6K/RiFUoRsUoWhCYW+Pkyi3SluZzgLuFCD6XXquVbASLKgj4p0IX6uF9JJJbGhr2RjPRj9cm8x6xWB4septQzbw4dEEH4BU049h+LTIwXW0TS0LcTFPdRtt6x0t+EX+LLv0avaHG2wP+4SaIkNO6mYSx5u5CkNaAWDxiHq6ciMcW9YncAFSIzmdbXkOo2KNHpCwutg2x8E+btkUs4BSX0kUV+1qiC6NEnWot+GthdwIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEfA7TueiDgfp5h1U06IfqgtjfOFfAG9vBixdDcPJwc=;
 b=XEkqOH+0N42wuE9SM/JmAxj7gYpv7PBAKnT0I003kMPWpPdDaqfueF0fmPo7cC/W9D5TNqJFAAm4tn79+GzYMQG1TKthz1bripA2W7HcYe9qeCAWaECjjozuuNAVrXQ4CMQ+BY4VpfElRsK58CovQYOinRUbN5tzP6pSgx6q7HjnJN1Kf1c1pSN2XR/6VjIqLRHBxD81fccP7asb8XOJ3lgIbqhPgguc5tQxHNGAOB0BTjriEuHDNSncjHCnKS5QN6Jwr5qPP7WSYjYPSl0schsa85M5moeWL2Okl5kk/kQErxuo/lzpqTRFeKG7XltT8eylzABCBEcjnIFecT9nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEfA7TueiDgfp5h1U06IfqgtjfOFfAG9vBixdDcPJwc=;
 b=EC2ANukTeM8DkZ/eqyWReOz/NggRA+fiBFAdvhHZqzL5cf5Lq8J3QlS/f4OayRSt6E5j/IgWNEnFJvVGI30LxbHfSrg+fJlQkHgZ1M46EQVWFBPwgINHw3GsRvOBE/weaDz2eM/xwE03NBZ2DTW+mlGayY2rwTYNhGElEn+Chq4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v10 43/69] fs/proc/task_mmu: stop using linked list and
 highest_vm_end
Thread-Index: AQHYhbAS9Zaz8pdLnkepDbelP4KxUA==
Date:   Tue, 21 Jun 2022 20:47:07 +0000
Message-ID: <20220621204632.3370049-44-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d39e52-2936-4fa8-ad71-08da53c74de8
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392393BD1CCFC6F43056F58FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrW5pzuyBlFQonOr242Be8cMWQ7jn8KsO4+ACGlb9Gj/OMy5PnZyaFYThrmYjVtg8VD+dkQmjGfNIz27aaE/3FcErqFJErJ03oUqgIe2uJlmH/zE1rd69pk9WRR3HGso+hsAFF8YqKIQBoQCrDogDk2ViEyvhgfe/2b0Suj7Y5isYp3yQpLKfcMlLorrD8Ks34E6VHXyTafA8AHigD9zHyC4TkYasW1RIW3a/8b5TKf6GrljJ71lFamBEG3LBkkdxaKUGtcxN4kMvwKRcT2RyiDKJEpa+vM3niu2ob0vF/L+CC4JK7MsWSWXUeXFjakw/eMLgdp5AX3GylDmziBDibvDno6+i6IS1oUSg+Gg00mhqYzqqDpMc3h/tm/vNgUUE4rAJCZnWeYQPp/BR5xBIUQiIhejC0z4uaVYNrSUU2UBhT2OJEBi1yc0MZQLoywNdieaJsVZStUd7PSlV71knLf9aK7rpQ5kSKtC6U3pIRBKD8Cd1CafD3rVJ1rjOFRRJ3WlcuC5BxGpAaO0wkBAgUhuf76/Hm2xpkZEd/Us4rpJxdYETYKoFr35Xm/0Z0ObCloawvEqfn/e3viGJcPX7V09DDX26TZfTqWIXcMVZpzOpFgRy5Pd8vrW7AhG7LwvmgrJ7e7KdGE/f5UCHriOM6X50em8LmY0gGwYfmTciLLOCpXplvRvS2FFnAaFpWdRZz1PrNyZT8+GCqs/ijFtl6ep3DksFg9CNhtPkmLu37Tc0skRunj/4GSqzWS5BrkkdjF5y+pwFYCPxfUQbbv9fi8RdzwNkX5upDwSIww8kiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?quqQr3yfXCI0nXUPywTjNyy1jWid/LSAS6xuy1jYzDAhO7UQBju5QaHYtn?=
 =?iso-8859-1?Q?THkxLpR8L8R8o+vL6Sy/OAp94ouTuXLUdb1wXWVBPo19sYh7cGdX8nO+x8?=
 =?iso-8859-1?Q?Fc55KDaYiSl8iRrFLJfksAKbvR6bNNaSck3isS9Z2uvA6Kj2fR+n0pNLuB?=
 =?iso-8859-1?Q?+ZXosAA2n8ElccixDOp4jdmcrYFfnW1Xm4D40Mix28KHP02wO1nIXKxB7y?=
 =?iso-8859-1?Q?y5BNn8CilBnhvEsQXn0HYILCvR0dnTerBcnbB16jwZtRg3SFKeIXrpMxKy?=
 =?iso-8859-1?Q?yFrb3P2vudZif2plneTp5gDioPox8Vdf+wObRMM+VClZoiD1lqax8YVFJo?=
 =?iso-8859-1?Q?+X0tjoUZ8yAabHOUYAnjJ/9zftA3UKVBelA4SyI6EvvwkjLkZsd0u23v/I?=
 =?iso-8859-1?Q?86IT4pSxWVB747WOzgfyDzqwFDb7zb9bIubSEorAU4+ENEpjM0vYmBREkj?=
 =?iso-8859-1?Q?jh3gznENtFGXK7C1ANzrOz4qtWfLs6tIfVbeautd3HKTPoBlaf7yyhASrp?=
 =?iso-8859-1?Q?7Wk3hY3RKJeQk8oi4+yqTKpG085DCSRZ6m0d64Z0vHV2h6eTPztNkTfrdR?=
 =?iso-8859-1?Q?hmU+kMjW6cH/O1G1sYsN9Erf57tosjPPehMY3W/jNXMukq01fp3rSBKVJ1?=
 =?iso-8859-1?Q?Nm2T97krT71ynsJVoygboXBF9hlHcuIQmiEWq8Aqkqw5cNM0MC1dj8xMiB?=
 =?iso-8859-1?Q?uYoTKj3hr4/04DnEH72orvwnkbyCnVK0WXaOVd+NrSxkKlhaZLpPUmKeCV?=
 =?iso-8859-1?Q?E0njtHKMab9eLhbpXNSRFL4lDG7Q6zSE0qbGFMuR0fD/Yn4xvp3ioVUPUH?=
 =?iso-8859-1?Q?9i5AOzXzxXAMlvGrnV0FWcOTs4PkEdYsrLONEd/J0d3YIlLsSUUOt1q/Wx?=
 =?iso-8859-1?Q?hNnmr6r5Le0aJXlg4i4YZJZDJT5gLmobYyA8GLxGYudv9CrpZtEVOmgHOH?=
 =?iso-8859-1?Q?9m9SgknQbBnzsiE4PYKeo7Jrv7DKqay35LH31lN6H4L5IliU2Kxue1noDR?=
 =?iso-8859-1?Q?aL0Kx72HajhDJZYIpWEriLKtj3p7rAYCgJ2hWQ/setcqhzkSc/DWQEolQe?=
 =?iso-8859-1?Q?sIs2WB7848nvqa+UzwKFBAYV3Kn1cDb9EvuIHgmg0t23qlubbsXEpTEVOy?=
 =?iso-8859-1?Q?zQXLDVYQ3LPicpUMZ9Pfjyl3fCBikp8H/wW7e//xpVnaa5HX5kWlHhbQDw?=
 =?iso-8859-1?Q?2KVsMbkfkeOaLBBA3IE6q06esJ8Av2XufTvz+nnBdoBWckhHlPMNhMkFHe?=
 =?iso-8859-1?Q?zQ4qAviFNK/iO8n1vV4ehUpHbdcIS3TDsOZUAGIbeQivJmpeyWxEnCYIvl?=
 =?iso-8859-1?Q?Icb3vVhu8U7q3Q8Ubk9vbEbBF41+48WHLvDYWeMknfYrCXY6py6kL4POb3?=
 =?iso-8859-1?Q?jubVvqpKbF4j+vdpUckkcZQ/pDsbgLh8NVR1te0Iu0JCyDTKNC2tXGe0Ws?=
 =?iso-8859-1?Q?eME5WDzAfuwoVX5ED3UwI+qbML95dR+AU8n8NHD6vPH3J6dkLhWTLYwgjE?=
 =?iso-8859-1?Q?05WIJ3HqGR4q5ed+TXzGK30JVih8nfPOdargWZz/0sAOSHvho+auz0+yx3?=
 =?iso-8859-1?Q?2V7GhFU+rg2Kh4QQpbJtGSZdA2k88i38icbIoUWZR9QcihbPK7PAsSg1iS?=
 =?iso-8859-1?Q?lVl7QwSXxsogtedPJbQsxTUhTB2PuOayNYZdg18MO+xr1o4b/BX/zURpmf?=
 =?iso-8859-1?Q?TWNfypz1eI91mCFnuaKhrwN2tExwp42WbCVnjct2My5rhp/PN/cjzCGL5j?=
 =?iso-8859-1?Q?5lXzQ2kOrQeczeE7L7a6ooDQlVrFAfbyCjhG2RC4ysVnO2tF8m9f3JzWy1?=
 =?iso-8859-1?Q?YQkSjHyZMwA2Y5nK5H1x5v+fntKgmSQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d39e52-2936-4fa8-ad71-08da53c74de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:07.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5drfWDuEiT1HBeu47g5k2wszvFJGBLF+bWN/iuJ1RfcPGLWRwFFj6imkQLDS+A9cmEBo/hWG7/oQbCWv9qtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=974 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: C_Y2lG0ORKGqhkRsSV7LCRLUxl1smF9C
X-Proofpoint-ORIG-GUID: C_Y2lG0ORKGqhkRsSV7LCRLUxl1smF9C
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

Link: https://lkml.kernel.org/r/20220504011345.662299-28-Liam.Howlett@oracl=
e.com
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
