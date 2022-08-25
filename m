Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA65A1A79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiHYUiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbiHYUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:38:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BDBCC1E;
        Thu, 25 Aug 2022 13:38:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PK4EBu020422;
        Thu, 25 Aug 2022 20:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dFikT3XVayx/CWDubhGXmTcuWC1BILcHV7LOVPNtIFM=;
 b=trZBqw+qUjR5Fwh11LP/3lsirRrd9xXCJqItc5hiY3ohTJwIe5C6i8HQRqCi4UansGo/
 IjqgtfD7iMpyIZeuYAsktE4b/VPQJCmEeJwT1E/x6oxU7G9jPEQIJfBomD6X1rKyziaD
 V1+D9kAmzj0JTcsDyCyEFAm1MLgBb7144qc+qMFFlt0MAgg97r7ZrNfbcYLsLvRoUlei
 dj5Xw9ToTxDlyJSwHBPeahYMo/bVJ3HwKDflZir4iwnezoB2pb11nqLeehTm9Oiibjsa
 zbBE6vAPN9MvpdTRYvZRPPtlN6C52hy7kU92KkPJzQQT74YHYPTPd7Qzf2PZ0eXLUxRx Kw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww5avf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:38:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PKBSLZ009635;
        Thu, 25 Aug 2022 20:38:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6nek5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 20:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brGc9WTSUhZouUWpFeyWASWMoj/k3tU7L/wnFgmJ50zpO6YShYV5aV4DLEYgSMcWFjBV50Kon7oDLIjpp2E8le8LlicvjlT7RtfYS8s1+YLVgZpQjKQWPXvcROrgAiDielXflcvcO+VDJoha4ECr6raMl6xmD+N/BtotCX18M0KFuDQ6ATu4rdpmp/ImwF7PK8dAdazAB2NxQOdToOB1rsyC/zfiZZEGSwmp6iKHm79zkTdkj6DB/lsaToKpYS4PYlVGVFC9Fet4CcYYxeaDz5NNW/yKXkbI8ALFQhHGyJAfBRW32SSL1RBfmOKDtn2sOuz0g/8WDTspsyzul/mpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFikT3XVayx/CWDubhGXmTcuWC1BILcHV7LOVPNtIFM=;
 b=IyA2tDgHb32IeTcMVy7M+Afoy3y2bAcr4qhAt3sACPhQTGAg1N6m8e4FgEWUO2kGTAVAs5v+ff8YAhYKA+9DzxUXlKiewbc4UZNFsb+bvq4pkQw2FW4dT0nJU0XdXQLPuVpZuyYIGOnGsnvSfx/UwMMVjmbYZDuebtEDYsA1DD419Fx0oWzaHe/zzR3C34tOxIlvlpjU9T3tzFcF9BV7D4kJ/ElD7rilqd6/CqviRKjRkt1hNLk1EUb3HnGLuA8I0IgT7PGsnB0we7oSzjkMCvjcl2w+ff6TjvZElo0K1jIreRo/9uKO1zuSEUKig/huOchDV3Hnv1Uh2DCB1etzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFikT3XVayx/CWDubhGXmTcuWC1BILcHV7LOVPNtIFM=;
 b=r1A3pZUoS7uoJQMCbrBGtr2Tx0kXERh02kdel0LU29zyFAzDcdu5cO/P9kzBVUTE8/BdIXzYayLcdD7X1w2yyi0oRNSnBgpzLBZFrFcXC2ooPSJovswioMcAtCosUo48e8xZcAW/s72EAVGq36fV9LSuBYejz2yF67iY8lAPZ3o=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.22; Thu, 25 Aug 2022 20:38:26 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::9d39:3715:87b3:c9f3]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::9d39:3715:87b3:c9f3%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 20:38:26 +0000
Message-ID: <4efd2c33-c561-b784-b52a-fb90f1c44fe0@oracle.com>
Date:   Thu, 25 Aug 2022 13:38:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] turbostat: cpu9: msr offset 0x614 read failed:
 Input/output error
Content-Language: en-US
To:     linux-pm@vger.kernel.org
References: <20220124180445.1137-1-samasth.norway.ananda@oracle.com>
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org
From:   samasth.norway.ananda@oracle.com
In-Reply-To: <20220124180445.1137-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0139.namprd11.prod.outlook.com
 (2603:10b6:806:131::24) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fb69751-2101-4a7c-b9d0-08da86d9c2ed
X-MS-TrafficTypeDiagnostic: DM4PR10MB6230:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh48L4x8K7HXGf6kt57IBZ2SXYgEAwf8ipIJ/TaYfRa7IxMcNhO/8lcFgULMUdh8haoVbK1u4jY4xPvLl2joQzpeNv8ZinvhC3Y9KCUFYNoxnLW5ovMukOPYKQaikJP3jCjd0V3YIxfFY48ZvwJen7KCnUJFd55yPRAbqfT+uLZQy0gR+4S2lZjFDr+GRdYB2mM9Zbb+LKlUF/gHTEDwsy5Wph4llRzDp6TOUCAKN08bHgMTqREjaxYc4HavAqMXhJvTIZc6h7InQk2o9MOQZ3T98rWFn+Arlo7EddTCRGolqsOv6+lmTefhVa2QrhItKahvHDpsRdu7T3CPrq8L4T3kvMReNWwbg58kjWgwzs9cIZAYge6MTAXd4lE48hMXDtrvElH+0IhTKvmsp/Yi8t/aI8RDpXc7xTa/bKb5wjdvyP/94zBuSzgoAvdNB6VcoYNq26faj69w7h9iDIUrJK0h/PpAEBepKBPXTn3Rq6rDlO1GBjxEMGJ2tYRXYgD+tdyM7Bvjkr+4ZmBQ1ld+jHE5cQRWZCwwIUYKTMF52avT5BWbD+5uzdLjIRIUwMDQM+lBEKRDYeNWnTNLgORG2jO0IJWOKEhWNnIY2ko3EauYGzdjDCPkKYHEXzU0JME8cPVamY5gXxnC9EqfKPuLS4CaZyGcDoWAAkQyxO9zZ5krelqiT22cUx4CXfxZ3tVsuEOMzbcluWZgdGLSl813lxeGW+PHLJfU92Gpa0ZaxodPY3Q/RRxi8oKsCj9m6IBY3Ui7HylbtSUquIFlAhYzWPvjZX/MpI3mtUXSBNrPqYNsksuwq8ZzcpE0PYtQsCGBxEEubVevL9aIqUjU5BdzRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(366004)(396003)(376002)(83380400001)(31696002)(86362001)(6512007)(38100700002)(6506007)(6916009)(9686003)(316002)(8936002)(5660300002)(66476007)(66946007)(53546011)(2906002)(66556008)(4326008)(8676002)(66574015)(41300700001)(26005)(186003)(478600001)(6486002)(31686004)(36756003)(2616005)(966005)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5PaUxFcTB6RldINGJ6Rzc0M2xKVnR3WHNraytkeGduMnZIbUVDbHRwZzFl?=
 =?utf-8?B?bzZ0NXRVUi92WHJ5b05yK1hHMi84MWlyTytZZlZjYjBscHRNR0VYeHY3dkRB?=
 =?utf-8?B?Q05VbXpHQk1CMjVPdGR6YktmR0dMeFhjWlp5YTRHbU1pRFJKczhiN2l1dDgw?=
 =?utf-8?B?bzIwdktVbVZ5Y1FzN05icUt6VnR5by9ZT0tVYVYrMHFQa3NqVGY3Q1g3SDBC?=
 =?utf-8?B?U0lRS3lnZm1GUExscUlXQy9Dc3R3ZUNaWDVJZFc2eGtvSlBnU01qV3kvc1Zn?=
 =?utf-8?B?aFBzSmVhSEJhRytRTlNjdVhzNkltNnZoOEtBU0FTamZyK3AxZXBKN2k0SnMy?=
 =?utf-8?B?WXZIczQyWkwxbG5JU2h5Y3F6elc0L09HNnExOUxhT0hKVlAwYUVhTi9vWENm?=
 =?utf-8?B?QXNJajIvSHJseDVtSFlPbURDTjVBdU1oRk1kVmNuV1ZlRi9jeFpmVjZkVG1X?=
 =?utf-8?B?T0RTV3hScm4xVThkb3lBTmNhNmx5ejRnMEZDM3AwWDJ5emtmNnhwRVh0T1Zy?=
 =?utf-8?B?cFBMR2ViMjNtM3RDL3ZUdDdidFhURE1xQXMwcnpwT1dYdm1Ea1poS3NmMGZT?=
 =?utf-8?B?dmJYQ1J4QUI3MlVHN1YzbUdOOHB3YU83dS9pSVpWR1NRMkxUaFBSSVlrSk81?=
 =?utf-8?B?MTNqbEluZk84TWwvY3ZhaDNVRHYzak1uSWVmdlh1TFFDbnpkcDhUM0pVZEFV?=
 =?utf-8?B?NmdxNnJpZ3ZpZVlVY2hoNEZua21iaDV2M1ZFTTZKa3NGeC9pRHhRcTJCN3pG?=
 =?utf-8?B?Rk0wRWt3cEtiN0lDYnNRcUw1eG5DUndtdzgrOWZHaWpOelhSWDlRTFNNcXNG?=
 =?utf-8?B?NHdpWFI4YnJDcm12amYyOUR1VUowQlhZZ2xPNXpyWEJXUVMzTGF2WVNCUnFt?=
 =?utf-8?B?WjIzNkFMZFhwLzlac2RaU0x2cERzWUM4MGlVZ3Nia2ZIRkFHQVZFaGkyNkVS?=
 =?utf-8?B?emhMNW9UeUtaelpHdC9QWmJDRk5QdlpMbmJVcUo3c0NqNTlQc0pkcklVdDR0?=
 =?utf-8?B?RklnUUZGUXRBcCt1WGU3QzFPUkltUlJZMys4MTdpaUlkTHZzSjR0dTF5ektY?=
 =?utf-8?B?RXordTFMM3pEWEgyNTNranFPV0dYWlJSQkVtOWlSK0lOSUdNaCtBVGZmdGpY?=
 =?utf-8?B?RDl1eVR4TGdwUkpnaXdaZ2NmU1I1MFpwT0dRay9zZTczRlh6aUVMMEZWaWZM?=
 =?utf-8?B?YjVESjdEL2JOdk4wa0VJU3ZtWm16S29rTFZpTFI2U3gwOSs5Q3l1YWFHMEk0?=
 =?utf-8?B?akRCcTVxTmQrdG16UWw2MTV0QkRhUEdkZmh4NnE0QTJOckk1cHcxc2ZnT0Nw?=
 =?utf-8?B?MHp0T2xtbjlrRmZGc3pua1VTa2FyNWw2OHJQNENmbFZWUlgwbTdhVjZ3d1h2?=
 =?utf-8?B?cVQrS3ZLV2lIMHJzQlBzR0owNHZJMFc5NmJURFBFdmhPTFFoOXNsQTNWRzFz?=
 =?utf-8?B?SFhMTWpOS0dyYnBRd2Y0dnZMa0dTaGc5YVZTdXJhYzZ6UmpTWXc3OHFTRjhy?=
 =?utf-8?B?RnR4WjB0ZXMrRnQzcnZKQkgvVzY4TXJxbTFTanBEb2NaWTB6MkRJWmsvVm5t?=
 =?utf-8?B?SHdKd2hkSTlGYmtVVmJmaWw1cVRMRzA5M2FzNmFnSDNvNXlXYWxjdnh3eU5Z?=
 =?utf-8?B?NnBnWHJoV1QzMGVXRkdwQ08zMHloQWJUSS95U2dsRnVZemFnaWJyS3EvTDZQ?=
 =?utf-8?B?eVVVUXhKdTg1YmxDTVlZbTZ1UXZYYVJReHZESHF3cExKcTkrMlpEV3RwbnIv?=
 =?utf-8?B?RURnckx6bmJxWTEyc05EdVZBczRkWDNuK2ptd2dHQ2tkM3BhZ2JrNUpyS3hy?=
 =?utf-8?B?bGc3RUNYeVZwNk9wMkR1VGpJUllpZ3VzbFRwZGdQQ281L0Z4aS9Nd2hTWXNY?=
 =?utf-8?B?SWlFbDkvVE13VTZSKzg2KzZQQTFSajl2KzgwcWRhWTNVajZnRFZXWUJBNlNs?=
 =?utf-8?B?MkowaFhnbUtHQjBFVmVJZnVRYUltLy9sZXhOZmVkMXZQL3IxV25PNm9qN0py?=
 =?utf-8?B?a0oxZXNSaThqUzRHbzBRU0tJeTZUTTB5WWdnY1UxK0RTV2xvOW1qdm02MXI1?=
 =?utf-8?B?eFQxRXVjUVB3WktXVkxMTk4yYk5SbXZkTEFVaFRxRVoxNDJON2UwdWJHamgw?=
 =?utf-8?B?Vm1VTENBRnpxb2hCV3FpZjh3SVE5QUNGTTFLWnQvTDMyY05FK2VoWU9HVHhK?=
 =?utf-8?Q?iEAHGY5qBQXyjx1928D2JEg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb69751-2101-4a7c-b9d0-08da86d9c2ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 20:38:26.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxAKI5VJ/DiTlXsdZagNGhC4IoHlr2gar1zagY+xG5ixEsP6sby8S+OrVGWMruxUuYcNmW5FpU+ZM6e2cuqHHIvMPZ4JxahxxO9m0WnSt5q13bCCiy8bMuFwvO/4D/hT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250078
X-Proofpoint-GUID: wwVqbuF3NXWlZy8Mk2IeEUQFomvmXOrs
X-Proofpoint-ORIG-GUID: wwVqbuF3NXWlZy8Mk2IeEUQFomvmXOrs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/22 10:04 AM, samasth.norway.ananda wrote:
> I get the following error running Turbostat on an intel virtual machine.
> 
> turbostat.5.4.17-2136.300.7.el7uek.x86_64: cpu49: msr offset 0x614 read
> failed: Input/output error
> 
> The below patch gives a more user friendly message. It is based on the
> patch for turbostat from Prarit Bhargava that was posted some time ago.
> The patch is "[v2] turbostat: Running on virtual machine is not supported" [1]
> and also similar to the patch for x86_energy_perf_policy posted by Ondřej Lysoněk.
> The patch is “tools/power x86_energy_perf_policy: Input/output error in a VM"[2].
> 
> KVM disables MONITOR/MWAIT in __do_cpuid_func(). Hence no VM will have MWAIT
> and hence turbostat will not be able to read any C-state related registers
> like the failures we see when we run turbostat. Therefore, turbostat should
> also gracefully error-out like x86_energy_perf_policy.c.
> 
> [1] https://patchwork.kernel.org/patch/9868587/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=0936cdfbb527
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>   tools/power/x86/turbostat/turbostat.c | 68 ++++++++++++++++++++++-----
>   1 file changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 47d3ba895d6d..c2904c1c0830 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -538,14 +538,68 @@ int get_instr_count_fd(int cpu)
>   	return fd_instr_count_percpu[cpu];
>   }
>   
> +/*
> + *  * Open a file, and exit on failure
> + *   */
> +FILE *fopen_or_die(const char *path, const char *mode)
> +{
> +        FILE *filep = fopen(path, mode);
> +
> +        if (!filep)
> +                err(1, "%s: open failed", path);
> +        return filep;
> +}
> +
> +void err_on_hypervisor(void)
> +{
> +	FILE *cpuinfo;
> +	char *flags, *hypervisor;
> +	char *buffer;
> +
> +	/* On VMs /proc/cpuinfo contains a "flags" entry for hypervisor */
> +	cpuinfo = fopen_or_die("/proc/cpuinfo", "ro");
> +
> +	buffer = malloc(4096);
> +	if (!buffer) {
> +		fclose(cpuinfo);
> +		err(-ENOMEM, "buffer malloc fail");
> +	}
> +
> +	if (!fread(buffer, 1024, 1, cpuinfo)) {
> +		fclose(cpuinfo);
> +		free(buffer);
> +		err(1, "Reading /proc/cpuinfo failed");
> +	}
> +
> +	flags = strstr(buffer, "flags");
> +	rewind(cpuinfo);
> +	fseek(cpuinfo, flags - buffer, SEEK_SET);
> +	if (!fgets(buffer, 4096, cpuinfo)) {
> +		fclose(cpuinfo);
> +		free(buffer);
> +		err(1, "Reading /proc/cpuinfo failed");
> +	}
> +	fclose(cpuinfo);
> +
> +	hypervisor = strstr(buffer, "hypervisor");
> +
> +	free(buffer);
> +
> +	if (hypervisor)
> +		err(-1,
> +		    "not supported on this virtual machine");
> +}
> +
>   int get_msr(int cpu, off_t offset, unsigned long long *msr)
>   {
>   	ssize_t retval;
>   
>   	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
>   
> -	if (retval != sizeof *msr)
> +	if (retval != sizeof *msr){
> +		err_on_hypervisor();
>   		err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
> +	}
>   
>   	return 0;
>   }
> @@ -1858,18 +1912,6 @@ static unsigned long long rdtsc(void)
>   	return low | ((unsigned long long)high) << 32;
>   }
>   
> -/*
> - * Open a file, and exit on failure
> - */
> -FILE *fopen_or_die(const char *path, const char *mode)
> -{
> -	FILE *filep = fopen(path, mode);
> -
> -	if (!filep)
> -		err(1, "%s: open failed", path);
> -	return filep;
> -}
> -
>   /*
>    * snapshot_sysfs_counter()
>    *
A gentle reminder, I haven't received any response on this. Any 
comments/feedback/concern?

Thanks,
Samasth.
Oracle Linux Team.
