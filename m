Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6895AF4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiIFTxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIFTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFF80B5D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAix024665;
        Tue, 6 Sep 2022 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lSrJPc+5W3/Gvzp7fS6f7BxscxUzmk9g/DsKovVH9Ws=;
 b=xYCCih+E6n5UHQxeCPglphXG3G7Uikso84M4jeNigaUj0tlYXCqLXWPnC3iqqwew73op
 /bD3m5M6C8lREa4kgmj3SE54h+WHq+j+pbcoD2piRBbsPfw2s1223YpNtPA6Xkek96gB
 9ak7ma5Sh6ouCuETzMCaMvXHyAtPphb4Vs59OO/vkjHclXok3fxyAbuzEBbstWpdvud8
 RVwQbUUjnMjFhWPndcmjovw9HAQ16L40NWRoJcs++v+H/3o9k53HGtiOzciC7fDxzl8p
 chmgtV2a/O9OZypZQEWhRp9dUIb2uB4+lVw6109tN8SvbSWHp36/9rV5q+G4ZrmAxFFJ hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67T031251;
        Tue, 6 Sep 2022 19:49:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bveA8WRCMMr7q1PneVRZCQD6COadFeaogD9ZPFl53akuUmZOjmNCif9cmbimLx8Cq8oNyX0pcqMww0jPoYpELK0xxNDBGa5bFKBqNmb1g/DiNDE77KplNmcIWUGoU/kRpnKJ4iMJMuvd83K2b08NhWYWSWEbGVgJIfRoAkb3ySgLlUlqqRoSiPbKTerBxAKG2iCnCuFjbecQJiFIUeouqtuFCe+p1DoQNhmG2uuKZ1Wgz8kyxs21RvWFgTvup3ziqSfCY21jN4CMtm0lJppMsPS61W5Gqmm/9axlVvH+dNXpq8iBcq3+RO8Ko0BcczkGsoM2xD0aA8nS6DdpkHkYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSrJPc+5W3/Gvzp7fS6f7BxscxUzmk9g/DsKovVH9Ws=;
 b=B6HuFSCNXWJG0M/LCJuhtj+HWUh6gzNGRDLE831nppbcR6+D3zcQmJf08VObunhdpQHM4Otc+H6Y1X0/U6In6MGV31bMNbdnQYDQ5g1jibw/BSTaPE8qgKPLYcQgOUiCGXSYCeP6LTUtu0wt/ww04+8vdtYidZeIt6yuhvKYx1V25JqnC9k5gnc8GB8x1Ee80+qTeKa2QRsmGKkoSQ07ALGWQK9KAmBw2Dtc+eilSzbv3x8kjbdGJzPHCA7gR8COzfRXXnRnIIGYvU28cTpt1RDVAHfPMWDt4RdMXJGDh9Qq+cznOrDth11WfSXxyRIeG4YowaQLGajuHX+aBEAk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSrJPc+5W3/Gvzp7fS6f7BxscxUzmk9g/DsKovVH9Ws=;
 b=Y5KfLpJjq7Yxm7d/v9/Imxg1gvzK160lO/ZflOCM/W32OWfPEadZDrmRVVgM0e41IocW0KETKvecRwoS+SVjY9LC/4SsWNu/2Z6ty6znfpCmK9ZQLwAhR1oQd694yXcqJTIYOwRmyOgO78+TK8lxzc6QyEsXstdNNabumSm8dhg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 54/70] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v14 54/70] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYwim2V6O5pcv4sUezPJ36If8z4Q==
Date:   Tue, 6 Sep 2022 19:49:01 +0000
Message-ID: <20220906194824.2110408-55-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d43a69b-3054-4982-5709-08da9040f427
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nT2F0BIGrV/ccu3oa2n0D6y7C9H7qFHo+Fp0sqhHX+LfDgnX4G+vPONnk3DNuoXYoc/p5pMpBuMAIKl09FaDROWWcj/h0Nw4AbcfQIDl65W0rTaSwVoUjNLQ3Wl5aR3oobwA/ma0wZDObV+js7+VeGHhNXPz0hLhA+aGDU2HXNQO5f7CrhgtGQ0QUItVOTsPa4h9wnlYmpwfYHBTee8vDjwDWvEtEPRTF1ThrLT5VArzMP9VUCHH+qnZnHeaCYCdKPr+qjqLmVB14p5FpOuYkAzzCCt9B26btpWCA+XnKmjdDgEwK7AsThEzB435Cohfko0C9dvj3hrtJGIJseLm1LOBMfyTtNHRSiBXiSKE/kFi8Pz4uYS1XJGWgjFQwqLZtjR3rZMnwmTef18XEqWEgNDiUjzQ4ntHY9Fd0UpOwTfsH8tHeABDLIM7zv61HmB9z+uQriyoJ+yONsIRDnD6yV8YZbtN6RyymMSB8lA5LEImGaqhJagF16YmUQOk8DbXswf2k4tSpVnRSr/drCY5L/b2Tdg9t9irPvxd8NFsLRwS/LTP3W3xOt21JRzvIemOdA1iFzoMRxG6rov4u6YSRLJVYsebx/LGzt7v430VYDCCOyeP2H0c+647fB1s6czXXbaSuOBCk3+JxY3KuTG/SHiUqwgW6mEhdHiAJ8l3gVFBhruS2d+I9dKOFWWOUsYeqZe2qrmuNI4Ogu3NJOb46t3JYMplZsEK0//gtUhNSCct06G6rpcvAH6LCjQwMtvYl+nMs47/T8hprR7zXrfR2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4rGQGC+BreGpGdAfHRBLUR4rMe7EJaxqjH26uQYgdrbj3/ZjveAO/6IKDf?=
 =?iso-8859-1?Q?xXs589NwLgobuOLbbULvTHy67Fru+v8ZB03R86otiCjjLBGiDCKOCCEZtl?=
 =?iso-8859-1?Q?9txQrGmxrX+J9waGwcLwCMbn/xM3Frjtx4wWnlgcFxIqPNS2CyLZteuvkz?=
 =?iso-8859-1?Q?c4zAw11NEaUZMEqfoOGwO3Sf6379wvjXHIaQNefB2s6pBU2OPJUI0/yHDX?=
 =?iso-8859-1?Q?IgFnZCNdtuq+sANKKbHV9phNVvpw5Tr6lEaHb8M9sLlXjwrIw20/eWdtTf?=
 =?iso-8859-1?Q?J1TVCBjXmpl9NqzWaHbTrXsE3STmePOpvvL2BMkulQp5fyt1ZipVua1Iy8?=
 =?iso-8859-1?Q?Hx3PVNrO/Nd4aTwRix+DjTc9QcbMTijpSgJ00NbOgbVBb7w2FxvM/AIIJD?=
 =?iso-8859-1?Q?TrkZBJ5cgtkgaa/KJK7e70a8T/9x5v/vGnCFRUBEtFTOvQmN1lDJjXsqHX?=
 =?iso-8859-1?Q?JtbGkQuRYXcYSwaUxI2f8DzyDefPYNrHHdg5QLzeoe4sKULwyFWdZzTexv?=
 =?iso-8859-1?Q?7/hQUQxEngIqaaSLOdAc0xP2AQ0mRzGHyyHfK0n0qVP91WugLHauvvLtHm?=
 =?iso-8859-1?Q?VQf+CEIuDZE+mtZ1MwomuLcbPKjZrZQZJ7P2UOkVdMMEYSGumn4yOOsgu1?=
 =?iso-8859-1?Q?7p6DOqRCMucGEeWgOBRtAbXwxqOgiLwB1LPRGPXs60OyDeqDLo44eW0aME?=
 =?iso-8859-1?Q?8vt5W1UXtlhKuAVCHY7Ew2tq+VNpoxWePgyDfI9lI7QOuO2pTEuCwCB4lq?=
 =?iso-8859-1?Q?C0S5Y7G+dCc1pMDpIk+F12W2BXYtVvL9we4ElxIsCvPYljCDIpL3Rosqn5?=
 =?iso-8859-1?Q?+QyN06pXwg5watiy7f/AP4EI+zIEofK0Cplg6rzDVKQNmjR7iBqLaTQ0C7?=
 =?iso-8859-1?Q?pxR9v6qIC4slrp/VkDkoGTNhQTn+8RpEnpMWRDpCps4I35Onr9Fc4pGZV9?=
 =?iso-8859-1?Q?+tw6sjaWiSAvmNySHjkSvyVwViAfYWYuy/SoPFz2F/mvecPjRvfWudEEKV?=
 =?iso-8859-1?Q?6gmpeyH02qcLazt5JQ3TbzgB389A/eLvKQFKVy0JyUMumiTCEqE6bkSk0G?=
 =?iso-8859-1?Q?MMQIZA7c4jOKnDdrghxkcvb5gZgNQa7D6skcPIOQlCuDUhoatQIkGutXcF?=
 =?iso-8859-1?Q?sBmWUxzfyovZXomQRjV7kf3PwI4QVnUQQOsujbLy+zcDwVaXfYIHTJJ7jS?=
 =?iso-8859-1?Q?WSRW97439Mpb1Mp2LuB4bD/gwJmvmsnWW7aBef4BBlsyfcdsuki5qZKtM0?=
 =?iso-8859-1?Q?LBAx5zVoTamSmAFXOkFn+iLo7yXUh/MSalr6N6/Ku1yR6qDXgXM9OnLtWm?=
 =?iso-8859-1?Q?JoVOq3VGd9OKsdISCntLIr4DuP6XfE9RSDHD98/ylo4h0nl5gsA5d2ZaVA?=
 =?iso-8859-1?Q?VvrFW7Tu5nWNHKiKVMfsF2+53j6WEZN8yIXJlMAcuwCXFDXzT2lw9TNBvP?=
 =?iso-8859-1?Q?H5XdvaqKVrBbvxwAFUwXmZaOP/JePP2oK5UbSF2Hl+fdMqW6+3z/APaJZa?=
 =?iso-8859-1?Q?k0ouVvvK/RhObuVewlSR4wK1U4P6kv1kpVyroYJKo2vbmIqhGWcL3KgVea?=
 =?iso-8859-1?Q?LePzSAQuxbEhSXZe5Dig5DaNhHNtvRWD6nurX253xPY3aiAOnqvNFIDAnu?=
 =?iso-8859-1?Q?u9NmItZ8NLKrgmmJQBVmwakmrWkA6VCpaBVYVvwxsoOlb5c8+EI72zgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d43a69b-3054-4982-5709-08da9040f427
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:01.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJUIrFjmAQKdMnmIqhlsTUBec2p/w50A4bBwdKkj8vpiCM0UMC9XmvzFE66LGhMkbO7TemH2lxf2nw0WFZfGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: ML3ahzyvpBEC0OJE7aAkoVjwlSgAuPqz
X-Proofpoint-GUID: ML3ahzyvpBEC0OJE7aAkoVjwlSgAuPqz
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

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index af97100a0727..682e1d161aef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1242,7 +1242,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.35.1
