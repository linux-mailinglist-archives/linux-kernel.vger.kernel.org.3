Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B9B50D95A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiDYGXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbiDYGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:22:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2111.outbound.protection.outlook.com [40.107.21.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3737BCF;
        Sun, 24 Apr 2022 23:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyRI1BTSw7FHljbjXjmJon97ou8J8Jypj5FWv8iYuxqa9QyQKYX/9xtQTIN9tkFu1jfQ4El/i33/K+Mo8dbPjBbjgGwrrPFYnGk/KQ8vyI3TMfNu4waGcC+DqINOKkHraoB1mLbV8/1VXdltNup9x5Y62Mt+SMFeH8c79JDyuBnSNVsS/UhjYh/Jg2ovjouNXLMpK8PQAjTUbVNjC03Wi4E3x1KbDEgLOV57jStPUUZH5f0fMOFRtEfn7krDyAvXYoZELeEASnwyW0DMmEBw4tL1lwWrV92vfRvqMMRDBo1IPG1+lnpJwwAB+BYQM8X3RaPUxudFL0mGO82Fn0IJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+23FFh0td+V3cKlNf/0/zjvTWTZiy73bY/scg47cN6Y=;
 b=SDI9vu8MvQ4NbQ3NaiRGBAsDlecTnnQLSQyuuTxNH8W6GkZe+61OqEb6z8yTuhZ7mUl3LA/5t+xsIyrS4rWsdpRqkozRmrwU21m7aZae0xISiImEavF34rqxF9OKaOJ/9xeD3FZWqqytK3KakJ8Vnzn9Zwqr0tUCvWP/YglBGuY7xHr9GK84knrU/SpXDMzpVqM52y/lB41CBk3XWGCKPiPR8bfMHdGQOmSrJVlRLH6gcDZrwOERJqw1NMhvU+wzVhgkJg5KFz3U8UpJ4KNbmat/AosuXKQ+O6CqHB+xuahD0mZ76rCNCoI1xyh+PtaOeGM+DjhV1TZIx2TrFXmpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+23FFh0td+V3cKlNf/0/zjvTWTZiy73bY/scg47cN6Y=;
 b=IHe8DjRWnJWzL7dGe0wwc7aRcP2xOoKLrev/HSE3RHYhD9KG8Dx5A7QMXTNVRHCpTIHVWCwIcuIscSI3mMJY0MtIfRs1fiwgzY9wQX08tK8Q6e2pkzeh98RVQNBtbfy0g7l50hkD3KS9Ya9MdUxnDtUKme/12fRoA5wZP6TozJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB6PR0202MB2758.eurprd02.prod.outlook.com (2603:10a6:4:b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 06:19:37 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 06:19:36 +0000
Message-ID: <e5a2b134-1113-3fb2-25be-ef47245b560a@axentia.se>
Date:   Mon, 25 Apr 2022 08:19:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings
 in examples
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220422192121.2592030-1-robh@kernel.org>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20220422192121.2592030-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::18) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf8cbf3-30ac-4efa-7b57-08da2683928f
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2758:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27583F2ED578D9ADD259D186BCF89@DB6PR0202MB2758.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68O764/rrsVkbTezPaENtPHjI/jO4xVQzRBJ8L4GT6xjeFqfEuZNPsdr7taMWJFOGHk3ZsDuBP/zeA4Jgse0nHt7z+axweS5tHd1rdP7dt7sXVVSpaaBYdfHYM4Zb9nyx4sMvWA/MjCRv2KXkCGXWJcfOyt2GdD+B0/M5H6+Q/SHBhC7Wy2Q0Nd7w0gcVu7GXrXxkU8fJeaMIZ108gIbp1ToNQ4HeHPN4D2CYhURQbL44w+NQzjSAVeJCrm0VjB7kBRcbRvKGhb81t/u3Fo0N67BoLBIN5Ijk57msuOPKyDTrZsp8PUgun3/g/YfE4uhofZJH3F+zFHBI6nqZSmcJ+F5QFFYiroFmm07QO47m4lwwL8H/O3NKvP5xKLXukhM8FAdg7+35PSmtWKDgefNCnCvz14orHLNsRW6A25gvoJX2ztp9vQz8S+UY1k8cjk9w6VXAFmh96rKB5H7s4ectA9xwtcNzcWsSke6WKYt7LwWHWAYZMXb666eRB/C3HDqvIMMw+4yzR8dIePh/leWBqhgMwuzp0QQ7s3yiIxLJzWAtTNFjFYZ9ZbrJonTLBARRKb+K6zPihhX3YJEhHmtiG0z0Eh02eKGV7AchSAItQ3MLeCf/j0u4B2Isq6DujXgchLIXtMHcSrZmu4i2TyhAR6F1dPOuQqIqXeMohzEj+7NmvHSqRkY6HlWjyXBhsq3vldEftwZhIBQo7tTg1ndUXI76mWziDPFJRgG07qdLskN9SURCXA8H+Kxhna+75Rw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(396003)(366004)(136003)(39830400003)(316002)(186003)(2616005)(31686004)(36756003)(83380400001)(6512007)(86362001)(31696002)(26005)(6506007)(66476007)(66556008)(8676002)(4326008)(66946007)(2906002)(6486002)(8936002)(110136005)(38100700002)(508600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNpT092cjVUcWVhcEdlYzBZTGgyK0svWk90alNFVkdSMDhTc0ZMNmVydGdk?=
 =?utf-8?B?RTdQbzNDb1hvV3V4WGEvRnBwdWpZTGJ3UmNtNWl3Q2xscmJubzJBczNMS29S?=
 =?utf-8?B?dDVwMzUyZVlxM3ppdTdLeEpHYjYvVCswNEpnWGF6OFpJNDFNczJOdnNqOFh0?=
 =?utf-8?B?UCtzc2FhcWFDS1hrRXFPVDh1dm5QKzFGbWc5TTRtZjZiWkt2ZlBBN1VRVWJT?=
 =?utf-8?B?alFwQVh4d1NXWG5rU0xBY0JWUGl5SHprem5TMHZFTlY1eEx1eFMwRmRKeC9D?=
 =?utf-8?B?TDJheG1VQTFZeEJUc0g4MHh4dmN2czI2bmtodnZoOFpvUTlibnE1RXhFR1BM?=
 =?utf-8?B?ZldMMnlVRDdDanlabkJHLzdhem1LYk1sWHJrZ1Z5U1NaQlhBTnJLcnpiOHpN?=
 =?utf-8?B?eFFUVXlncVFEQlpHWDltTUx4bndydzloUWFvWG0xdzFMVDNXWTNScS9Zb1gr?=
 =?utf-8?B?MVpBa3RZdkZITUVYQk81Uk5DeDVvQWZqWk1Ed1hVOUdBZjBUVEFlbUtxOVQw?=
 =?utf-8?B?bUtmTGFMeUxsaUJyLzI1eUl4ZzRGQWdlc2tranFPeDhIWkoyMHQ5bGVWUUZq?=
 =?utf-8?B?MGRrUi9NN0dsTm0vRlJBQmhPa21CODR4TkRSZ242VFV3TGJqQzJLZjkxR0pO?=
 =?utf-8?B?VEZKTmZnM1ZtbUkzbUxHSlBxeWxyOFlwVERlQ0ZPMVYyaWZqVUhRZWM3dXh6?=
 =?utf-8?B?Q2xhYkZlVEVEZUhXVmVMMURhR21LSXBpeFdrcSt4WEJFcjdpMmxtSU05REYz?=
 =?utf-8?B?bm1yUnVkbVZEa3lUZSsveDMxMDNuKy9maTY0dE9PVExXTU83SlBJbjh1V1U3?=
 =?utf-8?B?Q1ltTEJNRkxkRXFEWGo1RTFBSXNTRW1sZFhpK3pXT1k5SDdTaFYraTV5TG9X?=
 =?utf-8?B?SGdVaGszZFR6WkdSTHVFTHVrZWdqK3h5cGVJcDJvQlZiVEx6SHc3NUxhRFZm?=
 =?utf-8?B?T08wdUxLK3JaSWZEMEtRNk9JSzRsa1RXSnBxM2IzT2tndUFqbUptK1ZHampw?=
 =?utf-8?B?M29temZpamJLc3RDQUw0bFBXMHlCMVhWcTRGRjdYSTkyYUhlZHZhUEFRaU0w?=
 =?utf-8?B?VTBOOGYyN0JVaDNWWG9BNVVEVUlCVUozVTNZWGJrQTdmYVMzbTJVSGFwRFdl?=
 =?utf-8?B?dGVaUjRlWVZVcEkyQXlXMTBscmJnYzN5K1pIZ2VURklQMGxFRGNDbjBJZlRD?=
 =?utf-8?B?dmJzU0UzTlhWS0xaL2t1NmxnaURNZW5vSldIeHYraHJEWEVGK2NyRDFHdjJn?=
 =?utf-8?B?dnhCeWdkUEI1cm9wSG9VYjVYamhwR2Y0ZlY3OStXYzlZT2NJZGhHOVpLbXNE?=
 =?utf-8?B?b2NUSUczY092YUlTanZzNmJ4dXkyeWJ3ZExnSG1nVG9MRE5qSmc1YUtRdWNM?=
 =?utf-8?B?YzNpZ21JU05rMjY4RWtVQnpGTHhWdGVLTW1FZWpGVWpHbUk2NWQvdmd5b3JN?=
 =?utf-8?B?alhxRjB6TTlaNUIrMXF3RkRNZTNra0hFdHlQM3ZpQ0pzVlFRcjlxYWgzWWpv?=
 =?utf-8?B?aXdJdzk1T1h0MEJjQmNxa2dqLzU1ZmdTWnBkSUdicHcvZEdXZ3N3Qms1MGVG?=
 =?utf-8?B?VUovdFBRb1ZjVEhCQXZNQzl3WlVQL3VCY3REUzZSSFRKSDE5bkRSc09XZ09l?=
 =?utf-8?B?NTlSc3hTTHhGcTFxdkZ1UkY5dGRCamNRM09VSy80bGVJS1ZDakNXV0pKdG9v?=
 =?utf-8?B?cnc2ZmhTZGF3UlJTWFR4TFpENmZVNC9pL2VqeWQxaG5zUmpabXRGUGl3elVW?=
 =?utf-8?B?WTRYZlM0Vkpjc0pZMGRUampQV0sxdlZkVWNUL0swOHBTemw3aUlaeTRHVFg0?=
 =?utf-8?B?d1RkTUhRTzkwSXBNUnBLQ1Y2VkRwNDFqZFc1OXlnczlzUDg4TDlrMXVibFpB?=
 =?utf-8?B?Yld3YU5uNk1Jdk1YdlVhU3EyTDdFMXVCWjB6aVBUVmlRZy94T1I3bUF5RGEz?=
 =?utf-8?B?aGFOWXdPTlp0MXZZdVhlY00yRUtWblY5eUZnejNURVdBMUJTelVzT0xjaXJk?=
 =?utf-8?B?bDZkeUFBVFgvWVMvYUtjQU1XMWZoTWdMQlJGbms0bE03N3Y5dmMwOVNLWWFK?=
 =?utf-8?B?OWp2MEJONUZ6eHZ6TXVGRjY5VzAySzFaVm1lOEp6SVBMM3FBSUNtWEtEa21B?=
 =?utf-8?B?VDBDOG5FdE53cVRQdVNZMm51MFF6ODJKZll0WEdLSks4Sms4OVVKOUVqY2xR?=
 =?utf-8?B?bVZKMWorV0hCVldSejNkWDNIeW9yS3RJbXYxcUNrMU9qWmV1MEpWMTN2QzNm?=
 =?utf-8?B?YjYxOXdNbnY3WGQrVnlLREpQWUNSeHoya21sYm9YZmlUbU9IVk81Zyt1dmFu?=
 =?utf-8?B?K3J6eHJYSlhHYkZyYXBTcGNxSGZHcFhIT2lXbVgwTEVzYm9tOHBOQT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: daf8cbf3-30ac-4efa-7b57-08da2683928f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:19:36.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RFywLRgcGtldZKTBxxVrr7gJUQtlrngq5xQGjWUWBex9O2Fju8KIcIPDa5pzZIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2758
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-04-22 at 21:21, Rob Herring wrote:
> The i.MX iomuxc-gpr bindings are undocumented and a mess. Drop their use
> from the examples.
> 
> The problem with the binding beyond the just random variations is that
> the iomuxc-gpr is not a separate block, but registers within the iomuxc
> block containing random leftover controls. As a separate DT node, it
> creates nodes with overlapping memory addresses.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/mfd/syscon.yaml  | 8 --------
>   Documentation/devicetree/bindings/mux/reg-mux.yaml | 1 -
>   2 files changed, 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 13baa452cc9d..fb784045013f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -100,12 +100,4 @@ examples:
>           compatible = "allwinner,sun8i-h3-system-controller", "syscon";
>           reg = <0x01c00000 0x1000>;
>       };
> -
> -  - |
> -    gpr: iomuxc-gpr@20e0000 {
> -        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> -        reg = <0x020e0000 0x38>;
> -        hwlocks = <&hwlock1 1>;
> -    };
> -
>   ...
> diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> index 60d5746eb39d..df4db96b5391 100644
> --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> @@ -96,7 +96,6 @@ examples:
>   
>       #include <dt-bindings/mux/mux.h>
>       syscon@1000 {
> -        compatible = "fsl,imx7d-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
>           reg = <0x1000 0x100>;
>   
>           mux2: mux-controller {

Hmm, the reg-mux file is "mine" and I have no strong objection since
it doesn't really affect what the example is there for, but it does
look a bit weird to simply remove the compatible, no? Is that ok?

Either way, fine by me as you're the expert.

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
