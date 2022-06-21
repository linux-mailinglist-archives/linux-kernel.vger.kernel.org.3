Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCB553BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354617AbiFUUs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354390AbiFUUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB47324BFD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2w4Y007494;
        Tue, 21 Jun 2022 20:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8LB9Ootbo0gz6s2OGwXALas5NXxmLqsR3r/7iL47gbI=;
 b=OGgaKgYOoH8LWtkZixFP1RnDF55DEpMkSuxjL34eaEyG1ja8t+PnnLsNU54IyZX9PYgP
 CfWWfGfgzvDz15oGpzUy+7Rd0phFd0Ngtx04fMpD6Fdxs+RyIZ/bWZaRmYxh43duCWN9
 nNfSMCCg77tA7ksJQRnz2mtFk/kC1WUS+bEykE962hhOSmGG6ZNQTnBBMVMtkxEjCbUA
 jtNyjVkI0v0bAQkYnDM7D1WMUShwjCNBC40Oa16oJNxTyp8LkbPs6VKhw0bSiH9MZb/3
 +umArfOLrm1BbMz0lqbS63nKs2V0PV0NeCsrfrODQtXaN439r+U2Schm3Fe9WiR0bYLd pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgn027828;
        Tue, 21 Jun 2022 20:47:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noKIRsORuihZqp58vuJgLdG+3Qu4LPX+6JTyXiP8GyIeybtcqljmdjbAAbDmddOsbL7XTOdBzstom6BT3d9EjsnOZvgp99bEq9YqJDvOTefnda7g4feYDGH4LCEn77omcerGKutuhtObKzCnGnyaWfiN6br609DhHSF/vieZN3XxOH6kI/03Fp1KxtKCltltWWRcTWusoKjW9AsR4geRvy8p3EnxW6TbGczux+5ttC2ciMMZkgDzZeAtnDcXr/dJPEJ7U+/owagLMSxukpgRPPfWzOBE/XJIBkGgNEU6OsSFd9eKO94k9b6boYdMqM29s+XW8ss2LW9ocZ9zxqLxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LB9Ootbo0gz6s2OGwXALas5NXxmLqsR3r/7iL47gbI=;
 b=NtKDKejaHgFAIXbCN1M18Xh4Zv5rt8SI1fWp0U3Sl/jlGn2/qe0PrIs5ihtv/rFeE/j2KtIMjLOXr3uyh76Pu5zvcmdSnb9Yf+U6na8LpOaJwYeyi5a4OuRs6BhIyD8t5J4jOyOPqJIi4W3kxfR5RkJcORZ9zZao8QKz8bchCxIxfqUAhRbOTHkPXUdkfXfSannIL2LNpXDn/gp68AT2kefAjsIVO/PbdJueRZqayPiXDmuZTw0KruqiuFPpaZRQ+HSEpjCW90IQMk1GOdaKT82nHgQLRE+w0YN5eKXqdjuj+DOpIm3YGwls6cMWYcVI1V4gTtvV9pqouZ8+W+0McQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LB9Ootbo0gz6s2OGwXALas5NXxmLqsR3r/7iL47gbI=;
 b=VwPGNgw+aORBMQQxZ9Umln4bcvk5OnLtK/2ERWBx+/BBsgSMskesPE/j/Hz0g8ZMwMAmnYvfnEAuDx2NB1eKKxBbipfJXEzua2m3ZX6xB4BNP8OuAJ0p6dMyy3ONdIgyz4t3AX8cuqwP06PPKb/e8MHcK6NwFtRTB9SozJ/woXM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 21/69] mm/khugepaged: optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Topic: [PATCH v10 21/69] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYhbAMx4pb2ypP5EGf2LdzU38IzQ==
Date:   Tue, 21 Jun 2022 20:46:58 +0000
Message-ID: <20220621204632.3370049-22-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1485698c-e652-4eed-fc3a-08da53c73597
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30857C859E4113D02BEC304CFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IzLwvCrnvwjA9Bm5A3aHUG/QISvI4WoQbTUVz2V6pDmG6pvJNZIKoiKdRvKVz/6dPs5049yF01RjI6pICvixtzStf8ZlGsc3m79SdniQNam8D1RNoURLBuP/2Inx9/2yoGZwANd9OtkyabBprxyYW8RQcclNpe2rarbfX/C7Wu22Ot8j6qek/2gnra9BJ4ridwq6Sx6nYFzVKHUMLpdvxlC2BLpdcxYCdL9QB3Ja14FUdsUxtys15eT/UA8lXnDVb7WpkX4NorMehgYwMja4qjICkEQKbYGqXevX9x0kebqKWSDB6SgEHPILMyqaZ6Kig4hte+w2z3ZcIV9jAcyRIzK+MkbRyVs0DcpemZgjXEJMFUY8Z8VCysg+L1uJgTODnyhivml9ri/aIrWXvblaCRgeQQmI0uUjU+vjuPklnl4hfQAVYHmvzxd8nhvSYGlkfWBc8HIMjEtgUpPEP3UuloHLJGrQbM5yZjyAapiXzZ+YA8KMqpzHY4UCQVMmsWmXJw2sUVf9xUKxTeWgowr6WeMtkWcpYEpBwgkc+0TKEHkDxw7nbNWHwWG/PT+eyjZu4eqhKYKSoCuFu+JZJt9N1gtp7hSyVNATt4p6I+Jedz38f+/fK+/l5M2JgB6nZ4s9JQj8aAhCgtL7xRQSL4kTbsJ5tmc0IGiAwph1zD+bNIAt8Qx6zcTMjDHHVi3Fe4ARTgJAG9BZcjLuW4C9Mw4VLmaALmtndEZExpM8B4QZiU6aHDkmw0n7YRZekXgdTBFkn3HYjoyqmRCv8Sx+R1rZHTkubo+Wuj9oRhF4boHP9Bs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rJK3RP3Oy8F8YBw+u9X8RTudASX1NWHpM1F8EyXmtUcsnyBmr+DHI2SzUI?=
 =?iso-8859-1?Q?86wnfoXiGgIkRygOTFI2b0mdm17ELcDCpE7V4ftnjH5v0Sm6+XJEdspyDw?=
 =?iso-8859-1?Q?fJReEgYJtpdFVzQZt8HOUKGAfWQjFJlRniXSANJZV5sTk0Bhb+NjPOojuz?=
 =?iso-8859-1?Q?6Zqyw9sbF0yhACA0g/TwwXHwbbfFeZPfAxEnRdhWP5uCW79GwYJAnwRLF8?=
 =?iso-8859-1?Q?bYIfD4xaCYNgKPL/+RShbGDKcZSPenZvBrp7Q3hWYPAJBP0L275vj7jVjx?=
 =?iso-8859-1?Q?T/2oV2xIlEd7L8IneJZfZmkDNPQ3xQwuxlIWy5IKpgNksSJQrlESoeFgkJ?=
 =?iso-8859-1?Q?DhyPb5FUvVr9XoJsdQYl5zhbiV+st5u2z3AUXT2zheghie4WQNvMOAIVmH?=
 =?iso-8859-1?Q?BaIE4p65LvbIr3tkqGBRiz4/jedrVLCeMfTDgiewBNTju2KpFOMckH27K1?=
 =?iso-8859-1?Q?Xm1W/w6NJ7t9fL2+8ayO9BjpVGRo2GsH3R/Q/3gqcqdGlQkOjFW9gU9xtu?=
 =?iso-8859-1?Q?9PoU06un2kWQa2xvf2OlFbJR1UbhiMy9F3C8iMlG0XY1hQO1yCir8G4tRl?=
 =?iso-8859-1?Q?BOg6R05vrnvz5Uim+/p/V5RNeHg863/2hhr1syA8UDWNoXPMMbGpAfEkIH?=
 =?iso-8859-1?Q?203nvYcENycXPyWKgJD1CfLnf/N/Iz3gMqqcjNciszHSrw9T+Hxx5m1XEu?=
 =?iso-8859-1?Q?MH+4rY2v8gfPoec1Yq46VBsHK2JbLavsZnIfQ5EgxcO6rn1vWTJMaRttbY?=
 =?iso-8859-1?Q?DiQ51HNiBnhe1KSbeIMmzi1P8CDgc27nuhYKmmN2gQioe/3Om+dGgaE5Mb?=
 =?iso-8859-1?Q?6+jDaId5i11h+6LwNNDudXJO0Pb0FFPPjsxAQiDWJjiM6JR4Gb707jvDGs?=
 =?iso-8859-1?Q?gKzCpL8FBVpkKGWnKD9uvRfAgUrBRKxqlSZL3VjVAj2zzYBlFsuG5MR2xm?=
 =?iso-8859-1?Q?B2AzZW6e0hUi4bysLfGJd4a2lq7tFTMH+LOE8ZCCpH7efwQtC2DMvoxFmr?=
 =?iso-8859-1?Q?4dB0mr2N2i4LLS+cAPvdflA66a+Kuam/GUdbsxbRwkHlxMGPO0aHA3m8Ab?=
 =?iso-8859-1?Q?K1lFMOuxg+Ru/+itkSdOHu58QRq5VwmpUT8yoxLSqcOwTwg0ayRjioOrTT?=
 =?iso-8859-1?Q?t/8nPGkd2GIbYLkrJOJR3mAUqpsO3gYw6+Q/4Nl0XCemdEMeCuJFfphhPZ?=
 =?iso-8859-1?Q?Dk3dSbXt8NCUzLacCe/eCfSPxEK0snpt2MNWKBp13279wAxLXPvDUKeY7U?=
 =?iso-8859-1?Q?zYFGblHU+9XjLH0mCPAX54STCheL1zc57baDNd9+F091gWviI5U/GelJjK?=
 =?iso-8859-1?Q?KKwz/b9IjrZL4budAlzBrmdwL2UVruYgEZyNwYPFZERTr1vNeW1ycmZz06?=
 =?iso-8859-1?Q?QC/0ecSLCmGWZI5GEbbQ7FWmgrCA2UdgXWQzu5PJ+o0gGb93fRWvcxI+J3?=
 =?iso-8859-1?Q?oPp/2mtDecCOIPImMdfsSCD5VF/aQlvpcz3oGZFY37obWv6QNImTVLXZCV?=
 =?iso-8859-1?Q?HedItuX+fL9p9qyqE9iQg454f4Jz3mpoQyBCnuGOlcX1tRPKnhrbVaCmzv?=
 =?iso-8859-1?Q?4swR+JC6MGENew7CuRm8HACX01WER0BrOE9txC+HlW30/jjy67xSODZels?=
 =?iso-8859-1?Q?UreWJqtJbhY7/tgRkdU1ZbUTegwP+WtU7Rrqa63QLZt4s+P23VKd3hny0i?=
 =?iso-8859-1?Q?nFggkzzJjaaPPgDIrt4d3s1xMGzxaFlyknWpO2RnIj2Kfkq5QtVXTwE0xL?=
 =?iso-8859-1?Q?m0DGSDW3uGg4ISmo8qRCAO0k1t5WHxqTBu1vPQuVkgao3smD3Vth2gG3CW?=
 =?iso-8859-1?Q?kvtUMgUACltNTD2myaRPKxRO0HuIUyI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485698c-e652-4eed-fc3a-08da53c73597
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:58.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+eb9zqqH3hqrAJMf90EKAdYmL7XlKLoWOxRWHceBpdYHr5Io3Ll/PHi4CfUSr26vA+uWRrXIRNWDuAjultzyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=826 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: TAsj1JDzYaWQnJw5bTxC9jJPEfoliMsm
X-Proofpoint-ORIG-GUID: TAsj1JDzYaWQnJw5bTxC9jJPEfoliMsm
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

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Link: https://lkml.kernel.org/r/20220504011345.662299-6-Liam.Howlett@oracle=
.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16be62d493cd..8dbd68c414d9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1426,7 +1426,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
