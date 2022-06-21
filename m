Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD8553BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354535AbiFUUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354387AbiFUUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B952E0BF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:25 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ8opA004752;
        Tue, 21 Jun 2022 20:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RxkEZhj0aOJunFZF1J6LkXuIHHXutp6OCps0Nqsnx2A=;
 b=ZvuZ1pggPdGTW66XVgxLkWRop75mKrTlMW1OJJAdpxGACRmYgR4lgU6pqxtBiwe057Wa
 gTJw638UuaErA1ipPQm3B8mtRkWPBWE+PKEQfnLOFkX46oeTlaj0MJJHGVGTOVp+6TYG
 a5PCMQEUXVFd2Pk8o9lczwdIuNcWjWMGpMT8oU4xLo14noUwuEXqY+pDaPzdCs//erCv
 PQR9DGdQfoNdZPHmVQZYAC/E02emJLiuBpcGRpIzumR+iHpiAEOZq3I8xB0k8bthEOP3
 yER+AR2aU9UNNokM4KGIq9hxRUcUV6iVfndVb8EMeBlXEv3sY60Pwu4Hx/zRlcz79Hsy ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUha027847;
        Tue, 21 Jun 2022 20:47:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtHcdVIuT53G2DtKALS3bpd+YAV8GJ3byoCry7dtQWJdPHxHtuJnzoNoVRVmUPW8TWp+rfOWIw3fwOSNoFm+MdfpsX8BlwI8pEYt+cyGDz7zQl24lb0jf2t3ISWmCa4w4zD7psTs8vXTk6RL7wis+5Kk/8BYWPSYj6ucAHKrCAw6t62W6fAkF1QBTn0CVrsfUgsbymmRnUQGH0n3YJZ/9h0bkZj2WGYXsSpmDB1aRRoJ+v5kvSc+qjA1mqA+z8Uzvu5whfBDQLGFboY7vbfjsDysIAPaD9zgWm0Nq46zMmXkzlDvMmLo3oeiJBQ40YAZj9ktNn7G1M2wRHXN/6it/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxkEZhj0aOJunFZF1J6LkXuIHHXutp6OCps0Nqsnx2A=;
 b=Zrg27UhWnI7oytIbeKKuuhHfeicZ4mv3lvWMi55nJt478xZdXMfS6nBds/P7b+XIEHFsk4nnOtRG86WaJtCVdaBJ5dWW/QpCig8Fbqz8QDV4DziGT6nt7Iq5+GbNOQGiDolVHNRivI+OboBGOR4szBlyxWOFCtZKfggtuBnlAwdOSo+B2PTTuucVBfJQmGR+LTx2omvsBR2Wz0SMmdbsvK3ski7QmuFrxaHKa3oqTKob3GIEnCp80IStM1FinsvnoRJ7TMTyMCV+APfn8Cxvg8IjeP2sBPdreuKRr88Mg6ltLO2lHlBma+1k3sKH5ZuwXs4uc/OfWtenSAW2Glwimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxkEZhj0aOJunFZF1J6LkXuIHHXutp6OCps0Nqsnx2A=;
 b=QNELDjAE95HXtiH7jhawYZr1Rz8vCFn4UirCTZbP4aIQstRubkp8z1Q9gFwYrDE5Ru0Hr/zROfAtw8rTJSSH6HkTjwdaX0KtQmMdjKNYm0pz9Ufb1dLbA4Cv0aNj9M5xdHDXNR4LeAA177wL/2RG8EsvMZtQccEFhofY0+ciHms=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 20/69] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v10 20/69] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYhbAMk+GOApWXp0qs8SWLlVl5QQ==
Date:   Tue, 21 Jun 2022 20:46:57 +0000
Message-ID: <20220621204632.3370049-21-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eca6cd3-1cbe-432b-30e5-08da53c734c6
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB308595D4375DDE7A5766C3E5FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpiR4PqMPPSd2Xy+D5EZVFqmA0jcZ/NzJ4X81Cv00nlyJEqH57y8VfiXdV4vrMEpa3i71Kewffh9KpJdF5L7ezyva/jG524l/fUyhF43mQTU8vx2EyX47ESjSv3EYD//ce1zE4dWRsBwLx9JN/4MGs78Esr+cNlBfIBchkQ/iGkS7u4xMfVHWezeIdsAKakfWtc9PPPztBjV0tL5aeBiGgymfkIMmbkz3SZp+ARQAlJMZzlm6caoCcpUspOIIxfCZCbdIXOTUr4AgLrOmLzChB7Crxt9RQxhds7yuihuXlYd9i0XQzwEXN7xJFIb+ee7ybPnUgEQHrzTCV3YqF2gRLF97JOBffhxZ+os1Ifdt3yXcI1aX/wpBNSVnQFOp8bU+OzdYXLDGoFElTJTqXVIQhDs+0v9mK0rdLKTBQU3W8KN6OzfaYt3AdpACjtsDq2qzILr+1damm0z7ERa+obXOkH6Z80/a2oVM2NbR5YC+TazjVqcOw5OwJSlFg91oh5/RjRILK2jTyEq98pelZ5nRTXZa3jrdPs6ghi149hBOkPnys873fVEQg8hRwJlGwW+y3GLza+mhy6lHmXvp8V73NJF91OgBEzoopVVmMSi8RFclGlRAJmDKZ1EZZLeS69YG+2sTKwAGsfjZV6OTEhhURBC88zaPL+vp8We2FkAdkvEWdTAEyCUc7nHsI8hRj+enn38oIvp7HUMRYNvMllDi1VjgqDVW18wLEzCLIHSQRVCvEcO+W6zep4QQFoFJbr0vdx+wE9FtQTHwHup0/E5pkBrbFcP407wHue+eKG5Q4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XrN6EuoeBxUaAZB6Kd3ku98XuhLMiXboGzt42pmoQEvFA+Byms3jAX4a6x?=
 =?iso-8859-1?Q?2eLPG8yAN7pvno4g939ojkdznu8UNS4Jk/Du32cpYo/iNwKK0wUsYafYyZ?=
 =?iso-8859-1?Q?gqDbSzHAmNz3JoavlBEuet2Ns01ForfnWOYlkkbF+e+Ywv3XyHibwSI5dl?=
 =?iso-8859-1?Q?OwVoI1dVKwXsgEEpan/isctG1KUtwX/NBj6iajOXq9z4GcSF1APGvajSK9?=
 =?iso-8859-1?Q?YNbJNFqh99tGTOr1ikGrvWAQU+ZmT4J2tKdWy9s8dhalVNYFD+vYSINvW1?=
 =?iso-8859-1?Q?8nd1QHrxZ2Cz5vJvBY/NSb8GNdLxOpy8H8nN8ldVi+Rx0+GB0NFQelFodA?=
 =?iso-8859-1?Q?3QAW/WF7g0N9WSllsKDLfVodpPEvAMN6/HLjF0BjE/2pSc4bMpZAuZjU4S?=
 =?iso-8859-1?Q?UXDJW8rARJJ61PceWgbw5ukxgs7Xr+/tl8Iy3xZ0Rnxa8wi4z7d/xxJt9l?=
 =?iso-8859-1?Q?070jqDeAO8xMHf/gehkLTrc+me5Om5B3Y3aqSaAI1sC55+6QNjqOAvtOPg?=
 =?iso-8859-1?Q?3QRu/ZSoSJC9dnVuILZS2qCTvhGulhSLXZZc6omQzBdEJuw/oaLV0TfdTN?=
 =?iso-8859-1?Q?FNTpRLeB6KjS1i3VJ7biNYY0YJagCRT0K/5ae4LXvBxmExEdp/UrVMVy0w?=
 =?iso-8859-1?Q?NgRoOq0Klu0yqaJSyUquZ4NCNTN8TXtJIt/njDXwHLNBff/kQ53yBS5MiJ?=
 =?iso-8859-1?Q?9Eji+Zqrn9TzUzAP+bpvBZxNBnldj+EfLXGNnpPjvdiTYgzhO2QfaoT6Ox?=
 =?iso-8859-1?Q?lmrKOh3rXI0cA/OC93MldJNTFncHiNHScLqcxhQYKT94ET79j7nW5Plp/p?=
 =?iso-8859-1?Q?SJxZ+l6d+F1LSGcKIukSKCE+ooT9MJnPFT/bhFB5vCObLz2TPl6e1QeReA?=
 =?iso-8859-1?Q?0sr+UCzj14iWDhgihChUBJ3A1N8C+0Hw4AVAgCWcF0rQY4n1LIQsO2fpOM?=
 =?iso-8859-1?Q?0iRjcVsPZsFrvIZ03j1Eq1zrmaWyJvHT+DmxYoaoMgRY9ihrE0owZ7ANjc?=
 =?iso-8859-1?Q?SC71vgSD3CtpWPOzBSLFCme6gDRdVWTi4mAfRI3We5jVM5UTUbfa9KH3kO?=
 =?iso-8859-1?Q?VCDfJVxMM9qlWX6MYj1R4e/Oeh6oBAn8Dg0tOhZPTB3hgsJDFV4R5usTt7?=
 =?iso-8859-1?Q?8vROobRj0p5FNA+4jIFpg2nQ67rv6GeI8hX5sth2hk4wdv9pe+q9FIXC/n?=
 =?iso-8859-1?Q?AE6re3P2TJ6YpgXLhPzDYCKbpkyByaJSqFf3MlM7XuyTOvFjWJd+CWBg7d?=
 =?iso-8859-1?Q?WbjKf/EeHnsrSKcgbxmzr4w5tIzV9hiS2/2UNZ+RifzWYtqZQ68gB8he38?=
 =?iso-8859-1?Q?wGTLUis613l8zJO9NdYN/ejhgHLwrVkXVBgp+i5rfFMYvaK1ILMK1gVJVJ?=
 =?iso-8859-1?Q?9uz3ucRyHn+m97Yn0rrizLuqbZLYSNJxWO1iQ8zA9uyR1l2huOwMLccQeQ?=
 =?iso-8859-1?Q?JohImJKbhU46TJ9Whsf7xLmyd9ORqSlGwEKFwZYcOd1B4Y4/TlKoTXBmCE?=
 =?iso-8859-1?Q?rHi3sUezgFk5hxnKuTx1+sF9O3UEfh7SuDAxz1nZ7U23DhhD6I9ya3U0rh?=
 =?iso-8859-1?Q?fmAciup2VJDZzdgg2Xr8rCRaIVMpG90HVKzJ7BQ1okkHaWy581mKBYLVJ+?=
 =?iso-8859-1?Q?sBusqsWUI+t05lnouhtJeo059m4N9o+Q+KMW8CemhM0g2h3YoxEgHJuQ+Y?=
 =?iso-8859-1?Q?GO1fr/QJagtwvLBqO40XFtq+NffQf1L3rjR3cQNu+yi5i2LlniivITRycZ?=
 =?iso-8859-1?Q?xyqEQnkaHOkfVbsr1TH2CEpM82M8CZUTPpFn4mZK3Yecwia5848LdkY5mM?=
 =?iso-8859-1?Q?Vrh+T3F3WT2oElG3XA5GpPbq+TGW1EA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eca6cd3-1cbe-432b-30e5-08da53c734c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:57.8322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nP0OuUbl6bchBLXv5J6wAJKP45CEM5dxzZ1nfpWJlF94MoYIUuO6SodUbsw0bWLio0TMzRbGBh9ucqlQCfphzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=593 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: WeCKLbd0RxKblkQ-6vLkoYB1hYV0R6mK
X-Proofpoint-ORIG-GUID: WeCKLbd0RxKblkQ-6vLkoYB1hYV0R6mK
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

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Link: https://lkml.kernel.org/r/20220504011345.662299-5-Liam.Howlett@oracle=
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
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b84dbdb8e9f..f15301bd7f99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2863,7 +2863,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
