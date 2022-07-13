Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965E357400C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiGMX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGMX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:27:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D648CBA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:27:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDchI019281;
        Wed, 13 Jul 2022 23:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O63Zo9CVw6tLu9AmWzCRCoRDaMmyH4/OstxUvNxdCuE=;
 b=jiFEWs8HokkynJMv0q6u20JS7BznZ6emF0jyD53yAmrHVhlup8Ec5mDpCMjaf4xPxUyU
 CGYnkHzH2+fXzRwbk+TT3YyRI9RBkhOdyxbK0qy4/98xvzw1wOlqEm89rzcvF48xKsxV
 gzhqAvZWxgFSb/GbRpMhk4cbkA3uhrW1JPf6YNDzXp+4JlqRxN8mm5e3GtSKJi7t0kfT
 mPbqMDsAZHFP+dgsv7PYlhla1VQ6eGT1DysPOKpEd+242xpo7onR7kovKE3UpOzF5QPb
 Oz+50aKIWqC4ntBb9WAKHIxPkggFJyvpjwQ9SVVbmF1y86lwtt+XPIeSDMoMyI2qfh0d qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrkme0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:27:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DNR7lw005503;
        Wed, 13 Jul 2022 23:27:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70456hd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 23:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzY6IJM1nou7EyDN+tOOZVkpJw33uVoS6d36noRMQuniKxElHrsEsMHtT0CqbdpWSeJYCzvZM0Ao0vobtDWknCAyqepzTqHityMEy37evQI9M239qEY7Pw0RWbYR40kTi6uDbN3E0vsQ9iBiR1rmQkRJ5e8MNeaVV7KWJ6Eu8EGY4yWTnQ2tiX9v9Eem0kssGXBUTYcx5H72PJ1Nndh87Zy1kkLJCIu2K+PwzS6WZelYwtzsHVxp5jxggWayoCaLX9CbyMJPK4XIsiPft6hto/q0KUWYHU8QSRm63GctpEbgT5HwqKz54GF74ATe2ue8dMee6riyQy7ATAXqzZibIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O63Zo9CVw6tLu9AmWzCRCoRDaMmyH4/OstxUvNxdCuE=;
 b=LPk4iyqNot9zWUwgnXnqUHabXwuVwGx4veRP7ud7BWJ9CEaHjka8gjp+WBoykskHUOC6br3Wj/ZIOkPyvaC060Lc/skKe7YsREY/rTMhoSo0yM1tlfeD29rBRZJ5lN+S0cLQT1faZWjFztNp/A3bD9+jp4UQo4BB2ZzoN2wch5dSyGwNoBDq7QwEMWladvdmuwrCUjCpiZDeJ2TMKwuABaTZ7mx0b+zW6D8Zg5gH5D0uPJ+hSBYm9QbzC3s26Al1Hpi7UwoSmhP6fEHSPd2LF3CJg22PmbXhuo5Gpt2SFLule/3gOCvP9JV8/2ZMJdsBjNh8BiEI163dpLZaGUi5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O63Zo9CVw6tLu9AmWzCRCoRDaMmyH4/OstxUvNxdCuE=;
 b=ZjgeG4MgpvO69hBJM+O+jo+k9up4sHtZsV2VE41Zwe8HVe763NXaaX9NYyT40fZra/XeRYgS4H8U1zMF+bN+CykOoSBT/kn+Oabt4vFTJUkrALBnrOXQQ0D/cFWUineYzBty2/N8ibszapwS4xMfd6ijhn4l+kPbuJ9FnCTTHGo=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Wed, 13 Jul 2022 23:27:27 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::80e:be92:1fd5:b066%5]) with mapi id 15.20.5438.014; Wed, 13 Jul 2022
 23:27:27 +0000
Message-ID: <272ea76d-0099-873e-b8a8-1cc43b7b1e11@oracle.com>
Date:   Wed, 13 Jul 2022 19:27:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Jane Malalane <jane.malalane@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Jan Beulich <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        xen-devel@lists.xenproject.org
References: <20220711152230.17749-1-jane.malalane@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220711152230.17749-1-jane.malalane@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24043e95-fcd2-4ca9-87b7-08da65273f9a
X-MS-TrafficTypeDiagnostic: DS0PR10MB6030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNLyvlVDc6T59bS+lOZkTDBHgm9qzL+qn24KDZW22dTvbuZN+wurjxQYhKwdDGGnmTr4uoV5aqVokZi6NjJBaN8Iem/L0lpOKbl8Tc20gNB/69KvwWNTkmfDRrKoxzsebfDF1AFfWjo+VLwvVIR3PG6vxcXz782ZxmTxXtuOZSjD9LWUwbM7Q9IcfLxfRz/FJJpSNW1WRsqKMMeXL1/ys2PKsCN3WT08CAs7ViDpnr0KYSt6Wx018U1zaX02uAdh7Aaw7BYHVAQL5FYcxFTmq5/K19xzqJBpfwMVyWpcavTDn3WfXJ3H8ixTsFRU84sVjZX/8zzicg30/f+/HtR7cJpJMvwafVFLBk7Yeexz8osHCeJHF2CaJbk1c6dORAAFkVSNGs8lYCINCtmuHepvHH9lMGyvyvowUHkxdtudtN6ghNTKAa0IYkDVbNR+Rk+EssilgMqrGqVoeyqCbw5ONHpdLReO+GJYX9wEJYd9hBRsW0rIuh5ZPjbrF5czfEjIMvfDBZR8Qrca66C6ymmv+OGmcaHDMMKPo0cPTSdNGrjEKbMgwMvVTkCy6TmnGtYISTsXY9ymZZnspnYUz+JrbYf5EKwT3MXVImJgE+QpJEitjPj9kbSXVO2l7JjlUB6zBPoju7GczK96SXcyCTCtzddPEyTYZ2ZnXYTWfcDlJ53Mrg8Ih2Molw95x81YePf/bWrlaTbujMPy25gGJwJby898/R1Um4QTD0gaUyj8ifx9vtlMw6Z3VpAyyE5TWjmCU4FHpUChGGB7M29PoCI74gqTa3ua7ndpNSLT/E9+govN7EULdHbjgX0y7NUy9jB/8SsQF61eRextfgAkkeEY4Lrsg3so/L1/54eNpiinC2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(346002)(396003)(186003)(66946007)(8936002)(8676002)(478600001)(4326008)(66556008)(66476007)(6512007)(38100700002)(6506007)(2616005)(26005)(41300700001)(53546011)(6666004)(83380400001)(6486002)(2906002)(44832011)(110136005)(5660300002)(7416002)(86362001)(31696002)(31686004)(316002)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtSalU2MzZQOGRpZHhTWUZZZU5CV0swd2tZM0phOTQ4VTl6cWVLS3RFZGty?=
 =?utf-8?B?cStxWE5wMlEwYmpPdGljS0lQWTJxUXR2Nms0WVZDRmtlVjNjZG1DY1RleFJu?=
 =?utf-8?B?dCt5Y3JQVVVBRTdKbVFTY01vNEhlQ0xEZXVDOW0wczF3T29SVjgyYXQwd0RF?=
 =?utf-8?B?M0s2c1pIbzAwMm01QnRGOVVmbitUSlYyMG91V1IzWmNSWlBsNVdRSzNPclpJ?=
 =?utf-8?B?dFFYRDJZcUxKL1Z3YldxSFllNEVwUFJ2bExYSWwrZHh0cURQNGVTUVh4WEE0?=
 =?utf-8?B?NUwxT3JTbFlOdnJtQko3OTQxd1FjOXE5UHl4VExjWFl4dUVuQVNYdDZsaXFt?=
 =?utf-8?B?NzU4OUgxUmRUNnRmSmJGWWNMOUxaQmRXaFhjdWpuV3ZxKytaVVVVVkdYcWpG?=
 =?utf-8?B?eGhQbGZRMHF6SjEwV0JKOVgzdVJyRitQZXppMVB3YXk3UE1PeUtoTVlZVnRq?=
 =?utf-8?B?RzRBRDlacVJYS1o2aFRVclY4RXltVDhWYWdPNnpFTHNWd2E1WmZvMklQWXFE?=
 =?utf-8?B?OHRqbVV5VXZCWWFnWUlaUjdTSVJKOG5ISFc2OTZXSVc1KzZoUm55S1BCRWFU?=
 =?utf-8?B?WFF5NnUwUnhxYStPVEwzR2xyZnk0cVROMGE0dWlSYXlxeTEzV1NBV2N5c0du?=
 =?utf-8?B?RUp4TnFTRzRUWWJIbkV4WWNpVkdranROdlJGRkhITExVcC9oRThUOWQ4Qm9W?=
 =?utf-8?B?SW9UZFBrNGpIem9DTUxNRC9RT1JRV2hibkdOb1FCUXVMSURtWGhlZGRpNmFh?=
 =?utf-8?B?SEtEallQKzdoanpjcGI2aFR2TFd6RThJQS9FT1p3Q3RTSWYvZElBb1cwS1ow?=
 =?utf-8?B?RHdFMzVlQ0h3UzBDSUVkWlMvSE1sbmEydmRoNmRLVnJwZXM2dmxuRmN1dXdv?=
 =?utf-8?B?L2FuZ2ljRm5RVlAzRG03V1AzSWdQaFQ1eXBiYkJWZHp0ejNidzRmMjR5SVkr?=
 =?utf-8?B?OEZ3eHB0Z2xkd24zaFdEbDBNTjU3VGhkS1pUVWYvNlA2WWJwZmVmT2U0Q2py?=
 =?utf-8?B?c3Q4ZHFwSFhYWWpxYkt1eXNZNXNENEwyQlJGMGJlL1Fyc2M5dXFpK0Q5UFJC?=
 =?utf-8?B?NG1PaFExOGpaWDlWVk5QTU4yRVl5azlJQ0ZZalNEZDF3ZVFHM2ZsUjl6UU9i?=
 =?utf-8?B?K3lKenpld1FhM2VoeEt3Q3ZmaE92cm4xeWgyaTFIb3dxVnkydTA4QncvdEFj?=
 =?utf-8?B?eFA1b3ZiMHhCcjgzQ3Yvb0lqWThSRzFVQ1htRXg2disvS294eFlxSk5KNXhj?=
 =?utf-8?B?TmQwV05peDlyWmxwalQ4Vkd2Zm5YNjhlWXpJbUNRT2dnK000OS9IeHBzZktV?=
 =?utf-8?B?cjk5cEd1UXYvODFLTUZBKzB0a1J5aVhXQVBWRDZXZTF5T25JTTNtMWJwMEs1?=
 =?utf-8?B?aENOZVZqOTRPZUZ5ekJhS2p4bjNTVDFhdHlzcURrWlhNS0VQNHdTMDZIaXpT?=
 =?utf-8?B?b295anRydDBCaWwvRGthdkZnODFXa05yekhmR3RDYTZzK2xIcS9YOXF1TWdZ?=
 =?utf-8?B?LzlGR3ZvbWp3QkFKZWJhalNpVmJiVGxmWlZRTGF3L2d0cmVCQVN5TEo3bWZB?=
 =?utf-8?B?ZnpTdGRWS0doOW8yZjNsVXVYZ1VOeWJ6S1lPVmo5T2x6RXdLR1dGYXcxVGkz?=
 =?utf-8?B?bWNmMytGQStnbmZPK1hyWGdIcWpjZWhHb0VTelRNMkN1MlowWjRLL09HeDBp?=
 =?utf-8?B?SVNCYWh1Y2VsTzN3Tlc0R1BjRkxzZkhzUHZsVEFtKzhSQVg3UzIrY2QramJ4?=
 =?utf-8?B?a1h5b0pTSmJtdmYwNUh3bjFQQmhLVEM1YzUxczd5M0hwb2g1Z0NucUp5RUJi?=
 =?utf-8?B?cnN2NnM4L1BuNk1Rb3pMay9temRxZWtFZWd4SU5MRm5US291YXgvdmcvamVJ?=
 =?utf-8?B?MGQ5bmkvaVJ2eitzUUp2WG85YnBHSzhQYm8vbUJZR2JyUlVvSlNneDNzL1JH?=
 =?utf-8?B?NmJxcC9zcXFHeGlEUGtqMUhTcTdYeXVaM0dqZGhZSnAxc2ZINmdEeUdMTmxo?=
 =?utf-8?B?NlpqQktEZVJDaG55SDBVdDZxRWhPdENiYkZGWjJweFg1YTlBTHFsUzBmclRz?=
 =?utf-8?B?Q2xIdmtlUUcxNHJhcmdEMmF0UWFHQmgrMVFJbmg1aWpPVkRDOHUzeXdrQzB3?=
 =?utf-8?B?Q0JsdE1RWFBqKzNWeVhsZDY3TUkvS2kzNlZTU3ZFUlFKQnJoV2FaVm1rRGdj?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24043e95-fcd2-4ca9-87b7-08da65273f9a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 23:27:27.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkqUsdd+wnjkiwxLfFTLX53KoFHIWY1j1B6LXLNg+EQ/Lo1jtXzfF/cUkSX64ik8tYruWKooJ0ILj5SFw1pkpY6T8PiNbbAhFd7TFI76RTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_12:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130094
X-Proofpoint-GUID: VUyLlksXFZp2kv0TacYfIQkJFJiU0Xa2
X-Proofpoint-ORIG-GUID: VUyLlksXFZp2kv0TacYfIQkJFJiU0Xa2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/22 11:22 AM, Jane Malalane wrote:
> --- a/arch/x86/xen/enlighten_hvm.c
> +++ b/arch/x86/xen/enlighten_hvm.c
> @@ -7,6 +7,7 @@
>   
>   #include <xen/features.h>
>   #include <xen/events.h>
> +#include <xen/interface/hvm/hvm_op.h>
>   #include <xen/interface/memory.h>
>   
>   #include <asm/apic.h>
> @@ -30,6 +31,9 @@
>   
>   static unsigned long shared_info_pfn;
>   
> +__ro_after_init bool xen_ack_upcall;
> +EXPORT_SYMBOL_GPL(xen_ack_upcall);


Shouldn't this be called something like xen_percpu_upcall?


> +
>   void xen_hvm_init_shared_info(void)
>   {
>   	struct xen_add_to_physmap xatp;
> @@ -125,6 +129,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
>   {
>   	struct pt_regs *old_regs = set_irq_regs(regs);
>   
> +	if (xen_ack_upcall)
> +		ack_APIC_irq();
> +
>   	inc_irq_stat(irq_hv_callback_count);
>   
>   	xen_hvm_evtchn_do_upcall();
> @@ -168,6 +175,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>   	if (!xen_have_vector_callback)
>   		return 0;
>   
> +	if (xen_ack_upcall) {
> +		xen_hvm_evtchn_upcall_vector_t op = {
> +			.vector = HYPERVISOR_CALLBACK_VECTOR,
> +			.vcpu = per_cpu(xen_vcpu_id, cpu),
> +		};
> +
> +		BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op));


Does this have to be fatal? Can't we just fail bringing this vcpu up?


> +	}
> +
>   	if (xen_feature(XENFEAT_hvm_safe_pvclock))
>   		xen_setup_timer(cpu);
>   
> @@ -211,8 +227,7 @@ static void __init xen_hvm_guest_init(void)
>   
>   	xen_panic_handler_init();
>   
> -	if (!no_vector_callback && xen_feature(XENFEAT_hvm_callback_vector))
> -		xen_have_vector_callback = 1;
> +	xen_have_vector_callback = !no_vector_callback;


Can we get rid of one of those two variables then?


>   
>   	xen_hvm_smp_init();
>   	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
> diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
> index 9d548b0c772f..be66e027ef28 100644
> --- a/arch/x86/xen/suspend_hvm.c
> +++ b/arch/x86/xen/suspend_hvm.c
> @@ -5,6 +5,7 @@
>   #include <xen/hvm.h>
>   #include <xen/features.h>
>   #include <xen/interface/features.h>
> +#include <xen/events.h>
>   
>   #include "xen-ops.h"
>   
> @@ -14,6 +15,23 @@ void xen_hvm_post_suspend(int suspend_cancelled)
>   		xen_hvm_init_shared_info();
>   		xen_vcpu_restore();
>   	}
> -	xen_setup_callback_vector();
> +	if (xen_ack_upcall) {
> +		unsigned int cpu;
> +
> +		for_each_online_cpu(cpu) {
> +			xen_hvm_evtchn_upcall_vector_t op = {
> +					.vector = HYPERVISOR_CALLBACK_VECTOR,
> +					.vcpu = per_cpu(xen_vcpu_id, cpu),
> +			};
> +
> +			BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector,
> +						 &op));
> +			/* Trick toolstack to think we are enlightened. */
> +			if (!cpu)
> +				BUG_ON(xen_set_callback_via(1));


What are you trying to make the toolstack aware of? That we have *a* callback (either global or percpu)?


BTW, you can take it out the loop. And maybe @op definition too, except for .vcpu assignment.


> +		}
> +	} else {
> +		xen_setup_callback_vector();
> +	}
>   	xen_unplug_emulated_devices();
>   }


-boris


