Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895D5307BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352962AbiEWChI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiEWChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:37:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF51CFF8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:37:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MEVBOl022970;
        Mon, 23 May 2022 02:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5QUUPhggLzZllFwOiY2dUEydUWgmon07iUdc/P6UJ1M=;
 b=APaYw3ILqHCLXZE64zrm6mK9Mk1nrexRzyQqDD0TZow7iN22lfHTCpyC0iIkRu8XYQNc
 EYcCpMMeeDFbYFucBAw7dF8vqU3tD6E56oqPd/viSkF/UhVE/hMGlXf8hyHM9ntTWvDA
 CMsMZF3KubWhtMbuKzfZbBqelO1RCUI8rwmXVhjhAm86mUGMIKBGfY2aRrLQiCOyrBPv
 /1U3PCPfL3JCWCWnzdI2tR4J4+dUDulbopLjtiR0jw0cteB+7wDqc47DaZBd0d4pfT7Q
 ilhYLXGYpSf00ONtfTZBVMe12tKUqsaQUuTbgKI93Xpaz+/Ng6IzNpcpqmNjThGeGEKw +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pv2240c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 02:36:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24N2Vq60022844;
        Mon, 23 May 2022 02:36:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph7br4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 02:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxYzdXBOttmTDgJ9cuDa06FU0w8ewHl5hwIGuHZhayMEVxiQAG83ZpltIZspQ93JvT8mpW3v0/yjcQnbuJyPWer1HVlcRYa/zsnpl1oe52VNRAMFN++iwQ7+2kCy9bT8+9ufKIOnH1G6DIlRBb6FB3+KNNkbf10IWGUCj1lx4X+OlDKvwmpkY5SfYoY2P2F5N3OudaD2mXFKEA3sUQEvMKo4tBfuM4lWck/yykJ9/K9af3E9kuHNeaRfKSNjg4R7TwYMHyse6joW/DfkDjeT+4XeAz+4MUj1shPmU5X9qEmMPop4ZHP3e9K09F74J/867SUTVcQcumoMqF812V7e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QUUPhggLzZllFwOiY2dUEydUWgmon07iUdc/P6UJ1M=;
 b=eJAx+WERb0IiZspA9ZL+EsXHXLGaIIASulRcUtNpDO25XymKLg7Cutc/JgD01BRUhFlS51BLTA+s6ajDZRHnZb12v29h7TJb2fnkZmxqyPQOBC+XcCCCKWFQXTsu1TLXN+KIyRG16iPonbI9Va89OS1M92u5/uk8ttEhVwW1DuXpYJanfwXdju4Y/T49oGuj1WwgGy1W5/JfAqFlJZi+iCdIxcrp/l64QYwKSL8z0mTWrZ2rBObgBN0sKUYU9eeKJkBllzQLK+Xta1PSqhvF7z9KqaEu/gBLl9FxJb8apKyeglIfQLxnMVebqlR/4/055VUkaT2VPUagaeFB2eZgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QUUPhggLzZllFwOiY2dUEydUWgmon07iUdc/P6UJ1M=;
 b=CMvC99b41bssfx5kXm3edI4gDkOuW6uXTN+E/VSnZJxe67r/rqWC58tt2FUUm/JS2ZIy5L4ru0joqlVgLZp5H2uNznnCBpCopzo/XoX+O+rwENls4Yv8kxVXeHOlGwXZK4YRSiMmeFeIgQT47dTomG52kxPRLaVJbK6nhGstppc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB3452.namprd10.prod.outlook.com (2603:10b6:5:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 02:36:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 02:36:55 +0000
Message-ID: <e658cd60-0404-e055-f03d-a1866f77abd0@oracle.com>
Date:   Sun, 22 May 2022 19:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] MAINTAINERS: add Muchun as co-maintainer for HugeTLB
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220521074103.79468-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220521074103.79468-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ed3a295-0e42-4462-3c1c-08da3c651a41
X-MS-TrafficTypeDiagnostic: DM6PR10MB3452:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3452ABE3A01383A36A8689E7E2D49@DM6PR10MB3452.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0A5j6HRr7Esl4K6kO4YN1LJrCxMmH35t4cATRvqBsxytr47yb8bQP0Gg5kx9R9bbNSSfvpKfEYzthFSHvOxNw1Xdk7W1GuOJzw1R52toV6NZl5SRh/Yqqv+IXCNyuVIOIP7UeG2IY1Kd+i2i4sA0vVw7EXpGRL7UMvgQWAIlkxo7sFFjf8CG7DOVKfVMfsCVnJ3VFaoSu8hFi3ryKJSsCAmdTq+lTVm0BhBfU9vUKb3fUNuf8zmE//6mJ4G8CqEH6MpI2m8fEnSBK0qj8e5JRinqH42sPPRdi7tQX4jiBBfRRrKX19/HvgAWSjj+mVT9pDlJsMgo7+rkhyeP1SyaYUEnoW3PIkDGVUOMpRKkYBUZ8+0k+Cc2hrs3R3s4EYgS4hlI1ZrytiVc28RpHEkcEMgzwvrHB616obs5mTKazGMInIyghZsTE9trYAjAshsTCkpCCGQqqNKRC+UcUCm5P2PfTgdrFx0U/2Oq5MDXSxtpQ+5TQMyY6dyqhFwxLJkKzuQY0iiDPW45scXraAQDKhV3IzNJna9xDxBiPUFxiASH1klkfTLU0h440uiZcN+ZsvNURY9MdZUzOhcQc1KdI7TZwoRNabgu/B9mTMmrXLVO7apJvHUbyJj4+dYtvY4PVFTTowvP0skIdFDDM2hRna7+1ZeY18l1dbDxludBMBTjYFaPszFQ6m3eFJMDp2gRxwukqsXy493vZqW4pRNMOTwBH8FL/pYQe1ducSBFT6s5r5C8CT10g38+gRPLnyNxCyTElzcQhzl1Hy9jaI4Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6506007)(53546011)(52116002)(83380400001)(36756003)(31686004)(2616005)(6512007)(508600001)(26005)(66556008)(66476007)(8936002)(2906002)(38350700002)(38100700002)(4326008)(5660300002)(186003)(66946007)(8676002)(86362001)(316002)(44832011)(4744005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVyMVJaYkFPbE5IcnoraWMwYVlqcTFKc2hyaTVmczIwYWgzS0h1Q3lwREJt?=
 =?utf-8?B?T0xWUGppS1QxZmpkdXFTZFNTcEhFdUhWQmh2ejgzL3VSN1F2bHF0SHIzTXNE?=
 =?utf-8?B?RHV0UVc3Z3BqUkVwYnJqYVlZRThycmJBRUw2aXJtZU9LNWpSejBVQzI1MzFD?=
 =?utf-8?B?QlNmcUk5cmdrWEsyTGhycWxOQVRDK3MwRmYyeVk0MVNibzJyMitzNEl3djE5?=
 =?utf-8?B?eGR0Wm9zOGs3K3kyYVB1MFZicUJUTzV1TnBMMFRsQXNuc09BK0RCQzB6MUxa?=
 =?utf-8?B?djBiTm9hZ1BWVUREYTZEd3kxUWVxK0x3anpBVXIrOWxodGhpOUlqWEdlcEk2?=
 =?utf-8?B?c1VWMW5OVEZjVTRLalRmZE9QelBlTkJ2clpkRWk0aElwTUlMYnU5WlhvbUc2?=
 =?utf-8?B?SmFhTlR4bDJGNFVTRzE0RXF6WTQyL1hKZ0UrMFVHYWNuMFVLWW5LVWRLaTU5?=
 =?utf-8?B?bVZGOCs2OGtFQzBJblc4ajhTTkIrSkdQKzQ1ZjRIUUpyTlR3Z0J3WmZObW55?=
 =?utf-8?B?c2xvMTdzdGt0UzU4M1RDQi90YkRoODNrbk5LVE95WlMxTDJvWDVSVWhkQ091?=
 =?utf-8?B?NGVvU3pWK3Juekd1aXNEYi9kN2djNkt3RTM4Rk5QZ0pVS0x5ejNYSW96eWV1?=
 =?utf-8?B?eS9lTXZNQkVseFFEZVlMVi9lcUpQeU1PS2hCZHhyUlZJZVBmK1pWY011YVZx?=
 =?utf-8?B?cGpOMUlMT2RlK0JLVEtIUW1BLzdaVlFTeitvb3YvS0pXV09OOUVyMWphcGth?=
 =?utf-8?B?bllML2J4TS9NbnRUOHdZVFVHWXZPc1FxT3VHb1ZYd1I5WmhuQ0trNmU2NFpn?=
 =?utf-8?B?TnN6dDE4bVFMVndyY2tHRUZudVQwVkRMVlM2YlZlcFVzMUIyV3VISDQ4bi9m?=
 =?utf-8?B?bGR5NThXZjg4NlprUnZuNzJFczhrR3F1K2duRlA2cDMvR0gxT08rNUdiTW9Y?=
 =?utf-8?B?Q3Y0ak9KRkl3RGMzbHNTcXdJZ3VUOGRJNHZsTTdLQk53dWtZT3N2ODR2UnBt?=
 =?utf-8?B?SXh4MHhNRk52eFM4bjlDQVU3WlhkOWRIYW93UUZXOWxNUGRucnk2S0ZjdXhZ?=
 =?utf-8?B?YVczdExXNWRYSmNhNVdaOEVsYk1samo4RUsxeFdUNkpveFZPa1cwYUJvNkxS?=
 =?utf-8?B?K1g4OG50SFZUVVpvM2R3WGdLL3dHVmE1MmVBajQ5NnBicm9renY4dXF6OUYr?=
 =?utf-8?B?YVlPb0lYMzgrSHhvN3kybVRKdC9LTG9mUlM1NnN2UGMyVCtHWEc3Mm1XU2Qz?=
 =?utf-8?B?Um1ZSHprK1FDTjJNcWM0SnY3T25sVmZ4cVVPTGh3dUx1RGx0U3R2MmIxWm5i?=
 =?utf-8?B?QTBJK1JuY0tTZmNSNWFHQjRGT1g1c2c5ZWw1S3YweUMwSzVOdkg0YVZEdFVs?=
 =?utf-8?B?MTdmQ2RrRDlrdWtUNWNxMzJ3eE0yZWI0eWFLdThiblpZWU9EZWZ6YVdmb25q?=
 =?utf-8?B?UG1LNFBHYnd6T25tcjEzNDYvRkpvLytML05LTXByL2V0T3c5K3hHa3lNNFZM?=
 =?utf-8?B?TEtUM2tPQ3dKSUJGQ01DUllZVUtHR21US09mNzNvVEdLVVNyWjdTUzY0eWhu?=
 =?utf-8?B?OVBZMUVUc3BSYXF2d3VrcC9GazM2NUowaU42ejk3NXJtNU1CSnBBTUZnaXhS?=
 =?utf-8?B?MnF1T0VxeXRlOWVoYWdnbElYaXB0eVZnVE1SelArcTJLa1BjTmI5NkdhVE1Y?=
 =?utf-8?B?WmE1a1gxZ2k4bnlCTERiOTNsTExzTCt2d3JDck5DUG05dkJOQ3B6a1JZcE1j?=
 =?utf-8?B?Nk9FemNRb21MVytsUEwxR1lRRzN4bUQ2SWNOQmhwWU1ZUkoyc3ZqcTg1dHRF?=
 =?utf-8?B?dlN2RUxhQmNDZDBDak9oaFA5N0Faa2IvYmRqbldzbGdKZ3V3a2NYeEFUWHh0?=
 =?utf-8?B?UTgvbnZESjhnR2lqb2tURmdhcGp3M2cxSnNpUXZaRGpwcW9acFpjTW1QNlRs?=
 =?utf-8?B?NnFEaCtDZkR1SERpbGphTFBqbUZFYVYxNjVhWUsvVjZpQlhwakgybnhnWWhD?=
 =?utf-8?B?cTEwaTJTYmtTYXdxdUJXL01JakFHOGxLWVhaenluaG9PNjBEeWt4UWdxTHJ4?=
 =?utf-8?B?bURyeTVrOTZrY0VHdXFlbytSc1ZrV1lvREd3djFYemtZZmhGdnlJNmF6dlBy?=
 =?utf-8?B?Q2xpR2poZXRlRHJPMW1FVE1vbmRxOWhwVmY3ckZGK2h1M2llR0xTRFhyR0dQ?=
 =?utf-8?B?UlVmMTFOZ2xLZTZNbGc0SVBKSUxpcGNtcFo5ekFwb3g3OXJQZXNRNmIvc1U4?=
 =?utf-8?B?dWN5eStyRU9yR3E4QUFnRGZMRTFSVnd4Z0FvckxHb2ppSGZSeXZ1M0ZSYnFl?=
 =?utf-8?B?bUNnc05VMExhdE5BYWtjcVZLZVk0Smx3dUlmazkyeEdnL3pjV3BIVnFBNWpX?=
 =?utf-8?Q?ThjgQ5epctqzD2no=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed3a295-0e42-4462-3c1c-08da3c651a41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 02:36:55.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71J9NbusIeT9f+6gyxIjok3CdOEBbXWdxqI7924Pnek8ZP04wTIfTVeyJb/WfKjlYsKiiPFFN84RRvyTizhUuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3452
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-22_10:2022-05-20,2022-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230012
X-Proofpoint-GUID: 8RvTxLBI9cM05I3wp2kfdq82jEia0Ri4
X-Proofpoint-ORIG-GUID: 8RvTxLBI9cM05I3wp2kfdq82jEia0Ri4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/22 00:41, Muchun Song wrote:
> I have been focusing on mm for the past two years. e.g. developing,
> fixing bugs, reviewing related to HugeTLB system.  I would like to
> help Mike and other people working on HugeTLB by reviewing their
> work.
> 
> When I fist introduced the vmemmmap reduction, I forgot to update
> MAINTAINERS file.  Let's update it as well.  And rename "HUGETLB
> FILESYSTEM" to "HUGETLB SUBSYSTEM" since some files are not only
> related to filesystem but also memory management (the name of
> FILESYSTEM cannot cover this area).
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Happy to have Muchun assist with this effort.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
