Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F256C22E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiGHVI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiGHVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:08:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AADA2388
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:08:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268JSpo8028248;
        Fri, 8 Jul 2022 21:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=juJ7cRdl9GYJ3x+tPC7Rfkkv+tkBA9dIEHjIfFCS8eYs/QuBMhXJHjACI6xrAUOYMkRC
 bhbFjoJmVfdo2UoZIkAvZ1ZWfkaLg0aN0+IM8zrGT99YNTPXlejjIxhKjUgbK/UZroWk
 gGDEtN93RYtZYxKIi0Kxo7R7bVhsAQwZN9VU5dVGoQJy7sumMlP0dAN3y0zxDkYYvedd
 hbMgSl+owZlFcD4d2gIsWMGeWy0RwhduPBCGDhrE6LHxQqXmcNRUX4SUIS+/DvuCuN1A
 mfdHdfX5AGF7IsdqjN/RMVWsBEjwNwn59tPEACNlq3wVaBQc6i+UHSwQ8+MWF7BsA4DW oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubys6k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 21:07:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268L6qmS029497;
        Fri, 8 Jul 2022 21:07:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4udaec9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 21:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUSvQmV2N+Ixm6F7mrN+VSdAVvRq7N+qHOtLWgUUbdXDnCmyQro+00VqWttaupS6bHb/s3Hk6J+8Qotj/cIc5FKdBiQaSZnKMqd0RRHx3amhiWSpDQ/DW8C5nuZS/wsqLIjqTfxdFXfgXvdLaubSdkIwtu1YsmQTmJtbAYyNxeB9kbjHAkiAfsWUVhGrYdXXqsBzEMc6az2GJMDH1cqK+HP5i1qlSZKIOiO8lNQAqWvE1kFoDdvN+5xaX55xWjMdZvZ958keXlf467+d7e7FAYnhH3DVRrWO0JOYW5XVE0ZQLyJd5H8Tj20L5x3cIwH3aOuxGOgYkUumY9Pibkk7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=YOrfPZ2mL4BN4OhPyXC97KcnmH1zG2mL3zjzUm+ZriqgDb0e7hGBpzvw+7P77ou0wfmeX8T3qSzg6ZEGhDgUVnTejpwcR/NzfElgKnXhwtxGjpT4zkaJNyq/mnG3d4zCjaT+mpDY4nX1VTonl4KDCMcpz8fqcq3E32J4dMS3yQSFK3U5QRPGg0EdMKZRPeElzYsbmJs5hP6a1v1vIAx9oq3rA4re8mjG5x6VsjKv3sBj941sJuDQB1vTdxVknNXnuFz1mRG8CSqNpGDNDNu9zsf0/wSucan9OM+4/OJqnKfmkn6voLV7KPsbpIH+Jzwc1FGxmEzXwj2iRC3Vg8LpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srv7sW3jaIDaycVMKJD7G4hMFM/ejfOrATTExinyTpE=;
 b=ClCwZZxdnmTWqTLR9oNKdlGTl1SbjWPuP5ijHIRQrut90lg8cB+MqrarKZO2/RtZ5WbiIlcsAftyUXOYWHQaa6GYsugMkcW1uYAoqdwZ8avhpcREdohVeAZjLmuqwn3jmfrPAIMwkCuyrTp0vqaI9suJ+Wl+K9W5vlJ5lBCPPqk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5585.namprd10.prod.outlook.com (2603:10b6:303:144::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 21:07:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5417.020; Fri, 8 Jul 2022
 21:07:28 +0000
Message-ID: <3bd962c3-7dc6-6dd0-6d0d-2e4667a69a8a@oracle.com>
Date:   Fri, 8 Jul 2022 16:07:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <2843978.e9J7NaK4W3@opensuse>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2843978.e9J7NaK4W3@opensuse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0408f5b2-44d9-43e6-fe5a-08da6125dd70
X-MS-TrafficTypeDiagnostic: CO6PR10MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mJIdLedknesTkLdr11l9iVPvafOEfI0/8bi+9yJnEgD1gfeW+dQl5fN34lnDp2TmKGo+i9pQAupdMgN2R9DEJ4R5eIU1FdWEaQxidBXer9qabZd8I8/ajNw5GoKqkAf3DkBJCDP5QjP39JOgvrcJmZ7oGKlSwxwRGoEqWqdZ3S3hDXUXqgzfI2caO7mLwXpdeIu545FJqjplhQRCJbk9NLR9oq5MLgcxPJRBDymlg/9aqxtcZf1FUMHN8QaSWRMUcR/1V0iYLr/S7bhR3m/PMa3+BwvUY5FqodMEWQ70Q/BB5F5ee6FsUAo81mwwZdF/ihR50Aw74dsrfOdDBYnL/2uiOYJTDafzQDuXwYSQtRiKyTvOCtJl7oCrZgp8lsmEDDDhuD8G7McWATWRam8VSLB5KHHIi8kNLm5eyZhBHAvbYxaD0UTm3jX86Dakr6h9HUcBsGOQex5ZxpaW/eZAm6rg1kpAJptDeNDJQSrc0Gxt0q/j59jTXWPrS242TEH9RRxJuxl7CC81uokK23U9Liw6rPn2u2rFYOFHsM9562qqq9ZI1S3DYKw9PLYWr8BHkzHhZbcO6RTNOAfC/cRQAkNCKvBM+ddFyNJHNTrK4A4ahHB8bLhm0f7bSRo5rbCwsZUlCogR4vSgpkjjucSyuUU6CubOv2BqwHd6z0W3WDwq3H2p+VazqblqgzAXfqfxqy0F/nO72Jb0Lwao8jT/speWVxRZsa7xO48If7dTsz/Uc8+46QUJivPT7foto8W78f7uOv+RH1OVCZDVBHXtsy6fJH51HvDaY3XfYNAgUOoF0YpTMmniCsHxzARiuEZ6IsNmhqQhBqP22BvzaT8lO3+8TDHU8JpnZCTohuYOLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(376002)(136003)(346002)(366004)(41300700001)(5660300002)(7416002)(6666004)(478600001)(31696002)(8936002)(6486002)(86362001)(316002)(2906002)(38100700002)(31686004)(186003)(2616005)(66556008)(107886003)(8676002)(66476007)(83380400001)(6512007)(6506007)(53546011)(36756003)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHArVHVNaEpKSWJkMUNWWG1oNHNHUzFZZm5QZk5HK1puZW9RMFJ6L21DSUZ1?=
 =?utf-8?B?Rk1KQ3dpZjlkVi9iNDVXOFp6T1g0ampTV1BzQU90Nk8wbjg5N2ppOW5hakcw?=
 =?utf-8?B?TjNiK3RQV0pteFVBeHZzOElhRUVsWjJEMFljQXh4WDgyRE45emdEMkdrWnFB?=
 =?utf-8?B?dzIwN1RkTUxqem5qelFmQkNPNFpMZDcrcE9wbkdHM3haOUdHOXFFUDJ6U2p6?=
 =?utf-8?B?cE1oWG9HY2c4cXJkZ1VtT2dtZ3RuNHFMZ3hCWGVjdVhTeFJBR1kyS1RISDJz?=
 =?utf-8?B?WFlaVHV3dXJWODdFZG1BVmhKZi83ZUUrcVk0dkdpZjFvcTFDTnlQRy9XaVJZ?=
 =?utf-8?B?Nll0cFRoSDFQdVZEdUFvNGJKUExqWTJzQTdqU3o4UlAyT29GT3JSS01uWElN?=
 =?utf-8?B?bE1EZVYvdlN4eWwySVRKWWlXWmNMd21ESXVQcDdLWUFmazRmb2JQVjJEZmxu?=
 =?utf-8?B?UlUydXBxL2pGN3pYWU5Qc0xYRS84L3FsUXhCeFI1bHBlclE3eGc3eVNLYkpC?=
 =?utf-8?B?a09hSGN4QWN4TUNwbG9BeE05SWlsOElQam8wWVVrcEM2U1QzR3ZHSFFRNEwv?=
 =?utf-8?B?T0Ird0JNdnJVUkhodzNhaG1sQVdVQzFyK1Bpd2xSaWpyTzg5cy9WcUp0aTBW?=
 =?utf-8?B?dkI1S0dFKzlFdG0zNW1JMmh1OXRBQzUvaWEwT1llY2p0QkNXOXRCTE9Cd3Y2?=
 =?utf-8?B?MGlCT2FaQlRrMmRMNnQzMGdNN3E0Y2Z2UFU0YjI2SnlRUmRUQmg4Y2JOUWd3?=
 =?utf-8?B?emRRVG9QRk5KMkpFWGtoRk9OTTlqenVhN1MrOXdVMU5zVUpXRTU3ZEFmaE5J?=
 =?utf-8?B?UWluc1JmRFVWOFBjMHR2d0t2a2k0QkhqY3JWa3JJWlR4K0x0dEZXZEVUZ1NF?=
 =?utf-8?B?bFFWMUo4OEN3VUw2RXR4U1JLZVBWTzc0eDZpNzV2WitvaVNPcC9obWFwdCsv?=
 =?utf-8?B?K2o2Z0VlOE8xVk1WVUdyNW0rTGhtaHU4L2I3aXptTnBNV1BQcU95b3Q2SHBw?=
 =?utf-8?B?cWRFMjF0cmVaMUE3cVpvOGpFU2NOWjNZSE5GMHU5STlad2JJMmlmOG5JMCs0?=
 =?utf-8?B?TmtZMVB6UG9QZlZpdCtpTUpJZFJ2dGlCODkzeUZ6UDY4TlZVUVVnaFc3Tnp3?=
 =?utf-8?B?QkwzNkRzWSsxalNrUjlOMmptVXpSc0FyeHY4ZDJ4Tm1WdU9xSU8rSy8xNjd4?=
 =?utf-8?B?OWxKK3hJMU5pNnR1WnZaUW1JRGRyRlRvVExadmJFZFJuOWRndUx3YmxkWE9u?=
 =?utf-8?B?RVNmSWlCMFM5dWZpOEs0Mm0wR0M5eUhoVjNFbXZsdm9OVUtoaFQzOE5xZXpS?=
 =?utf-8?B?OUxCcWVlMHhHMVJOaVExckV6Rkh6QVhYYVRHRUZIVUNheXZKRFdTaVREOWtS?=
 =?utf-8?B?NDE2NW8yUHo2Q1RYQW5WaCtic0VLK2NUVGNWK3JpUjMvb2ZSTDZpcE1RbVln?=
 =?utf-8?B?Wk1kWTFObGlNQkMzc09LbXJnOG9PSU1pRzFkU1d5Q0JTQUN1SUlpb2hZK0Ft?=
 =?utf-8?B?aDFaaDVQbFVVK3RMc1VrWElUSnZTWjhacFN0SmtKWVpkZ1VOemNCVnlQQ21M?=
 =?utf-8?B?OXBCbW9PcEwxRWdsRTBnM0ZleU84cjJUOWNvZ3dkSmxTbmRsaTIvNHVMemFh?=
 =?utf-8?B?SXNQNkN4Um81Q2JYcG1VVmhOdmlnVmFDTW1vZ1QzNkl4UDhtNjdIMnlSSHJz?=
 =?utf-8?B?dEtxTXFVdXJCL0VWdHJFTVF2bXJJS0c1M2xiV1RoYVIxdHYxYXFqUmllano1?=
 =?utf-8?B?cnJPTW5DSzExSmdMMTNwOURIWFRBU3RROGdxSWNqbmhzdWZXR3NBRXptcEg0?=
 =?utf-8?B?SWhjck4rckxHWE1lUjd1RDdwU2ppZWtrTnkzUjlGVEtGL0NKK003VEJQcnEz?=
 =?utf-8?B?SzN4eUVMU2dBRWZ3MzZaZENKdTJjbEhubFhBRG1sdlpmZkVUQVloWm5Nd1B2?=
 =?utf-8?B?YzN0UlRmQVMzNFllaVlYQnZabC94L1VFdVd6YTJwNGY0OUxJbGZpOFUrNVJC?=
 =?utf-8?B?M1A3UkFlejN6eUdYNXlqZktmSlU4bDhoYlVKc2l1b3pyNGkzaG8wUWYxWi9F?=
 =?utf-8?B?RWdGUHdlc3VCY3FNU1l3MjV4dW92SEFpL01CVFViLy8zTW5OWmRPNzNIOHh2?=
 =?utf-8?B?alZRTndQMmttZ3hiTWJaaElWcW8zb04vVURKZXNZQnMyODRPK2xhWGNhNytX?=
 =?utf-8?Q?o0qQ2Wa1qRvu6x2ox2b8bvM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0408f5b2-44d9-43e6-fe5a-08da6125dd70
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 21:07:28.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VoTbSjfd+uGk6qAgcfSKXdZASHXRb5HFBPxSpGTnGkx/YZJDP20r7S4JVLYDOUhvNNaMbFpbb06mFOeKJWlS4TV1V0CRk8/awxJ+cqkZCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_18:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080083
X-Proofpoint-GUID: cz6adxlhrxEbQl9Xbyz_sbwdR63Cleut
X-Proofpoint-ORIG-GUID: cz6adxlhrxEbQl9Xbyz_sbwdR63Cleut
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/22 14:38, Fabio M. De Francesco wrote:
> On martedì 14 giugno 2022 00:42:40 CEST Eric DeVolder wrote:
>> For x86_64, when CPU or memory is hot un/plugged, the crash
>> elfcorehdr, which describes the CPUs and memory in the system,
>> must also be updated.
>>
>> When loading the crash kernel via kexec_load or kexec_file_load,
>> the elfcorehdr is identified at run time in
>> crash_core:handle_hotplug_event().
>>
>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>> generated from the available CPUs and memory. The new elfcorehdr
>> is prepared into a buffer, and then installed over the top of
>> the existing elfcorehdr.
>>
>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>> the need to update purgatory due to the change in elfcorehdr was
>> eliminated.  As a result, no changes to purgatory or boot_params
>> (as the elfcorehdr= kernel command line parameter pointer
>> remains unchanged and correct) are needed, just elfcorehdr.
>>
>> To accommodate a growing number of resources via hotplug, the
>> elfcorehdr segment must be sufficiently large enough to accommodate
>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>
>> With this change, crash hotplug for kexec_file_load syscall
>> is supported. The kexec_load is also supported, but also
>> requires a corresponding change to userspace kexec-tools.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   arch/x86/Kconfig        |  11 ++++
>>   arch/x86/kernel/crash.c | 116 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 127 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 762a0b6ab8b6..e9eecff3b97d 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2082,6 +2082,17 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_MAX_MEMORY_RANGES
>> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU ||
> MEMORY_HOTPLUG)
>> +	int
>> +	default 32768
>> +	help
>> +	  For the kexec_file_load path, specify the maximum number of
>> +	  memory regions, eg. as represented by the 'System RAM' entries
>> +	  in /proc/iomem, that the elfcorehdr buffer/segment can
> accommodate.
>> +	  This value is combined with NR_CPUS and multiplied by
> Elf64_Phdr
>> +	  size to determine the final buffer size.
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 9db41cce8d97..b9cdf7a0d868 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/memblock.h>
>> +#include <linux/highmem.h>
>>   
>>   #include <asm/processor.h>
>>   #include <asm/hardirq.h>
>> @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
>>   	image->elf_headers = kbuf.buffer;
>>   	image->elf_headers_sz = kbuf.bufsz;
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
>> +	kbuf.memsz = (CONFIG_NR_CPUS_DEFAULT +
> CONFIG_CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>> +	/* For marking as usable to crash kernel */
>> +	image->elf_headers_sz = kbuf.memsz;
>> +	/* Record the index of the elfcorehdr segment */
>> +	image->elfcorehdr_index = image->nr_segments;
>> +	image->elfcorehdr_index_valid = true;
>> +#else
>>   	kbuf.memsz = kbuf.bufsz;
>> +#endif
>>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>   	ret = kexec_add_buffer(&kbuf);
>> @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
>>   	return ret;
>>   }
>>   #endif /* CONFIG_KEXEC_FILE */
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +int crash_hotplug_support(void) { return 1; }
>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>> +{
>> +	/*
>> +	 * NOTE: The addresses and sizes passed to this routine have
>> +	 * already been fully aligned on page boundaries. There is no
>> +	 * need for massaging the address or size.
>> +	 */
>> +	void *ptr = NULL;
>> +
>> +	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write
> access */
>> +	if (size > 0) {
>> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>> +
>> +		ptr = kmap(page);
>> +	}
> 
> kmap_local_page() is preferred over kmap() which should be avoided in new
> code (please take a look at highmem.rst which I recently updated).
> 
> Can you please check if you can easily avoid using kmap()? Otherwise, this
> code will be added to my (long) queue and changed one day or the other :-)
> 
> Thanks,
> 
> Fabio
Fabio,
I converted this to kmap_local_page()!
Thanks!
eric

> 
>> +
>> +	return ptr;
>> +}
>> +
>> +void arch_unmap_crash_pages(void **ptr)
>> +{
>> +	if (ptr) {
>> +		if (*ptr)
>> +			kunmap(*ptr);
>> +		*ptr = NULL;
>> +	}
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: the active struct kimage
>> + * @hp_action: the hot un/plug action being handled
>> + * @cpu: when KEXEC_CRASH_HP_ADD/REMOVE_CPU, the cpu affected
>> + *
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories. The new
>> + * elfcorehdr is prepared in a kernel buffer, and then it is
>> + * written on top of the existing/old elfcorehdr.
>> + *
>> + * For hotplug changes to elfcorehdr to work, two conditions are
>> + * needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. See the
>> + * CONFIG_CRASH_MAX_MEMORY_RANGES description.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + *
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>> +	unsigned int hp_action, unsigned int cpu)
>> +{
>> +	struct kexec_segment *ksegment;
>> +	unsigned char *ptr = NULL;
>> +	unsigned long elfsz = 0;
>> +	void *elfbuf = NULL;
>> +	unsigned long mem, memsz;
>> +
>> +	/*
>> +	 * Elfcorehdr_index_valid checked in
> crash_core:handle_hotplug_event()
>> +	 */
>> +	ksegment = &image->segment[image->elfcorehdr_index];
>> +	mem = ksegment->mem;
>> +	memsz = ksegment->memsz;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>> +		pr_err("crash hp: unable to prepare elfcore headers");
>> +		goto out;
>> +	}
>> +	if (elfsz > memsz) {
>> +		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz
> %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * At this point, we are all but assured of success.
>> +	 * Copy new elfcorehdr into destination.
>> +	 */
>> +	ptr = arch_map_crash_pages(mem, memsz);
>> +	if (ptr) {
>> +		/*
>> +		 * Temporarily invalidate the crash image while the
>> +		 * elfcorehdr is updated.
>> +		 */
>> +		xchg(&kexec_crash_image, NULL);
>> +		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
>> +		xchg(&kexec_crash_image, image);
>> +	}
>> +	arch_unmap_crash_pages((void **)&ptr);
>> +	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
>> +
>> +out:
>> +	if (elfbuf)
>> +		vfree(elfbuf);
>> +}
>> +#endif
>> -- 
>> 2.31.1
>>
>>
> 
> 
> 
> 
