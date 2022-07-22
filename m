Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC6857E412
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiGVQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiGVQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:06:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ABD2A950
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:06:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MG3nj8025144;
        Fri, 22 Jul 2022 16:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=TWxeAQG6JCS6y5WYpK846VpZdPjIy93klNT/5VkwywU=;
 b=O2FYn+pwLyawQurwzPGfz0OHBSDdYoELnKnE/d+Gv28r9KIuOPN8EZY9HBY4GeY4Ps78
 EN+dPl1zOgm/wFCfngTS71jJkk25wApVa7syfOn7iEApnX+Dl0Bq/9B78Mh23vnOdxtM
 nnHnKXhb2ZZZkbM2n2LcgzcDIbhUVJ1tP0zCzFnZZjjzyKT9YFI5UJ2PxK5FyJOVpVBF
 8IXz+U5RIo6tul433HgV009K3BgY1WTh4scEkIMnkhS17N/N6a7Lii7uqvRBdLsJRlIh
 Bccsi3xB8Q9oUnizKgg0kvFgqBCry3jHoU5s4m1JDBON3hkFwJJfIzuN+rRVZviHIIEk wg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42qxp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MFaeMS009795;
        Fri, 22 Jul 2022 16:06:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gkv5v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 16:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJA8F1n/Ex0kC3xwqUxCb1cr+xGyj9S8Pqkvq91fjy+GuDc8lOWizqwK5qG6bPpqteInwdbaEIHHKsKsdkgsD5cAauBOCREdaceJlYpsCGEYKzeuk5wf032xhVusZ3lYYtVjnyvjNeGkgYO6wiMS1gajzOZwVWSwTXgvKEIJZNQjvE4WORQv8q/unvP71QrQHh6kKLNOprdSI681ImEa8gGtchSTRdPwQSQDvW9XFY3ZelaeJzkC9Iozwcf4iBVfteCu1wYsjmGFIo1O4oyoVSIapyqvTZqKkEKcFqJG8SDQbYmwj1UMDmsmQZDrdx2dmlf4xcUrfHQ/Sd71zLvW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWxeAQG6JCS6y5WYpK846VpZdPjIy93klNT/5VkwywU=;
 b=gkMhLQCDUhtBklkHE6+5PM+7f8uAmrICU57UVkj3YhUsVWHqUUNJjXQbe/cz9vq0VdvyCiS5O3PmrRdBvDet3Grn9AGzz/A+SjAO3qxA5DYi3HeiAvIt09Ug2IdIQkVU+Joak9DK4J0RrYyF/3N4OuF4+TYYwSa/N05kffYpDnV+5qfjSBu3FAnrHDLNSAMontYu+CHaxg91pOLn1YpZ2tG9lRKmd9sZ6PmqIsJQ8KxIhqDj8ylx9l5VBZimGDr9OvvW/CLoSbn37d1BS1AQrc9jbdDskUpAf4ygOEK+dkBIDWAayVcxz7iZQIqAN/o1y6Oz5X5yGr9fyIycDqHz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWxeAQG6JCS6y5WYpK846VpZdPjIy93klNT/5VkwywU=;
 b=r23LVfb3UewDAM4nSDefqMafeYP+zVQ3CJAYmd0NUQkxJlypXkMNJ3BfMiEsSQtbYPjvJ06HBQjByR6RVtjWtFTN23MRuoCZdbZW5XhOpqETA3EH3MkIljudNd6kQIKpN8PnCCFF8Fzx+ZF2rgsupvuWh1sQ3XmCgofieRbmKws=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3877.namprd10.prod.outlook.com (2603:10b6:610:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 16:06:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.025; Fri, 22 Jul 2022
 16:06:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
CC:     Hugh Dickins <hughd@google.com>
Subject: [PATCH Fix 0/2] Fix out-of-bounds maple tree isue
Thread-Topic: [PATCH Fix 0/2] Fix out-of-bounds maple tree isue
Thread-Index: AQHYneTwWgHHpjaO/ES4VffVoClLzA==
Date:   Fri, 22 Jul 2022 16:06:02 +0000
Message-ID: <20220722160546.1478722-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ddd317-8d41-4864-18ec-08da6bfc1371
x-ms-traffictypediagnostic: CH2PR10MB3877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KyboZHFIpMkJXPW3JYiELREEs+GgIXLxJ9sF6y1fVM8T3Yp4rMnW4t/TsEecVydcdNyGFnxc9VYVECWPO+PoUf7UvNglnnZrE2Jxw08dUMiXFhQD/KcBxc0k4d+PLygKwJFcf9+QDnKUxVHy4EEYCpX3inOPBhd3xOGBeXBqooUwON23H3fCA33xVy7T5oLBHYyAQZfGnACeNqu455O79MAIHnGTT8ycP/kdGtVs7n7OwdyPfCwjbmG6mT7+0UERso8GNTF3svIRg3fIzuRIhmiW3c7IatmvD8/YMDIrTc/2m5wRApLcGA5tFOuqVPCoMl5g4WLRf0tdmDlg/iapmk1wgj6tXEW+1PGIU3hhli2GNXaaIPfFa4GUmqBD3T/C8xXYQBfn2NgQiXiD7AgS8NHjajLB0emSFPElL7QWPI/OsosOeQey5m1inlV/KDPQzvMUgWEhGUPnrtoodbBdEwONrUXPqgYxBwSW18qUuDJQrkY3EbdYmdvXCJhD66NEnhb0asWeLdQnOb8tDp40dOCXcaeyEfcCP3nslvg0qeMDACzuUMjxZFcphJq73Tg2DpknI+TSnxB8V/U8QoB7oXKbhfLH9T4BMpMmjYnnWHpdNRTaw+8+g5VIyfdCLReo9U51CQgr7770A4pCB0VZ49fknARJwvxUY82ni35r/OM/8wXQ2YUy+/w607a6CBQXzmGWktc3P0/YkXZzHlAvdRQeafOjXXp83Ff8ujysrEcNzlgNCjCHZMCelCvNosjLErlwL2t0FW7hEM/8Nl+LJyUvA9NtVA+TwXHifTXZnsxm3Ub0Y5SyORvWWASjg2vU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(76116006)(64756008)(66476007)(66446008)(66556008)(8676002)(186003)(6506007)(4326008)(66946007)(478600001)(86362001)(91956017)(2906002)(122000001)(4744005)(38070700005)(8936002)(5660300002)(316002)(26005)(41300700001)(6486002)(71200400001)(110136005)(1076003)(44832011)(38100700002)(6512007)(2616005)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UGlT5VysLDWN4h+ghGCbKXmzsyKCWV7mlqobyZ6liKwpLl72PgrAszdWKx?=
 =?iso-8859-1?Q?aJqPD6Rjcl7owptsYPHqyCUL7RFxE9XffE0Z3lYR1M5YMQrvSDFjBDjgq6?=
 =?iso-8859-1?Q?5lGjZPM1E/w1ek5uQqlfTHRDEMuj692wV7aQrK8xISBDDnu6TIWAze5NI+?=
 =?iso-8859-1?Q?Tx0VOQYMmT83lSnCgMUoiVs4BFxsUH/Ksx0vzrzmljsug5v9RsFJr3GB1b?=
 =?iso-8859-1?Q?5+/goLbzRHnUc7DYg1ZYSbgAdTKGpPTEqsKlR7ptBD6FlhOzWYLVjPeHEJ?=
 =?iso-8859-1?Q?uV78aHCtJ6hwv8VRWjyz5yX+Jqs8VCzwmewYJWImTI7nnzdkEfIGjmeXlx?=
 =?iso-8859-1?Q?J+Ie4bw5tP3bjAQM5d8pcogSIdE54EEpZFkb8Xsm63d0DB4Q2ybX3J/0Mo?=
 =?iso-8859-1?Q?EvYO3Qg7RC1Fy7baMxEmb2CAf0/LSj9fIixGLv1eVYcbLpd+2Aeh7rp2lL?=
 =?iso-8859-1?Q?GLCbGr0A/uQtyOZAcTgPGBgS4WhgKSjyDNeCtEc0CvFAwIBHn1EUIvSNWj?=
 =?iso-8859-1?Q?epSG5bpQCQF5ngVCd7TBAEv5QpVvE/Kwp3ob2nA1gb5ON/gncXHWOCrLdU?=
 =?iso-8859-1?Q?orZfJVOwwNbZucdbx9WoH/hdIqGIdSlvOj7zJyt3sCNRPzUSLKG/eKIbta?=
 =?iso-8859-1?Q?DOqTEiw6pCG1CWYbLJ2+t5dTrfaVhmWeD1YbnhOyvTfJ1ZSTFqkseAg3PV?=
 =?iso-8859-1?Q?db92bH3sjo4lfG8hBuYZnkfUoWgu+lSOVoK6cDfb/kwjiciTBa2OvqRCph?=
 =?iso-8859-1?Q?35o+4H+gOWrD6DgLy5kFapTKM/OTshnXZEawuaMduY7FMV1xykS7L7nYlA?=
 =?iso-8859-1?Q?CsAmR+MZYurLUN2qdyd18HttRA4LLvPHvi9xALfW4YFnBImsnSYqToX8cM?=
 =?iso-8859-1?Q?KBJrs5LRifkGhNDK8itcwtr+e3Y2fSrKL0mH6EewMFW60X5ZFfyjtv23RS?=
 =?iso-8859-1?Q?B1/4FrW2lu2cQndpsqrLAC8Iv8p3ZVZg27uzN3NssRbD8y0M2PlkumxQDE?=
 =?iso-8859-1?Q?cKMezxxNeD2oJXvG8oTTvHZSwC/74e10xh1Rlsb2dxNZ70YNaAq+Qj7S9H?=
 =?iso-8859-1?Q?wy64m/xOU+iKW0zJldHNiZAZqEUT8U7svyaRPHtgpPWCrgwIyWJ4pGTmyl?=
 =?iso-8859-1?Q?JOrJhwXzo6XLD5DOrBPZFv0kOzVkglZCtWY7P8poXOlpxPZZO41dF4p1j7?=
 =?iso-8859-1?Q?eu+uhf2BllUN3/VQ7InJmxUKkLVi1xKAFic7nISjVSRjP31cVreqh5Cd9m?=
 =?iso-8859-1?Q?CZcFmlt2vPx7V/YjPaVbg42sSGe37djDzfS4UNGbtVLjkgmPBVwH5jwP6q?=
 =?iso-8859-1?Q?u8nOo/QbdUtqtum6KKzvDEzqlzvHVqY9DsnAtNA6ty3iAx4k/uMqFgOYM1?=
 =?iso-8859-1?Q?nrPpuB3zCSVJQ8yfdyEQazzNh6MuIbq8y5h16i/ivcpzoSXJABeu4yLwc6?=
 =?iso-8859-1?Q?4froD14d3oqIxZwjUD5Upsm1ReEWeWLRXpsytSPt7iA0p/l1WwgkPHimpb?=
 =?iso-8859-1?Q?TSquctxLc4J1sEpDXZW9p+kT4U10SRPSdXtgbzSvBOlr5agC3Lsb0uxjvH?=
 =?iso-8859-1?Q?dtOsdk4EpW2SkpfDitxjsbPtuPkbyL0OGkSaAEyngSlH+B7DTKKOoqJ3Mi?=
 =?iso-8859-1?Q?ta+2KHHQC82WF8CNW4CMx+hUEBEoMvoqdejHkofng6dC84a1EA8LgN9Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ddd317-8d41-4864-18ec-08da6bfc1371
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 16:06:02.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpTssnb+oQhfGyX49tugm2w0FkmXc+CELIiCfEajnHOAt4hXl7LZlStLsPxjunOuTSPSQQkhcQzMAMFwGVgPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=868 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220068
X-Proofpoint-ORIG-GUID: CS0E_GVhdw8r6rS-Tg0Z9p6Zhmgd6AFC
X-Proofpoint-GUID: CS0E_GVhdw8r6rS-Tg0Z9p6Zhmgd6AFC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The out of bounds maple tree issue was actually a maple tree error being
treated as a node.  This was caused by the requested allocation of more
nodes than was available while forking, but there was no memory
available.  This series adds one node to the calculated
mas_expected_entries() to ensure there is enough nodes, adds a flag to
WARN_ON() if a request for nodes is hit with zero nodes available during
a preallocated operation, and also adds the necessary check in the fork
operation to fail.

Liam R. Howlett (2):
  maple_tree: Fix mas_expected_entries() off by one
  kernel/fork: Detect mas_store() failure in dup_mmap()

 include/linux/maple_tree.h |  1 +
 kernel/fork.c              |  5 +++++
 lib/maple_tree.c           | 26 +++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

--=20
2.35.1
