Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36E246B708
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhLGJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:30:51 -0500
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:6080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231250AbhLGJat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:30:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAf3b/hHMSt/l++GJF1QyZsPW997j3FVWVfL7oiVJATP5e1p+UUKEIRR1UwBgSBWZeFBHF0k2nyralTPvF6sNwKiFilrY7tRByh633k8RyCoNUI+Y+O9xBOYuBGsf6uXk7raH12UB8ByXyxLg6lHkL3dRWQs7IOCCLJlZaw0yWttoxF1WPJUlq27eUtKKe1OI9MN8Eyqoma9dpqjJiZfgenwo0SBj5j9/gNmE1kfaPceWjrhbZ1Lfb8ytLAXwMq/bpgygLjLeHNkD5BRg0JE2dlWlQA4SdIqGie70HlEQNwEkmvpwcvedkEb2YUMW8hVvem/B4/DIy22s88u9TDr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fjf2dzTDr6U6AElf4pP4bSKWVptvcsuR5J5uP0IQws=;
 b=aOg+MYMNTmWe3zQkKxVo+6hC28M5QWNPvGTHNx45OHk1dOuw6sQ+eaWDr9nUzTk7rAfuMzvSwb7BE1xZDj3e2HqHKQbdX8wPByyW6JaaeXcY2bZaV+ltD8rkXHHMwg+WUDELUZUya75cMI+P9zhARxrz8sSVuur/5gk2/AFinWd0baiHsdWGIxM5tI9qqJnn0UwjNDjXBG1HojdOUnrit9aw3sTSGESpPAqOeGSSkZvWV0CQMOvCn+XDtUQkdfwk8LwoyXwTvuMLvl+MRr6dXOjvvpdZ3HCCfE0ijjzqQmwa7cYTtUZud8vh45z2CTSVSBuHeq1hsLBxh3TVJ70mXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fjf2dzTDr6U6AElf4pP4bSKWVptvcsuR5J5uP0IQws=;
 b=B+2JhvAqDCfb0ig2jxC2vZxyIVDOuJ8WaE8WOT8O7UOsFGNppw6ArPnX3twG28bFXPHYBLTODofb+FuKgIOoBv8ivlWTzMxp2ajWLaW+tyEIGEaouGv0CkMsdzN5Ycv4ArRCs+CFPIf6iwbgDuvSyioPEBSBa5Jg6ic2V+QunVrgFvwbFqSbFijW0oxoDhb4mzAy4ElORvbLwfRFUZXiys6avzYQSNuzqYVmGeEym7wSOZ++ifX4ukyf9uDZE1HjleJIF4V6rtBBufKo5AwbRgZYjSUF32ySM0gJ66g+zBkwuMY7YHoDitGMhYNf7bUQFdWCu7wIEHRunfP/0GLsXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 09:27:18 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 09:27:17 +0000
Subject: Re: [PATCH 2/3] dt-bindings: sound: tegra: Update HDA resets
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, perex@perex.cz, jonathanh@nvidia.com,
        digetx@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <1638858770-22594-3-git-send-email-spujar@nvidia.com>
 <Ya8YzUdUg+bFcx/2@orome.fritz.box>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <9f070c65-b157-18cd-eacf-ad7d677804fa@nvidia.com>
Date:   Tue, 7 Dec 2021 14:57:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <Ya8YzUdUg+bFcx/2@orome.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: PN2PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::19) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
Received: from [10.25.102.117] (202.164.25.5) by PN2PR01CA0164.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19 via Frontend Transport; Tue, 7 Dec 2021 09:27:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6d099e-0049-43bf-0760-08d9b963c31f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1336F218E046D1C653FD1E0FA76E9@CY4PR12MB1336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cxMUnCGIgkp/ovi2oARYWiKc5fUTh718n1RRce7n8CJvGZtCUpJSFx0i789PWQbRj3tG6BO7wUWCrCtsl+tUagkGnoOd7nvfFmd5XQC+wcQ33ZxmyyT0D3GdetFKBBG08QuLYY7ijvGmrnmh98gL8RdNmbjQ08nRThd2pjCXDF9Ea+2xTJ/sdJfThCAOn0aiB1JyKqWezcCnptwlabZaOwy3DeF5lWt/Y33dU2pcZyhL2mSaDMua604dt0J4Dd5hv57+MUX39DRTz+QL/PjEAtUG1+J2ifk7FEFGRA0t3yi+ryV5ho+N+acdWMq75sXwQhdMoZ8sqbi0k33044w+IXdYaluh2E51YoLgElDro4UhttZ9fgG6cDkXTbwPa0I6eqjNsjicYCqST7nfUG5AZJFD1HpaxwACa3cbhe0U51bTJukkBf5w1OGL1Lhu4Y+wMr9ZSdgzGoqUMiohCUj4y1KdIT2KAFDsOgvMXqG6Va0Mz7/CEIeIvDONeMG6k+cBj1BzBJaZxW6CEpcUidHv9uvyMEl0UmSXSsWXYr738oQgf7Hz7ENFVJya9WuZ33oqcPj80D5/QPYqjIkSEnUIu9FBO37/PHb2RvtG2ZekUHaN1RbxLSt3gyPvcZVSVhxmqmgCMsf1mV6ZVpqPR2LWuB3eCrUDE6FikJrERGL09OuJPQAnq2ALMmDc/H3NTjagValg3ydSOmMwWY0bYKQ2hi5/JxtSuLcRTuisK8r0z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(6666004)(2906002)(8676002)(508600001)(2616005)(956004)(4326008)(31696002)(26005)(36756003)(5660300002)(86362001)(16576012)(6916009)(316002)(6486002)(38100700002)(66556008)(66476007)(53546011)(4744005)(7416002)(186003)(66946007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?jQ0fKXCT/7vWla8dT38yPBovz4ldt/K/22CdoUwFgzeM4v0CKZAiT02k?=
 =?Windows-1252?Q?E0fmjDjMT1To+CQy1y9f47ueiKWzf7wWKAm+XMAGQuItbodEMt24g769?=
 =?Windows-1252?Q?4U6DncCeWoBbNw1Kyr1xNc2bpC+O/ikfHs1GmCxPHshvhHm14eAqXZxj?=
 =?Windows-1252?Q?VZ75OqJl7MsaQ5US+d9sDUzKm7IKrammR7s1daJbtnyJUsDYyjUJf1rD?=
 =?Windows-1252?Q?jEOITk+UDy58GITChZd8CqDYuRi9dGDMkzJbprHZsEeq5zTJb2vCqCms?=
 =?Windows-1252?Q?P4rMi3OC3aLXw7wve+SsF6GavhyM9ovXQ/mdwy/+f05sikmz6++uHWqg?=
 =?Windows-1252?Q?6M3hm9Q64vNIS34J1ilnjGwkOKtwsQjlwx5Afvs2QIKHN4gglNRx6wOf?=
 =?Windows-1252?Q?HTOMXoXCWe6M3HuJ7z2q1iDUnFIrZf2Aqjhr9IJ2bVQHtC7btc0Ml9Fx?=
 =?Windows-1252?Q?37U/TJpKk0776HtfjxMy6DMlqGYb3vA2CtMYaByrZMRET3pTQ5F0PDuc?=
 =?Windows-1252?Q?uA/Mm6ruGRayO8GoXUh6AcfR9HqyOmbYXT3F5486bdtGrhvt/AO+Y+EL?=
 =?Windows-1252?Q?cHUjSForK17GEOa27Q+RxLxXbJ4If3u2HOErmriFc8OvG25YCQWRge4a?=
 =?Windows-1252?Q?oP2uZ09w93cfxKBH4f+3L+b6nmbh474a5l7hb1VRv2DPTf3qngPYyx72?=
 =?Windows-1252?Q?mg3PkI3JdMWyiBHwaesEBYCdNkoQ6rl/4pNNAy071UJxeunBQ8thKeUL?=
 =?Windows-1252?Q?LcAB2baq5Yo024vtV+RvqQqBAVeWgA5Ogd1qONFDAOMy3phPwVXnqcqt?=
 =?Windows-1252?Q?d+dEO4S9XJCltifJqoCWZw7bLixj1xXK2xz/WAvwG86qobOPdEZrhIw2?=
 =?Windows-1252?Q?IvClYzVjmUclDqh11UcTOmGi+j3dmFBHColh3l3YZShJudTwKHFchnQk?=
 =?Windows-1252?Q?J6cX1qAsYdJzWvRX2/Z+XJIWaUcf6i/eB7rkZSlAm2mlH1e4RbY2ahbR?=
 =?Windows-1252?Q?orwaJD5jaOM0mSfB4lVTKIaOgf0L82lKLN1WNrlYoEXtdTuwHeVBcC7Z?=
 =?Windows-1252?Q?qN9bdet9bRmVBDLUepWvNKFs51zoIHnt5dGjg5VWEMIfPNw/00gZWFex?=
 =?Windows-1252?Q?o09zQ2gvQaNAv7OY/iAQpFrWCp2a/whCvupnvvsfC7gZePzbSR7DR/az?=
 =?Windows-1252?Q?a3bm3V/5eaQtHprsXwiDktW31IfXzjR1BEYCo3Ebu4czt1SliQMQByTL?=
 =?Windows-1252?Q?1f4kj4V0GpbHdfj5KwvlBlRHOD9T3AkFI03lnkHp6f84IVSFdIv8xTsB?=
 =?Windows-1252?Q?CKwSKqR5YGvK/Wrqosl9CKCMruYdbWzQKKGfYbxTsAupKx9jBPVYgbaQ?=
 =?Windows-1252?Q?M7j2lz2LsSF90niOInkh4exV6EMDyNUVWptFlwkRIV4UZmOIUhqlyUXN?=
 =?Windows-1252?Q?7hz5C13On5cMlC1WCVgYR+uOoJ0t97tPIxAHOFiqlT5egYZkpjKqRROJ?=
 =?Windows-1252?Q?AtGSFUGTyCD7peN86Amvgy11N1M0OOEuq6Ennn3T57wjbpdJVWzfEHm8?=
 =?Windows-1252?Q?OEkNr8LE9oxTNFMW3fNDpJVEfRgxdY4tVySgLEDmdvay4yXymj3DMxGU?=
 =?Windows-1252?Q?SbjXNnpRdFlW4i8PpsrLf1fgCigPTqa13ta7jMOjYvZ/XGaevLh2kOLo?=
 =?Windows-1252?Q?EmNXKzWbNIx2H0D0wDDDJvML03wMflp0T5B0VybOk+S1wD4RyqQnKnQ4?=
 =?Windows-1252?Q?yR9ZMNF3K2esqINGLi0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6d099e-0049-43bf-0760-08d9b963c31f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 09:27:17.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbYabuzUTD3IX1PA2yHCkgsYCf6awXo/c5+MNFrusRk4EYH0vU56607npFINiSw6Qu6jVLH6SHv/Xgp3GgBB3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 1:48 PM, Thierry Reding wrote:
> We could make this more specific using an if: conditional and match on
> nvidia,tegra194-hda, but this would work as well, especially since I
> presume that Tegra194's successors will also not have the hda2codec_2x
> reset.

Yes, reset hda2codec_2x is dropped from Tegra194 onward. So I believe 
this should be good enough.
