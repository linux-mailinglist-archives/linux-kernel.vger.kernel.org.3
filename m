Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC516589DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiHDOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiHDOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:42:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C187248
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:42:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274EbpVF019258;
        Thu, 4 Aug 2022 14:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w7FoEfS8Ealk7mxoy0r0sBlV1ctEAqZmtZDR85QbX8A=;
 b=MoXFeJmtowPCcuh9imB5BLqh/akOjcKR6tSvIZHP/UL1Ry4flkldRRW2ms5kpAUHwo0r
 QeyvsRt2/aDL+7fZ/zGycyxab7VcT9eyz2SOUwPuusdnqFNynooyaKlqwHBYJBfHhfqO
 p1pq39VsF/2tgIvfqUPducSgsHxs4XmzLJ/PZ6Bdksb6fDEqcnKo42kMeUlku5Ofqcbi
 +rp4EXC8o+1FHKkB2ivhlERssDfXMgGXp90uLRuGZuClTGLm6yB5+6LvkrBE+NNocyXL
 nZCZhLbWLsdJhX+ln+97OOZsLP2Yk18u+z1e78whJyLZ5zOC9q9XmkUgyN2aA3ZS+8c8 Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2w8ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:42:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 274EU8Zd003049;
        Thu, 4 Aug 2022 14:42:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu34c8y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 14:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8Qq8VwCCS/9kSeo4Mdi6znMh6U4LZ4Trx6wHhntFgNxdSsysp9B3ySVSQpM947uBSyLVrkFlYfdvqUunbWfz3X4zxkDNVfSOODG934J0FPhRZoCTBJnEXp0ms3ttsjcJo9w8O+3eUZMHYUnUakLsxJWFqYG4L7RlzRcG+mdEDtk9No0/qL86IaFCoe+dlb3FONLuyrmu9BkC0MYv/u5PRk1yGeQ+keJGF9Wf4DZDFOi8ZYVEDzkSaIixQ8w0W5kFYYc+3IfGziI3zLqNA5/IPE95oTFarKIbhlKVOqdeInQz1MFieexOPu6GzwxTsdq3rN9U1E/8pXkPDp8WcfU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7FoEfS8Ealk7mxoy0r0sBlV1ctEAqZmtZDR85QbX8A=;
 b=e883wuyxy9M3nYeTzbBk7Lp6KZ+X8UyNJr+foHCB53CR8DiQhgxdizDvuDpO4WrhjxiI9yOyVuez58gFjdmvwqYODNaSBzIWVACuWHFKNB4iSFuGFx2+/3AYAprsU7G0B2QNdCX3kY9ByMSnPpF4tIJ1Maui9W6o1FnyjIsxS/Ww3gqcCzKsKpdWcdPjutVMWu+fSed7Fqh6xbOohb0HBvvkAxlgfgL+uToGef5CIwtrHdBnjmy8+2SnOhshHf9AYz7KBhB8o6YqYGyrmyKt5GPbcD09X6XGklyYFLeEvrNML/kZ8+uBsQfD6zxi1W4993gdYLj6CrJ53Nm+MJLvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7FoEfS8Ealk7mxoy0r0sBlV1ctEAqZmtZDR85QbX8A=;
 b=x2WVBssMpavF3hRjVsx3qjBv9BA1C5VjWzVO1drLTAesz60CnFClAfy7SQiPJhizXiyPn+laH4iZVdqAONk4ayEr8VwRl0r9QHiP2SCSl0jhurIzuwCqvUF3ozC9pbndQRhH8EmqeHtqbT1nxcRlS1vFRq1eV4tLsxzZg/JQXoQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SA2PR10MB4697.namprd10.prod.outlook.com (2603:10b6:806:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 14:42:12 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%7]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 14:42:12 +0000
Message-ID: <4776c08c-fd67-3d0f-8130-4b5e1a3a8256@oracle.com>
Date:   Thu, 4 Aug 2022 09:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 0/8] crash: Kernel handling of CPU and memory hot
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
References: <20220721181747.1640-1-eric.devolder@oracle.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::24) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca30dfa-f1f6-4e1e-d330-08da7627840d
X-MS-TrafficTypeDiagnostic: SA2PR10MB4697:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9q2TF5+8B6ShZKpRC6mRkN1eRRqUa2P6kRpAifL43Jt219i0MfgApGk2jl6Ogrrp1GdObiLpT72ClXxjs0ip0knpsuZ+mqlnVUx3b5phJ6H/flLmVlUbl1Pp+tGjMBGkT4uA5bMZrAXm+4xiHxi5cXzPqgzVg/ImrXSwRXOF+HsRDO5OQeq07q9LYb2kd925G/1fPXiy4N4Qqq/IrW0ChvSe8EFv0i6ok+31Vxt4BasNvyGdGErNDDyL214HYAPmcpvumX8hC8f/Ls8RWp/NODrfiEaO00dWzflMbACQ0WFpvv78MXnJIMlVM67SUO9vQihtNyrcvd7WQCJdm7WCr/GGSkgMQJA1wXOZ9kYFOz2y/Ph9iHV3+iZL/ezetmTfczg6KBI42qYNAhsMgvzg+Lxp/vACqNz/JHMp1Y+l+2uFUC+UeF3uOIJ6OaEy+5p2WeGEkTkKVr+4y8Khm8T0zArGYmo90Gcfqmtqc6mt5QOwXeql7cWiA+2vtL7gKtWaWTeML4BHWRAptQLTOvyf/zVSTB56cPqcY2Jufx3Ocb5YvhmrBkBuOKU7mYrgt0hLH6PLqtVfrsKTudvoyQOX7jB/m925I466Q5O9HReWf0NBguDkadMNyLBVLyPM89RV14JGMCKPGCyFc3De5aPl0DDQaNw2knyZquccPoTB+LLCgPsJHV2ksLaIzOSb9s+Mf4f+x6jSIWTL//nQEstYjJ7bvGPfq9MV8jHh8elw8RNvxPNfohHlhwV5HEzkHUmvMTVrArh66AtZqFMjeVfchiqiQ3fm66Mw+teJ7JWU4a+yRsUV+dJIOjDWt7LegWdpyOj20Y5GQCPHXazuQmZ2IuIn63fP059sv5ngiCJI2MWbG+Xk2Rs2E2eAuQgW61/+OYRhrrwByazerEMRFajXxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(39860400002)(346002)(396003)(30864003)(966005)(6486002)(5660300002)(7416002)(478600001)(8936002)(316002)(66556008)(66946007)(66476007)(31686004)(36756003)(8676002)(4326008)(41300700001)(6666004)(107886003)(2906002)(6512007)(2616005)(186003)(53546011)(6506007)(83380400001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3A1NHUvN1J0dFRmbVFaNzVhWENUUWFxVkdGcGo4THpKbFVlcHZ1dVEreklv?=
 =?utf-8?B?enJ1Ti9nenM1UHltUUNYWHNhK3J6WXFIbjgyVmpHYlhIRmpzTXJ6emJHSm9o?=
 =?utf-8?B?SStnYzM5ekhYU2VvditwU1lFL3IrcEhuamk1QzBNUlNjbTEvY1ZQVFVpdXhP?=
 =?utf-8?B?VnM5bVRJc1cxQmxRV1NOWktYbjlVSEcvcTYybnVoV2xjdi9DUmMwVFFXTEpW?=
 =?utf-8?B?UjAzc2YxOVVnbEJwNG1QQkpDZmJGTEJDT1FqWUpTNGhkVWdyTzQ1aCsxWU02?=
 =?utf-8?B?b3VBMUphckk1WHAyZWFVVGk0UmhBOVFYejRFTGh5RXdTamIvWm9lZ2ZJN3lj?=
 =?utf-8?B?cytOWmNQNysyMkZ1Yy9VczBmckxjdEJsUjdRYjc0ZUxPZ2ZRTEdsNDVvOWVh?=
 =?utf-8?B?T2F5bG94R0R3NGt2TDZXeHRXbHlMMW90WWEyY2NFbnd0b0lGai9LMktiRVV6?=
 =?utf-8?B?aHorN0VyN203R3ZKbWxZc0xoSFEydmJEYkRTK2VVRDFJVGVYZFFwazdmdWR5?=
 =?utf-8?B?Wk45aXUwN1B1bFpHQ3hYSmllZ2dKUHNqVkR4K0pTYkRZMjlzMW5NajN0QlR0?=
 =?utf-8?B?RmpnZWZnWDNiNmdXNXdWdDd3cG4rT2d2cjRxYWxPMnJpU0lwYWZwT1FHQ2hK?=
 =?utf-8?B?OUpYYU1Md05IOTdpVG9GRTVaMml5WUlncUEvdG1yUUJYbS9KRXhWVm5nbUs4?=
 =?utf-8?B?U3Y2bkIwRjJiNS9VdFBZN01pcE5kSmFPWmxGUmtJaUYrN2luMW80Q0YxMDVB?=
 =?utf-8?B?cms5a3E0WTJOWUdsa2lDK3RiSGJvdGRTMnpxT2NocXJEZ3VTcUZLU0VBQStz?=
 =?utf-8?B?blVVTUpQZ1hkYVRBT1RNWUQzMCtyc3ZuL0w1Tysxc3dIS1JURUtUcnQyM1dx?=
 =?utf-8?B?WjVIYldidlFyRlNBMDBFYlVNVG95MFJqQXA5Wk5JazNtcVFJMlBKVTJHVXQv?=
 =?utf-8?B?TFhybEVRRHhTSktmUWNtc0lYeUNwb2ZCVXhqdTFwcjllbHFsNWh5UlE1UVk1?=
 =?utf-8?B?eFVrbkFUZXVFOCtub1lBY0ZlbXdGTTFCZG1PUnJWQzQzWTNuM0dHRThIbDA0?=
 =?utf-8?B?Z2RkVTB3OTk2emFZMHhkaCt3VTRjVVRrQ004c3l2Uk4xdlJtZmp2YjRDY25u?=
 =?utf-8?B?d2JWVXo3Y3laMjBDVHBLSDMySW5vWGJldlBSckRaS2U4MUVwTldFK3FSb25p?=
 =?utf-8?B?eFMxV1o4UXVxdFhkaVZZb0krMVhkK3VwSS9MQi9mRDYwMEdMK3FMeTFsYXZr?=
 =?utf-8?B?MXpSN0E2SHdEcXI1VDFaNDJDb3l2Wmdhdmh3SUdLN0ZKaUZXeDVuWlpKRjVP?=
 =?utf-8?B?Zm9aR1pwT0pCY1l3bUNSQ0VxN0I4aEpQTS9mUm9oYWw3aURGVUZPd0cwVkpZ?=
 =?utf-8?B?Y3NYV1N2TEN3RlI5dCtVZnljQXpPMFVtSzgvV29maGNJcFNBV0FkODJnUmRX?=
 =?utf-8?B?Ymc5MmtYTS9NVHkxa0ZnVExidjJPbEtTbUVmeUJReFFUdDRFOVVwY3FCMVE5?=
 =?utf-8?B?N2pPaCtEdFZYMlV4RitXSTgrdjBwbWR4NU1PbFZuYmtPUHJ2Y3ZvOUdDV1BR?=
 =?utf-8?B?cUNRVDdETHplZDNOMjNUbHBNK1hUYXI5cDNOL2hZOFh5WVgvTmxxSkZtWndw?=
 =?utf-8?B?eDhyU0FPdjQzUXc4M1I1WnhDazhlSUJMR2wxQVowLyt0S1YyWWdGb2lNMGpx?=
 =?utf-8?B?a0VhVFlISDA5c1Z4YzJ6eERIRGNJRXFsTEowSURiaGhZa295QVk5NHhGa25N?=
 =?utf-8?B?bGZTUFRrc29TQkJ1dWppQXRZN05GTjJEWmVWNjZGZ2xZVVlwcFRwN1daemxC?=
 =?utf-8?B?Z21oa2dpcmlWeU5qd3NVa0VxTzRBNzExZXd2MExvd2UyRnBqVHVqUGU1TUR0?=
 =?utf-8?B?aFg5Vjl1SGNtMGgzQzJlVkxkK29NdElWL1VWa0VZaHZjMkYwYVFLZTc5OWlv?=
 =?utf-8?B?bGRNVnRwRGhxQjR0eWw4YWhiaE5UMkoyc041WDAwMkE1a29PSmRHVW5rcW5r?=
 =?utf-8?B?U2tmb1crQTd4OWRCKzUrR0tQT2lPZHFrVkM1b0x1NlpqWEh1MFJldkN6Mm85?=
 =?utf-8?B?dnZiNGlHeVNITUJOaFhIc2dKZHN2blpoaE1yaFlqWjZGYU8zTkVuem9GaGl2?=
 =?utf-8?B?elUyQlMvQWQxVHRuS0h6SkZwZGVqU1hNMkM3Y2NRUU00Ui9Ha1J6YWhNVjFK?=
 =?utf-8?Q?Pl/JKNWdrUWT0tKMdZvSq+M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca30dfa-f1f6-4e1e-d330-08da7627840d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 14:42:11.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db/s4qPU2QZCIvP4MacEarbmpCD39DMWtIZ+ej9Ufm86l7MUARMTkRdqD7KCskQ05hm9T20bXgFaEMrafAnnIKfnANLHPgiNuhfunlQ4wcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040064
X-Proofpoint-ORIG-GUID: vMp-oTd9Pr6d88VT9QZTokqmguApPHgj
X-Proofpoint-GUID: vMp-oTd9Pr6d88VT9QZTokqmguApPHgj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nudge...
eric

On 7/21/22 13:17, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
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
> v10: 21jul2022
>   - Rebased to 5.19.0-rc7
>   - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
>     for architectures not supporting this feature.
>   - Per David Hildebrand, removed the WARN_ONCE() altogether.
>   - Per David Hansen, converted to use of kmap_local_page().
>   - Per Baoquan He, replaced use of __weak with the kexec technique.
> 
> v9: 13jun2022
>   https://lkml.org/lkml/2022/6/13/3382
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
>   - Updated the new proposed udev rules to reflect using the sysfs
>     attributes crash_hotplug.
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
> Eric DeVolder (8):
>    crash: introduce arch/*/asm/crash.h
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
>   arch/arm/include/asm/crash.h                  |   5 +
>   arch/arm64/include/asm/crash.h                |   5 +
>   arch/arm64/kernel/machine_kexec_file.c        |   6 +-
>   arch/ia64/include/asm/crash.h                 |   5 +
>   arch/m68k/include/asm/crash.h                 |   5 +
>   arch/mips/include/asm/crash.h                 |   5 +
>   arch/parisc/include/asm/crash.h               |   5 +
>   arch/powerpc/include/asm/crash.h              |   5 +
>   arch/powerpc/kexec/file_load_64.c             |   2 +-
>   arch/riscv/include/asm/crash.h                |   5 +
>   arch/s390/include/asm/crash.h                 |   5 +
>   arch/sh/include/asm/crash.h                   |   5 +
>   arch/x86/Kconfig                              |  11 +
>   arch/x86/include/asm/crash.h                  |  20 ++
>   arch/x86/kernel/crash.c                       | 117 ++++++++-
>   drivers/base/cpu.c                            |  14 ++
>   drivers/base/memory.c                         |  13 +
>   include/linux/crash_core.h                    |  32 +++
>   include/linux/kexec.h                         |  14 +-
>   kernel/crash_core.c                           | 233 ++++++++++++++++++
>   kernel/kexec_file.c                           | 105 +-------
>   23 files changed, 537 insertions(+), 106 deletions(-)
>   create mode 100644 arch/arm/include/asm/crash.h
>   create mode 100644 arch/arm64/include/asm/crash.h
>   create mode 100644 arch/ia64/include/asm/crash.h
>   create mode 100644 arch/m68k/include/asm/crash.h
>   create mode 100644 arch/mips/include/asm/crash.h
>   create mode 100644 arch/parisc/include/asm/crash.h
>   create mode 100644 arch/powerpc/include/asm/crash.h
>   create mode 100644 arch/riscv/include/asm/crash.h
>   create mode 100644 arch/s390/include/asm/crash.h
>   create mode 100644 arch/sh/include/asm/crash.h
> 
