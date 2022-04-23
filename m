Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C2C50C84C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiDWIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiDWIxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:53:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1401CF731
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 01:50:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23N7Y9Su002037;
        Sat, 23 Apr 2022 08:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FTzTu+j/lYiW5Y5we3EBoeA2hJUjfaGgGmZhtgrDVVQ=;
 b=cxD74+9qEAJCpGzPftgyl2obYaIlqhot6vhWI625dTKzt9ghy4CeIBbhE8bFACYiJDZu
 XXs6QHfnoceZQcajl3Cj6aLEAfV7uhjzEWiZhzsEdDKvPD7NjUJPTj12QemXMxFArIL/
 VwFnWEmW86kznoy+Taydf35V+JtDn2vyuKXefcU0HZKzNWvzn93Fi7OcZOwaJSHDFEyX
 ZZdghw9z4rz3Rj7lQK1n/GPXmEGejwh9/5t6iqsvlw2sPjITB7+3mO1N308ddf1fnjC3
 YcZtOpM19vJ1pfsb9tEMqjZ8jwFyhlSHdUR3+RZlJoaWZo7lblU4DBPcv2dTV4wBCb5h ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yr77m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 08:49:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23N8jwec039073;
        Sat, 23 Apr 2022 08:49:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fm7w0ygyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Apr 2022 08:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMh6nVnaov00LAqw9PNkh4Jw0AlWpEc5hWTK5Tmw8pQJ1B4NFiWMIvgLj5LTxdwk/4OH1qeqeThwLdYYFHErn/2Mtaz2rHkY92Gg96kyJLVe11nUIveGgz0rOK7yPJlYbUVJb8sEAKGEpKi3Imwrfa79fe3K6kRStM5rrmbH1HjGg7Af/SOe5IMbdWWrGc8Qub6hOBI0vcGEpnI4OCdQ3qU3WH5+JjOlPzo9am/uDRXEqPJLO4V15zAAiZ7vsed64wdIaj3vrApi4EQL/+M8uGt50kjmXEeGbRcuKhh19Et9OeRRWZqAgWepMXLTCY4G+cCpaeAo70154E2UHNxe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTzTu+j/lYiW5Y5we3EBoeA2hJUjfaGgGmZhtgrDVVQ=;
 b=ha/Ue+kZcVJzzUY5YiyYQ+AuZyzxIurmj7xeO555QuL5E+WOHwXxZchWKouEtmvXQMo2OKUYhDFWmGQWDarku/sTZM01vCZYT0FlUBGAJr4YncD4ikfcnHXv2V694sQmE63yg791K+HibN0PPGbFPXlRYCKGohQQPy+9RcIZqTx6hu5M6F9+1Nyc+VnA+kCumLoxr7iW3AEVy12DpIXO0jmJx16pHVwk5eWz0uSxgsgmcDT18TpxDMrhHHmposw+oXk16yFUkaxvXLzTbZdhQFMyUPkSvsS96D4lP6JgBJ9bicI/kcS07EmwRrMNFs3uhQieOl6pKZFyi1s5aw3KnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTzTu+j/lYiW5Y5we3EBoeA2hJUjfaGgGmZhtgrDVVQ=;
 b=OQjbGLnTM74iTc4GOr7Z3ivqm6VyfF2CilzRUsrXOa5R+NAmw6TrD8qcqTDXITl9jly4De2NECoZRsD18LiFWXNA0om3W5alEif9CDGKxTdbpHEbrsWBa3RJrlNIhui4WtZaM8qXILcG76EYj5uJkCGUDS8+aOtOmwtAUGl44c0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB2507.namprd10.prod.outlook.com (2603:10b6:5:b6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Sat, 23 Apr
 2022 08:49:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::14ef:8202:73ba:29ec%3]) with mapi id 15.20.5186.018; Sat, 23 Apr 2022
 08:49:56 +0000
Message-ID: <f2ca9d19-023f-76d9-5c76-6f08ccfbe348@oracle.com>
Date:   Sat, 23 Apr 2022 18:49:49 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v8 00/10] kernfs: Remove reference counting for
 kernfs_open_node.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <YmLfxHcekrr89IFl@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YmLfxHcekrr89IFl@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYYP282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::15) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94dc3e6f-bd41-44b5-7bf5-08da25063de3
X-MS-TrafficTypeDiagnostic: DM6PR10MB2507:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2507C865BDF318D2475F2CC1B0F69@DM6PR10MB2507.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmwHNY7GUNbPRw7oJf35aPsFQ1SyluiMaDY0euKPjb78fOq1jfr/kC53QZ5UFbfJc+0pjm+Mvq21DVElkx9aScIeuteJWOiPU1LkEd98llXgEpUmsiY/tgTIeKEX0X853ufVctvjD3knZ+Yp+Ix1q/SIYS4caIG0thtqIj9U4x7sp4ilPkixYWM/8Xm6eiEJ4cQd6lD9AagO1VUdBd1FKE0xq9X6RwJ7Se6Bb43894jhxT/xr488BysV7hIhni662GuEbcGUles/1sXbL9WCo0CDvr3TxLhw2aOJo3KMDi6bNICeflw/YEdvL6lPEWDXZBl9UCLZgAb3ffDDXnWJjzIjCBO0B/l6FPsfxz84uk/x/Z0JSVuPHVdqhk2qvU2Sgy5chW/QcL+5yxCDsPyqtDI5zZhPJHJR59vsVji8hQcOz8FG0BCUuMi3/LLLChFcVHgBbtqCpME4sRcwBvVTX6i2oxLdvyEVuCFLeWXW8A67A1Gz3WIVn7S2l37Wdrb7Jy7El7C2jBkJhcIsUV2uil0MjcM+VvbJrKGP90XhLXarRt1NJUtI2q6RrF8nNEQ2eVAB7OVZ9uhZBf3qJ258Ko3S4ijJ8bYSAiiudqng2rkuRShPi6QCeMD0R+9rEMAYeI0UJyIjPh3nj3pRCpn7rPqEH5TWan8m6nOvrOQyWiZb2jBcTMwNPLV9OQpaPxw087wqs6LnNsTPZ7njs++N9dxjWZVzm1QYLYWn+KF0q2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(4326008)(316002)(31686004)(6916009)(38100700002)(6512007)(2906002)(26005)(6486002)(6506007)(508600001)(31696002)(86362001)(5660300002)(83380400001)(36756003)(53546011)(186003)(2616005)(8676002)(4744005)(66946007)(8936002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpQMGJFeHVtN1ZqL3JFQTRXRTBvRDBYU0dQSGRDcXdWbGxjdEp2dkJwSkZ2?=
 =?utf-8?B?SFFKbmRtVW5LaGQ1RjM0Q0JqOER1L2czRktuUzZjTzVRcWdPNktzdFgwMVp4?=
 =?utf-8?B?MFhudVBqMy9JR0pWWVFqL3dwY21WZXRDakRwNjBFQXFNeDE4NmV0Y2ZURm9q?=
 =?utf-8?B?cXZaQ1ZjY2pIcXBveFQyM2lLY2haajJkNStJaGVHSmV6b0Y0M0xNdTIzV05y?=
 =?utf-8?B?aElhTEpEOVNQaUFpNHV1ek8xY3hQeHcrRGFDWU45Wm1kc0VPbjdiODNPdVBm?=
 =?utf-8?B?QXBjdWx6U3RnUmlQYWFycjVHaFdWRjdHS0oxa2lBenpaWUNNN2N4M0ZuRXQ3?=
 =?utf-8?B?NFdkZ1dVMWNMaXoxNlAvY2drZzNqbDg1M1A5Uis1cFNKMmlHcS91cDdMc1VR?=
 =?utf-8?B?Rm1xcktPWDd0NzQzRkd2NkNOTTVvb1puWUtGaDdMM3FTLzBFVVF0bVJ4cGp3?=
 =?utf-8?B?c2V5eW5Nc2FlSjI5VzlKMjhBbGZCMzhQR0UxWHZUbjRwUXdveVpvOFA2TDZR?=
 =?utf-8?B?SWJFeG12OWFwYXFqV1ErY29oWlVYZHhoVXY5QkdMZGlqOFZCRFJnVXhQcVVS?=
 =?utf-8?B?THA5K0lxZ0FmVk5IeVhDbGo5K1BCTzNUU1E3akYvR2tJVGg3UzJzL2M0czZC?=
 =?utf-8?B?M0JZMkkyYnp2Y3VaOVpCNFJiRFBwelNDUHR1L1UyTGpocW0rZ0xHUUlpa1Ns?=
 =?utf-8?B?M3FDTW56amd1dkYxMFJDalNEOU9xMWx6cVhqVmh0WWZYVWhFbWJobzdZR1VD?=
 =?utf-8?B?b3Y5UU5aT1M4REwwRFdSL1dvTUhHbXBBN3UxTWtFSlBFbE56MlM4aWhTd3pZ?=
 =?utf-8?B?d0ZMaEkvMW90K2pSUlhraFU2eEZmczB0UjhqemMwdW14VTFUUFgycExOdWZ3?=
 =?utf-8?B?ZVZzWElHRi90Q2dWZEFHK3J0Z1g5dlRyNEpsRmMwVXhMSFVZdm5CclNQeFZz?=
 =?utf-8?B?QXpYbURZMVVyMFJOYlA0VGIvb1p3a1AxTG5HWTdpalozM0ZmVGk0Y1Rkclg5?=
 =?utf-8?B?RXVNU0Y5cFZmR21BeTRZM1lmendSWDNZWnJiZHIxWXlZd25vbEpNVVVEQ25z?=
 =?utf-8?B?dXlXaGN2OHJkMlpsdndJT21kVER5QThXWHJXMGIyMTJzMFI1eFgzdEJJbDN2?=
 =?utf-8?B?UStOMjhOMHhtUk9qRlBzYWNIT1Q3MmtiM1ZXQWFHOExocklQcU05amRqTGc4?=
 =?utf-8?B?VnNKMEdtZmIraWZjUGpEM3NtUDIyaUJUMklkc0FnNFZoNGFISXU4RmZ0Mmkz?=
 =?utf-8?B?M28rdGtJejhFT0Erd0NGUy9RcmQ2ZkJmVEJMZWE5a0dvSXplVitMQm1hRDVp?=
 =?utf-8?B?L25wcXpseDVjU2Z0ZXhjL09IUkE3cjhnZE5lWktwTjJXRTJvVU0zcEwzSjF2?=
 =?utf-8?B?UHhDZkh4ZS9WRzhvd2dDMVg2eUlBZjFQY0l0T0xEbjFHRForWmtrOVB2NEVU?=
 =?utf-8?B?a3Y2L0VZeFZpUStoelFSVG1HNzB3dEFnbjI2TlpEMTl2ZThKanJaSlZjQm9C?=
 =?utf-8?B?YkIzRU8rMkN6T1YvSFdUVkp4RTI3dW4vRmFESEF1ODFUbXIzWGp4Y0VseHd2?=
 =?utf-8?B?dGxQb0E1RllYajBEODdyVTQyR3hBM2ZTOS9BS1I4RjEwYldvVzlNR2YzME9Z?=
 =?utf-8?B?a3FZZUxpRk1NNndOcHJkNFBpU2ZUMEkyeTdwZmw5OGZ1a2ZnNTRuS2tyR0ZJ?=
 =?utf-8?B?bUR0TnRVWlFSeUtQb0Urd0Y1aWl1dGw0TVRQR3VBanZIOG5mM0YrdnBIVERS?=
 =?utf-8?B?ZlZNVC9UUDJIUkdkRi9MUVY0ZitZYkpHem8yWSt4L3hDYnFFWTBETURXYXE2?=
 =?utf-8?B?Z3U2WEdNRjlTc0ZQVU5QSENqRnNNRWc0UzVpOHAxdCtUTjdHOEV4ZjRRT1hw?=
 =?utf-8?B?bVZwTHQvREIvWG9vdFB2b0E1REZ0em5Qb3pLK2xpWThsL0JSejhTd1pUK3VC?=
 =?utf-8?B?NU1lemRUWFpSSXowYXZNOS9odm1waUU3R3BRSnZYeHBYb3BNRVFHbkw4SUpJ?=
 =?utf-8?B?dDRVb1RxOGJCTmRIbzRuWjBoR1hLcnJoczVyMEdTMllXSE4xV0g1bWU2Tmtq?=
 =?utf-8?B?YWE5U2V5RWNpL1N5dDFwOUlQT1h3RnJ1TjlmeU4rR1l0VzJIb0FMQXBaOFFO?=
 =?utf-8?B?dFA2NU1jSUFzMEN5OThNRjNDdXp4dmpaQXEwWTVsRjlnSGMvd2J6d1ZuU1Uw?=
 =?utf-8?B?YVQ2OUk0VG8zaTdIVTNXZ0VkT1dqMCtHVU1lbWhnRzFVL0xYOGhoM2VYUjlG?=
 =?utf-8?B?MlZteWZaUGdYNURxOEFoaHl5bjFna2ZnVUdPeDlzT2ZtM3JibURKQ1E5RmRR?=
 =?utf-8?B?dVp1VlJJQWpMOS8rM1FJaURkM25jRWV2bFhReXR1UUlqbklNUFNLOXNtaVN1?=
 =?utf-8?Q?X95j0zWLgt97GU+c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dc3e6f-bd41-44b5-7bf5-08da25063de3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 08:49:56.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwTNUkmde86fDXVPzPnBclPOKkxin8yAXs32vEUlCq93rU7LXwfhRTSWC+KBKNNmRMvMy/Wiwh1osCTrX1r68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2507
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-23_01:2022-04-22,2022-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204230039
X-Proofpoint-ORIG-GUID: DnIMDR42qYL_gXl0yt2pHxhpDL9aPZeN
X-Proofpoint-GUID: DnIMDR42qYL_gXl0yt2pHxhpDL9aPZeN
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,


On 23/4/22 3:03 am, Tejun Heo wrote:
> Hello, Imran.
> 
> I took a look to patch 5 and it looks like there's still some work left to
> do. Maybe it'd be easier to concentrate on the first two parts - the notify
> list conversion and open_file_mutex conversion first and then get to the
> rest later?
> 

Thanks again for reviewing this and I agree with your suggestion. So far
most of the concerns have been around usage of kernfs_rwsem and those
can be addressed independent of first 5 (even first 7 )changes here.
Just one question in this regard, should I send the new patch set
(addressing open_file_mutex and list conversion) as a separate patch set
or should I sent it as v9 of ongoing change set. I guess first option is
better but thought of confirming once before proceeding.

Thanks
-- Imran
> Thanks.
> 
