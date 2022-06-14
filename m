Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF054A323
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbiFNAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbiFNAWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:22:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE7240A6;
        Mon, 13 Jun 2022 17:22:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdWoI004207;
        Tue, 14 Jun 2022 00:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=u1KDmEiM4Vog3qO51yrcVYn2KmdgfzRdsV5FklMaKKs=;
 b=0YSAIFqspur7iEckZxOEPwRtqZBps3Qq507kVkTO76muhSz6srbfOj6zfZ1gPNFAC6OS
 mN2VZf365WIAbq/WfyaI2qgkLjGCXDU6Y1HJRzl8PpQVRJnTda9RHZj4jF4474AeD43p
 aSfMfphsj4tz2t1oorLG7JgXWF8TQhtULDkfGWj7JhBACxGRDiFhe1BN7sNo8Ub51qZO
 4uNne8LHWGlt1GjHzAJtpH1tm/9lbDshETbUkUQR+q7ZJQDW5B9zdSbtRitWGYkCihEu
 4drvbK9RWh6k64OLIFhODs00HGknAs5kWU2PxC3DgT6Kbi0F81BMsiMCmyCZqKS3nZOz 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2mgh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 00:22:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E0Fs9H021583;
        Tue, 14 Jun 2022 00:22:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpeem25uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 00:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOOpZdtqOVDuHxHbak4rcK3HC/ym/xHX9FRpDikAnpB2ZOcpOvSJhroqE/QxyzIxswqu+8F9i5Odtv705l1VW4ny62idsmmrK4iuqWexOLdAAZGtlpt1UPgxNokR3McQ5soPFIskvc3Lfr32tKxAUi9Z3Bm3rMjEx7tQwl0EwipnPBmsP9rf7XYDy6X3GQa33JGy0w9Ith0ALU0lSSPhBTTT6hWCIpoN+DNFUyNKHIbB4yIqhDLtP3nCw6MFVZwvTo2wFlHNWMUGX5ZxRxuAJqL6XwCr+42iDEby8yE+wZT1bsbeZiSaKEqeIOOU4SmGAQVRvt9RiuP/dFGcvOZ7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1KDmEiM4Vog3qO51yrcVYn2KmdgfzRdsV5FklMaKKs=;
 b=f2BVgt7OP6KJZTW/8O0o/Rmu7TuTL2AEz1dLFf2mrp/KFL5IeAhxdSEu4lTWfM2vRj/eYlj312c+NBrghDD3CrcUxZWwBJ9SD0GYfkSUR1N1ynP/q3E0+jEIc9IMtK4hKtFvfPbh7H5Bv5Gj+McQ0qBGGgFvkT61MfMYHg2N0HdlGC8q3PylxMrx/jbrT55YppFa3317nrhu3CG6JrktAzWqJvEhwqtEXlxxXc97+8lLLuXqARZY+HGZp4SiPEBo8DoOa0hndJd/FkvTJkUc0Apr9OL5gz47yPVcw43wtZjnlFRekjQhiKqtoXegMGPPEchGB5+z8+4AFuxeCKM3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1KDmEiM4Vog3qO51yrcVYn2KmdgfzRdsV5FklMaKKs=;
 b=shvhldkNCvEw5JhQnm8n+0C96Mm64i/NLJpw+x0RjDjdOqz4GR2ADt4muNOydCrbNwXVm9x+ATf0uwcNSdbpnPCKkdf3SkshFvqfCge1Asu/G+79tZ4VK8vfAJsd4dbplEKXMO49exoGPubxgnPqud8u8wGrkigwCx1OIX5Ny50=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3818.namprd10.prod.outlook.com (2603:10b6:5:1ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 00:22:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 00:22:33 +0000
Date:   Mon, 13 Jun 2022 17:22:30 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <YqfUxscKfUhT35jR@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-7-songmuchun@bytedance.com>
 <Yqb2bA25HhLU/mpM@localhost.localdomain>
 <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yqb89waW/jcsgRgo@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: MWHPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:300:116::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e02c0657-9aa2-4155-aaa3-08da4d9bf9c8
X-MS-TrafficTypeDiagnostic: DM6PR10MB3818:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB381846FD0A412639E8275E4CE2AA9@DM6PR10MB3818.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dawvTPKEYGTeHa6x6iWtJo0KnQNO9CJuQVeH0nNgjsOd2TuBSIkQUaDKba30YyUau62ZkzPJrQf7FC0ItTbY4KvAvZi2x8jYcWhy9xfpvMvtD4/No6s1hBJ33LPE9nJDyyTDOuxmrHaEsO7xj2toY0wusLPD5u6YoEUOdUWLVVrx7lXqsn3lHeD/C5EIW8+Do2QFye63vMfolf6pXMwRxqrex6C3O6zbRInHR60z9sl87RCwKZBCOBtZUHlWrgk90OTADYGxRFppxwXLpiQt8WizcvsptWmhXQuUobbf9yu0DpL9WXNl8gTQNu2x/5p8RY0144Zgb+DFNYUev6X5XdSmOHEOm3Z+UclAjl0Lu4doIm90+edtPhSzx+O7RDOoA0L1tmsBwXH8wmEAzyjvU5BgRVeWgCyw7V35Xu6M4g0IdfkMjt0Q84S8jHOABzPRbdouQqtelISbxyDm59h+xLrlgdwd4GsaypReCvHDjnoVcN/Of6ctgEwFrXtfS4FzhRhNZtBBcwOwCG+jF37MK4G1VXV5nYqwmdKETU9mKJMaByVtoNUBFThSPmhwGg6sVaI16EHlMU9BQ+MpnInqaqH2WQtIqSWT4Tg5va57r6rUzRBN2RAD1dIZ4eezS6CMPDJxc/xypA3eGWw4747w9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6506007)(26005)(508600001)(6916009)(186003)(83380400001)(9686003)(5660300002)(6512007)(38100700002)(86362001)(8676002)(4326008)(33716001)(44832011)(316002)(2906002)(6486002)(8936002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFPV2g1c1hIQ1JIMm1iWWdpTlZzNmpIbU55YndnNlA0TVgvWHVGbFhFK3Vp?=
 =?utf-8?B?S1lBbXFmRURnN0xrVGp1RldHcEgxZDZjaUJvWVdLMWE1WGxPU1lPZHZIS252?=
 =?utf-8?B?eURxemE3Rm5BTVcyUzRXMm5oeEZ6TTczR3AyRUlqSTE1eC9Ga2JhT2s0aDZD?=
 =?utf-8?B?NHIzdnZSWHNjZDlQdklIZkwvRFdTdWdvNzg2Q2s2TVVFRUVVUlpidnkxdUVo?=
 =?utf-8?B?V3BTU3gyeTlBRlBMYTg4Qno2QmdudnFWYTg0TXNnS1NuK0kwV0pyUGwxRFdT?=
 =?utf-8?B?c1VoVVdURElyTThSUklPZHA0YmsrbDNHdHpTeGh0UzhjS1puZUZIV3RMVk44?=
 =?utf-8?B?aTFhNk5FVThDZjlUYzVraWhZR0J0M1NtZzlQek9IeTJPdWZTMXRydUdhcUFB?=
 =?utf-8?B?V1J0Q0g4R0xVT2xGOGt1TmFIdWZESXdveUZwa0hQTFNGckIxVmV4ZmhMVmh6?=
 =?utf-8?B?L21UWlBzdlhQYXNYOWE3Y09MWTlPUjRCTHhaclBwd2dyd1I0S3NKcG1nazU0?=
 =?utf-8?B?Wm5DUkxlOG00aGxzVVZ2WG1GM21zUnN5NlU0WE94ZEZSRFhIQUl5NGo5T0ps?=
 =?utf-8?B?RC9RK2hqZ3hWNjdvVTFDNlpZV1J4SG1sSkZoVDZWektVeUVrbUZIekxZNE9Q?=
 =?utf-8?B?SG9IcDVVMzRtSUFOQ25QZ3FocG9hcDYzSCtycGw2dmk4eVZXYWpuVDE4eHVK?=
 =?utf-8?B?QWp5WU9ldjNjbHlCSkgzMUJTTkk4T25Fc2dITHZLbEZ2Z1hlZXFGaktSQmk5?=
 =?utf-8?B?aFZtRlptYkErZ2QwVTc1emtsNXZ0RlZpRUY0d0UzVnpuanJORE54a05TNk5D?=
 =?utf-8?B?RFhTYkhLck1Mb29ucjl4djdnYS9ndFBIVnpYVGZ0dktxOWprRHNxUXVSYm5r?=
 =?utf-8?B?VnUrZnA3d0s3eW0yelZJQVdyWktpdlJSdFhkakFwNVlrcUhxOGVVY3RXaTN3?=
 =?utf-8?B?Q0lLNUxGekpobm5PckdzdkdoamFxSFl0L2FWaS94dzQ4QldVM2NsbDVBWmJ2?=
 =?utf-8?B?U3EvMjlGcnpTZjBqMjZ2ZmdRV3c4RXlWbGlSZFRUTnRvWWx0NTZRRlI2M2dR?=
 =?utf-8?B?OURmTmVmUUhoWHhWUE1Eam1SdDRlVzZ1VXJtbklKVTNBQ3VPanJpdUVwSEpI?=
 =?utf-8?B?THd6ZFJYUDFLS3dabXVVZTV4d1Q0cHQvNmhlTndUUHN6NnlYemlmUlFuMUxy?=
 =?utf-8?B?VlgySDk1QXJNTkhmS251T25aNFNicUhPcDlmd3k5bVZlVEs4YnZDMmlDK3pv?=
 =?utf-8?B?dGVhYm9qOEVSZTltRG1BWnRPT1VBZ2hzU203eFJPMGZMcTFZcVI4dENLSW1H?=
 =?utf-8?B?NFdGempXaWt5b2RieGNBZk44STNWUUhzbHhKcXgyZThGd2wwMDA3aU9qd1Uw?=
 =?utf-8?B?WksxTTF2MHoyMk1USStMTkZQS01hZFJ2YVdHWWU1cjZNTHZpeGlZL3BldWxs?=
 =?utf-8?B?bVQ4UW9sNTdQL2thcFBaOVZtQWp2Q1ArckVraTNTUGc3cUVBMU9XZXhwaUtF?=
 =?utf-8?B?UG1qRWdaTENKOU4yclBBdW85eEx0UFQxWUJ4Z2ptTjN0ZXh2NFhoczFPM0Ja?=
 =?utf-8?B?dlJKcUI1RWZpODZnTXBRb0NHU2FYbitIN3FPbGRQS3I3K01vQzIyamhmTlZv?=
 =?utf-8?B?dU9lRi8rRVZjT3N5UFhheElNLzBGRktOSG4wYTNZd2FQSmM4Q3Nvc2hEbWxE?=
 =?utf-8?B?OVhXc2k2Y3VrcXFnZDFscHg2c2FLa0U1cEoyWUZwVitkUjlEVkg1TjgzSVdE?=
 =?utf-8?B?blI4MXpWNmFtc0ptZXRYL05yYXdxSEs2ZlpsTC9zNGlSdERacktqaFBvQWV0?=
 =?utf-8?B?TGwxTTVRZkdGcWx4RjQ1RHlwT0gveWJKUkUyUE52N3B3WFVreElvMFZFSjA2?=
 =?utf-8?B?bFFvTC94ejRiOTlIOUhKMTBvY2tWUWc4bHFlK2h1UmJMN0JrdnV6bTBIMmt4?=
 =?utf-8?B?QVBod25BTURScHZ4Rm4vcGRGamx0MUJ3YWdKZGg0NEhyZTZmZ2x2SDlvdS9P?=
 =?utf-8?B?VTd0cjhZcGxMaHdUYk9tTWtHWGNJb3J3T1o3cUF0OXoyeHZPY2tXSklDQVh2?=
 =?utf-8?B?ZjB5SXpCb1VCTm1RNmVUbGlvazNqU2JpYkZ2MEcxU3BuUlpNeFBMdTBlZEJr?=
 =?utf-8?B?RzBwcDBBM1lqb3lkZTBxOGYzcHFCSkd0S3BiQ0g1TFVScWZSTlNRT2dUR2dr?=
 =?utf-8?B?OFFWcFlmc0NZSE5yUkdFWFBCYWl3dTBLOTZndlArYmZGam5EampIaW42c2pq?=
 =?utf-8?B?dVdaZXdxVlFZbHpvbUZZSTYxZnNSWW56bGtteHlad0FlSVRwRklEOVVxNE9C?=
 =?utf-8?B?VitmNWhNaTlmUTYrR3VDRmtXNFU0Szh1cWNMSjl6YWJFMXZXN1VYTFg3UnNH?=
 =?utf-8?Q?qeXexAAWkx+3B8zA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02c0657-9aa2-4155-aaa3-08da4d9bf9c8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 00:22:33.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06Bwt9Ex+Qv2xPYLwF4JTFjl6VJKq+gWjRu6n3uwrMZsS984fBBnyOZiqUgOg61p6gbSBlYlVPBZuXwe1a3Kaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3818
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140000
X-Proofpoint-GUID: -06f49Q1FZnkD0iFfA92L4DKVZ7huIW9
X-Proofpoint-ORIG-GUID: -06f49Q1FZnkD0iFfA92L4DKVZ7huIW9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:01:43PM +0800”, Muchun Song wrote:
> On Mon, Jun 13, 2022 at 10:33:48AM +0200, Oscar Salvador wrote:
> > On Mon, Jun 13, 2022 at 02:35:12PM +0800, Muchun Song wrote:
> > > -static __init int hugetlb_vmemmap_sysctls_init(void)
> > > +static int __init hugetlb_vmemmap_init(void)
> > >  {
> > > +	const struct hstate *h;
> > > +	bool optimizable = false;
> > > +
> > >  	/*
> > > -	 * If "struct page" crosses page boundaries, the vmemmap pages cannot
> > > -	 * be optimized.
> > > +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> > > +	 * page structs that can be used when HVO is enabled.
> > >  	 */
> > > -	if (is_power_of_2(sizeof(struct page)))
> > > -		register_sysctl_init("vm", hugetlb_vmemmap_sysctls);
> > > +	BUILD_BUG_ON(__NR_USED_SUBPAGE >= RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> > 
> > I need to take another look, but from the first glance there is something
> > here that caught my eye.
> >
> 
> Thanks for taking a look. This is introduced in commit f41f2ed43ca5.
>  
> > > +
> > > +	for_each_hstate(h) {
> > > +		char buf[16];
> > > +		unsigned int size = 0;
> > > +
> > > +		if (hugetlb_vmemmap_optimizable(h))
> > > +			size = hugetlb_vmemmap_size(h) - RESERVE_VMEMMAP_SIZE;
> > > +		optimizable = size ? true : optimizable;
> > 
> > This feels weird, just use false instead of optimizable.
> >
> 
> This is a loop, we shoud keep "optimizable" as "true" as long as there is one
> hstate is optimizable. How about:
> 
>   if (size)
> 	optimizable = true;
> 
> > > +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf,
> > > +				sizeof(buf));
> > > +		pr_info("%d KiB vmemmap can be optimized for a %s page\n",
> > > +			size / SZ_1K, buf);
> > 
> > I do not have a strong opinion but I wonder whether this brings a lot.
> >
> 
> I thought the users can know what size HugeTLB is optimizable via
> this log.  E.g. On aarch64, 64KB HugeTLB cannot be optimizable.
> I do not have a strong opinion as well, if anyone think it is
> unnecessary, I'll drop it in next version.

I do not have a strong opinion.  I think it adds a little information.  For me,
the new logging of number of pages vmemmap optimized at boot seems a bit
redundant.  Here is a BEFORE/AFTER comparison.

BEFORE
------
[    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
...
[    0.330930] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
[    0.350450] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
[    0.359282] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.359285] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages

AFTER
-----
[    0.000000] Command line: BOOT_IMAGE=(hd0,msdos1)/vmlinuz-5.19.0-rc1-next-20220610+ root=UUID=49c13301-2555-44dc-847b-caabe1d62bdf ro console=tty0 console=ttyS0,115200 audit=0 transparent_hugepage=always hugetlb_free_vmemmap=on hugepages=512
...
[    0.409068] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.409071] HugeTLB registered 2.00 MiB page size, pre-allocated 512 pages
[    1.246107] HugeTLB: 16380 KiB vmemmap can be optimized for a 1.00 GiB page
[    1.246110] HugeTLB: 28 KiB vmemmap can be optimized for a 2.00 MiB page
[    1.246123] HugeTLB: 512 huge pages whose vmemmap are optimized at boot

When I read those messages, I am not sure if 'optimized' is the best
word to use.  I know that using alloc/free throughout the code was
confusing.  But, wouldn't it perhaps be more clear to the end user if
the messages read?

HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page

Also, how about having report_hugepages() call a routine that prints the
vmemmmap savings.  Then output could then look something like:

HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
	 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 512 pages
	 28 KiB vmemmap can be free for a 2.00 MiB page

Not insisting on these changes.  Just wanted to share the ideas.


Overall, the code improvements look good.
-- 
Mike Kravetz
