Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCD54ED4C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378991AbiFPW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiFPW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:27:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672D3B543;
        Thu, 16 Jun 2022 15:27:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GIe3iD009842;
        Thu, 16 Jun 2022 22:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=tcWerTdRjGyI0quxJav2lXWcnLcp0KdwmazA3XB/XC8=;
 b=Eh3YgNTH+h8lkldk5f8TWJnesLs2mI1jZev48sncyi5zTb6SKSBmvvBDTUKSxH+GjI3+
 4waOcgGRgVSgOwjCOQOzus3rnkRII2IF6f4DIDQAq4+j6lhi79rSBWxTEzJJzFt+z+Z7
 DMMlGESmNsR2/SuJwbzcPdvlANOPmN0PCdpXCeLATZ8xVj2cSdiGgDbrnjBEDSbh++fB
 16Dd0TrBoF4IFg6z2YPSbddZIM43sh/b65AFR11PK34gv8Ts4p9gSOUfheQ9OWVWJYwx
 /5AiDPjmlfrtl53qO1v8q6/E+tSuIDhRnmN+8Z2+p9cSMIEDlZ3Fq7n3l2Rv7x0X3Apn fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktmh01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 22:27:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GMG1sT013332;
        Thu, 16 Jun 2022 22:27:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7qjfu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 22:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT3t5A3QVJq5d1Ly1RTGrgajwcHyOBVXd2I++U/y4TiWqNRkLGAuaKpQJunqTHLXhCO7lLObcQaq1J/7jEuijBdSxFsu9H3Yfv1eMij1wFpQn9tl2mTRySBqIsRqvmYGH0/nCdSw/ZiMAQOb+C1VTFZ2+5/Gnu32EbP2aZBreaLGYpOx2Yj/pll0gPHFOLvDencc3IXYBvo4k6J6p5RdJF337z5NZfxl0CZDsahMQCOtcuW/kLr1QyT4TY+jZcQCTG/OyklbWPAbXgYdTeD5s5Fea33uvy7CSyuN3R/mRnAaYfM/qNyjQRGXlcjk85f4SbGGJd7PsixoWwNP/OjhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcWerTdRjGyI0quxJav2lXWcnLcp0KdwmazA3XB/XC8=;
 b=N1IkVmzgtNAvVW/7OoxbxNrdWBtceSYnmPz5U5wXTUmBZyZCrR4ka4JY2eKxSKrP9CXX4h5r3Wt7RC8d4C4JS5QJlSo4zfyCmAzd23T1MQH4f+O1CJSXf0HuufRefKvIn2PNOI+Wv85Yrt+UoW9HH5BVC3CpZtaY2qajnv4tBbBAiCTTXR7goc3xKGrSdufsD9Ug2DZmVgJxQC0sjB1EwA4xEK24ngwEIfanxATPS9eObF/M7JIV6vnA8Lqo7Yzus8fiRb1Cu1I+AyKzF/7ZExEFScV8P7tKBfnaNuWlQcYt7Ff12ef/ErID8m5qR9ZdmgU9szz7a3ZGZh74BjrKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcWerTdRjGyI0quxJav2lXWcnLcp0KdwmazA3XB/XC8=;
 b=Sgvp00wacl/JxRcMD5fKyHMK7GuicKOF4dRdBddBFrzbNKdRIlJE9y86v4ubKblvhQHj5/Z8tBz9oMN9FkAU3OTDy6Had1glSzmxi9Z8ZzsFcFQbBoSu+5+jJaamG1GbA/YeQHkFCwViu11HvNOmASj2HQq4lkOh0rpR5wNiJEY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3239.namprd10.prod.outlook.com (2603:10b6:a03:156::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 22:27:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 22:27:44 +0000
Date:   Thu, 16 Jun 2022 15:27:40 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net
Subject: Re: [PATCH 3/6] mm: hugetlb_vmemmap: introduce the name HVO
Message-ID: <YquuXIaBM98oTyD9@monkey>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-4-songmuchun@bytedance.com>
 <41e2d762-2c0d-b13b-d6da-6e0e0e858a84@oracle.com>
 <YqqjaPOMyPd3aUs2@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YqqjaPOMyPd3aUs2@FVFYT0MHHV2J.usts.net>
X-ClientProxiedBy: MWHPR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:301:1::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e7d4666-7b16-470f-d313-08da4fe76e8f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3239:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB32393C217F157EE62E560943E2AC9@BYAPR10MB3239.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEQwSdRFZ51JGFbnvQh+EXtb9rELDMgUQzm9Z0iMwdBtnm88KK79pYiGAQRHGDW0j3aG5+HPp1wKbNc11llLfGlLlBDM5vi/6TrkQvdZUk8Vy3VE5Gowgqcb/kelCptTCIoKMJalOGhW5pLpgDVDhBbP+Z6DCNFW6oICtxFnzPJ2Y+1V7KvXsY1rBKyOcH1G1q4HVuCZfq5QDACqAr8gBO/Fpy/6OiLV6UlZP/5YHBsG9C3/82YA02J4jXTQfxhHwpVGDzmm2pnH1NnSnfn8RZbbzpJHntykC9fp1JNQvKUxnv0xIYc0JfjPWWbG7qSs6N/70AG3okPjC5TFEwah6tA94BXwg+Skn+pohfm8QyJrnanhO03V7ziO6mKlmoOzxkq+tMMtVLOEp0ddLVZQnuzNaFne32jiBny91tUmaOfggKrsVrS2ds8AHy7EPynLrV6agCZdEMp8vJEbzxqFKsZui5dATvrpS9fmhagt1G/x+yLZi+idR+LpoO9gdjzcsuxF7UvEHS8i+lK5Z/Sgi7kEWlf/MoXfLUbaOMGHgLxI5Htz24/cOKh5xrrhe5sZiS82Fxzb59TSpQg8zyG04BPQzE7RS9crH5rH1JC2Zu2hMEM9kCj9lkcI0Gzs6vJrNde8K5y6yohlisp0VETwxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6666004)(6512007)(86362001)(26005)(53546011)(9686003)(38100700002)(83380400001)(186003)(6506007)(5660300002)(8936002)(66556008)(66476007)(316002)(66946007)(8676002)(4326008)(33716001)(44832011)(2906002)(498600001)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWkrY1pOcmJOSzhSb2VJaHZYSzNiRXJ4TUlMcWZCUmlSVjRsY2NBOVVKeEdu?=
 =?utf-8?B?bkttVm1abXNkc1dFQjRRRmd3STFlYk1tZ1daVHZrSmFTVmJHV213QTFSRjcx?=
 =?utf-8?B?eU5IbTlUSXhwakVkVjNocWtrcm9RVkZqbjhicnRiK1lrM3pGUk56YnlqSEpP?=
 =?utf-8?B?N040dERSQW05bk5GZldFeVZXZlFvS2UzS1ZtQnNIaFZlQ1Uvc0lzVnFjQ09k?=
 =?utf-8?B?WTlqckRwcnJXdHV2QXBqbjM3Z2hpdW1vKzVKc1M5Y05vUnBKblBVRERwTmNo?=
 =?utf-8?B?WWk2VkptcEVHbGJ4aGFvLzFyT2NzblNOUzdSbDFIUGl5SUhRbEhpZ3B5NFh5?=
 =?utf-8?B?TzAwTHdFQnZQNUpYZzdxSG1HVm9zSnhCL2F0RHlYWXhVc1RTZ2FhYmhuQjVm?=
 =?utf-8?B?NWpSQkEwTkdENGtCQWdmQ0hqNHkrMXN2cXlRU3R2eXlUWUxLUmU3eTBrVCs4?=
 =?utf-8?B?N0xoUFhwam5wcFNhMmRPcW1lMUNrck5xbWtzbjVad1QxM241cTRpUzE5QXVQ?=
 =?utf-8?B?WHRjT1pHcG4rRTMvQVByaFlGMGNTZmtEZzg5akg0OTJYaFZmUmoyUlZ3bXIy?=
 =?utf-8?B?bCtHM3RiRmpETlhMUEJhamh0bFhmbmhoYTBYMjZBNFVLLzhHQW41MEZBeHd1?=
 =?utf-8?B?NFVDTCtuYXQrZU5WREFRMzM5QTgwcFBDNnBYclJtQURJaFRMazAweDNIMHNp?=
 =?utf-8?B?aDduVXhSb1JGbk44bHMycmJLSUlSZVpQQkVpbnJXckh2cDF6Sk96Z0w4eEJI?=
 =?utf-8?B?eXgva2xMQThjcFZEWkRpQzBxQzJmcE12V2x2d2hCQVNXOWJPOS9rT09WUDl0?=
 =?utf-8?B?L3hxVEtFekZZTjBNV2xQSnhUSE03aUZQeEZkWDFIY2ZtdmJZRUFCVUlUL1BG?=
 =?utf-8?B?WlV0RGdsUTJ6NGdDd0ZUWTRkUnBlY0U0eExuRjRYd25jdmVoQXU1Y2lxUVBT?=
 =?utf-8?B?RXMvbzV0dUZ5M2VUalhpQW5MS0RPTk1WdVdnTmNBRUJmTDl4NjEvc3NoTkkx?=
 =?utf-8?B?LzBzbG93Sko3UFBPb3I4Uk5adC9nVnZWeTYzT0tnRUR2aWh4MVFmUmJlZGto?=
 =?utf-8?B?TjljWnNDcUtHVVNMUmpzclJkMTlHbXFselVCZk5NNGFXTlJ0YkptcTRoNkNG?=
 =?utf-8?B?TGZPOFhibVlaY250MldzUHNQTHZuTTMwUjdsTjdWclQ2bnNVcTNjZ01GZ29J?=
 =?utf-8?B?eVYwUUNTY2tWQityK3hVbkZxWlprSkFodDYzWTNrU0hocWRiTlBHTkpxcjUz?=
 =?utf-8?B?SUUza1grbUJzZG9QaVhVM3JsZ09hci9LdTNITUFVdGFZekdab2U1Q3dibXdS?=
 =?utf-8?B?VnVoZldKcExvTW1WRjlQYjlBemM3ZnlBYWZWbElPZGdpeUJCYy9LTTlIUzNF?=
 =?utf-8?B?MWdRdFI4Y3psbUtSU0hCL016LysybWNYT2VDUnBINjFOUnpVNnoyREFaT0I3?=
 =?utf-8?B?Yy9VTG9xZ1R3SGt6blRlUmJVNE5JN09PeGpDcy92ckVuTTJxNjIrU0lSRU12?=
 =?utf-8?B?SkZwMmxzQkpaRFBJa2dJQmNJVDZzVWtDNGJQMW53N3R4cmxhdkdpZnVaZmpS?=
 =?utf-8?B?WmxmODF1bGRQOEVOSEFIdEdRQnN2cXRta0lnbVNhc2Q1NUlzckpoRVcyZ3R2?=
 =?utf-8?B?ODNmSkRHTDNqK1dWR2dNbXl4WDJpMVNTK0dzbXM0a2IvdnNPekprRm9Wd1JZ?=
 =?utf-8?B?L2QrTUV3MWRxYTJKa1JFZUp5cVVzMlRnanRkcGN2N01KNDVxTnQ3VU0zQllU?=
 =?utf-8?B?UDR1dGFZaEQzeVdzR3FsNm5wMWFzZTNBVGtHcmc5UVVueFpJWGRndlF5ZTdP?=
 =?utf-8?B?aDZWRXNiV2tEeTYwYkRRV2tFNWY5ZFg3dzlQWXNkZlV0aSt0QlpxZHMvY3pq?=
 =?utf-8?B?c3hKaUUzRXF2NXhIYmFzY2pCZnJIaSt1cVlDM0xOM1F4djFVVXpBM2l1cmZU?=
 =?utf-8?B?ZmtaTksxOEFucFdTdHBibG92cHF5a29jUGdyQ0hNVlJYYWZObkswNlArRk1H?=
 =?utf-8?B?ZTVzMFJMNVozL1JvQ2VxYUl4c3d4Y2hrL20wakdjTjVMb1BvZ29yaUNrNnhV?=
 =?utf-8?B?eHlCLzlJS0hDdEx4R0hyaDg1c3pLSjN5K1UrTERDRzZDZFd6TWNVRFdPSGl5?=
 =?utf-8?B?Wk1RYkFDc1ZGY1BIZkFoWjhxa1RWOXVraHBhY21PRE01bURkZnR3R0R2bTh2?=
 =?utf-8?B?OGROYW03RWIwdDBOekNSbC9WRXJac1VEOXlDbzRlcDFNY2tpSmxucEJJbnV0?=
 =?utf-8?B?QnRlZjJ1TE4vejVzTDZmMGEyaWd5eVdGM0Jib2lUdGwxL0FpZ3dUTXY3c0Nk?=
 =?utf-8?B?NDNwOVNVa0hPZjJ4YWVuYmtPMU9uQk1ZenR0VHJFU2g2OTR5TmNUVGRIcHJN?=
 =?utf-8?Q?O685446Waf07Lnrs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7d4666-7b16-470f-d313-08da4fe76e8f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 22:27:43.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpV5W95w8bcyebZp/CLaEs09SkA5oTzFbbfq1ff8Xs2s+C5s0VPDjxtT8yI9yusxE9/Bm2rtBKyof5zQqbyVzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_16:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=690 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160090
X-Proofpoint-GUID: JN6guTAIDlhloIDuABlQmAgn5mAsNBRC
X-Proofpoint-ORIG-GUID: JN6guTAIDlhloIDuABlQmAgn5mAsNBRC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/22 11:28, Muchun Song wrote:
> On Wed, Jun 15, 2022 at 03:51:51PM +0100, Joao Martins wrote:
> > On 6/13/22 07:35, Muchun Song wrote:
> > > It it inconvenient to mention the feature of optimizing vmemmap pages associated
> > > with HugeTLB pages when communicating with others since there is no specific or
> > > abbreviated name for it when it is first introduced.  Let us give it a name HVO
> > > (HugeTLB Vmemmap Optimization) from now.
> > > 
> > 
> > Just thought I would throw this suggestion, even though I am probably too late.
> > 
> 
> Not too late, we are still discussing the name.
> 
> > I find the term "vmemmap deduplication" more self-explanatory (at least for me)
> > to refer to your technique ,and similarly s/optimize/dedup. Or vmemmap tail page
> > deduplication (too verbose maybe) because really that's what this optimization is all
> > about. OTOH it would slightly deviate from what maybe established now
> > in hugetlb code.
> >
> 
> Well, I have looked up this word "deduplication" which refers to a method of
> eliminating a dataset’s redundant data.  At least I agree with you "deduplication"
> is more expressive for my technique.  So I am thinking of renaming "HVO" to "HVD (
> HugeTLB Vmemmap Deduplication)".  In this series (patch 6), I have renamed
> hugetlb_vmemmap_alloc/free to hugetlb_vmemmmap_optimize/restore.  I am also
> thinking of replacing it to:
> 
>   hugetlb_vmemmmap_deduplicate vs hugetlb_vmemmmap_duplicate.
> 
> Many other places in hugetlb_vmemmap.c use "optimize" word, maybe most of them do
> not need to be changed since "deduplication" is also a __optimization__ technique.
> 
> Hi Mike and David:
> 
> What your opinion on this? I want to hear some thoughts from you.

I can understand Joao's preference for deduplication.  However, I can
also understand just using the term optimization.  IMO, neither is far
superior to the other.  It is mostly a matter of personal preference.

My preference would be to leave it as named in this series unless
someone has a strong preference for changing.
-- 
Mike Kravetz
