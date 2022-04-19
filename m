Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739A4507C46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358129AbiDSWCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiDSWCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:02:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF140E5A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:59:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JKOc7K012445;
        Tue, 19 Apr 2022 21:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=30tZRumLn9/VcNc0u7CPD+TgwCF/Ta5+52348gc7Nvo=;
 b=tYIlT58hsmZUWIj2qIWmU1o0pT7u2USrEjcw+hZk5IMw6MAcc0x8Rxw5CHqr4w3n7akk
 hYOrtJMCihP7yZjrUCNRo/u3QAxuEDhYYcd0Z/l3POm6bMjyafFUBZPWdXH2yzX045Q/
 H/SiYAw0HUzjyIcipH5bttqChCSFK9+oNKdKpTasx/b5MvZv0sXcDyns8878F2wVZhlJ
 t0afqBoenz9YdO0SggJOpa09tlUhcnb+Fy/7et69qdVcFoAacHbBywGNlOd1CbZXteHp
 sOKZX7hg6Lvt8ngeXvd0FAeJ4YSDRr/HI8jc2x8ooyqQoq44eUqNLaHLm0pkb/lr6YhP yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv7dyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 21:58:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JLtjTb031003;
        Tue, 19 Apr 2022 21:58:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8353xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 21:58:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKBJ8qyCl9rcW4PKQnIwJGdxlbCJrOhHFASpuYsjQPL0I4UMEi6O1nueNEr7dzpj1M3PjU508FJVc+jIxO1IjThoR2ungJKfqlOZOnoiGRQeViEBLUjUu+gzaG5t7h3082ZsImmH96Kg4vZAUDFVky3PRT03T/Vi29GnaCkp1QqRXvACFOUCU3Q2dfbxNOxe6OpoxFfcKugiRxu4e07kK1e47XeGfZVVvMaui8WS8r66uJLUnGkd62PfjvgMdPMS66G3DitXIicWbiBSANMryPPSPM+J/OIgS0sJlR3WNm1lTLOyvu7EJZGTzaUpRG1ReVpDuuKatUpQhyzm7xk1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30tZRumLn9/VcNc0u7CPD+TgwCF/Ta5+52348gc7Nvo=;
 b=DaY9GVJzZ2Lzkk4+VHE4DqL5BQrq7RbvDcD+aDANij/Nzth3x4MsE8HdzsS6PNFmyn1oFp2Y1eONusQFIva8xYlaVtcZL/A5emqIsDJJLrrllYO4hyAEzW/iM62V72O2DenF+cxNZGoRzxWzfzE9OBetmwmtrBp9CGIJSZIsP+bhV58hfA6Yitmdtq7zaC/ozDXwUWIq1ZdHog6tdoi1JXqzZjWKo9bQ9KQyF5XSaHCxGbDSXPUACpQ47slYB6sfrZ4YbZGMKeC8retxHwVTjuP6G8JhSRkw7gt7dbiRE82/4aIovHAFLOPtncWK2M8TNjvOHQKb1QPhqRdhR6/K+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30tZRumLn9/VcNc0u7CPD+TgwCF/Ta5+52348gc7Nvo=;
 b=wwKohifB5rELLqTH8EIfTU5bz0qucj8LkdN5TZTKvldgb3r5NVMYaN7MQYYK25SWA5FOCRAGjenGWRGfuySBJJtQsQk/7NY0gQkyCMz9uXV5ntT7VVULrow/ZWv3H3Exuk1WsrvFFSzFwPnNoZuKg+DFDdlUo4BFjXhJZgBIV/8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3918.namprd10.prod.outlook.com (2603:10b6:208:1bd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 21:58:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::c11a:5b2b:9659:7c42%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 21:58:54 +0000
Message-ID: <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
Date:   Tue, 19 Apr 2022 16:58:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com> <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com> <Yl6PueNCZZeobMWr@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yl6PueNCZZeobMWr@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab8d9bc-eee9-4391-a7e1-08da224fcbd4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3918:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB391828A5FCB60AD77A47097197F29@MN2PR10MB3918.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7qF1mlqmVe2alVHC6FmPbHHfKm2rK0BWMUPByVcuPbfRCS+FdAwH/P61e+WddSA2h0vFwjVNZVEoqXeYJoEGjUsPXPzsj950ILMJ/hRJMZG77IHETZPMJpGQc3pVVxMY8u7t4EhFmZf2SvuiKVYlRWy2PfnJQ7Ll7KxxIjkOXrADG0ydLWREXzJ9E7FWg2bFX3ocPSsgahI2YkH2yKjnvzdouoCd/B8ozQrvTwza13V0uknA8Lu0of2EZBH/JLjGKaVO/ocIH8/9HX+tyfPBs5W6ApJIH9F8tMRhvZ9h4P2QyDImTwRcHOyLNhFW+C8DhQsqTETFdzADWcSUTdCJsv0Fnd/hBWbnnPSLF/gLg/257F8LgYGXTPhSzyOhM3VDxFq4E0Y7GvzpvfaRx2p0ujPTWtyB3fxBQSG4XgNXDhYTchMR+1TGzqJcIU9/U4R0yKCG+LA0Q/2akx7Hv8pgKpfATARBFeVYRDOeF0gWxxvSReZUF0+FihVJbRh7pepcJQnbNA3lFTHsMl16NilSrj6N0oDDdNcKsv82ELgcSvJjuYYOjZmqZVd0EeJ65TEQqWdEnsOH+dPuMHaHV0bMFnnwB13rj1vYlDu7qM7jCOVPQ48x1KtQnggCuPAol+6zm+WuNeYhjxqHj2nyn/5im/LKzszJqf6s++AnDGu9nQUxFcwnwiwG2sYjSaCYz/M9rvidF83LZJMvu28Tkh0TWhmTsFeWJv9eW6lfJT25ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(107886003)(83380400001)(2906002)(36756003)(66946007)(8936002)(6506007)(5660300002)(7416002)(6512007)(31686004)(53546011)(66476007)(6666004)(508600001)(66556008)(6486002)(316002)(8676002)(6916009)(4326008)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNDSXdURFpTVjg3bVh3RGRUTGc1UGxlSVU2L3hPRFZVUEViVUJ2WmUyRE03?=
 =?utf-8?B?WTFKaXZGTnpVQ3VoQkZOaEdCU0hQK2Jjc1Zyb1UrdFJpMVZNdUk4K3RpcXRz?=
 =?utf-8?B?SDBWVVNDUnJ3c01FTkxaUlZLQlptMlllT1hqdEJFanByRkxNc2FzUFJmVkc2?=
 =?utf-8?B?bUlOVnFSc2xrRTFIZEhPSnNkWG1ZZkJKcVd2SWJtSXloY1ZYZDducW94RU15?=
 =?utf-8?B?SkxHanBPcHFSRnJRZXdFbmRxbWVRUDZWWFRMV2l2cFVrZHRsM2Z4ckc3eFY0?=
 =?utf-8?B?RVViamgyT1oxSGFqMW1DY2JlYUEzNnRoQVNnMUF4NUxLQWlIdmx4akFVeW12?=
 =?utf-8?B?V3YzdDdRaVdCWE01dVZ6MlBJSHh5NzBGc3hWWjJ1ZTYrYzRpazNkU3MzWlNQ?=
 =?utf-8?B?Ly9lUDg0bG1GNzR6cklqMXMvaXo5VjdscVFRRnc5TlZNVm9zZmFOYU9VdDlM?=
 =?utf-8?B?SEcwakdSajN0N25aOTFQOHpvNDBjdGs0cGx5Nmtkc2lETm9GQzM2d1hFNm05?=
 =?utf-8?B?UW5ZeWV3RjNYMHdiTWRDSnlIUHE5ZjF3VGxzUlB2WGlkMVhwU1BQbFVFSkNL?=
 =?utf-8?B?N0pFN3k5cWNPNGhHRW5ZQnU3MTBsRG14OWNQVkh1TWhORFdjNGZvcmpweHNE?=
 =?utf-8?B?a1lSSnJHKzVBR254Sm5sUGdad3RpRGh6V080NnVPNkplcEVGc2ZiWnpoMVhi?=
 =?utf-8?B?cm1SR3RnNmJpSVh5VldEQndFQ3hKQ1B4OVFsL2RhK01LbUNSYkEvczlHSzFH?=
 =?utf-8?B?YThCek9adGFIUWpvNjdXd0h4VGdvNDE2ZDFjMFZLY1QzSTJ4eHp0anR1d1N6?=
 =?utf-8?B?L3phcGY4TlN2QW44MlRyOUljcHpCZGs4Q2EydjZWaUh5aXAxRDRjQlQzUGdh?=
 =?utf-8?B?aEhEcU9OUndseHArb2VlYWRxK3JKZVBtRXlvQjdjQmFTVW5SV2w3ckUyU0FJ?=
 =?utf-8?B?RFZSK1BwT200Nm1Bdit0ZUlzSDRxaWt6VHNaZlorcXB0OElRa2grV081Rm9s?=
 =?utf-8?B?azl3VTlEZDlqVUF1MXovN1lEb0F1cGcwY3RkcWdFTXUrSThuSWxCT09uMzBv?=
 =?utf-8?B?OFdrdDNRUFNGRGpJQmxYYzhpUGgzcktodFlDZEVYQm5ZZVlSdkxMY2pPQWYz?=
 =?utf-8?B?cytjSjJIMjd4VGZUNWFHaVVJU3llenY4YVpWMkVXWmt6ZzNDMmxUMFpLdnps?=
 =?utf-8?B?dnpiYjRhaGRycjlpZVd2Wm1aSjE3UWVBcll1NWdoeXpPNVZwY3JvNm53Z3lo?=
 =?utf-8?B?VUV0MWUwbjBQZjdzNHlFaDM5Zk5JUDhtQ1RGaGdLRGFsMWJwT3N6NE5abWc3?=
 =?utf-8?B?WHQ4RFNnb1BtQ2J1a0VzYzMzRVowRDI0OXZVR1ZNblFGYUtTZG16c0tSVTVE?=
 =?utf-8?B?WjZFWXM1NXd4WS9XWFFHVlkvYVB2TXU0R24wVEtIUms3MTBkdmVCenpvYngz?=
 =?utf-8?B?ZFJhdGpyUjRFb1gvaDE2Q0tZUDMweVoyRjhMbi84TmcxNm5RQmJnRjQ2SU4v?=
 =?utf-8?B?N3U3U2h5a28yaWdobGhpUDdEc0tjK2tLZ0tiYVNReEVyQ3Vma2Rod3ZjT3la?=
 =?utf-8?B?QVdyY1RPcFB2S0VlRjFBTFpYUDlRZDZ4T1JXbWk2YkNOaTNFZ0hkbXI5U2Jw?=
 =?utf-8?B?NFdzQ0NLcWwvekVpb0pkQ1dKdnZCRm1vMWowYjVNeldLbktuZ3JKUmdkZU9h?=
 =?utf-8?B?cjQrMFVON2dKT2RUQkV0NFE3d0phYXJHc3dsUGthZzVBVllaSGdheHZPeGZR?=
 =?utf-8?B?YSs5NW5Ma2Y5NkhlV2dBYXZXSi9qZlRYYkNNem5UYm12WjhGSWIwV0dWS3V1?=
 =?utf-8?B?SVdzT3dtWlQ2YUlndGs3TFRSRkxHVUNEemlCdnJBSkdJZWoyOGtycUwyMjRs?=
 =?utf-8?B?bXd0d3JqRDFzQ1ZmWlVNdUY3NFhqM2tnNjVpL2h5ejBZV2RxSk1IanRTc1pO?=
 =?utf-8?B?TEpuM3hQaGZyUDYvalV4ak8zWUZjMHlYSFNvcmIvUWU4clA5RmhJaEowMXdX?=
 =?utf-8?B?YTFHRmNtNUxzKzk5SkVOYWpIVUxjclNpZHlmcXNtYUlXTHV1K2NtcGUwbDN5?=
 =?utf-8?B?ck1LMUZwMTFRVytDM0NaanI5YUh3K3dUSzAvY3NYM3ZSR3A5U1RjZjBNWVV3?=
 =?utf-8?B?REpzRlcycFhWZkthRWNib1NnbXltYlpxY3AvZHJTN1A1eU5ZRW5Qd3VMbGNn?=
 =?utf-8?B?Z203ZlRzS2IwbGhVM0Q3TVR4TDR3RzZFREZERStidTJzZUk5T0RNMEQ4VXJ3?=
 =?utf-8?B?WmFWOWIwYjdkdzRkcElkM0FTeEM1dGNzSW9CUkNYeG5XOUo3bHFRaTdYMERm?=
 =?utf-8?B?QUdpS2lqcUZJdy9RMXk5QURZN3RLWVBHVnlCTVZuK1ppaWE2U3BkRUhEZW9v?=
 =?utf-8?Q?dpU3BKvKuEOhFeRGjPhscovHxglpd1kqOc3MD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab8d9bc-eee9-4391-a7e1-08da224fcbd4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 21:58:54.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEueCNliJ1xbdxe58VXkRoQGJlFxHz17EalkME94HcqSMFHomyAuY28bp2Tk/1q2ZgjusbZPfqnsBufRJFAuyAmM+Dw3+htkvENgdmU+++k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3918
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=991 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190121
X-Proofpoint-GUID: 97OgezwEpDoPIGG1LRNmZCvZaHjb-pDC
X-Proofpoint-ORIG-GUID: 97OgezwEpDoPIGG1LRNmZCvZaHjb-pDC
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 05:32, Borislav Petkov wrote:
> On Mon, Apr 18, 2022 at 05:03:39PM -0500, Eric DeVolder wrote:
>> I've examined the code with this thought in mind, and I'm not exactly sure how
>> this code should be restructured for !HOTPLUG stubs. I'd very much appreciate
>> an example in order to facilitate accommodating the request!
> 
> For example, see init_intel_microcode() in arch/x86/include/asm/microcode.h:
> 
> #ifdef CONFIG_MICROCODE_INTEL
> extern struct microcode_ops * __init init_intel_microcode(void);
> #else
> static inline struct microcode_ops * __init init_intel_microcode(void)
> {
>          return NULL;
> }
> #endif /* CONFIG_MICROCODE_INTEL */
> 
> The actual definition then is in:
> 
>     arch/x86/kernel/cpu/microcode/intel.c:
>     struct microcode_ops * __init init_intel_microcode(void)
> 
> and it gets enabled when CONFIG_MICROCODE_INTEL is enabled in the
> .config. When CONFIG_MICROCODE_INTEL=n, the static inline stub gets used
> and optimized away by the compiler.
> 
> HTH.
> 

Thanks Boris. So in taking this concept and looking at, in particular, patch 4/8
"crash: add generic infrastructure for crash hotplug support", I'm not exactly
sure how to apply this technique.

For example, if the suggestion is to change crash_hotplug_init() to be the function
or a stub, then what is an appropriate place to the __init callout?

If instead the suggestion is to create !HOTPLUG stubs() for the registration
functions within crash_hotplug_init(), then that entails taking what are currently
static scope symbols in the callbacks and notifier_block and exposing (ie make non-
static) those, which doesn't seem beneficial.

Or if the suggestion is to create !HOTPLUG stubs() for the callbacks, then I thin that
is implying that crash_hotplug_init() is not #ifdef'd and always runs and always
sets-up these event handlers, regardless if we need them?

Perhaps said differently, I'm not seeing, yet, how this technique applies to this code.
Is there a specific function that you know you want this way?

Thanks,
eric
