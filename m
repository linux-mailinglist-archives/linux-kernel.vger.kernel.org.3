Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06547553BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354204AbiFUUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbiFUUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0423BC4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ40ok018707;
        Tue, 21 Jun 2022 20:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GVCpNg1Q3pH5ZLdQQiN72q/nw5O2eBquU1qEJ55Bl1A=;
 b=YtQrDKBbN0nFtXvf5u0+h66t9vdMsAdNi0bcnJ5UHqVJO0USCqssYpMnF/yiMePz06tU
 hh8kazYD2aDR6L5gq+r1TszSjy9RjI85d9yitRtzIjgl2OFKc/OJex147ykbI/YALsoS
 bdAlxk4X1eLe2/T4V2OvMr+ohRSaMHzswmfo+q0wzZQwDWr+dhYjM+5u95erm3ADFCjP
 VPgoe38XN5CFZsWMK2baHLC78WZTzBasshhYceBd+OuQq569lgt9To7uly8GHNaIcZM4
 oH1rot8UtSTcVtApTsc6CC/u3GP/KqBajMpvMcvi0q3FU61Qt/LvUKf7vhyELErjY36F rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeaMY010747;
        Tue, 21 Jun 2022 20:46:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkghq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQFqnzISWU5+mXiyohGz2r3bZv0SuA9YCvKStdkA9CWOg1kMdPSFyUD7yeSMbTP2vHt8Lchmjt2Pxzo66/F5+BHiDj3oEYSNjwMD65vDHwUaOMTUwJ+HxsO6VmumarYOnAfyhXM5TWc3UJpCXQ8BXE26frpEFyjEh9Vca8XxxQa+zMZ6mClznICgYWqBdJ3QqtVVvM8h84xwfjurD91nQEGL26yGUgcmghzPV2tFmdZF8qEQKDkOVvx9q5v9FmP+ovfZS5L0nPVzL9IStdQUlp/xFFc956WtY+kBgEXg9PTBssEfkI2vrbxhogDHZO8nxg47pyolaoLSQfaFtOVgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVCpNg1Q3pH5ZLdQQiN72q/nw5O2eBquU1qEJ55Bl1A=;
 b=K1ntD/WIqJ9CwvyOR3XaCyr7Scp8vPYmNixnp2E9iAjcLgQRh4Lc65OiHrz8utSaiX9MDlcLdgzJ//wOQPfVzWp0Jw/uPUxxM40WnfNXpO7WSSbUGuQzz+MG9jiXO2a3Tn7A6j6tJKJ/FAuF9gqoag7ZVsU12UazXIHNvYa6FPZnIsebwOt+/mWf2agDJD1eOuTG4OdE9DGdZzTrztviHNg+6sO9lbSpIKFL8ZegRdWJ7CbIokffHvhzCc9P6GSOJ10ZgTymgz1QsJ/11kJmFRE7dB7UsBLl1MPwTTyID66s0vJIlY+C+1Q2dZW9I+M8ftPhtyA2XlvDu8agwtYx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVCpNg1Q3pH5ZLdQQiN72q/nw5O2eBquU1qEJ55Bl1A=;
 b=C6WCTM9lcEEHojzv9CiwLRkXV3I8mqKsnY7gy/Yb2rTc4gYK2mZ3/Hxc6r3AJ5jWjq60i+L2cfHkqT/7lurhSjriR/Wu9l8GbBXk3SUST8AzGf6GkM0m7M3uwmlTC13lQt91ar37KLFDT/sK+91tPnihxCkmQX8XdQz7fPfNUOc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 02/69] radix tree test suite: add pr_err define
Thread-Topic: [PATCH v10 02/69] radix tree test suite: add pr_err define
Thread-Index: AQHYhbAGLzbuJApaMECqFrGqwC7aCg==
Date:   Tue, 21 Jun 2022 20:46:48 +0000
Message-ID: <20220621204632.3370049-3-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4fab857-e4bc-417d-c056-08da53c7297c
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3074B5B5A3BDC4385D937D59FDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2cKD9cnHjyWh2WOrJih4nrmdZRSJscAM/yZ21iuWmDGdVWtfTLM+biSa5h0zJyY2KvX0OdWJnCCIDmVbZPt4Gg1VdrDyrnoGn5pcAYGqzSKG803JQCEa9jOCNldNyhEruEKMpqDDLrwBTo9fLnPLMP8T5nV9kOwidgY6EX3yKLZ1sWsOXsZ64GC9PpoiREGXl5Fl7VUDpCjzZ092M+u0ajbYuKWx0q2OumZO2O9kTJ2v/1Ui/Qeg9jk7U4TUyYEkz2c3EKRXp/CQ7wXUHyGbOErEDtF0Uc7Z5PR3ujcFlsEcqhL1wNT/SCdCEnkIM7qBPIN0eucB4bPU5zn0+ioYB0W9p2haW+99Bv9kL14g+n0Fl+AtHql9cuAKDOQLG3aNMUKc7hilUT49roniKA8kHRecd0S40t1Zuf205WC9MapyofrqPcZ33pscB2DACZ/7xuaWLaaao89hPHBbTHT5GKj4BmwmqSzWPw5Nn6d04Pxvaon+uV4EPFir59a2dGvtNQdxZfzXTnI5F349bYsrxc1bK3jASvltpGj3JFmWFv0PJMS0ivip3fQw41/nxImdmNpTcBB3KfYwwYB9ouX789udpMF5SG7ZdHe1AY2qfTHuYk44gvGjjKclrE43the02dxKN7bFxYjSZ+EXN0s4UU8sMPfnYCGGG1CMH0hK/81Lah9C7iTkP5qBO15+muYLYwSkNMWfn4u4EQpfeDZHYTlmybNirMos5AKyR9llAwRbZ9sYDUyn/twHInvVy9erlXiwyvAyuEtv81WhHrXfxkOvldvvS6NRAo/PD9bjslpcerjbgMGE24GRSM1yrYtIkx/9zkyYpIIBVYo1Tx0KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(4744005)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5vVARhqQI16GnvC9oSebplFTF3ju1xac1fge7q4gFCX02LAXyRkATnjPe1?=
 =?iso-8859-1?Q?BBuQkZWlnyDyYTCCTA6C3OpyVW/D68HbkUqI4hDohtI0vBL0uEnNGFDbSV?=
 =?iso-8859-1?Q?7Xp8PLdGgGMNWBVX2hNOXJwONvA5RtYufdBiXA/+ue7jCgfkPEFFXri57E?=
 =?iso-8859-1?Q?BVHbFit52PzhDqogpepkDhq+KfTx4u5s9VB5ztSq4SnzePIn3tPAadAhGh?=
 =?iso-8859-1?Q?JjMZ6H6rYjFGemfZDfAroVEcpG2APJgsG3z/crnyGXp/8bRTnGEMZQEUaw?=
 =?iso-8859-1?Q?dQzbdVOuIjcHVMV3ui0cX/7pE+MSR+L9XWK7n3fuEoyv7Bf4+IZLB2/vjw?=
 =?iso-8859-1?Q?BS/0qG6xRcsWSWry67gdWnL75GVvEXuKOGwuTICvL6zRdcxMODc2mG2dml?=
 =?iso-8859-1?Q?3Q2R12x4zkBoMkoFSvc0Fw11sBrz+agbrO0hVtsG7rzxo7x87YxpB4AVsq?=
 =?iso-8859-1?Q?0IlI84K0VrOUO3vEoFx1mst29KRmVTd20/DEy8FwseVXhyJAL2w4WXCE51?=
 =?iso-8859-1?Q?4OFxNmTlQfEiaU6uJ9q1mqmbQ8lo1+0FGHMCXWe6mHfMYUR1l1tNnjci5q?=
 =?iso-8859-1?Q?OALtyVhtCh99qS+vK0Ceu+y1X/Z1z9IUodLYiYh3RjwvDvreVKxSL7kZ9R?=
 =?iso-8859-1?Q?Tl3fTPoe9uSMMyV9Gqymt6SxQw4AlA0+5hOtXdLuNkAPBpOcKoQnC6hcgv?=
 =?iso-8859-1?Q?NSbkqxxUQ9+Q4T37Lmejm9qWajm52BNPfQ8KB1Mil9Nl+0JN1TjWayCkxf?=
 =?iso-8859-1?Q?7/rxSQ0zJpA/36FLwcIeEZl2aMBTzYPntbmq0keaJ55f3rZqGvdJQMxIbk?=
 =?iso-8859-1?Q?hu090TQujgWFraVD0f1vhPHd4bVP67Xt1GIlpWBVgCBDduz8wQkYmga+SZ?=
 =?iso-8859-1?Q?icgAFjp0n9qJDeLmDiqDxwU47AsGn4GE08s+KPhi6xCvWALYbh4/jBvGUt?=
 =?iso-8859-1?Q?fDqKdbcv1CE7TwkhJZi6l3ZvL8ayOs0IASaRVjfMmqzJBGixr8woQDWzmP?=
 =?iso-8859-1?Q?V3wYluU5E2txULMgJzxkh4jM+mZOSwAtRpZGtFx88CLCWrLgbo8S9+JZvJ?=
 =?iso-8859-1?Q?OJz2O3yDUQdmDi7GuA4No1n71dZSCPRRpoaIwxT1ob40WB2jGoy3XMOYqZ?=
 =?iso-8859-1?Q?ebE143g5VAyasCtAE4aPuQcvlcMyJYsSUHx7RFKvzVwhapiceQJBZ8KcyU?=
 =?iso-8859-1?Q?MrbLtWZBhaxCvK2tn24WhZx1PPlX47qMiWAU93A4c9dECnMW4gyrSE++Ei?=
 =?iso-8859-1?Q?J2zxKy5y9y+GmCY1Pvagw/510SuurSgTt5Sd7iG0aSDGOjsz4ROlHxyFEs?=
 =?iso-8859-1?Q?Y2jsT80MrtiQChg2NEmokgSwNgRNyeQ22H58nsY7B6xv0mlvcCJ39KzG16?=
 =?iso-8859-1?Q?tHpB3iqHS/RJ3WDRVSwTiGSH9cwJanqlbI0C4jgNqznCxoxFrfwBABTZRY?=
 =?iso-8859-1?Q?MKm0fNSQoTtZxVWhcjy3lxNzAEblTt7Y4rwwkslPKea3N9QcdZWwBQ4YAB?=
 =?iso-8859-1?Q?Cb+NIw9nBB1p+oJErjxDrBWlDBAyb8W4ppWX6YcjfR6OLEkvExjPQBqxB3?=
 =?iso-8859-1?Q?EWv2P27hxbL/rmIVI5O+150YxNGtxP0Rei1l1yrow5Com5SHYer8c7J3rV?=
 =?iso-8859-1?Q?0T7q0/Ngrsu2yVUrmD5CuYKwx2qqsFW0y5XGvIvU8r1IwosKxgvaJ8CR58?=
 =?iso-8859-1?Q?EpInsLBNFcrSssUpNepfo5MiYivl7l2BQe6CSOb74ubz8BDrQyRQlPPmnH?=
 =?iso-8859-1?Q?iTgbEWtQzXAZgbfeMw62GqgiKA7pTrcD9EVEsBornmC+uoSsn1F+IPZz/3?=
 =?iso-8859-1?Q?NgG/pshXUgtA2j28tN+jQkHfyo6YHoQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fab857-e4bc-417d-c056-08da53c7297c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:48.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyQ1w8q2/WfYcBMJo98Czkcmzr3TpNxkb4fu4Z1/R5mLP+lh3vFIPHNTwWBpTo0X7nkYAJrTuQZ3/32OylTApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: ekE3cBZp3emMMbvh78nnS8aBFY5Om1ZF
X-Proofpoint-GUID: ekE3cBZp3emMMbvh78nnS8aBFY5Om1ZF
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

define pr_err to printk

Link: https://lkml.kernel.org/r/20220404143501.2016403-2-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220504010716.661115-4-Liam.Howlett@oracle=
.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.35.1
