Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28A567255
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGEPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiGEPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:18:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3CFBCA4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:18:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265EqF5e004055;
        Tue, 5 Jul 2022 15:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=403Xs3bUmSJAX1FiH2xuNgNFVftAMbb9LEywUp1y3Fw=;
 b=Hphs8Etju71wUTyELAo/2WH+ZmWlS97rEnLfc5NA+T3lZ3MYN5d1ZmAeyUx/2/tu+98u
 yiXaxLaGnPcR2u/wOMum4dHf1jxm35L+u/3YPzS51Xx91ZFP1A3Tq9igy+OSCE44Q4wP
 vcD/TI+wEiYu+t84+tVUt+antrLPrPkz6rwXP0bduI+T6Rg7/Pk6B4UM16yvdQ6YjN/Q
 tGh0JRN+i/lDrsAy19XGD8l9vyAuTQd9WB4XfyrB7DgfTEnIbWsr6rg9vycQYJuX/oYt
 xNDYR/qifsXTboyLMCmxA84N2VCKdCHMsBGVM1NCA0t12cr+kAQDmVuZ2E6C4oHGOSkS Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2cm0phg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 15:17:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265FFRsV021189;
        Tue, 5 Jul 2022 15:17:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf8hxr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 15:17:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPR4OiP8T7ub5xmt0W2FqP/e9tGWZOHEiRtw9k7sreL+ekg0ZoVVWl1PkCHaeWkH0Su4Z3Qa4dz0dqmp5P1d1sDgr/20yYHm6Y4tABNpdVo0ey4Dp9VoKmhJ7CvnH1h2esRZNL3F5dtd1T8UBcYRot4VoM0lS+3D5aYnDYlm2PO/fedYsJWj2gtolp+7VcUVSGgwNDDGvH9ckhjHWH32A83ZeRI0D0k/Ej8VqP5q7KoXwdd9JQ5/qSLkGc+IaHQLAvi74uu/gsk+vbIzxcR5VkLHKukLnVQIlIIFpW3qrfwxVear7ZtkvYGxNB8Jmcf0Ycf/DsnL4N1RzfgzBXDQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=403Xs3bUmSJAX1FiH2xuNgNFVftAMbb9LEywUp1y3Fw=;
 b=KFQXZ8YE886vip/NR7XZ7x4N2c8P0OgD7FD5alW+bHFySQiswvn6HnT+LNmkf7WVezdnCqDQFXOLzMvit9ZsrBUsvw1oVjh/qQWHG2o9yB91Sjc0UCbph8FcwlyBAAQvkGBQF/bKY4Q+/4LbJpuWa3VuDJqo8Cz+9uz/fLCnVkEKo63PBBMpcyctZBEvT0rGq1/bP0GNRM+M5yImGiDYPWwDaIRcqalf410/4iUU2g8fV9i2pqP4KIa4llDLsqZl/98ADTVuTUEn6xv8m9hsMVk/wow0ENMTfFggo6f2rQVSj+IAmYM6S78r9X92gQ2lX+lsiFZUtsKAL1Tx6lYDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403Xs3bUmSJAX1FiH2xuNgNFVftAMbb9LEywUp1y3Fw=;
 b=MdnVGmFtTIOc6KwmgRKK3Ppi5r7VWTMuKUdtHaNnmUwnngMLwbPokpfWUB7ddnJYGdlX0k/Q2v7mKO20VNzIILYKzUub36fc93vcTFDz2U6wOcezU2IweykNUmjvykaKi0YgDH6YqGZ6nR/2X1IjeyTMqZAJ3yg+qYF0Mm7I4fo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN6PR1001MB2052.namprd10.prod.outlook.com (2603:10b6:405:2c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 15:17:49 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::b50b:f334:e1ad:9e29]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::b50b:f334:e1ad:9e29%2]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 15:17:49 +0000
Message-ID: <51e85040-5622-dae2-dc28-f167660184f0@oracle.com>
Date:   Tue, 5 Jul 2022 10:17:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v9 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220613224240.79400-1-eric.devolder@oracle.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2b68d8-3bf5-49ac-322e-08da5e998563
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25aHi+/pavehOPhK71IYR97rf2B+Vj1HdJpYyqpLtkQ3ltheGfymzFObPQGlplngsIUx1pR/PPpzqiKqAWPfl1Mu/ybbt3AsmlAJI7aE9lmpmULw8sdxyI0SqVEL/ZufEtApiM56oNAf5LJWO20ggEPeljDIBtD9gFmed17HGDGw8LQScJ62uddxm0Z4JO09b0+vfJ6uByIc/y63m+7shWZ8nmeCEnHAjGj/dxzoMam7KEJXJ2Va5BPY9XcS/m8CssTIJCTDkO86EMenmBf3pDhPlewQ1guh3LigIemrHPq5zOImcrvoVFWFwl0jJRuaIuDgpMZsRxNB2L4RAOJQ1ZfivOzeEBYvAmm2ktgRs/kYxJdsdbxxMvze56K6tzQ5oQB9c1zNDX3lZuRcB9m6fM727Pgd7MlyHqrhPHtMZIWHGRv70KE08M5yRXqgClbBN6QZZz0ft544TAjrrIL9Bn7zg3n80us8sttmm1nBZoa5eUDf834kJ0v6/qxb3/gpMqcaYxlAdGIKB45Ab/KSd4DEcmG0dskpLRXOFyTdmUQOODrCJGXsLeWcqTs4+groTwS5BnqpvmfxVvSC8Lg43Py62jfVORA+FbFM/IFkyG3BebtJy4ZiCQ27kjLZytTGuhqFa3HPzH6rka1Ln7UO7u3JuA8kWNVdC7bxDDjg7orBGgkO3n8NSPlLklOoJ+Gle6jw/fLvWucFA3GO4MjGc/yvslX3zHojPC2tZcjAbFySjQPnMLD1wYzw9ZQguUrmiIilknVFErJPQ9rKt1sIEOpsp4oJxly0SkcrX4B8vD/pMwIdrMo2oEcl/CvNGJJbq1jY57rHgoIjFAWQX4JpqYMYDhHYXPmVg2zYdePjCSEeTNTHNRZyygWnX3NdOMTOckoRPfy1Hr+CG2STgfcs6QpV0zAPycERub419+VYRg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(376002)(396003)(346002)(39860400002)(83380400001)(30864003)(86362001)(31696002)(8936002)(38100700002)(107886003)(6666004)(7416002)(31686004)(4326008)(66556008)(8676002)(66476007)(6486002)(66946007)(316002)(2906002)(53546011)(6506007)(478600001)(5660300002)(966005)(2616005)(36756003)(41300700001)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1RbDJXM1hlSENKSjZrU2JNd1BrNUlvK0FsZ2pEQXA3eVJVUW4yamc2UW5B?=
 =?utf-8?B?Szh5Z1NFU2g5NTc3K3BJTkswZENkZjFnTGNxQ1hFSm52cXNhOFRzWWdjYnBQ?=
 =?utf-8?B?b2orZ0Uvck1NRCs3WnRFU0w0UjBRY0xFQ3ZkclhRMEZ5SytjUDVaTU1maEt5?=
 =?utf-8?B?UnUzeFV4Z2Z3OXdBMGF5dGx3SG1RQXlwUXlwMzIxWVNtdXF2RmdnZ29GM2Jm?=
 =?utf-8?B?WEVhTGMxeTBHQkRBWEdYemU4VGFSMlFBSm5nSG8ySTV4TWtINDlGOGdYc1B1?=
 =?utf-8?B?ejNWNlk4ay9zWnhsdVVZVm1Gb09pR1A5VUp2REZ2ZGVHQ3d1VHpBQUpOMGZH?=
 =?utf-8?B?amViTUZVMjNWRFlKWmlqcG4xYy9sWkNvUXVoWjllV3JMOVprL2l5TVl1RjJX?=
 =?utf-8?B?RDZhcTkwQ0xrZXlTNlZLRXpNTVdSeUl4V1RTdzFhYWhrVjgrRndoSjEvV0Zn?=
 =?utf-8?B?TjRoN3ZSTHhkblZ2ejBEVms3RnBVVkJhRGJaNk1LT0MvY2E1eWpmTDc2YlpV?=
 =?utf-8?B?MUtZRFFMZU9Rb1ZCYXM5T1RpenRiUU5ZSGNrbDBES0xicmJtTGUyUmpIcC9a?=
 =?utf-8?B?MVY2TGE3TjBFNUtPVmJ0MDJqYWRDUzdiSnlUNklPV2VTMkQ5ZWpvNU8vN0lQ?=
 =?utf-8?B?UCtkaVlSbmpqV203ZVBKbHk0c2NCTzV1QTlBUmFLNTQzMkVZb1BQTmZDeW1x?=
 =?utf-8?B?Ti9KQlVCZURsTU9tRkxxYVRUQ1NQTFkvdHdCNWpHdkpiMitMTytlU2dXZzdP?=
 =?utf-8?B?Tkx3SnRqa1poZmVjdUtkZVZWd3NWZG5BRS83cVh4cmxWV1YvTGFmZ2lidUs1?=
 =?utf-8?B?N0RtTnV6ckhaaUNSRnJOYWdSVDlqSVh0OVcyMzdQa1F0RWFNM01uaC9YU0hr?=
 =?utf-8?B?VlpHczB0dDF0VFhFZDNrYlRuQ2lZemtrUFE4bU1VMkFPcWlCTmtKRitjUlhD?=
 =?utf-8?B?cmdmSHB3YVp2K3JVMytwQ09zdTNKZDIvN2VZMituakQ0VUVXTmZNY1hoNU9Z?=
 =?utf-8?B?VXdTRFFMZGUwMjhEKzNTSlFUNWhXR3daYU8vUnFNRXV4dDJoU1h5TXF1WHRL?=
 =?utf-8?B?WnVUQ1JFMFBTQjg3aWFlME5sdlRtNW5rVW9haCtxREQ1Zi9RZU9ML1Z1QUdS?=
 =?utf-8?B?U2RwZDc4MkgxcDhtUVFTQWwwWVQyaytrWjhyVWZvSHQwM2dOQi9wSEpiQ1Vq?=
 =?utf-8?B?dEVZQ01qY1pJV0Z0YVZCOGd5RkZVZm1rb1RZNC9mWnVjeGdkN2FrNmluTXgz?=
 =?utf-8?B?R2puRU1Bb2doODZERFVtZDF2ZmJhRjA5cm1XSkNVNUJSNjBVN0QrSzVqYWMx?=
 =?utf-8?B?U2R3Vk53dzNXbGRGRTdxMjRTN2pmS1B4b3I1azB5eE1kalpFajdFQ0wrYm1a?=
 =?utf-8?B?OTJCUEJnb3B5QlEwV2pQWHUzK2k1VE1Id1dqbklUVVpsMkFIK08wNUozNjU4?=
 =?utf-8?B?cjJEWUNSUTczTnhFbUo4cGMvYXAyc1VBOVd2V0g4aStRMFl2bm8zbXkzbUxN?=
 =?utf-8?B?bFhZV2tpN09hWHJHKzlSbER6SkM4Mmg1NWtwTzlMQWd5cHR3bElaNWhNa1Z1?=
 =?utf-8?B?bUVvUTZxUC9ZaW8wSWR0elZSVmUrL3ptN1Z6eWZndVdhUnFyYmlOR2VBMTEz?=
 =?utf-8?B?RzNzZjBJUnN5aVlDKzRGU0NzWW9wa3JwWk95TVlldkI0cGtlL1B6dnZpSHpi?=
 =?utf-8?B?Z0dWS0VaYVJPNWpGUXZ4OERSdFBIbk05eXdCQzJHQldVVzdQQXUwVWZlQjV2?=
 =?utf-8?B?RG5mamZtUHgxckdPRG1kNFVtSVJTY0Fja1VXZ3RBbWlSM3V4a3hPYmhraStr?=
 =?utf-8?B?OEJYcThHUEZUdnBnTGgwVk5SamZzcVAzcjdlNnlUSGpEQk8wTThYeUl0SXkw?=
 =?utf-8?B?VDJmLzBNckIvZWhOVm9RSlhrWTFEeCs2ODh1VUQ3WkVTMmcxQmNwVU5pbEdZ?=
 =?utf-8?B?aW14bFBOK2tNdjFOTkU0emswV25yVi9qRHB3cWZtR0E1YUl1V1dIYzNTdnRq?=
 =?utf-8?B?UXF2MEZFYUl3U0p3blhGdHBXRytKbmdSczg0U28xYlBTUmQzelZ0L0FER1Bu?=
 =?utf-8?B?b1h5UXhDdS9ZMzJPaUp0VEN6RHVpK0x5ZmhLdUl0azNRMTFJYnN1d2pHOVV3?=
 =?utf-8?B?aW85SGlJTk9VbXIvTjNHRXNTWE16V092QTZqUjBPYnR1ZTlMNDAyb3dWTXdt?=
 =?utf-8?Q?OLYs6fDfFg2RGcFK1rpbaxE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2b68d8-3bf5-49ac-322e-08da5e998563
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:17:49.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tnvwIS4L+4XbffKsYYQHV+RN27tANKjFBcXHyHluPm698VzbmMu46MYmgeYm57SqRNR+rZ6OXoN+S/dP9XoFlcTqfSD9FJ3LLcHUL9NXKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2052
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_12:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050066
X-Proofpoint-GUID: D2ZliUnKpxPxQHIQTzjYfkLzYyecYbR5
X-Proofpoint-ORIG-GUID: D2ZliUnKpxPxQHIQTzjYfkLzYyecYbR5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nudge...
Thanks!
eric


On 6/13/22 17:42, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>     Add the following as the first lines to the udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:
> 
>     # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>     These lines will cause cpu and memory hot un/plug events to be
>     skipped within this rule file, if the kernel has these changes
>     enabled.
> 
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load syscall.
> 
> This patchset supports kexec_load with a modified kexec userspace
> utility, and a working changeset to the kexec userspace utility
> is provided here (and to use, the above change to standard_kexec_args
> would be, for example, to append --hotplug instead of -s).
> 
>    diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>    index 9826f6d..4ed395a 100644
>    --- a/kexec/arch/i386/crashdump-x86.c
>    +++ b/kexec/arch/i386/crashdump-x86.c
>    @@ -48,6 +48,7 @@
>     #include <x86/x86-linux.h>
>     
>     extern struct arch_options_t arch_options;
>    +extern int do_hotplug;
>     
>     static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>     				  struct crash_elf_info *elf_info)
>    @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>     	} else {
>     		memsz = bufsz;
>     	}
>    +
>    +	/* If hotplug support enabled, use larger size to accomodate changes */
>    +	if (do_hotplug) {
>    +		long int nr_cpus = get_nr_cpus();
>    +		memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
>    +	}
>    +
>    +    info->elfcorehdr =
>     	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
>     							max_addr, -1);
>     	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
>    diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
>    index b8bb686..5e29f7a 100644
>    --- a/kexec/crashdump-elf.c
>    +++ b/kexec/crashdump-elf.c
>    @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
>     	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
>     	long int count_cpu;
>     
>    -	if (xen_present())
>    -		nr_cpus = xen_get_nr_phys_cpus();
>    -	else
>    -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>    -
>    +	nr_cpus = get_nr_cpus();
>     	if (nr_cpus < 0) {
>     		return -1;
>     	}
>    diff --git a/kexec/crashdump.h b/kexec/crashdump.h
>    index 18bd691..28d3278 100644
>    --- a/kexec/crashdump.h
>    +++ b/kexec/crashdump.h
>    @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
>     			   unsigned long long paddr);
>     
>     unsigned long xen_architecture(struct crash_elf_info *elf_info);
>    -int xen_get_nr_phys_cpus(void);
>     int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
>     int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
>     
>    diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
>    index 70fb576..f54a2dd 100644
>    --- a/kexec/kexec-xen.h
>    +++ b/kexec/kexec-xen.h
>    @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
>     #endif
>     
>     int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
>    +int xen_get_nr_phys_cpus(void);
>     
>     #endif /* KEXEC_XEN_H */
>    diff --git a/kexec/kexec.c b/kexec/kexec.c
>    index 829a6ea..3668b73 100644
>    --- a/kexec/kexec.c
>    +++ b/kexec/kexec.c
>    @@ -58,6 +58,7 @@
>     
>     unsigned long long mem_min = 0;
>     unsigned long long mem_max = ULONG_MAX;
>    +int do_hotplug = 0;
>     static unsigned long kexec_flags = 0;
>     /* Flags for kexec file (fd) based syscall */
>     static unsigned long kexec_file_flags = 0;
>    @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
>     	return 0;
>     }
>     
>    +long int get_nr_cpus(void)
>    +{
>    +    long int nr_cpus;
>    +
>    +	if (xen_present())
>    +		nr_cpus = xen_get_nr_phys_cpus();
>    +	else
>    +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>    +    return nr_cpus;
>    +}
>    +
>     static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
>     {
>     	char *buf;
>    @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
>     		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
>     			continue;
>     		}
>    +
>    +		/* Don't include elfcorehdr in the checksum, if hotplug
>    +		 * support enabled.
>    +		 */
>    +		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
>    +			continue;
>    +		}
>    +
>     		sha256_update(&ctx, info->segment[i].buf,
>     			      info->segment[i].bufsz);
>     		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
>    @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
>     		case OPT_PRINT_CKR_SIZE:
>     			print_crashkernel_region_size();
>     			return 0;
>    +		case OPT_HOTPLUG:
>    +			do_hotplug = 1;
>    +			break;
>     		default:
>     			break;
>     		}
>    diff --git a/kexec/kexec.h b/kexec/kexec.h
>    index 0f97a97..b0428cc 100644
>    --- a/kexec/kexec.h
>    +++ b/kexec/kexec.h
>    @@ -169,6 +169,7 @@ struct kexec_info {
>     	int command_line_len;
>     
>     	int skip_checks;
>    +	unsigned long elfcorehdr;
>     };
>     
>     struct arch_map_entry {
>    @@ -231,7 +232,8 @@ extern int file_types;
>     #define OPT_PRINT_CKR_SIZE	262
>     #define OPT_LOAD_LIVE_UPDATE	263
>     #define OPT_EXEC_LIVE_UPDATE	264
>    -#define OPT_MAX			265
>    +#define OPT_HOTPLUG		265
>    +#define OPT_MAX		266
>     #define KEXEC_OPTIONS \
>     	{ "help",		0, 0, OPT_HELP }, \
>     	{ "version",		0, 0, OPT_VERSION }, \
>    @@ -258,6 +260,7 @@ extern int file_types;
>     	{ "debug",		0, 0, OPT_DEBUG }, \
>     	{ "status",		0, 0, OPT_STATUS }, \
>     	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>    +	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
>     
>     #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>     
>    @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
>     	int buf_end, int phys);
>     extern void arch_reuse_initrd(void);
>     
>    +extern long int get_nr_cpus(void);
>    +
>     extern int ifdown(void);
>     
>     extern char purgatory[];
> 
> Regards,
> eric
> ---
> 
> v9: 13jun2022
>   - Rebased to 5.18.0
>   - Per Sourabh, moved crash_prepare_elf64_headers() into common
>     crash_core.c to avoid compile issues with kexec_load only path.
>   - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
>   - Changed the __weak arch_crash_handle_hotplug_event() to utilize
>     WARN_ONCE() instead of WARN(). Fix some formatting issues.
>   - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
>     and CPUs; for use by userspace (udev) to determine if the kernel
>     performs crash hot un/plug support.
>   - Per Sourabh, moved the code detecting the elfcorehdr segment from
>     arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
>     and kexec_file_load can benefit.
>   - Updated userspace kexec-tools kexec utility to reflect change to
>     using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
> 
> v8: 5may2022
>   https://lkml.org/lkml/2022/5/5/1133
>   - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
>     of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
>     is not needed. Also use of IS_ENABLED() rather than #ifdef's.
>     Renamed crash_hotplug_handler() to handle_hotplug_event().
>     And other corrections.
>   - Per Baoquan, minimized the parameters to the arch_crash_
>     handle_hotplug_event() to hp_action and cpu.
>   - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
>   - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
>     to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
>     by David Hildebrand. Folded this patch into the x86
>     kexec_file_load support patch.
> 
> v7: 13apr2022
>   https://lkml.org/lkml/2022/4/13/850
>   - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.
> 
> v6: 1apr2022
>   https://lkml.org/lkml/2022/4/1/1203
>   - Reword commit messages and some comment cleanup per Baoquan.
>   - Changed elf_index to elfcorehdr_index for clarity.
>   - Minor code changes per Baoquan.
> 
> v5: 3mar2022
>   https://lkml.org/lkml/2022/3/3/674
>   - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
>     David Hildenbrand.
>   - Refactored slightly a few patches per Baoquan recommendation.
> 
> v4: 9feb2022
>   https://lkml.org/lkml/2022/2/9/1406
>   - Refactored patches per Baoquan suggestsions.
>   - A few corrections, per Baoquan.
> 
> v3: 10jan2022
>   https://lkml.org/lkml/2022/1/10/1212
>   - Rebasing per Baoquan He request.
>   - Changed memory notifier per David Hildenbrand.
>   - Providing example kexec userspace change in cover letter.
> 
> RFC v2: 7dec2021
>   https://lkml.org/lkml/2021/12/7/1088
>   - Acting upon Baoquan He suggestion of removing elfcorehdr from
>     the purgatory list of segments, removed purgatory code from
>     patchset, and it is signficiantly simpler now.
> 
> RFC v1: 18nov2021
>   https://lkml.org/lkml/2021/11/18/845
>   - working patchset demonstrating kernel handling of hotplug
>     updates to x86 elfcorehdr for kexec_file_load
> 
> RFC: 14dec2020
>   https://lkml.org/lkml/2020/12/14/532
>   - proposed concept of allowing kernel to handle hotplug update
>     of elfcorehdr
> ---
> 
> 
> Eric DeVolder (7):
>    crash: move crash_prepare_elf64_headers
>    crash: prototype change for crash_prepare_elf64_headers
>    crash: add generic infrastructure for crash hotplug support
>    kexec: exclude elfcorehdr from the segment digest
>    kexec: exclude hot remove cpu from elfcorehdr notes
>    crash: memory and cpu hotplug sysfs attributes
>    x86/crash: Add x86 crash hotplug support
> 
>   .../admin-guide/mm/memory-hotplug.rst         |   8 +
>   Documentation/core-api/cpu_hotplug.rst        |  18 ++
>   arch/arm64/kernel/machine_kexec_file.c        |   6 +-
>   arch/powerpc/kexec/file_load_64.c             |   2 +-
>   arch/x86/Kconfig                              |  11 +
>   arch/x86/kernel/crash.c                       | 119 ++++++++-
>   drivers/base/cpu.c                            |  13 +
>   drivers/base/memory.c                         |  13 +
>   include/linux/crash_core.h                    |  12 +
>   include/linux/kexec.h                         |  14 +-
>   kernel/crash_core.c                           | 241 ++++++++++++++++++
>   kernel/kexec_file.c                           | 105 +-------
>   12 files changed, 456 insertions(+), 106 deletions(-)
> 
