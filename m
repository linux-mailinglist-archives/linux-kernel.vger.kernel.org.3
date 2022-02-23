Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1672F4C0E68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiBWIlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239002AbiBWIlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:41:52 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9216CA67;
        Wed, 23 Feb 2022 00:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkK+8I9yiUeZQWLKYJIJ6DqGcXjsauJSFN4rhcNQttdLZcAeWk0h5ROvnnucAKdwVdIze0lxerGTUUODfF0gs7GXcRege67jNho+ehuAYGIvZqWmQCZ2qW2stp8kr+XQsmST2B2vy6czvT1q9Qt6y5byUyleNEQybAP1wrPCBlWC78SDdtzNHtOwNcOEGn/OShEXYZcAcnpWG3RlLmjqiFpRT8hlokawNTGiKTMDCCrBqQhBcu5YgQciAAgKx4mQozzl8GkAK/LQ3ZvOZV9FD428i/qg/UQqBDlm5h8LWSBGVssZyePmEgv1Hyt1nU4b/8Nre2I3l+X4AU7J0djjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pPj934eM5zbeM9TxRZS0NSCvIdx8UY2p/ZWzjMGwPE=;
 b=oUqhMeYjxXVFjHLIK4n2RYd2+1uMFa8SULsZz8KJJeA2QXuTVMseWiBZzsRLwQMfFRCc6snY87Qllk9yLAaz8K/6RTSulIWG6f6Wx+kcJb5dqBfQMC4rk/84hmer4AE3Gik3ckSGHAg6tO6ZhVxpj/qmG2CrzwKElt1Qe2OfMb0DalM9GRgxERYCNQ0Bg9d6Knh72wXrsTOK0rvXBOy0EssPZwqWLguj2XPmcD6pblsYfGwneDHdpCxMvB0fRGQ8K4RXiZXNz8xrK/dXMbBNPoh7pBQ1jvLoyzdFKc6dd/+/2huceSrwRcyzOrqD8l+fRV2LK1vedq1n9jHhGQGdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pPj934eM5zbeM9TxRZS0NSCvIdx8UY2p/ZWzjMGwPE=;
 b=Pe2cFuzLZABC9sL/TWt5AAwoqj7q39wx2gH/C5YKmjftiEGW3T49B5pBHPfiQpJ7XboEx1cxwZ1aI2tXPfcYtQJMSSpSt77BNrUfDoIGf5ckoZCZGiiHihJ9hsKKG9wYSz6FZAiTXEavQO+9YwjEPwHu07G9p1F4jH/F8WV2h1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM0PR08MB4433.eurprd08.prod.outlook.com (2603:10a6:208:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 08:41:23 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 08:41:23 +0000
Message-ID: <7d5512ce-b94b-b890-f852-6c37e2698b7f@wolfvision.net>
Date:   Wed, 23 Feb 2022 09:41:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: enable rk809 audio codec on the
 rk3568 evb1
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        frank-w@public-files.de
References: <20220222175004.1308990-1-michael.riesch@wolfvision.net>
 <20220222175004.1308990-2-michael.riesch@wolfvision.net>
 <3287619.yDqD7nnjd0@phil>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <3287619.yDqD7nnjd0@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 918ff529-3f91-42e7-582e-08d9f6a84557
X-MS-TrafficTypeDiagnostic: AM0PR08MB4433:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB44333E0B7835957EDC830FE5F23C9@AM0PR08MB4433.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRY+0IfUK02jo/fYEloxwXfzuDjWqsiLM3uxjL78uU5Ie71qDKf1mZnBUVyuJ1krtAqENpk/pnPq4o228UdWO1Mq/CBMYxrlSaHCQxqgM/sQv2+LJ+g8aIa/GlM8/ayDNtz1r7wt6k0R3+CcgNAh5AUMqZgxdndGBlA/o0Arz2/qSStnbTtwU3+wLOE8AxWrKW8RDWPvSicrtVip6mf+QrIaZxXpes0S5d/csA71WrQlvqsfC8yVNkobEkJiDPx0n8Mtsl+4zlN4S7WBYwdYs0zGHHgj9FZF/Q0OF8t8klSVZD1FuXRds9vTnpfDLCiaWrCO69+iiJk6js8TvfVPzjdZ7Us/5YtnQDih6826pbRgb/XfnCePok15kRoQV3EIPlJTgLYmQ7ixRhl3HW2OCmvkOOum4uSeaL24pUnk46hWkgqqp1qeAb72yVK3GmyCceF9WokseVttKRtUStJeEPc9MjBPpsQb4EVO2Hlxdlc2mLvGfvNvcUpt7HHQ75lSXyIXDEeATaSo9gbUnMjWKkVP9lTpsY6BRMzlfn42nMOEsTXQ0Iww2AIib4AlrfpuSVs1/ob/FPb0cftAnzJsFjiMIVJ79+Maltkp85zPRUpfetZVH11zPIevflT/On8BHvzavuWKMr5aITMp2y1EScWHnOfIp8wuYy+7b+QJcaaTTRidmaueEzxqSfsXIP20BG38mI+NRfU066uhCTDRhEf00BMT4C/XhZdnw5Ibnqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(39850400004)(366004)(136003)(396003)(8936002)(53546011)(52116002)(66946007)(6512007)(4326008)(5660300002)(66556008)(54906003)(316002)(31696002)(8676002)(66476007)(6506007)(38100700002)(6486002)(86362001)(508600001)(31686004)(83380400001)(2906002)(186003)(36756003)(44832011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGV2NlNoWUNkNDkvRFFzNnBteXhFNk8xaFUxK2dWTWxyb01DZEpmcVRPaFBE?=
 =?utf-8?B?d0tQclBKVWhXdUNzTGVub21UTHQ0U0pWTGZNVTkrVmhSYU11cDRkeVZrbWhU?=
 =?utf-8?B?TDJ6dnN6ejJaN2dPa1UrUzZDSzlPZjQ1S2cycjJVM01hVjZUeEdpd2N4cnZr?=
 =?utf-8?B?WEVzOHYwdE0xcElhdlFOQUkwM2RHNVA0VnE1d2RZQ3daK04zbms4ZWJwTUtV?=
 =?utf-8?B?OE5UYjZicWdqb1Y1TGJFMHZWM0ZYWkRiL3hHdHp1NmtFczJmbVlqVnpTeTVs?=
 =?utf-8?B?YTdQUmQrUVFYalJmSHZOenR1RTJxTTlFSWFqOXJmS2xzLy81dEJJanI4KzZQ?=
 =?utf-8?B?aUVFWHV2cHdxZlpsVnd1TjA1OXhGVFd1alh1di9HcU04N0pTeGYyUDZIa2ZD?=
 =?utf-8?B?SlQ0YmZvTlc2REdSSmpBTmVvMnpGSzc1R1k1bkNyUGNWQi9mZE42UnZablR4?=
 =?utf-8?B?aUEreE11NDFoNDlJQk9tcVZaaEZRNFkvOXBQTUYvS2V6eHRmbjhvNE9VYk9a?=
 =?utf-8?B?OTh0UHB4Zy9PL3o5dE1yUlV0cWFINDA0SEJicWRwUjNXZktleUo4VkJvTXps?=
 =?utf-8?B?YnBQT0pYVjFWYUcvUXkzOFJIeUpyU1dhcUhNOGthbldhT0NxN0ViRFV5eU93?=
 =?utf-8?B?ZFpEckdYU3RZU1duSnV1ZkdiZHFvN0p3emVFQlg3a01NUkxZck95OEhWbnJO?=
 =?utf-8?B?aW8zVHpkalQyRmFrWG9JUjBmNzRwdEpwc1lKc1hud2hRbUZidHk5K2EwZDla?=
 =?utf-8?B?cjlHWUFGNlcrZU45ODgrTkY1bTA2SXNGek8yN3VOUXRzWVU0TWlRUkQvSWtn?=
 =?utf-8?B?MUpGYXpsTlpQVno2dHloaHFXandHa0xQL2FHS0RSa2FMN3Q5c3dySjNScmsz?=
 =?utf-8?B?OE5FZEhQSW1Tc2U3WTJ4c1JsV1Y1M3gzRU5iUCtxQlJ5YnNqeUFvRmdDazA0?=
 =?utf-8?B?b3NrSURFKzNqVFY1TjRDY3BOR2h3dEhvQURxVHBzYm9UR0tQeng5UG1qWnJp?=
 =?utf-8?B?SUNDNGd4UUZWczV1UmRyVGVBVm43Y09TTUMvVGYzcEwzK2JwbHRWSUc3MjdK?=
 =?utf-8?B?V1VFVE92K1AxOFdKcTZVUzVQSGFZM2ZzY3Z6THIwQ0M1TnY4Snd3WTNZc3ll?=
 =?utf-8?B?RE4ramM4NVByTUphclNDK3hDVWdCNFF0NVFySzJIcGZCb1JNY0hTTWF4R3VQ?=
 =?utf-8?B?ZE8yc3pzYVhTaEtZM2JUU3Q3WUwrR0RRdHNmdmd0azV0a1V0RzE5enEvMnZU?=
 =?utf-8?B?ejlBNTk0ZzBsSCtQd1JTdnFvVStNMDRmZjVmcTVXRnkzZlNwR1BKN3NpeWVG?=
 =?utf-8?B?ajQzZGtjVG83WnIxRjhYYm9IMDdUcCt6OFB4Z3dQRVZYQTY0dDZDeUFETURK?=
 =?utf-8?B?REYzYldvemphdzdvY0N4WUxYV1U4dGJudFA3Q3lvZFVEQUNOTXBFc3pKUjRU?=
 =?utf-8?B?dmRrcDhGSTlkVmRsWjlySVlhRW9TRXBBMysxU29lY2lBZ21nT05VWFdZRUJL?=
 =?utf-8?B?VktSYzg2VUFZcVdaN2lhUUVuTFBmcXNpSnE4dVNNK3Z6REJGTksva1RNRzUw?=
 =?utf-8?B?NjVXL0JHRG1TR0pXejlzWmpOWEtZZ3pqUGFnamlRMFZlK0U4d0FVVk54aHNG?=
 =?utf-8?B?cDg2cnJFbnVBS2pXcFY2dURTVnFBakZ1d3VCNXZLR0IwRXJCNytQY3JnRjRG?=
 =?utf-8?B?OENoTEQxemQ2YVpWZG5IYVZEQ0MrUXFkZmN5QW4wYkZjejJhNUR4cm9hNkU1?=
 =?utf-8?B?bUt6ZWU4eTJYcEJCb0dWQW4vc2p3dktFcVpESlYvc0NzZkFQSEt4QkUydWdo?=
 =?utf-8?B?TDdSQ3ZaM0lKOExGVXU5d3kvMXh5QStpaVpuQjdySlVpSlV4YXJGN05kYjJm?=
 =?utf-8?B?c2lEWFk4Tm5pYlZFZTdwSmR0T2hiSjlWaFVIdCtFY0oydUxscGNsb2FqNHFw?=
 =?utf-8?B?dkFTNTl6VnZ0WjkzSFdWc0pCczYrZGQxR3A3MmxXRytvVzZkamI2eXRaZzBo?=
 =?utf-8?B?MHVFSlFmQm5QQklSM0dUcUlGelhFYTBza1d5b2FtcW4vbTZid3VoSVRDWkxJ?=
 =?utf-8?B?bHJIOFdlMDNUb3ZCc2VXblZYV05RQWozN0x5dXJKdU9hWHlHWjFvNGtDbEVk?=
 =?utf-8?B?S3lCUkRQa1ozNmpOeW1MZkxUdlB4dERRckFwczNXb3c1VHN2eUl6aHJDMFNY?=
 =?utf-8?B?YmtjZVBXYnhTaU9kSDNtR2J5cm42SkNGR3kxRWNVTXRWY1dVTGpIMC9ZeWZQ?=
 =?utf-8?B?N0QwSzdXWmxVRXhycjB0VzlCZmt1UkJ1dm5tSGNTOWMwNGtVNjQvaExJWXpZ?=
 =?utf-8?B?dkNkT2dvQUIyZWRJZjNMWGMyWng1T2JZb1ZacVBIbzVjQnhxK2QzZz09?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ff529-3f91-42e7-582e-08d9f6a84557
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 08:41:23.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79GB7pnn8Yg18A35yfbe8ALNsO+kKPjJtp0nWK+cJWcMLNuzYlX5B3q7cs3gN3fl/IUszjV2a+3xSvA8ERytq0H6psqraxwB7NhVjzRcR00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2/23/22 00:11, Heiko Stuebner wrote:
> Hi,
> 
> Am Dienstag, 22. Februar 2022, 18:50:04 CET schrieb Michael Riesch:
>> Enable the Rockchip RK809 audio codec on the Rockchip RK3568
>> EVB1. This requires the VCCIO_ACODEC voltage regulator to be set
>> to always on.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> 
> [...]
> 
>> @@ -282,6 +301,7 @@ regulator-state-mem {
>>  
>>  			vccio_acodec: LDO_REG4 {
>>  				regulator-name = "vccio_acodec";
>> +				regulator-always-on;
> 
> As this seems to supply the codec (in the rk809?) shouldn't the
> sound part model that relationship and handle regulators
> instead of requiring an arbitary regulator to be always on?

To be honest, I am not entirely sure. VCCIO_ACODEC is supplied by the
(LDO regulator part of the) RK809. As far as I can tell, the audio codec
part of the RK809 is powered internally. There is indeed a note "IO
Power = LDO4" (which corresponds to VCCIO_ACODEC) at the I2S interface,
which would make the RK809 the producer and a consumer of this voltage.
This could be modeled in the driver, but seeing that the rk808 driver
and the codec driver are directly coupled I think it would not change much.

I admit that I am going for the low-effort solution here, but it is done
in similar fashion on other boards. What do you think?

As to the other consumers of VCCIO_ACODEC: The microphone requires this
voltage, but is there a representation of an analog microphone?

And of course the voltage serves as supply for one of the PMU IO
(voltage) domains (vccio1). But I think here the principle is that the
IO voltage is only turned on if there is a peer on the other end, which
(most likely) consumes this voltage as well.

If you decide to accept the change as is, could you please fix up the
commit message "rk3568 evb1" -> "rk3568-evb1-v10" for consistency? This
did not occur to me when I sent the patches, sorry!

Best regards,
Michael

> 
> 
> Heiko
> 
>>  				regulator-min-microvolt = <3300000>;
>>  				regulator-max-microvolt = <3300000>;
>>  
>> @@ -366,6 +386,10 @@ regulator-state-mem {
>>  				};
>>  			};
>>  		};
>> +
>> +		codec {
>> +			mic-in-differential;
>> +		};
>>  	};
>>  };
>>  
>> @@ -386,6 +410,11 @@ touchscreen0: goodix@14 {
>>  	};
>>  };
>>  
>> +&i2s1_8ch {
>> +	rockchip,trcm-sync-tx-only;
>> +	status = "okay";
>> +};
>> +
>>  &mdio0 {
>>  	rgmii_phy0: ethernet-phy@0 {
>>  		compatible = "ethernet-phy-ieee802.3-c22";
>>
> 
> 
> 
> 
