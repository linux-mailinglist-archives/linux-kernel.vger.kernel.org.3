Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA96D501E02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbiDNWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiDNWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:10:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401CAD135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:08:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EIQA6A022836;
        Thu, 14 Apr 2022 22:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QfF4nF0k/OUUzViXgP92aUhvmNmmEep+LurvanjF8fY=;
 b=loZvBXrY/5OkH6mH72/wAPjHJ/1EK/vDr/i4GEW/OUeG7un5UfCBUb3kICs154BVmoyp
 JKhd9VBJSO3Si1826cF/YtJ5KQhjGJDIJ/oc1q+4j4Vwrz9rUdh9Y9jij4QWuYRui4ae
 cYAcaqkl9CYteG7ehR8FFUxCRSm58o1RlpNNBLffJdp2lb7nfNB8TmAG/hf9OdfOOKA9
 x2SLt82rdGzaDbGv0MeGHOvT+hb6pVGyIwXGd6fh0ZGNoc1ClpsQJVGlPCfPiVQzoOCo
 HjcMjsTIscXmeBWpchSvVO0whKNSokEpAJNu71gSXouetxVIUMXOoVJzavWzYWY7hO4k /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jddn3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:07:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23EM5b9P034456;
        Thu, 14 Apr 2022 22:07:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5u0k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 22:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkDDq29a0oAiRHBJNv4XL9+oB6ll8spMn6SLZ2SD7/hBV3fxwv0exrv+r6IfQUkMgj25gqVi+/93QOpCn/Niqvr2C7Ot81O0AdgYpBjwnMtqdm59X5kLtuWvsBH2y/azsSTVFsPmNKVxKSU7DKrX6jYKJfgyiEp3EqUFAvsUX+F8GQ9wdnvhT36S+W7KObQ5NmgOLVdS5FY3Os0cYmFPIVduKrX7hJAab1DVjWbHmQtaASWMrAfrschthzzQw0V7ooExHeP+PrPX6u8WHgdi8/IO14p+rSXYpVlj1Nta9/ISiqaJ+SabCGl3tbxWeKCaAiP1vwxX8vGYR4MU5PgtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfF4nF0k/OUUzViXgP92aUhvmNmmEep+LurvanjF8fY=;
 b=g1BvR2l0CaLPp4FYtH8oXrnYdLWyaHK1AexeDUOTKCX3KbZWb2oC5dOZ5DxftG2OnpCBz11ib54iwJGgGGV6/8NwctTa3MSlToHPEBFaIocvM0cFG4sdtxw0rWWMJf98Kp+2dCXXLTY2cLzFIyuUzBMxVUx//CSlVHFk5ihoznN3Cgr2Zv6nK+Sz0HCPNMoSSK1zjhikdz8umctk/9PDSelWmzriVoQoZNOBexdNBSKa+oOl+LfS4xMHEXHMpxdKSqCIdRiUM6FJbHhdCTTAXadW8Bp8hGl5ZbMYWhIhSUMFrE/pNI31y0TX7lz7HYANfrxyDQ5VIaHbIAnXUCePAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfF4nF0k/OUUzViXgP92aUhvmNmmEep+LurvanjF8fY=;
 b=zCln479nzNsQEJReCGpZsQAGPDt3aFxyhYH3jKkdpJhydpJEO19jy570ftfRYyfO6uJPwc+6/0v4F3WMBwKUSLI5yj3L4vM76hvSMsG0NSxi/rvRrd+f8Oi4m4hD2ixX1XTdgdPOn6Z3iD7D+OLP8foRQZAVieRx5JCjBuCytg8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3805.namprd10.prod.outlook.com (2603:10b6:208:186::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 22:07:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b1bb:21c2:580e:922c%4]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 22:07:18 +0000
Message-ID: <b30e9ae6-86b4-57f8-8484-d437996510bb@oracle.com>
Date:   Thu, 14 Apr 2022 15:07:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: migrate: Simplify the refcount validation when
 migrating hugetlb mapping
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <eb2fbbeaef2b1714097b9dec457426d682ee0635.1649676424.git.baolin.wang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <eb2fbbeaef2b1714097b9dec457426d682ee0635.1649676424.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617b40ca-6097-4bdc-a7f3-08da1e632440
X-MS-TrafficTypeDiagnostic: MN2PR10MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3805E9E30B936D15CDE340CCE2EF9@MN2PR10MB3805.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPadWbPelaacbP8nTWq//WT/0sAx7zdYJkwgsmjp30c8PmDTVn/nUVn9aqE+a19NkXmcKGBLAhYOHc66srJ+4I5l9OuGPi/Mieba9FXdx/0wSplwhusf4jcKn1JWQOWtVFWB/hu0PHoxHbT1GnLjCnqZqnbhxNoSNtzuteZ3QLaaqtp+Q3dYEQOn2toASpAWkQ7Pbu14uMS+FOOahhTCSLBXd2xXnhShQlpT25LeHfw2YH+DUveeQggd/QrlCOUn7jgk/9EgiWmC4U2Niymo53zxFi/j2NCY2jkSn2MgKBtTYBPQgAKJfPHl/+Zgk1NSuC02elifZAxuC2tUJcLf8jH+N45V0Lx6prw/pPN2Z3aotRp9d8ObHX7T7C3tEmzqVi3G2DVmNB+La1hPAy5+3IjRbyr2/OnmGgIJJF+SC82KZJHyjat8h1ZYfkWBc2PKNk57q/0r6KDPe45FzRVjm3JYMa7ItcDGpO8QTVz1uNjWyw+Zff1nA1XhU5EoKM7vAoR1lYFQzFxEEzdYJZWacOJX4LW9NyAca6tqskWrSMrJ+As//JI5aE+aVEePzwwHhKJMOUOoUzjaojGGnJVH3XywJYuBWdZ9UYytB/KKYBeWS/kdO5zzjUTDexEQiSRp5kp7FlEyJMylLt73iHN5DJelU7K9czVwdTeGFafeB6D7e4nWf6Ebc+ILXtdgan/FQyFwP0rPi2K+GJ+VrzRP8bRbJYHW5l2OqGQkyi70attFsrtCETpjXypgIcI3/9mEGLl2bfUBZkQCO6No6sNbCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66946007)(44832011)(186003)(86362001)(26005)(4326008)(31696002)(36756003)(508600001)(5660300002)(6486002)(38100700002)(38350700002)(2616005)(8936002)(83380400001)(8676002)(316002)(6506007)(6512007)(52116002)(53546011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZoNFVXWHErQkhmbXQvb0hENkJFV2JqSStyVENCNC90WXJwL1QvT1RLckg4?=
 =?utf-8?B?Yk1Zdnh5VHAweWttTndxVHBVNStScERMRit0WTNnVTZlTGtUWGxjSUt6VFVl?=
 =?utf-8?B?YnpGdGN3cTlxY3RWdHZFYloxSXE5SGY3ZGs2MXRzQnVIRjh5TEFaNGJ6MFMr?=
 =?utf-8?B?ay83QnphVW5Nc1Y5dW1YQWZrOURiK3V3a3VxYWN2RXlqeFk5ZEhBbC9QN2U0?=
 =?utf-8?B?WFA4bGpOZmUvdnB2OUpuRWFCNnkwbURQL293dlkwOUY4MEY0NDRJUURDcFd1?=
 =?utf-8?B?UU1QSXFhcDJTZnBYMEZ5bjlCTE9vZjJZWW41YUVCaWtSb2JBcmNQckRDeHAz?=
 =?utf-8?B?RmVSV3o3QVhtRXhyTDZuelNFMG40V2hRanVJUE0wTkoremN0cXJ0Q1NmRyt6?=
 =?utf-8?B?Y2cwY21xL0RXaFd1d1ZkZUtPM1Nmcm9vT2cvbUsxMUNGZHBqTmtiK0k0TVFl?=
 =?utf-8?B?b1JuQ0ZDK1VmYU5uNUdaYXlFaElnVDVHWCtJeWZRZlpvUW8zUVAwT2xDS0Y5?=
 =?utf-8?B?VFZjbDI0RERRRU1BbFRJTGpjM2hPZXNiWlFGcUxHbTdlWUhuN1lUUFAxZFd3?=
 =?utf-8?B?bEFzUFE0RGpqa0ZKMTJaS0VCRms1YWhrSlJhMHFIb3JkRURIN0laUHU3eENU?=
 =?utf-8?B?UDYzUzFYZ2lFYTYzMGtLVTluSXBtUm1UVTA3MGpVT05lNmRrNHdPTGNkZUxS?=
 =?utf-8?B?TWp6dERrUUY0bkVpRDV5RzBnNm9nZTNzWVRUb2hYeDN2U0NSMXdPazlMdkpR?=
 =?utf-8?B?b2VKeEQwUHMvQmwvZG5MMkpnSkwwcDBKUDViOC8wUEdhcEtOOUVONk5LYVFs?=
 =?utf-8?B?dVh5a1JLNlFwWVYzdmdpYmlLVnp6cks3UGRFNU95YndCdERMTmJCcTN0Z2pD?=
 =?utf-8?B?VjZoTmhocDFwczlaMEFDRXk3VklrNGJVek1wa2wvMDArYlV2eTNTSWgwaHNu?=
 =?utf-8?B?SkkwMXQydDVJcnNWYVBodER2Q2JteHhaZDRFMURSMGZLcEtxN1gwODRyUWg0?=
 =?utf-8?B?ZjlwRXV5YWRmUlliWEp2SVRZQ2l3Rm9kdUpBc2VwUEREY2lVZXNqSC9URnI0?=
 =?utf-8?B?VzZYVERGZVpOWk5HWUF1dmVKUHZTYnZVTGZ2Y1lkb3UvRnV1NzBvc3dNVkQ2?=
 =?utf-8?B?dzNjb2U5UnFRUHJJbEZ1aVJNdVhvK3VsVnFJdzNUY2Zlam5rVnNML0s1aWUy?=
 =?utf-8?B?WlNKT2dZZ0ltQ1FaRmVMd3IvYUtZQVZ5eGFORE9iN2JpY2srVStPK2hQdGFL?=
 =?utf-8?B?aGhjTEhRR09abW9ZUHJhdUo2Y0d5eEpYYVFYUFdKWEpjMkFIRFpONE9TQ0lr?=
 =?utf-8?B?c20zTzdxNnRDejUzanRuNHVrR3haeE80RWxFaDh1eHNEYWp5b2dpOUY2cHBt?=
 =?utf-8?B?YVQrVGc2QUpjOFVFNlRDemxsUVpqOHAyRHFMSTMvRHd5UU5iVzUvRTA1Q2tN?=
 =?utf-8?B?cnE2eDVDRWVGWG1zWFlQMzZvN2V6cUFwdU4wN0ZKeFZ1WjByRC90TzlubEUz?=
 =?utf-8?B?TWlGcTRQU0kxaXpjNmdYY2M0S1JDaHFReXVpUVI4SWpPbHk4Rks5dXcyTksv?=
 =?utf-8?B?T1pwTXphR2MxZDc1VnQ3WHdYbkFjbGhjbmxBekhyMGlCaXNkY28xdm14QWg3?=
 =?utf-8?B?RjIwRjNVNFk1U2tqMktjQTRCRldMMUdFbjhVZzNxVUZUa3lUc3M1VjlrcFZl?=
 =?utf-8?B?bXNOWU11T3M3SGFuV21DT3lObG9pdDJxYzJKc1ppMy9GTmFoTzJKc0FBV1Ny?=
 =?utf-8?B?TVhidW45M0YyY1FPR0RIMnZuaW44emJpUmNwSXlmZi9EUjc2VmpsN002SW16?=
 =?utf-8?B?eFc2SnErM0xUcUQ3L0Iwbk5CeHZZVmdaekhUeTNNd2N0Zk83d3pBOFRZWVpJ?=
 =?utf-8?B?SUpFQm9peUVrYWNBTkMwMEJEdzZtSDhRVldFWHFHNGh4a0RrREFucU94UTJE?=
 =?utf-8?B?NUh6Wjd0bFUyYXhpRXkzMFRFbENwczJyV3J5Mm5tSityTnI3Z0YwYWpFOGpy?=
 =?utf-8?B?UkIvMmo3SGJiRFN6aHRnV1VHVnZja1hXVGlJV1h5L1I1Tk56RWFsaEFTbGFj?=
 =?utf-8?B?ZHhlVENySkN2bXFvZ2RPS3VaQ3N4SzNOTkF1TTVuRmx3OWFSVStNcXhiVkFx?=
 =?utf-8?B?VllXc3kxR3FDWkNvcXVSLzVqWWdYUE5yY0Jna01CNFFFSGJIR1lTYTlPdDQv?=
 =?utf-8?B?dnVwMUhFc2VnaWsyaVZLTzdFcVNnWVhQa3hKODZQU2xXMFIveDJIWjNqakFX?=
 =?utf-8?B?eWxSdjNMWlo4N0hMc0ErUFE2UWlQRkw0ZzdPV3NsUWtJNzlPZ3hZVmo4K0Vy?=
 =?utf-8?B?VkZHNXBxOFQvSHRpZmlOQmp2U0d1NXNQem5pL2d5REl2SXpadlBOR0paMDZX?=
 =?utf-8?Q?VTI5SHuNHheBvLJM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617b40ca-6097-4bdc-a7f3-08da1e632440
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 22:07:18.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFyhOATa0jl8TkgyfLKyePZtxiOcaOPSr16HF75BG2lyGvnF9EAzYkScN5hUm8WHX/6majPhtoxIeRE4uf7pOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3805
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140115
X-Proofpoint-ORIG-GUID: d3xwShQ53Pemr-_NzLdTVWdtdFmUPGQ9
X-Proofpoint-GUID: d3xwShQ53Pemr-_NzLdTVWdtdFmUPGQ9
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 04:34, Baolin Wang wrote:
> There is no need to validate the hugetlb page's refcount before trying
> to freeze the hugetlb page's expected refcount, instead we can just
> rely on the page_ref_freeze() to simplify the validation.
> 
> Moreover we are always under the page lock when migrating the hugetlb
> page mapping, which means nowhere else can remove it from the page cache,
> so we can remove the xas_load() validation under the i_pages lock.

I agree with the reasoning here.

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 5 -----
>  1 file changed, 5 deletions(-)

Matthew added that extra xas_load() and check both here and in
migrate_page_move_mapping.  However, migrate_page_move_mapping has been
converted to folio and does not appear to have the same check.

Ideally we will convert hugetlbfs to folio someday and rewrite
migrate_huge_page_move_mapping as well.

Would be good to get Matthew's opinion.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a3d8c2b..b267827 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -477,11 +477,6 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
>  
>  	xas_lock_irq(&xas);
>  	expected_count = 2 + page_has_private(page);
> -	if (page_count(page) != expected_count || xas_load(&xas) != page) {
> -		xas_unlock_irq(&xas);
> -		return -EAGAIN;
> -	}
> -
>  	if (!page_ref_freeze(page, expected_count)) {
>  		xas_unlock_irq(&xas);
>  		return -EAGAIN;


