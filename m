Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B93501F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347780AbiDNXxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiDNXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:53:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215A63B2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:51:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKkvS2006846;
        Thu, 14 Apr 2022 23:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0huJwo5FLaBPy1SOMOrI46rgPLljaJdVmNSXjVU0RAg=;
 b=ftWUUxqr1/fJgrrJrkoAxhJBwCBSUS4+gUi6B++/9KD2c/xFQ+4gZOFzGB70sRIS+yij
 eS45+Lsd9QzzdIn0ZE9djaQALAvLnATSI1B/c6fOOT2FrY5sXu9KxLv68kWR51q4NvBM
 xTfrWSrWX+9gJqNswELHNrq+V7LysQfz3Wk6cWdPB2s43Rp/RfIUUNQygY81WFVyhxsB
 uRRS3H2nTj0Gp5fE+17Od/zS1ZBW01xhcFPUEfVuwQoulwWsZn4KCsTtioXfdUakCxdh
 NWUmNrtuhdAnNOLm5E2x9Ap8NM65P+y+6n2e1X5Lno8PPgzT53xICu8nKOTSh38ARTlW cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rse9xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 23:50:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23ENjoDx038471;
        Thu, 14 Apr 2022 23:50:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k5gpp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 23:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je5N7RQzE16UnCyIcY1a1y3BrnYGdGcg1gOFDDElEh4vvFQ9dt6GQNvxCLhhxnTXmE9Xey91ZIfEeD4RDIHvMc95o7O2KSTBypTtX4wU6XiQt/N5x8vnHepwppHWzwSfAa9hcpdovzbm9odXq/cvng3u2buYFdbAyVnqxAiPQ7f7jwjzSC2qTkRevemt42loKP8BOxhpAyanzPx3liWU5a6QlpRlYDSub49txhLS9djBrUAzTJYb6YZ9xcUBHz/RXeSX+yPPa3uzjOn+hJUX4I8OcP7RkRqktBd8xugIHuqs+HwkVyMIChbyILZVAgMIsNmAJUsMzlkL+SHyv1eT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0huJwo5FLaBPy1SOMOrI46rgPLljaJdVmNSXjVU0RAg=;
 b=QOIM23FLPGPvwNylcWoKJKblnEOeXPIjlByVTSzgykKoHco6dzH11Negpi6Bd1rkQGnESh03Ka4SXAgMGWLj9QDSkDhi4IRaLNkAfGfZGv57GtkPeq+ylMlYkltubsfs3yionxaBNpyA5Yqli4wFVNbUsr+f91wC8ZaQ8b0syM2Kc30LcGsNsFqIvTV+OV6w+kaUNVVzotbNRQUHqpHRjA2pSXaJMm02HIAVtXjJcEHyXq+HJ35Jl+skSyRqkzbosAjHSSLiMNRxMN6Y2Pd0l9srgzd8/2hsmB7g/qad+rL+oCHE2AQK7tOGVgXM82HkN/J2bGqllHwP4P3No18UUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0huJwo5FLaBPy1SOMOrI46rgPLljaJdVmNSXjVU0RAg=;
 b=l+qErflHyrGxK89IdQ/ksdKhCEigObiuuneAf6/zhg1UgkaiSxdAFntj4s5uZy8osTdYhR9TmQrDh9hW7yDz3kyCJIT4056+7IHcuXhIZY2L6IiMAqqhyeVz5K7JSwpq4CwKYmO7e/Igij7vkYDYV4J7HtyLXZpBL4wUFGKyx5U=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by BN7PR10MB2417.namprd10.prod.outlook.com (2603:10b6:406:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:50:45 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 23:50:45 +0000
Message-ID: <a5f3bd4c-7335-dc3c-1606-44eba9576fee@oracle.com>
Date:   Thu, 14 Apr 2022 16:50:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] hugetlb: Fix hugepages_setup when deal with
 pernode
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-3-liupeng256@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220413032915.251254-3-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:303:b6::27) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c659771-0fbe-4c8e-e838-08da1e71977d
X-MS-TrafficTypeDiagnostic: BN7PR10MB2417:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB241722F165E30004F5EB4E09E2EF9@BN7PR10MB2417.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inebza6hst3g/gthlIlzq7g4VR8iwMDC4l+jTYr0BzcCZaQrE9nPrbwbdW5MZfxwKI1QjEEGxozHzIRWeKrLC1FQtNLammWp22E2FX6MWehul6XIo9sUdyalMYafgjmDdRnsiT7oKHzsJuGtrazCNGIHsndfjhBClwjxE3Cte9mdZm8Iy1K20OHsfLAJJZQrAMSEvr0o8Cl1ggsmJKmMs6ZukBWeyUiFu4Y2UbHcsW10mYkvvNGw3We5+fi9rAoQOddWWwhzkMramKQp5CcqVb68T9FsaJPphk/muGbCa/lnBwje/AHH7qXN2VgjDTcNI2nOg6ejAUXxWPmstaJNFwBJIwdFnRfxbyI6SGOIqhP+7OWx7nw0ZHbiGbSwtZoSrLdQNRJ6bbQW1IYO+Ls/XK7UiZ1ZjvWeH2rKfDB4seh5tLJCwIvXzDIU8x07/nkwI2QjD5CV4S4A+V7UVkpdvS8X5yJbEmcfBZt/hrY3jQwaEtvj48MagtTwj5iOFgWLF6NwtuRo/AzfH/JNfso3+mQAHgFRVroGENsdQ3T/Q3uFVi+GhFYR8Tx4AAhuCpM7ptxq8VYnHwykgF623ioBqMx7wNuV8qSBOPwMk6jXAOYbTfLmjAlhBDAtluEwjfdfP+ZKMnuldwdYw9oJgwZ+R1KNr0hKez+JSmFY8GrH2pZ07CUqaLKyteoSF7l8/do+Ps2JxtOdWCnrXgWMe0LWTwEs95s80o5EcOYospbw7kbgsJuCfxZttGBIKIBafOjFZeeaYLbDidGKNppn1g2dyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(186003)(2616005)(31696002)(5660300002)(8936002)(316002)(36756003)(86362001)(2906002)(52116002)(53546011)(31686004)(6666004)(38100700002)(6512007)(38350700002)(26005)(6506007)(508600001)(66476007)(66946007)(8676002)(6486002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRTVDJocDVZSVpkR3g0aHA0RnBWbUcrOHNSYit3cHlmb1F4RW5QcWlYZ0t3?=
 =?utf-8?B?bHRVU0w0VjVPMWhQdUtEak9iUzZkeHNyd0dqSHU3QkpjZHloOEthTWg4YzBK?=
 =?utf-8?B?N3F2ZnZxY0oyeExJcGU1bTZWUnZZQ2ZKOSswSHZZU0MyWXlNeWtnOHJMWCt4?=
 =?utf-8?B?MWtKT1hwUjlLS1QrZnFnYjByOVhCV2g4QXpmTEVCNk1EQnUxQWQwTmhMYUNl?=
 =?utf-8?B?eDFDT0lHckZqcVpWbnpmaUszTVhuVER3Z1lmSmRlVWNSRDVVVC94RFhIMXVH?=
 =?utf-8?B?RUVuNzJpMmYwdzNydGRYUmsyMk5ucXBRNTF4bmkvaCtBeDd2aWQ2Q0czZkRG?=
 =?utf-8?B?cjdCL1pYR1BNc1lKUEl5YWJwQTJxdFBNcko3SjNwVmxZTnVGRWlLdVR3bXpU?=
 =?utf-8?B?S0JGanNlZ1ZhcUk2Zkw5WDVBYlFPWUNVeXdrZUVEUEU5elZ3eXc3QjJlUFhM?=
 =?utf-8?B?SC9HMTZrSGQ1VE1hSUtTTTZmT0VEKzdHUk9wZGtGeUdEeGFaNFRmbHZBT09p?=
 =?utf-8?B?MFRnV2ptbmp6VGVaTTBVRXUwc0dubzdmSDNvWHdZdEtwcS90bGVPTERTQWpn?=
 =?utf-8?B?emZRc3BpQ2FYeXhEYTJWdUZxM2xzMGNvT1RjUGlLVURXL0lodGFhQnNKTm5Z?=
 =?utf-8?B?ZHBleWVOZlZ0OEp2VWEyMGpqZERJT21vWFNnWnp4VnI0UzBBVzludEc1YzBx?=
 =?utf-8?B?cGFMVDM1dmJuaFErRStBS2RBU09zZWdsWDVPdUxlRlRncjdjWVVwaElLNlJT?=
 =?utf-8?B?VnVvYlcvbXlmMU1TYlhyRVNzOFpXM1BHa1MyNmtjbTBGNkFRUU5wUDk3U3Vs?=
 =?utf-8?B?MFJ3QWVyY3ZkUG11SDhNMGRWUkZxeFBJNTNHdW9rV0JkdDlJcjdNYTVLUUxN?=
 =?utf-8?B?MUhSWDVyNTNUTnV1S24vMm50eFFscHYrd2h0djUvMkpGdjMzOXAyVU1kSEtx?=
 =?utf-8?B?WGZEV2hPT0k0cjgyREdZM00xSWUwemZKZGx0SElmS1R3YXd1aUtLNGl0SWRh?=
 =?utf-8?B?UXVzdGpPSTgxUFhDbE9VYVpGUFlkdC8wVTZpem1nY3NycGtrSkdsZzh3NHNL?=
 =?utf-8?B?RkhmcWlMZzRDa1VPNnVpTlM3MlhVMGcxVkNMdkNob0diQ0JCWVNtY2hQSVNC?=
 =?utf-8?B?NnhpdHBvbHJTYWtMdlVZclVuWlk1d1lnTC9vajhNRXVLbTY4RzRlbTlpbjE1?=
 =?utf-8?B?RnFJNWZKMlhpd0YxUEptL3RMYjdoT3VJSG9GQW9sbnpDL1BYVktsay9SemNO?=
 =?utf-8?B?Qk8vajU0NHhGSkRneUUzaWdMTk9ya0Q0eTRzY0dRRS9DREZjcWRvb2VtSk9Q?=
 =?utf-8?B?K3Q4bEprajEwbHp0WnRyUFc4a2F1V2ViemRxdkRpVFI3RFNqZ1pDTzZGcUVB?=
 =?utf-8?B?Y0oyemtOaldFQ0NtODhiNGpwWjNKWjQ1SHRWNTZHQS9XOERkTlNMSUQzQVNn?=
 =?utf-8?B?OVRpWU1WT3BiazQ1L2JQL2VPK09ISEV0UlpWZDFLYXZ3L3p6REx6Q3I3ZzRh?=
 =?utf-8?B?b0UvV3NrMk1WNzB0WFhwNlJqaGFINDNweGYwUldURmFZSVpLSWZHOTcwY2cw?=
 =?utf-8?B?bGNUOWdnSW1TSTBKSDd4UUMwaVRvMGxDekE3VWh5Y2JmaVVRbWFHeUtRSlQ3?=
 =?utf-8?B?WmE0a2d2azVkTXN1Ym5Ob3hjblBBclVrWUZiOVptNW1Rd2E0cWlDN2ttK1hR?=
 =?utf-8?B?TXNJeTFjUW1jUjVxZ1hwbEhGdHBVMlEwWklpWFAyMkFhN1NzL1lMQ1M3S3Rr?=
 =?utf-8?B?Wm1ibHRmWDJZNnB3bzk2enBqWHZsUkRYSFB5T3Bkb2syQTR6YXBOQWJ2djRm?=
 =?utf-8?B?aEg0Y1VYOUhJbVJMQmhZb3JlSHVHSDM1K1ZyQzFyMGZWazJqbURxTjBzVlRZ?=
 =?utf-8?B?RGRpK2tMQ3Y3OWh4UGJkWEJ2ODY0L0krMklvVzg2aTQ0ZHQrNm5zMVNnRnVn?=
 =?utf-8?B?RHRYNU41RVdFTkpBRThsOG5TNkVaRmRXU2k3eE5LYitNRUVNbDVMK0wwYTVX?=
 =?utf-8?B?cW4wdkNRMjlIMUhqQmI4NXJSbVFRalNrVzdjNGlyaEN5Skx6QUd1cmRmNnI2?=
 =?utf-8?B?YmpTOUZwZkcxRzJzTUhidmFXeWxTMHZDbEdjbS9JWjRXK085bU1jN0R3dHEz?=
 =?utf-8?B?YTVLbkVxTUM3Zjl4cjBPKzBEK0kzYk5MNkR2cktEVjRkLzUzeVdtekozL2k1?=
 =?utf-8?B?KzZROFk2UzFrZHh4SDZIWGRLYWdEQ0NzMEhld2FZTHVMYWdvV0F4TE1RVHM5?=
 =?utf-8?B?U0Rzb1ZVblRndkJBVVZ1cDZoQm9nT3lad3dWY3VINDZUQWRSeEczMkFqbU1S?=
 =?utf-8?B?SGdSVU01TnpiZVQvVzg4c3NHQVJBSnlKVUVXNDdkU2FoSnV4NmQ0amFLRU5X?=
 =?utf-8?Q?XANO1AkTArcXw5DE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c659771-0fbe-4c8e-e838-08da1e71977d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:50:45.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Wkp1/WHLuwmZZBLxXtRaPMX4TBdNfSIwKunVrFZ/6P93nkPLViAIlyYAmpJRcL7bLQf2pxLaxmBOvj/5moS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2417
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140124
X-Proofpoint-ORIG-GUID: JJjhZpiNXky55f2QmBByRdSv4-hB1jDr
X-Proofpoint-GUID: JJjhZpiNXky55f2QmBByRdSv4-hB1jDr
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 20:29, Peng Liu wrote:
> Hugepages can be specified to pernode since "hugetlbfs: extend
> the definition of hugepages parameter to support node allocation",
> but the following problem is observed.
> 
> Confusing behavior is observed when both 1G and 2M hugepage is set
> after "numa=off".
>  cmdline hugepage settings:
>   hugepagesz=1G hugepages=0:3,1:3
>   hugepagesz=2M hugepages=0:1024,1:1024
>  results:
>   HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
>   HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages
> 
> Furthermore, confusing behavior can be also observed when an
> invalid node behind a valid node. To fix this, never allocate any
> typical hugepage when an invalid parameter is received.
> 
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
