Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5167151017F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352176AbiDZPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352167AbiDZPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38F15B466
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT30j025784;
        Tue, 26 Apr 2022 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7UnH8bv1InK199Jym1hvkk2fwEjzTTH0jTS9r1KY1mM=;
 b=EjScqgAjUzjRvS5qV8B8Z1vbcTXnitlkNBbGzpFQ64P/CowWhYJdCIP46g92vm2Lm22W
 +fgh8cL0CHXiorB4AWN66c7/cFmAgG7iiTZsp2JTolNMc9xjLS7OxcYd/HhGV7f7HBlH
 7mgbYFvJ/Oh4Ug4YyhKh4I1Zml0e8gOt//ijxgz8Fsb8HyUy6S2hMniDIdoSH2AR4Wqm
 BuCQQfwKM9sMzpKrcFzn7IAUiogy5VhJit7PPlzKf/uhQP/1R/qMx1TjwhCEY3eEfk2m
 LQUJftpczIQ6bRFlqesebzqL5pv34zCuXkLlIEiWxqqkuwFDtfeq0xc1o/iXc/rnXy6A ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USY037884;
        Tue, 26 Apr 2022 15:07:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+ERgwFDQ3n1cQWPlpS5pMnVKM3n6bv+gDcybCYuarALfBtEsMrmV7IpJqoILbCMwkRbdu06gBTTykltt6DitkaeZA5NkYlMSpGmjrZvQ8j133Mb7n5J+e+BXKny9FO8wNCU5e+vTjtAIupi9kM+krGxAZ+SHtnMj1ryvqCie+DVyjqh8eQsnYAERxjGSPX5LoRvq4QyFB8CbWp+kIDmfIwxmHWu7LDf0/XKIjv/jitxY8ZuluccWp77pFWrnTWNnM/FzCpQRr24qb8vohtkSpD/B4HkFKoJc7hRU0WSieP7HMWbV7nnyg65/WQNMcSwfWfTIOx3uIize6GFWLg/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UnH8bv1InK199Jym1hvkk2fwEjzTTH0jTS9r1KY1mM=;
 b=hw6Gi1Z9dVAMq8/GFop8oyYmzF4RV/zAXNe1FS95uZkJrKulgiF9weJdu7vOhZnC9MkzxQY9bLEkCAepy54GCFwkZ8V4xf70C2p/0YorC0XcTP2N9cgBxKeSoVy9I5qeOnJESWOG2zjRQW+pdaXvvnFHVCWzck7QrrNXfef+kXXygNpD14WPrH6NXBw5UdFOSbw1/nAWn/lITnYDTEpnJ4qOQL1EpP6cii9DzbROAxPhyqWG7KFFTa6Z84TEv74zYty4/0WLZjQ5CMFojM+UzjGHQJI3aCn0/6rQO6cTAT6XftZdNkqgGSk1cUTlMkpt5OHk6lmEGs3zJiISDZBzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UnH8bv1InK199Jym1hvkk2fwEjzTTH0jTS9r1KY1mM=;
 b=emRR0vFO9wYSDmsS+ZOmnlbCFqPkQj0XRDB89OM33ZgF77yMB2C99chKwlV7CloDjdZ44IX6XvjtvOgd4U1OBT26ZJQoO3xTr20SS+EJZSJwTekcCa6yOVCqO42ootY3okIgsJA+TQ+qKFFvL9DPvwzYdbMkJLnszTPHuhf5ocI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 55/70] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v8 55/70] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYWX9AntXUDDBHpkGzkrYybh/EIA==
Date:   Tue, 26 Apr 2022 15:06:48 +0000
Message-ID: <20220426150616.3937571-56-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb158b39-0dc7-46fe-10bb-08da27967d15
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB23774089D32162CAA94A04A0FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s89QkjHFHOkm747p0/Y3opsjYc5EqQ1NyLQqz10CJqOCF/4r9pTnfa19raoWMDQuqTKAudsRDFWiNdzTf22sjHgufYbUWHGIkGEUNo8mUKxoOyg7pO2h59vw1YkaDxbqFxpZ20JEKH4imBtoRCaX6Fz5mySTO8a3ArNxQ6ndjOHLar/zb3OjY1KDoypS3avOWBY4jvxQO6YjKjA0/cuF5Jq4a2A5SsSnPD5rPdD5ZhaL4M06MciHwB031i2OJnayf8ZJN2mMHaZH8vIQKSEzo4UoCCwLbbBYAWIHPen7Q11x+BCr1mJQILUEYQXZloFQuLqabZKR61ObUmf7/BvomLxRFTl4mrgFln7Z3jZ24/d5WeMjrBD69eZO1sOTWT3b7ZbaF8tXkHEU7B6Ce2TwCZKe9pvGVz1Y6QZCWDlWpJ/gZDTFHCcNBjuN0etHor5HsgIdCal2DrGz1a7/wF9fuXM3vFxgko3xFwuaX5YnLTbbebSe90ZMqtOXvhl/fDyAv1rSzjyAf+jdFhvEucKAatJueA5AIOmICvqYxVmZjqV8OkOTzFQ9WGwNgDey+95o+hPkEo10gQioyPCMviAK3l3UiZJnYYrJOBKb3+9VV7Rnpebrr7omOUUGOiEVgkkWQDbvxU6sq5K4wsMYp7D7TwF9LhC3lxPL1p3FhwdAvy6W1/Fla4eAEgQ7Iyr8KKA78yPGnRg++3lFUIQzPjCo9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(4744005)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gc3vJAeFwuY0UaIWSH757iXCtqHaY8jBW/gCXmaoU/AwbxY8aqB+/rpz/O?=
 =?iso-8859-1?Q?53aaZNhL505RXOTuE2VrQxbrRtvtaoHKPvN8kUb2Gp5VUmM201PGDSYNen?=
 =?iso-8859-1?Q?1ehXIzKWgChotstMRRqccVBqohdDpFB+1yZuAOIMm75zV3nOAQ/hNaXJu4?=
 =?iso-8859-1?Q?wK4lyJrHYUFmdZti9RhWUXeqb8BUfBf92yaXSdqGmw1hhKmqqrDI3A7+5u?=
 =?iso-8859-1?Q?MMki/3XsFxeSDYr8pgUqQivXAavv3PlpkB4qsmJsybR5pnVgs1SLsLSD7P?=
 =?iso-8859-1?Q?mqsjhzKVJGQyrneSH/Z46NfbO+ik9l2qV2dKQZYg4ZzFeMwv5+dxo51LCq?=
 =?iso-8859-1?Q?POviRgHgAACTPYADDY3HuxclCN9gMn8mvsW2p9ZS7HRp2SNG+boi8Wvg/2?=
 =?iso-8859-1?Q?DqPL6KJcBZSL4P2DU4jtzo8TKzjF/+BIOXT4mhVthQxLXa3hz7pxTugbvz?=
 =?iso-8859-1?Q?nHWRq3xs6+UP/p9jmPCvxk8JYuCjZlSKTeYP9M2YA+qGrEQ8TGTSoANURp?=
 =?iso-8859-1?Q?4Uqbisge5UL5Ce7WgTg0XHsBCEmzWbNnqT4OYuGs2TwIDPSxhe4IhQMPV8?=
 =?iso-8859-1?Q?EzYeY+V3kuW7F7atabDrceHDa9ssjmNioScrKezz+WVqRomv6laNOhqd9v?=
 =?iso-8859-1?Q?1dGmUmgf+rNJF4qEBVvp2kCe3CPx7RnkPJsKjXa07gNqxlx17m9yVOaYkM?=
 =?iso-8859-1?Q?YyYg5T2BnOJrroiH5tWKf5G/0HYU3CoOYxcm7pEGm03oiZrIB0ffNzjm9x?=
 =?iso-8859-1?Q?SyVLsxK0LQRLcXMyM6oAj52eQIBEuZ4nEJFwV9Tya7WHgRZk8c99An6hBN?=
 =?iso-8859-1?Q?86VTleR4qw6xuzH3bnXXVFj8XjKL2Bt1nS9AsDY4ZYqzy7jrAeYfygchJP?=
 =?iso-8859-1?Q?jkZtZAlUBoCUwnYru1daRWsmfWaesLKQcRvt0f2eWpzARFI9nLz8C3Q+yG?=
 =?iso-8859-1?Q?lpgClpnGlLJAS64bDUGIzia2EuLfyMNLsanMzc4xK5Ywjq7Rr+rPO/87yG?=
 =?iso-8859-1?Q?UrgJCu08pIGM182vqnV2dSeyIZKoaaUrR4s3C/VFIbJA4Q4ZoN7ezWB0wy?=
 =?iso-8859-1?Q?RsRjRD+Datg1mkY3T79ZU0FnoCugj6Avlguu4ngSOfGpMzJ0vlGXGfw4Wl?=
 =?iso-8859-1?Q?6rgpmQHujgjv3riTW5roUBtX4+fUKvzl4+zorH1GPCbzI3mc1NcwovwycO?=
 =?iso-8859-1?Q?PV0VAC70zpAul+LQQe7aXxaD3jg4l3tZNS3ZTN44I/jgKvuXVPMJl0pcAt?=
 =?iso-8859-1?Q?YccG1zYuCJSOmVIpBu4917ijQOohZZKHSEaYbScTRQWS87wY2qQy4IYVi3?=
 =?iso-8859-1?Q?iNyQjRlWtSrc+KZpCCS7346Cxmg8ZGH4QrA+Z+RGmlaIpE8pWonwf7xevH?=
 =?iso-8859-1?Q?XCWzX1Q6bwdS735exEwEeNChMYRyFQ9xDZcfsjlUdmxHwxL/BpNQeGr5U+?=
 =?iso-8859-1?Q?QA2OHtdQCCKk42m1mcG0AKjldzZvvajqBwkltOyGZ6Ryi4qTCEG1luK+Ie?=
 =?iso-8859-1?Q?x8kwMuyL3OWNcK+fQtjPLEVRCEO3RshigwT6UhDGdTyiA+Jr5HYqrqeGqR?=
 =?iso-8859-1?Q?+UGCL/wOLvVtxNwcs3rKI9hPT02IypfkWVeLooQSbjwZ+TazA17j8l/y2I?=
 =?iso-8859-1?Q?5mQj5CrH1WiLDQ+wAVUbOR1TQ9K99xvx0ZBAgKiwh90a82y+R6fU0jcthc?=
 =?iso-8859-1?Q?lBUafg+KOEFZaH7bpZXxTgZ8+XujitOjV145qyAogxAqdXo+eKSw/5ZROG?=
 =?iso-8859-1?Q?u3MHgLX5qrLgDdv1RMU+7sPeLgTyv6medLXIARKjodytsSdYR954x0DSoG?=
 =?iso-8859-1?Q?jNw2GcGpPVZGi8SGoT//PAlGvyUS7nU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb158b39-0dc7-46fe-10bb-08da27967d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:48.5361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXTsAeT3cuKxGCHks4FkxgYSjbV/ma7l7iIRFhqpQDg2rR5StWIrPbfZVPMsLKtf9yADS/tPQAiOV7zqTMe2OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: YlFGNDwSeQH9fHKfoCpNcs3pkfBGZ-3Q
X-Proofpoint-ORIG-GUID: YlFGNDwSeQH9fHKfoCpNcs3pkfBGZ-3Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ec03a76244b7..1c943a7ddcb2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1232,7 +1232,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
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
