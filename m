Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA2554D6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350211AbiFPBSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349925AbiFPBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:18:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A51855A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:18:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FLcXrt009908;
        Thu, 16 Jun 2022 01:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=8SwV0/5jFwNua0Pc/eZdxg+j2wuyimGOWdThDWskIrk=;
 b=xxvPHTTYjwZgzgtQkjzU2CHVfMEFU8gw+G6N8Jg+xVGzLl6ZTftosfll1PKr0uPUiCIa
 Wko0u8DFmQK9Pz0uDFlLKjy+EXxSZe6UY+eAL+Vv7Zvyhw7qyk9Pfo5akP8BsqRbMZ+i
 6wp5kpvDNfnpzu+Q5cbY1nhd8ueg5FXXVneMVCPcaRJ+zQAp+K/4x7jwtEIZ7psQtmLe
 8ni7d9IAF0m7Smyq0sDeURvQzKlqaQkN3iXWODzDo7FHHvKmXWAZGhEffo4zswPJDoja
 NnORdpP6tCmoJ2UZzTsViQSoj4dCTERo5GRwZpL4JSztotTulHAu+tgAfYeBYb+ytBGC wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkthxpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25G1AY2n025240;
        Thu, 16 Jun 2022 01:17:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gprbsbqhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 01:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMHbQyfDlP0HaILbMB/1mOOtcbH1kvAiVn+7+EghMDLzRRjGpp/6HcaJdPj2PEoFQpImOPSajRkLVlIf/PQKiFWjNzIzl1zg/XKqCL838oigy2NtOcetHxTuNQPrYkS+EekLIq+Yqid13P3473aU0dULBGrms5xmXrbIW1WlnuOXZArT8JQW0XIcDb+ZfH2IEjfnOPZKYhUObNWyGy7LK4Q7LIr+k3a17yw+UP9D+rKNR9BcBNnhxdOm7zOP39+9fLzRm+d0v6UbQug1U635x/d+bljTksMCmL7KSk0usrBCBsTUbuRk+zN2p8BbpeicBPMEwZGOUe0qqP7rTbPbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SwV0/5jFwNua0Pc/eZdxg+j2wuyimGOWdThDWskIrk=;
 b=a5R1dhuBuUHYslJSc9bppjtHMp+/BW7bicsxgM4V9dvSQdK92Yyj5UgZssHm6HeuuvK1cIGJOLMQaZtok3c9VFcwukllCQzPtX1MXOL9HoGjjoAE1yahHGvHokxb1xRn24DDz2kMWH0dGiWbXEM/ZXL+d+xG+jl+vq4BWQ0Aa9Vr5hYYb2NFJ9gS8JKPKdljqaoRAIeV2bCcTscuX3X1NC50WYQZqp0skHsije1TuiSsKjSe0qnmw40H+js2TddAqZ9wGFin85oVubMz+1woCdLuOyZIFNwH/2e0LYthyxvXEtx5ky3fy5pWPzGN5aA99p1EmnFW1NLGAUqX1No4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SwV0/5jFwNua0Pc/eZdxg+j2wuyimGOWdThDWskIrk=;
 b=u/vUR7aLDxUKqBw+dlT6jiabDpYAves1gpYHfsc2bqxyQ9PcqmcVv87YD/xjXAV/626QIUKgqDDemnkbIkhGqP5JtrDmjwJ1f9AORMYs/LH4mhLfdXLblXSri5gCdbGExlhLSXEYlAVafBXBwltMgEhVPE/bowZRQWVuShY/zAg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3456.namprd10.prod.outlook.com (2603:10b6:805:d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Thu, 16 Jun
 2022 01:17:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 01:17:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 Fix 0/3] Maple tree spanning fixes
Thread-Topic: [PATCH v2 Fix 0/3] Maple tree spanning fixes
Thread-Index: AQHYgR7nc26jFVQMt069NRYC5tBF2g==
Date:   Thu, 16 Jun 2022 01:17:54 +0000
Message-ID: <20220616011739.802669-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94274989-79f5-4c2f-ad98-08da4f360a55
x-ms-traffictypediagnostic: SN6PR10MB3456:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3456CEB8935B74410CA189E1FDAC9@SN6PR10MB3456.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndNbEV46joP0OY0EVNeEglh4l1tL4RcXioV3OIlB41oCvOMunu4byhvu4Tyz0fjAh02On4s3BNYNyQemu4JuQbo/laawZPE+NWNM4+YngSCPF7z639jm7Ozi7NTpBYBT97mKjLOIIeaEtuvPnyQ+w9kHK8vcXg2VO6iPxdu4yT3bB2RkKduXIxR2bSFN+1SUdTVsGZyDoPpA+UemhsPDiSqrcG5aiMvo2tm8e340jASGUKnF9fAEK0VJVJ2uQcdQM7N+ALk36ubGReLMvPF3f6tNZd5sfY/ynuyMJ/2OPjVk51QOdSOySDw05Wc15sGuqrUP8Q+/0D+/6ExOofXzyjE4BBpnUVXZ7pMg8wYjgJTpIgA+Mjs2nfz5jK6DIbko0UmnYGi5rHjvxW+vbRAoIq53iV0SJRfdWAH/Ly5WRJhi30OJW1LwFVWeJcVwu8BNcooxZWtMfcZF7Yf8vfb3i6iTcxqMOzbcbcevNuGxSJpxJ5iA+ZvZgd7WRYkIUpTt3KOVygh4g9Ip7OoS3gLfe424SHFW3i7zWudk2GRIKMnXP9M6IIYMT3l+95HF+rCT3yEkQz/Jdrju2HRyBPK8+WY7bB0IvQSml4Pn+3K8J7x9IwI0W2crfHgiuqPy/BNvaF2F8d1dKcYxGSe+HGSjuZf0K2wpwWgskKF2OXoyyeoWQzkD4PkmHzVH7EZf+kmsGyJ/g1A7cjNzt5B5tq7HXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(186003)(66556008)(6506007)(1076003)(6512007)(2616005)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(76116006)(91956017)(316002)(4326008)(8936002)(508600001)(6486002)(44832011)(4744005)(36756003)(64756008)(5660300002)(2906002)(66946007)(110136005)(8676002)(71200400001)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ndwOiQGt60YtJp+7S+6/1joOTygaAhe7XCEM6eC0Kpx9HrEP1ytMyJWrf5?=
 =?iso-8859-1?Q?ME+WM6NFrXP7SfV+HRFrKFJ/vhroBWB/Yt+UUpMIkyu1FU90anBPCpRXtO?=
 =?iso-8859-1?Q?gUqKTpQ7kCyudRC0xyDbQ54Ek+k+NqQZLvQ9rodyzb8mKURNaa6t4PzYCZ?=
 =?iso-8859-1?Q?s6O37q3ALvT2sPQMNBuWDSKUFk8n262/fhjdOxyhTnXnXy3Kbluk04+HDC?=
 =?iso-8859-1?Q?yYJ8xNXRgr3kYarltHAgYKfjiuUUnQtUJrMN+2Xmu+v6fTwlbHQLjqN4fk?=
 =?iso-8859-1?Q?Zb6i330KMNfE+yTf+eHb/+i+YMrvCJSW03/ItKkfVTtAGJaEnE0jn6NAFb?=
 =?iso-8859-1?Q?DsKB3xbp9s3O8H6YSvEUKJc9zFJgstKWJDuENXq4+RzpPy0SCGZViZEeQY?=
 =?iso-8859-1?Q?vMj6wwFkZAkNtU9WrslVpic6vyyvyY897iLJqElyINUJGRytMcpx2C5HCf?=
 =?iso-8859-1?Q?sQ7LwDlOfm2jszOXzUBFcMRzvPFg/Hu+FZE4o4xpP4jc2OW5F75GeoUhK0?=
 =?iso-8859-1?Q?NHoBFUhDYdCxPv+0sOST5T8EvBM4vo7uBQSJR9Mc0wAldSYn/vixvtadHz?=
 =?iso-8859-1?Q?OrmToGVkr8sgED8rDk5+CQ/POWWbK34N40DR8E6Xxm1rFane8btpJNQZVJ?=
 =?iso-8859-1?Q?ZTaBFDccQtyXerYZiInwHOKDDL5gvFesVv2NhI7qACat/y7lOLoEuL99+l?=
 =?iso-8859-1?Q?u6nfCNr/8BTivu5T4Yn9c+9Q/iCjxdoSd2TaUZ9aiYQtTE17X5aTW8LXjH?=
 =?iso-8859-1?Q?UZrEGLyIUSAQBU59YobFyje/ZXh0AwNS8+pSNse6gEDYbsjRh/nT8GHWzc?=
 =?iso-8859-1?Q?hHS8DBM4TCJSP/AD3rzTAmnDACHI1tZZAsohBsI9xkcxXZE7nRbpax+uNj?=
 =?iso-8859-1?Q?2k4RakDT6O6RF0e1s/fflalL+6pUG41XORW6FP4XHjfxN2iD+e18IYSrnV?=
 =?iso-8859-1?Q?GOYet4oC1aECbNr9u9Fe29HIDMRQZIB797rdjUz+7CxJ+QY5mtrHOnicVf?=
 =?iso-8859-1?Q?PzDYDAt66BqNN+Vl8P0v8zz67+KWFhxsW/g8GHcdJuF6DC7BF9qwJW47Jz?=
 =?iso-8859-1?Q?4Vg39XR1G28mzbhLTyWZcQ4lF6rI/VrHtRMtbQbbVZshkY0gAiHbliI7Kq?=
 =?iso-8859-1?Q?FeCKVP503AOq9szVVLqS3AVTY90aSKcXVjHl4OA9N0IwWTnWHKu8MQUQN2?=
 =?iso-8859-1?Q?7R9upRzpRtvPSqX9PD+6WX881QU8y5VH1qSCP+bmafiRC21X8QuPzCfSx6?=
 =?iso-8859-1?Q?/DTE43clHy6KnaukexaZPaJLUT4gOBgbcGTSWw0TjLCo4bK3ngo6U7jMgm?=
 =?iso-8859-1?Q?hdNv2mTowmeqUx+u3mGysIsvtDRsQ4fvBt1N//fRTAWSz/IJI4HSVV2QD/?=
 =?iso-8859-1?Q?k8Kb/dwmskWjhwEl0eiqxggJN2XF2cA1IRi4lARxqtXIUexpjItOFsxLVM?=
 =?iso-8859-1?Q?7PSzJ9bF+AyEucMq1hb51915J6Qwx1STvZCO35YF2xsz9BOO7soJq3u6lW?=
 =?iso-8859-1?Q?5fjgxJJzQEOE7sh58qUzb0dPFjnBvMFD8qw3SXfPMSjDJzTPyO6MralqTe?=
 =?iso-8859-1?Q?zGX279YaHz22/2j2RHhGGNOquwr/idMUAVqyCugTFhnbudqhHPdCAvTFQQ?=
 =?iso-8859-1?Q?Ef1YtUQ0Dbw6SJMn9miIM/tiLC4acs7d9SY483A9R0ZAS0TK1rydIqi77o?=
 =?iso-8859-1?Q?78nYFUl474uUhjk5KwA5iZq0iQs2ELJs5V+ziuM1jjtemcygY4oXJnZQEq?=
 =?iso-8859-1?Q?2hrBwa598w85cTq5VXsEFg7eiUJyAVq4iL63y5evNubHnr4PdQYuM4RkRR?=
 =?iso-8859-1?Q?EAbLryPJ6PNKeaPlfPfAVkng+XMcYEY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94274989-79f5-4c2f-ad98-08da4f360a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:17:54.6093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wb8f1eWqDdKyYfqZXA0Q7XWchGsW1ujReFqLdNNG3o229JV/YUesId1Yo5V/tvaYnDY211WVCRdPWpcRQPTr2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3456
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_08:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=910 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160003
X-Proofpoint-GUID: 4oQ24OCDCtWt5mBxysziM0kkMxiOYML4
X-Proofpoint-ORIG-GUID: 4oQ24OCDCtWt5mBxysziM0kkMxiOYML4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please apply these to the maple tree series.  The first two should be
applied after 0f3ee6b87b "maple_tree: cleanup for checkpatch" and the
last patch should go after 17c9912bc09d "test_maple_tree: add null
expansion tests".

Changes from v1: Removal of debug printk left in patch 2.

Thanks,
Liam

*** BLURB HERE ***

Liam R. Howlett (3):
  maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
  maple_tree: Change spanning store to work on larger trees
  test_maple_tree: Add tests for preallocations and large spanning
    writes

 lib/maple_tree.c      | 299 ++++++++++++++++++++++++++----------------
 lib/test_maple_tree.c | 277 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+), 112 deletions(-)

--=20
2.35.1
