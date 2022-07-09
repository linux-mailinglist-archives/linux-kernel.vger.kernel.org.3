Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A6156C929
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGILPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGILPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:15:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2049.outbound.protection.outlook.com [40.92.23.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12251F62B;
        Sat,  9 Jul 2022 04:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCTQdftFcaQB9bL/3WvHC1O0pgx/N17mj70xAi+qVPr5JP3EKhIxPiaj0Zy4QuuvS0lcS96lOSnFti2m6SFFZbkVF8eabozFidq+s4Jb51r2sRl8xYtclX4qDvzDxGOXjRFP+OTDztjOMsQ87H6pqnnTAabQdTCJMHMMQKTrxLY+ef1E7nsDAZASbLZL3qvWPc2F4NtdsB0bTe6ZWvHfZl4d/1lyqa1xfoNFQXKNDG3og8/HoX+KMiYy2UNj4HJQU6gakxLGpQMguz25Or60FXyailxEV3Cz1HVE+0Dg14YTx0iOq2SmkyswDmPf1omX0V/Oh+uqBha7GsRNfn3PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9HoB2u6cqzg77iF4lhyKDxMjl4FsKFBdRJT5E2wLw8=;
 b=TwWhsNqTTIsTWtk4GkJNdngKXqrrABInE7HrUhjNx0BKhJxE4eABMjRGt/GfJsL4QokJNz2l1eKmZcDbNIRCypWCJDqGhYS0JfOrCV2S+upcR1VhKmk1Wdel4kkHo4h5GXgtKpLzqi6APiho8syVmDWoe32mYuSLwDnW7P5p2QMUq5kGCsPlDzs7GMQf6bz111msKGGroP3C0MNju9FSA1bZVFQTZVXKswWz1wV+K4DDl6n716VFLamO0M+6ZXijT3MDU1EEZqDz5DTvixGyUQo6GHWjTypb0nT8KZ3W5hoMpE1pYKFkqkZRgZ1cTg24TAIg5TmjoEX5IxQB3ZZn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by DM6PR02MB5852.namprd02.prod.outlook.com (2603:10b6:5:179::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 11:15:47 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%7]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:15:47 +0000
Message-ID: <BY5PR02MB7009DA0B33AACEDA9CB403C4D9859@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Sat, 9 Jul 2022 16:45:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH 0/5] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <MN2PR02MB702415D7BF12B7B7A41B2D38D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
 <bb78f8fb-d6ea-5c37-0531-8d7584bc897b@somainline.org>
From:   Joel Selvaraj <jo@jsfamily.in>
In-Reply-To: <bb78f8fb-d6ea-5c37-0531-8d7584bc897b@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [y1YU+MW2x11LD958XQ8D0vJAB69CRH+coxnwuuDZznYlBIKLaHIYvzEGwmZBW8jZ]
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <9924c4b4-87dd-fd7f-0760-3aa6e9a728c8@jsfamily.in>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d7cd90-e073-4af8-16c8-08da619c5eec
X-MS-TrafficTypeDiagnostic: DM6PR02MB5852:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di6eOBhpZwMJhrGAH65EadDIr+QcJQOPCydIRsOZ5IkMRCQRP3ScSYTBnAGyWfhY5bfupNtRAu/3aAKmItPbC6vhGzJ+c432gngOeOvxMD0IP+mDC2pbhf8Y6yRZ6FqvpgFlVw0Hpmp2qGqaopiAWJO/sbdQSRVLi+vIkeytDTQv8EZCVWH9GSdgq4dQng1Xu7bUCm0LGIGtvQDX5zip6jSje3GCHVX+6e1/Misfow89WDJm88RK2xw3LjNcegMGep6pnJuKDENEGr1VgIYLN+p6LOxsDeQ1P41BpdegAfFZBrU82sERUz4bGvwDPXMmP8pwZoc5WjA6azXGKVNquU/1TkMpZweVMoiCYhTfBL42lDkxWc8Yj2+ZIvdRRRr5rsBDIoZdPncaZoyo98bQkDLPVHf0ljCkqyXlDEnHJHYtx9/tJOpwIPSFeWYjg7j27lnrDZlBg4Zowx+N04KnlL5UJCmJ/Ft6oPmAVOjUsT4/6n4Y9G+G0VRotqHvJe4T/0yuqHzLDqta/yJNvDRVGgZbMosijxTooUFFrYmReBlulc8vbCY+LmPGPJS81j2Rhq6dVf4nO6ZMfChRi5FVOy4ez87KDNO/jYg3rNxY8hRKuxCiMuxal9VtCDSF42RYCXCLk7bB8hwr+cVLarA8FZdgHIy0w+33VeU2EHJRzjDXfrzxomsDtWxCcY7kfL9jFijHqLWE5VbNQXaqHL/VfHQmlX4ZZKFFVX+KeJGTOKc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm03Ni9oQ0lSS0hkOVYrTkg3Sk90Um5UQWZ1OTlpakdmeDZiSVVJcnpSWjJk?=
 =?utf-8?B?eVhJUHlsUWhaSW9Fc1hFdjd5TmUzOVhxMFQ2QlRrS2VxMXd4czRPb3dpSER0?=
 =?utf-8?B?RnlCQ3VPUGFsdW5oZENLaFVEaHFUWWtzRXRnQ0svMk15aU5yeWdCWW1yUUFL?=
 =?utf-8?B?YjVMMk1jVGFhRXpndVpLVXFLUDNhZjdVOUltWndHUyt3Kzd1UEZmN2RJbkZa?=
 =?utf-8?B?bzd2cnhpZ1hEcnRuTHhSbnZMRG9pbEdmWGxYNTZocjBvMVRXcjhpQTZXRHdO?=
 =?utf-8?B?dnlIR2hYZEw4WVpCbzJveUpOc0pyUTVBODNBVFE4dU0xRHR5UlZKV0FPaXg0?=
 =?utf-8?B?MTZJM0lSKzE5bFpyK0pqanBHT2RpTlVHVVE0UFJwYTJVQ2JydVVuSW05MnNk?=
 =?utf-8?B?a1FSRWZhYk03ZmljZGU0ZHU5aC82bHg1OGl6ellYVWhwQXpGQ3FoemJBVGtO?=
 =?utf-8?B?SW9kOG1DVjNPb2dHYTFybjFJMitIZXNRd1Mxbng1SjJ3V2dNU2xWOS8yWWFN?=
 =?utf-8?B?S0pOZml4b3ZxaUsxUSsxZXNGaDBoOWJtamhJakJ4eFBsUlgveER0U3I5a3FD?=
 =?utf-8?B?Nyt5aW1LQjJpOWEvWURpMFgvVy95M0JEZ3BpakRPT1hCM1JKeHp0WFNPVjQy?=
 =?utf-8?B?NlMvRkRqWndDdkF3MEZkQ2swYjZiMzBPc25NVEU3VHdOeUpwOVUwaVRBWEN1?=
 =?utf-8?B?MzdmcnlpKytUVys2cElYSGwwZk9vQVVpQklNU2dlTDJudXZrTWl3NWc5Q1dF?=
 =?utf-8?B?amlLbzc3SkVWMW9WeUhGZml2cUJnUkhwbmlRem1XUllRVWc2dzdWOU05QkdR?=
 =?utf-8?B?NVZPVnZ6ZTM3Nm0vRjQzeW95Y0EzYkN4Zi92NkZZN0ZuSmZiU0pFNHpYbzQx?=
 =?utf-8?B?dlFnalAydUd4OTgxeDJmTGxnZytNS0FESjdkMGpxSDVwTXV6Q3NVMnVVdWwx?=
 =?utf-8?B?dFQ0YVJzODF3OTBnZVE0eTdxVmtpL1h2eGUranJFMXZGMFl2OTA3NTUxajBV?=
 =?utf-8?B?S1BRNXRoQ3pCeS90TDJpWGU2V3YveDRMNDkzZ3VYL01WMTk2MnVxQk5BaDlo?=
 =?utf-8?B?MXFhZ20vM1p2ODNTeU9jNml1L24wWFdQcnFWOUdFRGlEWk4zdmUyOE85YXAx?=
 =?utf-8?B?U1ZaWmJ1NHJkUlNhdEpJUHRyWDVXbUNuYmg2V3Z1YXVTTVVlZVVtNk9GR3Ry?=
 =?utf-8?B?OStQQi9FN0wxS0ZtcXA1TjZ6Uk56Tm0zWFBuQ3lmcndDQjl3T3VmYis3T1dv?=
 =?utf-8?B?aC9pR1ZuTzlpUUZEMzVSRHVDcXBXOW16YmZ6QnB1bTkwbWhwWTF3bWtjT0tl?=
 =?utf-8?B?a1FxZTduQmp6QjZ0ZjUzZGxXSE93eitmSnBUclVoMXRyKzJCemdtRE5NT1NX?=
 =?utf-8?B?NUJKLzZLTEZXdGZpVFBwZUNramViMDBjTFljVGJrMEx2djAzMlpKZWxHNExj?=
 =?utf-8?B?RlFTV3VZaDJCR1RCMTlCaUpKY2lyb1Q4cFlEdnZLaURtVTAzcHRsU0FBLzM0?=
 =?utf-8?B?YlVxYWY2ZVhCSE0xeVZsOVFOR0pNQzNJTDZiV0V3d1lmYzNRcWNnUHNEbXBU?=
 =?utf-8?B?elFQRSsxZVJJOU8xZVI3OUpteGkyUEl2aUZta1VERUxGK1FkaUxCNGI4UG02?=
 =?utf-8?B?UTV6WDM4dEswT1B1YzJURWxyaVdXZU1BREJIWUtmUFFidlQ3WklzMW9OWkxD?=
 =?utf-8?B?ZTM3ZFIrN3NtdWU4LzR3Ny9jRVFPMlpMZS8rM3dNT1laL1k5bGNldWw2d1hJ?=
 =?utf-8?Q?xKCdNdOYnttZ8N9K8GfTx6YSjAkq9c8Gfnp+zCs?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-99c3d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d7cd90-e073-4af8-16c8-08da619c5eec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 11:15:47.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5852
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad Dybcio,

On 09/07/22 02:13, Konrad Dybcio wrote:
> I believe this is not the correct approach. This may work short-term, but
> you will have to prepare 2 separate images for the device and mistaking them
> may cause irreversible hw damage at worst, or lots of user complaining at best.
> Instead, I think it's about time we should look into implementing dynamic panel
> detection.
> 
> Qualcomm devices do this by parsing the command line [1], as LK/XBL
> gives you a nice-ish string to work with that you can simply match
> against a label. Other vendors may use custom mechanisms, such as
> a resistor / GPIO to determine which panel (or generally hw config),
> but implementing this mechanism would make upstreaming of lots of other
> devices easier..
> 
> This issue concerns many phones (and well, devices in general), as
> they are seldom made with only one configuration due to supply chain
> strategies.
Yes. I very much agree on this. It would be proper to have dynamic panel 
detection. But I am afraid if I can implement such a solution. It would 
be nice if people working on MSM DRM stack have a look at this. But, do 
we don't need to block this patch until such a solution is developed?

> Konrad
Regards
Joel
