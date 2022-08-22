Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239F759C25A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiHVPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiHVPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD73F32A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MF6alH003939;
        Mon, 22 Aug 2022 15:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b13usxr/rFGI9qnJuyqgQSXFTPbD64MOTN1je9foGPI=;
 b=D8y0OuPfVll0GqcpLra/LHZwzkDcfjb1Dj17LVD0/WBJHsJNNtfZ7DGSfZn6wTRtxFw8
 okcfGb6ZZO3F8oMj8Xml0jPwoVF2Rbnym2jXlUQ9BfAClaRGY9IjiBGVrOUeDeQ1R7xk
 jm2qPl4+zhWVOA4f2l+v3QgA/UCxb9L4WKf2PdWoPJsIfemNtj7cu3/s6BFXr+f/qmHw
 4kN2hGTN/VmO5oNWuN21AKWVL4ynCpKIBH5brWShuFhs3OMGELLYk2T38l8Qh8u2hM2a
 nn0i92PFIBvVILjZcxLp3GOsu+gyNXAcPrLxkKHJfTTZYwGWK/s8C+cTdWhGj55OQjKs yQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4c56800h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NdW035436;
        Mon, 22 Aug 2022 15:06:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u1em-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M62qVEAnyR1Slb1RVGgQWhMyDbNpK3IByQpWsYhVam7kKW5S5ji9jYJTKxuN2kMdx92CqC30xx1W1zYkEq+RZHKZcxqCmiuwlzo4EBZi13omOTGs0dLQTkX7hb3tvO/9Fprwyk1jRyKGGetSudFGNF7yqgoyAcUfj4lwZTAIpHa0If7QmBGG9MRzwL6LoMP561ZrP8s9pQJUvXz+/WIgwZqcDFSt0+hnfSmpw+Jy70cAUvusrlJnqH5Xku+0r01T3jRYrF4r8q2xRk0CoKoo/dwveL6Em4V2DvPaqmmcddbXm9phb5cslWbbcaTJ5TUWF3G9ls4BVpVl05/MhgkAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b13usxr/rFGI9qnJuyqgQSXFTPbD64MOTN1je9foGPI=;
 b=KbJFp0Ynp0jwExzTyc3v7RP3Bo4mY50kzaXyIdnhQavwURJVS6/85v/ZEkQVkjPuuMRL7V+FFvsPp++uGBWQT+i81G55t6Xth9ViFM/9wtUqrTL25dN0NrL9gN1rX+mo02KpYctpX/R2iDohdemTZ3B2iEJRAxKtFCrXiuWwE8Pu6Pp6qkGjMJa/4Lx3AhITcD5/in69Tx+zOmFHKQRpcE3SUn5cDA+KxzTZBqEfqj8N3gamfsHZ1+Diyn7g34mAKhabs/12mkxZB82bnLMsUkLXiLEGIYIt5wwS5or3r7GVh49FoUrsD1J9PmiA9mIpdhq/HVlNKYhVVLUIHb2doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b13usxr/rFGI9qnJuyqgQSXFTPbD64MOTN1je9foGPI=;
 b=lXWFtuRkzDFpNTg2g2KtH4kkGxCK/pEk8GbkJF2y/RLi35UpZEcmUWQ4SBcv3gOvz4y0Ky4DEefbC6aX4NtXhy1Gn0mA4iu6Z/wLPXhA2V3d1HnEUyaYnN0vBpLSqeh1YhOTbCpejk6NJXLQMsMKk/csG6g7Rvv8iaSIiyVx0r4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 61/70] mm/oom_kill: use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v13 61/70] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYtjjDHyfHyCkFWkaNxKQYFTNYmg==
Date:   Mon, 22 Aug 2022 15:06:31 +0000
Message-ID: <20220822150128.1562046-62-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1dd727c-089a-4b74-8c5d-08da844fe826
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7u8wM1wW/d5UgZe3PNz8PCiDIhnG6xRXTPHNY/TVDxszpmWeReUt75PN234smTTcmaMSxP03qPyqXUy82s6rbeBzGnQc2W4Lb3y4Y5HEF4u78bzlpzMUkLDmeR9ZRAK366pVu57ZhT09RdBiJX0WqT1wIi4agdsJtQNkwnpzJDkGZZyUP6fROk1cal68GpoS7xZA+AmBFjGm3pdc879gkN9FAAX13prXVPrTmmdy/i51YsCtj/KTBySinPxmqOgcz/s5fHEiAEh+C0gFDvVb90D5K/u0RR4wCk1xz/eVg9RDA9xlAsV+xq/I08Dr69ODn5a5qIy2X1rh8FpfRyKSQ2PI4PhMIoUDznWt/DjKI3DIxFQ/E/bo08O8ia6NOV1YQ8UTL3cbmjkK6X50z58Sfi3wnXzJP7uhPrZsZtxGskKr8BYBWeN5yFr/2iD2xmP/iBbhjVKKgogNFPZSiWoIqkVhzxEX2Iu6YSxRG2Cf3QsUBE5vSGAds6YhnbTKp8eKvGA9lVzxsNb1oGgTtJqCIUpLnWJlsvrdmiu2R8Is+7BV8Ty1VaacxA0Cff+0jdX989vMBQfLfB4hroMIa4tm3QMSbVzl5b325DaHNTFuzB0fUWOgohQvrUQP6CQdghPCXLifrqoYn9GK9lZwme2skvCyDwbOF3Z/foFClEFJlYYwTyT/TAZY0NX5bq+1AZ4qlHIhj1lGYqSUC5PNkTt7bCVWoTSrMDsUwjGt3wnw+IM4g4A9LaQxTTorHQ3qPQZ3oG+W0QePoiwjSMLZz/sgiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(4744005)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qWb9iAzvF3SzQUMxjlWiZ8AA1HeEjXM/brZg6+mxqKNrSt/R3Gr2RQ7dj3?=
 =?iso-8859-1?Q?4WY8LYV8UMwqh5W8RfO52XwYoXkyJdXx2DVb1lvNlfHYqzXa2AzvwKEkeV?=
 =?iso-8859-1?Q?x4vGpnC9E1cNyIaAg/9apXnqJqc8cxslN7WyRdc/daglSKaMDzRSR+3K+j?=
 =?iso-8859-1?Q?dKhHKw8jQiwiLxzZxfDAyuN9F6Swjpz+yjt5yla/w7wGAXnODyfvUshnRv?=
 =?iso-8859-1?Q?ETSNPXPp6awIfhyyNjeShMotfep+TjLJq7f/ZkJcxDPXJTKddDxuATBjbI?=
 =?iso-8859-1?Q?Sb50/nbFTaQ69pQvHALvpzFh+FtUmwLUySpGWdqZK5LDCECntMfiHQxlzb?=
 =?iso-8859-1?Q?eICpGKSivclaR8vzOxD3N8xyUlUpQF44kOrcwwh2IySGoaksJZ28tZVl39?=
 =?iso-8859-1?Q?Ih3xMkWmUIqAkMblaAStUOR2H8wgsO7W6+hiG5wWAEu11rUdK/629+qAU0?=
 =?iso-8859-1?Q?R3bVBSGKZi0/cm2AlGvTHU7lnWUHKjMKAu3oLggPcLxv7y/pGZcgP9RhZU?=
 =?iso-8859-1?Q?zFQic79nZFV2qWjQWMXMH2FmueV3U7iszV3ujhCx0Y6I8BKztJRaLLUbZ1?=
 =?iso-8859-1?Q?UzsnjmrZNrSIs7DXbq+WjWmqYtwmfp9EcahsreP4wZa/TFpF7Jh+azpp4u?=
 =?iso-8859-1?Q?F6bfOxPqeMLbYW4n56CLVInZdIbg+lEjrBpq9frf2HY9uWVVC7Tfc9jHZ7?=
 =?iso-8859-1?Q?skX1ogWa/cjQkCoSFaLkzs1aG9nt0+ytW4f0jMJzv+Id+2sRYUC0U6itpA?=
 =?iso-8859-1?Q?5LF9HmwDTgVtPWPuVVaMWWIkOLh7xatRQ7o91397XhDrjqxMFqWy8A2AYJ?=
 =?iso-8859-1?Q?RUaaHDkU+wlxiurVEwYeTo4SKJIlpITf+ChEDjAoD3W4GWdi8/+Fkds7ST?=
 =?iso-8859-1?Q?sfs3SakISfkngvvHneVfn4Q7KrK8toPHn/ZzKl4G0u/mHhadmGC/2pHS3m?=
 =?iso-8859-1?Q?/l6cODFW4URpIO8QnchXvRmYPuAHbb+VgS+YVvh91uRvfX5LZGxYXb0Kn3?=
 =?iso-8859-1?Q?jrNcHNO/TZafTQ0KiwqeYViWDl5VmX9+Xi/Xb1aPhHplF9pwVGKkIan1lN?=
 =?iso-8859-1?Q?LuVxu6uKEDDqlR73PYn1RSwnveZvdYpj1d/TFqT52GSugFZv/K6S+b0TL5?=
 =?iso-8859-1?Q?GpmZzgagYcD742w/GZETfKN6hSIGQHHzgXsCTKZyMZFdKg7Awl1if5TwzD?=
 =?iso-8859-1?Q?u5IomYAeKCE1We5DYBV8x+EIHEYwgQhr5k0X2dMqmeeJdLNBYZyOqOgU86?=
 =?iso-8859-1?Q?9eKZKBVD203m5XXiwj1lhfkDGW9rn4lFAruQQ7OuPgdAxYwG7OqbjWSCBY?=
 =?iso-8859-1?Q?EUpIraqFgG+GNuH7GmefEMSD0C2q6rXzdrghlsbPaholA07H4M8OEF6dIQ?=
 =?iso-8859-1?Q?/mH6mZHqewhgUw+LTMvgu7GpM4j3mgSo1lRAHWk3aVmwAHVKzUAWIoGsUV?=
 =?iso-8859-1?Q?vxGWWvkqEECeKFAN8zXGqPj2Ob5WFJ5OaaBBV5u53TEHuB+wWXyWYQOxcD?=
 =?iso-8859-1?Q?IrOsrw0T7zc2xQR+Xgfnpj+heiCoepBTI2GonlMI9xLRZTY/JNcsfud3Ng?=
 =?iso-8859-1?Q?dNya+PygBuYcdOzncBlgNN08KJgn9UzJ+TjwzpOMlRAyMWO0XFYbvBjNQu?=
 =?iso-8859-1?Q?KiqPyiZ/nBYKI7q5oy8gZ04XbRvnPM53AmDUCzexHwpbxpi05KG5Ek0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dd727c-089a-4b74-8c5d-08da844fe826
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:31.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0U7d1Y7h1/tdfwnAJPBRF5zt51V2zPHwg7WIdB40y7OSe/hGiIhE2hVbJGsMTfEd+1qJCv8Oj8Iq5C8V58Di8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: fSfe8zG7_qeXh6IFkJjrpHXCKnMmNRCZ
X-Proofpoint-GUID: fSfe8zG7_qeXh6IFkJjrpHXCKnMmNRCZ
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c08cffbca0d9..6811aa48a98c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
