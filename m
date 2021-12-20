Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1047A63E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhLTIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:50:24 -0500
Received: from mail-eopbgr130131.outbound.protection.outlook.com ([40.107.13.131]:51648
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238055AbhLTIuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:50:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTI29Gu5gr0FiLF6p1mL5nsHTDFH9t51G+jqYeave+KSWUgcmDcmiUmhdYBcQPxDlligQVwk2EkKY6y0WvlpNnVSWSKOAj8g/ZPv8zXxZ2AE+naQoqLnk3e42mSMbB7KVWJlwYT6sqTm6t1yF2sStOJTA5LTigR1Wkywl4UpbmYIt/vxTU6y/DI28DhAEWa2YI0Sd/HJAJqIfn+sdB5Ur9hWtGrSPUd4H+6jPd+SdpurTBUjATfHMkgFK6t0mQyKovHBRi+EKc3O+NsBKCqC2BWQWDyaHiIHwkB5T8dtRzgp2xwIgYuZWmlyhjlbw08t45kuoOMqqMDXIm6tOeey0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vwayf/u6oSu+plAbXCOs+xyZw9ftd4LEwYCGAWeYnTc=;
 b=Zy2C8tyXJq3R2yEVcsodJ8czO0WGQm3CbF+vN5rRV5fFOrA0DYBqOh1YIEI6NHpWGZTOh7UwNIS0TXZa1rWFLPVbAHybF1DRbLX4ZSkLHwN6OF3qwSsM1N7ynSHT0NZej0GheLmJftUGT9cnuM31dx8UwteSY8h4V2aYZciALZMFSYF9CZ5LgV+rH//5aZw6PNXwUCqCDoyDkzCAubmj2sFude9ZQLJtjifdvW6BFtbyj+Cs5368/4Yvdm+nEmHnXT4Pcp3HNXiUOcuIFotSJRshb8gnZMoHgM97CuZFLEvC5NOIqWLVS7maTLf0sPrBOqDPPe+/uej3sL5XiX4mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vwayf/u6oSu+plAbXCOs+xyZw9ftd4LEwYCGAWeYnTc=;
 b=NCp1KiajWjS34vGbA90Lm+/awJcF3avvu4uTQ9w/7tbh4J6+8f7vvQVL6n5UQWFlAOKNlxd9yLUSGxZ899Jn4622RMcOy85WthBr5i42x09pt07YfNJfw/rbMFHXNispc4+4sZFPedqk5NH96yB19cFwBoAU9lm+A5m8YkPxsMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7307.eurprd02.prod.outlook.com (2603:10a6:10:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 08:50:20 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 08:50:19 +0000
Message-ID: <44ca3bc1-4a87-98f5-4c8f-1e406f01d0a2@axentia.se>
Date:   Mon, 20 Dec 2021 09:50:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mux: add missing mux_state_get
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211202124053.2835-1-a-govindraju@ti.com>
 <59c57ab7-a272-b925-befc-79f88c925e3c@axentia.se>
 <af642da8-a9e1-6d3a-a928-8a514f1c5eb0@axentia.se>
 <773b9424-a1c7-1955-886c-de36299a6873@axentia.se>
 <031e134d-dbe3-0f39-3e63-647d0efa1576@axentia.se>
 <238c5e18-1b1e-9f9c-8c96-f25bd7f7f838@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <238c5e18-1b1e-9f9c-8c96-f25bd7f7f838@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::11) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9608bb1c-cac2-4f5c-820f-08d9c395c073
X-MS-TrafficTypeDiagnostic: DB9PR02MB7307:EE_
X-Microsoft-Antispam-PRVS: <DB9PR02MB730760758BBA359248B26C6FBC7B9@DB9PR02MB7307.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpTCvO1T8M4vlET0ExX8cWzl0l01Soz4kyxiAsCvAtTRchlh7WoEcAUA50jvInz/TRL5ECCTupt8CRekv2pYXbfdzYX7goYO4MrrXTBP8ybxeNSVgRrWIVz8vpNm/nzJXHlGAS9gAkuvh5kQW4w4I6C86ny0eqoCFO06phHX1eN73UKQ8uNVQnrjuETJ9IgXmk1SmXyWjWfbIhNEFEZd9vMKAuuNcDtaGCaEnabyvQS9fmQCoCsc/aVsV6tKsBHgB/566L3F/IIw+do5w1CC+rQIzKIkSVKVFoXY2dYXNRO6B2mICY8Kf+4Dv6FYDWku3hbrSUsFSkxIS65tNVLjJrWZDfTOkqCynFYAOgetj7+qTZf7EuAsjTjVu1g3LR8vz1/xanOQEj8y79oN0FSn6nfGHPzidEnFtGEUpYh/c0ymOjMSmAyX3UulqcU8UnJ9kXUMAZS8f/DoToscrDcRKvmf9GDEFrh4tMS2SAt4AyRkY95ipa7ej2AgbWzD2MfuP2wDLoVA7FI4sCZte8aPS8zw6oP3JioKzrrh5k/IDLnUWwgOwj1/wSDtTgCUK6xL/1Emm78WlyLKZXj95UfjpU/mEGFcxync8Sj2PDpZyiV2JMYPQbO8oEycpiHNDPYZZEJwcFi6b9UqDIjxM4R5fQUgp/skHqiNlV+Xx29ZFLiYmV9Tpd/LgP8IOn1DfA164na5IRL3WetvUlxq+tZN8wJkonNrhoXEYFpFMRvM7eM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39830400003)(366004)(396003)(36756003)(53546011)(4001150100001)(186003)(26005)(5660300002)(2616005)(6506007)(86362001)(8936002)(316002)(54906003)(4744005)(8676002)(4326008)(6666004)(6512007)(31696002)(38100700002)(36916002)(66556008)(66946007)(31686004)(6916009)(6486002)(2906002)(66476007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFkrUEN6SE5rb1NQeGpJK2ZVeHFQZGNILzlndksyWkFvcTZQaHNWZEVJNmtm?=
 =?utf-8?B?d0dXQWlZRHpmU1F5aGk2c1R5WWtUVmZpSkdtbmxTVXlEclA4c2Zuc3kyVVc5?=
 =?utf-8?B?U2diNk95OEcra0V1ZjZ3dGxoTHRUZk45czlJUnRkQmlCbmlweFBDRWdNenFY?=
 =?utf-8?B?aHFYNE1GdlE3Q0xDd1BpNUp4aXBtM3BGL0VaVm52dUUyTUc0QUh1UndQQm92?=
 =?utf-8?B?bkxiL3g2dVRIcHp5OW52TVFzQmt2VWtDV1ZVcnJBNjVmZE4waFpuU05lUlIr?=
 =?utf-8?B?eExiSDNCbEdTTWlrWTYrOFhSK2NURG1zcGNqa1ovWEp4ZjBZb3dLanNRcTBu?=
 =?utf-8?B?cjZlMVord21MRjluZmQxVDlZTzRWRzdPUHQ0UldtaGxMbEVrSlNQRkRzQXAx?=
 =?utf-8?B?UFEwMnFRbFJrVzhWTUs2UlZzSUVLR21UcHNJV1k0cnJMWFhFVERXY29xaXlj?=
 =?utf-8?B?WkNwZ2ZBVWVJT2VNb2pBUERweTFUSUVtMy9SbDRwajFqeUdMQWl0VDNONE9Y?=
 =?utf-8?B?YWlINDBhYVRTc3YvZVlwKzVjVXVpaDBPRWJEdEJnUEZBZVJtcCtab2QxeG42?=
 =?utf-8?B?cmdDVkMyekpibXhKK3JpbmFRY0R4a2ljSTA5Y3FnYmZYY1BwWlhWYjdpNUVk?=
 =?utf-8?B?SC9EN1poYXFlclhtS2N4dld1STBxaXFDZWlFY1JMZEJFSTMycHdoRjRlbDJR?=
 =?utf-8?B?dWRDYjJ5dDZRSUIrY09McHljRjdYQWdIQWF6WTFVVldlOWlFTld3a3pFQVhk?=
 =?utf-8?B?TktZZ3FqN3o0YjBpdXZlZFIyN1luUVhmOVhrYVNRYW1XeHFLTC9EMGhTQ2xq?=
 =?utf-8?B?R3QwSmNjOWdWeGFvemx0S1dwc05mNVUwOUpzaFBwbWdzRFNzWUMzeFZsVUpU?=
 =?utf-8?B?RXdONE5xSGRhQStTYUNoTXIvNk9ETmp2VXRURy9PZWM2RklBM0JISkh1c1pQ?=
 =?utf-8?B?VzdQUWlvL3hXcUxRK3A5K1A3WXc4WlMrQmlCTlh2SnUxNlM1Y1IrbGs5QVFK?=
 =?utf-8?B?QThUVXpBdGRxeDFBYmQzRUlJR21OQ3R4YmUvOHF1SEprNEQrL0J5TUtiTTEr?=
 =?utf-8?B?NS94QXFoV0JzRXh0a2hYL2FNbTF3QklGUGthdEQ4Ly9BKzhYS292ZTR1RW5x?=
 =?utf-8?B?aHE0V2ZmK0RId0dCQW9nbDIrTlVtRFoyRmJUcm52Ky9YanNFQ1dNMVB6Kzh5?=
 =?utf-8?B?YU9GZHlHWW9qengvVXdxY092cW9zbFVHUG1yZVo3VnBXR1ljUEN5U0N0emNx?=
 =?utf-8?B?a0Q2OXNJdmpYb0VtN3VXcW1wSXhDbDAvTVZiNlYrcTFVL0JWVUNkRU1zUTNm?=
 =?utf-8?B?RUFLeXdLN01PY2FoVjZzSGpOT2xsNWpNZ0IzVkNOZ3RsZDYvdG5oN05ZVjNW?=
 =?utf-8?B?WDlEa3UwU1JxK0I1RitxdVFHSGE5Y2JOMDh2L3pTMkNYN3NCNHdrVXVLMGhs?=
 =?utf-8?B?VlB1ZFhLMHBJR0J6VmFuR3NjT2Q4RW8xRDAwZFhkWWNYcXI5eXdSUi8yaXBk?=
 =?utf-8?B?d1dNdk1ua25xY0ZDakV4QytGYWgvb2FNNXgyQVBWZkFiUnRTVEp3KzlvOUFv?=
 =?utf-8?B?cFVleUhybUI0dWVpS1ZLTE13Zmw3RWZtVTlkY2U1bmplaFJoWElLT2p0MWs1?=
 =?utf-8?B?VTN4c1NJcVpQZmdUanlsMmJsUVFpbVJZZGZ6UzJrU1ZKT05rOHhzS2w3U0hC?=
 =?utf-8?B?RzNBcEkrcDA0VUNLdE5pM3J2QS8yNVhVbkVxQjQ5Qm0zb3ZCUkwvK01ZVEFz?=
 =?utf-8?B?bitTWHZhWVQ4Y2h6UEZURmdDZlNMaWJ5a3BudEd4eWltQlVhcUdPV0ljSEM1?=
 =?utf-8?B?cStTZnd3VG9UN05tMlhxMTI5UktLdVJYTk81dHpvTDFlU3BoaWVrMlZtYVBL?=
 =?utf-8?B?NGVGVy9lRWhoZHF0SmdnR0krR25nZmtYcDRlT3VXSzJrL2craTF1OFF5a1Rm?=
 =?utf-8?B?ai9JZThnL3BOWnd4bldZUFVMT2tSa1VkRFdhV3lEbWJxU05tUW5nN1BQQnp4?=
 =?utf-8?B?Z0w3YVNIMVlpV3FUeFVGU1prQ2ZrZFQ1TWtZVWI5bGRTWXlZVGloM0ZzdjBW?=
 =?utf-8?B?SEVXT2NGOEJ6aXpYeDV4Q21mTDFiMk5FTHM4bHRZNFFENUdQZnpEdXlpNnFM?=
 =?utf-8?Q?kvnA=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608bb1c-cac2-4f5c-820f-08d9c395c073
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 08:50:19.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZFfhAwWrQq4FRMMYOpl2jqMRU5HfUqsgEB/fAsv1tzQIYVV+xc29rzv1h/wusr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-20 07:57, Aswath Govindraju wrote:
> 
> On 19/12/21 12:07 am, Peter Rosin wrote:
>> And implement devm_mux_state_get in terms of the new function.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Tested-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks!

I added the commit to the for-next branch. I will pass these mux
patches on to Greg when they have been in linux-next for a couple
of days for the bots to chew on. I can't be sure this will make
5.17-rc1 though, when we're already at 5.16-rc6 and the hollidays
are coming up.

We'll see.

Cheers,
Peter
