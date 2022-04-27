Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB15511924
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiD0OMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiD0OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:12:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB97D4ECFC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:08:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RCEKWN015530;
        Wed, 27 Apr 2022 14:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jkAPW0rBfFJHdpUtzOQohZmv+N9rfGyL2q2nQOPUpZ0=;
 b=vSl+XGaQHoCE2P4JgPfqqcUgLlpZkIYj0OtVafRdumhqrBwO/7h/H9koB6HnjjUP0jCj
 BxT2tvMTT6ydW0To6DncsUTtDl3IQmoCgcooJCsaStggkozO4c0Aw9BOH1PRQbVm3bfv
 i6XFJTsP1S/iR8gf01Ff93YiSAXXwBx9hHWxgoLcPaFPTuQDviGzEyZFEEkHS7Wk0oyW
 XqwUlpoRKXL1MHU8eBPzwDukaSnyZkX+D3TYcm1eX1NxgQRZf/J/vzxQQ/NGIrBQSCtO
 vuc1XKBreuWBIXkpGp9SHBcvpefNzl10A5hv+5FV9tn3AWecOoIjnroV6Dnfay1LRRN4 vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9as4ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:08:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RE29NQ036137;
        Wed, 27 Apr 2022 14:08:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w4txsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 14:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCPaCfUgGFX49Q9P28/+sNFZns9RG/m6TJ2ba0sdgYEpKPEdhFGdJdPo6KcYy/K3gBDnjAaD7ez/Yby2BBxIcG2uw/eW1NFpwP0xN/oz+lQ5rXyfc1AhtodSyanNaVIzSQK2KJdAwbp6ay29ATNH2MwHMdzl86r7vjp9zslifuXwm3ImVywDm6zzs40SLup14gYcl+SIzZwZhZ3rqmMhgZIFY06WkWycKkQvbBUtIGbRRXnZkBfSnAIAPyCSMbTuKKenRzhNTEqeSWOTzAb25I56BBLFVnZ5t+RcDMfPdOhZn0xE2YCuEjCvdF2A+3cvF8Zc4O7v762DYc1uif45yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkAPW0rBfFJHdpUtzOQohZmv+N9rfGyL2q2nQOPUpZ0=;
 b=X+Upky2alr/J2VelTlwVtDy6efjnOiMDPA/ZQyyM7KKwvrWfMTcLsuNaHkvJ7yHIZoxKCoaJYAzW5zWFy6PPl28lCOfdHuw4fUaCpBEugeALBSNk7Uclde8TzQmr+tJPSugS9RlD5A3zwWj/gmz1FV6P833gO8/ul0OWrv6/AIpqhiu5B/0pjj8r4qMm26wrOUgevq7KV+MVND+VKE/KRRF7OEhE0RG1kPmme0CEoiGudNKgpBdF9+gqucjM7U6N4nuhyw8nYMo9B1B/pk7bZg+CACP5ZDw6m+1+REw5QjOAr7MLVpX9wagf6MUFBjMKtn15uebRX0ZPtPKYkO/dGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkAPW0rBfFJHdpUtzOQohZmv+N9rfGyL2q2nQOPUpZ0=;
 b=A1cgb8YA7DwcQRjflG5vhzFO3+x4H+qCceE+ZBPIJUNVddh8a2Jsu6bvU2iBRHPAniiFDlb6SJLBTe60Q2S/PI3Me0sWtY9G4tWUCS0ug//9rhzfgFpQh2kyYqAoiru4m9Bh8+puXrCf+YvhUA81IHB3ajMWgh4bq9VDAr0blXk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 14:08:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 14:08:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYa0Cn+2AgAEtogA=
Date:   Wed, 27 Apr 2022 14:08:39 +0000
Message-ID: <20220427140832.mpvnnkkhrbupk46i@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
In-Reply-To: <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fee26bc-b3f6-42a0-627b-08da28576d91
x-ms-traffictypediagnostic: MWHPR10MB1582:EE_
x-microsoft-antispam-prvs: <MWHPR10MB15823A686A50B0B1DCBE5888FDFA9@MWHPR10MB1582.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gR5Tq4kcuzPKFWdEHxeapUAGi3vlKTfNUjRNY+SqsmL+FG4BeuxexxVaMKl5Vv4Ww5EtQGeReXyZ3+Z+ojGWEjt9Hcaq2yUceD0tqtCcpIHXbCmUeVhqGx5UmR2t1fA8SUM1E2GPhUbMWzl6ll/zYMLoqFfoG+2cyXo8odPFNNFiT3sOYnTH1Xp7U2wWGg/QKj6OJQ7XKB0UqS5RNB/rvtJ5rgZO807s/tULGwJrlDeEQVDWPWaO+E+txGIF80yPiXe5x8t1EMwfp2C1nWs0euODjCgBOCxHMU5pHIFmlMlRZKcUaFKI1+grpCySD0QWygnzucbMk3HFdNMV61EbyIbURrb3rahab+woXmCEOYadmRD7NRlEMJ8J5vv0hFwnJkQnoCSyECtuTIDPDPoTmnz/x83v9oMaZkeBfWwiPSILhWNDBSIev1uONuudPaPd+qJKmsO5RJ6jTF/IXLQU+xIs6AkTsMdH4jNziPvSsQ7SRuHPvw3824A7iWiSEKEPMZ1hofG6GKXnVh3xkkwgeXzZSYtxyVnD+0EuFTbaTvF60asE5KTjBXttKhFmMx3XtOFB/N/jZVimwD+XFRqqq/AYFL/TvtcQno0FizWJaGxSm5/HUMXiI9HGOm+r+z8AP3C9xT1WlFkJpQXRPXtZTh+RL49/0ZXSP4pbL0OAd4tAWE0J/9BzBOUj339k0QwfTvB9EA5vZNWREhyneubdSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(66446008)(54906003)(38100700002)(122000001)(5660300002)(38070700005)(1076003)(316002)(44832011)(33716001)(6916009)(8676002)(91956017)(66476007)(76116006)(4326008)(66556008)(66946007)(86362001)(186003)(26005)(64756008)(83380400001)(508600001)(9686003)(71200400001)(6486002)(8936002)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q7//JM31ABUsYIjivkQN3VerStEz2tMmMzt+pJU3q5OLfiJ/4M3IpcQPQQoA?=
 =?us-ascii?Q?jNROovbjFcTf1lSSpI5reJBjMjmUo71silr8/OcOQoEi//4PAKb9VAH0JRzp?=
 =?us-ascii?Q?2fgFqYV4RI+8ZEuAMSyilX6i6R2DTgkAv4ClkfwT/NTKJuy2ythPWUMkLJqs?=
 =?us-ascii?Q?nimi+enFjdHm5qfTEcu3k0APydI9pV74qsVbK9mTT5DaB0p9WdAMfX+u53w+?=
 =?us-ascii?Q?QP8cQXeLxq2ZsYN+GKUG/ONkXz+UVyzIbTcm2SUfwoRnLRXF7f5VJTmkpotJ?=
 =?us-ascii?Q?fVdZLRFeRHebUkXF8BHuYFiIgOXiH+kem5CrTJppUuI+DlpQFyoJ+epVTyM9?=
 =?us-ascii?Q?LZT0guFAMy8nPRqgVwyR/o3eQQZsY8Re3qANkUL5wg268trvLcxutKk8FScx?=
 =?us-ascii?Q?mfM/KISG16CpNDCmnr0xNro1gI8P6uGJ/+UVq+adzij5SzRlrHWD+Vqe0s+r?=
 =?us-ascii?Q?D9Rldht3SQnVoyBGiLhAcCXWndKy2pEVadsXFF7J2kpBp9k2bRSU4SGZCtSM?=
 =?us-ascii?Q?4CK67rcwhRVAmwcvX8AoLqbUgXooATzPwZPb6m6p2t5ZavsVSaWXkCqp9fiI?=
 =?us-ascii?Q?zOYzB0VTY/KWjfsEZLTGarP1o4R1XxzdLv4Fb+umzvsa81YIbMvzOT25JRMn?=
 =?us-ascii?Q?wvHPIuf30j59fIu8RknBhEqmNrZVJmj1vGW1neVrSpaUw1FgJHCIItVlnn9c?=
 =?us-ascii?Q?CWic8tITxagtMUn/9WesGPoPyJpcYyxbbjqwd6ks/B+P60h4y5g5GMyqJIXp?=
 =?us-ascii?Q?aYGg3rWSMO6NluqCy2zLvkM9ksOJAPvKzza2D+KCK03h2+RSuAAWnRlbzDF+?=
 =?us-ascii?Q?bsj3SpHAUz+qYxYidEa8pSUmg2cp0p0DPpyULLUtzIzPpFScqxF2a+ICNThf?=
 =?us-ascii?Q?4hrMIYSH4i6ShbFRIVnAm9g/AH7P1MoIYc5zGidOfM2MlEvg3o+xsrevIGZ2?=
 =?us-ascii?Q?wU1pTVIdf93YpiSWfJ3FFZPs+vDkjDkvQgj1j8PNUQWPeqzAGLYAsqZosGR+?=
 =?us-ascii?Q?t3sJVxx202LqvEssJmDd3YB6q9ucDJXw2Wteh3cnf8WPRgjzPTpljaLPgN7q?=
 =?us-ascii?Q?5yeZJJcOmqZ86TkGgkndOFr86JuT+ZITncMs8fSv2xOHwNcMxyUBxWNaWQPf?=
 =?us-ascii?Q?Sk0vVaBPza0m3clbv8DvtVgkLil8fiVpIkbekvFuhp7fN4PBX7uL/r9yrkZO?=
 =?us-ascii?Q?XXf0paxHPz9Vmic/6MHOdNaVllwXtvwWC1pcrNNexfA1Sg1XzRrIhanOF/+n?=
 =?us-ascii?Q?Ayt6GmvkD8KXgdFgi/pG+Yc8ukyuiJ3K4VGWyMqQJvxNDzcLyiAMCB2YqK7G?=
 =?us-ascii?Q?3hFG3nigS4uMH3+A1rdcitdBwtkDW9YE6ajxbvHOAFS9NXeaJmY8ByDopuvL?=
 =?us-ascii?Q?EHGaLMwV+CbwUWfgkgaKR7H7PXDURtJb7GDrOnl2Ys0e2Y/nynYyDgk4f4wb?=
 =?us-ascii?Q?KU50a8Bx7T1v6HJonx79hxo3jh++ea02CNdp/qufVNzYTo4vppE9QeZHl8sg?=
 =?us-ascii?Q?0ZDDsNu0eO9uIlTSoj9JPTUG7Jp23ATE6H3wtgzaiSm8bA4+1c6UxBECRSUI?=
 =?us-ascii?Q?7gRxHLgA78lapoNFrEdGisyY+avkYmRgK38V9pBFEvs3VCekRRqZLzTsdJMx?=
 =?us-ascii?Q?l7L9cCzTA9Y1Yp+uj5WxnyDfZFBv6XeZRYZxT7EWXiIT4iIA7Ao/sZUjoZzI?=
 =?us-ascii?Q?lZoXz0q/RJwiHE0udbpTCSE79LbliYAVi3s3SH79O1cGx4i1qdoG10WzwIsU?=
 =?us-ascii?Q?hXTEXwLOxjooSfuSpVxXMY5OFlxKMbA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <913558AFDD34E147BD532E90D3797DD0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fee26bc-b3f6-42a0-627b-08da28576d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 14:08:39.1388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXQvMztLfHtKCTfHYFGRV77xe5ococl/AuutHWe0zjpXtzt0hb7iP6jR8YMYhthyqjgNe808Ew6pZkLe3z7TmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1582
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270090
X-Proofpoint-ORIG-GUID: LLTzrGqPtTdBc8onZv1NgX70O-xxWdZg
X-Proofpoint-GUID: LLTzrGqPtTdBc8onZv1NgX70O-xxWdZg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220426 16:09]:
> On Tue, 26 Apr 2022 15:06:19 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kerne=
l
>=20
> I think it would be helpful to expand on "a number of places".=20
> Specifically which places?

Matthew answered this, but if you look for users of the interval tree
you will come across many users that do not have overlapping ranges.
The interval tree is being (ab)used because it is easier than the other
options even though it is not necessarily the best choice for the data
being stored. I don't want to be negative about the other options, they
are all really valuable and have their uses.  I think where the maple
tree excels is the ease of use and the cache efficiency.

>=20
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and th=
e
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
>=20
> "mmap_lock" ;)

Ah, right.  Thanks.

>=20
> >=20
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
>=20
> Do we have any quantitative testing results?

I was waiting for the mmtests sweep to complete before sending them but
I didn't want to hold up Yu Zhao's testing of the combined tree as it
has proved useful already. Please don't include the results in the first
commit as it wouldn't make much sense.  If you intend to put them in a
commit message, please put them in the patch introducing the maple tree.
The benchmarks are around the same as they have always been.

kernbench                     =20
                               rb5.18-rc2             mt5.18-rc2
Amean     user-2        862.24 (   0.00%)      861.45 *   0.09%*
Amean     syst-2        136.65 (   0.00%)      141.58 *  -3.61%*
Amean     elsp-2        505.38 (   0.00%)      507.99 *  -0.52%*
Amean     user-4        890.24 (   0.00%)      888.34 *   0.21%*
Amean     syst-4        140.64 (   0.00%)      145.32 *  -3.33%*
Amean     elsp-4        264.34 (   0.00%)      265.76 *  -0.54%*
Amean     user-8        952.30 (   0.00%)      947.57 *   0.50%*
Amean     syst-8        145.52 (   0.00%)      147.79 *  -1.56%*
Amean     elsp-8        145.02 (   0.00%)      145.38 *  -0.24%*
Amean     user-16       920.83 (   0.00%)      918.95 *   0.20%*
Amean     syst-16       135.37 (   0.00%)      138.99 *  -2.67%*
Amean     elsp-16        75.03 (   0.00%)       75.25 *  -0.29%*
Amean     user-32       970.98 (   0.00%)      969.01 *   0.20%*
Amean     syst-32       144.75 (   0.00%)      148.58 *  -2.64%*
Amean     elsp-32        44.10 (   0.00%)       44.64 *  -1.24%*
Amean     user-64      1062.19 (   0.00%)     1060.30 *   0.18%*
Amean     syst-64       154.24 (   0.00%)      157.58 *  -2.17%*
Amean     elsp-64        28.88 (   0.00%)       29.10 *  -0.76%*
Amean     user-128     1609.09 (   0.00%)     1612.19 *  -0.19%*
Amean     syst-128      210.05 (   0.00%)      215.09 *  -2.40%*
Amean     elsp-128       25.22 (   0.00%)       25.45 *  -0.94%*
Amean     user-256     1767.37 (   0.00%)     1766.86 *   0.03%*
Amean     syst-256      215.99 (   0.00%)      221.56 *  -2.58%*
Amean     elsp-256       25.20 (   0.00%)       25.33 *  -0.54%*
Amean     user-288     1772.73 (   0.00%)     1772.35 *   0.02%*
Amean     syst-288      216.08 (   0.00%)      221.39 *  -2.45%*
Amean     elsp-288       25.16 (   0.00%)       25.44 *  -1.13%*

Increase in performance in the following micro-benchmarks in Hmean:
- context_switch1-processes +14.74% to 2.22%

Mixed results in the following micro-benchmarks in Hmean:
- malloc1-threads +34.95% to -30.06%
- malloc1-processes +2.73% to -23.65%
- page_fault3-threads +19.84% to -11.55%
- pthread_mutex1-threads +42.50% to -11.76%

Decrease in performance in the following micro-benchmarks in Hmean:
- brk1-processes -35.35% to -42.69%

brk1-processes decrease is due to the test itself.  Since the VMA cannot
be expanded, the test is actually inserting a new VMA.

>=20
> What's the plan on utilizing this to further reduce mmap_lock contention?

The plan is to get to the point where we use the maple tree in RCU mode.
Readers will not block for writers.  A single write operation will be
allowed at a time.  A reader re-walks if stale data is encountered. VMAs
would be RCU enabled and this mode would be entered once multiple tasks
are using the mm_struct.  I can go into more details if you want.=
