Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180357ADE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiGTCYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbiGTCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38461D98
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPur031784;
        Wed, 20 Jul 2022 02:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=pUtSYhMI0qC04E7iY/eTl/O3bBI+YpMu/n8LPGxa0cmc2b5MR+lShOwFVjb5F7lGmhlW
 z/gtbFI3CKVvXV/sOvEgdQEo3R1ODdGiYcp9iTwh9Tk8GxWB5S6qA7SX5KjniZYAE82a
 chdFlntONaot3MZANIMQ+kIJqpGBmcXx1ffokAMXJFUqeBPbHH5eeyjBilfeYeOzvY1l
 /w9L2KVZmqZwewuFw6XyA9cdxQhJiTIrqOlxbBPIEiuKozyG2osa6CmW/VSaTHP4Igya
 vcRzu/2BiCnE/d0KzevwYmWyBIHwiByxusd25pK0ZHXraV2AU9FKVJ+40EWSlXhZUbr/ vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2AVgI009816;
        Wed, 20 Jul 2022 02:18:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ww-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgsZn73Mx+6LuK9u1MW0brJyeRPEDrSGzUJgY/BkiD4JSV6x3nm5quKXBMJd9YMyPXL43oBuYKKXcdLXbYWMWA0r2XNXQsEMu1EuY1d2DiVECmHs7jJIerssutcNJ6PqWjDAwkFmIvXnDPXJBRrtjaqyvYVV+JaYeVuA3vA/XjxZQHvbYfa/fvq8TryA5XJzuewHx+9yZqGuHwPMuh/ARvY6oG6+g9UcvwZ0L2tB8rgQxHFCTlEM4wVBuoL68eqRfdZWNoY11JNH2Bycaic7In/v9PC5MMvn1QO3WfzQTjyz00aR2VddVso07ssW06eyeLD7136gXV/j5GTKrLQO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=UTYHdnWIk6OQA3eh16ey0mJijRjgBr77sksnYTFQlY4aye/XDuMDYKYO3FCcG6aPVM63SZKJ3fTxnZW3gh7DC981YK6wqx1HX0Ciii1wprkwmAEMVgMd24DNkRjdSfXt31elviQdP2ePCJMZOrKg3idthSdT8Q/Ti7xhtGHFyxQrNpns33S3L8Ld6NisOXmX0+sdpVPTzxn20NnVd9R29aUggZ9efwbHwHNElDz8Klbr2n8ABeX8R3bQBUEQ1SQbzomnyD2KVeijMzvn/iyjiL5HP9Q1K5ZL1Qew8xuWZn1Qm76LxQEW+k3jaDsGH3eI7QHxJP/FLm/mTyY4IJCRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iEUrGA7Q+pr5OPzK+e3mZOWwFcPcmnp3Vl0Vo6zTqA=;
 b=S/ooAgCBqD/vhWqNyt7EiAyK/wzLKsmJAmobt0BOi6rkucPMY64KfyJL431gH8GGEA+T5ODFwyAcSFH9+wQQuM4JsVgyKkvITct6fg1X3JaanW9qfU3nu2P9EEW702Uilu6qVcfCWXa8MIyEQHBwmt6agAPuchpUQqPBaLkmOSo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 54/69] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v12 54/69] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYm97vTId+GnCmKEW88pS1//A+Zw==
Date:   Wed, 20 Jul 2022 02:18:00 +0000
Message-ID: <20220720021727.17018-55-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 055205ad-2b36-4c3a-7355-08da69f62a33
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mznMITQMz1fmQn2L4sDDIiVnnKkcVF49UNRQSedIfNAhlw7Bed49/KbCeab01UsZrPQsmhV5NpmuP5DYmyANYhOf2iiAO5kcaPLAPBn3XsDR62T6GKuBsyg1jKkFFGS0suw06C0IrvqHSxQSMPftJWcPINV6O5vr1KUhQVBuWvGjhsl/taDRdi5ykdWTdecNGYLEbA78ixCNDGDmPqAGsXfS/lvQNO+1DtBtTn9nnQxPdlAYHt+wHwRjQi13D8W9RoZp8YA0Uumz2GQeE8LNBE/LckHYZD1gtk4Qz7XdxY9xpltMWAV2QgUclnJ7uZFeRgGVrF3aJRgkefzqmXOSjfcZByd9pl8bSZqIvV9bYyuLgJ9kJd0GbyJsjuPn3YYlv/zMMM+VatqZJJbaEY1kdTi1yjWM8vkMOVIq/NvcgsBGqXw7vQW07XXVz2f5wO7r1Odu5y8/hX8GJ6GIs2r8Fg8B/wNupzDRqwRCfkNM65PJ6xuNc4RlOcLwjs4tH/MNj93onfLph8syO++xGGQmGO6gbYltpnEsCI+zJk406NvQMiChv0qfynagY4e0HlUk+OYX5JCZ6NttI4xudgH8iNBhQFX3omWOWiQslwulN7831IivGOYcMpxnaC8x9Dwa6xSsA1OkDudaFOgjI7sVzUxvBBWi+8rNgmqi5jHPdXLx9z9zcXJfSJNAP/xpSmJDalfutx5+NX6l3lEU8hWEA/6r91ErzF+RkCtPAlEahLKnXI5Zl8g3OjUaVNO7ne8DJmnWSbPo1sTbxkEHNOOeBuzIL9yOHZOxHhClD7H3BPMOHzm5DFZg/fznHgQlhhGGrI73LI9fjKhP7SeXOVhNdT8HBc3jQXKdvXmjfKHtq0nsVIq5sGu67cO8X6oRVrl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(4744005)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?njufPKymex2A6gqZqHTh9gnb9kuw021nwWGsNqnQMemrpwQvuPG2Da9kud?=
 =?iso-8859-1?Q?himX5fuTQWn9Fxv98+CoAHS2BJhV9ZCsPzfCSsclvT7GskNqOm/udQPiAK?=
 =?iso-8859-1?Q?4eoniFzcdXCEMkkpo1SJ/8BxlDwGuBXNCeklmu/MLwmvA11+Gyr4+uPXla?=
 =?iso-8859-1?Q?D1JPH2tk9pycOY3ZTuRibscLTya+NFG3ADO4acHmuziWb56RrqcM+i5/nV?=
 =?iso-8859-1?Q?30L/vpJvkvYysIlRXSwR6dZnUs7zOBnNK+qLEoR1z/VIlX5LPLshJAYnrU?=
 =?iso-8859-1?Q?ZZVPjIgN+aFyLwcoRPl9dJyeZTp2ugn7FDqmCj83tGUGM9OgmdraMcvxAn?=
 =?iso-8859-1?Q?KqtE54XBMrqAiihEhYutGJ/jatM81yu9rnLoFbHP1G7O84p9a4yeaFlGRm?=
 =?iso-8859-1?Q?7sjy9zF7R6PF5SjXSPiqnOikkVIIhBQTGpaPnJ245BAlYuFW6Agtyt+VmY?=
 =?iso-8859-1?Q?r6srO94mIzfhg/ZGQcToy9eAMjaA3JsyjAeXchnEYA/bJ4tEijQTD6t0Rx?=
 =?iso-8859-1?Q?qMTU2StqePTpmEwr7pAAvORBicnaRb5vrupZaa6WxQiC4ouXjxx3PS/OBY?=
 =?iso-8859-1?Q?jl+FICqeZL2ZSjzCjmEcWfvlAMZyPqmR8PENd61Qk+6Uz5U/poVnO52L10?=
 =?iso-8859-1?Q?C0FMvLPI/5cwD3MvwTOMx97Cl/qTVe4bugHAhM9B6Yw5NdxSATNTbV+1Po?=
 =?iso-8859-1?Q?73EHvPXbjhYoX12HtbFjRSr08jhJztr7kvoCMAICu0YtffcE60/1fx1WqG?=
 =?iso-8859-1?Q?dUUVkoGIrMCiw9NDvJyFE+Io7Fpgc2i3A2TtakT+ZMy26jrviy4PkPzsPk?=
 =?iso-8859-1?Q?yphzvKmNemXxSmKpg8iFe4J5/aKdN9+jSIGCuKcarfYopzDSgjd8O+mE4G?=
 =?iso-8859-1?Q?AcRvbnAWFyp1gKXDsashm0GotnU0vP5U0+WGpnDB7wb34x6Ip9kMSc2wLu?=
 =?iso-8859-1?Q?rC+sV82A7akvduh7qwYgQ43SXneRv9OKUj9KtAViK9EiWnkiYCd1DSEw6a?=
 =?iso-8859-1?Q?hKsf8lPu5vfbcD8yoZQcvFA//HOyC7u4Wq/JtZ4y5yeqNVMfBeTfT8us7n?=
 =?iso-8859-1?Q?pBqdBl0KRGr+LQCem1YyzgtGobbRkpSZ8y/46bxc+sCkt1EQJ0c2xOde+4?=
 =?iso-8859-1?Q?J2RfWSWcL5pruYIkfa0rS1K04xnHEGP5G62Hlr7VFzDgx+Lg7FfFqwb573?=
 =?iso-8859-1?Q?+mjHSWfDbU/hrXyLa9H7BXaj7ZNC4yyrwfC2i5mdnzJZA2Lds/VAfbQoFY?=
 =?iso-8859-1?Q?EvWku0WCeYgkMybdY4I12lE8xegKRCpL6YyrvfLeHJBbWmxUVl0G/ezlM3?=
 =?iso-8859-1?Q?WyvOVg2Ey+NfUnYEAGaxQMyTCmgNcNZ3D1DmJDrM986p+4U3+fOr6Ow24B?=
 =?iso-8859-1?Q?Mo48NmwE4Nv8QWKo8bhq1T8eeYeQ6RH6gEE7WvDW6PAx1MEvRnrZAxi7pc?=
 =?iso-8859-1?Q?Pg6etn/28tZ6owpXBHvlMd3mliWfTAbzj4GZzzPkBcpbBD0JaRaXgGbFYE?=
 =?iso-8859-1?Q?6ca0P4SY627kqDUwnJ1vvkqelRGKvh+iN6aVYfFkEcx7v9aW4zC7cOlraV?=
 =?iso-8859-1?Q?jawKWF4/Y4CmZUcVdgKMK+Qj4vAl07l/4eVE1jAgu9SDJBkWD5QjjZe6Z4?=
 =?iso-8859-1?Q?2sd3s3KTWadqKaawzohxgSAu8jTCxIVVfe3muX7BCKO2XXOoAUWMyeCw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055205ad-2b36-4c3a-7355-08da69f62a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:00.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBjpID4t9f9jXKP6zm+woFmNvLGO4S5JfxyyGqUDgrUnf5lLW4EhGHd+HmSbZWdr7U/qtdIuBt9rFt1bTsbiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 9Y3nhwvgd9DJqGtXEWfaNmv9v7qilMgQ
X-Proofpoint-ORIG-GUID: 9Y3nhwvgd9DJqGtXEWfaNmv9v7qilMgQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

madvise_walk_vmas() no longer uses linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-39-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-55-Liam.Howlett@orac=
le.com
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
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0316bbc6441b..12e8010c766c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1238,7 +1238,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
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
