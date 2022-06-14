Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7254A70D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354525AbiFNCvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353199AbiFNCux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:50:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DAD433BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:32:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E0olGr027247;
        Tue, 14 Jun 2022 02:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8RSpt+ie8GdQs0hSQHCMgLen59frTTFPqIZT/0e2mvU=;
 b=ev43OkkrUH3jJ3twWXHDZe6k2q5IKyMYXanQ7wkQnAcI8z6x5UxwptIfgJX0/ARZX7Rh
 UYtTREmSvKS5RL+gJOEjFIb6csDTzjvbHdRb/JyYr5WDpeZmw1tNoZn8wU0/2U26R2qW
 1PM6whSjikHgHI3Zj7/JxBVClSDohNpqIApesN1qjmocKk0amSF9lkOHNWE0eIvf8GWS
 J5F3E3R5DJc+ltICknJCjh8VkvL/qECQzgJsBr7y9JfTCd83RVwLGBzYMdialH5U3eyo
 5qoMqWu0SP9AMPuk7X2ZZjAUiyPyw4N6hDBO7Xfgx7VqdaUvreepDlEXYcCe72H0Wos6 Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns4k1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:32:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E2JoRQ039072;
        Tue, 14 Jun 2022 02:32:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpgmx94uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 02:32:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnRYa67N9fuf+roBwg6d5t032pT+j8vTELTwRfrCRN4HP1MJcfYWR8gMZBWDVdtt5Bw+/zLxWFQTbymRT4zlIqwVML5IJcvgjJgbDxge4U8cOlwbLwIAQqwnOOGQJAoUMbQSjcI8fFM0g6dx2NJsHTzzEn/y7opaxpthqsjaoALFS3QSgECu2aJ2Q5etTbsMgXS/STjgQ7rtCR1sVTVY5uERm1xFxZ4BQglFqunvmYY3glgqrM0y6ob762y05/X9Gd3xJB6aLuHPIZBkrbUpGhTFmY8MBySD87xdZYLjvB+vd5x9OSmXCQJMQjz18sbCpqBrXNcoD96nUoYhWijH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RSpt+ie8GdQs0hSQHCMgLen59frTTFPqIZT/0e2mvU=;
 b=nlmP9WSrYYHX/OCtVC92HlTpwKvjLWwYFdMcbQlN54n+I9tf4mGOp2E+CtBs+c0IvnFAZLErsprVzemfnX+Nc1/SEriEKMvJBN2F3hcbphUq7sCvkt5htdg1URNn2cuTUSPiFLYd7w1SZgAfy8qIyl2x7uWzvHqRjyJtjbDfA6MwSTAXR+nDfjV9gRBA6nCtGZeyIQSv7Lc8b9bVrn7r49I833+wYRTIpDsRu1AxD7PJDBJSd/O5wGwBS1pVGGNTz8VMPPCJSEahVFom4cDN07H4Kudn5LVm9QXksy2YOFyx92pwILrZeszMXmtGtbwDv0w7136On+lc/3aKtclZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RSpt+ie8GdQs0hSQHCMgLen59frTTFPqIZT/0e2mvU=;
 b=xqKStSv7su//WSJQEWk8+RGfMMM+M9w7zuyPYCQyyR81eL3Bs6aX8BaHKjA4A2dRUN+Ij2t+sqU0Va3FmXKCdkTFESklpFxAOlh0I3aFe7iagE5k2dpjFvpdaf0+snN1OAxO7s1lrIRa7GzpP3xZO3rJN8td7aMaztExqn3QYok=
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com (2603:10b6:a03:2af::22)
 by SJ0PR10MB5718.namprd10.prod.outlook.com (2603:10b6:a03:3ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:32:04 +0000
Received: from SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a]) by SJ0PR10MB4479.namprd10.prod.outlook.com
 ([fe80::11a1:1f57:5f11:ab1a%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:32:03 +0000
Message-ID: <e0eb26ab-7c57-6df6-a2ff-83c84ab145a8@oracle.com>
Date:   Tue, 14 Jun 2022 12:31:59 +1000
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
 <6d1c5a49-fc16-5fc7-e527-8cb91ec0d25c@oracle.com>
 <YqalHuEB6OjjUosV@slm.duckdns.org>
 <c8a8a616-da4c-f2ce-0bb2-e0cba69db24d@oracle.com>
 <Yqaqbas1JaWz25jB@slm.duckdns.org>
 <61868aa1-6c88-ecd2-beb2-67b87673b805@oracle.com>
 <Yqd0OJupifpplENB@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yqd0OJupifpplENB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To SJ0PR10MB4479.namprd10.prod.outlook.com
 (2603:10b6:a03:2af::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d9eff1-09dc-4b62-2dcc-08da4dae1159
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5718:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB57186B277C6CB237E831035BB0AA9@SJ0PR10MB5718.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QADUfQp3FqRKYZiZKV+ksrYmt+em4b9Jt7PV0x8s3PcFL2ktZaSO7Bdu0S2FgsquRcSSqqITvc6/Be0oO3XBkiu6F/iTIct9eSLJInVPzVLfekmlNfRy4b7dEOaXvN8/VYa1vmipKse3Fj4DlUlVZS3LdCHKeZ1ai3J6RuM7fFjs1+0x2b+QNJyz9hM9t4x8K8cYcFH9ATV1Mt9V0kmIPAOqJJQT+5bcp+2fRu7g3qtIL9ynd7w2lIwp28fHum4d5ZBYVYdxPxpptFSeSjRaCw15eZBuFNlKZCF/asXHFKhow9DrJJ9NSU4pi7spGLKPfWPrtibltaL8cdtNwWYH6bjioOJ3E1ioT18j9NoTkHALbPiG+fXvse/SeIC2FhWbHY6PTQDFODzpTRthaUgCX0V4VgBj5As4OBV5HYyj6nCvQWQPadoFLjBYiVNvgDV0m20dapv4UuLFsLiu95GY6NEXapi+ldbKM8drq0PKFuLINqAZRNLT5gQ37WXYamEXWzgajuh+KHNgJF9SOKOiXmoLGjqGcKV1zfsYLeZVnIyqjJMQfPIJM1rUCDBBWZvitQgwsXg6xXgHkpux/IMySVrA8Ym5T0kDR8APSdZl/+CtfsnqX0eseS0AxZKyEkAR/WszjsuDEUlk+JE7Xzzc3qbwaONKIE5D1JMIqUpMHQeBTj5pkNXvXE/2gide16hprVlkXfp5Z4jnv9l2PqdW/ggkgE+mbL6BJBcjYi6vz6SkqsAMbXnIT+8WE2uiQ+q9+QS3ZjUGsU+wF+rUQnellt4pfke7sRHUqzxN/g7p4V4UueQ7hBHfNKFv6CQlBIkZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4479.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(36756003)(31696002)(5660300002)(4326008)(8676002)(86362001)(66476007)(83380400001)(66946007)(38100700002)(186003)(6506007)(2616005)(31686004)(4744005)(53546011)(6512007)(26005)(6916009)(508600001)(966005)(6486002)(6666004)(8936002)(316002)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNDd1UxcVBhWDBkdVBVT3RESjNKZnRwQm9GNXZtdWpQeFpGYTd1Y0ZKSDRV?=
 =?utf-8?B?dTlJTHMxREJiMUVBNVI0N2FHK2IzQStjZi80cHJjMXAzb05xUk9JRDc1YUY4?=
 =?utf-8?B?dnBUWDdZOTZidGxVQ3N1RlNGVmVyVjdRK2NiNmJlYkNLeXl6THJUTkNjOGFV?=
 =?utf-8?B?NEt4S1pFOEVSL1RXQ2FJV0hETmQ4dHRCK1MzcDF4NHByb2RSOEUvTlJoQmpq?=
 =?utf-8?B?QXVUK3Zpa1FPc1BRcG5kUFFtei96Sk1zMTNhcTdBb28zeHREZE4vYU1kSGMr?=
 =?utf-8?B?S2lBSjVaaFZmd2pldjA1cnZlQ1pFS0k3cTl2emNqL09qbWNPOGRoeHZwdEx0?=
 =?utf-8?B?QnZFWnBJSEF3WG1ENTFDTk4ydkJmNmRXWG50d0w3dW9lcHQwbW41VTZtckhZ?=
 =?utf-8?B?dGNNdGFqOGdlRUd2U3dXRmhOTEFBMnl4bnVtWFlucTJ3bW9iOXlTNXcvUXJu?=
 =?utf-8?B?Y1FPKzNqN0F0c3oxMjVMWDU5U3ZVMEpuRDgzeWJwSHBvZEUzSFNYejRCNExM?=
 =?utf-8?B?d09RajVZY1lsbEw3M3UvcFM0WE05WVU5WTY4UVNuWUNyRWZ6bnRRbEF5VW1R?=
 =?utf-8?B?WFU4OE1WeHVoZm9pRnFISGdWYUVIK1BNVjVYN3VlTXBzQlUvUzNHdmQwZ1o4?=
 =?utf-8?B?bHkxQXl3NjJVSlJhelRhM2NPdWtkVTBpbStEWTh3RENJbThvOGJIVXBkeVFx?=
 =?utf-8?B?ZVp4bVphNHRkSlFiellHTTVMQThrdVV0RHhBeXMzYXFVU0dkMFJ3U3kvQVZn?=
 =?utf-8?B?TDdHeXZ2MGtvLzBsRGFOam8yMy9LOTZCRmwycUVmNHRIV2tZeFRkc24wUXg1?=
 =?utf-8?B?MmlUWFBvRk5NVUZNZGRXdVFXbmVtYnE4Y1NERTZnWnNxMFNBM093M21NdnJN?=
 =?utf-8?B?ekx0elFsZDM0WHZ4Zlk0NDMrY1A1aFoxcTc1UDZkVFRmSG1yRkdaekcyWC82?=
 =?utf-8?B?UDI3Z2pXR1BReDBsOHZpQzlmQjk3QVJBNTF6bzMxRkpNaHAxYU8vb1g5eFJN?=
 =?utf-8?B?Z1lYZGdwMzk0eG9kUmZJQ3IrWHoyand5WVQ4SXlZRGl6TlB1dkROeXlTOVBN?=
 =?utf-8?B?bVdPUHkzZVA0Q3U3Unh3bzdWeVJlWTJVTExtc0xUd3hPZ0VXZFllRnJGQ0J5?=
 =?utf-8?B?QjRqRmEwWTZ4K0JmaU9uR3daQWdNSTVjdDg5Q1BtUHg0Uk83akw2OTRJZHhD?=
 =?utf-8?B?MDFvZ2xXQjZMR0NBSVVQSjNjc2pPQlFCQlp2bDVIS3dMTmlvT2RIcFo0Um5m?=
 =?utf-8?B?NnJsZHVuL2EwMXNFYktHT08xM3daQjdFd2pYcTg5NzZINDFmRzd5S0tYOWZS?=
 =?utf-8?B?YUdqMjBicDk1a0FQWDY2aS9pZ1RJZlphc042aTJ5VzZpWHUydlZOY245QWJM?=
 =?utf-8?B?OTNqelZHQ3M3c2syVHBYb1FwMHBvVjBLQ3IzZ24yTjZFNG9kNEdwQ0J1Z3J3?=
 =?utf-8?B?U0hrSGJFcXF0ZDlLTDlFOE1PK1dyYjlid3pWUFlkOVJTbnlPUVRaWDNzc21B?=
 =?utf-8?B?NzFZcjAwM3l1K1dlS3h6d1BxT0pWdmNGRTdhWi9tLzFXWnk0Z1d5ZGc3ZEtC?=
 =?utf-8?B?QW56VXVXOWNWUFBmR2N1OVRPUDJnbU5tWHB1cENyeXJzUXZyc0ZUTFhhSlRP?=
 =?utf-8?B?dmVnWnU4YXBJMk5tMDNLQ2hxWGM1Rlk0RkFVcXhvQ0ZoVjNyMFN2T05YOTJR?=
 =?utf-8?B?REFjcE5udXY5Misvd0MyRHZUWWxmME05M2Y1aXAwckN6cGNJNUlLZ2Rpano1?=
 =?utf-8?B?VkZWcXNXWmhnaUl1T05mc0tXNHk1U0xic1l2VitOc0JJWjFBWHZmTXhHTWRE?=
 =?utf-8?B?UkdjMHJacnVMOXdBY3EvWHV1RWxjYXdJMVRoUVZCa0JRckN3MFoyQml5aDI2?=
 =?utf-8?B?QkkxM0lFYnFxa3phUTcwVmxSNUpPUlZ5dk1FbWMxVzZkZ1phSVZKQVV0WUlW?=
 =?utf-8?B?M0Y4MVMwVjNpZ0JQT1Vaa1FYaHRjUTkyemdhT1pMNFVlK0ZtODVtOEpIWHQ5?=
 =?utf-8?B?Sm1pSG0ySUF4VCt2QzJoOFJZbmpwVkpSWFBaTVFjVlY5cHFhNHVmMWpTZXFw?=
 =?utf-8?B?NjhEVUlNYzY0UDdHRHBreld0MnA0UVM2V21DN2t0WmtmcU9meWVKVzJXVHdm?=
 =?utf-8?B?emZCeFEwZTRLQUlVZ0V4cmpFbnJwSGh5SXdQd2NobUE4MTZpRDBsVWFWTWR1?=
 =?utf-8?B?cjJoaTU0Z1owTWZiUEt6dWNiNjBzcXhENEw2a3A1OU1MQWJCVGpEc3ZjN0lB?=
 =?utf-8?B?TUpUY1p4b1FvQlREc2I3OHYzcmlSay81TVFsTkMwNnU4NVduelBTa21NbmRt?=
 =?utf-8?B?c1ZSU2tMRS9wTS9jTDdnVGlnT25PR054UWdOYlRtUWpOKzhLOEZ1b0h0TVhp?=
 =?utf-8?Q?2o7J03poEDnxuJFM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d9eff1-09dc-4b62-2dcc-08da4dae1159
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4479.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 02:32:03.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOWexVVcXOPPJCahtGDV0L+uxBZCJgth8/36HY2SJGKRJdSR0dM1K7DciW90fK9z322LL6m5urJvlmXkys5UJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_01:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=891
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140009
X-Proofpoint-GUID: nLr2YAgwJGE_9PTzgFNwqtEr6n8zIKCV
X-Proofpoint-ORIG-GUID: nLr2YAgwJGE_9PTzgFNwqtEr6n8zIKCV
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

On 14/6/22 3:30 am, Tejun Heo wrote:
[...]
> 
> Just merge all three into one accessor. You can list both the !list_empty
> condition and lock held conditions on the same rcu_dereference_check() call.
> 

I have all merged all dereferencing into one accessor in v5 [1] of this
patch-set. Could you please let me know your feedback ?

Thanks
 -- Imran

[1]: https://lore.kernel.org/lkml/20220614020840.546013-1-imran.f.khan@oracle.com/
