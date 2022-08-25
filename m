Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D55A1A32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiHYUWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiHYUV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:21:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1315AC04CD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:21:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PK417p027422;
        Thu, 25 Aug 2022 20:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eqs0m7ZXP9YKU9Nrp2ohg0B23ddErjr5UnSxhThsSXQ=;
 b=GSlNyBvk4F2LaETFraNFqWznNcC1FIyS5766OaupYIQcPhRv832nVz2wDJS5NK0Gs2Gv
 +Na9lvAPTk20MLNsN7L2z8z8cE4eLWsLWCTvyJd+KmEGv+aFr3MIIR59Ma5RWICi8bCT
 HO/LRbsgdNJq7c0uoytrxmnQNzd30A/rTE/h3UwkoPpHYfjuTTrpGxjAXLvkntF85aFN
 QbWXYxt0inycjp2tGGjBmXK7WvNHnZisA2tWdTFivuqWLM5eFiWR9cQiQIkS6wU/Q5l6
 oEYYUezxLEwPDzeh2zmvZ4BkUoiLeftQXKl66JjSuj8wuh2nKS8TvDe+/Gyrruvz8+Sf ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23ytxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:21:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PKBDED016760;
        Thu, 25 Aug 2022 20:21:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5850wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRqNGKXzviF7rRPaJ9NVri3nS4O68ehCSb5U3JKszgcRp0IhELSUaU1g6D9uUXNC3Ij5irSnG6Nnj3VvNPPnbsyKk6zWxoXzD4jLtDoRoixYvdsqWXWJbBVt4B+fLpUHlkNUP2g0P6h7OFouOLlQ4iGO/fM1a7316DPH4ej6pxkqpM4zUcXwwWC39FVtwV7i4gqrhdjYk7slXdEJCrsFHjyd6+rvOM4KOWmLfARReOwDORk3RpDqWZZmj7eXULgNF7PTfGrCI/ZLtSHkW1AcQy/Vp8VChm/y+WUpPf//J1UvdJhnfScbdDRWOsI0AFpad+SJwQTS8TvQSzwzHl7KAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqs0m7ZXP9YKU9Nrp2ohg0B23ddErjr5UnSxhThsSXQ=;
 b=NgQmd4RL4OBX8BrmZLhqS/1GGd4TqmAG+qJxc9qxpwDNG7pUtE4y+8+uZhlfwlzNxy0NbtuUfAprWLQ0igpAoAr5hBUv3G94L8wxZeP8qGm5v/n5DMrgA+ABtnDB9iZEHa77dOL74D2YRW0Mq53JwLn9C3uauBBsFIOaoVRk7hVBr0wehSCeeAjSSWbeTTaL/spiGMiF7c5dPyBJSnAcPGTompOrEdXR/kRq+ecPNcrRCsFdWn1DDANyy7ojQRhNd7ATZ4UUEgSvSVLpAjlo3hXoVdc2jVRhFArPCcJJIOcWvn0KbfqZYWZ4nGySDNVjTcAlBml5cMlL1GEl8hufSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqs0m7ZXP9YKU9Nrp2ohg0B23ddErjr5UnSxhThsSXQ=;
 b=pc6qVbKn6jvI0Hvo5Vagy4xamN/dIXlOvMl/9DCYfmEG8YQnRMR3vzgnZHiKDYGqyjnikpEhqGsU0/i4hvVKiXNCIZum2xa6/z0SvQddv0FLFWXl2suZvWoagLUR9izNCfkhAe/gbBDc0jP1xxImqwG61VXVMlnSVCvxdHJoqAM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1742.namprd10.prod.outlook.com (2603:10b6:301:a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 20:21:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.025; Thu, 25 Aug 2022
 20:21:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Topic: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYtjjC5w5a5sxoDUK1UuyGlVOoOa2+yHEAgADWHwCAACFQAIAAVDEA
Date:   Thu, 25 Aug 2022 20:21:35 +0000
Message-ID: <20220825202128.6a4pzhdntc7xsok4@revolver>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-58-Liam.Howlett@oracle.com>
 <YwbDmKyQxWHfRg97@sirena.org.uk> <20220825132054.ymenz4cewiemsxw7@revolver>
 <YweTKGvxzpUnbTkk@arm.com>
In-Reply-To: <YweTKGvxzpUnbTkk@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 468df39b-30e7-411f-cee8-08da86d7689c
x-ms-traffictypediagnostic: MWHPR10MB1742:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSCk2r6sWznbaYLH0QHcX9X+aGRgEnTgq8aBuWypr1SLkKKDEaEDHpelw+oGXff/XS12G0xMBUXca5Lhbhk4Giee2O4KDknXK2Mrq8PDmAKs/c1tsVfwqyq/CQ9qXTylZcjA/yF2OacTQusnjDZPx8cGhNg+XrMLMWABuoOSpOWzsLF7gIB5z1P2r+HIIXRyEpdkDqFlzfKY2EGcpCG6T7uTuClOWeIkF6ceKFypQrAT3qXDhP50FImJRl4jjLvxsG/1sf/qLYObmk5OeuE5HP58fQs06BKfJFvTyQViGwVhJeneHny3UyQF+2Tc5R5AHPtDObR8FY8qLFI1PFKcy3NY52zzGbHAbaLBgclwu1xWBAB7x9plf84KQpYAmNPZrM5p4kggwy2eCoLy6kmdr7KeoXB/zGgaL4fIUC4bd9JYtMbdzBOgoxVy63aDwCQPyl6Mmw8FcwkXgEWxLzd8yjrnwnvoyYnJXWpTLdEU6hJ/s+O46y6yTnMT/ZfBIJJIMCd7QmF1ylu+MrV2Gv6WTc/SVJAAPp7EbJguHK0WWEZaoPzIYQcaWppSpIJbjBM5L4mzt69hIJd84XeBdr+DL4rAOxIPksj5rdYs4/FzszwbbnWme4sQjTWb+eVF5mhyzn8reCi1iFRw1ciQJLdEVnVuBle+Zgtynv1BIsdB8OodO2bGg/QzLO0N9v8+a9F8qM14asEYx4kpdsdLBTliVGVwL34WDfZ2Wkf+150Xs1eN3YLcGvW3ZWvfzqSeEXFjdB3iG9a9NavokaMGv9Y8Xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(8676002)(71200400001)(83380400001)(1076003)(186003)(41300700001)(2906002)(26005)(9686003)(6512007)(478600001)(6506007)(6486002)(5660300002)(38100700002)(76116006)(6916009)(54906003)(8936002)(33716001)(66946007)(122000001)(44832011)(316002)(66446008)(4326008)(64756008)(66476007)(38070700005)(86362001)(66556008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2pcC6IaAjc3wdAfkjsV4hb/NavG356a6eRaQ9aRSRFH07XgWiZvbnbgaJGZJ?=
 =?us-ascii?Q?W89SDhEzFtWOQnO2/rWpTagxtu01WLYN0X4a2L9pKQNY24j4T5jGObjkgcF9?=
 =?us-ascii?Q?3R6IGh7GUatxJlZf3zCflp10G0HCaPs5FHqiC11QDngkfiFY5tbRPPLWpq6H?=
 =?us-ascii?Q?OlzRO1GBUFaEN9yCdsF1pO1lbloemmTUkwW9j78kTMZXucpAeZ5OLGNblQfx?=
 =?us-ascii?Q?nCAVvwpN3sVGVD4BtUEo6iJLoSbzlnZXfr+y3YQWhJQgOz+UzWbu2EqbOTEk?=
 =?us-ascii?Q?1w5Q/69b+8Y4pKsX+izd/2A+lhdm7ZwrKjqh/tPlxfg5r9zjCnKkctLFXYcL?=
 =?us-ascii?Q?QPAgREN7MO0zS/lKF6p/4MYTpa5FR8Hs897F+BMnZYLup3Le10dv4YafdSxx?=
 =?us-ascii?Q?DGdlyGsPY8mJSx9DxduI8osU9gr1SJw97PNii0jw2hoqZfOjCaECRxdyewM7?=
 =?us-ascii?Q?Ns2eqXbesKmcoX6vRPKgXufg+KU9W6hYOKdnV5ElfXDmROL/ect7JliWdh7H?=
 =?us-ascii?Q?KO3Pc9vUwz444SsSy01KBbrlCe1XLVkNpY24I3gC/QAayv/g1wAHCIvvhFvy?=
 =?us-ascii?Q?pZTaCOpMX3psQ1RZn1Yh0WMJTB3AIpVj7C0NuZXD5RsS1Ep1a1mGKyBz0x7l?=
 =?us-ascii?Q?R/pZQQAxgEwhBA62OqyUz33s2QfjxMmZQxpYEMWYvbAqvClzaPaRU+QuvWh1?=
 =?us-ascii?Q?l1T+NDmEddFbfz2FNapAbAXmwXYr40H37fxMdtHaamUMhOvUwWbcbGTkYZLm?=
 =?us-ascii?Q?Mt8BYQS0umA2krXG774IufH9Q/XBPwXjD7qYGgl33EHWsVXJTTMq6svL+SnR?=
 =?us-ascii?Q?rIF8mCYNVQwYFXJl9008caO3Q+TiECOzF1QPdzrXUE41hyoQEEik+m3JNHPV?=
 =?us-ascii?Q?YBRn4VNc1JtL1nFNaX6ejy5ZGlYy/RiAE9PbYiAOl9rZjEsadkBTeTMn+/wQ?=
 =?us-ascii?Q?JMaN3ijO8Fe7pobwJPAypkRhgtQJuoi4vzfrZADRzPNuyqe85zCFBXJWfo0r?=
 =?us-ascii?Q?vB/VJUNzo42dgP5FifOumkXn5uMDEo56qoNnJvUY1F9q5+DYXMZ21e0jkhdN?=
 =?us-ascii?Q?1uVd1SDF9AAzxlrAMVSv2OkCzVeVJ7rARXbmsSgPCJqbz8puBuP71rkSFvIs?=
 =?us-ascii?Q?slhBJEtWbrNFyhiTHMozFqaBKiZcqGQUbxAWFDTJT0Q2f4sCt3rtw+cv0ZJ1?=
 =?us-ascii?Q?llEDGTmyKHNcmnPyu9n0eyfTGEtJac8GUucmd6rYq1+rE1Wil5bc6h2Or5m7?=
 =?us-ascii?Q?NZlRLXlDFqgyDWZpDJj/qemYfGAmt6fFYrKiSWd6IpjkO4bjFk+r91lIa/Bo?=
 =?us-ascii?Q?/MiRHMZCY291/WNTReJIbHbdTBvwYn/kZyo7fB6/TRGB8VbhXJhnvSArDZVv?=
 =?us-ascii?Q?GXa0XZBb9y7VO32dCfniGduqCC4KZpigweA9LndnA8xBoJhqjHLtF4HOqRx1?=
 =?us-ascii?Q?B+bTxfwyc1fN2fnyc+wJlLNa4elcTX3XHTblR7JZiOXQ79G0fPoN9xoD2gjf?=
 =?us-ascii?Q?Pt6Zqy/JUBEEosMAbbcqh5DhsUJD/UqTZNV3whgbwVJtHWcvh9LNvlOUQamw?=
 =?us-ascii?Q?3gAka45EnC0Cu1/b+x/4n3H7YrXqNS2+l095wAfkpgDTShPftec8MqLJpRFg?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9244E68BE39A742A55D7F940F629E32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468df39b-30e7-411f-cee8-08da86d7689c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 20:21:35.6919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gD40yNSK2+iTbWjNR5xfY6prceQV8ef9pse+REHz/9NRyZmjo2RddHYb7cBRb7yT+EDh8N0l6YhoV5v99G8wGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=925 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250078
X-Proofpoint-ORIG-GUID: hPHvWBpSfvHr8ZrElxpru8Cw4_aTv_kv
X-Proofpoint-GUID: hPHvWBpSfvHr8ZrElxpru8Cw4_aTv_kv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Catalin Marinas <catalin.marinas@arm.com> [220825 11:20]:
> On Thu, Aug 25, 2022 at 01:21:01PM +0000, Liam Howlett wrote:
> > * Mark Brown <broonie@kernel.org> [220824 20:34]:
> > > On Mon, Aug 22, 2022 at 03:06:30PM +0000, Liam Howlett wrote:
> > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > >=20
> > > > Handle overflow checking in count_mm_mlocked_page_nr() differently.
> > >=20
> > > Our QA team found that since next-20220823 we're seeing a couple of t=
est
> > > failures in the check_mmap_options kselftest on arm64 platforms with =
MTE
> > > that aren't present in mainline:
> > >=20
> > > # # FAIL: mprotect not ignoring clear PROT_MTE property
> > > # not ok 21 Check clear PROT_MTE flags with private mapping, sync err=
or mode and mmap memory
> > > # # FAIL: mprotect not ignoring clear PROT_MTE property
> > > # not ok 22 Check clear PROT_MTE flags with private mapping and sync =
error mode and mmap/mprotect memory
> >=20
> > Thanks.
> >=20
> > > I bisected this using qemu[1] which landed on 4ceb4bca479d41a
> > > ("mm/mprotect: use maple tree navigation instead of vma linked list")=
,
> > > though I'm not 100% sure I trust the specific identification of the
> > > commit I'm pretty confident it's at the very least in this series.  I=
've
> > > not done any analysis of the failure beyond getting this bisect resul=
t.
> > >=20
> > > [1] qemu -smp cpus=3D4 -cpu max -machine virt,gic-version=3D3,mte=3Do=
n
> >=20
> > This helps a lot.  I think your bisect is accurate:
> >=20
> > ...
> >         struct mmu_gather tlb;
> > +       MA_STATE(mas, &current->mm->mm_mt, start, start);
> > =20
> >         start =3D untagged_addr(start);
> > ...
> >=20
> > It looks like I search against the tagged address.  I should initialize
> > the state to 0 and mas_set(&mas, start) after untagging the address.
> >=20
> > I'll send out a patch once I have recreated and verified this is the
> > issue.
>=20
> Thanks. I did a quick test and untagging start seems to fix the issue (I
> was wondering why mprotect() returned -ENOMEM when failing).
>=20

Thanks Catalin for testing this.

I can confirm this fixes test 21 and 22 above:
ok 21 Check clear PROT_MTE flags with private mapping, sync error mode
and mmap memory
ok 22 Check clear PROT_MTE flags with private mapping and sync error
mode and mmap/mprotect memory
# Totals: pass:22 fail:0 xfail:0 xpass:0 skip:0 error:0

I will send out an update patch shortly.

Regards,
Liam
