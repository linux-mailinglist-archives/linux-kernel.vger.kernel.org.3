Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CDE46B9C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhLGLIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:08:04 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:17168
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230293AbhLGLID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:08:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2E6Gh4agxJnaOTyeEIOIaZGgKtQUCg3cLjn2fxb7bof13J15lT/vBaedNSIca2HushYW7159Nsck069vgbCybPm01oANs0GJd4aMPJJkcBTihJnFx+IUkTgb8ZB9nt4PBvAS5AOIlf0unu24cMbTcNAYOXUrJVhVABwjAMIVCbJTeaUotS9U4l7iD6/oG485KzM0etrkYzipVfHTsHnLPJLuYpBvYDJi5Um6AHBGkg8iHTSYwuue+TjmMy+26T6kPITXPNdcaykdo4p59Q0g4VQ5xRuT/puLHyVcn1sY5VxGi+c/7lNJyWi0QzTFJXhh7NxrdzvDTw19cEapVDWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqpofOB+gxsPeNdJMWRXsRsYSBWb1dxHeQJUsP4ZaSU=;
 b=XHjgvvKpsvW+IxE9Uf4NFk1O65Fw4sZzcD42rMcx5A/0wSg0A+SxmEjz5OAqB+vFD18hrKun5dH53VtPJHEzTw158BV1XFm4Lhc12D2Rc0Uk2bnNi0hMAKyaI2ahfDK+rYO9oEGAwoXAYlx4CJZb3bklkL5pX7Bvsg1vL/aCDYtLYRI/9WpyKoT1Q+tn374wsBLg43nUeEGVO7luiS3/ud5l4u+Z6I6y5ADT85rYFKzUJ5cNePXiGm/duNzESKxqLdHSu0XvD0uPAcfKx/ERz2Q72lgrAuwJUvmilJSBt7OoccdWwJimQUMexyrb7/mZ9Vm6BW+/tYBYRE8+m8T7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqpofOB+gxsPeNdJMWRXsRsYSBWb1dxHeQJUsP4ZaSU=;
 b=UpcXgcDTvvxF/I82UJ/2fFBTtyLOPLsTKlCOaNyOq/iDL80j+HiZCl+kQrWnSMdje3yqGZLKPG1owlEeJUJcmI5NgZm444wDXOzktI2gDUTZD6HzIYRIXwGGE2HwUQ9SsqpQ6Dl6aT3oVsJ1dvRIYFKqHZqAZVPwwB6zZ32vvqRuuJ5jlmbpmU8FNG8M/MeWZA/ZQc2wkOXIisCz1tb7Qlyohn6YT+G7Ekgk9ztW3uZBO4RexY6Fp3U0nRW59I7YA721MBSN2gonYiZrhNX+ZUaeR2vdNw0dAUfxe3GqF0ALDgU6fizjO9yXF2X8twSuzf9zXVJNVr4Av4f/woaBew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by CY4PR12MB1174.namprd12.prod.outlook.com (2603:10b6:903:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 11:04:31 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::24b0:46e7:d3c0:a77b%7]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 11:04:31 +0000
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
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <03a5094c-0c53-98ab-97cb-4b27ed1b7a38@nvidia.com>
Date:   Tue, 7 Dec 2021 16:34:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <13d20227-ec6b-03db-01dc-b4b00038a15c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: PN2PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::32) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
Received: from [10.25.102.117] (202.164.25.5) by PN2PR01CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 11:04:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b420cda-8e6c-44b2-4141-08d9b971585a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1174:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1174A4CE4CF63D4133D57AE5A76E9@CY4PR12MB1174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eP64PlyiG5bIoHfmxeS2keu03XuFR6CvzET3aosaCH8pQSPAieDd9n1Oeyz3XCNLyBEMwMFj9wTkj3SAllN4VauVSwdGVu4g2MfgYyLidwn6qx627or3+aitEeW9LEQXL3rJC5FelT8N7EPQnBMpl39L5AvgbaEm87SwXHMaOOeuAZrHjMLxQ1o8qCFktmYE6EqjooMfFyPf6waap3UI9lAAgK7GUsS+UQ3qw+5xQRP5GnrwEFipZ7R8ZkK8iBXK1/S/S0UDn09amuRHgf8PZ5Ttldvr8H5yAGp9b7ymoBOkRlyyIAGVjbtJdd2RPAZpydF9TOUVfiHcZL5ug+aL10W8ZMF8U9/DdFJfb2tsS5vksjZnB8G8gr2H9hw/rzzHlfD67OJjLqM4A2athd2Edgf7bFyOdJmolKqvEVcjkPsZSmpRoZEtDkfG90lH9PTnfv9XwKxLFKGMXIBoj6G7RAZpwQWCvynyr6AvglqXUnL+j8AeKss0oNrXLbJpx64gYAn4IFPoW1QF9zzO9XJYqh8OhFkQkZZo8F7mwMcpyfsFMbkL8bSAPUXV/s1+/0rr9CMXLPqxZnkb7ShuOKLrmVt5BrVsqTAF/NogpMJNBQByZGBT6nifbSCtd8PAVf9+qf2m5gL0RTL8uPN8h7Upj14X5eJLMJ/eUJXkCLGMu79f9idK+NM5m95f7miP+OgzJsv6oI2lbLVUShIGGHeqrCpccHx6xMtyh6lYl3S6zQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(31696002)(31686004)(7416002)(186003)(66556008)(8676002)(2906002)(316002)(8936002)(6666004)(38100700002)(66946007)(4744005)(6486002)(26005)(66476007)(2616005)(956004)(4326008)(15650500001)(86362001)(5660300002)(53546011)(16576012)(508600001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1I0YXFjVDl2ODVEMHdESktEbDFTMDhXZ3VzVXVnU3pQR3dISitoNHlheDdl?=
 =?utf-8?B?a1pBbndiazBVdUcvZDkyL1lQMHhyblo3Q2dFR0pSMU9MQUt1UHdCMzViZS9k?=
 =?utf-8?B?QjE3aUg0UVEyMEhjMStYOCtZbjdOM1JHWU5ZUkdHWjNuZnhrOWk4V1owck5i?=
 =?utf-8?B?V0hvanBWMU1VL3NxNExlQVoxbmFTWERMSDl4YXRZamZYT3Rya0s5Z2Jsc0d3?=
 =?utf-8?B?RXZIbHpSZzhVdFo0WjVXOGk5V3c5WjVsUm13eENiWGxKdG5uNzhRSVBRV2po?=
 =?utf-8?B?c2VtT0FGejVCSnFzbG93UXF1eG5DNmg2a05qeHBQT1hoVnJHL01FV2M5ZU9Y?=
 =?utf-8?B?bHo0NmRacW1MclBVeGVBcmd6WE9lZFROSVdaK2NIM3RzRllDNVhUS1JRdzJm?=
 =?utf-8?B?ZnNYd2Zqc0JYbWRISFNycTV1RVFuODZ0ZWFZMWxwaVlDSGRqWG5XUTJUd1U5?=
 =?utf-8?B?TllOWVdDSkFhV2xleGRtaTJaa242UXRmNmJnK1lhTUdGbDdRVDNxK2JFRUhN?=
 =?utf-8?B?U1M1OEh4UGZGaEhaekJrWFdMMFd2Nk53Rndsc3ZBaVRZUVJ1VWM4QkJ0Tm9D?=
 =?utf-8?B?UkhXWHZHSHorVmNhdTUrRGRLb3JDTUs1ZmJLbnhhNFdRV3p5b0RwYUs4aThB?=
 =?utf-8?B?UTI1Wit5NnNlVWdCc1A3dzBvNThFOVczRnBMcG93WDdRSEJDaGE4eHNLZHQz?=
 =?utf-8?B?KzhHNTF3WnRCYkxNV1VBSlVkeXR0aXRUV0tqL3dLNTIyWHJpcDFaOW5RZ254?=
 =?utf-8?B?R0dMN1p1VVM3dWg3MWJmdkIzVFk0RkZFSWgyRE42UWQ4V1E0bWNucFdsMUFn?=
 =?utf-8?B?TXBZdFVUUW1zanJKTDhwNHJwS0lyRlNnWHFrWllrcUNoVUg4ZXRGMDdpUnJ6?=
 =?utf-8?B?S3h2akowY3NpS1Uwc28rNndyVEloSHg0UWRNUmtsZzZiYUNzL1JZMVR1N2lQ?=
 =?utf-8?B?NWdzY0ZCZHd0UVlLU2xQbWtMY0E4VEpxWFhmc3lQYUZhb3BtYTlTbTdVbito?=
 =?utf-8?B?Y21QcHFNSGtKK1BPOWJlOEliT1dvTGY1MEVpZnRSNjBIbVR6YW9IMWNFb2hG?=
 =?utf-8?B?SDNNNTdoQnhsd3JIbSt6eXppWktQOHVER2ZQTTltMkZncGFpVy8wRVIrcVVL?=
 =?utf-8?B?ZUtmODN1OE1Ma1lKcVRUakhwS3FQMWxnMGZTaS96U3VaSFRMYTVwSHB6dXVZ?=
 =?utf-8?B?VUI0d3hxWDBlQWJEcCsvVWJsaTZXQ0pLU3ZPSHV6YkJyTCtOcWhZK3FHU2JY?=
 =?utf-8?B?OTZncjFoYkY4VVh3T0ZpVkMxMENuMk01by8wYnJpQlpIb3M2OGhvbDlkNXpP?=
 =?utf-8?B?a3B1cUxJRlBFNDVsejczY3dMVXJ1eGJ5YndDR1R0WWljOWtzWENabHVGSXJG?=
 =?utf-8?B?ZWt3RGNWY2pvcTVNZE1VQlFDZjJrem5wRFgzdTk3eWVGS0ljbnFqcVBMaEN5?=
 =?utf-8?B?UU5KbW9iVmh5UzBTR2VJQ3N2NnJFMERyVG51MDFjVjFDNXpGRTlwNjJtcTds?=
 =?utf-8?B?aHlpeHN2UHdhZTh5ZGl6M1p2MXBWc0tsMGRib3hEelkzcU5zVDRmLzlvWkNI?=
 =?utf-8?B?V0l4TXlmWVl4VVcvRnNuUEpCZWcxYndaRHdsd0R0NTdqcDZucWxRTUFqL0FN?=
 =?utf-8?B?anFiVHR1RG1CVlk0aGthVGx6MHhBMVltMkd3SGJEbFR3TjZoOTZXZWoyRGRP?=
 =?utf-8?B?N2lCeHdpYnY5dEwvV3RIMlRudmY3dXB2akxNUGRna0VORTlkbmxxMC9FTEQ4?=
 =?utf-8?B?bEx4eGlYMU9qSSt6SDc1TWwrekRxRjY0dlpRTlptQnRlLzJIU3lrRnA4UFVT?=
 =?utf-8?B?ZjN4Qlk4cWVDTlI1TmVwUkVHbjFHU2ZxMTJldDFLa2hDQ09kU0VTU0pxd3Zh?=
 =?utf-8?B?eHZ0NWRBaUt4bGRQV0owTlBOTFNIZVZPYWJ2ZWVXODBrTnBDcWVkZCs0dW1y?=
 =?utf-8?B?MThTTXFNQ1FWTGdiOEh6dyt0eFNSVERqOVhCT1RzVkNJaUZ1NzNtbUpiV0dP?=
 =?utf-8?B?OEVkMlpBaGlPZ1p6VnhYM3UyQzBIdDJxTjlnY2VieDVBY3FDUUl5dklYYnVn?=
 =?utf-8?B?YkZiMHJ5eitmVHY5ZnhOR0JvU1JTZHY2K3l0TGd4RjVuUzJKTVZmZWNmMmJx?=
 =?utf-8?B?VmhlTHI3MXBtcjV0TUJoaU1JKzhLSFhNSHNCZU1kZTgwK2tJMi9NSzRRL25n?=
 =?utf-8?Q?Euj2H1MIaqIFI4XYai+i5Vs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b420cda-8e6c-44b2-4141-08d9b971585a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 11:04:31.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiA7+Tjp8vZpxE05iWKV2rqv1dN/kRXH940ioFE/BXXWaBgVyUyBJ4njkvdYiLejVVyPT5g8kJcTv7WlB0THHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 3:44 PM, Dmitry Osipenko wrote:
> 07.12.2021 09:32, Sameer Pujar пишет:
>> Tegra194 HDA has only two resets unlike the previous generations of
>> Tegra SoCs. Hence update the reset list accordingly.
>>
>> Fixes: 2d8f8955fe02 ("dt-bindings: tegra: Convert HDA doc to json-schema")
> The original txt binding was already wrong, this "fixes" tag is wrong.

The text didn't document "nvidia,tegra194-hda" compatibile support until 
the json-schema conversion happened. Perhaps the text doc was not 
updated when Tegra194 support was added. So wouldn't this be right to 
use json-schema commit as a base for this?
