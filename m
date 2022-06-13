Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E89547DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiFMCge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiFMCgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:36:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145D6219A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 19:36:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25CIxCOd029561;
        Mon, 13 Jun 2022 02:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8k8n0lgUxQfxB18opchHHDzReyg18/nG5B+6eqzn4ig=;
 b=eElQw7FeKvZtF7QSUkS+Mnb9KBemF5z6ZG/CLKM454LMM7rD7DeMUinvYxPAfacRt9XU
 om3LVa2bN6UEezRw6s2HHVADUoU0o7a4SPjJ2k0hUf1eOpnkRgTmBQvYyVc19ogZm34V
 Z5Jfs4SwTBO6TWHEIRWYwnZPLcQTnDpsJjQp0QWRqoYYNbBvmWxvCOOXeB/Ww1OnCXs9
 98ohGi+bqiNhH4rIZFAkImh9wYhuSlD/2cMLREba2bWQ7tlBcXMh5ZJeUeCQHZRfZB1K
 xu3iXl0selY9uxzuIPbMmCu1+G0Z/9ZM8RE933F3g+PqawJYlg0e+dED5sQucOm1chif cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkt9vr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 02:36:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25D2Gi1q001046;
        Mon, 13 Jun 2022 02:36:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gmhg2t6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 02:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChokW08RIs4k+94nj7lf0Wn3g8XDKfmDCEY/BFA1PR2oaZ/9uu8YturV+/JDIhcLDbIcKS0VFzH/fvIRlREeMYDXy5geMdvH43QeNXg8HRkKxjww4c0FxElG1e6qoVNBJl/WLDhAc+YHyvcVHAo9H8ves0s4k7HuoD8nwYF2i5XlX3Eb9j4/AAram/hUlCiFf+Iev5oTA4Wx0LThmNHgO4T7fuy3w0dUNEoUqUaNlapRGRlwNUDQLSEljz9xb6aw6uTlMUK2jNPITdxweYYKmJbB0jh/7VaTfhSBFhhFb/tvnpedS8qgJ0em4M10IiIrWAT8v4a3WXC/PbY1Zt0SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k8n0lgUxQfxB18opchHHDzReyg18/nG5B+6eqzn4ig=;
 b=L5fqlhI/mWZHc0EccMxTakkDgvE1bbMh2rzffR8LyOX8+E39D4QIxSr+fGBiXTctEkhKuNz4BleHHQ2183dTM0sbsu/L2on9lyCOW5n2bUgRbNQgjEYPP8NTZv8KU5a6/BtGhK3HcoBN2riQPXcbeA9azg1VOqoQeTASp7hq/JTo70ep82jyqquN0+Ur8NrP2Xeiz2/j2Z7jd/9uh3Vut7TBE0OTcTzurd3TFRUs3hdhXFo3DraxI9CgH0GQV7uQVGe6JP34+M5eXRpTYhK5dWzkz+VtQLIMdcyogDqZdE+yvQOYAzQoA2xTh07JeCQA39a2n1Ra+WAYs/sTUQSxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k8n0lgUxQfxB18opchHHDzReyg18/nG5B+6eqzn4ig=;
 b=I74dY36EO3eJ+tD+GQrNYRH7SdoAP7yeODdTLOGgGz+0HqpvzoQtLmb7eSoUdKU+mTXN5gtHD3rzy5bugZ5TI3P8wE8Afgqf3BmcloX3ko5v051dvdM2mtAxcRDQgrs84y69ap0ZBHuyNSujSZthMJs5taLvbVfgolRr8+n/dvI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN6PR10MB1858.namprd10.prod.outlook.com (2603:10b6:404:fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 02:36:19 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 02:36:19 +0000
Message-ID: <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
Date:   Mon, 13 Jun 2022 12:36:12 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v4 1/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20220602063907.136569-1-imran.f.khan@oracle.com>
 <20220602063907.136569-2-imran.f.khan@oracle.com>
 <YqYpTShTDLvAp4vx@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YqYpTShTDLvAp4vx@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:10:111::19) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866cafa1-ead7-48ef-1362-08da4ce57f12
X-MS-TrafficTypeDiagnostic: BN6PR10MB1858:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1858ADE10B4FD7E9C9EE6D6CB0AB9@BN6PR10MB1858.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxuuVxeRHhp8zczO1j36+QbmlE6D56CheaCHb3MuzBI3jrrOrNzTwBKPzpZGRLup2zN7IFys/qfd8OPjlXP9Pr2r4QMlrQCYDRJKue4GXc14wJE+biS6B7T6Br/BIWlBjQIciFuKYqwUiDX9uHq/agzmKpA9OQldok5Yl/nP/+pWZhF4XQV7JMi0vyqoUECQBDdyKptBaIf9MSvPnTXQWPWU8MdpxaA9zqearBCpYE3fUSZk6j+1hoBnIu9MgYvqSFLdp9TWgwr6IQ2ial9KtXdIg3arrwCrmD0fRmtfHRce5kQ75ye9/ii4r4pgNR8bwyQEdk+2WoVTBaqloBULL5YztsN20A03j+KZBVvoYoVk+taLUdbMbPfLxtmgRQtOM6Oj4aKWM5EzCuCFKPIsinY1dxhGma8MbLZZAi5TU/xu5c85+R4+54tlG62Q0GD5mWSR23WB9/FZjUfkg3IqXp0pBpjixyBYtHY3kxf1DdOVoC98rDtu0NRSWSNZX7zTMTIY6SREKy1ECsUpI68t0GVaxADcsSUad7+HaTk/4/T0aLHRi7EUni8tnRD3n+iGMfS2TGUvGfU/rnZqOevp2xJUeJ9/8J/b0q/3YdZI0FhmtqAlIgbzmeaL2fPzgCYX6nJYtzoxJb+QWI4CnF3Rtlnk4nZvhI73LkeS+YqVjS/2U96nnpl6z6uDJSTe7QBMA3s0AL8r07y2g0n0kPpYdt+DVozl+3nOGrK1KLHRmLa2R0VaA0iTyh7kbz1zbCLCT5p4nw4pTPaMzIRzl+nbvG4KW49NkCzOwF0FKe878Z1uwMRNL6Tb6/J1Y7KTMEVL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6506007)(53546011)(26005)(38100700002)(6486002)(6512007)(2906002)(5660300002)(8936002)(966005)(31696002)(86362001)(316002)(508600001)(83380400001)(36756003)(6916009)(186003)(31686004)(66476007)(2616005)(8676002)(66946007)(6666004)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXl5TmdoM2JxNnlBeFIxdHh2RE5kbVZOa3QyS0ZnOE5PcGVkR2Zwb2JXcmxN?=
 =?utf-8?B?b20zN0lKdGhiZDZtSjBycjI2elB6OGkza0txUVZyNFhkdUR5TlNyN2ZJOXNw?=
 =?utf-8?B?R2ZTM2V6L3Q2S29iYlJBZVp2MTIzVkFvTDBQcUk3eWhZbGxSa1ZiYitFN0lt?=
 =?utf-8?B?Z0ZNbFRSVTdpVnd2V0xpYmRFNzRtT2RSVGg2MG5SQ2RSZ0Yvc2NpaHU0bExy?=
 =?utf-8?B?QzFnQjhnTU80Sjk3RzNkN0NVMXVibHA2SGxNR1p4WjBJTTE5VkF1eGJNSzBB?=
 =?utf-8?B?NXVWcXVYUzdXckR2cHF2TTVpK0NYSUN4OG4xdGJZVEV1SzhiZ0NCZ1pUWHdn?=
 =?utf-8?B?UGRQd25WcnFEdFB3eWgvOGIrdnRZZWJER3RtS1oxY21TbzIwT0hhZ3ZaWkhM?=
 =?utf-8?B?eXhBM0RCcll5U0F2a2k0a01DSlpGOC9hTHpIeFVtWWtDKzBOeklNa1VkM1NL?=
 =?utf-8?B?QjMzUXMzdXVJTWVDcXQ3RUwyUzBDYUZtREdZaFR3aGV5cElBajFkNGxFZkhQ?=
 =?utf-8?B?aWxSd05qUmZ4ZU9TcWc1L0FZRVZiNWVmVGYwdU9wNlA4RlNBMzlVS2I5SnVt?=
 =?utf-8?B?UTdtRk43aEd0Ym05dUNSOXpDaGJ6ZUoyWmllR3BJOGpxdDZoQ1o1QUZudHFF?=
 =?utf-8?B?VW5BaGxHaGNUSUhOT2xSMmVJTDdvaHNsK1lSbDlxdUpLeHpDYlE5YVFEb0Jl?=
 =?utf-8?B?V2ZYMTVrbVRoeFppVklZajdCcUF1K0NyUkl6V21WYXJkZXhwbGFlQlUxMS9F?=
 =?utf-8?B?ZTVaTnAyRy9HYmpFRWpYL1g0OTlwbSt6UkJWcWUyb1hVcW1rbE9ZQS96SlNW?=
 =?utf-8?B?RkdKeUxTZGdDYjBlbVl0Q3ovTjRvUTh2MGp3cFBYSXVRWS9HWlU1VXhMZkp0?=
 =?utf-8?B?Mnh3S1hZU1d0LzRSQmtIL1V2cmFMSG1PeWphRktWOXRBY0VOQmpLUG1FdUtG?=
 =?utf-8?B?bkFidjB1Mk1NeWtERlZDVWJBMmhMQy8wMHRHYmlkREFUaXZNd24rVzM2Y1lt?=
 =?utf-8?B?RmJLWndmSWVOY1dxZStqeVZIRzZ0S3dtaUxoSzlTa0UvVkx6bXlmdFZHZTM5?=
 =?utf-8?B?Vk02YmlTL3Jac1VRc0Jxa1dzSzVhTWdURE9rWjNJbzdWdzlaQVpVZ3NNN0Nh?=
 =?utf-8?B?OExMUGJwdURCNGtxQnpBWk5wOC9vK01GeHNLelRxMUc1QXFzS1ViN3I2UnNQ?=
 =?utf-8?B?YkZzdmJlcGh4YlZTWDN1YnJ1Vnl0enFxUCtWVjdzaFJJdlNNN1Jham40eEls?=
 =?utf-8?B?RzhpK0paMzYrS1ZtQzRpU0xIR05uY0YrWSsxWnpBdnllUjZDemJWZ2tqS3M5?=
 =?utf-8?B?NkZlYTBLblYzUWc1cHVLWWEwbWd0RVN5MU9wMmMzaWRpdkRnMy9XbkpMOWEr?=
 =?utf-8?B?ZmRHak1WRFRVMTBPQ1luNC80eTZmcW1YbXVhejJxNm5Rd1NVSi8xckVMZkFQ?=
 =?utf-8?B?R015UUxyVHpwVUUwdHRNeUpxWVQ5VVlrNmVhS3hpbVNYeFR2TUx2aEdtMCt5?=
 =?utf-8?B?R1RLd1VYU3ZKd1N3dFFhdDJMOURJeTA5UW1lWWRpM1VlTHFvZWIrQ1pvU3F5?=
 =?utf-8?B?Tk44M2taSzZBY0NhODRsaUZhZ3F5VmNwOGN3M1MrZXc5YnE2dlJiZ29vbnBB?=
 =?utf-8?B?RTBhTDBqdFVXajI4bGZra2FJcUNtM1M3REhOVkpUNy9UZFdWSExlYUZHOS9J?=
 =?utf-8?B?VGpCNW9XeG1UQzBzbnQrWWUxSDFRYU9jNlo2ZURmb0pmMS9OeGJOVXFvOERw?=
 =?utf-8?B?MzNiUnRBemtHYWl0dFh6UDAxbjB4Nk52bG9zbzEzY3Z6TXBjTTBWa29NTEFS?=
 =?utf-8?B?RUdCWi9rZHpMRVJNcjJCbHIrdm1KQUpCT3NqSmFPd1ZaaThQUUl1c0tpS1Bo?=
 =?utf-8?B?aXRxVnZEUXNQb1I3THZvMTdwSGVUQVZnQ0oyVTlQTTlTaTB3QmtVczBpM0I5?=
 =?utf-8?B?WHNuNkE5cFRGK3p4aHVEZTZKTlVkVFZUR2V0c09uWFlNWkxoUktKKzY0RmZG?=
 =?utf-8?B?enBvckNHWWJ1RDM2SlRFMXl1bVpneDcrQTA1THJZZHZjSlE0SGFQT2dCTVNi?=
 =?utf-8?B?cUJUYUJiU0JaaDA1enhLV0NyY0RqZTEzZW9IVVdvRkpreXhOMjJGRHI1SnE2?=
 =?utf-8?B?QVhCTWZrYzdDaU5FeFJoaitRWitqZWl5NHYydDg3NG43U1Y4RTZYMXYrUjNl?=
 =?utf-8?B?K29pMG9xS0ROV0NvNVlwMDRXeHVmZHRHNVQvai9TRU5XWXhrS01LWjRnWkNp?=
 =?utf-8?B?SktSdmsveEMyRXI5NElIWHhSK1h6UFdKT2FoQllHeDdJa2taZzh0RysrZks4?=
 =?utf-8?B?WDRNdzRFckR2dXpCVVRDVkhNc0VUWDRKYVVYb2ZtNkl4c3Z0OElvcGYxT1gr?=
 =?utf-8?Q?phFLQtFoJ9oSH7IU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866cafa1-ead7-48ef-1362-08da4ce57f12
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 02:36:19.2428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX08OQ5Oo9Uw9D9Umh8zZ6MCR73N9ZJxHWVmzn0c9NtX60ieV1Mbfa5dmbztc7Knk9wjB9se1Ct7Be4eYYupCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1858
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_01:2022-06-09,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130009
X-Proofpoint-GUID: mrHU5giwhPF6IAcVgYkkSThLOVG-5BbH
X-Proofpoint-ORIG-GUID: mrHU5giwhPF6IAcVgYkkSThLOVG-5BbH
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 13/6/22 3:58 am, Tejun Heo wrote:
> Hello,
> 
> Sorry about the long delay.
>
No problem.

[...]
>> +/**
>> + * kernfs_check_open_node_protected - Get kernfs_open_node corresponding to @kn
>> + *
>> + * @kn: target kernfs_node.
>> + *
>> + * Fetch and return ->attr.open of @kn when caller(reader) holds
>> + * kernfs_open_file_mutex.
>> + *
>> + * Update of ->attr.open happens under kernfs_open_file_mutex. So as long as
>> + * the current reader (caller) is holding this mutex, updaters will not be
>> + * able to change ->attr.open and this means that we can safely deref
>> + * ->attr.open outside RCU read-side critical section.
>> + *
>> + * This should ONLY be used by readers of ->attr.open and caller needs to make
>> + * sure that kernfs_open_file_mutex is held.
>> + */
>> +static struct kernfs_open_node *
>> +kernfs_check_open_node_protected(struct kernfs_node *kn)
>> +{
>> +	return rcu_dereference_check(kn->attr.open,
>> +				      lockdep_is_held(&kernfs_open_file_mutex));
>> +}
> 
> I don't understand why the above is necessary. Whether you're a reader or
> writer, you can deref the pointer w/ _protected as long as you're holding
> the lock, right?

As per [1], we should use rcu_dereference_check() for the reader side when we
are holding the lock.

> If I'm mistaken and somehow a reader needs to use a
> deref_check, I don't see a reason for this to be a separate accessor. Why
> not just merge the condition into the kernfs_deref_open_node()?
>

I have not merged lockdep_is_held(&kernfs_open_file_mutex) in
kernfs_deref_open_node() because not all users of kernfs_deref_open_node() (i.e.
kernfs_seq_show(), kernfs_file_read_iter(), kernfs_generic_poll()) can guarantee
that kernfs_open_file_mutex has been acquired. So at the moment we have 2
helpers around rcu_dereference_check, kernfs_check_open_node_protected() for
readers under kernfs_open_file_mutex and kernfs_deref_open_node for readers that
rely on existence of kernfs_open_file by making sure that ->list is not empty.

Could you please let me know if this sounds reasonable to you ?

[1]:
https://www.kernel.org/doc/html/v5.6/RCU/rcu_dereference.html#which-member-of-the-rcu-dereference-family-should-you-use


Thanks again for your review.
  -- Imran
