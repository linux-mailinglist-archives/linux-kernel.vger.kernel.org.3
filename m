Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9529154BF99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiFOCOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiFOCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:14:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38332EA2A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:14:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0T3Z2015214;
        Wed, 15 Jun 2022 02:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lU2VDt13KTEmx9Rz9TIXPBNO2OIxyDufA2l0cvHbtjk=;
 b=BvHoQMGNQksBwRbn36DpazSyYLHJRzmHeHgxHf4B6ngVXbKNEPcI2X+HYyFcJ3SCzEED
 LGf1JR/OgeY2J0JPIibkUqrF/NrSD8b937/IBnE5bbNvdbuQkx08G0lClWedsSz+ADTh
 +EhlVI4zLZe9RaRsprfp5IjHMZnHGJFtZhnoijcMfnBNbRQuRqKY/sENjX00nla2kNZM
 Rk1AQ5zYO/csLVxjsZGFwrzfLAJII9SzkzGcpqD4u+Vdzy82OFkDSFzOT8H+E6f4WtlO
 ZYChqGtKvl3S2Io5s4l43cxoV/T6q/RH3Pn37GQIcq9Phl3bOooJXENy6uyaJciUpOlA mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0fbqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:14:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F2AAPk021148;
        Wed, 15 Jun 2022 02:13:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq0u1tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:13:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez9jeI7pBoyZu+UjfBPX77ixfr3YJ+UsnlU6OZGq2lUAp5xBhsYrid3j7F7potGyNl/OQBom+Z70e7pfMapopIZWJsaoteE2zqPeth6wQqBp6r/NjSqohpzEsA4WXjGXhBY4CGhab9ZE/owRXE7iE9TneVdTMUxnisC4YlmnnX8qemQuldhrlFWmi6zmGWD9heSMlNjWyDpCI2+3wc7XYecpozNiEoCDF3IQSRmUwzoKTMWdXao38TnXCs6mg0zDtIITewU5miB0OY7zdE9CuMv/Xsiwdl85EcdnirKUbKkLYr5CKB3E51VjSiMmFWRpVMw0AWGR99Gg4oiJq2nm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU2VDt13KTEmx9Rz9TIXPBNO2OIxyDufA2l0cvHbtjk=;
 b=YD/w22RwkrjkfhE8fjtAQpzE7tnW3Yh7Vs34qY944FZjG8Zs0c6E5p5DJ3XU2Gbq7IvNhyxkymYb2VRA6+67N7W+BSWGw2BLGMawvZjTnzNXQ6ZyBqoCEZ5gFKxCmzvTY02oXyCi4Vaua+1K7zqEnyGOFTCa1mG9NLDCXnDlxYbH4ZoFTlqlRzlewBl4tquc4XqyIScAGykT+K3SPRS/6VdVCwei6UGT/oiPPrHUCxCVyinX/5FxFsPyKaB52fG7wd/JJAggircKYGWhhF2imQcOfcp6etMDrEIyIrH4FJblWCKdhZeyijHVwM/1oe0rWF6SZswqYxJ2Jts7cidC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU2VDt13KTEmx9Rz9TIXPBNO2OIxyDufA2l0cvHbtjk=;
 b=fj9CVanO+uvFYgH5WQ4UalXSD4LxLClOyDQtGbzwcz/jjlXB6r0atbufnFDEb3bo+BOeWIIGjoJlJXOQ9lfh8ZLSqmhUEFnPHf6xTG2HaOazrOV/XxguKAvQ0TNRb+gOK4b+zva+csTcZ3bfOIxINQDSP/JbFrzi+m+ColmZmEk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3636.namprd10.prod.outlook.com (2603:10b6:408:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 02:13:56 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:13:55 +0000
Message-ID: <89ca35ba-0290-b155-b290-5e70efafa9bb@oracle.com>
Date:   Wed, 15 Jun 2022 12:13:48 +1000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/4] kernfs: make ->attr.open RCU protected.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
References: <20220614070346.810168-1-imran.f.khan@oracle.com>
 <20220614070346.810168-2-imran.f.khan@oracle.com>
 <Yqi1RVRK2XahPWlg@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yqi1RVRK2XahPWlg@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efd08a9-7c80-4925-7245-08da4e74b331
X-MS-TrafficTypeDiagnostic: BN8PR10MB3636:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3636EC6CB9A36760B5C3E9BFB0AD9@BN8PR10MB3636.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEvLwn4/lCcMZH6UkplZw4OiDdIzoXkp1PjR732cZOCKDgH/jFg0Kn0NNvdURL4eRM4EJLynuWAqS6Ulsk4iaJtDaGsg0Yo3g2PjhpDvUtElonfCJ9GtdvlerY/MUM227LZSMPj8rDpqGKVdfo2fmymWbUn3dbhd0FojtA+YZ49qgN3zF0yf6IkftC23vIreW6j9v1+LrPbx2qzaq75CJUhVk4IYGzVEfAl7PPjwfjEHL7LrmjGo3p5tLtcEYmRqnl9D/1ci3vxwToWtJQh/HmiRgy4BmCF/t97ygbRZArN1+rXq17ETCWAsy0p0Vxks64l5c03eIcleSU99CjtSumXiF0dOp+Cli3cdNN1De/0bJ6zTZZZ8VsjFp5vhAi7VSe82rddZUxGcC+51yUwR416lwlpuaJtb2EoUbnQBbsC6A2dCQiUtWMJT2NXvC13gOcMgbsSvdYroVaGeGsxSPVJbdCABsQVUjF41Kewy2rbVShpWyzXsKMC3MYj7Fn6waMrEMXkeq4XTScONeIO2GRpY+si6XzSWDIMtCkfDtiXSXE7AJDp6i57kazk6ZE+FPfKKQvJa1R8bG+vS8a1bWn21ZwXn84BI7+bvx9x6vWHtL/Qhs4wHnPkPegFjMmdA9CP2CQBarPximeVJV+p6tcG057EB5Xvrj2Ykik+mLBN6TA12G05aDe6nWEbH5GY+M6CHV37K43B8l6kKiw/XDRFMnuu8aYQIE6OnFXfAcfSTSe4hLsmGlTyfL47zhuD+k9cMH242SsEzwGR9KPWS7TiejwqfHRALTw69XQEr2csY9PCruggiEwMxa++Loaf8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6666004)(8676002)(508600001)(6506007)(316002)(83380400001)(2906002)(4326008)(31696002)(31686004)(86362001)(36756003)(6486002)(53546011)(26005)(6512007)(6916009)(2616005)(186003)(38100700002)(66556008)(66946007)(66476007)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhPQVB1Q0NNSGMzb2hQMjN3dzhPTVo4SjFNV3cwNTY2VW4yaXFoR2ZyclBT?=
 =?utf-8?B?MjlqNzVDQUh2ZDdHWnNGQjU5WndMaVpJZEZCUmF0RWFOcTNLczNVcUF2RHlF?=
 =?utf-8?B?SUk5Si9NcStiUHVkQ3o2QUFSWnprRytCa3NSN21YVHJ5ZVdqb0pCcWU1bWVx?=
 =?utf-8?B?YWZSSXJvdkRNZmZDVTBRVU4yN3J3Y0RsdHU0cmU3ajZrcElCRTBSM2dnMHcx?=
 =?utf-8?B?MzdJR1BZaHJ3UXQwT0hwb29WVldBV25RTm1BNWIycE5PNnVlbHRhTkY0L0pr?=
 =?utf-8?B?NWhtUFFNZ1plQWdPMHN4Vlo5TUdvSk9rdm4yQXNwU25ORUdXaUhtK1JKN084?=
 =?utf-8?B?K29EWVp3MHpxeVVPc05iNmRtbFg2UTZGZmJDbHZrYWN0UXZIWDlRNzFieHF3?=
 =?utf-8?B?L3psc05yV1pBTWQxajIwRXFEZ3RwTFhQQWdRRTlrTSs1VmFkOHk2c09mRlRw?=
 =?utf-8?B?UVdJRVRyaUpvQ1pVUVBSTG9NZml1VDBXdC9vWEM1QUY0SFhubTkzRTBrVDQz?=
 =?utf-8?B?eGF2REdTRlliT09NYzRpVHBPK2Jud3F2SUx4bmtURHYvVG5aTTRhK2s3WGw0?=
 =?utf-8?B?NFBjK3RVY3JRZ3gzSDFHcWd3Mll1Ukl3Y01tWitIQjNpdktCWWlnWHFrc2sz?=
 =?utf-8?B?T0ozbU51cGl3SW1kTGNkNTMxQW5udGFvN0tiWEozNmk0ZWlVMmptQ2kvaHBB?=
 =?utf-8?B?Ny9sV2grSGpyZUgrd1BGdDFrMWpkYjVGYU1xQUNHZFo2aXJyN1YyYlAvVVN6?=
 =?utf-8?B?VGlESnJhdXUxQlIvdkpDdlpRSUFlRnF4Q00vZm5HandwZlJKTVp6S0diOXhO?=
 =?utf-8?B?NExmT1ZEczBDTGNEUnd2Q2J5V3JwV1kzM1NCU1RVcGt2a0xzNXJYc0t5eTl3?=
 =?utf-8?B?T2MyeUlObzRheXhlN29yQUpvMmNtdE5GaG5zSGFodzRSVDhBNERGazlkdnE2?=
 =?utf-8?B?MW51UGRES2lHQVNMZld0RnZjTXdMaUdqQklaQ1VpWEVhdTVLbEtJeWVWdlBZ?=
 =?utf-8?B?ZVArcTJVODRBekJQZElPY3ZyQkZIS09ONGU1ZGhQQWlwU1RJN2lFVWxaRWJ5?=
 =?utf-8?B?TlptS3VEQlFuU1VLQWZtaFBDTHVOODdndkdiRDlhc21NTEQzZFg5WnM0Y3M1?=
 =?utf-8?B?UU5IT2xJQWQ5bkRJdFJscGNxTERON3cxclFHcUtWdXJmU0k2ampKb3JrMnd1?=
 =?utf-8?B?UXI2dzB2SENoWjdJNUxod3AvWkhoSGdsMzI0S3h1a3RXTW9jQUlTSDRvNkF0?=
 =?utf-8?B?SHZPQjlLWkhkQXNTSmtVRGoxQ051N1NOZTVYMWx3ZTZ2T2Q1WmwvVU55RjJL?=
 =?utf-8?B?U2Fib1BHbzIyZWpmOVliTVcvb0VMVXorWTNFc2R3NUZOMlhHNDdDNHNiZWF2?=
 =?utf-8?B?K21rejFMUXcyM1ptekxLblNoZk5UdHd0cE51YWFmVWg3bFdMaTQ5RDQ1SmZ2?=
 =?utf-8?B?b3pWeWVXZVZ1ckVMVmpYditKb2dneE1yUVFLenZWWkZTWGZoeWhUdVJKd0Rm?=
 =?utf-8?B?THBZYnE4aFhla0MzRkN5MVB4aGNQanFtRlhTZDNQRDdlVG5YSGcwdmZJbmVB?=
 =?utf-8?B?OTdFaURYR3FlbFpwbi9JMTdDV0xGZ0lzZDFaOUNVSXlpTWpmWUpwbXM4UHlY?=
 =?utf-8?B?VCtmK1l5cXVyZTBBTEFPWEVHV3V4Y0xQTlQ0UDNoVnNFV0M0bmNRTGF4cXgw?=
 =?utf-8?B?aWFwN3JlaXlsWmE3TWFrbkp6R1M0SFBKcXRPNm84ZzdhQ2Z3U2wyeHpSZExu?=
 =?utf-8?B?dmVwTE52TlFzU3RFWmJCV1l1dWQxcFp4QzlRQUErL25XUHpwR2ZXNSt5TDhV?=
 =?utf-8?B?c0VJSFBpQkNTZnU1akYvZ0lhRWFQdm92ZWZWaVdqUUNsaEk2a1JKSEtRa0dq?=
 =?utf-8?B?Umdxb3BTbGxrc0VkVkU5Z0pKRmlMZ0lkNGdqMnFtdzFuazdUVVVNMm45UTEx?=
 =?utf-8?B?bHpGUm9jSU9Vc0ttWWFuUXNtTGNLUHpFWEczNXZINTdabmxjUkZhVDJESkZp?=
 =?utf-8?B?SkhBRG5UZGZ4S3ZLd0FXU0F0cUNhNFBIMzRXUTBlRnFDNnNxRERNRkwvdGZI?=
 =?utf-8?B?by9zaXgrWm9mRGQ1UGhJS3ExTDJOekE3bDZ2MVFsTlIwZitGQUw2cmlVTWNF?=
 =?utf-8?B?UkdZczJjck1tZE9kK3EwZ1pHSGwyVm8wU041K3NYcmRPMHJsMG9QTm5MTVRw?=
 =?utf-8?B?dGpFMisyZkZiQW9raEZNZHg3T0VkWmhyYVJiK2xxRWZXM1BwRlIvQUNwa1Bm?=
 =?utf-8?B?eEJkeUNVbFFLLzEvL0pQeWhwak4veThtTjJWUGp5RW81RWQvNy9vdzUveUNq?=
 =?utf-8?B?Z1djK0dhbG1ITStZMEx4ZDVOUVlVZUExWHJvQ29BelZaZzd6K29tSCtib1pF?=
 =?utf-8?Q?2j1Mzzn2QS89Bwic=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efd08a9-7c80-4925-7245-08da4e74b331
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:13:55.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjetKwzzQpB3vyGxQagmN0Nng0SF87fJK/Du/EqBgdBsVErYmDzsPKVMJqcwaH7nAKAGWWxG35siZYlNQeRyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3636
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_01:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150004
X-Proofpoint-GUID: ynSkOynTa-YhYvOi2EtYgFQOuJLiX3FK
X-Proofpoint-ORIG-GUID: ynSkOynTa-YhYvOi2EtYgFQOuJLiX3FK
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

On 15/6/22 2:20 am, Tejun Heo wrote:
> On Tue, Jun 14, 2022 at 05:03:43PM +1000, Imran Khan wrote:
>> +/**
[...]
> 
> Hey, so, the difference between rcu_dereference_check() and
> rcu_dereference_protected() is that the former can be called either with rcu
> read locked or under the extra condition (here, open_file_mutex held) while
> the latter can't be used under rcu read lock. The two can generate different
> codes too - the former enforces dependency ordering which makes accesses
> under rcu read lock safe, while the latter doesn't.
> 
> In the above, you're saying that the accessor is only to be used while
> holding kernfs_open_file_mutex but then using rcu_dereference_check() which
> is odd. There are two ways you can go 1. ensure that the accessor is always
> used under the mutex and use rcu_dereference_protected() or 2. if the
> function can be used under rcu read lock, rename so that the differentiation
> between the two accessors is based on the parameter type, not whether
> they're protected or not.
> 
I am going with option 1 suggested above, since the accessor will always operate
under kernfs_open_file_mutex.

> Can you please post the updated patch as a reply to this one? No need to
> post the whole thing over and over again.
> 
I am sending the full patch-set because after modifying
PATCH-1 we will get a conflict like below when applying previous version of PATCH-3

static struct kernfs_open_node *
kernfs_deref_open_node_protected(struct kernfs_node *kn)
{
<<<<<<< HEAD
        return rcu_dereference_protected(kn->attr.open,
                                lockdep_is_held(&kernfs_open_file_mutex));
=======
        return rcu_dereference_check(kn->attr.open,
                               lockdep_is_held(kernfs_open_file_mutex_ptr(kn)));
>>>>>>> 80411dbfe1890 (kernfs: Introduce interface to access global
kernfs_open_file_mutex.)

Full patch-set will avoid this small conflict. I hope sending full
patch-set is okay for this time. The full patch-set (v7) is available at [1]

Thanks
 -- Imran

[1]:https://lore.kernel.org/lkml/20220615021059.862643-1-imran.f.khan@oracle.com/

