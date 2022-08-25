Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FB5A19BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiHYTnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHYTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:43:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB17B1BB6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:43:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PJgQB1023613;
        Thu, 25 Aug 2022 19:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Rbr+CpbWH+EapKWEw17nUg67ImcAR+xQUvVN6I9UTw0=;
 b=qHr8m/krYVx6hpEy8Upv+7fbIddhJFrVEcDkRmV/dPaqFuhtwr+NvNVJuQylrxV0AQVS
 IptouX8wog77opaBYwav/8pRzrWUYKL4PBIl7TpHRJ67R2FSX8FQmBfMoESaCbI6+EFh
 ty27dZ+wJl5MD9D+VpII/Q0ZaFU9x3THuQQHjirWT4XT5Bi4vT5pd0bMSAgXYmRecjpG
 DpuzexE9/z5jQLZV5lx0UdhyLikk/DNfGm1MYN0C531KbwmRPMkzxccKIus0Kf8dD3Yx
 Vc7B4JRewWzz7OaSkNKaf14slJWQ5p8BAxLTiAcL2XwnyLjYlb7xb0Kfm2NP1ZLrxBZ8 Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww55c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 19:42:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PHqUbG017061;
        Thu, 25 Aug 2022 19:42:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n5pu67t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 19:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3Tw0dhin5DJyez/G/f7YY4JM+1suuWqgHElvVsPuPYNNTEsu7isS+HBexNf4W1nCFvR5D3W77+S3ahSJKXf3pDGGz+yXXDzM6d7gjAO4BfLfYoWUDCNMWudjUwpeKo8uLdu14obTINBm7Z1xWijkxRSOJlQCjgXrqMlS/olmO3QGLrId3P9rGsGiktfOj4/eXLMslOqz+Y4pYSfubyha6YoWtFu5+zzR2W98bk1XP1LqtABeHfIo0yIWDRMgRF6fAwf5Hg3uHqg9nx5HhWThuN8NQkScz++fEchFn2Ecb/3AWYVXB8V+TV3VzWyDjLlPIxgebc/GgX2PnoTv9r3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbr+CpbWH+EapKWEw17nUg67ImcAR+xQUvVN6I9UTw0=;
 b=Mn0fqA8u/lJdjZ/yuohXSJOiEm5shzNejjLouINeHKnEwzDgmrLT3LkXjwRa+lSbCkCa6p1L2p432HArxxcqC+9p0V+ygMI882S5/5ol8ohB0uREt4OeH0utlbOTewDsIxaU/GRKZ2IU4hdXryHZow6NWnGsUjBAmqJX0AlYtWv2K5iIfKVdisx5akm++0AyjRkFoYRpxrWqNQYGW7gqCgmfzCWpLk88LVGrc7VT5Dbu3rBy+bT2ESsBuz06UY9ZjEzgjohiJ2NB3AQ+d0NVaNItQ9rbnTOnCLk+5/EVV6WeQdQS11UtmNhuUJt5gBq0oz+W3UwfVlA5vLDV7d/bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbr+CpbWH+EapKWEw17nUg67ImcAR+xQUvVN6I9UTw0=;
 b=IefeuuKba0ZabVOWQ1fXdN4uucNCqY3r9vOgzQ59Hhi24iTbc469LSaZZqS+nhjuNhtva4Q864imIcEaaMWTVlY2XcbY1VfRXdHxFzwgdrLG+mynwHSd8BY+NhbFA2aCnzkiUOAfpkzVbolQdQYzr677lAsB7K/0oAhsdWLVyRk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM8PR10MB5463.namprd10.prod.outlook.com (2603:10b6:8:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 19:42:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 19:42:37 +0000
Message-ID: <1d1c19ad-9d8b-b603-32aa-0101504d598d@oracle.com>
Date:   Thu, 25 Aug 2022 14:42:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 8/8] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-9-eric.devolder@oracle.com>
 <Yvbxgvk+5HqEl7J2@MiWiFi-R3L-srv>
 <0395a745-edbb-275a-f37f-c6e799388da1@oracle.com>
In-Reply-To: <0395a745-edbb-275a-f37f-c6e799388da1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:8:57::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9934566a-1f50-459f-0112-08da86d1f6e3
X-MS-TrafficTypeDiagnostic: DM8PR10MB5463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75gkZYQt2KdbrccXtIX2OcDocsk1a0ZuzrCfVbt9Ol7xWot129vBiBN7g1ZSylV/4f0I3DXjQZWw/Qe7gPgeC4o8rPRkv5Pht9z4hBhMBsMEeo6m6sncs8fCERCHbx7nqSl+aR8QQ/LtUwTBp7wfWpZGpFXDPBX8Xjs/Nc2wVca1RaCFQ5ILtkhKN825suo2M01pvhzRldcuvGdNBTmUcUGakEK0rz2KnkXF0rLXtN+HplxNVsFy6bOLi1PZ8ODp11piTLcncSxqFLbESy+1U0cuBaNK8L8kq6IpZDrNpLFtBRG+ikIFWNhF4e59GDZizUZ8E2gB0XUosbP2NzfsldPjJBnv1d4ZT4IlaQLNkX30zaEk8G6i2Q7YkZQt+j427vGcH+pD5+lHqqrjJ5744RgbzXvhowMhvW4E7P1K7iZP235ZjvkKum4hViIzLm4omvoyIEDs32Yya0i13qJ50lcnViWFkGJcI9nPEZEnaRtOwFcgbPQKC0kSGEjVNDXBkJMy81R3ta2xtrX5fDiOsWBp09kYCv/NLNzgAz+u4rQdv6zMDCCERUPzFuYi4LkLzj2hXw/wXinspmi/5rRHJF0jkX3TalGcISQQCXWbyONCffias+iazLZmeYbxcQPSj/fJPj1g98EjJiR+EgwIn7R2CQ8fgM00yNCdQE2kOq0t7MmIRNQzihL46BOUQo93NdTaHt+T9qWa9L12haXUAbYhQlEon/bOxUdjAkdNCbEqtIbinwk08eEpxJDcqPeICy/l/PaiECm5p3CMFDEZMx/+nEVUzbEK519GzXoPm2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(396003)(39860400002)(6506007)(6512007)(2616005)(41300700001)(6666004)(107886003)(86362001)(31696002)(36756003)(53546011)(186003)(83380400001)(6486002)(31686004)(478600001)(66946007)(66476007)(4326008)(66556008)(316002)(6916009)(8676002)(38100700002)(7416002)(8936002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9DQmxOMjd2a2hjRlM5a2VnM25yTEZESUdUTENLRk9xejNENFFHc0lyVlZw?=
 =?utf-8?B?ZTJ1eGZna1hQamZ6S3NjUlJFcVVyVmJFZkRNRkZpMlgrYkpwQlRaakUvbnJP?=
 =?utf-8?B?SnNHSVJ5N3VRdldabDVoSmdaZVBNZVR6UGE4UjUrU3VvalRLVW1hY2ZhUkFB?=
 =?utf-8?B?QksxQ080cDhRQ2JxckZ6bWJ0WlhGMVI3OGhzMU5jWURrQTJBdVVrSHJMZzl1?=
 =?utf-8?B?Sk51RFM3RmdJTTR2K2hSNTBCWUh4SXFqNjdLUkRvV3RiV1I2Y3ZPOVdSSDRl?=
 =?utf-8?B?b3NGSkkrSUxHSU5RVXREOUM2Tng3NkNMb0dSUHhvM1dKODJNR1hFY0hIM2Va?=
 =?utf-8?B?YjVxUGd3Y2xqSUF5MDNqUkJKa2h4aTBlY0dZOG01a1BpTkJ5aURMMzR2Y0tl?=
 =?utf-8?B?TXVGVnN6RDRpSU0xRGlWZlQ0NnJvWkdvM2Rid2psd3YyczM2dDhiZ2ZIQjBF?=
 =?utf-8?B?QWpFdVduaTd5aEZsb29rQU55d09OU2wzZ3lDSkJEVnBqR3pDV3hjZGcxek9u?=
 =?utf-8?B?dm9uK3g0ZXJCQnZ2ZHViT1o5MTFNUE5xaWFlLzZqbUlYMFhoVGQrMzVFM1Nk?=
 =?utf-8?B?LzY5YS9DbFgvRGNBdGVjWTlCQ1c3d2cxUGRFbFVZbkNEZW9VaGs4UEpZcFo1?=
 =?utf-8?B?alVEbUtiQVhyR1pROGtLTExyaWtCOThZYjJQYkpDNFNCY21TclE0Z1IxMVRQ?=
 =?utf-8?B?MmphYmZhSzgySE5XOERDQVU0bG1xOVBjTnVzdDByakYwWENpdld0ejluWE9K?=
 =?utf-8?B?OGprYWU0d2dINWc2LytxK2tmWWVwVEFDVXBMekV0MjNPeER5TDZTNCtRQjhS?=
 =?utf-8?B?NjVUcWtjSnRRMEtXYmtrYjV6UytSNHhiOFVqMFNGcU9lbk5icTJ1dVVtRytP?=
 =?utf-8?B?YkpJc05XcE9IM3V1anY3ekRYK3l0UTJUeUlwU1p5S0lWQytRMkZ0TExnd0dD?=
 =?utf-8?B?YWh2K3NFWDFSeGgraGZTVGJsWnFCL2dVc1ZRc0JGeHNvVXlpc3lTcTFaMDd2?=
 =?utf-8?B?R253Ui9EYy9Hd05zTjQ2bSt5Sm0xS0MxNE9BV2pkdUQ1ZWFFaEZiL1RpWU9V?=
 =?utf-8?B?cFEwVkN0N2tTYmVGSGtvNWxkOHd3NC8xR21Xa2tOSkxPcWo5b2tESmV2bVlF?=
 =?utf-8?B?WlRXOGIyYWZnRWZjRUdNTVptL1BxQit3TnB3Z2NycUhySDlXbEFNZ1VLYUNi?=
 =?utf-8?B?TzlaOG1WYjZLZmlIYXBVUmpKd2lvTXJlMXJEMnhVRUlHcU50bVowU0ZpVlg5?=
 =?utf-8?B?aWtBRW5DcXZkRjdxZ3U5Q0U1bmJYSyt1Q3dUNUNKQndrS0VHTTVVRVN5Ykdp?=
 =?utf-8?B?cjBIOStuYWR0eno5LzNjL1BnUGMyL1g4M1FlQUM3cWhkNjBhWnA0NWdaN1Vu?=
 =?utf-8?B?ajdhNmZWWmcwc0lVVjkxZjJUNkxvSTFOOXlyZ2pKTlV2NmQ3SXZYbnowRVM1?=
 =?utf-8?B?QUh5TGhNVFhPUmt5SkhsNHdEMkNkMmg5NUp4YlR4djc0V2ZYTkJ4dHkzNitE?=
 =?utf-8?B?SEVXTjRid1d3UENvTi82RHpjaFNrRFZxNklNN04rMllEM0hNN2wrWXNjdmxy?=
 =?utf-8?B?VytBdjcxZ2FhUWF1N1FVZi94YkN1cXpCcEJ3R3lqVDNvZSsrNHZSRmQ4U1ls?=
 =?utf-8?B?MXB3c2FkRUtpb3Q3SW5FMDVaUDJITCs0blVIdFk0amkrQ1dxK0xUOE4wTG5y?=
 =?utf-8?B?RzZVbTRCYXppVjdDLzlVNktTTEdWQktubG9SU2EzTUFxeDlRV2NHL2dpak1Y?=
 =?utf-8?B?VElVK05vNlVGaG53azFuMzNNcjB6UktZM05RWUtvV29aNzFMSXI2eEU5dGhi?=
 =?utf-8?B?NVRQV3BJeXduVStxWjhmMXVlczZHdHE1anBScmJ3VVpIZFJ2bW5lMSsvbURY?=
 =?utf-8?B?QmswSktINlZSaXlzYkpKdXFQMDVCMVRlL1NWZkE4Y0NQRlM4dG9xZnlERXZH?=
 =?utf-8?B?ZmRNd1c1UUFrcCtwSWN0MUZGd1FGWk9QS3praGVDV3B6cll3bkgxUnVBS0pt?=
 =?utf-8?B?ZjVsQTMyczUzRGJhcUZZRHhVNE4xeGFCRDRXcnd2RzBkd1NIUjQ0YWlyYUVu?=
 =?utf-8?B?OS9YRG40SDIwK1dndUVuUG1LV0hXSnhxSmtVSFNhcW1haUxqWW5TNVRqTTVH?=
 =?utf-8?B?U0pEeG5wcExXeEwxSzhCTXpseXBUaTlnZnlMNHpoWWo4OXp5NGFiUFJKQjhz?=
 =?utf-8?Q?k60spL6326PJHqLdsxfQV2I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9934566a-1f50-459f-0112-08da86d1f6e3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 19:42:37.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI+Tsyg3tUfI0P8cGFyRLs3oZAaRhyKAJqyud/U+uX4UfvWfWQUIyjcFZpEgAxHKpGRTpVxn5u2db9wDI/gv/q/cMvKwRo9VFkLlxQ1ndZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5463
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_09,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250075
X-Proofpoint-GUID: 778CIdPRaUAq-XLG_IbNOZQ-lWNEiCa9
X-Proofpoint-ORIG-GUID: 778CIdPRaUAq-XLG_IbNOZQ-lWNEiCa9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,
I've v11 ready to go, but I did raise some questions below which would be good to resolve before 
posting.
Thanks!
eric

On 8/16/22 10:23, Eric DeVolder wrote:
> 
> 
> On 8/12/22 19:34, Baoquan He wrote:
>> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
>> ...snip....
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index e58798f636d4..bb59596c8bea 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2065,6 +2065,17 @@ config CRASH_DUMP
>>>         (CONFIG_RELOCATABLE=y).
>>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>>> +config CRASH_MAX_MEMORY_RANGES
>>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>>> +    int
>>> +    default 32768
>>
>> Do we need to enforce the value with page align and minimal size? I
> 
> Are you asking about the value CRASH_MAX_MEMORY_RANGES? This value represents
> the maximum number of memory ranges, and there Elf64_Phdrs, that we need to
> allow for elfcorehdr memory. So I'm not sure what the concern for alignment
> is. I suppose we could also institute a minimum size for this value, say 1024.
> 
>> checked crash_load_segments() in arch/x86/kernel/crash.c, it does the
>> page size aligning in kexec_add_buffer(). And in
>> load_crashdump_segments() of
>> kexec-tools/kexec/arch/i386/crashdump-x86.c, it creates elfcorehdr at
>> below code, the align is 1024, and in generic add_buffer()
>> implementation, it enforces the memsz page aligned, and changes the
>> passed align as page alignment.
>>
>>
>>     elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>>                                                          max_addr, -1);
>>
>> Maybe we should at least mention this in the help text to notice people.
> 
> Unfortunately I do not yet understand the concern being raised.
> 
>>
>>> +    help
>>> +      For the kexec_file_load path, specify the maximum number of
>>> +      memory regions, eg. as represented by the 'System RAM' entries
>>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>> +      size to determine the final buffer size.
>>> +
>>>   config KEXEC_JUMP
>>>       bool "kexec jump"
>>>       depends on KEXEC && HIBERNATION
>>> diff --git a/arch/x86/include/asm/crash.h b/arch/x86/include/asm/crash.h
>>> index 8b6bd63530dc..96051d8e4b45 100644
>>> --- a/arch/x86/include/asm/crash.h
>>> +++ b/arch/x86/include/asm/crash.h
>>> @@ -9,4 +9,24 @@ int crash_setup_memmap_entries(struct kimage *image,
>>>           struct boot_params *params);
>>>   void crash_smp_send_stop(void);
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>>> +#define arch_map_crash_pages arch_map_crash_pages
>>> +
>>> +void arch_unmap_crash_pages(void **ptr);
>>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>>> +
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +        unsigned int hp_action, unsigned int cpu);
>>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>>> +
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>>> +#endif
>>> +
>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>>> +#endif
>>> +
>>>   #endif /* _ASM_X86_CRASH_H */
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index 9ceb93c176a6..55dda4fcde6e 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/memblock.h>
>>> +#include <linux/highmem.h>
>>>   #include <asm/processor.h>
>>>   #include <asm/hardirq.h>
>>> @@ -397,7 +398,17 @@ int crash_load_segments(struct kimage *image)
>>>       image->elf_headers = kbuf.buffer;
>>>       image->elf_headers_sz = kbuf.bufsz;
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>>> +    kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>>
>> Do we need to break the line to 80 chars?
> 
> Sure, I will do so.
> 
>>
>>> +    /* For marking as usable to crash kernel */
>>> +    image->elf_headers_sz = kbuf.memsz;
>>
>> Do we need this code comment?
> 
> Well, it did take me a while to figure this particular item out in order for all
> this code to work right (else the crash kernel would fail at boot time). So I
> think it best to keep this comment.
> 
>>
>>> +    /* Record the index of the elfcorehdr segment */
>>> +    image->elfcorehdr_index = image->nr_segments;
>>
>> And this place?
> 
> Not necessarily needed, but I've found it useful.
> 
>>
>>> +    image->elfcorehdr_index_valid = true;
>>> +#else
>>>       kbuf.memsz = kbuf.bufsz;
>>> +#endif
>>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>       ret = kexec_add_buffer(&kbuf);
>>> @@ -412,3 +423,107 @@ int crash_load_segments(struct kimage *image)
>>>       return ret;
>>>   }
>>>   #endif /* CONFIG_KEXEC_FILE */
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>>> +{
>>> +    /*
>>> +     * NOTE: The addresses and sizes passed to this routine have
>>> +     * already been fully aligned on page boundaries. There is no
>>> +     * need for massaging the address or size.
>>> +     */
>>
>> Can we move the code comment above function interface?
> 
> Yes
> 
>>
>>> +    void *ptr = NULL;
>>> +
>>> +    /* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
>>
>> Do we need this code comment? On ARCH where proctionion is made, we
>> surely need to the protect/unprotect.
> 
> I will remove this; I've mentioned this in handle_hotplug_event() where these
> protect/unprotect functions are called.
> 
>>
>>> +    if (size > 0) {
>>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>>> +
>>> +        ptr = kmap_local_page(page);
>>> +    }
>>> +
>>> +    return ptr;
>>> +}
>>> +
>>> +void arch_unmap_crash_pages(void **ptr)
>>> +{
>>> +    if (ptr) {
>>> +        if (*ptr)
>>> +            kunmap_local(*ptr);
>>> +        *ptr = NULL;
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>>> + * @image: the active struct kimage
>>> + * @hp_action: the hot un/plug action being handled
>>> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
>>> + *
>>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>>> + * must be updated with the new list of CPUs and memories. The new
>>> + * elfcorehdr is prepared in a kernel buffer, and then it is
>>> + * written on top of the existing/old elfcorehdr.
>>> + *
>>> + * For hotplug changes to elfcorehdr to work, two conditions are
>>> + * needed:
>>> + * First, the segment containing the elfcorehdr must be large enough
>>> + * to permit a growing number of resources. See the
>>> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
>>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>>> + * list of segments it checks (since the elfcorehdr changes and thus
>>> + * would require an update to purgatory itself to update the digest).
>>
>> Isn't this generic concept to crash hotplug? Should we move it out to
>> some generic place?
> 
> Yes, so I will relocate this.
> 
>>
>>> + *
>>> + */
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +    unsigned int hp_action, unsigned int cpu)
>>
>> The passed in 'cpu' is not used at all, what is it added for? I didn't
>> see explanation about it.
> 
> Well its not used for x86, but as I recall, Sourabh Jain needed it for the PowerPC handler.
> 
>>
>>> +{
>>> +    struct kexec_segment *ksegment;
>>> +    unsigned char *ptr = NULL;
>>> +    unsigned long elfsz = 0;
>>> +    void *elfbuf = NULL;
>>> +    unsigned long mem, memsz;
>>> +
>>> +    /*
>>> +     * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
>>> +     */
>>> +    ksegment = &image->segment[image->elfcorehdr_index];
>>> +    mem = ksegment->mem;
>>> +    memsz = ksegment->memsz;
>>> +
>>> +    /*
>>> +     * Create the new elfcorehdr reflecting the changes to CPU and/or
>>> +     * memory resources.
>>> +     */
>>> +    if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>>> +        pr_err("crash hp: unable to prepare elfcore headers");
>>> +        goto out;
>>> +    }
>>> +    if (elfsz > memsz) {
>>> +        pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>>> +            elfsz, memsz);
>>> +        goto out;
>>> +    }
>>> +
>>> +    /*
>>> +     * At this point, we are all but assured of success.
>>> +     * Copy new elfcorehdr into destination.
>>> +     */
>>> +    ptr = arch_map_crash_pages(mem, memsz);
>>> +    if (ptr) {
>>> +        /*
>>> +         * Temporarily invalidate the crash image while the
>>> +         * elfcorehdr is updated.
>>> +         */
>>> +        xchg(&kexec_crash_image, NULL);
>>> +        memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>>> +        xchg(&kexec_crash_image, image);
>>> +    }
>>> +    arch_unmap_crash_pages((void **)&ptr);
>>> +    pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>>> +
>>> +out:
>>> +    if (elfbuf)
>>> +        vfree(elfbuf);
>>> +}
>>> +#endif
>>> -- 
>>> 2.31.1
>>>
>>
