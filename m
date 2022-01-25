Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412A849BF39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiAYW7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:59:52 -0500
Received: from mail-bn8nam08on2071.outbound.protection.outlook.com ([40.107.100.71]:53312
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230150AbiAYW7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:59:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4EeNf/Hg4K+KAc7yf2epWJOcgLLI+SW179jlbHJLsM+LInGmXBRfdXiBOudbGH89m3lfEFYOrzSqSR54i3gve1jMhySXvb7pb7ABrLpaI6vjtfhFQYqL2bQsbq08xLdKd/ARPZZHq1JD6ifGlq9FgyQDQ4e/hwjMxbSiHGF12wxgHmU41dgs/mSH4c3ki1kkj5hyEGhrRCsFr9r37mKHzskPicGIHVQTeFob3tTSTwJYYfsHffO0FN5DrbIvXfxpnfHbcgUwFyb9o4GO1li7NApijjwdaEHgGH/+bVI2o2wwUwVW2JaKjgeFH9yINNgU3lvmMEs8Ynvp577jTco5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rii3PzFi1VXLq48K5UtlSUDM25Pa6x4sH+weE5p5WCg=;
 b=iTi6nZ2A98AY2xZGPcdf/8HOJcR4/7kSlsHa1HIUhW3a1xaDBjXvKEozbOp1u8eHhBLMjMImga9BLnMoAIvZM796qopgT0ow0E1hYhXpq5hQVj9EVIzky+8oOVDNPQzPKYIixke6qig7kawwMrtRRV0focH0pZmHqbuld9OrtcNl2UIWZ0df/NUIx0BpjD0kVOmkkTR+ql8au4M8lhbuYfiqg03rCeMvTr3DfMhdxzz9qv+uUtY8+SBMd4sbaXfA++Nqa/pwd6As1qpV+qN/+5saNdpNwh86Jc6y9puOv+QRgQa4LinmuSUwpyxBij5SgDBDynmiNSoI1PK1Ps2fjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rii3PzFi1VXLq48K5UtlSUDM25Pa6x4sH+weE5p5WCg=;
 b=MIJnH+JYRTzpBmEsvvRpBOGZX+TMbCUo55Ux64u+aNmMnz46k6ZJ8R5BczFfG9jgxyG/1KIhS9mUC2m1ktbi94DHbLrM6lqrwTMdCj+guZmTixvglIgS3f5Vuw7fVhbzrqs+LNOOO/q3pt5L/6T5yUaHriuuOAas9J3fq2cbm9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.13; Tue, 25 Jan 2022 22:59:49 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%5]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 22:59:48 +0000
Message-ID: <999b1940-3e72-be82-8acd-0634ae50cda9@amd.com>
Date:   Tue, 25 Jan 2022 17:59:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
Content-Language: en-CA
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220126094035.631da5e3@canb.auug.org.au>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220126094035.631da5e3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ede4b469-3cd1-4c38-0d82-08d9e0566333
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754DFF4131A7C11ACEA9228995F9@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krGpyYbKQfR1tmrRsQ36qYWhYfjm3ZrTMH9DSCAiLylV/6mH0FrSmqW7AoFvu8pDZ5J4Cddg0lF/i0PCo2z5MzmO5uaH3SVdyvv6rIaK+qiedxmgRn0pFZzFY5QRzS9414fGBZhDsM8L/TiHrAxkNuYCuF2ZPStKNazArpPY+5dj9pAQw+b2wXCOGmB2/KqDc/qWLfZ1jXXRes3/2dSJvMzNKEcUVAKPePuAskxH0QDQP0Mlw/dkYD3b5jJq67lJuL9Rfabj94i4Fnr562RzuhveHj6WqqqEpilJugSNAJV7kVCvWpGvA+ZlT6zaaq3puGouxpWqaDQ8fwo08iieJo6lSX8QtOstZ3pBCfKETIzKstNDxqSgFcroq+luVG8Cv5id0NOzrGRXKFdLyA3WWFi/pupGAeDI1tzTcd+FuHmxxYV6soXAn07kFBx3PgM4Q5fZ17j+euM8A8GHqdjQNtLuZ34Y92CfF9fyoFP82dXgtHfyV/A5MVd1XqouOlNhdY9DvrOiZw/9wPYg1/1Ksr6eQcNV3/geOo4+FKGD+/WC+S+Pq3Afp6oAhrsfIinTnHXMGBcsAoXK535Tx9AMjeWD9Eo6LmAzcngj1rLJzJ2O3AP0CSwuOTCyxMmCqFhrkKI3b38MLo2Gs/mLNZJSzPhcaeRYxeJM2+H5JOb/dalHAwFPFnWRFlrLoZf436ZxnYZ1kOvGJUn1Yvwik7xqJ9PQKuLXxVTPr6B7nAmZWy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(53546011)(186003)(38100700002)(2616005)(8936002)(6486002)(110136005)(5660300002)(66556008)(54906003)(8676002)(26005)(66946007)(36756003)(66476007)(83380400001)(4326008)(31686004)(6666004)(6512007)(86362001)(508600001)(2906002)(4744005)(31696002)(6506007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnQxdG90Tmlrc0NjKzgwaExmZnBhUXV4eHhwM2hPZnNGcVFCU2FQMnlvNDly?=
 =?utf-8?B?cGVmUEpCTE92dHF6anowejFJOCs4Vm9OWkk4Y3U5aktKL2dmNDd6TFNodms0?=
 =?utf-8?B?Q3Nic2g1a2ZWTlJHbDc0NEpUemtrbmFCdmxTRlBQRzhISTNhTVRmbFNRdzFw?=
 =?utf-8?B?L1dLTFNKU3BJSG41bDl5VE1wb3dMeWhUWjlNa3dUdkR2dm5hdFRSTUhVa3dS?=
 =?utf-8?B?Nkc1MEFnd0srd0hXaERuTG8rQy9MV1NxOFJRSVcxdmJqK3AxeVc3ZUxuOGRR?=
 =?utf-8?B?YkhPVTcrSTVOUkNSd21wK2w4YndRVHpiMWFGaHNzd1BCcnJNTE5SS3o1NHVP?=
 =?utf-8?B?YUp1ZFpZL0xPWERwODd0bUNONndqWFB1T2NTMUtCOWJXaG1QU1ZMK21QY210?=
 =?utf-8?B?Z1o4NWVDMkpxZlZnOVFQVml3NHVjZSthenFJZU9ZTS9lZk1TdTBQcEUwckVT?=
 =?utf-8?B?S2JnTWdTMHFNL0p6Wk04R0VsUjV4K2NNU1g0V3JieTd4OXo5Sys3UWFFcGkz?=
 =?utf-8?B?SjdSYk14K1BPNlNEYVJIMGVtdG85aWxhQkFYbGp0aHZDQzQ3L1NGeGt5RVo1?=
 =?utf-8?B?RDlUdXh2NFdnWjNBTmltSHlURHNlR0U2VXFycHdpdWxoUnUxQ204MFBKU0RP?=
 =?utf-8?B?bDdiRWNLa0dvclc0L0xMcFVYTXVYS3VrbFJBZkZmNithSEJ4TTdjdXNESHFY?=
 =?utf-8?B?OVMzK1IzalQ1TTJhSW1jYUpvU3NSeHJsaGcrdCsvYjl3aUhJN0wrRHlEUmQ3?=
 =?utf-8?B?dUxNL1ZHZytSeXNvYno3b0lKV2Q5eWxhNDhaV04rTHdXVDNJUDVIQ3hHandK?=
 =?utf-8?B?VGhiT3ZRbVdySWFTYnNuWjBiemVoTHFQdy9HclFQNmhJTWM0TlVMbkJyZDJW?=
 =?utf-8?B?TEg4eWt0OWVlb0lWZ0gycytKcXRrRFdrQ1VOU1pMS05DaVJTTEV2WVJwdlNY?=
 =?utf-8?B?OVV0OWtKdlpVRm1CTUMvU0NOblY4UTFjWHdCRExpMkpCTEd6c01HWDcxUCtt?=
 =?utf-8?B?eTVuTjB1VlRheUhiT3U0VlBCak9yMUVQSEhjeFlHSUd3aXptU3FtMCtvL1VK?=
 =?utf-8?B?UVVSb1BSZFNpNGt0ZTBzVGZ5MU03WTRVTTk1eHhMR2RLTmRLcUh3MWNrRnF2?=
 =?utf-8?B?YUZXUnhqQlkxNzlVWTh5UXRaZXJhalFGckhlZjFkN0o3SitWYzFtUkRUcldk?=
 =?utf-8?B?Sm9xR1A1UWIxeFFEaWt6MUNSK2FDSlA5a1NiVDVYenptcVR1bVBESVBHZVBX?=
 =?utf-8?B?OTZlRk9pR2lKRWpuWERpSHprQzd4K0YzYWJ1bVpZMVhnVENPc3lIaXFKYklB?=
 =?utf-8?B?YmRzdlZ4anhZK1ZLVGtUVDZWWGxmdkZhcWZML1lieGlOUmhhdGcrcnFyL1Ez?=
 =?utf-8?B?dDRSVllxWVQrSU1wTUY1UFJSblIxT0x0eDlzYjlYQ1ZNVlRudTg5aHBHbWtT?=
 =?utf-8?B?VG92WEpLSW9IbFZtNmJuTzRST0g4cUQrQlFIOWE3bVliV0NDdmo5T2dsOWF2?=
 =?utf-8?B?QVpYOHJJTktBaEMzSWVSaDVRZVJjTWFwMmZReUY3c1lXQWg1N2UxbkhnSTM2?=
 =?utf-8?B?ckxrczJTSGN0ZEF6a2xvYkhTK1FxQXowcmpMNnBBUEhwTzRLSlRxenJnalVo?=
 =?utf-8?B?dERGdHg2UDBOZnErTzV4NXFGbDBJQ0hmN1c1QXlWWjdabjNXL29INXZsT1hW?=
 =?utf-8?B?NVQxOCtONitmZVVDL0NkK092RGt6WTkvWEc2d1E5M0VsMk40TEd2aGFxRkhh?=
 =?utf-8?B?TXd6ditLS2psc1AzUEJYNnBRTkZPMldNcklRVTVES24rUy9BOUN2Mm1acEMr?=
 =?utf-8?B?WktzdGg1QnBndXJwYXc1RC8yQmVvSlZ4TGlrYVJNM0gxODRYc2thVXJFMHda?=
 =?utf-8?B?Nnl3VXZ4V2JZR3BuMEpURkdoQkFaM0Q1SXlrcERQM3RCeCtwNjJ6YXdqNnNU?=
 =?utf-8?B?TGI4d3dOME9sZEdLakpMa3VFQUliaU1LSkJ3ZWlhdWZOTFIrNVQ4WlV1UTNP?=
 =?utf-8?B?UldoaTlxYi9FQ1dPZmx2WDJJNTNkMGNHUFdQOEZsdEtRb3BkMmhOZEU1alNy?=
 =?utf-8?B?NlgzUWJzZklPNFlPb0daekEzdjR2S1lqNm1uaTBOaHdjMDR2WEkxL0RuOWI1?=
 =?utf-8?Q?EbCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede4b469-3cd1-4c38-0d82-08d9e0566333
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 22:59:48.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urrb9IaQ0KY8qUEVNI/muVlV6dl1MiwJlUvEstFqNu7279OoKGIb7MGih4NhntbA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what to do with this, because in our tree, I see this:

commit 824c2051039dfc
Author: shaoyunl <shaoyun.liu@amd.com>
Date:   Thu Jan 20 10:39:41 2022 -0500

    drm/amdgpu: Disable FRU EEPROM access for SRIOV


And this is what I used.

Regards,
Luben


On 2022-01-25 17:40, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>   69bba523d97a ("drm/amdgpu: Fix kernel compilation; style")
>
> Fixes tag
>
>   Fixes: 1b08dfb889b2c5 ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
>
> Thus:
>
> Fixes: 1b08dfb889b2 ("drm/amdgpu: remove gart.ready flag")
>
> or
>
> Fixes: eadabcc2bc6c ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")
>

Regards,
-- 
Luben

