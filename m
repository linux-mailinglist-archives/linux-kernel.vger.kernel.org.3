Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A27540228
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiFGPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343890AbiFGPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:11:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446FF551D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:11:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257EwMXL025759;
        Tue, 7 Jun 2022 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=t8I0DFBoeABdXcz+GmrPuikpzK5+dFSIQDUhZR+v5pw=;
 b=kkI2jCNNKSu5lImcKPlT7DlRZMLbdBx6Whxf1wXZByVdrLjuILYVLGCRGtM4zoa/vLVD
 to89kE2vnjjzgtFwMQbP/rPs8FcDYTX57MgaSkr7RbOCnhyFCuQvr6kpc5eqCoQ99rf2
 Xf07PZdDPoD4GS5w3yASpySC6yGhZjRL3q+8NU8gH8m72AFm0xD1rvBJAvNEiVBDo92b
 GsV2WtEnYEYhy+TFmsSm5BtLiGc/nDQgCAGjPj+AYitfLv+B8FXZgIHW36DUZtmDFTor
 xjhOE0bloX0JZheQd+LAiDTb+W72GPg1JQ6snoBdtH/VlVsU5oyBihG3tdEjSTdH5oFE xA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyxse6r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 15:08:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 257F6WsH005803;
        Tue, 7 Jun 2022 15:08:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu2mrg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jun 2022 15:08:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOHN5ToRIzr0zLRAy33oVQXLyf3gJde+jUs8E0vaQ0doKy/MvaKrltXm6ngc9e5opmtBxgMxd2rEph8e3UNf0ie9XPPV8xAL6cug6yxosuEZLajXpBsyhPiQYSByGp2xNVydOwinII5u11bSI1n8BFS64RJMMe6qwLgsKeg62hdJDY4/+Oq6sAQkKv+ErtH49CTqmjbPKGG1vHq1OZcW4PX7PQrzJ3mhocg8nSRRSk4MLnlH0q6oGr3rpC56TDuCTbFzFzfa9DPHXzbV92ZATM3Rlq2Dq3GHK6Wpmi9czQ+KdQIeOJTWdqZesiew7/0sfv+tnYQIxLZp/7xabDmllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8I0DFBoeABdXcz+GmrPuikpzK5+dFSIQDUhZR+v5pw=;
 b=ZHVUB5nhSKjwb9KfXm1w5+M9GbGC7yR+9Iqovna67DNLDYa+Ivw9ALh8F8GutzulfCBvIuJ15sGj74zcJpmp7TgkZPAh04nq3y3RUAkIv/0MQ2V3FH3a92CgCP/mysDmRr6lzRqkL35rf8prkUbt16/Vw9zeAq85pUKLUVP4GbK3geYG8oKY4r7ecDodY2jCUUhQQh/rFTdqQa47f3UPllmJwsCiCPOqiAFrwueqCNgvr2BBMEiQBDr40YFgy3wRoDM2G+gyJSpF9OrKPJpBlKBRLtHokg3VO+DVVRX9m3mQDPDvY99L1UEuJbsC/dJ2j95y0OfqbdEfaMaoi4QC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8I0DFBoeABdXcz+GmrPuikpzK5+dFSIQDUhZR+v5pw=;
 b=eER7pYj7ElpDChD1tsbfJVbEo/UGGIQxmVu4ed7OteDX0iAa4O5fZJOOTUntBg9RL0F9L26hhSBuCxL4LB6OnYKB0p6Dg/XGJF5Szitc7wLGy6pkYm7mu3HcKhEdv/wSu/Nq4MGICywdDZdOPnF34K64SoNQjwoJeHcrRu/Z0Cw=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CH0PR10MB5244.namprd10.prod.outlook.com (2603:10b6:610:d9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Tue, 7 Jun 2022 15:08:17 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Tue, 7 Jun 2022
 15:08:17 +0000
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
 <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>, jon.grimm@amd.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        joao.m.martins@oracle.com
Subject: Re: [PATCH v3 00/21] huge page clearing optimizations
In-reply-to: <CAHk-=wh89D_69JZtB0MNKbrTM4dPJisK6E0yFKH-hA++F13mzw@mail.gmail.com>
Date:   Tue, 07 Jun 2022 20:38:07 +0530
Message-ID: <87k09s1pgo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::13) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda2fea4-f28a-43c5-12c3-08da48978d37
X-MS-TrafficTypeDiagnostic: CH0PR10MB5244:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5244BE7D6D62866CC35FC189CEA59@CH0PR10MB5244.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb8z3t+mMoScFD7SrPzmOemNjFt1kZvKrQ6cqDqDbBD7i6T6ZbZy2E3FxJQONQR/dhDzDLJHdXX/4RZq0nxVZGiekGgzSy28ETc2jM9lvobd39JPbCan6UaAq4dfrPbL+fBg18E6vq1jXYL5DYPF+uYv630lMbEWIrNkHgwptiGvyt+e77USTID8hqFXpT4of2gCY/g4F2WNO8WgthDUW5tC3KUXrk8UZk4cDii+EM+sdSC5Z/+hQbrN06UanbWUl/V6Q9IkQwAxOYlnYjNuGX6BAtRvcXwC0AJjE5dY3/jiVZY7/hcaV+sPtzQfSiJop9XdKljW3BVnszNXxt9DLHgv38DHCFaU8zD3+7EIEOd8rDKJy5jdiKuL5aqmruoVNRyntpsBiATQEvWRLiihAkEfwJHd7uNnbotOAz7OqF3o5g4dAY31P0ZWa6xnUbXMqKNNg+EC4psT0t8bbVMWHRua+4In1r5VeLYJkkE7VpsmiNua6+j1PgaCfddm6m13pLkGVQ9UGta/0XlHpHthOlfq2G46IB4HFbfCilnbrOnzdVoLoZ/Btu9T+kPFnme10b7T2dbsZq3rqHzhhkHWootMsP0jBrRW9VyNi4oS7LLNQT0+rcjYj4VpLRRwZu9m7pB7p5mOAEGf/E39q+S0lDd1m3zeDcxkr76K418Z190jxH00oKe8fgf5ULdSKf59
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(53546011)(6506007)(38100700002)(6666004)(52116002)(6486002)(86362001)(4326008)(2616005)(7416002)(107886003)(8936002)(186003)(5660300002)(36756003)(2906002)(66556008)(508600001)(83380400001)(54906003)(6512007)(6916009)(316002)(8676002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SLv6FZAFWKLKZ4LDmi0z6yPjU91EBmB7LVhvn1gYx5U99hqO6E1cvNJBoFtG?=
 =?us-ascii?Q?Zl97Tu5ovTKxqx4dBGeIuAX0LiEvILnjFVD+OvNrkujuQIptrT6IKjA+JHym?=
 =?us-ascii?Q?Xl+1GNxgIdCs/yNgR4+otgHgXAGZ+t/x85GQj70h5mEgxSa5o1oQS8IFLcyo?=
 =?us-ascii?Q?ZRxANLuT+EQQgi8T6E6Yr/nYCfltsYCvyDlX8oUawbHaDg9qaVw2RLNRUMg+?=
 =?us-ascii?Q?OeY/iPKNJUKJr2ylQD1LcJdzl2od94vxzeqMZZUeIKMZam/719XkL/SzBpOz?=
 =?us-ascii?Q?1vOXonpygLK8HLnISQX6L5+Q7EWVBdckZloDMEZ2eHHG82Vb5t3xmrLEcCaY?=
 =?us-ascii?Q?r/4L8/3HSZHUXMZMsaNeaFK5uhMZuSIhHONzI6byHGLCyi8zwci67Hnoa7kc?=
 =?us-ascii?Q?j5+pzB42ShWQKKjSWW9HRdNXUA9FFKGEtnQsY0GYMxUV99LntXiiAL5evcam?=
 =?us-ascii?Q?dkvNqqO+z4HfHY9iI5rv8/6wizec3ewigR7GVEywkMzR7Vc52mCIcZVaffE6?=
 =?us-ascii?Q?/sjTFmIplEuKUZWYUr/rc0XTra3XF21yFLMbC4amBDP8Qb87Wb6Sa23u8dL0?=
 =?us-ascii?Q?Kj0QBpqQJ6j08lm3q5BPCGI++x3xTOTM3gDZ6B3qmlVsyIrhlkWDwo9nNaKc?=
 =?us-ascii?Q?bFdLhpk1jgaV1NDap6aEEuKX8MvBA/seqIVJmK2GTt0dRN20Mx1RODdLIJXO?=
 =?us-ascii?Q?uGmuTtXS5mhOXVfrRr6a1aEGDcWeDqWlxuTGPJ31N9/DlpHf6/832KAK3twd?=
 =?us-ascii?Q?Ue6azw9WKWNYm4K03rG6zYLLRBT18kUhOFcDmM8WFSyvVusPglKT2HOo+Zgh?=
 =?us-ascii?Q?4bToKXAuV/yhYa4RB0qVLP2Kn7WPA6fsa0ui9NrNlo5J4VK1NXHh1S1hUeQm?=
 =?us-ascii?Q?ncrBPOoL8lmkLJqxevF98faogeBmpHpkVthdthVMR2RQj6cGPtRZxy90wSTK?=
 =?us-ascii?Q?p/rSNdck+Uef7UgtLqjKACZ34FpkyJTwsNfusv1OrL6dzifKrXcrWPGXYIY3?=
 =?us-ascii?Q?dqyi5Ol608m3/ONYPVLw4hE7x+FNUnDMCUjINjDoE5DlHXWYvUyBRX5ypOGQ?=
 =?us-ascii?Q?wF7Kh/d7mAKBjNOYf63LoPJ7sHonVg02kYzEqV7mTlDOqTLENfithQMVGQr9?=
 =?us-ascii?Q?841rVpmin+hdA+BDiK6ji3OccYFI0wRuY8Bn/VLB4ktYqDrb3IlKaGV0iKMr?=
 =?us-ascii?Q?CFvDj1zTKZtd99Gl0h/O++HC/l6PXdNu6C+C6nttSjUaB8zVzhgTo1CN7Y/l?=
 =?us-ascii?Q?lhJKvcEUeL9V2m2fvJ5gejavsDfUcAXxtgufPz+Ck/Ct2HWc95yPvNkVgTHi?=
 =?us-ascii?Q?mMlhCfoNYeREkhw4YzxkL5zqm4xlZbAxP3vzfZN4iaetfegnRmJsR3oQosVR?=
 =?us-ascii?Q?8S1CnSU5hF9CNN2q2SZCx+e43k6J4+ZaxUr7oDtGHB+yICogqloBsNE58gln?=
 =?us-ascii?Q?cg/hAeizMnRXdRMYG5VIICltMvIiouk8lx2jIpBafvzKfQCg48pulf7D2/L+?=
 =?us-ascii?Q?vXbIKBYyCYHgGKlETARHSMbEiGrCDUwxlmbuCsp1UiMl8j0Kh3XciyHkSE+1?=
 =?us-ascii?Q?zQZR8dLmexWIHuvQihHErV/6PjBumH1gmPUVB5MuBS/qCiZxAseVHYcZddRH?=
 =?us-ascii?Q?tUMvWzNDGuw2xC/Q/lBnshjGXK5aCeUAqD0g0Rb8gOoXc6No5r1ILi9HTlZ+?=
 =?us-ascii?Q?xA7zQTXkF3uhk4kTB9FFtUpv5Wdp0pJKS8cIwRKQ26i4H/wEalx1fekceud1?=
 =?us-ascii?Q?VvZsB0qdBVkB613dG7OtLCGjT6yxFZkfM3L00aZlaTg2NbshVp247TMliJCa?=
X-MS-Exchange-AntiSpam-MessageData-1: SjdbI+R7P2gHC5mafH8oTudvb8AnU9Cglio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda2fea4-f28a-43c5-12c3-08da48978d37
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:08:17.7179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p03mMH5fJhkIfn+7OhhFDm/8vYyqQn5zB4C6bMaJbse/ZPzD6YT9QEVDrQBtMdaCS9+7H6FHWf4ROcyR8TYHnMlFZXya+FOzmLMun9sg5g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_06:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=980 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206070061
X-Proofpoint-ORIG-GUID: FMB1O9TD0zuUF5f1FSVvImRr3SBaO7GR
X-Proofpoint-GUID: FMB1O9TD0zuUF5f1FSVvImRr3SBaO7GR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Fixed email for Joao Martins. ]

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jun 6, 2022 at 1:22 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
[snip]

> So I really don't like this series. A *lot* of it comes from that
> horrible process_huge_page() model, and the whole model is just wrong
> and pointless. You're literally trying to fix the mess that that
> function is, but you're keeping the fundamental problem around.
>
> The whole *point* of your patch-set is to use non-temporal stores,
> which makes all the process_huge_page() things entirely pointless, and
> only complicates things.
>
> And even if we don't use non-temporal stores, that process_huge_page()
> thing makes for trouble for any "rep stos/movs" implementation that
> might actualyl do a better job if it was just chunked up in bigger
> chunks.

This makes sense to me. There is a lot of unnecessary machinery
around process_huge_page() and this series adds more of it.

For highmem and page-at-a-time archs we would need to keep some
of the same optimizations (via the common clear/copy_user_highpages().)

Still that rids the arch code from pointless constraints as you
say below.

> Yes, yes, you probably still want to chunk that up somewhat due to
> latency reasons, but even then architectures might as well just make
> their own decisions, rather than have the core mm code make one
> clearly bad decision for them. Maybe chunking it up in bigger chunks
> than one page.

Right. Or doing the whole contiguous area in one or a few chunks
chunks, and then touching the faulting cachelines towards the end.

> Maybe an architecture could do even more radical things like "let's
> just 'rep stos' for the whole area, but set a special thread flag that
> causes the interrupt return to break it up on return to kernel space".
> IOW, the "latency fix" might not even be about chunking it up, it
> might look more like our exception handling thing.

When I was thinking about this earlier, I had a vague inkling of
setting a thread flag and defer writes to the last few cachelines
for just before returning to user-space.
Can you elaborate a little about what you are describing above?

> So I really think that crapectomy should be the first thing you do,
> and that should be that first part of "extends the clear_page()
> machinery to also handle extents larger than a single page"

Ack that. And, thanks for the detailed comments.

--
ankur
