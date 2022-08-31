Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3C5A845C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiHaR1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiHaR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:26:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647052C12D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:26:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VGxP0G025704;
        Wed, 31 Aug 2022 17:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g9te/YXr6dcl6rZHfnDz8BuciTV8dLD18SWkKF8rfJw=;
 b=qimcz3XgRDUST3yqcK0lxW27VP/kr59sZdde9g04bttSjhn/5RWgAG0aghO2WnXVIZeO
 FiErmfHbMDvwPv4PUnueQ7gCrppfBtvqpG7yhHpj2c3ju3kiPSRpRy1bxBUwOfKDDw+v
 8XxXb33d1tMA6SvaqzvjHbytsBUfwXq9bUz/RlU2d9+B1kM08Dj/HcdmnvB5lh7hchww
 kuyLDi11GHTlqXuHZhixNneSgHtWFwg12+h5OK6uCnjU0RnkGB7n8euHoAXinkH2rUhY
 Qz+HMVGQUdvkI3e4YMSTMYSZyl5eyM8dcbh8f0leOrSAKhjpvHgY3oYhroN9NlPoEyGC rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7btt9v1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 17:24:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VH2lIi031295;
        Wed, 31 Aug 2022 17:24:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q5jxjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 17:24:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqb2xcyD7FMfVlwmRYIinwO45U5dKXoIW5I9fptCc9HlwjUQ96/Y9iex9wp3vmyQiCyskysKT9G4c4N/gHiY+vw4nRpoiUEOFfvokYhoZtnslpxqxRj29qBDy6iadmXi6HP3kQKMPgH2FnwQvBUMKhcR/yIjCJTSXv7ph32QAnghdDXee3YEA1pkfWdDuxNLI/3+q4gi/oOC/Fg4dQWyR9TQWB8PDuGEiLNzr6KN5OjwHQWzKtQ4aauwpqmut6P1af9cBFUbMt9Hej7Rf08MA04FphBdSF7uPjKDBg0ROZ42pHctNzuayOmtvF++AKL+RvdqOKwTKRInsrrWCfDBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9te/YXr6dcl6rZHfnDz8BuciTV8dLD18SWkKF8rfJw=;
 b=B7vcSbXaiYCrxQR9kq56Cos7y3fujLk5OqbC2iqVD163jJ0jDdsdZ35RVENHnfIVdyy7dgpcnH4k2Wgk19R3hpQNUHfL28fyHEVYYkwhjn8QJBH3PGZqMO1Ti/ogSvFC/hEI2r1rlXyGkYXgGRa26qnT1XA73V6bekMQmU/1vTXWKmIi8CKBFcCuj4l/LK8BZyOe3R4eIi4uSRQvAholBVeGba31MqLs6FFrjQzCHvMwj86waExLkO6ZfKhUM3Mgn8CarENGOsttmqeEbGu9JBnOE6ZyOWqoW0NTyMeOQLHlDPNVU/ssfSNDxu6CKHgsUBavnoJxrpHX84Y2FRUTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9te/YXr6dcl6rZHfnDz8BuciTV8dLD18SWkKF8rfJw=;
 b=k+Mdmp5YgIg25Lflje93W6IWpjTQSGX9JGvT2T2oQ+55Tj0fgQFU50QwyQtOkeltsaq9S6WQ0jJ2p9C78zOuPx5uLiALFfUKG9Vy0j6d7PXp3M+NmnKrx5RVRXPO8LDf0ODjH7gdyg/LdMx5kEMtaiTNkUNoYvqqhAafGjFt46E=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 17:24:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:24:38 +0000
Message-ID: <0bccf3c8-10b2-d4cc-0474-fde41145d568@oracle.com>
Date:   Wed, 31 Aug 2022 12:24:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v11 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-4-eric.devolder@oracle.com>
 <Yw7U5jYKcwZ+cMpu@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yw7U5jYKcwZ+cMpu@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0092.namprd02.prod.outlook.com
 (2603:10b6:208:51::33) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 172ef752-ea8c-4df1-ebe5-08da8b75ae65
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4576:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSoMMDTGVI0wv5XZXcTe+W7R8WYjP3WVxsqNECB/A6rjNgM3kwVBfFAKkzFU9nSfQeBC5PpkHGVLFw50YDnbWBlRFTNHdOdAf8qQ9qBFBkn4MG1PqCdOsfWf76j2zvwlMcwsuSiXw4MnpynKbRUN7JgjF/4VyY3YFrcxJHXgxt4XQdITig0U8ZB07DMHz+fLrhEluyrDxGReGX3qvL/0G+Ufk+xLvlI1+lRNXX4iqOKSV5h6FaL9q6urWp8+9ePYwp6qLhMJRnwbN5J9w7vhx0cniyRejBO3RY/eZ3S9FA5W6Jq/4IPzbHTHu4fK2zh5sAzYCGLUduOIMr3LoKHF89KnGkWixLWbCY6hwkIsBxAtHdCYLBPxz91hPPozPyuEddy/BB+xDtGkyjPjBtuT9H2ej2O2wD2KDSOOidNIHx3VDzYcGgy/9i1AdO7egcKNo4CZUxy1n9W3TbwGMxDxBIs8BOKPWuzc/T7v0puVfu5DYZNF3nmzSfnrftajpp8iHRO3i0fhlb7kuZIoJA+D9+nCXmgZFbSGm5hob5MIyBWjEk5FsG1/n15cRVdFra3Fdl1fg7RrjxoLfl2uZpiPv1lpg3biMiidOoVmMmyycqIrMfyEGYiQuRAvynCCHpR1aj0thGM6215G3v6XS8WKMW3CmmDoFP6BKFRXb0yEHGnRvAwE61s+KwmGsex+DMUUdEchnbPDerZCG5m6wFbNZfpZiV7rXGcaPyZHEMxB7JHmjRp0+Sy3dpP5klaTZ/uGtWUPD9ubh7JxtoIkMwYy5Ly2dE+9aNvYFsKOhpdAJENubGq8YbboIkx5ZnWmD6q1OG1cU+rI+sxW37ECwY7BgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(136003)(366004)(6506007)(38100700002)(2906002)(107886003)(2616005)(6666004)(6512007)(186003)(83380400001)(53546011)(4326008)(8676002)(31686004)(86362001)(31696002)(66946007)(6486002)(66556008)(66476007)(6916009)(41300700001)(8936002)(316002)(478600001)(7416002)(5660300002)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NklyamRHdU55YzNKajlxQ1d6NXF1SDVkSHpNU2xSN1IxM3BZSERLdHBTdEFv?=
 =?utf-8?B?UmdDTW0vamVzbjh5OWJDSWVvSmlISTI1eC9UcEpDMU9NSVIrN1Z2NDdPNDZO?=
 =?utf-8?B?elNUai9WY0hXNExNeWc3dmxZNkw0Qzdwc2dBRVpMY1E0ejNnZmUzTFFKLzZh?=
 =?utf-8?B?MlExWHlOTGhVcGpqMUhqS3RDQ2szdHpHOHVjcE5xQmZsZ2hNUWV1dzM3Qmtv?=
 =?utf-8?B?K3AweVBJVVYvNWxhWFFUOFJJUTlXZllOS2o2QXcxalM3RVJXSTRFQUVTOUlF?=
 =?utf-8?B?dWJPYnVweHZMd2dlRXJnaGs0Z3dwQmh3bWRIb1JIbElWVjlBa1NnK2FMRlow?=
 =?utf-8?B?a3hWbkdwdkdNVU9OeWlNRUdBTWJaQnhNUGxZRFNTNExCMlpEMnZVQmxxck5O?=
 =?utf-8?B?dFVrT1FMRGZ1OFdPSjVWRWl0TUFHcVI5cHlFbFp4aGIwdkRHSDh3OUVPQVRG?=
 =?utf-8?B?NEV2U0RibGI5T0gwZHpBaWhGeHppUGhKQzNJaXI3UGRQaEY4YjRXVDJKOGt5?=
 =?utf-8?B?bjhaQXpFM2Rmb3lMWitYMXJYV3FVWGEyelJ6NThiWm1HeU5SRFpmV0dsM1py?=
 =?utf-8?B?NVE2VTAwaS84NWtkbWVPVjV5ZXdLSkw3WjJMeGlBU2s4UmlxZE5DVmxzeGRD?=
 =?utf-8?B?Nk51bG91K0JSeUF5ZXlSZkxKYmNUYkxZaG1NWXlzK3NyV2U2bWdxaGpndEdo?=
 =?utf-8?B?YmVDUE9XNERVbHBDYUFveTRKUWk2dDJlblJIcndVUlNHU2EzeUJGbzNmd3hP?=
 =?utf-8?B?K3VwWnJQOWhtR21aZkVCU3I5MFh4THRwUXVVaERQMWlXRSs5ZUVRMjdrS0p0?=
 =?utf-8?B?SU1PK2h1dTA2SWNtUVdWMm80OFgreGdHMmx6VzRHc0M3c0ZJWUczdmNuNC9i?=
 =?utf-8?B?YXdFM29uNTV6STRvN1VFd0pGQU12YWx6d0o3NjdJNnRNNlJLelpGclNtZ3VP?=
 =?utf-8?B?a0xZSzE2MXRBU1Q2SEFYVXM5UURlYXQzR2Rob29pVzh5S3kwaDc5V2xnTW9p?=
 =?utf-8?B?WnU2ckVoK2NVQWVtQmlMSnVIdVU5WGlrc2ZrbmpPWGxkbFJMRURnU2xLc0tq?=
 =?utf-8?B?NENTWi92M2psdlllTUF3VWQvYXpMWVI0WVp6dDlLNDVSbGl2V24zQmdNaUNr?=
 =?utf-8?B?SkRpQlplR0VWemVMNEYxMlpXMXpqb0dONGZEYjZVbW83eUJGSVNLS2IzbDJ4?=
 =?utf-8?B?YzJIdUZja3lmeGE4UmdaaU1wbE9JMDMrdkNNQk9xNkkveWFZTHZWRFVqK1E4?=
 =?utf-8?B?OWhENTBvTW0rNnAvQk1LZVVNVFpiRkdQSUR5ODlvODJGck8yTENEVzN2NWEr?=
 =?utf-8?B?WFFYZjFOREpNZ3krN2pnVS9vdzNxMlpMRnlHMWM4VkxiVXdZZDJRMlhUTnhG?=
 =?utf-8?B?eXBhMDhXb0Q4MnFTYjRkSzZKNXNHajAwYkQ0aHNQR0NEckIySGI1NTAzR05T?=
 =?utf-8?B?WWZsTExlaC9BbFdLcHl1STQyd3NMdmNOZkl4Z0Jxb1U0c2QzTGJGcWVMNDFD?=
 =?utf-8?B?YThWaUtEVU5KYTdkS29oVkJha0ZXSXJ0TGhRU21pWDRxSDkxeEJzZUxEeFdt?=
 =?utf-8?B?NmU2aXdRb2UvOXc0d2JzZlVlSm94U2FYQWl4MVVGVUlPdlB3czNqdlJ1NHBq?=
 =?utf-8?B?MTZNcVA1aGl6ZE9vQ1R2cjZOdmdIeERNRmxrTzVuRzVnUzhxMnU4Z0tRbHBZ?=
 =?utf-8?B?NnROWXBuelNMVG4vRnZsdlhyVGtZZzV2bklQSGJGTE40alRWcE96Y0NvZjVw?=
 =?utf-8?B?SS9kOE05TmlSdGZnYmlYVVMxNW9CZUhBSVRuRjdNK3RlQUNOOElQR1FGVDdL?=
 =?utf-8?B?R2d3KzJRZUhYbmU5MTZVTnhleVpJT094eFRDWHk0WnBjamVva2d3NTVBZEZs?=
 =?utf-8?B?US9MUnA2REZJdXk1UjdKem40cjU5Zk9CR2NaTG1zQW5PclVpbVJsYis4SVRQ?=
 =?utf-8?B?WmNTMWNZKzRmeEVMQkNpeGI2SWdXbjUyU3ljNURkQjVUaEV0ZkVBYU9WZFc1?=
 =?utf-8?B?Rkl1U0NXc0k3Y0NWZE4vSXMyUmhaaUREbWxzL3BXU0ZCelR5b1M5cDRRNjlx?=
 =?utf-8?B?NlIyRENTRWI0dk16MjM3MjB6UTExT1dFRHlMWGNMeW1vNjlUaVJYMGttUno5?=
 =?utf-8?B?dVUrUnF2ZjJMaGZKMENWUUNKbmNhMmxUQTZYREg4M3Y3NSt0bmJ3dWVwMnQ5?=
 =?utf-8?Q?bbJNv/DWu7ibNPgu3Ivjj58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172ef752-ea8c-4df1-ebe5-08da8b75ae65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 17:24:38.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPoLqAAcCBJk/uhq2rVBAkc/gHVyXk9QKqG/K7W3Vi8lB+yXPcm7fMDXZIKmgItbwgbTHknZyeRsON8DgIkDmHNiaQNjN/lT5Sauyqq0Wy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_10,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310083
X-Proofpoint-ORIG-GUID: eKrNy8p2PUEWqxMBDAW-EzkRYLoKUWNV
X-Proofpoint-GUID: eKrNy8p2PUEWqxMBDAW-EzkRYLoKUWNV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/22 22:26, Baoquan He wrote:
> On 08/26/22 at 01:37pm, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/crash_core.h |   8 +++
>>   include/linux/kexec.h      |  26 +++++++
>>   kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..3b99e69b011f 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>   		unsigned long long *crash_size, unsigned long long *crash_base);
>>   
>> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
>> +#define KEXEC_CRASH_HP_ADD_CPU			1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
>                                          ~~
>                                          Nitpick, These arenot aligned,

done!

>> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
>> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4eefa631e0ae..9597b41136ec 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -374,6 +374,13 @@ struct kimage {
>>   	struct purgatory_info purgatory_info;
>>   #endif
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>>   	void *ima_buffer;
>> @@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>>   
>> +#ifndef arch_map_crash_pages
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +		unsigned long size)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void **ptr) { }
>> +#endif
>> +
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action)
>> +{
>> +}
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 0f8aa659cca4..455150205ded 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -18,6 +20,7 @@
>>   #include <crypto/sha1.h>
>>   
>>   #include "kallsyms_internal.h"
>> +#include "kexec_internal.h"
>>   
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>> @@ -611,3 +614,134 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +/*
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. The elfcorehdr memory is
>> + * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	mutex_lock(&kexec_mutex);
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		struct kimage *image = kexec_crash_image;
>> +
>> +		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +			pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
>> +		else
>> +			pr_debug("crash hp: hp_action %u", hp_action);
>                                                         ^~ "\n" missed
done!

>> +		/*
>> +		 * When the struct kimage is alloced, it is wiped to zero, so
>                                               ~~~~ alloced is confusing, s/alloced/allocated/
>                                              We can accept alloc being used, alloced is a little weird.

done!

>> +		 * the elfcorehdr_index_valid defaults to false. Find the
>> +		 * segment containing the elfcorehdr, if not already found.
>> +		 * This works for both the kexec_load and kexec_file_load paths.
>> +		 */
>> +		if (!image->elfcorehdr_index_valid) {
>> +			unsigned char *ptr;
>> +			unsigned long mem, memsz;
>> +			unsigned int n;
>> +
>> +			for (n = 0; n < image->nr_segments; n++) {
>> +				mem = image->segment[n].mem;
>> +				memsz = image->segment[n].memsz;
>> +				ptr = arch_map_crash_pages(mem, memsz);
> OK, I see. You want to avoid the over 80 chars line, so introducing
> two local variables. We may be able to tolerate that in this case. No
> strong opinion, let's see if other people have concern about it.
> 
> Other than these nitpicks, this patch looks good to me.
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you!
eric

> 
>> +				if (ptr) {
>> +					/* The segment containing elfcorehdr */
>> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +						image->elfcorehdr_index = (int)n;
>> +						image->elfcorehdr_index_valid = true;
>> +					}
>> +				}
>> +				arch_unmap_crash_pages((void **)&ptr);
>> +			}
>> +		}
>> +
>> +		if (!image->elfcorehdr_index_valid) {
>> +			pr_err("crash hp: unable to locate elfcorehdr segment");
>> +			goto out;
>> +		}
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(image, hp_action);
>> +
>> +		/* No longer handling a hotplug event */
>> +		image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +out:
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +						   "crash/cpuhp",
>> +						   crash_cpuhp_online,
>> +						   crash_cpuhp_offline);
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> -- 
>> 2.31.1
>>
> 
