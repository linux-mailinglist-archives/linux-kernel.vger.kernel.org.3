Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E85636D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiGAPSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiGAPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:18:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE6DF9F;
        Fri,  1 Jul 2022 08:18:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261DIxTM012824;
        Fri, 1 Jul 2022 15:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TI+nVQ4oziNS2jx8Bm93FC1lkVTJjK6MvmAUwE+1siE=;
 b=v4kYuDByodTO8R3vwrXoTRmAwOgJQvogVJKGDXaGpm7aEE84K8QlPJq/6fqjru+Fjmwv
 RwY5M89PZVdICkTp2IeOOav/pf9um12zAhGblN0g9NyOaDZuuN7/z1mOaYJiOYrLskHb
 ANIZgx+C165StCLm65aUMmUPS25lOPGfS3M1pSAxLsORZkjME4fwQxMmcyDorFqVysPd
 ps9OHwt1ZrqqQrZWh4vaLiTl4/FwVjGXR7IOy0sI7KQ6NT/Czu7HASj9ehhtxgd8bVgp
 JmH5nSL6TOD0YR5vpPrdI1FeRVMT4j2R0Ljuo/HCUztM8Z1ALxHGSYWrHMn5j2rRugI7 pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwufkhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:18:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 261FGnhI023654;
        Fri, 1 Jul 2022 15:18:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt51kga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Jul 2022 15:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmhthhPFnkwUSPhl8YBNdqyddQfcC3j4meR8kerWmgd1rdWe6ev4oUhBmTp/Vs0MH6PuyrJbqT/hQKpKh2/dGLrlmIueTLLox/HOyFsLeghZA6ae3wdnUMIRkP7r7Lfv583pTQXvvQ7cyNvRyp/9Ekjc1hmXz21OWe0PTgj0u5R9srIIal8F37XggllNXhEHn7CB8uKauZp4SnXp/iohEZLf2JBcu9Q2LohrWjl5ORJxiq5Vmal1RNNkDPYfN1JxPU54kQrjqxDAnpviJfA6sDmFtJLONvp7Xwy/hShLHIk3YrCOrTNnaSOSCbMCzoxD+O3ql+GHE9RnM3WEhv8GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI+nVQ4oziNS2jx8Bm93FC1lkVTJjK6MvmAUwE+1siE=;
 b=B4mKUxNBO1YZGaC7iJwbkUJjG/U0/KXv3vGhagtmReQz3RbzGDm9jcBO6G58Pf5ajOqD7sqKrr6QKF/UeaE3jIEwgELLLt1xeBssfLbNJLiirnOkM6VqOOiH3yG/xLUoa6UI/eXc1JihzZH62/Bsi4GGBHkXi+aLZv7HTjANptCmbxbPZil68cpEoBVY6dO9H1NNNzcJtoaU0yzMoU10f3MdWE3W3/2elwnzqBgpEn3IfvoWN8S9hGA8lakUxMDny14nlEGYshiKdwezwamHghtBgc0b2PmM+v9atniyRFPiZjVzddJz3AUql3b1dZDkZ9L64Icbuei5OX69yFUNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI+nVQ4oziNS2jx8Bm93FC1lkVTJjK6MvmAUwE+1siE=;
 b=ro4Ymtp/3Md0VY7qhrkj2o69/qlda6Emuj/4/7HnD2hGt/BdtdkYKNlDvgfGq+ekOlLg2SZ1xH7q4C/Ta8odEA0OCJMM+LxNJeg9dfYuyd7WGq737JAI+E3Q5tcAYI+/fbq/iTHqGFHbEv7yEpwDwTlgI8RmqEoWAxGHsPL46Oc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3902.namprd10.prod.outlook.com (2603:10b6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 15:18:18 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::3037:a916:f4b6:52cc%6]) with mapi id 15.20.5395.017; Fri, 1 Jul 2022
 15:18:17 +0000
Message-ID: <2c4bdc7a-b49f-c2ea-28d0-4ec838c3b26c@oracle.com>
Date:   Sat, 2 Jul 2022 01:18:09 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, michael@walle.cc, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        guillaume.tucker@collabora.com, pmladek@suse.com
References: <20220701145047.2206900-1-imran.f.khan@oracle.com>
 <Yr8OSxotW2VEUyKQ@dev-arch.thelio-3990X>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yr8OSxotW2VEUyKQ@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0018.ausprd01.prod.outlook.com (2603:10c6:10::30)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 550afa9b-dd69-486b-c3a4-08da5b74eceb
X-MS-TrafficTypeDiagnostic: MN2PR10MB3902:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mn++WYRdP7ktYcGoN4WPX4qZQqmSe58JaUewVpguwr2z3PC9+h0OOxdoTHs5EJUB+Zsy+LD0uMEqgy9/0CMd/Di8xHHuHkBBdhiPdqdx/8Yx652zdIjT7P0GD4BEA+JNE2Zxeu6MyJHke0NDwn4OIlOH89Cy7u9dm8mKpNqBgvCcy4BFvzPYp0wtp6vzcLC4WrJ/nQelgNOktjd5lFJzuM7yMpxSER4ykfBEIpsJUlnrbqJ7Ve5apAjQ+SKRJ4eY+u/fSfNmS05ebCuWjrnMfvb/UV7l7jtz3IVQcC1YKbhAt2MlLknOk118exfB10amycB/BM1MU3QZkhz0Q1b29QK1sgfg7yH5SOW5MH1J/LGe9EQlHbBxjWnUNu0hFrk5V/ODdnRZ6dJKpty6f1SBkFO0jYLU6KcB+BMBtirNhQOBTkXueQDfNeg+vfGMygCRZmEINMFS1QO5n1Yu3Y1dTFl+JcG6pFNYapzhWcTAmyjGa+3vPg3oS1ivGdgesDu1Yuw9nP7Yqt3+vcuz/UCb6eHIdpCs+0DFZ8XLaBzJ39zuB4LKrxEY4ISJ8XUqDy8rkBfYSS6vEuZn5L4G7XLrdZVEywGQrqcGUtY3VYg/r/I7xT/4r5ONGXGjvChmJs5y8PwMpfF23mM/dxiX+yGxKmvlUkFCHDPy6mdSeyR2tw0QoRqZxd9bsk0L4iW4Fde0PFceY27zGjOpDkDjUSAVtrWcmKeeZYN9bU7MKM5wI4v/vcc4hV/mFXxc2TfTq6HRcekifVxXPvA7CfvtYu/Y9K0BpOaKtjoUv5hsEtN6opgCGJvzcdKGBJvhcEcjn+Jb3c0obzFIB+BCSTF2ivHT7jxKbnMIsRVjo2taBTz6Dqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(31696002)(53546011)(86362001)(26005)(6512007)(41300700001)(6666004)(66556008)(316002)(66476007)(6506007)(31686004)(66946007)(2906002)(36756003)(38100700002)(6916009)(8936002)(8676002)(5660300002)(7416002)(186003)(83380400001)(6486002)(2616005)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3loNzl4TlZtZ3cwdHRYQlk2OXZpWXpBVEFsRklrbTNkUGtlTkhra0JtTnYz?=
 =?utf-8?B?UXFoSmlicHg2OWZmSndSOW5OU1JQSzY1SThtUHYxYkRLNU05VEIvYXErdlVN?=
 =?utf-8?B?aFk0K2hLNUFXZ0dhenpZbkFLME1qNjhTcGhBdVMvR0Q5ZmZQSytWNVp2eGVi?=
 =?utf-8?B?Q29iblJMdGt2Ukk2dXR0RHRSUkYwS09XSUJDM0xWYXJ3aGNBb0Ribk0xamQz?=
 =?utf-8?B?THlGTlh2dWpiMlRWM2FOU0J6aUQ2SmhZbW1xaGJZR3pvZ2Y0ck54c0F1dUIv?=
 =?utf-8?B?T20zRXZLOHBHdXk3ZXFVazlYc1I3dGNMN0R2K3AxZEhhK1FIVS91bVFiNElW?=
 =?utf-8?B?dHJ3VWVGV0ovT2hnR0xWdHZUOVRWSzBMYlBrczAwU2J5VlQrdWEvRVJ3MFhp?=
 =?utf-8?B?YW5Wdndzazh3UkUwTDhLdnRINHF6MWtTOU1aNk84RHZrYVQrNTlrU1cyTzh6?=
 =?utf-8?B?aHV2Si92NHU2WUlkME1yRnpUOHU4TE4zSC84NlgxZHNncFQ4cm9MeGNma2FI?=
 =?utf-8?B?b0E2Q0JjTnorRndsU0NIWkdTMmdkVmRSY3dGT1AzbXlQOUxES3htVzM0clp2?=
 =?utf-8?B?QjJvN0ZYZlR2T3J6ekYrNmxZZjFoR2d5VzFpSTZIZlZia0lHQnRJM3RWcmxa?=
 =?utf-8?B?czQ5NkdUSmpiSU1WYlAwYjdFcFVkSC9nRUFXL3FxTFFvWFk4WGdjUWd1MHFG?=
 =?utf-8?B?N3I5YTN2WmZVTlJDaWE5NlVUZE1vOUw0ajVicmlkRXFXNzZZamcyZWtqalVp?=
 =?utf-8?B?SFdyd1dkUm0rRlFMWGFkSlM4djZsaEZqY2UyZ1BuT2tqMFQ2RGlDcVZWTEFC?=
 =?utf-8?B?RUQvZ2FRSkpEOWxVaFZYL29vUVpoOWtTL2VTeENSZkxaR2dINFc5L1ZPVjZk?=
 =?utf-8?B?ME90WGxJTkhDeXQzRlIwSjFiMVhwK2N4ajdJcTc0LzlkbGkzL2twUE03Wk42?=
 =?utf-8?B?Q0o3VkVzUU16bXpPemVEcnp5dEp0UzdiQUxvTmU1c3NsT2VMYXFyblV6eUdL?=
 =?utf-8?B?WkVLMXBKSkI2SWFBdms0aFhGWnRHYWpjZ2NmTXBnVFg5M3MrRnFUcUlkNjBn?=
 =?utf-8?B?SHlsV3N3WEU1ZXdmT1lXenVjTWpzZ3o3c1Frb3c2MC9KOVlnb2VNaFR1TjAy?=
 =?utf-8?B?UXRiN0FZamd3YTN2My9WNCtkVWk1UnlzWTIvVkNTSmNtL01qNjN2enB5aTlJ?=
 =?utf-8?B?RVBRci9keEh5MnZPd3ZiT2FVN1MzbXlEVGdwKzV3bVZHNmVSNjVsTWdqSkth?=
 =?utf-8?B?MnZEOEY2YVdYRHJ0eGEvSXZUaVFKaWdMdTN2cUdBMlZrWWI5aHRNSDJ5MHdX?=
 =?utf-8?B?SG43U3lJeGJ0N1JRTXQxaDJSYlUzdFY3Umg3ZG84ZVl2UEFNbVAxL0VORDlI?=
 =?utf-8?B?enREOWF4UXN1TzNFaTR2U0pFbXRIdk02d1FCRjNDTFJpY2ZJRThqdkEyT01P?=
 =?utf-8?B?VmJXejBDbDhTRTdZNG81ZkM2ekVLSHc5a2x1Mnp6cE1mOFM3L04zUHpzMStL?=
 =?utf-8?B?VTVEV2kxYXNEQjEvUk9EU0NYeXF0YmFRa0NoRkxDYXY3NmR3c2tyaWFHM2s5?=
 =?utf-8?B?MDFWeHRWa1cyUjhYK1ppU2ZDbHowK1ljaFFYNWtOeHBFWDFtaEx5SW9Uak5m?=
 =?utf-8?B?WkdQM2VMQmIrRDJXNGZGWlJSb1lJQ0JjZFp5elV6VlQwNUtZSjYwQWZUWnh1?=
 =?utf-8?B?bk82RkhScXhua2FmL1ZzWWRvdWxydlVRMjJZRmdiUTdsS3JyVDJyZm9IalJW?=
 =?utf-8?B?a3VlUFFMNldsckxGWEZHa2JmOFJaUlhRS2FQRFE2Qk94ZzgvM0VwQ3V3OWRI?=
 =?utf-8?B?WkNIRGRZZzNtMGZmK201eS9OY08vWW1UZTlJRE9NTmtCcHU5NUV1N2I4VHBW?=
 =?utf-8?B?L0E0dEkzQzRKSGkxTVQzd2hZd1QwUWNGR3lWMlJjNTBjN1Y3MjQ0S3JLUndS?=
 =?utf-8?B?ZVRkWVU0WGtRRnVaU3dQOWl6K2lmZ2g3RWUzMkhDeFFuSlB2Rnc2R25HQWE5?=
 =?utf-8?B?N1JQcVVTOEcvMlRINk5TcU1xMUR4VHBxNHpZaHlQNjNLVkFLTjl4MU9aUFdG?=
 =?utf-8?B?NVNUN3B2c1g3UWZaSlg4YnNsWE00aXNvUTR4MlRkcklZWk1iZE1LTFpoRjNP?=
 =?utf-8?B?MmpkNkRrdiszUCtmd3dpSlpsVnc5MVBHcXFmRmVpTEFVNFBNZEtqN283aS9K?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550afa9b-dd69-486b-c3a4-08da5b74eceb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 15:18:17.8835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECsAoGKUWDnmhYE/kvx8GkNjPIcuXvnZ3A3kC6EG+zPNO/hAUr9kj3kn8sP6s6mtnaWmpp11N+R7u8sMtCPzfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3902
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_07:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010060
X-Proofpoint-ORIG-GUID: 6v58kKrn7KD5QFzdtNPwR0xK576XYUsC
X-Proofpoint-GUID: 6v58kKrn7KD5QFzdtNPwR0xK576XYUsC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On 2/7/22 1:10 am, Nathan Chancellor wrote:
> On Sat, Jul 02, 2022 at 12:50:47AM +1000, Imran Khan wrote:
>> Kick fsnotify only if an event is not already scheduled for target
>> kernfs node. commit b8f35fa1188b ("kernfs: Change kernfs_notify_list to
>> llist.") changed kernfs_notify_list to a llist.
>> Prior to this list was a singly linked list, protected by
>> kernfs_notify_lock. Whenever a kernfs_node was added to the list
>> its ->attr.notify_next was set to head of the list and upon removal
>> ->attr.notify_next was reset to NULL. Addition to kernfs_notify_list
>> would only happen if kernfs_node was not already in the list i.e.
>> if ->attr.notify_next was NULL. commit b8f35fa1188b ("kernfs: Change
>> kernfs_notify_list to llist.") removed this checking and this was wrong
>> as it resulted in multiple additions for same kernfs_node.
>>
>> So far this bug only got reflected with some console related setting.
>> Nathan found this issue when console was specified both in DT and in
>> kernel command line and Marek found this issue when earlycon was enabled.
>>
>> This patch avoids adding an already added kernfs_node into notify list.
>>
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This should also include:
> 
> Reported-by: Michael Walle <michael@walle.cc>
> 
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: b8f35fa1188b ("kernfs: Change kernfs_notify_list to llist.")
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> 
> For the ARCH=um case that I noticed:
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 

I am really sorry about missing these tags. I was not sure if you have tested
the patch I sent this morning.

Could you please suggest me if I should send a v2 of this change with these tags
included or if this mail is enough. Sorry if I am asking something obvious but I
am encountering such situation for first time.

Thanks
-- Imran
