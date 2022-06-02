Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07853BAC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiFBOaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiFBO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:29:52 -0400
X-Greylist: delayed 238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 07:29:50 PDT
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A72200AF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:29:50 -0700 (PDT)
Received: from 104.47.6.50_.trendmicro.com (unknown [172.21.10.213])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 4D33C10096D2F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:25:53 +0000 (UTC)
Received: from 104.47.6.50_.trendmicro.com (unknown [172.21.180.2])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2DF9E10001744;
        Thu,  2 Jun 2022 14:25:50 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1654179949.132000
X-TM-MAIL-UUID: ec008f89-ec56-48eb-9382-54917dafa3d3
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (unknown [104.47.6.50])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2095F100021C5;
        Thu,  2 Jun 2022 14:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAjop8065GuLZhsdeHg1NVorwHRHf99HfyUMYFU18/n90ACTd7T+bWP0sJw6uglPptbD622ebNw0y9qenzfSlRXpOqAYVmeDUcvzW3qN6PS+wZVavGjVxExis3YxbfR/GBg98fB+WllCawEaSs3oz/whRjgfJkKhmSby61rNXROq3gQWmUtFXFtb0DeGK6mepSpf4vHdyZAUYPxjyRENhFxCR3oGsntJVSiNztauUGnKzD3mx8H0RIE9b7jlLXhpEt68hR5EMnnNixXrQNz0azZX92PWdc9lCEEaGdOXmPmS7eYAJDvaGfBP6zfL7QaizDAYh7RDw3RXkAyWFkCEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8sm7sAlKMuMO9p4bdPNuTuXxzFvtl37987hjG7TaLc=;
 b=LV/iCUiNj4lcrznHppDqxDmPWfPEN4+tbOFoo/bKA5z85ck0Ixrwi1f9zGPOi2PAuzJUnmAf+EtFwLE1N8X8NCsqyntMAlJYoS1yESaSjC8DtLsEQuynjSP6SP4XaY1/ZCyAB/Bxhg7KVRaANWj/mvESd0PVcBk584H6oUsLA2gBxonqc4sDM0xR3tIuuyNWEtM+cg9ZQUdVjbcyzW+qIh+Ytf8MkT38k29uBx/hqWJOdkI+JeXMCbYegChCZuTsaUyOBqMTIDoPO/AMEekcm1v/DDIN3B+PBG3uLVWg/WIgY7w/qwo8JbmLEMSqC6wMOWdsXz8F7W+zYH5Rt4Z5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d523569d-2470-3e01-c407-d6e723c7d0c1@opensynergy.com>
Date:   Thu, 2 Jun 2022 16:25:45 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-16-cristian.marussi@arm.com>
Content-Language: en-US
Subject: Re: [PATCH 15/22] firmware: arm_scmi: Add SCMIv3.1
 SENSOR_AXIS_NAME_GET support
In-Reply-To: <20220330150551.2573938-16-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:208:1::44) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c9b6b52-8d60-4985-db06-08da44a3c8ca
X-MS-TrafficTypeDiagnostic: AM0PR04MB4849:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4849672DFA41828BE8A49C078CDE9@AM0PR04MB4849.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRhtJkB6GS0hl5UixXirDt2tJT66im+4xNSh48N4TJKauhulGSJe4rX/ZCIe9Ny1gEQ4uD7XaSTvbgQx+8APWG7ArizDt7FeIKm3sEJ/4Cne7wUCIEOUuhq7tefC1RoiLal+0+D6PDQk0WFUg2kovxlhJnmGGUWLs3PY0E0dOeDPPI6xy5qnsuNYDYKe1oD7ImPyQQOdyhTv2TR/uS1cedcxT5alHyeKoiyI9zWh/YgOXU/jmzAluE6ygyrjNsshTs4iyDkAeCcBBbshpmHHvjkv1HIiyzHTixdgyZaWy+GTOHg0tWvdnzbXfKTH2b6FE0+7SmrnSxcrfd3oA7UHPS56oHZNhkEFUUE8Tcku0mF5j1/uixcjVxpK9MKzlSzfngy2nahhG2cq9b3e0gEIMa61tg4OUKAWf1EFGvjLXqM/aYUEg78ytkmSXxq/NgPR0PvI+CA3Gkc23Ngee8SUOauwXwjAGBhOMVqfVfzs7NYGx0pjWgsDdypCFFyLHu2lv6woIdbwgTsQwGiFHadPk1w1JGqjOIzYNVOVws5OeEjfp9O31YImoqKN0sssvsdNxqywOIUcvC+G7xFHa+ODj0ONjFoi7w2/JCF8K0Y8Jo+mEuMCT6whhOinpzl+N9/ecCzcG21a9ebQRJmLZ3Pu8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(39840400004)(366004)(136003)(396003)(36756003)(2906002)(66556008)(44832011)(66476007)(66946007)(4326008)(316002)(42186006)(7416002)(508600001)(41300700001)(31686004)(53546011)(5660300002)(31696002)(8676002)(2616005)(86362001)(38100700002)(83380400001)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNhSlgxcVlMWllPbkZOSWtDV3hVNHFNZG1sVmh2QzB1OXVLL1VwcDdpRVVh?=
 =?utf-8?B?WWNZVlZ4YXBZWnBTMzR5ZlZCcytVbnBqaHR6ViszV2s3V25IWnlhczNXR0pS?=
 =?utf-8?B?VmR2NHU1SjdLT0d0Vmk1RnFpWHBjaW96MGJ1MmtOWDhEQ0s0blY0OWxpanZn?=
 =?utf-8?B?eVFkNFlWcElad2U5eDJod2NFdHIxTjA5emNTUWoxNWxMNU5mR2U3SHdRbTdX?=
 =?utf-8?B?MWlKbHFrNlZwZ0Jkb1ZnVWNON3RKTzVnVVY4L0ZVK1RNYWUyaHNib0lyQ0FW?=
 =?utf-8?B?ZmxIZHp2SDlPaXIzYXRYditKbzNGaERhZDRrcnlBYUV6OXk1dVdGb2gxM2M0?=
 =?utf-8?B?YkI3ODQxMzN3OW40ZWlvYzZtdm14VEJKNnltb0thb3dZN0c3dEZoV1NIdUQ5?=
 =?utf-8?B?UjE2OC9QRHlLck8weE1GblF5VHkzS2xxWHlLVFRYdlN1U0QyM1ZjR21uRmNT?=
 =?utf-8?B?SUdPd1RNNzZxVmZOOHREdU5ObENJTGRqOGZ5MGNoU2pHWnFIL3p0VngramhX?=
 =?utf-8?B?UDRXV2g5ZEtvMW1GLzdTTUpKZEppenZLRTJtWUNmMlhqOTh1ajVpaWQwSHpw?=
 =?utf-8?B?WFNGWUNzcUJiM2J6VC9Tc3VmVWJvblZNSVpmUVQ3QmhVMDVaQUV0clY3V2xx?=
 =?utf-8?B?TDM1cWFHL1p3WUR6NlJFV0EraG1OMVpIdXdqQUdDRzdRVmRSc2ludlM0STVP?=
 =?utf-8?B?bVVqdVB5aDNtS29KaEFqZDBlR2VsOEFOVXovTXpmV1RZdkdPcUdZQnlKbEx4?=
 =?utf-8?B?RGRGUWlWRUlWSjR1d2IzQ0Z6NkVXMEN0dlBFRTM4TnV4STM2N0IwNDcxZU5q?=
 =?utf-8?B?M3c1dkhtQTNjTFlnZnVzNEVUeWhSNXhmNlVDMDRsNUxpeUpkbFZSMmlhaXlY?=
 =?utf-8?B?Wm1neTUyV0wrNWltMnIvcDRQMHlMNGdtd0hRU3UwQUZIQTZPWmM5ZndqYWwv?=
 =?utf-8?B?VmIray85aEhTcU9DTmJ2bGZSVWFHcFZVUEprbDdZN0g2azcvS1h5UHNrSDZR?=
 =?utf-8?B?M1pxaUFrU21iZHpMV0krdU11S0xHZXVKRTQ5S1NobUZjRm0xTE56YjRZL0dn?=
 =?utf-8?B?bkNUNnpSN3YwRHQyR2dxMGRnTTlLVEIvWk1UanVVN2g0ekZTK29BNFZhU1NF?=
 =?utf-8?B?ZmhlRm8zdEpvUUFRek5QMXBKTzB1T082aEJ4eUI5T1pWM0JJTmZpdk5tK0NN?=
 =?utf-8?B?SlNMK2p2T283MzgzY2FNNGkwR0RSbytGcVlMNEV2aUNmbjN3dG85dE1zVlM4?=
 =?utf-8?B?Ym44WnhKc1k4a1h3MDl5OERsSUF5b3BNcTlYSG1XUyswZHBHcjFjMDhRc2lp?=
 =?utf-8?B?TW0zejBVR2JEY1pUZzBreHZPdHkvTVJ4anBZWkIyVWtJL0twSnJWcFN5ajBV?=
 =?utf-8?B?Ykh4dzdocFdiZjN5bGh5ZzcyMGc5S1VTSzBZYXVXRXJwM2I5SHU5aGIxaGpJ?=
 =?utf-8?B?NWxQbk1IZERCOTNCTWlYV2NzS0NiQWRadTh0YXFLVHd0MkRzTW5uYVo3UlZD?=
 =?utf-8?B?MzNtNURWT3JON1cyVDVOeXVBY1hwWnFUR1hCVVVseUpCdE5MS05KMDJLZ2F2?=
 =?utf-8?B?ZjhaVmMyRzA0QWJFLzJJTXlhZDFoaEtoZkdqVnp2VGozcW1aVkNQZWVzanNG?=
 =?utf-8?B?UE55K2x5VEgvRmVGdzRISU5Vb1VQTmNkTFRhVlhJUUxDTUdJV2ZsSjRrSnlo?=
 =?utf-8?B?TjN2VjQ2bjArZzRqeGdLYTE0WGM2Rjk5RGJKWHBpZFA1MnVCaThEcFFKa2NY?=
 =?utf-8?B?STkyOWRjM0Z2YjAxUnZoSmRBb2NmU0JSUUdZWlQrallZNVg1T2JaMWJZQkIz?=
 =?utf-8?B?UW5SYUwzdW50Qm5ZZ1VtZkR4U3JEZEJ6QkhmRFlDdkk2bkJlTVc2Y2tFbmJv?=
 =?utf-8?B?eTZKZStscis2VVJab1Rqb2trd3lGU0Y5RVJadUV2L2pWN3V6SkM2RlZsa2NK?=
 =?utf-8?B?Y3QrME9JVGhyQ3lHMkFTZkpxTTRJTnpuZG9tdUMwMXFLb3R1dlJmS3JGS0wr?=
 =?utf-8?B?MWx2RnRNUjlwN29mR3hmc3ltdlNnWW9weTV2SU03YTNCUWlYNXU0VC9RRW8x?=
 =?utf-8?B?c2FHcmpaQ0JKYlF5N01NaEVHK3V2WU5qcDFzMVAvVVZTRFlmRjVWZmV6UVhG?=
 =?utf-8?B?cjIzakJoZ2pWVmE5eVE3dk9NOXRxaVMzSkRmK0FxNm56RTdNV3NEdk9iaUg0?=
 =?utf-8?B?azlvOEhOc0QrLzJubWFNaXJFVnlESFBxVXlieVRTVm1wZndYY2prZGp3cGIz?=
 =?utf-8?B?YlJaYk5uN2UrZmgwZDdsdFhuNms1T3E4eDNxYVJubHpXYWEybWlFR2pDQnc3?=
 =?utf-8?B?TjE5NTQxQXF4VmQ0M1JXUVdKTndDRFVVMzAyczkyZ1BLWVhZMG5CLzNtUE5T?=
 =?utf-8?Q?E0bKJOEWCklSN2Mj/LgAJGSKZZxBd+X5OFbFKpJH5ZyZI?=
X-MS-Exchange-AntiSpam-MessageData-1: dOXBQ/wCK4zc2w==
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9b6b52-8d60-4985-db06-08da44a3c8ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 14:25:46.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eqFFvD6El4t/jtq1ICRVEUWwe8pPj9zPnngWcpC0ptp9A5dBUG9mGyvqmHn4xTSVATunioNc4SBOrw7XDMvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4849
X-TM-AS-ERS: 104.47.6.50-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26930.007
X-TMASE-Result: 10--14.920900-4.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGj/9O/B1c/Qy3bspjK6JP6q9mojSc/N3QdlEv6AItKWF4nO
        /I/i7S2A31xh7JpF57xyuciK3rjhCrVQ6XPWwtdyEXjPIvKd74BMkOX0UoduuaY5ZGw7wyeHuxW
        P7AlD8NM/3QwynUylBzJPsGAQSaI9seY8I2CDJmS8coKUcaOOvVEwSDwOevUhGW7AFHmXEc/Toh
        hY3qi5AgP836J1bbqPYgTbC7wP+zinULniotLgm8Q4mpKyfkqZcV3n4J/0zUNcgT+8hMpG1WRxN
        dQB9xCvD25KFzNhcLR3ZVcbJy0H7pGGP7kET72BEzEoOqAAVLML//VMxXlyE5+9KccEt4MqDENM
        /mw+DTJCA5uqpIdWjFefQD4rOWh54MNSupiYvyaeAiCmPx4NwLTrdaH1ZWqC1B0Hk1Q1KyLUZxE
        AlFPo846HM5rqDwqtWKTSjAK1+IVsqyTUUfbI7FBq2O/FLHzcYxn+YYLRNcvyIB3JxQ/rbg==
X-TMASE-XGENCLOUD: e46a0e7d-a6b2-4443-b843-9fa6091365ca-0-0-200-0
X-TM-Deliver-Signature: 75F1AE1B8B8907E7E84C058AB9764843
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1654179950;
        bh=t6O62WX+cfB0+onUJdUTbojiTcmes11t3i1LIbRtfqI=; l=5796;
        h=Date:From:To;
        b=L9qNnBb5a7izdGXg+qfhzUCQxp5J5nUCsKeIWgylHmkZDhCkzVhZdxAbmNXZajAPv
         /2srWMv6/sS1Ur5G1Ag4vIwcSvVLISXhFjQ92NyWVLr+QZkokis+c8kQRpr0Lv0KnM
         dUWVPPBYru88ED6cgGlg7xdmXUQkSXLnR3bxbpl0a4NdJB7c7Wku7GWgtG3EYZexkp
         6EKxyfQau084PYC6aiY3N8kqvOuKEPhNw4oZR+/ffMISPmrbmY+sxvJwWI10Phe8an
         yQIKsN83Wgy+8A9aebDr56TQ6AjO5zN1lsaQ98z8TyzwE+N7XpLXsmrJpQ+SiocMk9
         7vj67edTAnDxQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.22 17:05, Cristian Marussi wrote:
> Add support for SCMIv3.1 SENSOR_AXIS_NAME_GET multi-part command using the
> common iterator protocol helpers.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/sensors.c | 82 ++++++++++++++++++++++++++---
>  1 file changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index e1a94463d7d8..21e0ce89b153 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -28,6 +28,7 @@ enum scmi_sensor_protocol_cmd {
>  	SENSOR_CONFIG_SET = 0xA,
>  	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
>  	SENSOR_NAME_GET = 0xC,
> +	SENSOR_AXIS_NAME_GET = 0xD,
>  };
>  
>  struct scmi_msg_resp_sensor_attributes {
> @@ -117,13 +118,22 @@ struct scmi_msg_resp_sensor_axis_description {
>  	struct scmi_axis_descriptor {
>  		__le32 id;
>  		__le32 attributes_low;
> +#define SUPPORTS_EXTENDED_AXIS_NAMES(x)	FIELD_GET(BIT(9), (x))

Hi Cristian,

I saw this patch is probably going into v5.19 already, so I'm a bit late, but I
wanted to point out a compatibility issue, and a small error handling issue.

Please see below.

Best regards,

Peter

>  		__le32 attributes_high;
> -		u8 name[SCMI_MAX_STR_SIZE];
> +		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
>  		__le32 resolution;
>  		struct scmi_msg_resp_attrs attrs;
>  	} desc[];
>  };
>  
> +struct scmi_msg_resp_sensor_axis_names_description {
> +	__le32 num_axis_flags;
> +	struct scmi_sensor_axis_name_descriptor {
> +		__le32 axis_id;
> +		u8 name[SCMI_MAX_STR_SIZE];
> +	} desc[];
> +};
> +
>  /* Base scmi_axis_descriptor size excluding extended attrs after name */
>  #define SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ	28
>  
> @@ -393,7 +403,6 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
>  	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
>  
>  	attrh = le32_to_cpu(adesc->attributes_high);
> -
>  	a->scale = S32_EXT(SENSOR_SCALE(attrh));
>  	a->type = SENSOR_TYPE(attrh);
>  	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);

The strscpy() call should probably change the size parameter to
SCMI_SHORT_NAME_MAX_SIZE.

> @@ -408,15 +417,69 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
>  		scmi_parse_range_attrs(&a->attrs, &adesc->attrs);
>  		dsize += sizeof(adesc->attrs);
>  	}
> -
>  	st->priv = ((u8 *)adesc + dsize);
>  
>  	return 0;
>  }
>  
> +static int
> +iter_axes_extended_name_update_state(struct scmi_iterator_state *st,
> +				     const void *response, void *priv)
> +{
> +	u32 flags;
> +	const struct scmi_msg_resp_sensor_axis_names_description *r = response;
> +
> +	flags = le32_to_cpu(r->num_axis_flags);
> +	st->num_returned = NUM_AXIS_RETURNED(flags);
> +	st->num_remaining = NUM_AXIS_REMAINING(flags);
> +	st->priv = (void *)&r->desc[0];
> +
> +	return 0;
> +}
> +
> +static int
> +iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
> +					 const void *response,
> +					 struct scmi_iterator_state *st,
> +					 void *priv)
> +{
> +	struct scmi_sensor_axis_info *a;
> +	const struct scmi_sensor_info *s = priv;
> +	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
> +
> +	a = &s->axis[st->desc_index + st->loop_idx];
> +	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
> +	st->priv = ++adesc;
> +
> +	return 0;
> +}
> +
> +static int
> +scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
> +				    struct scmi_sensor_info *s)
> +{
> +	void *iter;
> +	struct scmi_msg_sensor_axis_description_get *msg;
> +	struct scmi_iterator_ops ops = {
> +		.prepare_message = iter_axes_desc_prepare_message,
> +		.update_state = iter_axes_extended_name_update_state,
> +		.process_response = iter_axes_extended_name_process_response,
> +	};
> +
> +	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
> +					    SENSOR_AXIS_NAME_GET,
> +					    sizeof(*msg), s);
> +	if (IS_ERR(iter))
> +		return PTR_ERR(iter);
> +
> +	return ph->hops->iter_response_run(iter);
> +}
> +
>  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> -					struct scmi_sensor_info *s)
> +					struct scmi_sensor_info *s,
> +					u32 version)
>  {
> +	int ret;
>  	void *iter;
>  	struct scmi_msg_sensor_axis_description_get *msg;
>  	struct scmi_iterator_ops ops = {
> @@ -436,7 +499,14 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  	if (IS_ERR(iter))
>  		return PTR_ERR(iter);
>  
> -	return ph->hops->iter_response_run(iter);
> +	ret = ph->hops->iter_response_run(iter);
> +	if (ret)
> +		return ret;
> +
> +	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
> +		ret = scmi_sensor_axis_extended_names_get(ph, s);

From the SCMI v3.1 spec, I understood that the reading of the extended axis
name should be conditional on the bit checked by SUPPORTS_EXTENDED_AXIS_NAMES()
(the `Extended axis name' bit). Yet, the implementation doesn't use the macro,
and instead decides whether to issue SENSOR_AXIS_NAME_GET depending on the
(sensor management) protocol version being at least v3.0. But, per the spec, it
would be permissible for a v3.0 protocol to not support SENSOR_AXIS_NAME_GET at
all. Is my understanding correct?

> +
> +	return ret;
>  }
>  
>  static void iter_sens_descr_prepare_message(void *message,
> @@ -559,7 +629,7 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
>  	}
>  
>  	if (s->num_axis > 0)
> -		ret = scmi_sensor_axis_description(ph, s);
> +		ret = scmi_sensor_axis_description(ph, s, si->version);
>  
>  	st->priv = ((u8 *)sdesc + dsize);
>  

