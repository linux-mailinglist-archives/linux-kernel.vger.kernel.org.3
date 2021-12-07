Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6346BAFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhLGM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:26:51 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:45323
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232053AbhLGM0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:26:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKxX00wINZDfEymiOshX682Zbj0n37paB7v3wgHq9N5GrPF82mzGpmhDFHHOutAit+UwVINii8VWM4aLzBpeiClYytu8WkUvNrdFlDzNWsMFfN4HzKnshmtXWaj1Pp5C8ho3kVHbJP1gRB8/PFOx8/NQ0JTt3mpVHseQHX2V+ds8D0U0BzoJouNsvHGVEyHuHDbKudXPFzR2IP2LY1gILn9BNVe6r28pHJpcRALGVolL9Hqmmb1WBfirILdUb8pKhS1cVXqfi5MSBiR57uZd7/RLuZUqQ0ECl2obyGyDHOEc2KlTORHxEElIfrnKD79jafTQbAj0QTk1nFORXkqinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm2tb7QumsYopIQV1/8dKuiP4ju0hc66gu0qhe9dkWY=;
 b=U2iq88SZWprBaUv/a1qikBM7sBP8vi3j+UtmJbe6lj2zmi0N7qjOPXV1LglvI+rWkJYKmbshGMiTPeUef8rbi+fszgnu2y650IQNJCOZG+KmHMQ+vbmxBjAxleSHULK7HHPvRk0W9oCEdIt3P+pN6IQ4KPYrvNHcjxRsz8lOoZVBhqKFDKULmyENU1xV8kxVisfaPUQjAsMMrrr05rZwzkhJ+AZ7H7iABKozgPqG1DXVt9DNpwgXR5hyZVG1C/k+C05OXh/wvLExXqJkQMM5bB1KbXWi3lPGsg3sQAx7uAZWyZcyysF3YcfWZsRUWhjr6tFe/U1zlzZdN7zFLZnU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm2tb7QumsYopIQV1/8dKuiP4ju0hc66gu0qhe9dkWY=;
 b=iKmf3kuxhSyUoT7J16AAuRb6pcNbyx3k4wfsQNyctjp8QxzGzFCdmZJKKw2KleyWsnR3K5NDLIuzWnIMOz4RdbLT+xKnUfWzFDV7hbN1xoBXPG75oMx12J97ofekEQiQDBPWZ6STD22X5QleYRifFAenyEeeqQUMGuVZCecElkG6xdUwyJ2HLYsoPqqXJZCXvtzz1CYrYYMhiOQrXmNf+USmY00kyTO2gph0hhizNi8scBdbtuSkQpotvcKuwtQWA+DMSMH9lgnljmA3Dl0E7nZkTYQaTALK6NpMs6g1aDLWX7r6KtI0PYLiS/5288aH7fyCpMR9a4sX2qVKntjX0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by CY4PR12MB1893.namprd12.prod.outlook.com (2603:10b6:903:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 12:23:17 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 12:23:17 +0000
Subject: Re: [PATCH 2/3] dt-bindings: sound: tegra: Update HDA resets
To:     Dmitry Osipenko <digetx@gmail.com>, tiwai@suse.com,
        broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, perex@perex.cz
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <1638858770-22594-3-git-send-email-spujar@nvidia.com>
 <13d20227-ec6b-03db-01dc-b4b00038a15c@gmail.com>
 <03a5094c-0c53-98ab-97cb-4b27ed1b7a38@nvidia.com>
 <42161fd5-f3bb-a71d-710e-b7078e294a0d@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <31e2e1d5-0d98-2a92-3ec0-496c81ac42c1@nvidia.com>
Date:   Tue, 7 Dec 2021 17:52:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <42161fd5-f3bb-a71d-710e-b7078e294a0d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
Received: from [10.25.102.117] (202.164.25.5) by PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 12:23:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21c0173d-5afc-4ac3-bde1-08d9b97c5934
X-MS-TrafficTypeDiagnostic: CY4PR12MB1893:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB189353E895A7E6D4147AB8D6A76E9@CY4PR12MB1893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHm3mATkV50z5godwfDfWoqNXG9k+Q0+o4t5HG9/D+d1J9NL9N5EzGvbDTugUxh6EXsnq4Z/SE4w11kJ61IvjsfZs/BVV94GLePSvdqw59oW8DKzukn3LAFroIcdfLG9q9uKAn/BRTH1miE1naHyRHWOxon0L5TPjukDYtUeh7OUlVyIdpldWOqNVyINz09NdiEmGaorJpJzFkwa5GtbAyVz10B7gD9bk/4GXYCTvjIyhNl0rYZrOhH+lDfteXcTe4M+pwJAOVy0cJHCRP8xEPPnqFkwZKWm3SujiXvA90oV74nwt1iSz/JqhuNtbIb6JLjt3G2sKzzxYeNeF1+BRXNEKpWqrmZPUmZu/ME0AwsbCh/qLXSlsxpq0zySA/dPXWVajs1mJhpTmsibWnThDWB4nhhfyPtKzZ3yV2iA+uaxa0+eTsKTsrCha7D/HCAEHvVog624ygAhRSnpdAfx3MKXks2YDFuziw6bEnUa9luOV41ZnmOXdc1SJkj86vhgvrJzyy6uNG09QQG2rtBJDeQSxfq3z6eaETXiSyH4eLZ0jt7/K2tAosjk0QqubQzQMrnxpUJjqAs4DAmrnIzdrrFxUDEfdE10dmMsvBBHcYIRNkJSjERcLtyo7EPh0Qs3aAfPlCAZSKBXfiq+mxXfdjh04dPNmzaRSJ9t4Od1c/hDCsLPOhFcCyKp3EqMFYPJd23+V9AJwBaE2LT3Za7uXcSjxtkh032sl/gTD66Tuec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(36756003)(8936002)(2906002)(6666004)(316002)(66476007)(16576012)(66556008)(83380400001)(7416002)(508600001)(86362001)(38100700002)(53546011)(26005)(31696002)(31686004)(5660300002)(8676002)(15650500001)(956004)(186003)(66946007)(4326008)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxIZG9WRGZ0SkxaTkVGZ1FoZzkvV0d0dVBnSElwYmNpSFhHRDluRnRTVlZ4?=
 =?utf-8?B?NzdNaC9GdVdrMUJXSldwVHhjRWtkK242emJNcWc2cmo0TlpBUVhHMVA1bFRo?=
 =?utf-8?B?Z3NNTU8va3Nvd0hDT1UzYWVuNkJYaEFKTHhnUDZaVlFkZU5lcnlnaUFYOE1W?=
 =?utf-8?B?WjR1MjhjOG5ISWpVMGNoMlRUcUphTUlQd0ZYaitJODJoQkJlbWZZd25zeXVm?=
 =?utf-8?B?dEFRQzltb2xBMkpRZFpybmxOVU10eEtLV05OcGt1eWlwdDlJdEJoejdJTlRK?=
 =?utf-8?B?Y3lDUmZtWk94cisvWWloZHFmKzBCRlBjWmtPNm9objhYNGxkNEowbUJvN08x?=
 =?utf-8?B?UGs5UnBnNWhEd1ljOWtlMzNmcTJZeXJZMzlUUTRXbWlFK2t5b3ZiaFRiaFNP?=
 =?utf-8?B?c1FPMnNILzA2Vkt6aVVqQjJUM0Z0TmNQOWRDRXora2FCME91VC9nV0FGUyt6?=
 =?utf-8?B?dlZnbnFmZG9FQTh2ODVKSVFhcGpWTEQwemtQZFdUSElWQ0hIYXVTVlFsYUVa?=
 =?utf-8?B?YVRLWjVFNHE0TFNuN056T1h6RFA4WlVBaFMrb0t4VHpsRWhMUXpGV2sxSStp?=
 =?utf-8?B?MnJYVWNDQXU3SDRUTTl6YzNsa2tjQXNHNjFiY0s0eTBNdzhMU09MWTlra0RJ?=
 =?utf-8?B?WjlPUXU0YjNXc2xORWJxeWkwbTZZbXFOOWdTYzdYeGZGUERpaFpSRWNmTzNC?=
 =?utf-8?B?b2hjZ1MzNUZqWHZJWUhiZ2R0WmpkRGpNamlNcGFaa2pjU0kzQzZLcHJTRWVQ?=
 =?utf-8?B?ZlhMaGhRNHk1STlRZDlUeGZzelh4TVU3cW1OMnRuKy9QbkZEWUVETmM1SkQx?=
 =?utf-8?B?UE5Jc241NVdwelkzRzZ4cmcvWDlKR3ArY2EzeTgxanVtYzUremJKSW9iZjVi?=
 =?utf-8?B?Umh0L0hWSmRyckEwTXpRV3ZrQzZlSWZvc1p2T0lURjEvVnZoV21pK1JNVTls?=
 =?utf-8?B?eVoxcXIreWFQeStXQ0FCckFTZmorbEF3U3FYQmwwS1p2ajFlcWhVYmpPcWJS?=
 =?utf-8?B?d2FTYlhscWduQkNWczZTVWc4cXRDNlRDWUo3U1Y1UlZQRDdMZU9mY09rMXFL?=
 =?utf-8?B?NkdlbFZCRGxVdVdueHFZblhKT21FVzhvMlNnMGVWejlKTkRZT0Z0N01tdGVN?=
 =?utf-8?B?Q1ZvM1IwR01ISUpCNWdkaVRrVUt5aEhoNG5CMkk5UGV0bUVzSVYrU3AyT2pT?=
 =?utf-8?B?L3RqVTVPeFdnaHl6WS9CcnBML0c0bW5ZOUhuaDdHZW4yajB5V3BOU252QUdC?=
 =?utf-8?B?RkU1MmpIL25tejlCaUc4NGN0Y1J3WENPOUxhQUo5ZUZSY1FkcmNRVXRYeVJP?=
 =?utf-8?B?MjdoQjRmTXdkOVBGSEQ3M1hEMDdFblJ3RThuVjFGY1pqZUxuWjBlaE56Zm9a?=
 =?utf-8?B?S0ROVkFETWtmNXNvU3BBYnMwcm9hdklUa0o5Qm4vVnhsd2pCalg4UWNYc3Rr?=
 =?utf-8?B?NGlVOUJLQjQ1blFLVXRCblZSbkVIdUw1ODJBU3NMV2t5eWlFUkdpUGJoMS8r?=
 =?utf-8?B?ditIRTV4a0grR3owMnNIVGdmNnpaU0VJQ1d4aVZMUy96WkpIL3FrN2xoSmVo?=
 =?utf-8?B?WXQyM0o0REhHMjRmUnNoOUd2K2VQK2E1djk3WFN6TGJoVHQzNEZXK1BBeUMr?=
 =?utf-8?B?K1B0S2JjVkZDb1phY2xEa0lsbFAxTDdZTWgrRVVnL21DMlVFcWZQRjJjZkpY?=
 =?utf-8?B?Wk5DSVRReU9vWkRBYVdJKzM4ZlVabnUwSW04bHpFRDNkOWZXeWkwU2liZWUx?=
 =?utf-8?B?ZlRDNlNyV0ZDbDU2b1oxYmJIaHpVK0pFRVlGcjR2VWxSY0JmbHcybkZYMnpB?=
 =?utf-8?B?R2gwelkyanpxeDQ3d3hPS1c1ZFk2Q1ptV1B2bUpndkxza2wvN3U5T0hQclh4?=
 =?utf-8?B?cFN5YnhuNzROcTNMTGVmNjAzbVBjUmgxYUM5TktjdzRtK1ZLNldmaXM5MmVj?=
 =?utf-8?B?aFVTTi80UGFYa3g1TitiU2ViUFBkNUtWd2lHUTFxZVJSb2kzZG9IUEZsWFhW?=
 =?utf-8?B?ZmJBTWYxYUVJaTVVWUtKSlBHMldTb1FHbjZuR0s2SkNGVzZ4dTUzVEY5cmxj?=
 =?utf-8?B?UTNGMEgwUi9LdXZrLzZZT1MvMXkzZWRmMTJWaFhwb29lSlRod2xNZElCdENs?=
 =?utf-8?B?TWJsWkFOdXdXOVA2VXZMMTB6Q0ZuVXkwa2RnN3ZVZjA1ME9qTmZvd1U1WUFq?=
 =?utf-8?Q?oSywws8PFqxYH34hPFS+SAY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c0173d-5afc-4ac3-bde1-08d9b97c5934
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:23:17.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CX8XAMeuL1Dz15juDV+a527VpMRNC02OQmSA9QcXa6CxnJjtD9+0NquHEEMPdwkofA5urpQTki1gBDYzSYAPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1893
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 5:32 PM, Dmitry Osipenko wrote:
> 07.12.2021 14:04, Sameer Pujar пишет:
>>
>> On 12/7/2021 3:44 PM, Dmitry Osipenko wrote:
>>> 07.12.2021 09:32, Sameer Pujar пишет:
>>>> Tegra194 HDA has only two resets unlike the previous generations of
>>>> Tegra SoCs. Hence update the reset list accordingly.
>>>>
>>>> Fixes: 2d8f8955fe02 ("dt-bindings: tegra: Convert HDA doc to
>>>> json-schema")
>>> The original txt binding was already wrong, this "fixes" tag is wrong.
>> The text didn't document "nvidia,tegra194-hda" compatibile support until
>> the json-schema conversion happened. Perhaps the text doc was not
>> updated when Tegra194 support was added. So wouldn't this be right to
>> use json-schema commit as a base for this?
> This problem didn't exist when the binding was converted. Should be
> better to drop this tag since it doesn't add much value and creates
> confusion, IMO.

It is true that the problem was introduced recently, but from the 
documentation point of view, given the HW never had this reset it should 
not have been included in the first place. If it is not useful, I can 
just drop this tag.
