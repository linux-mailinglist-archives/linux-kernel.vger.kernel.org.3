Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C732052D6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbiESPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiESPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:05:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C33BBEE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:05:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JDBvW4007814;
        Thu, 19 May 2022 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=PWWNuxMnVZrcOYZBoSDlsUqF6CDAPnOe0kMG4hbahUs=;
 b=uZhCj/qSttDn43BJH+3fdXbOLHyPscVbOm0pm+4zdeBjolrn3MRBw0IeLDkM15yZ1krL
 vaawS106f6MT1tdk/gM6Sl7ZFVdkFwzhsUPxTUcfiOEuHMC1xA0PH0EZoOAxJdyt3vHI
 yBdmpjVBvf/kVmNjYEW9V/CoUziHedaXG9Y8P5cvR3g8Q7mZ2V9i2mCBsb3nEXzB2O/P
 nLCUXoMS+2+Gn/zkEXnzLMS3zub69nSEkCgdioWbBEvGyOptgKf18BzIQNE0q6JaHMvB
 83FdvpeLnaH6Mvb/UoKajAO8xmMYDzlTbPZOL9dAH/+SMGmkgv2VuOzH9frRPh4XrMVk 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22ucc78j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:05:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24JEuV5T037728;
        Thu, 19 May 2022 15:05:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22vawven-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 15:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp9BSPDLqIW22DDbUgouiyJpcmkrqgKfkze6mLEuLXLp3gKjUBCjo1k+ejnydMWJL2hTPNmrUhRU214pzYRJSkwDfDjVbgI0lrAP5arsp1DGLiYVcN7M+YLoGUV8P3L/wzV83DfvPlzNBryLk6TSgxLxbMPx4HXqruRGy2Ugu+idDNKn665z0cdmtKc76nrDw9u3ej0jK6QkOTiV8UEyPk06i6Zw4iP2dG1CRWviOv6ap0ePToxaNhz8HxkhnWxoIGEVW+3ZyBf93Wh2rowADwBii5ochcscYZzFQsTj3Jtk88jlWnGRBQvTfCzoivQ1hxYEfFyj8l5XyJnwaptymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWWNuxMnVZrcOYZBoSDlsUqF6CDAPnOe0kMG4hbahUs=;
 b=CAXdHB+LPGQjEBt9l7czoiJ1DcOcDpdbwh5/wmrwfJOg4juYs/UsZQmj3q2+FkC0kjh6BJ81wxex/S7SmCY6Z7ZdcXHklNkos7uzYahOuXTCeq6r7G44VfgbZtNIzvTcYQz9yFfd8dqiSpSMB0L7Uwq8wXyTVaxQkCzuhZKaR97jNz67KQMx+/5jsE9ogfpDyuOOLeItTxO1NRigmDR8TVcSNuX6WXYvDfdHtwO8dKjkbxWCH40B/0CQiVqop9HdvG35NdleAbNkLV/vZIh/AgsmpSQ35crZN9cY0/Lm/gDr1GRdxdLTLYqP82svm+QhPOgFzRta30sZiHPNmdCchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWWNuxMnVZrcOYZBoSDlsUqF6CDAPnOe0kMG4hbahUs=;
 b=Q9xZlHQQWfd0FBajGdolMJod1Peg+j1Gs6izHMDpONbDUyYjAINuSt0t4TRFOuzzaQ4fYYXLEv3mlwVw+juqdYeLgSl/Fp3WFy0bobzM8MhlICfRqOOnNfPrUq5ijnftDElzEBVIyuEC2SdlO8W1qgjdB8jx3ZBuN1UxwuewlfQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR1001MB2414.namprd10.prod.outlook.com (2603:10b6:301:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 15:05:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 15:05:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/mmap: Fix do_brk_munmap() when munmapping multiple
 mappings
Thread-Topic: [PATCH] mm/mmap: Fix do_brk_munmap() when munmapping multiple
 mappings
Thread-Index: AQHYa5HcuaOmNE2RSUSuG6FvB7LHjg==
Date:   Thu, 19 May 2022 15:05:22 +0000
Message-ID: <20220519150509.1290067-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 903aa8c6-50bf-4d5d-fb21-08da39a8ff02
x-ms-traffictypediagnostic: MWHPR1001MB2414:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB24145C14B2AAF84B2C6F429AFDD09@MWHPR1001MB2414.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6w0MIYhSrVl4TFG1aFlYiPr0t84w3MJgFQjdjej6IU1ipvi9RuURh7BrRXB5NJaSzoOvypvD3Jv9uB3VBbB1CkrLCA1dNKCziZMFpA+mVPN6cZhDE4GwYlqjhnJI9DM/4Jf0iuh0qYa6l3Oo5TQrnxhy+yNGGdmmQyTePKTeHyN2Kyztg1gP3+qVE80cWblNjVhPfz18QygoT0sy/CgFXtbX1FTLuWBe7JnGP8ry3z/CVAC/78K0rr0rxBK6JaL8DGECQpmi2amrqFrA1CgovEehmxaKEwWwzC0FDg4WBHkwVMQm9+zudruRpVcLk93gQXEGCZpKBOY7FGLLBSUrXa+VPOELOXoFb7Bou6eGgWyJBCxTtw+SpUyvUIxEFK56Heq7+aQQmO+byP7ChHnARN0i6/BFWPOG/Z107qNiPp/cXf/eIUTMXaAMNFvk9qFxRhWqkbPrgMQBu03TLLNiXeheA2IsjOGF4lsiGbHno+rXIGyBE4NjVH9/T0RfKX7tPrxWRdWAsbRrLgLQgw7I5d1W3vPFQDZ+jfvP0RQVPQ4oUpwTGmqLLnxJ2GKj603uedgTCO/oT2JzU8nswMA84kAPKjppmN8exQJMwx67ZaDFExQLZbNgRgOCqAOipiJkNhD/euPEfjWMjTgvwduroo6jIBBxuum5ho2l4VBFE/R2j8lpZDKJqHdt4xQGqR+1LBaRVTbzvOpbmBCPAfIXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38070700005)(44832011)(36756003)(2906002)(38100700002)(8936002)(5660300002)(508600001)(6506007)(26005)(6512007)(4744005)(91956017)(76116006)(64756008)(66556008)(66476007)(66446008)(66946007)(6486002)(86362001)(186003)(1076003)(2616005)(110136005)(8676002)(71200400001)(83380400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xbLAVFno+hjTzjeK0xb0IbBH2/hXYRBLSQN7I2BIurNsLwHiGNDp5P5xZf?=
 =?iso-8859-1?Q?Awt5uJ0c8go1g3ZcJw/EM1VxKC51VJxi+TpzrVDQb6hHNv688Emnaha0bC?=
 =?iso-8859-1?Q?a5NfwsNmW81JIJszfFoPQyG7xLkLOtuplnG/ZNLeLpgqTPRc/0YhLSbHuB?=
 =?iso-8859-1?Q?nsxSnMZeMzZdkGLUUFnJHqucEf1MtWBI5tlI7UxQ8WOHWakx9yKu48FC5R?=
 =?iso-8859-1?Q?R+w05MCkLnL0qMZ6WvKKZfmYPWoFvD2UPDMgISea054QXIyC5X2LpbeSPz?=
 =?iso-8859-1?Q?LUVmOzu8tDsJc26dfxboxcUgy09dpcZkSvzcvUrNuN29ftZ9KeqdcW0qQw?=
 =?iso-8859-1?Q?+C05OMHmV1HjxX2NK+s5jtXozPFJyMTIgLfHGr+9welCDSG5AqbU1O95kT?=
 =?iso-8859-1?Q?cLSc97V8412WJJrQnApdSWRrMA1TXd1+r/fUpDmFqtw9yi6h66zwDMfPEc?=
 =?iso-8859-1?Q?NIAaQc8CAnw9mgcl62wjSBW99q2CG3VOnKAye6Sh/IdHGdA9wnt3x5gf63?=
 =?iso-8859-1?Q?JnWKo+a0/12a8kAaEFnSWnE9RptHzbMCwQFrJhGPJXktLHD6zvuZxoY0dR?=
 =?iso-8859-1?Q?0OhwjR7cDi1SX9sO4ZnU++KCjjbnkf/fmSCJaOB5BLNUlXwlpNqWpcoNgJ?=
 =?iso-8859-1?Q?/kxqTmK4yDPYMCWAZXOTq4Nr4y8K3BfSRWay5bhb+ILYqp1/pALq8u1XYc?=
 =?iso-8859-1?Q?iNuAGQpbr5pvxHEWjoePrkPH/E/jKYpluTjhdMhGof0Lm1d+iyeaqdxfzV?=
 =?iso-8859-1?Q?4nb86AYPd2mTRkqj8jyqUk9awuHSIIaKEjm6rwFDXyvfE2/jLIEU1NDoSl?=
 =?iso-8859-1?Q?+iwbx2/VGMoNHGlkKVraGiBCYzQZH+fQHc3/3MNYDDcH2LX8zFmS5DI5Ya?=
 =?iso-8859-1?Q?cEWBwLlVXCBG3pHupcE1RA6BHkUIvXfAUHsjSH/0x5nfCrAVXDcW3+w29R?=
 =?iso-8859-1?Q?2Spy2j2FcMXVjvpQiXnPH88jzn43eGH70mGrJ42bBgryej5xr4rAEDRWPm?=
 =?iso-8859-1?Q?CS3PZVHtsB4GZGvqkPmGn8f+/rS9K05xqrxd3EQdjp2Dlbnw4ypcDx7+LV?=
 =?iso-8859-1?Q?q9MdQPCmohtqE0gfyXPF0MtlJVLFqjgQc6z8LKOzhIJB/OB0PEJFfQVg6k?=
 =?iso-8859-1?Q?5/P2ZUPYB16PF/2IQIiHSk9Y/6nsgAYJfD3s6gCGQndmRraHSsm2KVGV9X?=
 =?iso-8859-1?Q?p7FKMVDyb3Gmlwpf5lCKZrVVm9KsAje3YBYk/itor2E/e5B9XyndXEKMvo?=
 =?iso-8859-1?Q?xxiR5A2j7OjkjpR9F/FYAaMFFcZfAFfZjNXcFdf05KcCyPCWB1IeRYBYDm?=
 =?iso-8859-1?Q?7+ZWIVatcdT+ZseXTntCzJ8U9ZHwZrpyr8pfqIokTQAEY2QKsoT5Yt/EOw?=
 =?iso-8859-1?Q?8/HtNt3Y8oUfyTOgdam5Z5AVek18lCr4YaYYnhrvKt1L0nmN2X/uIVU9+k?=
 =?iso-8859-1?Q?O0Pjsvzgl8YF5Ap0DcUmULz14XZpeu3fD8QW6iiFqSbOIRKp2nxFuL9bxx?=
 =?iso-8859-1?Q?8Pe1DA/SkHPQabKI4Xm0WYSL7Xt07k+nw0zuMr20Ty+HoGQwcJLkNUiBZR?=
 =?iso-8859-1?Q?sqSHvPlN6d82agT+Ldtpt4W1hYCQqv9mW9K3xp4d4pw9q9oDO7xYnkUOaX?=
 =?iso-8859-1?Q?X5C5HoGczN7ne6IHhpXs0qG0COtwy+HenZlckrOSnZ4BvMuKBLi7s1j2/T?=
 =?iso-8859-1?Q?pdmFkU5ZrOSjyNrTDgn28tSbMWMpPndZ/ixA/puVENR3/rNnz8IneeswDh?=
 =?iso-8859-1?Q?89d/Q+qQSjkPArQAdrvsOVeqOEcmnsFTjZWbUUHBMd64z2K0gkxKAdrZ8I?=
 =?iso-8859-1?Q?XAbkM1W/a+0Pn6JF8hWD1cIQn3PVn0A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903aa8c6-50bf-4d5d-fb21-08da39a8ff02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 15:05:22.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEmwoNKw6wuj7Nsnkxj7tXGQ9Er28XbCDjuL6C03GFx/xdY8zSBdyfCM13Mc3+PwomprvYeFao1d09S7dludfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2414
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-19_04:2022-05-19,2022-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190089
X-Proofpoint-GUID: u4weKc6O-rpBFuSHjKeDDQC8c8wDcaew
X-Proofpoint-ORIG-GUID: u4weKc6O-rpBFuSHjKeDDQC8c8wDcaew
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the newbrk is less than the last brk vma start, then munmap entire
VMA(s).

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f1fc9c5c068b..c065a3d9b5da 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2942,8 +2942,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely((vma->vm_end < oldbrk) ||
-		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+	if (likely((vma->vm_end < oldbrk) || (vma->vm_start >=3D newbrk))) {
 		/* remove entire mapping(s) */
 		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
 					  true);
--=20
2.35.1
