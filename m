Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE675844EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiG1RY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiG1RYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:24:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B765646;
        Thu, 28 Jul 2022 10:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQJO/t5bRWx9xQWLy7tMreEuISWOSo1KW58l2j2uGCq97xQSP1Uwz+16BhaxO8oAYgFiopFZvswT1laursnJe9oXljLoPpORFXVZj/FtwFZwm55gkFpHMgrds5dtgrNHnkPEkulTSl4aU+LUVvZf+dDMuvwjo/SOdKeHFpjIZwqPLh2Ga0JR4AdnJdOWE10pOBvgQvqQYnmuJD8aSWzYvQCyfR7ZNmwUf2CBanALL/QpK7noCZuLxkHuziKtLKB5InsYZUE5N/GRnzfiCGskAZxD0umw91YzlUMyD1xfvCsqUmuHMZiO8IK3GGLl/GMQfwoJRaN3ZktXxqRUB8QH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+8npCijmG03kdQDaRvMGCcnNNCUP7FuyYilG4u7uOQ=;
 b=ogu0p7mY26CJ7Q06hmSw7IGoH1mqiXgUYVCOtzIDTxBaJVPriAAI4+dGlyJkbc8R/Oi192RalaBqCwf2XYwGN8zcK9m4SZoVYY6GJe2bH/GqRwf6c6YWSO/MjWu8jzI0F5jYS2fT547cidxu6YT7JoExNWzOnYjNf2VlLx/goUUNmVLvnKu+e+goeaYALwGdCa45L/JCiJMn518kJ05dQ6IXgGEwZJE1RwcdwYWbWtRQ7A8mETO4TpAqn+qL/2PgnRByNeeILYcaKDnY/XDcLNDdbx2JxtJiQ+X1kDGSN35Ns1JC0Xe+tQPha0NXdFH/42sL9+mlZeoFyvONE/aDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+8npCijmG03kdQDaRvMGCcnNNCUP7FuyYilG4u7uOQ=;
 b=ApASrzO86yTCnDd3EifVAf5NS0rYFQoGXTL0boBU4NUFEmJq7oBL8rUCI8OuSmBcQg25JU6WfZCOliJaMOkLHLW+ougVe+NEHn2Q/ma29eo2/QAkRhracyNeVSOb9dh993VUBnkwUEJQ2vkJl7JtYYFEZQZjxbzWXaMB9whpnEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 17:24:19 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::2ddb:590a:f046:b38b%5]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 17:24:19 +0000
Message-ID: <818ed83e-00c4-354d-753a-ff1d6d38b9b8@amd.com>
Date:   Thu, 28 Jul 2022 22:54:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: build failure of next-20220728 due to 93ce5e0231d7 ("HID:
 amd_sfh: Implement SFH1.1 functionality")
Content-Language: en-US
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
References: <YuLEvUKxrcwe2dZp@debian>
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <YuLEvUKxrcwe2dZp@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 946338d5-2df1-4272-8177-08da70be012f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4972:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfBHdvf3r5ni6A7z52zSSqsp9wOGcln7xoS/MLfZImpjgfPmIi/R+tJFgtbanBCGJBGbf43VICf830QDLanfcGhjsplhiyAzvV8S+59+Az7raVn1p/tFyT7KsjOqDy21aS+pPNtWF8m1NyZHakFOGWTIA7KAINKN9Pm2SEcVumnH6tj1SmPIfDdCEKVZgtiBf24ikcQ0fO9WO7sU5TISRHkowHnLbtXN8LWMxsXxSLf7MSeHqxROgAi71Rag11RLCT1thWEmylmS7ifsoinSHji0LKf02c4eBXdK3hJQx6mDOIkGsWiPVCfDvNiyWRe++x74nGDqC+7/6ertLBmuWD3bXFeFjv3s1CzSqfvBm5ZVmHk+1ogTHAY+5cv8zj1wQgxw25utIcGvR8vA3pF1CLZtDRfcXdv1HtpUSQpVyMyj7BAe6m8KxNjNIkRWi8HUc2tdKDFsJrS73khWTXzNo1TH82CPpprkNEJIBPyagUxQ9ORgYNs0QXLTASrZfOJ8Ci/23c7N90GMocmp5EXo/X/6Kt1xfC8RDChlOmHtwJAtzN5Tq1fUVMYSA4dTRMJfO4TESuSvW1/z8yBp6F91D1J0F8Ag61B8Z5n4j8k0+q4UfwXbQN4bfOd6DUE6yxO4nD3sqT8sY2ORWDMiwXjUwyz+huyvgJJnhpTfK/DR3HialBF05V0v9+49j0Wv9S8SB4uvvfTG75c0IGtyBnaKtgySLkLlfFS9vhRJlv36FWzUKiU0qbJYmAKLs2X56E/NSV2ih8qBPz6OZud9vle/rCGX/Q/n+OW1Y9AaAOSs1r9aK8gXeRPwCn13CdK/mRbiiqJ8oa4nJRJcxoyPK3HlySiQben5mLRU8DQRUOKS0W3g9OVdyZkMmPiDORKOZaucjTgHgASE+sm5hb6MHmHMSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(5660300002)(8936002)(66556008)(4326008)(66476007)(4744005)(66946007)(8676002)(2906002)(31696002)(36756003)(6486002)(478600001)(966005)(316002)(38100700002)(110136005)(6512007)(26005)(186003)(6506007)(41300700001)(2616005)(53546011)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01aelBjODFiNHRPWTN2a0dDaFR0a1hLN3QyT0k5L0RwWFYxL01iQ2dHdnhT?=
 =?utf-8?B?OVdncHNQZEQ3UjJWK2hjMXFlNlUvM0JFdWZwNUFmd1UvYS90d1dVQzIwYmNX?=
 =?utf-8?B?TDNuK0QyNXJLbmZvUkwvSjl5TCtaSVBEbHRIanUzdkdrektsY0pZb2NGelJF?=
 =?utf-8?B?T0dJNmFlNVVjV1RvZng1T3lGVFRvNHZ3Z1FObGNQeHBqbTZYcEI5Y2pUeWxv?=
 =?utf-8?B?b2t0bEVpZTcyMU1xMTJMc1VQQzhBT05OWWp4YjhhOFZrSzR6L3RiODhXWi9k?=
 =?utf-8?B?RHFxN3FOaFRjR3hZdjZaMG9WTys0MVNOazBGZkdWSFA3dXVVMXFaWkk5TXcr?=
 =?utf-8?B?WGEzT0dPRVRJWlNWVS9Pd2VyWlBEVTNTWnJjaEtwT1dFK3VITURMRXlkclJx?=
 =?utf-8?B?UEl4K1FKVjRaNlZWM3RvMXRibnBwVnFMVWtjTVNsSWtZVzQ2d2VRcFNnWEM3?=
 =?utf-8?B?MkhFbHJHOGdiNHFwcTE0MU8weHhLSWZ1REV2c205RVdvdDFrY3lLN1dRY3VJ?=
 =?utf-8?B?Y0F0eEpzdW5WRXgxMTdYMkFya3Mxa3dJbStJTnM4MjVWZmJ6Sy9YeHQ5M0l5?=
 =?utf-8?B?U3dRUGhMUUQ2MzBiUE0vUzV4ZjRGZmZzK3ViZ3I3WEJZT3FQSUdLRThHSU9m?=
 =?utf-8?B?YVNSWGtISXNueHFjKzJ0bHNtWSt6NVR0MTVjQktpcDNyb2xka2tyKytjcUFt?=
 =?utf-8?B?c3V1eFBwOVN2bjlxOUVla09keVRlV21UNjc1ZG04TTBoTzJrNU9uMy92Kzd0?=
 =?utf-8?B?NjdqVkhMV3BQVVVOREw5TkE1eDdWOTNIOHR2QURLa1BNdVlhdm9UZ2NURTg4?=
 =?utf-8?B?L2ZZcFZhUlFCeVpkd3N0d1ozRVd3NHg0VCs5THZmWUU1dlF4N0dUQW5wcWI4?=
 =?utf-8?B?SGQzcHRqUXpSNWpEeTZDM0NOSHpHa1BlN1JuZUxyY2JvUHJyeG1QdjJUbUxp?=
 =?utf-8?B?ZFVIWHZwY0ZSeHVFVzVhTWgvU3hPeVlacldiNGtWTXdER242YU9hTng2Y2Rt?=
 =?utf-8?B?UENqT0kzbVFzaUtJMnI4MEtsWTJSb21Yb25tMjBrdWJRbXVlbnhCR1U2Q2M0?=
 =?utf-8?B?ajlYdHgvc1dIb2xUb1dZNzNBdExDQkpMS1RsZkg3TWtyZENzcW1KTVF3TkRO?=
 =?utf-8?B?YnhjU3A4b0JDWVB2cERRZGtBcm5PcXZtam5UOFNqMEFKZ1VqaXdyakJVM2JT?=
 =?utf-8?B?RGluUHBpcVNNSnRORVBLcFNITmtya0RXalFGZ3BhY1VNMFZkVnRncFMvdUR6?=
 =?utf-8?B?bDhVai9ZQW9ZOTVaTTAyYm42eXdaSmxUdEdkYldLcjlFTnB4bkovYi81b29Q?=
 =?utf-8?B?THdQRVNTNGpIdVhFVWxGVVRiNlVHaitqRmJWWWxGajd0WTRLcEo5aFhJOU5O?=
 =?utf-8?B?cU1teTc5ZFExcTNzKzFHdk5Oc1BjRi9SM3F2TFg4ZEFGS29PbjN4dmY4UGIz?=
 =?utf-8?B?VmxCUEdDejQ5U1VCYVhUTFZuY0REaE1zQktlWFFNZ3pLaExWMjZ5UVpsRVp2?=
 =?utf-8?B?bTI1c0xocEZiQWd1SXU5R1Y0a2cyR05CM01SN0k3Ukg0YUVIYVl5RmlsQXp3?=
 =?utf-8?B?bmxxWGEvUGVkQithdWo3YWJDWDQ4bmprRzZsUzhCTFdBdC9HRE1TQVZVWEV4?=
 =?utf-8?B?K1lZckx5UDl4WUZqK0NaNDFub1JmdFdLalFOTURNMTRjSGNIb1R6YXF4dFpS?=
 =?utf-8?B?MVpTZ0tFaGF0a3NZVTl2THdsaC9zZjB0Z0NsVkYrZkhES0RwQ25ycCtxU0dv?=
 =?utf-8?B?Sk1FTnV0ZzA5cjFScXlXUE04NS90L0lLc1JGdmpReWVGSEgvdk5KOThLQ1ZF?=
 =?utf-8?B?V05odllza3pEZ0pqYXNLVlh5VnBhY0JMdldNZjRESWIvSVdDYWh5UzV4cTh3?=
 =?utf-8?B?L1ExWU56UmEwWlZIUVpCeHpLRlViMFYwTm41bFpsRFRISHNlN1BEQ0VqbjBu?=
 =?utf-8?B?K3hpTjNTRUJ4SXI2Tm4vL1hUMmNIZWVmS3phaEp4cy9qVGpjQmJ2QXcyeEY3?=
 =?utf-8?B?cGY5Y05TRG5rMUV3NEdOSHIyeGJPSFdmRVNxMVJUZEQvZWxnZFhzdHM3TzNh?=
 =?utf-8?B?NVEyNUJEK1V4S2VRTU5USGZLbEFCUjNQcitrYnFvb1JTcWlmdEhFTHpWKy9o?=
 =?utf-8?Q?KVKPYDgFvdH7HxUj9kWiWIOBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946338d5-2df1-4272-8177-08da70be012f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:24:19.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSVG+T4h7DvWcZe8Z9Jps50tZThL0CswPBtbht/CDeTIADtOIcv5hfOZGFxqg+sVqqcTcv5ClSL62EzLAT7gMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2022 10:47 PM, Sudip Mukherjee (Codethink) wrote:
> Hi All,
>
> Not sure if it has been reported, builds of xtensa, mips, csky and arm allmodsconfig
> have failed to build next-20220728 with the error:
>
> drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c: In function 'amd_stop_sensor':
> drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c:48:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]

Already fixed in https://lore.kernel.org/all/nycvar.YFH.7.76.2207232011090.19850@cbobk.fhfr.pm/
Also find fix in https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/tree/?h=for-next
or https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-5.20/amd-sfh

Thanks,
--
Basavaraj


