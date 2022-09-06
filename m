Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437095AF4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIFTyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIFTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F77A745
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdbZG029984;
        Tue, 6 Sep 2022 19:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=p2lJ2HSls7Km4rN7jyDt9noc6tX4Q1Eu89vN3wO1SNPtsTNUCH8o+B5P3dEHe+X1gFZZ
 aIALHL9kxYbB/FjRsgWWGaxYyxy5HA0KB9xo3xWiHb82LEoQrEKya9+PDMBHCq/wvXo5
 kJC8x1CauLFVO09HpzdhzsFh6Bh4aR0buubwKnesehQgsXXZy5lBotUoBELf8iTYJgom
 WbLAtwC434B2lzd0/Rq/pteFS/LieZpAIGFFdpkyEmDhM6E83mHw3QF41AkqpY4sNF2h
 pd0oOUfSqrDyHU68rULx3kQW82IWpxpWwG2jo0JUK2YEhE1T3veZWl2N7Pp1Whw4R9kB 7g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H2KIl031383;
        Tue, 6 Sep 2022 19:50:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajns-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZ9tBrR+Oe/Rbf0J0g0LDrAiW4JmSNukp9VbqCuNkFgusrnkAhgSlLLf6ZzPmN9cvrrf9zOA+mRFAq6fB5vAudQEIojO4CXDi/KglUGLOHgLrhONCE8IV403uN7Hz30ozCQHO2FIWnzlRZd4DNiR2KmqRJo5CEWa2RhEknRw3RRKd6fG88iNdzGxL4cfMHLwh6XYkmLfz3oFPqDb+UlCjl9TuhYnuE6qg10l2qBq6E1fzSXqgWx/elgvb2fkorp8lgkVNjOtE+w6aLa+ewlVhtXnmd3S4nQXWxjWXCrSiN0ioBM0tfli0oSJV7nucqF8HgEygBQ6YOBefJxovzmeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=LKItMA5ZNqeaHFFZdZaIqnPTS+nmpG5SOxR1LiYSY1kXRbefnnYASWLFz8awRbS75gve0wAUqmlyuYBuE4UcWy0horBT9Dw/Hq6yhuiwM3mx7pPlb/sNUt34VenoYJzUp8DZldXJf2SjJgmsArHx5GR7qmmVnFmViGHHn1YkxUs9rAm/Qj8ywOgmXRHDrnU7crccrSuQ4jqQLIdD6gXaITJR3fzm5o+HYgtp33lwOzrkwHcQGwAZme9vsliWVagveuj2VveKHbY0TqLpyH8XRmRYk3B0Gj7o12ZfVV81wwbubAmcdZw8gP+AZXcxw+Shx6zs1z1wS9YYYCaCeGZ95Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKIxAaGaKnywQod4vZUAAWKuSFE1MP+cvJDK2c9ropg=;
 b=yqfEsTZay1WnzPdYwU3HpU1kCDvb+TbMTPfLn0mc9F44zpFt6a9aRkioDg2T/ehz2qCDdWyrpabi4t7athr3N0q61sJUZmX9DTVBblA6M7cK5eAZ/EkRif7d7bkfUEe472lBbUEa/lgThEfHKW9UjJA1/GAFids5XsfLUNdFPAk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 62/70] mm/pagewalk: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v14 62/70] mm/pagewalk: use vma_find() instead of vma
 linked list
Thread-Index: AQHYwim3D9/zE62xcUu1amnoDHK+bw==
Date:   Tue, 6 Sep 2022 19:49:04 +0000
Message-ID: <20220906194824.2110408-63-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea0ece6-b113-4cd2-74c3-08da90410823
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCZvaWqBw8jg5Y0018OF9ZdTB8HIGA4lETeDgI/PrkwLh4j5uvjJA3sNgr/I78FGmTMimKLfT5BhZbwaOSIhOcMl+HBISRY45P4BD06CDJ7KE74m2zqqLXWPMzvNSKrIGQdn5of3gFFsnNmjlmd5lYu3pTwI6SVVQbHdYb41A7CxHe8VQF1UHeP5kcqHAJj+RPwrHlywBF9O0Oj++5e7ssZWyRFMGmvrBazIr1MbKH9d4HTbEuefoZgoFkGaLrzwf0cwhKOoN1V01kGObHALKZDAlr3hZoE47Hh9mbMrEcPQmeTbHu2o/v9dD3Y6yKD9gLPKG0QfhUGhnOEqEVFb6EE4ewhHG8GEV6WSzG1HCRFgQIYaECKx0OYcTfKRd3Rx7ny4XSMfnhwUlItgR9DT+ECUhHFOu0IRM+LgfMrILx0CY7r57eRqyjh2DKzDMB9KT1W01IRPjjgWRRsV8Fse9NQZVyFbrB2UNMC1LkEh6n4U1YSudsXjGop8G/N5MPwIPbLvjv2ijKdQof7RbMJhRq2ad+2rSGsLV0LVWBeZ7DYCth44ObhLlWOMhZjp7qQOTttwaXUOefQRtHmML+6y7dNExAr0ZNBptVbMdwNiBN15CoOyvZacVHCa20gHrfvCbZiOJWXVAAG5lGgmanujdIjAWAI4t5YSMKzDS5vv7chUqB/3GMtKG0AcNpa5Z8uWKUFJSypriIExkTkZM4V7RdHkATC7dnVV4p0IDvtb3blhysmKhxnPOGmic0CoyrIwISoGBGYufUZDGwZbwRJulQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ds5jMVa3ZZ2Dz95Ia503960VhADzvve4Q1CsEDM9YgHOuE53fsDRmNPFui?=
 =?iso-8859-1?Q?yyLos17KaVI2oqsVgtjzOf5ZFDESG2gPpHuReDivo0YdA4fHK7Qx4Psdkl?=
 =?iso-8859-1?Q?hxcMiIMTqFQ6zIFT52bVhj0v5WP8iz8ftfR7JlU+bZEWbZ+ADSwnM/Z5Ij?=
 =?iso-8859-1?Q?nqosbIiIJOgvnZUS25saHVUOrnWVrJiQSnfNOeEsJc99l3Y9pco4fS+hwI?=
 =?iso-8859-1?Q?eiRdQk3Tu1TULUKvRy9WRPWKkpSJ3ClETuO08OPrCwfMXRurzrDGQF65eE?=
 =?iso-8859-1?Q?6rDLjaGgODB8Sd4C+fBRIf1Vl8cNyxckbAiiYD+DvMzsIPq5csBnhoEqbc?=
 =?iso-8859-1?Q?mKw0MQ5u6qkmgaFOJxBJcMWocMIADSVAUs8jfvgRn8HZZB2qFp23J43FIT?=
 =?iso-8859-1?Q?Q/ul788jrS7DnoQTt1Yd2YY3pEdW3DkAvWbblIHo2y/G1rUcdjMz4ExbJ1?=
 =?iso-8859-1?Q?BTXhRrldjX/SDe7w0Bx9YfVWnkDthgiDlHFXuTcV3gTvAHJ+ssH1TxkH9b?=
 =?iso-8859-1?Q?MSx52+xKeI6c9p+q4AGwZ61xEXQ6yLo0NPvzs99gzB7l/7lGnhLL5w9zHb?=
 =?iso-8859-1?Q?+I4hEeJw1Z7cWlVk3j5if0EDb7lY4GUAMFWVm0E4YrbQn6Q5zC2ezzQ03o?=
 =?iso-8859-1?Q?lO9EsWxn9UKmLB7goi/jBF90Q8wikLzmVkiE4Rnhx4nrKy2xw4E5mtIzX1?=
 =?iso-8859-1?Q?206cnyfi6BNvw7siLufRro8RDz+rRRdhKJvlc5XOftcUdEsDZmjFPIZqS9?=
 =?iso-8859-1?Q?CD9LUpVMmQEqMFq5RXOIZe/lIdq3YAD9fATL7IfSHOLhRjS8unFcvpPY7v?=
 =?iso-8859-1?Q?SNdmYaPc4/tOzfFPx2m4p3pWKVHVZdB8Cdbl4FCnFjkX75sbu9RgTD9j9z?=
 =?iso-8859-1?Q?NetqphLQ/AkJq71fmBDlpVAOKZtqctbbRzVNd7TEW0ikzgLgpjbH/aJ9Rk?=
 =?iso-8859-1?Q?YcXIk6gX7yt/QVyLMQQ1WX4Epq1IE1E55w3SQRufM+BGudl8QYa7naJw0C?=
 =?iso-8859-1?Q?kdDdLsNpAbkHHPJmpnkTsuh0ky3ZMT43h5/hCKq6hPl0J1Qg9Lg1kLCCx4?=
 =?iso-8859-1?Q?06Orv9tvliNvNE87uUWqjhcVJar7Bv89fUmApro5KRrgcURRYgDzqkBOCb?=
 =?iso-8859-1?Q?OZ4URXkJIvC4TkN73WGVgGPjsmSNKEyokAjDa9l1dwW9Fo8v5q+eN5oVpj?=
 =?iso-8859-1?Q?GZfdWRmZYP/j6UdluIxsNRC0j3YXAykLmQlW0n7EcWb56x1/LQqIUje8vh?=
 =?iso-8859-1?Q?6wzhg3sYxhRlskV2Xi9pS94grCPYFR+W1Fc9aLEzaotL2FsdvUXCWysNOS?=
 =?iso-8859-1?Q?dOIaVobxUFybE4ig5sezMny70d/E/vjJh8ROqUdfA00wBAKg0bV/ngHeJ5?=
 =?iso-8859-1?Q?DYWKU4rHa7Wt3904ZPu11+EGcljf2Jic7UkFMero9CR5gk+N4MJllrWNcX?=
 =?iso-8859-1?Q?UD5QmDcYOFHGxDwjeTPkqTiiaXIFeDQZFMu3EGuuWQ3nActxpoV0PKXcqG?=
 =?iso-8859-1?Q?6wTF40M8dKWtfFLcJRJdazISK4FwZcUTtg+PBtlolmaY4tx0KKFUgRXig6?=
 =?iso-8859-1?Q?otNApMuJdkmyOxe5irGvTmwHdONjA9fn/pByeII9HgBVgCiK34PKz0mQWk?=
 =?iso-8859-1?Q?dMhLcdJ0Xz8WK5ZIbP764GZMuVbhuY2jsBDF79S4ECqLKbofE2E+3UKA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea0ece6-b113-4cd2-74c3-08da90410823
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:04.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKA+xHy8P87ZWrjlO9oMymlcYe+Btdryihfj/qRWjQQXL2mbwLa+VjKxjYD0r9lSoLpt261Kk2WqcpAel+qHYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: CjqNnM_km-N9AkEhNw_Qj-JNHOaf_rZK
X-Proofpoint-GUID: CjqNnM_km-N9AkEhNw_Qj-JNHOaf_rZK
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

walk_page_range() no longer uses the one vma linked list reference.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..53e5c145fcce 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.35.1
