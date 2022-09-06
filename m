Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3755AF51A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIFTyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiIFTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA5D760D9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYVi029915;
        Tue, 6 Sep 2022 19:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Pa0nUb4ozV6YcCX6EenXm/7pYsFbzpJMDsedJQRT6pY=;
 b=OZWTKiO6gni1PpFUTMsk6m+9LdSis4gtXMQhPIyexfcdwMew5Yj9tB0Q4MnFFUbORclN
 mC8Yav0Bo9qemS5Y7he6UDnLhF8Std3hIy4wfhEeFM+jW7NA7T9+8nJMydArnadItLok
 HBw3diXMZ6bLBEZ8KOR9NcftQQPrUajdIjp9chuUlPd6o7u4yifZDq92twzn86dreZm4
 LEGdr+nYOdcOlGYCM81sy0z/OjbEILm+VxJGsZwrugAiUeCqERAzXRakSXD/ivkRywMt
 sx6kLc7AMC/o58JI6/5dUZ9hXDk+ih5CWCMoz8VMmKxX1cnhvrBEAFbyiK0YeMnzp2ek Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H893Z031227;
        Tue, 6 Sep 2022 19:50:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajqe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfJMjnpzo8zdSu4SUCksv6pHG+Wv2ViUrPyZx3MMOfzXLwMiii1CuqsKMkpeg1JUiS74QN3THdcKyRSfxl+g4/4QY0bdOHrWI9obTXhaUStTxmjd2+g23ba5jgMGrWMIAjxJ18oOyhxSiRfFSOcYcUWuqwm6cstmsK1P+k4dTvk3eSccjGzTEoucmHOe8Clty49zJg8VEiOA5F5pgdIt6Y5spwyOM2e7fws101TiJCaIdgvuaQ+4PsGHvvgrpTdWQTSDsNsKiU0dZKzRJuBXfQUygg+zM6W5FU/SN4Xn/55mIlXQ3z56HDbSThol7ncfNpza61NWENL1rz6gXlJm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pa0nUb4ozV6YcCX6EenXm/7pYsFbzpJMDsedJQRT6pY=;
 b=jKz2reblGtfqOoFjzqkdUd1nbJ2sIkDW9NejDYZb55LkE73VEfbt4YelfYgTfcMW5hnCNgQHOE3BGeFx89EdtJogxElITvEY935re/b4M6GWKxuAwF957nSyBk7QyFzsHOkEGBcsXr3HqK+R7+rUdVxmDgYtUtO04UCg++o5YvCmeMs5LzKo5w4kCKM6ET/YsoqVfP7LG34i/FswCOtDJRF7gfeS8sdTsWXFGClYSE2OxUf8418c4Sgzy8q99YWFB/n+tnHDKrLg404YsIytf3WxA1HhhvAr01VbruUdLzVadbkYaFNm8jrDP2UesiZ6zplweBJkDJ6A6xr4OT/oOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pa0nUb4ozV6YcCX6EenXm/7pYsFbzpJMDsedJQRT6pY=;
 b=EDrhoL+vtBnGw8MUrMmowEFlufh1zmRYeeDyeQQn9Jd0kHVjk6xBoT3Xyyt9O0I0uWN2+7Z0PbyaI1R12rC7aanbZDUkZcPyB5BgnvGCZWVM24RKAl94mf4sz6nqpsNH0buUVn/jL4//bLAA466HBuj8+HPHpXuMb5swu4KOncs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 66/70] riscv: use vma iterator for vdso
Thread-Topic: [PATCH v14 66/70] riscv: use vma iterator for vdso
Thread-Index: AQHYwim43PAcZ9WYQEq3a7FUzjLH7A==
Date:   Tue, 6 Sep 2022 19:49:05 +0000
Message-ID: <20220906194824.2110408-67-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1476b772-ef5c-4b8b-c358-08da9041095b
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2O35R7N1VCDnCXy73o5CcHJORw3X7zGKJc8YbYrVE4GEzEIQo7SOJj8Ukrhuk+UmhwWD2Io/dP2/pYhzRQxWyQdWsnkJ0hh9sJxbgceMoAYDvYNjWv9RloxCp+QVPXHwLTi+iH6B11Cn9TMvE1dVEajAYS7Co0effK2ilCCC/qnkCrJwxqq2mCJ2DUt7dlXxwtQINvseGS21zpTOk3xspeZKRoKg18Fs6vtAWFGMfMS0I+AjxF6fdr0SmN9DF6yB2hAyzlKzJDRzsGGZUIQyHI12qhUmMLO6osoOAwyEBUPTsL1K8EVuiwr3o73ILBpP2xNg2/WvVUagJJlBBaeVoR3FXyCQ6uB5uxsjR9+zEiK3xzmzVNyAXW6O587+NzQQrySHQgCf36t+tP4D0DXj6UCVZCz6uxJhSkd3uFNcRsaGQkQqTlbYo5gs1bLBNtw6vPSkAAXOxl3nzxT8iqn2m67IMEYPOx3Swhai09lc29zHgmSWzkKW6tg+Hc6kpbFcAjs/J4hfvSMHPaMPY5X4y7hIaumW79MvfEczwIHeXI28yW9MMfqd1cG5q/qMRj6/T8DdtmSUl+ab1HD/f1L9zAp+mlTQLZJUmuBjr29qbXMoikmbU20jT/Ixr5JUvQlqg+wb5i3W3fSQj3B2GXkFVo0D3C2ssCd4do0mVSU3L6aEbNz9jYPbtNtYDRv8pdUs5pEvRCiaUv4HpgZcddyF8aADPpuXHrj2kzPt3y+yqHklgizZ5ohZF+RETyVaC1h2+zo2MljDHbKHJs5651nig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?32WgqiLFRs+XH/uqFhOuhPD2JdcYlhyc5s7UD1MMuD5sOcYzXQTzlERaxM?=
 =?iso-8859-1?Q?rNKkcuif6x9yA2uc4HeBM5RSODqRf1c9qQxzdiMbSZcgzVxjOH2SFivODg?=
 =?iso-8859-1?Q?iD2ctUszdIsnUdZMMckQmjVO1mbtd4RcLZbhn5hEnw3EMpv84L9eFotQWB?=
 =?iso-8859-1?Q?s6CqkTgEuZWIpsOU44fkpFSdFQCp7B230LtEY3Wddj5RFBBZlZmPVQQqH6?=
 =?iso-8859-1?Q?+TsldihvBZgkw9+kY0abM0o5hzvVSGkcIPpca+XxMWPrfuW2eP6cY3sY3U?=
 =?iso-8859-1?Q?uKxH31xHVqlNyYmDQ7pPd+Bg9OX5XMdAqDtHWGTiI1x20s/5lidctZn/ZD?=
 =?iso-8859-1?Q?609kXPBRI6cGWZrEBd7EEYv8pJLy5XnI0FUs/7JP0xR50mjVdcmEpSR59b?=
 =?iso-8859-1?Q?InPnXvd9jWQjpW4xWwCWAIhbTFIeF1v1d5TNJAhojont6fcoVkMOOIQ7Zz?=
 =?iso-8859-1?Q?fyWxvf12L3yTynUWW1gHMpMTezFJ4KWTr5msq5/1mt5/e8RMUGED78HUxQ?=
 =?iso-8859-1?Q?D43ed22bEfD9vC4C4NmyO07ixOgPbUYGN6FQJoc5ezU59KIAb4BzGuAQTf?=
 =?iso-8859-1?Q?+kpNcYzCW6iDPi/3F/C9DQlFdRkVYKPmEkF7oHKv7k1NF8nVI8G+aQnfyH?=
 =?iso-8859-1?Q?5T08uo+xEcZhY82FmYGpAP6vNpUmk4hxgx7uAW1xjrRibMVckU6nQrBwW0?=
 =?iso-8859-1?Q?9AQ2PPs9M4YCryYBbOEz2ZLsVltjSNzOZBmjj3v9m/th0dyddrGy9vY8Xm?=
 =?iso-8859-1?Q?dTzJ482EFcz14S0rr1wlOhGmgVccKBOfAqfZ8yXbt02qR7BWEP0GWvuG1H?=
 =?iso-8859-1?Q?JppUNpjVkeKBYd2fwxCXkxIDrFox9sJwtQJ3WjFxy+KRHXmVn4mzxUofrA?=
 =?iso-8859-1?Q?A/XzGwbJUw8Y/UnNdoQZAPK/aQ60RyDrXh3vQ3qtUXLr4sRMw6OFjZvzIn?=
 =?iso-8859-1?Q?E8fkvX/NE3KlX9lCy4UfYUqFj3WffeWYdIN2nJ6mPaj8H6AhyLvu+hxzx2?=
 =?iso-8859-1?Q?jsPTCOVY6JCMruaEl8otjaORFKU+UM2moSH3xX0+gwq61D4xYh1tRfbZzJ?=
 =?iso-8859-1?Q?ea5fVAICmfOhpmQvRETBOCxdGygk3RdP9/bshiDVkVIYk9Yp6WVVdsWJsM?=
 =?iso-8859-1?Q?8qXXcX6rmLEgfvX6AHXtl+6mOkE+56lKHpp31uOT7sd4zRCxWsm+99WJC7?=
 =?iso-8859-1?Q?yilMk65mjKsgW2Z6cSJQVJ9wnw9Aa2LX3h3Dd88846rPJjjUaFNlVt6bP4?=
 =?iso-8859-1?Q?geFW2/FU3MORQjad1gYiiRk29ns6iTKP3NJv7PiFHdZn2sJ1tvvnUj/8sj?=
 =?iso-8859-1?Q?48cUF1AEVKQO5upkc/npjOVbP2nms3NBh9daH+qERhhaEklYOtYJ497d+V?=
 =?iso-8859-1?Q?FFx8uLHlGFSXAFbkfVmDHAsXTXaKRmDo2z1E3EZoRC5wI2QgHreSRccxqV?=
 =?iso-8859-1?Q?laBi3N6btjLJjfKzroZY4yfeFMAQZ4/zCkCMnpazsxWvk3b1dl0gOOdiTc?=
 =?iso-8859-1?Q?VL6VGr3tcJ70Bq+BZNg2tFTu4QjdiYBBCpakmWrXT45TqCl6gJ4n7icBQ+?=
 =?iso-8859-1?Q?pvbLPnJJBEw2NqySiVPKTnt9VQvIvrOYP7Y0x0h9v3sXF8uO7DUVjah7ui?=
 =?iso-8859-1?Q?hCTVyG6OMY+SOnHP8aUfft7U+yXWG9U/jup36u4ITtMy43IZtiQt+dkg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1476b772-ef5c-4b8b-c358-08da9041095b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:05.3963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrgWXIrgJugYKoSWTmHlKxzTzBYbOQwqbiY1/VouEMW42hNkQQvaoOhmWatC8d4CnbtLEIFL1t4Bc4fAA2qQqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: YZWL1CrnhJ97DXFT_xGpC-sXQ91uAEua
X-Proofpoint-GUID: YZWL1CrnhJ97DXFT_xGpC-sXQ91uAEua
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

Remove the linked list use in favour of the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/riscv/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 69b05b6c181b..692e7ae3dcb8 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -114,11 +114,12 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct __vdso_info *vdso_info =3D mm->context.vdso_info;
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info->dm))
--=20
2.35.1
