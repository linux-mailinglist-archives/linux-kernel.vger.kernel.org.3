Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AD1581B58
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiGZUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiGZUwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:52:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CD2A27C;
        Tue, 26 Jul 2022 13:52:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QKnKBY010349;
        Tue, 26 Jul 2022 20:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NvY4XKcyQXb8dseA361s+mjsCdDQZHV1fp3Jqp1mNQ0=;
 b=NOT2dolasOiHrPkBw2vmOk5eP8fUC3dUOZzbr4cqIZUb7ftEPbuYGYN5ku8rCjm+BJdk
 gMGYtvpYAAk2DcbqbZg+/nkWg3WITy/0/psnWoVZ/Ls+pASID9FODcxoLP2wYpbLHP7r
 u8sJo3PbKNVm4LK+aGuKi+gft+QgeZUPTTdoSpMDbQ6swf93uR6aA8SdxMTlGLWe9L3s
 C0ro8gEQazZpMxG/d8Db4swpP+0bEUUBKpQRddOdJJEyMPEpshuN6MZFpT6Ddmx4nQx0
 UUCbv3q2PW25a9rw+PbQKazatukO2IPFG6yL/XCnEwfRfVJlM5Qws/0+oxJL/CbxeuXg 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9fq03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 20:52:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QJ7f7o006274;
        Tue, 26 Jul 2022 20:51:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh65c2nb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 20:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2tfi8SmswbVmugWkXZIAwaRbAJu3PeqygCXW95YeY80WKrgB4CEvEZIt2ZSXlzPxAgEVQTjRz40Xlb8ROqhutr6Hfo6OFkAOf37fLVL89K2t5kd2ZLSO/YVl0KHw//5nURXLguPoDu6JOYAlbu4UZVFajsOoSa86T0DIJYP0WRj5yaigaZzGR+MaVDVN5n1OTwfGzY3bxwTVe8E+kvp8p+al26QxpsFTs7/Oq7ZzxGd2UqJkoWJimc3sA6EvhQEcBGLrXhcpTbgudZCtk1uK2rDa5graVxWmSSyum4cwAjkWFJy31Us2uoz3BOKljnYgdhtLMbNhweI7opkbz5R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvY4XKcyQXb8dseA361s+mjsCdDQZHV1fp3Jqp1mNQ0=;
 b=FCiSsV2J7QYYHtvkY4NbwV07UCvGbxL6U38MbuMbBKg+wvVeEtEaBz4ghY3KZWxiMDIizejcHwdo7IKGiac8GaQUu6m8MY/FFUnaWHaHObpDthxk1mwPMOP+2S+w4L8uvvx7AnXRlGSoUHHMHIxcLbReyVfSybiOfLpRzXy3jL8F9GdpqDpBT028PvVj79+m/AFEQoZKsxNNQlLoAe6x2eg8lEJtrw1H5VyZzMeD56F72hJt7lFUYr/LnGHbOMuBuZtbe2ZV3xdCHTEBsD0OsTWqOHyN6wd+5msTyTKc64CJnrRhX7EPlPR50pzhDLZhhkdYBxONYZwaaAKJOI/Ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvY4XKcyQXb8dseA361s+mjsCdDQZHV1fp3Jqp1mNQ0=;
 b=yODZBEa6LnlY8Kby0yvw7xKfTeXnLowaGAaioxCZmj2xlY5Bxl7bk0So+yk9cpJ/VJuXfL89Awjcko7A1bvf8J7gyMq+kSohiKsTBkm8car4+X5dB3IM2YN4PRRdD8Knyqkk54XH+kauZYiTRPx8S4waWR5ruQ9/0XI3tUcxmwc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 20:51:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 20:51:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: run time warning after merge of the mm tree
Thread-Topic: linux-next: run time warning after merge of the mm tree
Thread-Index: AQHYoOIvxkBRTwM62kG1//iUr5jiG62Q+kyAgAAm/4A=
Date:   Tue, 26 Jul 2022 20:51:57 +0000
Message-ID: <20220726205151.nlcpzavgs4vcjeqd@revolver>
References: <20220726212340.72499268@canb.auug.org.au>
 <20220726183217.37gnocd33nbjuguw@revolver>
In-Reply-To: <20220726183217.37gnocd33nbjuguw@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 219cbe61-f6b9-4bba-8e1c-08da6f48ae20
x-ms-traffictypediagnostic: CO1PR10MB4596:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H7GN1voRm2mrwnRqABhUsLqnn4WWsMev2jLSoHhFfC4SiG6bpijYcN3Y+iWpPtmPSelUx3nJ4JzcLt4oPNujFdwUGHILS4su/jCGUfrYKZOq5r6c9I0Rrnqn1A/A7E0x8eW+DJBzsLTjmVWr3X9CUyj4eYbfJW/zg8d2BK96kfL6zC0YV+DfzaW8RdONKN0E0S7v9W9iEw+bhVuI/mcObYCICoBTkTf8NlCmBsty5dro0d3nbmyV8NMVAV5jYhQ3GtC9UDJ6qKcBECa0RL1B+FnKc/11z3feChVjpuK1CbY2leRTS6l/83ThwcpFsCd3j0vjsHttoHeUNrUWg7stlc8zPi1jiG0Pxnq1sRNIrloiQu6R/GiAnOOUwk9KlU8sBPVNNVSiRaaFvmt3M72nyVmKnbm5yisQhUUsyhzM9Y///aMPUahuqlUDtL+6/zVsUcaZJzI7SRuv+wUTlVP0rxhXWuNZZHEe5cPG1FlxC+rxZRn/xRyAeHN3G6au0qwLfT7iUj1L4WieD9gR4ivaid/OsquW5ggX6F4SYvUNBgUq/X8dnEBLAQnve3YCXerL8d84b4cGnPgP1meXJ+lF3BKzrDriLtq1yC+kLtXJbGqlvjN5yhflLrccVL3iEDNbVf0w/j4QfzX9jkjg5NUDKLWrMhPUUdLx5PTuue1g95VIvF7Ua0eTwjq/q3fpnn7n5ptuDFyMu0RABBeXuOfG5W7RvrvGwCnnZCaWlYKpkKdxH8oXtuAMHylkf+gqK+yCRkLz7YOYqOlKv4Vpbq/lhj7cIrO/kCm7tqt/vMq0ASM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(33716001)(8936002)(91956017)(38070700005)(64756008)(44832011)(316002)(5660300002)(66556008)(66446008)(8676002)(66946007)(76116006)(26005)(4326008)(9686003)(71200400001)(6506007)(2906002)(41300700001)(122000001)(66476007)(83380400001)(6512007)(186003)(1076003)(45080400002)(86362001)(6486002)(38100700002)(478600001)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sfte90qK2UGvaNko53IPUgcqeEBohldQN8VJu6/OliQeP0ryaL5ts0qLTT6?=
 =?us-ascii?Q?R8gsYBiIadnLDqKbyXLLOcueBX8dHIG+fF3BmCDtK2P0wkn07hFmMGS5m4Ac?=
 =?us-ascii?Q?hlK7c61r14x7aVs5Fm755erIMwHI/EpQ4ekRaZeb8E+jaUu+QIR/NEgrnoMt?=
 =?us-ascii?Q?ZLPcA9M7hJN4FnjNLAFkjPucgIzVIjLh9d0ensCGiOKS+ecE/DpHyLHI/J6Y?=
 =?us-ascii?Q?XWnJmwHtkWz+ohM2Cx6oqkUTWJpvPpxjhVftGOO+HT9EAzXN/Kyj8fia3CCj?=
 =?us-ascii?Q?TzEJcl1WxStfU5+BTN4YErImuHMRIvNK9idhuEeacdEtOx4OkunBe6C1eC6o?=
 =?us-ascii?Q?TYO1xDMuT+vl1LC1h5HuEx5QVBlLCiTt+Bp1sBWUN1KhUnTOcYtvCFLq1gSC?=
 =?us-ascii?Q?hJUC9/WQTK2iah1pKl+H3ozGN18JxIfnNliBdVtzAvphZEx6V3qIYM425Kaq?=
 =?us-ascii?Q?YYzEl7p4lZKuOOPwp38FLiRYJll2ZKlO8AUqerbrIg5fmdiP9wqhHDVFK9eT?=
 =?us-ascii?Q?DPLuXiUz4chCcA5641EJnasEgvR1jga6b0aj2b7neKcY8kHOGqctlIBtqy3b?=
 =?us-ascii?Q?0eW2udz3BTWljKVMtd6VBykYw2FI9RQPzw8egcfUVVRMfgzGgpk/yeIPXLEb?=
 =?us-ascii?Q?kITkVFM8iw5fPUf5HcxUKr8Fl/ZN9NW+XHm2+UzVNzofNOmIb5UIgC8WFVDe?=
 =?us-ascii?Q?8B+9fHEdF/uzFo6aHNoYYfYHk61qifvPppv1qDCSG8GZt5BuxrvExutdHIL9?=
 =?us-ascii?Q?7RQxLr+udaxrx7FsNwZ8KW/t97K9efKJRiP1m5QuTyDaTSXIJ2b90n31sjjG?=
 =?us-ascii?Q?3rTog+tOPsPDAfEOmxuvQNX9do4sjW3dqd07rBPcUfZ3dcuq1U3AAb++Eh2s?=
 =?us-ascii?Q?UrIfC74JDa4ZXjF4Tj/SxBcYfqDqYWusod0r2bJPvJiJZ2x4AXtlKaZtdmBa?=
 =?us-ascii?Q?kRKQWlLX7L1BKbBgXzkBaLjx7XwSJyYEBfo4Zwj9lVl7ERLjLov+fyYRBfCG?=
 =?us-ascii?Q?VSSeVqJxcco48phNJckr/SrubqDlhk5U3K3XvpIlatMir9wCAiu69A8GTgEd?=
 =?us-ascii?Q?aTKiExpaB3t457ErSphceq7VgStijhx5pKj8lhK9e6oBpXpkjqJHHJSHhQsn?=
 =?us-ascii?Q?X95Er6MF7Plsx30t1ZqA2ZHENzhkSn7sOtLucTkUg11m9yEsaGPWHbVRZL4g?=
 =?us-ascii?Q?/j5Ky/EJ7IYkwOvlsAM0edEHgKfA7dc5VYGSFZnqun3PDhm8gP+jsH0tcbLZ?=
 =?us-ascii?Q?LG9N41yrI8sP3g0k1Rg3Z++gE5POQqFrr/yrJQo7KhxvK4SEsCKVLo1zI93p?=
 =?us-ascii?Q?ZI0fVVp0Z9wwrZtnYI+z705YQx7rq+k7/lSrIZkCBgn/UHt3gsPoHAt39iRE?=
 =?us-ascii?Q?WBnU0m2VqV7IZyOwHZf8jcyXCodPiY4LwGk6knfyqtHtIz75Ex8PsiSBWhmz?=
 =?us-ascii?Q?IKYHbVxE+OhxnzSm7FLG6/FFr+Lx1tYrZ4+tcZICjiYkCB7bVAuGx2m8SjIb?=
 =?us-ascii?Q?gyl7ncqLdHDIh60iRX9gN+/1OXG9+QhQzx0oVzhZa7h3kWKYmAbx7oL1XzR9?=
 =?us-ascii?Q?BKXOFMLVy2AUtF1HpeCBtsAD7do+KCfQEA9oYhKnkrMqGYkbekZZBjJpbijz?=
 =?us-ascii?Q?LQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0AD8765D0643748BE37571A12F1C23F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219cbe61-f6b9-4bba-8e1c-08da6f48ae20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 20:51:57.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoT6qVhCZQmczO7sJXHIiUuAF4Nvpis/wgZkwgvwASFi/uaqt9tMbe2RQxBzpBNlSmO1T2SYyzWkARjEEBDU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260080
X-Proofpoint-GUID: UNjVtdtoCGlaVeUMQ93I0X13PHltRLgR
X-Proofpoint-ORIG-GUID: UNjVtdtoCGlaVeUMQ93I0X13PHltRLgR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220726 14:32]:
> * Stephen Rothwell <sfr@canb.auug.org.au> [220726 07:23]:
> > Hi all,
> >=20
> > After merging the mm tree, today's linux-next qemu run (powerpc
> > pseries_le_defconfig) produced this warning:
> >=20
> > [    2.579447][    T1] Freeing unused kernel image (initmem) memory: 51=
20K
> > [    2.597718][    T1] Run /init as init process
> > [    2.725683][    T1] ------------[ cut here ]------------
> > [    2.725993][    T1] WARNING: CPU: 0 PID: 1 at lib/maple_tree.c:1227 =
mas_alloc_nodes+0x228/0x350
> > [    2.727071][    T1] Modules linked in:
> > [    2.727515][    T1] CPU: 0 PID: 1 Comm: init Not tainted 5.19.0-rc8 =
#2
> > [    2.727924][    T1] NIP:  c0000000007e6d18 LR: c0000000007f5434 CTR:=
 c0000000003bb950
> > [    2.728030][    T1] REGS: c0000000034c3770 TRAP: 0700   Not tainted =
 (5.19.0-rc8)
> > [    2.728190][    T1] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  C=
R: 44428480  XER: 00000000
> > [    2.728584][    T1] CFAR: c0000000007e6b70 IRQMASK: 0=20
> > [    2.728584][    T1] GPR00: c000000000403ee8 c0000000034c3a10 c000000=
00279f400 c0000000034c3b28=20
> > [    2.728584][    T1] GPR04: 0000000000000cc0 0000000000000cc0 0000000=
000000018 0000000062dfc850=20
> > [    2.728584][    T1] GPR08: 0000000000000001 0000000000000004 0000000=
000000000 0000000000008000=20
> > [    2.728584][    T1] GPR12: 0000000000000000 c000000002970000 0000000=
000000003 00007ffffc35fb60=20
> > [    2.728584][    T1] GPR16: 0000000000000002 0000000100000000 00007ff=
fa43c0130 c0000000074d03f0=20
> > [    2.728584][    T1] GPR20: 0000000000000002 c0000000074d02d0 00007ff=
fa4350000 0000000000000018=20
> > [    2.728584][    T1] GPR24: 00007fffa434ffff 0000000000000002 00007ff=
fa4330000 c0000000034c3b28=20
> > [    2.728584][    T1] GPR28: 0000000000000004 c0000000074d0480 0000000=
000000000 c0000000034c3b28=20
> > [    2.729676][    T1] NIP [c0000000007e6d18] mas_alloc_nodes+0x228/0x3=
50
> > [    2.729769][    T1] LR [c0000000007f5434] mas_preallocate+0xb4/0x190
> > [    2.730100][    T1] Call Trace:
> > [    2.730277][    T1] [c0000000034c3a10] [c0000000033f01a0] 0xc0000000=
033f01a0 (unreliable)
> > [    2.730876][    T1] [c0000000034c3a70] [c0000000034c3ab0] 0xc0000000=
034c3ab0
> > [    2.730990][    T1] [c0000000034c3ab0] [c000000000403ee8] mmap_regio=
n+0x2c8/0x880
> > [    2.731102][    T1] [c0000000034c3bf0] [c00000000040494c] do_mmap+0x=
4ac/0x610
> > [    2.731206][    T1] [c0000000034c3c90] [c0000000003c5bc8] vm_mmap_pg=
off+0xc8/0x1c0
> > [    2.731307][    T1] [c0000000034c3d20] [c0000000004006dc] ksys_mmap_=
pgoff+0x23c/0x2d0
> > [    2.731408][    T1] [c0000000034c3d90] [c0000000000134f8] sys_mmap+0=
x48/0x90
> > [    2.731539][    T1] [c0000000034c3db0] [c00000000002efc4] system_cal=
l_exception+0x184/0x370
> > [    2.731639][    T1] [c0000000034c3e10] [c00000000000c53c] system_cal=
l_common+0xec/0x250
> >=20
> > Introduced by commit
> >=20
> >   872b9f073f0a ("maple_tree: add a mas_destroy() call to mas_expected_e=
ntries() failure path")
> >=20
> > At least reverting that commit makes the warning go away.  I have done
> > that for today.
> >=20
>=20
> Thanks Stephen.
>=20
> Where does pseries_le_defconfig come from?  I have a ppc le config that
> I test, but cannot find a defconfig by that name in the git tree.  I
> found a pseries_defconfig which is BE that I can try to see if I hit
> this issue, but it appears you are running BE here?

Andrew,

This is the result of a bad merge.  Can you please apply "maple_tree:
Add a mas_destroy() call to mas_expected_entries() failure path" before
"maple_tree: fix mas_expected_entries() off by one"

There is a change in the mas_destroy() which was lost, clearing a flag:
-       mas->mas_flags &=3D ~MA_STATE_BULK;
+       mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);


This is probably due to me missing the Fixes line off that patch.

Thanks,
Liam=
