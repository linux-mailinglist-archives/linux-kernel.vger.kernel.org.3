Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A153553BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354447AbiFUUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354380AbiFUUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF7E2CC9F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ4NhA004714;
        Tue, 21 Jun 2022 20:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WzplbQx7UHqj6+5lf1Bo7goPdCygbqVhUEeBo617ex4=;
 b=C7AGdgxUbXvbWvB+gNsJDDVlrBQOeu9SYFXpOMTVbn56CWs9i7rMMT8IZL7mTq/I0u48
 8b5dJJLu6aQCjCSmtQgg3+AKdy7Q2xpevkpwgR/Aih2rxzZgwuQyHb9Eo91A9rKbaYmo
 YNLUfEmdbrOJDeGolLcXau11KqlMpc2F8tyRasEiH2gWGxtkXViV7j/g+jOhDR2BuVhb
 QjqxMSmDWmWq7z4HLhsAfDQIOO2QJ8HmaS7QN787KFK/tPYE3HlQvY+T5ekQhz8Ov+xk
 WqFgkozlgmJ1jjxPv65U7vBEUyj2FJO1aswGFXEdJ4+Z95UndQ0jwuDGTe4zIEGcFo7q 4g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhZ027847;
        Tue, 21 Jun 2022 20:47:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH4voE0DqI05f0ojbkpHmyIOQ+vHkgfef+Qm9UOJquioJYMFAyzOEdGpDXq5n0q2A0a8buzJkcSje1Je2Xi8KthRJ6iHUqvjpyl7Yd3pKM2R1zF1C8GGOcpJhy4M/9cL7pyBTaRxi08ASgeamf7RonbUYgo1c6XZLd6mh6QwYAaYBA8ftxI48LYod3UErRzOlPFcnnz4OaHqqsQnx5WvHXDXg/YWNiFSaHtcfhFWWCc2dVg/PuTCv5eucnWy1OmQKt57Kdj+JTkpo/oqgIhfs0gvHV5tI2s/ONoMMcTyljnQKjmRr0j2bIvO0RqmiJh3U9NwEGmo9So0FtAgHDtRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzplbQx7UHqj6+5lf1Bo7goPdCygbqVhUEeBo617ex4=;
 b=GxBzwhr9NBhzBnRd+MWJOGlwF7unkLhgHg4HJQ6PqXqYp/GTUzkRk5SFe0wivaIFNPhCqbSzoPwgpS58mNnuM+C65phbasHjT6eK3GW3/m9+9zLU8CB+khQJyLZcINqs8jpfTVmW27DJ/zx+lR7Yl6/HGYT6wn6GvdUbvtHNTvCJO0iG0qq8CzvRkBjyHVXR8Lzw9TOwgoP4GyArexuYpiHJxg61IiO98cb4qSLxhAJYrfgoumpY4Xsrf+6kGdS0ie9LZkDnf99TUUK4JsRI8agR3n6SJEivWv9RBGxZynStjL1uol/nS8+xM+f2UPlWnFAfQlX4pC+gagkxptnlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzplbQx7UHqj6+5lf1Bo7goPdCygbqVhUEeBo617ex4=;
 b=ZTYLlUj2Fw8SR2zwHb/SMbE8EOX64+uKFI785I832qzuP7ELrtnOOhnJb+VOe7MEIECfjm9w0F2GzLHyp5if2Ownfb1HhQTz5CFswVz5ECkGGZ9ogBNNXJ5zLKj7tTq/0jPJfab3R04zYIXQWKUBLFRVmZoDeX/QNVFyHjxvEyo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Topic: [PATCH v10 19/69] xen: use vma_lookup() in privcmd_ioctl_mmap()
Thread-Index: AQHYhbAM/jtODHr+AUirdm/bFOz3jQ==
Date:   Tue, 21 Jun 2022 20:46:57 +0000
Message-ID: <20220621204632.3370049-20-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d733183d-89d8-4940-530e-08da53c733e1
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3085F4F6149ABE6E2A2EA383FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YRbponWYdfpeXD1khSbh8YANHDtB8pdy1N3njS/zUc+ZnVISevGMFbjDk8KSb62Kx/A/NROOpzChiosykhAGy0PqENPCldkEIG65D4b8ZB+u6c1atq53V9T59KFQ3V4c2Rhe7OF2D4oKlGVEqwzcdrSLDIzXvPRjFKfQnyhCMGtZb1AHlZNP3d9fUx89iEbpg/wcAuPwIjGUeiRt8YKHFqbU3Cd2oOFZk1kwW/8u3iu7jAfxAhQBh0SsnOUXRbp+vBkjEaN8FyKuaLk8e6aw4v8/76eiFPEXBi+tXNs0txDa1p0f/pGazmpcI3qpQFXQIybllk38+EeLpBNN6axAuwrdZ9/ezDN447/nIs7HPwWOlL83bkBCSZKZ2MEj7Flm9qam2TR1GEIljjhjE6lxWw5YjxlcbItwvZHgnlaBhCKUIqbspxDViV+oaTf9nmFHZNiYmYjjaiL89BK/rDJ13gL2Rgd9eckRQX3qA8Ird+VtEvZWZKnjD19LZrAr/WlPP8oAAp3LcgvhnaSOzvZkpURnHM9b26qNq2X5gJIQzoHR/iTnEgfyS7bA6qHf/Qahlz2QwHKDwtpq1no1iUaFmVRULS4X4fGn59g12eCTL+VX4ZqNX1kZihoDH05ZumcxWlmfQqoooK6fx26cLufLEEBvwmiscQa10bP/fQNNjwMys6JtKzCRVR5Mx+Kb1t6q0VgjOwq1ekfls3mJnKhGOKlHUnoIPlNo8+8Hi/TWta0BSrpqA0xoo8D4ahBeGFRMzNsvDIeezGKbffd43jZsT7OygWHowhGaXBK8ZK/K00U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DdU9Ses9JWV25SmN0LO2Ci2OitwTYcv+YzmOfxnEmpOcQbWfeJ3oQaoBd1?=
 =?iso-8859-1?Q?ydeloWmlDvjj5qPj63QVqSF9zUJAMBfz9gTlE8nuZsN+bTC6ffWlMxcqC2?=
 =?iso-8859-1?Q?IvqR/qsz3Qk22PrEdy9+L8NzbsWo293bJtcRviXOSwRRvB0I5z6WVjzq5o?=
 =?iso-8859-1?Q?qASRrc2/tcZR4+MCgGGCN7tssIqTIdcxFbh+xJ9/cxiJqjmBKD7cgnk0Fs?=
 =?iso-8859-1?Q?zLN9cCo/3iUY6dxHhms7aolbeZq7Wf+lCTmtfnzndnuPIZJLKUVMH91RcP?=
 =?iso-8859-1?Q?4KokYOH56oPh/La6p2472F2gtKUIPKuLUIrnq7MlJ6EkMMYHKu1aVEohG4?=
 =?iso-8859-1?Q?rJZqQoybspXZwrM/dXoBIgpJbN8eVWBekxuqwhWb5c/el67ykINvGXaLON?=
 =?iso-8859-1?Q?WZRtBSlIAXh1PlHQ7v4AGl81knM5z1zY5Gsa54P69aVpYo7tU4/CnpncGP?=
 =?iso-8859-1?Q?LWmqCpwNYmzCT9HzmAB5GpucYs7nqKTVXgL7S2IyaToqkQI0O1flDQFRYI?=
 =?iso-8859-1?Q?Tj2rycnw8uqYsTfjseoYnsTmbbv3LH5ePPDyJx1XWG9gKnwKydIjsnd56u?=
 =?iso-8859-1?Q?k55OYZZOr0qetkRnOspQVga3Y9jK9wVm93h0a5gNeUpFN2xw6F0ysecFli?=
 =?iso-8859-1?Q?O7MdYWoTYUJDv4uxRFqAahplXh2eV5mmcJy5E5ktEH9evAi/fZhuffQc9s?=
 =?iso-8859-1?Q?oSbNjE50da8FpeRkU0ggam7akWOuf1pJRzJUDKU/qsWWvZjyR0hs212EPl?=
 =?iso-8859-1?Q?8YpVGhY92soPRm1VPea1k+o4LVB0qeQmYzfRU5hTb6OuE/qs0UjuCwyjup?=
 =?iso-8859-1?Q?bEnsY1FVL+wGLQ78Ainxc1pvX0gQ+Sx48qbzo0ZXZtYw9UaLsjBS1/37/r?=
 =?iso-8859-1?Q?bxVjxbHXOlqeGmMEHvUg52D/wmJ9oUA1mMoA7oKyikd+OJu5cSXdShWX2U?=
 =?iso-8859-1?Q?NHCWRPY+pEVO3wSMG8Sy+suEZbPmzfH6gVEa/LFMAmUxPmkA8Vv2GOJ6cd?=
 =?iso-8859-1?Q?xwUagdk1plr0hynb+vg84Ycd9HIUFYQUXSBPkw2E5cp+r6lCoGFj4XRUFe?=
 =?iso-8859-1?Q?a7gOZE9m76LaC6JDdNDafWvvruLfDkAsyTtkINA4iuJZPMCI5+PkQjpYji?=
 =?iso-8859-1?Q?AmMRlTVjhhIC/AKadyMZRUfvlNLTe3SmSqwoTp0SY2ya/07vVcgvx4+WEp?=
 =?iso-8859-1?Q?2D5EpBnz+Mo9KWm6Cif4zauc4ZbQ+bx7rtmoRUwOcIFNLigjABl19Y9BVZ?=
 =?iso-8859-1?Q?gqWUxIYDqbXa4/r8YmFnJ6hxUxd5H3lkRs5oftfwF206ZaQOeXPrJAdjza?=
 =?iso-8859-1?Q?yxXB/VbfupNmXNRJZk5pYMdNOwDqdR0sh+IyA2ldXy3Acwbs0QWEi2BN6e?=
 =?iso-8859-1?Q?aIIfGJo1gfzr27opSBC9x+iPouGuwuAuLELdKdMLnNTgWF/0D2Li0oP6LF?=
 =?iso-8859-1?Q?AgKm1E5elBDVrBED+N72iidcFOjHZq/gxKHZDhHgMIJT7NWbc4dHgOZT7A?=
 =?iso-8859-1?Q?6Ns2FK6Tu31A7II+mnF4gVr/BU/X8BQcUYPywQocnui172lIVE0cn2uFYI?=
 =?iso-8859-1?Q?gTc/Y8RfuJcLwEpbyHXLCdjPMkBh0D8Y1orRRsbxpEcvhyplxcHFeGnlJf?=
 =?iso-8859-1?Q?ICLMQkPLsOtKt7NcVj0fCX3NEcuOpeOY5sRxges1/GER89RzXJ7rIvXtfL?=
 =?iso-8859-1?Q?NIH1jTgrFJpxn8fCyrS7TizKt2CBv27MbPAyQZLrtIkQchGQBUC039GkkC?=
 =?iso-8859-1?Q?pDR5Un67j31V5ffJSYoj1KqdGcy5ZvhYPr/MehNwxQ2amt/4LpCHfaxIhT?=
 =?iso-8859-1?Q?bnsJElKCrH5kFajGkMTczSHMymIyJSY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d733183d-89d8-4940-530e-08da53c733e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:57.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LARet9OZGsKeY1e7O8JctmMJgTj5vXvshPLR83jxHvH6qAejedzJCCnqmqAwvCQCXavqNwCFiG53TsOtCI5tSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: L3DjX3fhyDLLr0ACg-OBbEJhRMqJyKH8
X-Proofpoint-ORIG-GUID: L3DjX3fhyDLLr0ACg-OBbEJhRMqJyKH8
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

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value since privcmd_ioctl_mmap() will exit
the loop if vm_start !=3D msg->va.

Link: https://lkml.kernel.org/r/20220504011345.662299-4-Liam.Howlett@oracle=
.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 3369734108af..ad17166b0ef6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.35.1
