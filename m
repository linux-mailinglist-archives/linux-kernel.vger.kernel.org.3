Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5E583613
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiG1Awp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiG1Awm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:52:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DBC50736;
        Wed, 27 Jul 2022 17:52:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNOMVe017508;
        Thu, 28 Jul 2022 00:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mTd2oGPAy1b7Wxgpaw/Zr6QItLmcyRuYkWAFSifEHqY=;
 b=pAjc6d650n+kKQxhJI4e/n5i10m7UjI3tG/pT+dmebBUnYgWZOXQlW0z53rKUEXV8X78
 ot1n9N/GfeY2HiNjcikA9XgGAKppD/YZ22VUSUIV55dLs5YG20E7EwR0R1xs+J+Hsznt
 ajY9EuyPEDydf9G6LLhUgVq2xSjHrGrISfM7P0yxiiVexlfx4AeS2NXzpaFMFUCfuRhk
 26R0+clNUJyh8Om+m9bxikCLjom9ow/fdxg16egGqh8B93u+zNHzjr69xwObVk+VMVf6
 ++VO90OlOkvISuP/tLao96Iqx41U94y0dPtMeY+zK7Z6l7sIlPPSselXFohlYKL1jN6O eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gk4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 00:52:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26RN0IUp031502;
        Thu, 28 Jul 2022 00:52:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64u1am1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 00:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhCmvZ3rIdxSiNMhs6Mj7bz9AhRe680nTUwvWqk7syD/NxIx3afa44Ym7BcgoR57hPTYaxL9F0Rp/fMRzJwFrnRwx0UIHZMW2Z085c1walsKAHe+EiqlWL2ACnIMvd8cjcnmX2J3spZtNaSCaUibwx2r2uajtHbwdZIm6hwWjgv2EZjvFqaWQb6LRMITx+2BYDkPHVjiAVPxCsXBiO0Q6RF+bIzydwRdRWlgkmKsmY/UgS+HQ3CyMkEjQxlb7kRkAEG61tMDVzXNDYD6FtzXlssL5qXNS8XV9Vtzm4FSR5Giq8+YeaZkJTcK+4Oj172gmvHvyfMWBxTrYXG+VFUf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTd2oGPAy1b7Wxgpaw/Zr6QItLmcyRuYkWAFSifEHqY=;
 b=Q/AGmHjbNfvT6RUQGOgs9BwFpfj4JtO1ebVPfVCfD5Cmd5c0sTRY7YAUfvDch6LIjSX2IKp6w6jiSHDKSg4BgjAfZO0LVUy8YeDhxtTx4ZC7IDV6IeqsCHKcNCaUuitMJoLlHxzh934UMKjVTTGDlyJzQ9UoLTfHLyTg2BLfzChdFcGNN6pJGbsdlFnmATLzDJDd/qhaItMXWumRE4Wx2T12wYriyGb21fa1lHIRYkAvnuiMMlefaRTMY8AUURxYGEwDk8pQX/PsiQwPkKtj7UayCDua6vj4AKMEKnPHKoI/GwfkbKFDwxd0KKuT5aTrQXHre7toSGqmFq8CmoY4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTd2oGPAy1b7Wxgpaw/Zr6QItLmcyRuYkWAFSifEHqY=;
 b=kB53XkrpYQNpJuoUvMCgLB2logvQ+N2pWvYrKa8g0eWpus9i8/baO+riwniUPX5xxnR/1QSIXHFFmviMO6eYiPMfUlALH9HGaQA3r74tB14Qur4FGQ8seJAnCnK7crPn+y+V3ZGHYC57OS9C0P0QGxo8uWcKhkr8Bp+mWfIeZ4A=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by PH0PR10MB4710.namprd10.prod.outlook.com (2603:10b6:510:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 00:52:10 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::dd9d:e9dd:d864:524c%9]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 00:52:09 +0000
Message-ID: <6a899346-f9b1-dc3a-2da0-f3271c85327c@oracle.com>
Date:   Thu, 28 Jul 2022 10:51:59 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] mm/kfence: Introduce kernel parameter for selective
 usage of kfence.
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, glider@google.com,
        elver@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20220727234241.1423357-1-imran.f.khan@oracle.com>
 <08da326f-3fe4-3342-bce8-bbd94bf8be97@infradead.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <08da326f-3fe4-3342-bce8-bbd94bf8be97@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:10:1::31) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f267262a-6fef-4f34-bf7d-08da703366a1
X-MS-TrafficTypeDiagnostic: PH0PR10MB4710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6brHHJQokFdBCO/GhNARPstpgR3C2kp+FfH5ohcVQwj8PMBKNlr1f0ceGw4/CewlVT+ca3KAWLIg5h0Msk450LfyJW/2kYD4ESVJrbE84tTwNtuiUM3M70bdan7hF15pzJKYesRHDVqfxfdnjUZNRcOYCcLQAMqdI/f9o6gm+1IJiftD08dFia0CS3brql2R2MNsu8tpVvCqMs4OBK+WkwLZM6exBoPyyOCa3bWOLiovW08bX52Y+DiQwYQ89FDAE18SAMJ2JDicg5YMeq7KpC7TWB0aXPJTXPYruygDxjScbBdU+4FmXiXxuUCad9/8g1BcFIfEJgwPS4s0N4sMOVpbTUTnwYl8qx4lqBB1sBKHqPDJOD0ZuOlERnVdv28gYuXp9gs9SRhAOpW4qQXoPGZoHtPc//EpjZFm/BNREbsyh1VBAKDX9S/g8q2ynwvblDZ/EbAs7Fqy1aWPhX2AAhup45NAU/Vzkqh4XDYeem6InRxQXdk98x4kTXJdhmSkskUwC5KZq2qKN1eeJ+WDEqPKFhmsAVON8DYwa5k1/EADFSBSxjA22F1qR4VQvitZpFvJ76V/HRJA2DYB9rWqZRwJEvmUyCAt8xvKlPk9iL4p5RnYYd0uP0FA+9KEoZrHLFINiuY4O8TuBH5yH7hdL9FFaMp2sjRwDOoB02QyP3epqgJyk988oxRXzzwL/B703Gty76kyYtzaaAScr4bL65kyctARc+LuH72arUypLgO2Y8walSe8kEQx9cg2xhD4AdV83G8yZMezQvTQwEaHlY4gm3TiHx7JabFOousOzkeoPyMJaYDM+7YZZ9CaPV5nFaiHW0awWQUoHzdGcrkscEQuP1A4AKDXcJrtAq8Ks+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(396003)(376002)(366004)(186003)(2616005)(83380400001)(6506007)(66946007)(4326008)(36756003)(66476007)(8676002)(66556008)(6666004)(2906002)(53546011)(41300700001)(31686004)(7416002)(26005)(31696002)(8936002)(921005)(478600001)(86362001)(316002)(38100700002)(6486002)(5660300002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpOak10MUh1Y1RSbzRwZlhwNGlSZ3lLZEthLzgwOW85UHNrbThUdDlmQUcv?=
 =?utf-8?B?T2Vkbm5MSDg3WmVDeHIySmROMUZFaENpUE5MbmJQMWpZMklyUjdUMVdDR0pT?=
 =?utf-8?B?bFFhcC9ORUZXQzFoa2NERFU4RTIvYytFL2Y3dkdoZHN3MjY5YkRNcXRHSXZu?=
 =?utf-8?B?U1hoVHdBemduU3VtblhGSGlvU0FNMWtVemVsRWpEdDBZa1UxZFJjQnY4ZnRa?=
 =?utf-8?B?UVhFMFBaSEtqM2V3TTFyTU5hYW9UdHYxU2x6dEl2eW1BZXoxQUV2R01SMFFz?=
 =?utf-8?B?ZW5QOXlvUk0vSWxDa3prUVNRZklNZ0sxRnA1Qis3WEwvQ1NPZDZ2OWFxQ1Yv?=
 =?utf-8?B?ZnFMNWVqQjFYY2d5U0pGbVkvV3lWS21iVFJJc3hMSUowaGF4dldhempGT2U0?=
 =?utf-8?B?SVJXWDAzc2ptVEtTWFI0Mk5MMENQVFNrVkZpWWd4angwKy9ZOVM5ZWlXTDFv?=
 =?utf-8?B?UGxBemNlSEp1c2JCVXNvZy9lMGdWbUxpQWhyMndwRWFSQ0ZRNlZxSS82VUFB?=
 =?utf-8?B?U2k0L21kNHJzL1F3SC95cXRHRjBrSHdKcHIyZVFIRTdWdW9WVGFJR3hJckYw?=
 =?utf-8?B?S3Z0ZGVSZEIxc3VBNmYxenc2d2pYUVJGT0JTTXViWjh2ZHluelEwQ0gxTGNF?=
 =?utf-8?B?MTZUTFI2NzhMTkh3VG5MVGtCbHhlb1FKc3k5ZW5VOHV3QlNSb1NRSVJBUVd1?=
 =?utf-8?B?enlGN1h6dmpYQTY2NHhNM3VSeVFsQUZsSHJ3T1YzQU9UbldwNURLblBQdjZu?=
 =?utf-8?B?TXVUOTZQSm1PTVlnME0xSTRHODNUWlMrSVpMK2loYVFqQ3V6bXB0SDE1ME92?=
 =?utf-8?B?Vzh0aGxEZUNqdVNyOCtabXVSbFpvVDN4bnQ1ZUtEUFlLUEx2YVpFNXIvS2Va?=
 =?utf-8?B?MFhpTmhTVVdySlAzQTFzSHpwd2dvZlZZSnFRSzVkdUF5RWZsS1g0SjJCVlht?=
 =?utf-8?B?RDd1T2YzYUcrLzFnR1BZbVZiSkJJQ3RPQnl4RVhGVmxycTh6ZTdVeEhDNkNk?=
 =?utf-8?B?OTNLOE9RbDlPNFpvQ252eDZmdE5qajdmREowbUhsM051SEdWNUxvMCtVelc3?=
 =?utf-8?B?M25XK0Q4VzdtZGpURi9ybEU0dXViVkZtUXhNd3V2SkhVMFdpcVF2TCtCNEwv?=
 =?utf-8?B?eWpFWlVseEpTamoraEF6TGJwUWtjaS9pM0tMYUpFd1FiQjd5UERmajRlWElt?=
 =?utf-8?B?MEwvWFhabG9nZlNmMHF1Y0JFTENDT1JNeUg1NmE5bEtQWitGZHlpNmhCdkMv?=
 =?utf-8?B?NWFselhDQ3g5RFFCcHA5Z2g2NmtialZ6SnRBMFFZOFdTWkF2dHBDWUNVZUla?=
 =?utf-8?B?cFg1cE5ra2FyWURmTG0wSThid0ptSEpwQmJMZ21RZUxpbEtYQndSa2ZiN2xD?=
 =?utf-8?B?QWZDamE1NEEzWUo0L3pRQXFmUzN6anBuZnN6WGgwVXFjeU5LNmZ4a2lTQlRN?=
 =?utf-8?B?MWJhbklXSk8zbTFiZ3lxR2x4T0ZMNVpQTE1iZHpRd2h3OS9sOGRBM2lBTm1D?=
 =?utf-8?B?djZWS1U5MmE0R3labUl6aHZuVnAxWHhBMTY1a1NYc2hza1ZXWmZTdWNYamI3?=
 =?utf-8?B?SlhOQUZlQmRyRlU5R2NLNzFBNjZaMzFrT0g2eW9xNXNUWTZSWm43WXE1R0Zw?=
 =?utf-8?B?emMzM1VpYW5xQitDc0wzVUd1Y05aWmcwQ0ZxNFlFSkMvUnByY3lycjR0dndL?=
 =?utf-8?B?ZEgwOTVoYTdsK2M2Y1c1TTFoU2lrQzUvVDV2bDROY2JZVFlnTlJPWG9oU2J5?=
 =?utf-8?B?VzZZNERMR3ZsREUvWHdYT2lrS09CYUZPanZCT200TVZiMmpmWGhlbXVUTVlz?=
 =?utf-8?B?QmppeWd4WjNDaitveTZxQnFpWC8zbFN4bjZsblh1WXJ5ZFFBUmFkeVVhbGNR?=
 =?utf-8?B?REpGaWlxTFNPTG56bUdwR3pIREhEc1cxcXUrYml4M3NJR2o5K1J5T1ovWnB2?=
 =?utf-8?B?UUFhNEErWU5BUlR4NGhxZHNPWWZpSjg0czN6VDJjVDRKV0QyTElJTE9IZGcz?=
 =?utf-8?B?VW5jRHBFUGF6cEJMWFNwaEMvb01hcDVJWUlWaVhPc1dDUkV4K3MxRDRpWU9B?=
 =?utf-8?B?eHpIVVdERmxsL25vS3Z4VzZOdmhTbG4vMHlWdjB4Qi9GN0VzS2dsV0FCdG4v?=
 =?utf-8?B?bjJNemxPTlJTMUowclB4NlpSNnl2QjRic0dkc280cnRQVThlODYyQmN0UGls?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f267262a-6fef-4f34-bf7d-08da703366a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 00:52:09.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH08+VlHAeK9RGLz6szC7nO2O3odiw0IV6YzE1KRG3wDipNAKgUzmew/W+VRM079e9WrajP0QXpp+3xmjqE4YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280001
X-Proofpoint-GUID: xwuPV-5pFBTF588P0cOGqvWHh97VPG8A
X-Proofpoint-ORIG-GUID: xwuPV-5pFBTF588P0cOGqvWHh97VPG8A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,
Thanks for your review.

On 28/7/22 10:00 am, Randy Dunlap wrote:
> Hi--
> 
> On 7/27/22 16:42, Imran Khan wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 98e5cb91faab..d66f555df7ba 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5553,6 +5553,11 @@
>>  			last alloc / free. For more information see
>>  			Documentation/mm/slub.rst.
>>  
>> +	slub_kfence[=slabs][,slabs]]...]	[MM, SLUB]
> 
> I suppose that 'slabs' are by name?
> How can the names be found?  via 'slabinfo -l' or 'ls /sys/kernel/slab/' ?
> 
> 
Yes 'slabs' are by name and names can be obtained from slabinfo or sysfs or
using kmem -s on a vmcore. As it is a boot time option user needs to be aware of
slab name just like when someone uses slub_debug.

> It seems to me that the boot option should be listed as s/slabs/slab/.
> I.e., one uses 'comma' to list multiple slabs.
> Or is there a way for multiple slabs to be entered without commas?
> 

Yes, 'slabs' is a typo above, it should be 'slab'. The name of the slabs will be
specified as a comma separated list for example:
slub_kfence=kmalloc-*,dentry,task_struct.

I will make s/slabs/slab change in next version once I have gathered some more
feedbacks.

thanks
-- Imran

