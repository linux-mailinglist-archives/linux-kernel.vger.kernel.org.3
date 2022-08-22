Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A6959C2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiHVPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbiHVPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:36:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC831B783
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:36:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpgmw016424;
        Mon, 22 Aug 2022 15:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YFPt9xDGa1fVfHszqDEoe5Ni++lDRd3bZiKc0xfhDk4=;
 b=r0Cjh0hJyrJygab7BZyF95ipedWsTT6xAC+PN0jrF7oE/O0isl+4Y/krxFmnr67Gb4Mu
 S5xOdWuj4xozrMb4SmzRq0VCvPUurdge7tq1D5dmR6QZrEr8vbFccTP2iXQsAvb5oRgS
 QmaUGncCCTHgDsVr20nwDkIc1PUE4/zUcCsVNU/R0fWrfJVLUM4bNREmj6PShBBH5leu
 4zIS5hkyn/0sP/hU9RqKd1uHMVxIVnyVkCKOcNdeuk9vLH6TG7UfpiauSD9GB1/GIl8u
 dRZihWk2hSQ96vULAr88TRhEu1DWplnJpeKyn/EPuUK17qNmiuU39bSwkAnwfkVPDbGs tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nae031868;
        Mon, 22 Aug 2022 15:06:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUIunt5HIpBjH4tZYanFuqukMUfwSuIdk2yhx1A5w76k0rCst7Iz31b3zym7IkhkWL4gebVBUQ9E93NQvfaSBLDqBkoQkJpfilZOYut5fHulJiSnpq/nrbOrVHlE2Z9Y+XCmIbizef8GJJ4+PiM/MZoolScYCAkMNL7bhMMsMaSrHYYLsDMxc0Oivg+5zgfd/9O2KGHnKX77PdMCKTpQNaplZVa6/davZVqcP2icue5cauzn0rcgFkq0NAcX16GSqMekmx/wtjVi+wtKP0uetiR28wLmcZCF6v0PVICiGn7jAArb0EiTojA0I2UClCUegXnTlbZnvqSjqkFNoDRsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFPt9xDGa1fVfHszqDEoe5Ni++lDRd3bZiKc0xfhDk4=;
 b=CV/ylY1/ZURtdJ06URgjoPfBxCoRjtY6MQ9LulTAyVW+Ywi7QPEBSPmGHvYn+Af/jYAjfFcnWTP2GQKKN5OOXqfl6eoraE8kfSnvdkqJhWAROnC2BYTHVYlx1pjDVq2zvtuSMFj3e+Yg3FrcVsSjPrNRy1wBHbtKTHy4BvLI/wHIBaeVSZvV9F1/NGbmR477HU/9IczqkxsgGBJzykLQsvAELlTLkPQwtaBMCacg7SehcXTCiYr+5mJ2Wry/YQgvilSMHvrvfSDXB1+xtrw/2voy8HUl98SK/WsIgVuAGYqM7EXDAww+PNhgTXxWQCVE503RX8ulKTfWFpJwnkjqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFPt9xDGa1fVfHszqDEoe5Ni++lDRd3bZiKc0xfhDk4=;
 b=iVo/TCmSCxinftdMB2gwXeWWs1hetqUFtDH7lXs40YxR/qXjACFiXUzpd2EKOXcdFjUtf5C5FYXms2jBuasOOxvlv6wrtn0/P4l/myaJcE5rjkFWvO99l+5cZxyt+i56Wme0Lx1ifjsRcTe6zgsOVceFnJCrjtmkw+9/zTEw45M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 46/70] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v13 46/70] acct: use VMA iterator instead of linked list
Thread-Index: AQHYtjjAjWySsyrSK06scBybB6Zi8w==
Date:   Mon, 22 Aug 2022 15:06:26 +0000
Message-ID: <20220822150128.1562046-47-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe533d6c-05af-4aed-f724-08da844fe3f0
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Al+z79qVjChOfIP44Y3IcdpwPs2+SHns0pjjsFK+CQ2vYWd50wW99WVzuI+l+X6XmU+vPEOXkBCB7GpG17GDi8437inITO7wDaQ0LlqQuw7Xtq+zDghtPErZn5tOGifypDJAa02cJzONzf+6ZB/ZEe/+sMTyFytjX4hkvDH+4VlxeQIku/d7qAck6oEL1IV0aO7kIPoNCuo8hz34nZuuP1nrSUA+fUVz/KRONP7MSWbN64Ob3mtZGHKtGCNZmBEG8HsBY3HM1afiZUJpEL721sK0b2aAtz4uHuMDvhbQq8gVR66dYubtEgagoui+KHesT8Eft3BRswaJZEg3HV/KimhRUnCZPAeYhvBdPszhJveCTGZm9oMrp9kYlBazq9chw6V6oYINfyBJws/I+rYDVm8cBp+fPhhODLNOagqOzICA0Z+WRMSl470obGJC2CjVZk1QzWLhVdqI05GuUwbhGfVeEtR918gR0PPk8pqD//BICPat5d7UgWZpQ/77dePYcGeGm80QNfUjzkJJtu4S3nmpCqDYja1Go5mI0entIRwPo2wgXVnHWKIpsA2alc1vj37qoCtP0JknjYEVxa2IBHSX0uAcntc8omWzAH8DRGF0/mbFVntHLhBxMU9QE/n1W0wjLmxC8yoWkgSDX41L/2cEeEry7T0S164nhizViPE19OOFLJYEVYzM6SJG0F9UDf0J6gtFEdjT3YwPzi2YOwRpaMyblhBzzAtXK9PwCyH0t+m453zhaJpr0Cp3BoaOpjiJyEaTxG37XZKmSV2WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B/kGGdvRvcHdUpBZnFUHD1Ym5pS0SKAsp0QJMhhKkIOSFosMGC1vxPLDg+?=
 =?iso-8859-1?Q?cM3Gyck798RF7AldZvLj4HxsZQljYrCkvSt6qWg0chsKMWj4ZBi9KjizH2?=
 =?iso-8859-1?Q?y11M4O04b1pSWxbuTVv+aKN9VEZdy4N+u88WbiXA28jwGd02Ho3152NkFH?=
 =?iso-8859-1?Q?kLRCLQiO06yAx8y9YK1zRleb546uyg3IZu21oQkVyij6mDZspeye0Z3UTN?=
 =?iso-8859-1?Q?qk86dHus0FpLYlQYqVQyQZ09ocnB4x7tYqc3a9+dH7csFO8EVBMTJo7dw0?=
 =?iso-8859-1?Q?krZCVn3lj6TlwLqsej1DOv62T4cR9C1nyZWD78Utwi15RvL6I4wgHPHlwR?=
 =?iso-8859-1?Q?p6HEUJo+UBVMg+jMHkIjbiLMsG5Y877B5FIcRV+78WT8uS5hBvC+AMHop9?=
 =?iso-8859-1?Q?g98dCb0RKU6VNu0ZOGEFnuLoR9rsJz6f5eP7Kk6mqwcyIvSLihgmBvQ9tR?=
 =?iso-8859-1?Q?DhRnJtES55IfmxQ3fe4VDJ/yraDallPx4A3sBm7mOyQmV7sfwFE81a2pta?=
 =?iso-8859-1?Q?KFXBR0vPvQPq+ylu7Zj8OwoPs48zXeOCHXKRpqfAK3ZPDtyl8T71Zs2mbP?=
 =?iso-8859-1?Q?PeK6JXCFExuEinPIl0IyICkSKhLZCjB3cJBxaPMi5jtLUFeTqOKVWsEa7Z?=
 =?iso-8859-1?Q?II5e2mEA5hbihtX3ZuFlzmESJ4L6o11Luyt8UTZWMPu8xm967V2sNmkIsZ?=
 =?iso-8859-1?Q?YBLSkyGr5x+VyK0pPq08ufzGOsslAXrFLW3k+s406xlyRsevxPw8nj2Bid?=
 =?iso-8859-1?Q?3NV7L42JquT90kGSo6hGnG/vMFHou2rwOifEjHkzzZpuWJs56qHN1HtMFs?=
 =?iso-8859-1?Q?b46qAVtRh1wfJKaq6cTBp6U8U6N8tl1o2MC/jWHW3p7Q1i5j+IFFz8aMHy?=
 =?iso-8859-1?Q?3+VhMWkONDESCMRe4O8ua5pcf0S3kKjyKa6vzr+zgTivYuvqrNQ90ri4VA?=
 =?iso-8859-1?Q?y5V+c1sjmCusKIdMDmJN3FaX0LLHAmDx3yDQ0dfycl++bVGp4tQXlznDyj?=
 =?iso-8859-1?Q?pKyIU6JF/p2CsS2BS6pT37956SE4YOLx13TVVQJU9S5ACFapWMm0/3UeDu?=
 =?iso-8859-1?Q?9kw1u23UBUayCHccCzthiOmZpGR+WGrRE40sQrC1x1Nw/ixJ/sQy47VmOu?=
 =?iso-8859-1?Q?nJCCeOlcSiA4J6dk6tA4mhQexB+hLiTnycFue8oX3UB+uiwZah1T08xJHD?=
 =?iso-8859-1?Q?AG0OvGnErafsKDb+n6+Pku5uEKy8mUC+sCBOkmHaMhr+watitKNuWU/Rr1?=
 =?iso-8859-1?Q?Vbk/FhS19xY2LkfGsNxJb/bkIQWJKdugKAHSL8r5begskrzvXX9byB/SDv?=
 =?iso-8859-1?Q?/rLrPY7bRn0PFgkADVyf2e7rv5tarWCWSlIM5K6o/lskKWgGGiplz/UBy7?=
 =?iso-8859-1?Q?X/7FFEqGywAIn4V2TJh/xZCjPLzcVemfSU6fZwD6kJjQKj+x4XssAg9BfV?=
 =?iso-8859-1?Q?4Ok05amXgy6116MvpyXukDHWASQxQxReKxOoIs4MHOza1cya32xPXCJqBZ?=
 =?iso-8859-1?Q?qRbJF8LUVP6Nn6HDago45uGU2rj4OCl+svIKEjK9IrybTOpVV3a01uVbT7?=
 =?iso-8859-1?Q?ZXmJuvKP8SRglU/HLzFfD/IS6vCgwphZSKs3aTvpnyvxXidj+p+lEHhM6+?=
 =?iso-8859-1?Q?uFDkBUAdHHqvi7Rmm70w5HBKIABKs/SSNCp2KcjhhyBcsX9S8UOlEyQQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe533d6c-05af-4aed-f724-08da844fe3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:26.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdEjIwhIpNPL4KaRrWlJCQKFcAVvF0xIFQed+ytsMh9DmLdwZd71h+JjmNSWUCYLcwJVGSwX1cSLECpFVQelPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: aDmKd0lirHXsKO0q_eDsFKY-_U0-PpGS
X-Proofpoint-GUID: aDmKd0lirHXsKO0q_eDsFKY-_U0-PpGS
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
