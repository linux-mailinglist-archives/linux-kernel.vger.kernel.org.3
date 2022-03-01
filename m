Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064354C8DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiCAOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiCAOat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:30:49 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA837EA01;
        Tue,  1 Mar 2022 06:30:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDtGW4vdfsm+T7OZqr0TFoYBFZVC69ina4z8EPTPQbVKuy7KaWMnKxSBJurzOWTkj5vAmhBO0jsqHOPnlobaEebdphO7E16nl8K189Ow7GYyIj05HNCkV6iC46+iGO3vIIDC4axgf1nNzkuf5OjdRb/5P/zJzj/lTWPJnPh3MIMhCbMU9tWWcVIq6oh0CgeW1gQVbDj8TdbWMEf+F1Vxfx6uaJvdz2oID32X0Rc7g45pqXnKSMhxRUiq99mmJgyNkcN78IsClbnCY8Gmw+H54vixW9ATMZg3+c+bbu4UQE899+w79KowC6TX0/RoBhgzfjmm1CAWCWwqGICVqIoTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqiZWW9YM1zFEGU7AMt4D8fV0E0V5dlO6tvzTVy2YZ4=;
 b=KxbAJFg4lIj0WtsqLpI5q8TzjcvBn5dSG/aVh7BpR1yi+x40vzoUxZgkmuJ14ODLVZn8OJSFsX1bM69SRiV/CwG0unTLf5XbfiO7AMbD2PWg4ovjyHTTn6zHYbK7ZG2P6pWUqv8Ee+yYhjA5QrncbqEN8cC6aJY/H5MrJ+kNC1RK21QosLBe9oHJcOtgdvtP2NLz6blr5O1G7k8FMDAuP/bv50Fd5Dozj/im2q87wWAJq7WKLO6/2s+/foGbHMAet010/rJ0A53Dk+u6L4A7z8EHgut++cI3iRG9ATPmeoGPIfdlqAvxaVdKQ8U5KrDvkyqRI8vSXbILoBTALv4tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqiZWW9YM1zFEGU7AMt4D8fV0E0V5dlO6tvzTVy2YZ4=;
 b=GBWnnbB5lwN+vsyQUy28BcTqYa6wrO2QO0pXMhSgIe10eUuJX8wMq1DBSf09CkVdcOFPjFfeVZUXY+5Mu9E4/HJooOmtXXr+kbrZwAG7ovdRtrVzvmz244M7Yr8YS5P60IJNMiz2GioOEwn7+Mes/VWDDw1tE8SHMmw6yFB4ewE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM0PR08MB4436.eurprd08.prod.outlook.com (2603:10a6:208:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 14:30:03 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 14:30:03 +0000
Message-ID: <d38a8950-af24-6b8a-c09f-24f539328a95@wolfvision.net>
Date:   Tue, 1 Mar 2022 15:30:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 0/8] enable usb support on rk356x
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        jbx6244@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a2a2f6-4217-435e-9d04-08d9fb8ff96a
X-MS-TrafficTypeDiagnostic: AM0PR08MB4436:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4436D3465020BB9A0A68C84FF2029@AM0PR08MB4436.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBckw/JE+30QajCP54bmj3kUUlxUuERm9e+93kcKjghlOd4U116Hlq+Hc3y6GRjQkCw/HM/T89I4xuZ+QfwcYShf5W4uVKYeW0zOdHI/3hHZ/AN43WpXyTLd6kJzYIcAbevUtEQ4vaSoWwwoBoQjNqEBfQGSgk7HYy0NqWC3zc+0typ3VMcdh2eh3SpNLSN8/pycx2nIQ7+ATUUvI7IV20UcabPRJx2d2mjRdJeWZPPKWcBEikX2OIrpMfcm5lEP9fXIWCbfKeCCEnVA7OJGr6JGp+rhtq/oTHyxtBvjVICzDl86kBzoMv9fZwl+BBZTZQeAR19jMhNSuP+eUaC34WUCe/8CsbLIEoyKfrJTUnr42kagZrA/6TwxL/fmeZ8lzxrJErSL+a8M1lnDvnfmVK9QcxLor+MSSlMlTdZjI3yQ4yd2udqyjUvRc2HzfKho+ogCuZEirxwNNDpOhyWKChxl5GkXlXm4l1vQjXvV+WKRSDyVc84vmqYhU2e/Ma9qLMG2QOWiTR8K3YeLlDb+Y7anY8wGST9LcuFyaZa318iuWsMVloUny4W8gs6RVnKs1gswB9k4ll3nqQsDvJayjmZrXdfe3o7L4AeCsvVomzNp7NyhSK3k1GW88KPTD7nGlw5pVZ5I1A5UstKgga6FDE94i90zSXLpXQMCk97+fhvyIk28gvVtR/EXcNnfsAOekVdBkB0G7GoxQJBrX80B16LixXxViuP7rhiEVG+pmIv8+iJAOq4q26IEvC+vmy7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(53546011)(31696002)(508600001)(6916009)(2616005)(6506007)(52116002)(86362001)(6486002)(186003)(54906003)(83380400001)(66556008)(4326008)(8676002)(66946007)(66476007)(316002)(38100700002)(7416002)(5660300002)(31686004)(44832011)(8936002)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHJJbS9HZWl1VVVyM1N0aG5jQXBhQkhKT0Z6NlpacnNBL2QyV0NPQ2s0TEt4?=
 =?utf-8?B?SUdYVklPbVVUS3FGYjVMS3pGOWtVNWZJOHU3dDA1dWdOOEx6dG9nWGpUM2lo?=
 =?utf-8?B?WE1jV05VQnJZWHUxd3hRYUEveEgwVDFpT2dhVngvVnZpUkpoeUN5VkpxT1A0?=
 =?utf-8?B?QUtNb0JRUlp0OERFVnJGNVU2RzBSYmN5UVM4enFvY3pXS29wbVFmNlRSMG9j?=
 =?utf-8?B?N0VDRTlLV2JkZm8wcCtGdXNJdWtJNEx4eXBLczhrU0g2SjJ4M285d0NmM2M1?=
 =?utf-8?B?YzFuMFRZb2J6bGRoYStFcG9XOEtHT0NlUEZhakpjVnIxRm16azM2elNISUE4?=
 =?utf-8?B?SEdKZXlpc3hLQldmdGN3VWhNL2o5MFNNWEY3cGd6aTZxcjBESFIxOWxaTjI5?=
 =?utf-8?B?WUdOVllHQktPUXhYdm9JbjR3SjRDc1BMMVRxMzJGc2o1ZHlGTDBGM2Q0dHRy?=
 =?utf-8?B?ZGRmZ2s2Tlhkd2dobG1jZmJNcEFtZ2RxeGFvV2ZpenhjbEt5RGs1VmJWVFZI?=
 =?utf-8?B?YSt6NDh0ZmtTZUdNcEFNSHg3d2x3aytIc0ZlcHRIVCtKRUNZdE9SY2h0YkNn?=
 =?utf-8?B?bGJHMjI3QmkyTkgxZ3QzYlpXSHJEU0hmK05oTGU2UWx5eWpLaFdkek5Eb0t3?=
 =?utf-8?B?cmI4MDFoYXpZYnV2TFlUZ0JBMDBDRUdUZWZ2NDJLTk5Qc29heWNKYUhhS3pz?=
 =?utf-8?B?OWlYOEg0SzFIL0F3a1lvN1o4ZzJVbzJWamI1M3c4a3R1emdZZzV4NWFudVhE?=
 =?utf-8?B?TWZlSlJVc0dJNEhxVXJZaVVpNzdUdHd1QWViQVR1cGpKU1lkZ2UxeVkxbTFN?=
 =?utf-8?B?N1VhWVpQeUw2R2NuZnhQN2RWSG53bkx3czRhcVBVMDZjMGlVaDJEaTRrR3NL?=
 =?utf-8?B?RU9VWFF5L3lpUlBaRVE0b1AyYVc2R0hTMkFUZlpLdHdvYUIzVEh4SkFDUktO?=
 =?utf-8?B?eVgrYWdyWG5Qbzl2RXdrWUtpL0Npck5TQTdrbmExRzl3ejhlS0VEN0lkSkJI?=
 =?utf-8?B?d0NkU2NFSEZZZVhPTVlVVlpnelN0bmZlTjJiN0tEdSt6OG9HbHhZQ25qLy9k?=
 =?utf-8?B?bXIzN3J4cVBPL0dtYTc5R3F5a0JyQ3pkdGdwT0IvRmJNc0grTkNGb2EyV3VS?=
 =?utf-8?B?RDFBamVqNXpKM0lYRVQzcU5ySms0dzdFMzhRNmFwY2hZZnlGL2pYQmNSMnYy?=
 =?utf-8?B?ZnRqTURvcFVYVTRHMEJTYUEva2lLYTc0TWlRajZXeXVqQ0cyT2k3bExuUEVO?=
 =?utf-8?B?aUdhV1NCN2ZzMU84MHJ6M3crSStMQ0psNEpGNERIanFGTzh0ZC96VGsyY0JS?=
 =?utf-8?B?bGYzY0xZalg2UTQ0K0VTSkdYUEVLQTRHWnorME9CQ0NaOC9IT05LVXJTUDNw?=
 =?utf-8?B?M3dVY0tHNE8ycFZyRDdwc0FBRTViaFUrOXl0bmdqY3NPOGJiOHQzdU5VdWpi?=
 =?utf-8?B?MjJXSEVUdnVXWXM5ZWMzK1ZxN3ZGY0VUb0pHcHBhTTdpVVR1NE9NdlVDZTlF?=
 =?utf-8?B?NjRWb0xMcENNWkZ1bFBTRjh4L2NHbXRKN0gxczZoMUJzQVA5MDcrSTBlVzJE?=
 =?utf-8?B?ZExWQklHS29GWGxCUjFrbkgzdzVTeUx0a1JobTlQbXA3WEVibVhhaTFpQkdp?=
 =?utf-8?B?SFdiV3ZEMC9IdFpiTkNJSzJSOTJEeUs0M1puSGNucGZYS2UxT3ZaVmsvcnJ6?=
 =?utf-8?B?dm9icHc5Y01CaHNscUJmZ0t0UXNHK0gxUzF4dWhtclRncVkvZzBreU5VbHhy?=
 =?utf-8?B?bEZRYlZZN3BSNUdTOEs5WFVYbnp3eTRya0VNU2lYSklkRjh1aUtlMWRoaWZx?=
 =?utf-8?B?Q3MrNm9qN0VIZDBmalZ1VHJaajRoR09zd1V4WDd3K2k3YkNZZ2tlTmd5dmtI?=
 =?utf-8?B?TGFjekhqbmxVVXBiWUxKZEFTNVZsaW01eE16ODMzTDI5dUkzdmJRTXJsaUE2?=
 =?utf-8?B?c1R3SjZ4amNKMSswNGUvdGJvOEh3amdZRGhqUVFxLzlyTGFjejFTMzQrd0pC?=
 =?utf-8?B?c1lURWlBMWtOUWx5Q0lMV0s0QWtYSFlDZ2YzajZlbjI1VmQvMkRrMXBDZ0l2?=
 =?utf-8?B?a1BoVFJzN1NPbmZQY0FDZHpZRlBLV3RtM0cwN3JvYjMvUVFqaXByWWQzRlFP?=
 =?utf-8?B?bjVEa29HR2NBT3AwWDltU21TZHoxbWpCSlBnbDdlelNoM3VYRHkrdW9rcW5K?=
 =?utf-8?B?bGpXanZYWXdDMHpNRUpyUkFJUnJYWCtKUHpnNkFqQjY3VGNIMDN1TUVYMEJJ?=
 =?utf-8?B?M01sZjR4Tk83ZFhVM0pRelJ0RndTdDVtcW9CYTlkaFlYOGVwQmNGT1RGVjlH?=
 =?utf-8?B?WUZSNVBSeWF3a2dOM0NoSlk2MmhKOVZreFJTcWNXZlZIaTJrWk8zbzJEYjl1?=
 =?utf-8?Q?DS2lTA7Np6470k1k=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a2a2f6-4217-435e-9d04-08d9fb8ff96a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 14:30:03.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lrHA5z5eYh5HvHK984R73OaRi5xPxwRr5CLl3+k9WH24CVQFk8V6UNGcGrEjmBn7l8eNmjxox1HL54Dqij00uwR5DkpdYY8rS15A1VaKnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/28/22 14:56, Peter Geis wrote:
> Good Morning,
> 
> This is my patch series that I have maintained out of tree until the
> combophy driver landed.
> 
> Patch 1 fixes the grf dt binding from the combophy merge.
> Patch 2 adds the dt bindings for the grf changes necessary.
> Patch 3 adds the SoC specific binding.
> Patch 4 adds support to the grf driver to set the rk3566 otg clock
> source.
> Patch 5 is a downstream patch ported forward to shut down the usb3 clock
> when the controller is operating in usb2 mode.
> Patch 6 adds the dwc3 nodes to the rk356x device tree includes.
> Patch 7 enables the dwc3 nodes on the Quartz64 Model A.
> Patch 8 enables the dwc3 nodes on the rk3568-evb.

As far as the RK3568 EVB1 is concerned:

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

for the v4 of this series.

Thanks and best regards,
Michael

> 
> Note, there are functional changes from previous versions.
> 
> Please review and apply.
> 
> Very Respectfully,
> Peter Geis
> 
> Changelog:
> v4:
> - Add SoC specific binding, fall back to core.
>  
> v3:
> - Drop the dwc-of-simple method in favor of using dwc core.
> - Drop all quirks except snps,dis_u2_susphy_quirk, which is necessary to
>   prevent device detection failures in some states.
> - Drop the reset-names.
> 
> v2:
> - Add a dt-bindings fix for grf.yaml
> - Unify the reset names.
> - Constrain the force usb2 clock dwc3 patch to only supported variants of
> the ip.
> - Change dwc3-of-simple to support of-match-data.
> - Drop the PCLK-PIPE clk.
> - Rename the usb nodes to be more friendly.
> - Add the rk3568-evb enable patch.
> 
> Bin Yang (1):
>   usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
> 
> Michael Riesch (2):
>   dt-bindings: usb: add rk3568 compatible to rockchip, dwc3
>   arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
> 
> Peter Geis (5):
>   dt-bindings: soc: grf: fix rk3568 usb definitions
>   dt-bindings: soc: grf: add rk3566-pipe-grf compatible
>   soc: rockchip: set dwc3 clock for rk3566
>   arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
>   arm64: dts: rockchip: enable dwc3 on quartz64-a
> 
>  .../devicetree/bindings/soc/rockchip/grf.yaml |  5 +-
>  .../bindings/usb/rockchip,dwc3.yaml           |  2 +
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 37 +++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 11 +++++
>  .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  9 ++++
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 35 +++++++++++++-
>  drivers/soc/rockchip/grf.c                    | 17 +++++++
>  drivers/usb/dwc3/core.c                       |  5 ++
>  drivers/usb/dwc3/core.h                       |  1 +
>  10 files changed, 165 insertions(+), 3 deletions(-)
> 
