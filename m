Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF04F574A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiDFG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358288AbiDFGdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:33:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6736F6BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:07:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235NRhmO004895;
        Wed, 6 Apr 2022 01:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4iODF0iOC+kLSXMaGcnPs4zF1dnILwA48GhzA6VfFPw=;
 b=fGtmgzs0UUmRHFLPQkLtkizR32FGqdfLGyNyUeHsikwb2eauy0p0vMi5UcWLmxOlJkiN
 sWeyKzvvtoKbv94MGYRDa9F64z7EQeoKenNIFTKd21vvEE4BMM2uZvSbGgsAY5h6urCG
 paVkc28ntERGgN/ARpGFnF1sZGcQ9tq8oRK/2sMQDf15Nh7Y6BUe9bXNdGwEfKDFjlqX
 dKU9vi+dW09UBSHi2u5lF8/ZFHr27P1N3pMOvNj1l4GkxHklFJwmUkq5jhm1z/DHETz+
 hElLt1UaJKyissIV9NBm0c3rbOmOWSORvIeh9Mqw4qtl6ji8oxHrUd9H9/al2gat5e7z Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92yhxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:06:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23610p6D008369;
        Wed, 6 Apr 2022 01:06:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx43j8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:06:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLzofvkR6nhhxxp3JMHfhV3ZZVcxhYbTVE2uxQ4GjEi9cq48Q9YauGjK284yCEPtPusrzDLdhY8hCaiUKROCs2h/5QrzJZQ7iXSBBNgFVl5556zR28XTxLQSIExu7A9EP6ZoQiLwsi0mZeN3TgcU+jmMb7/PF3X1+9Eyyha/CwS3/BTNrdHmuG8IDRbpnC+TP2QwrzBjIxlgdqD2H2PzK3hgyw46hfz5dnyYF2Oi3kO0nF+wAfJqHUeZTL+N5a/k0z/EArSb1jWukDi3YZWg+5otqmVP+dVxC+uVkem7Z51TgxHycTTfTCVdEErZEYRSh01ZqcpCboANfSoFb0NgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iODF0iOC+kLSXMaGcnPs4zF1dnILwA48GhzA6VfFPw=;
 b=GAB2pdaHMEkjsb+MczdghCtV8ffbBz1LMrnySHwC89encPvMiuugkhl2DY1pgRnyJkioDmqhEmZEbxpv3iDUNMr2JwqSFhoN6zLruF5wfyy7aO7JhW8JRN6BIZDW8jYsnRnIItlSOyRE/9PsJLTbEPANBpCSTvVhS0xo1reJZ00VxVkZO+6jZOQ9ZHI0nStcmfmlEbBj12kISxbj3yajTNHZ9+snhvEwC7FNfY/5E/QD5+WQGpudLIC/lWP+qu5viVORiCe8YBkxLAhx3/4RLRx19W8yWNu0WZ27b4Kkvr0Y6NtDu/ETT0nPnotqf1Gu/G2+UWn08m+VS1zyCUsrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iODF0iOC+kLSXMaGcnPs4zF1dnILwA48GhzA6VfFPw=;
 b=jaqBf99GBiHZZKHkD1A7WJcOdiMkEMtP1LLYa1gDotVWQs34q+K9/NoFIEyQsT40vkak3lVqYGiZ8UHYYA0BwzjPXSvckEAZcqe/i9zPqfjcUDL7XmUISRTlj2Qny9ZhxGeQ+0KgJq5BZ0CkYpJ/iEg6BOAAUR8TrxB2Rj6ZSvA=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MW5PR10MB5851.namprd10.prod.outlook.com (2603:10b6:303:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:06:42 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:06:42 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Yu Zhao <yuzhao@google.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmscan: add periodic slab shrinker
In-Reply-To: <20220405235426.GY1609613@dread.disaster.area>
References: <20220402072103.5140-1-hdanton@sina.com>
 <20220403005618.5263-1-hdanton@sina.com>
 <20220404010948.GV1609613@dread.disaster.area>
 <87ilrn5ttl.fsf@stepbren-lnx.us.oracle.com>
 <YkyyCcdJq69tO6ba@casper.infradead.org>
 <20220405235426.GY1609613@dread.disaster.area>
Date:   Tue, 05 Apr 2022 18:06:38 -0700
Message-ID: <87fsmr58bl.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:5:74::20) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b093cd9-3a3d-46a7-32ef-08da1769b611
X-MS-TrafficTypeDiagnostic: MW5PR10MB5851:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB585147F9A45501F1C60A5DC7DBE79@MW5PR10MB5851.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayTNp7XF+9eM0uHXLWcYLns3+NiDJ/J0LuXGfI4/9vagW53h1vqYZMFlEkTTa1g48gCfxYlxYsnE8yJsYkKf7KGd5u5Ahd1LOLk5yKsr7VD7TTz7wrrT0OSTwrj8tiCjR1PRAD0lzfRNzwWrb/1jwRVlUTTXmBv59T14YQA2ajRQROfAfJaZHWuTqmFL2efX97/yxUC4uA0QwUqlwNbPcJeVAa8mvJe0GqR/5ay3SSGENUEnou8vjPgYApcGg5LZVLML4AB/p2DeE3r4dAqu+ZP9y8pvlaQBAdEf/s2zQBWGtZfkZa5RKIVLPynQTsZNkPtR4OkZKHc+JTogGU3E5LnJN52CmWDjGyzZ2lEZ0kiw6rNoHQk4Z2i82F5ckiM6V+WX+lHvTYnXcoJyy5rdlnkOf3qnjlv3NYJFLqlEFkeE4NPFUaWKuSdL1T1Qekr/IcgZfdDOE0LYyvv5HbMVbbg/Dw8ERt1/bVM1hiSL7SY0pntZUAO3nSUAcHyXpb4Ac0httNSiifEscwuXhgCNMOQoWFTQ4OD4AjH6rXpGm4Yq4aOBOvOV0bVevj2Tqho5ZsmG4wAIUnhPsFBmDkTvIPkJsWA9YpNBwIbkNIbnJ0uva0wEiOOfThShNzZutG3b/GimmMrqkKA7xO18STFHv/SnKjPG4SsLDQ0wF/riTKlIxAfZDlTkDA96IyVSuLAYLyR50aSa4RHsD9uL9Nk/+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(5660300002)(6506007)(52116002)(508600001)(8676002)(6512007)(6666004)(26005)(66946007)(186003)(66476007)(66556008)(4326008)(86362001)(8936002)(6486002)(110136005)(54906003)(38100700002)(38350700002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mmw90THgGnQpgTMhGjpnnyh2Ov/N4UrTZV6KfJkFBGDCkhsw7V5q89fSAeWK?=
 =?us-ascii?Q?ip5HnnaD5ldJrHxbg6EgVTR8SMeRnPOSQcMKPWvni5m1bMbGeGUQDrQFht04?=
 =?us-ascii?Q?M9HVEnMw2k1B6EZ5CNiMhy/0WXBnlawqDBAwMIZNbfjQ+YRSK7i17h/i+eid?=
 =?us-ascii?Q?JOdsUaQiANSkFEUPM1ciDk077Ygkx8gEk9DFH76KCvJeywgJsy75bzMwcOyu?=
 =?us-ascii?Q?QSVZzAm6JMjI3jTtWzDy9NNSholVX53Y8c2OocT0pADvtAn49QxT8Dh6BZb4?=
 =?us-ascii?Q?5QEwP2Eu4uXSWPWqNFSChwr3VvYLhXopYH5v6M1PucDFmXnCLX1MyrpvzgPY?=
 =?us-ascii?Q?EHVJ46FuoGmCjiYJiTLk3EkbijVzxuEsOP8Tx1wUXVCzPIjy2MQVjV/Vhiw7?=
 =?us-ascii?Q?wWankklaQnNz6cMaP/AeZiHJH063l0+ip9TSShWDietmA9YlgXSc6aOAncMT?=
 =?us-ascii?Q?BJDy5jXtFDMQS+83ovAEohqKBuPSanBwEBzFbnDM1RuhI7EPxAZb+U6AvDmW?=
 =?us-ascii?Q?347lzhHFwX9hljuZ4iB8lU3etIsUlLbZ11EoQCSGKZgystgPsjYOVW972kAm?=
 =?us-ascii?Q?FBqT/yRAX3YDsYGpi378nEtUfpItW95p0xYAYlZA/IKgqqTYAHyMJ7FEt7bH?=
 =?us-ascii?Q?dbn5LLvzxsrVEz1EtLF0QgDfJGnWEAR3gYcAT2PoLGca2UYZ7vGt2ls9bE5h?=
 =?us-ascii?Q?3R2RA6yUQlm8+QIn3RMqo7ccHvLyV9w5t739w1OZNqkkjTXWXip1ruJ0zJ0U?=
 =?us-ascii?Q?wruhg5B10diLTCQBOdYOo4vmVkSnNqT+aDFYWun8vhSIQAh4xSjFunIGXJAk?=
 =?us-ascii?Q?mp/tixBBtXvJ8ORjiWxARWLEM3DwyUbvmq7SSZ0LWD5MM69X09O2CooPoinB?=
 =?us-ascii?Q?EOO56PU+NxVHEkOCduUeQowvqBlYxZMjQvViqtby6K8IjvJTnIEFZQOxSuKN?=
 =?us-ascii?Q?h9MW4dLSALjHjrHHLBJ6N9/PR/GeFGXv8kgHMpcdzBrQJTK1H1hS9f9YeVxd?=
 =?us-ascii?Q?bc6JMTjbHwUJk84C6zes4Ui6yZ0g4hvtQo0GXQwMyf8t/Es6BC+8Ton3S3jq?=
 =?us-ascii?Q?hYsDnd9Ov2ue69pjZIGixH9VEJaGHaMUHvo6x1BHDtrJeonerUIUhGcFVcFp?=
 =?us-ascii?Q?ebsPYBbgjmiFteWLMP9Zyfk3wPNJsTTDGNjkUZ7e27NQYSf2Ix/lJTmFQLkn?=
 =?us-ascii?Q?QqqzdEuJaxn/7c+XpNPgrJt+/sJRcfIroIrYtB1+VETDxeQo2vA6AoyPJZ3H?=
 =?us-ascii?Q?kb27uWq6PekSh7eV0D0Ps3vFUesFomZg+7wBpY0eVJE7Lp30fsujhmRMqrFB?=
 =?us-ascii?Q?SJS/CYfH5FaHGOMmTTIsGPPss3U4CHov+XvULvLwV2S5JGva7m8X2umjKzLT?=
 =?us-ascii?Q?l8lMCgueYUAat1nzBT1nxuHnZ689Ooz08UmOxErefw/wehnvN9jFg926FGpt?=
 =?us-ascii?Q?PJVzcDJtn5c68W7jOryWaoaLwWKpF+4OpE5DmkMXmmzf6IZKG34qrS4YWuTF?=
 =?us-ascii?Q?CAXORRFz9JIFUUVDJLFboaIE2Mivp2EAersv1aJ4BoliOBq/5inPdbSgCsO5?=
 =?us-ascii?Q?GXhD6f/CS3iiopDQOokW8o4Kv28W+Z0CLesS8fJRCEzpeU/s+S8qQLaDJU8y?=
 =?us-ascii?Q?AC3p0T/aH8S5jBbSblERMBpCLbjGL3EM9yE9VQJ4+6zzpjzvt6ecj24SawCF?=
 =?us-ascii?Q?8E4eMvye7vIZpWfdv9KI4B+Tytm6mTIaBIdgH+Z/pZhgLx3TwzEnJPfYQgAx?=
 =?us-ascii?Q?uNT9oq+/kxQ0BD2N+0cEzKi6VegueI4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b093cd9-3a3d-46a7-32ef-08da1769b611
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:06:42.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bu/hS7bYrCNmIe5gWNGXjIzLR277qvsTceFnxrUnNvska1yDAN4e4xlEixXgq3MzDbwd74Gr0ORBR3ObSy8jqretKuYPmzqRmRi53JnzRs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5851
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060002
X-Proofpoint-ORIG-GUID: JGfSYY__4ultc7mjbk29XuAEuZFrV8B0
X-Proofpoint-GUID: JGfSYY__4ultc7mjbk29XuAEuZFrV8B0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Chinner <david@fromorbit.com> writes:
> On Tue, Apr 05, 2022 at 10:18:01PM +0100, Matthew Wilcox wrote:
>> On Tue, Apr 05, 2022 at 10:22:14AM -0700, Stephen Brennan wrote:
>> > I can't speak for every slab cache, but I've been coming to the same
>> > conclusion myself regarding the dentry cache. I think that the rate of
>> > stepping through the LRU should be tied to the rate of allocations.
>> > Truly in-use objects shouldn't be harmed by this, as they should get
>> > referenced and rotated to the beginning of the LRU. But the one-offs
>> > which are bloating the cache will be found and removed.
>> 
>> I agree with all this.
>
> Same here.
>
>> > I've implemented a version of this patch which just takes one step
>> > through the LRU on each d_alloc. It's quite interesting to watch it
>> > work. You can create 5 million negative dentries in directory /A via
>> > stat(), and then create 5 million negative dentries in directory /B. The
>> > total dentry slab size reaches 5 million but never goes past it, since
>> > the old negative dentries from /A aren't really in use, and they get
>> > pruned at the same rate as negative dentries from /B get created. On the
>> > other hand, if you *continue* to stat() on the dentries of /A while you
>> > create negative dentries in /B, then the cache grows to 10 million,
>> > since the /A dentries are actually in use.
>> > 
>> > Maybe a solution could involve some generic list_lru machinery that can
>> > let you do these sorts of incremental scans? Maybe batching them up so
>> > instead of doing one every allocation, you do them every 100 or 1000?
>> > It would still be up to the individual user to put this to good use in
>> > the object allocation path.
>> 
>> I feel like we need to allow the list to both shrink and grow, depending
>> on how useful the entries in it are.  So one counter per LRU, incremented
>> on every add.  When that counter gets to 100, reset it to 0 and scan
>> 110 entries.  Maybe 0 of them can be reclaimed; maybe 110 of them can be.
>> But the list can shrink over time instead of being a "one in, one out"
>> scenario.
>
> Yes, this is pretty much what I've been saying we should be using
> the list-lru for since .... Well, let's just say it was one of the
> things I wanted to be able to do when I first created the list-lru
> infrastructure.
>
> But it is much more complex than this. One of the issues with purely
> list-lru add-time accounting is that we cannot make reclaim
> decisions from list-add context because the list-add can occur in
> reclaim context.  e.g.  dentry reclaim will drop the last reference
> to an inode, which then gets inserted into the the inode list-lru in
> reclaim context.  The very next thing the superblock shrinker does
> is scan the inode cache list-lru and remove a pre-calculated number
> of objects from the list. Hence in reclaim context we can be both
> increasing and decreasing the size of the list-lru by significant
> percentages in a very short time window. This means it will be quite
> challenging to make clear decisions based purely on lru list add
> operations.

Plus, for the dcache, dentries are added to the LRU the first time their
reference count drops to zero, but they're not removed if they gain a
new reference. So at least for the dentry case, it's not clear that
list_lru_add/del would be good indicators of free/in-use object counts.

> Hence I think we want to connect more than just the unused entries
> to periodic reclaim - we really need to know both the number of free
> objects on the list-lru as well as the total number of objects
> allocated that could be on the list_lru. This would give us some
> comparitive measure of free objects vs active referenced objects
> and that would allow better decisions to be made.

The dentry branch I have works purely based on total allocated objects:
no differentiation between free and active referenced objects. I could
hook into dput() where reference counts drop to zero for the other part
of the equation, because like I said, list_lru_{add,del} aren't reliable
for the dentry cache.

I have opinions about whether or not it would be helpful to add in the
dput() signal, but I'd rather just try it and see. I'm learning that my
opinion and intuition are not all that reliable when it comes to caching
and LRU algorithms; trial and error is key.

> As it is, we've recently made a necessary connection between
> allocation and the list-lru via kmem_cache_alloc_lru(). This was
> done as part of the list-lru/memcg rework patchset I referenced
> earlier in the thread.
>
> This means that operations that slab objects that are kept
> on list_lrus for caching are now supplied with the list_lru at
> allocation time. We already use this API for inode caches (via
> inode_alloc_sb()) and the dentry cache (via __d_alloc()), so we
> already have the infrastructure in place to do per-allocation
> list-lru accounting for inodes and dentries, not just "per list-lru
> add/remove" accounting.
>
> Extending that to other slab-based list-lru users should be pretty
> easy, and in doing so would remove another difference between memcg
> and non-memcg aware list-lrus....
>
>> Clearly 110 is a magic number, but intuitively, attempting to shrink
>> by 10% feels reasonable.  Need to strike a balance between shrinking
>> quickly enough and giving the cache time to figure out which entries
>> are actually useful.
>
> Testing will teach us where the thresholds need to be pretty
> quickly. :)

100% (that is, 2 per allocation) is too high in my very cursory trial,
the dentry cache didn't seem to grow much during filesystem workloads.
0% (that is, 1 per allocation) worked well enough but like Matthew says,
won't tend to shrink the cache when it is necessary.

Stephen

>
> Cheers,
>
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
