Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972D4C496A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbiBYPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiBYPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:44:06 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AE1FED9A;
        Fri, 25 Feb 2022 07:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gomPrv3Up4a4Xy5wJ+JreUN1YZSMKeFlesmFVJ0mfKcDPDN0U2bhiiGuXqOvDu7AGoSRYRECsN9Pf/Yt+3fIbHvxkyf1FEzpM+sQQO6APgD9Ex7Yki35hDIrcUJRZtcwq7o0GBckyGzeW0H0guEEfkcBw3pgJ2cxQFIy+apxQqF2iHlU7Fd2KFbSxaaHxOhuIVlEHE2Et3chW0v9rB3Kjmd7vZOGuI5qlLvUuVq+Oli8cYuAQHQslQ0ZRsamtusmt/xhktev7r8e2dfItSqfEyRHYima3Gn3jwhSAczesPUbGvh0LJjluxjhz3T4iDptylJNfWQHgW7aP4CWUSaTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PFWIGMLBVFYyRoRqOy9GZLLhCqdluI4o57L2C3p3z8=;
 b=HJcC9sXcPiIuAug+7VAQvG/dct9+uFt+keyvCRj5Am4Pa+jfwvsS3iB37J372WFAODsXUBIxf3JTogTO8wzTY2us57e9mgqE0Fgnlhfr1wGpwdWoICrhO8XSQz/UceB2lnFq43Z35KF2lhN6L8Eoe6lbop9KJs2FbiD3QOChQBokXcMGArzr6xWcy6OSTzXYArtRa15o2mjPxQvKxhCbibrFujvb908u1pny6peNyLY2C4UTovI0uvwIrhCxJjPtiSMHZKSmyPqY1w3D2IMffLFLqPubd6mEmDSd3kmPtdJONGcSgppRbruOIScicLBb9RSLbm9YtuZfgzXfuK0Ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PFWIGMLBVFYyRoRqOy9GZLLhCqdluI4o57L2C3p3z8=;
 b=LRsoWl3/9ZxPH8mt3nCv9iR6mKCogHdMYBdFaYwIjU1FRX+SgdGzd56CDwq/nRrOCx8T8bzu5NpMguY4EdUc0ntt4AAxKsme6Fz2CBkxdikU8d3eIxQ2Bb4EDU+vPe63Tx9WTWG74jWdZLwttUWmm3MNWxPsTLxHt3XU1VCKKBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB7004.eurprd08.prod.outlook.com (2603:10a6:102:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 15:43:30 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 15:43:30 +0000
Message-ID: <53bf7d2c-baed-75fc-41e9-63166beec414@wolfvision.net>
Date:   Fri, 25 Feb 2022 16:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: move power domain PD_PIPE to
 rk356x
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
 <20220225131602.2283499-2-michael.riesch@wolfvision.net>
 <2939d801-586d-85fd-97ef-d42925ddecce@arm.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <2939d801-586d-85fd-97ef-d42925ddecce@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719b27e6-8ea6-4ffc-4f13-08d9f8759225
X-MS-TrafficTypeDiagnostic: PAXPR08MB7004:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB700439749539E055ED5194FAF23E9@PAXPR08MB7004.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecWDKdp2Os6WSif4MCppkA9qJ89f1PzaNkD+VrET0LCkzwkymKsmwGSfVyaeq7vpRCtxFH1nThfIqrWSQml4fVZdkJ+0wbgmoYFmv/x6OaQIi02SrWQj/4PjqWaP/dP96BwHOkcKmIRe8eK9NMVsGmOqXDykXPeClLVsO4U04okktaILJNV/aldJF063zoPU9E78bbqtGZ5FeBrTT8Vdm5jFRVdnirRaevp03fwFelRZJ6/GI3/MWHBxuVAwoIX55yy+ulMQkO7GZLtwgiVHTcBuc+30lQRex79XEviAQG206lB2VPaq+8/QM0J/Uzn7cFuc/4wOiUXvqUfORMr9rzrhuftM+rEvNTvbOgv6jsQxNMmXhaa3uM1EiO87nobqriTDob+5ZgXNhJasPjxj7Zt537CVF6lXacEJDatyu8yGh1HG6BBPgQvpYIlLQEqz0FFtGwA+SM4XtgJOiJNq06Gc3olzbKnK2c+wWwpeGq5aKsLy8XNwp6fDXbaPArW3rZB5rfRyGQiA0zKX2H1rpmfh7znR2Ndc84EtsONsyxNjJF3TV+G5kQHSCzkZc/ZnYguKMzHCH+UN2Jyy4UWreWCbL7Gw35GDcEyCQMhS0KNTTu2Hy/BvfPhhr/0rD8T/z7i+NNi8Ota7eWOMnyUF85Imeli28TI8ZOjLxuCVhIQnfZb9rLkO2BxfOBHkcHqOwswc74bqhB62N2fGkpN8p/0GhcYspzSKze2roNRgRHzieDZPViVs8DHZi2Q/INaKxdrFVf83evXSQ0g+YQp9ZT1qHVwOVp0NcT4igHRF4Ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39850400004)(376002)(366004)(346002)(136003)(396003)(44832011)(2616005)(6512007)(8936002)(83380400001)(31696002)(6506007)(31686004)(508600001)(53546011)(6666004)(316002)(6486002)(54906003)(86362001)(36756003)(52116002)(5660300002)(4326008)(7416002)(38100700002)(186003)(66946007)(2906002)(8676002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFU4aGhvVmZlUVo1MlMwSUM0NE1Eckk5SmwxdSs0b2VoM0dON3JuZFdodG1j?=
 =?utf-8?B?ZWc1aVdaOWFnakh4MHpIeEsyVUVDVHhhNCt6TWltVkZ0Zk5EdUg1SXRQZUQ3?=
 =?utf-8?B?M0xJQ2xLTTdiWnc0dTA3SzM4SE52NUhVVkxEUzYwWjZlSkhPb1BHbHU4bDNq?=
 =?utf-8?B?c3RRR2tiblU3SUswNFZaWklzVGp4b1ZBZG93RWJqeVBhVjRrdGZNdkprcUkr?=
 =?utf-8?B?bTBuRS9WbFFKUitMVXp3QlJNSnJIamFuNlhHazFyVTRMZTVSOHpSZ0kxYmtD?=
 =?utf-8?B?ajZoMTNzK1NsV1hBTnkzc2xkazBldFZNYkVjdXdkTm13eCs3ZUplOGIyYXRP?=
 =?utf-8?B?T3VSL3V1dmoraWRleXdjOWduSnJONHB2bGdwYUZTRDJwYVpnWmlwcHRkditK?=
 =?utf-8?B?Mzk5YVZ6cHZicVBYTzZQTWJQMTNaWHNUR2YxS3l1YjFIbVZLQ1NXYm1PbG1V?=
 =?utf-8?B?TDBYVWlWdGZ0Y0Z4MGZLTFBIcVRPZTJkeTlFV1VFZUo2bUJaam1BU2FJRFZH?=
 =?utf-8?B?QUNHMkFSUWhsaTU5Z1MwNU5IN2NWdmhjVUdqRDd5VFMzRkhSVEZsQmdQdG83?=
 =?utf-8?B?T0MxWndWNURUV1dldnpEZ1FqWjdZcVNmZGk5cmpReHI5NkNGeElZbnkzQ1dQ?=
 =?utf-8?B?UGs3bHFCNmNqOEJaUzkwZ0UxdmpyNEExeGF1dGE5TFg4U2g4amdJVm9hN1FS?=
 =?utf-8?B?aTA3d2IzWmg5RW1KUnI5Ky9tWDBHZ1J1RnJISDQ5UjlsWUFvVUxnVDlDbW1l?=
 =?utf-8?B?NmkwWElDZkN3QlQvL2QzQS9jdGNYbk9wbnprTEZZa1FMcGtERDJmbGR2bVF5?=
 =?utf-8?B?ekhnVEFQSjd2WDVXa3FsNjNmRzd4VDNjK0xsU1hBOHowOFpxMWhsdG5Id29H?=
 =?utf-8?B?bDMwLzZ2aFJMbHhVbXVESEtDYWU3OTV6VHkzaW8zOWl4a2ZGZ2J6U3lLMHoz?=
 =?utf-8?B?dnJ1ZjREKzhXUEt0Rkg5WUV2Q1ZOV0ZOMnQ4SVEzaXZtUVo3RDZYRFhHdWRM?=
 =?utf-8?B?bGdyZXdJbzZxeHV3cEMzUVIxNlhqOEZ0SmVDR0JJN3dSU09Ic1FKNTZGTDdZ?=
 =?utf-8?B?Qm1vYVNxRHhDUXJGZW5CYW5ZVUovdUM1TTBBWnZWVVJmZWxkZndLZUtQK2cz?=
 =?utf-8?B?MGVhVGNxc0RSQXNMckQ2WFljcUE0b1g3WFdNUHl1WDJ1L2szM0NGV1lTdjhC?=
 =?utf-8?B?UzhHM2hEdW5JQlgzNVZ1dmpQRis3TkdWcTl5ME9hSEZWUjVWUnNhVnNKK05M?=
 =?utf-8?B?U2s5aCt5UlBvUDJNeC8xTWM0dEdrNDlLaXY0c3J4d2xzZWlVbVZ5ZXlBSlU2?=
 =?utf-8?B?SEMxQWQ2VVdGTHA3SWNqZ08vWFVkQXBFUG1FMTBhUHgram80K2lycDlLczc3?=
 =?utf-8?B?bldMQy9Fd0ZmR05PZGJiYVN2Y1pHN3VXZEhaczBhWW41NnFWMWhSR0kreUQx?=
 =?utf-8?B?UW5Gd2hpTVhvYkdqZng1L2J0UXhMaHNLWE40WEZqd0Y1eUlCeUd2Vk03NFNi?=
 =?utf-8?B?YWR1cHpTbUw5eG5NRDFUMUJhRGNxbW5GSFNwSzlCNXVsbktFUGpFQ1BtT083?=
 =?utf-8?B?bWVHcHF1RGZreXgzQ0JpZ2p5RlRBOGpJNGg2aTJwS2VLYVY2cjgrK0xRaG1q?=
 =?utf-8?B?NGhHK0V2OVZPekZUbDV3SVNqTVpTT2RvOTduYUtFTUpqMDRwUks2VnRhcTQv?=
 =?utf-8?B?SmhjS3hJU2taN21DOGNicFMrbXNEYVZCN21VSlZJRHgrSlEwWnlOejExOVRQ?=
 =?utf-8?B?TDBEak1mc3ZZbHFpc2ZJWG1rZkpUSTRmb1FPblJUNVM1b2RtNm5PR1dmc3Jm?=
 =?utf-8?B?ZHBxMnJkb1cxOVpOQTRIUjJKWUg5ZUVhWk03c3poOW1KVk9QVG9sR0JDSGhi?=
 =?utf-8?B?SkFvKzcwd25ISERFZUdhN0RXbG9CaXlTdkg5NFZVbGMrOERrQUZjOE1FYVg0?=
 =?utf-8?B?WCtjSnlRckFubHV2WmVYaHUxc3FnWWJBbStLWXZwWXRMMlYyY1VWMlpHakFi?=
 =?utf-8?B?THc3c0wxc0M3c3NlampBc3ovYnE3Z05wQ21JSHZVUy9mdTZQeVdtV1ZQZTA3?=
 =?utf-8?B?Q2tGTjZNNXZ6U3h5elE2R1hQOFEzeUJVLzA3L1djQTROODlwY1FYQU03QmF3?=
 =?utf-8?B?SjlQQWtVK2ZZY09BcitFRXgyUzE1T1BVbXAzRHpBOFBaUGNuSVdIbVRkOTl0?=
 =?utf-8?B?UG1VUnh4UnA5MzNLZ2srU2xMYXNRWGhGS1B6NDVKK1J6QmhHNi80RzFGVnNo?=
 =?utf-8?B?Z1hZSEwzN21WRjRsQXVHUWtCMmV3eTIvZG9vV01VUTdtRjJjUkRyajloWDhU?=
 =?utf-8?B?UzdORWZBRXhpLzA5ZkYwT1pud1hxQXBsWEFIY1NsOUYxcXpZeXU5S2RvVGMr?=
 =?utf-8?Q?b2Xv1MVAMel+6t/4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 719b27e6-8ea6-4ffc-4f13-08d9f8759225
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 15:43:29.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnx+RMDsw+u3aN1Qgm4BKICHHsGeS7iEeqkkg2YiCIx7P/b8U9NDvOCG/V7mHFDt2x3tfFKHWbbzkQWkya3Vz4vu6L/RwMSbuEEwzTZjGP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2/25/22 15:14, Robin Murphy wrote:
> On 2022-02-25 13:15, Michael Riesch wrote:
>> The power domain PD_PIPE was moved to the RK3568 specific dtsi but
>> is available on the RK3566 as well. Move it back to the shared dtsi.
> 
> Note that a corresponding definition does already exist in rk3568.dtsi.
> That one *could* inherit the base definition and only override the
> "pm_qos" property, but looking back to the original patch series it
> seems like not doing that was a deliberate choice.

OK, my bad. I overlooked that both rk3566 and rk3568 have their
definition in their dtsi files, so there is no need for this patch.
Sorry for the confusion!

Best regards,
Michael

> 
> Robin.
> 
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3568.dtsi | 16 ----------------
>>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 14 ++++++++++++++
>>   2 files changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 91a0b798b857..ecc0f3015915 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -100,19 +100,3 @@ opp-1992000000 {
>>           opp-microvolt = <1150000 1150000 1150000>;
>>       };
>>   };
>> -
>> -&power {
>> -    power-domain@RK3568_PD_PIPE {
>> -        reg = <RK3568_PD_PIPE>;
>> -        clocks = <&cru PCLK_PIPE>;
>> -        pm_qos = <&qos_pcie2x1>,
>> -             <&qos_pcie3x1>,
>> -             <&qos_pcie3x2>,
>> -             <&qos_sata0>,
>> -             <&qos_sata1>,
>> -             <&qos_sata2>,
>> -             <&qos_usb3_0>,
>> -             <&qos_usb3_1>;
>> -        #power-domain-cells = <0>;
>> -    };
>> -};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index 8b9fae3d348a..742f5adcdf2b 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -490,6 +490,20 @@ power-domain@RK3568_PD_RKVENC {
>>                        <&qos_rkvenc_wr_m0>;
>>                   #power-domain-cells = <0>;
>>               };
>> +
>> +            power-domain@RK3568_PD_PIPE {
>> +                reg = <RK3568_PD_PIPE>;
>> +                clocks = <&cru PCLK_PIPE>;
>> +                pm_qos = <&qos_pcie2x1>,
>> +                     <&qos_pcie3x1>,
>> +                     <&qos_pcie3x2>,
>> +                     <&qos_sata0>,
>> +                     <&qos_sata1>,
>> +                     <&qos_sata2>,
>> +                     <&qos_usb3_0>,
>> +                     <&qos_usb3_1>;
>> +                #power-domain-cells = <0>;
>> +            };
>>           };
>>       };
>>   
