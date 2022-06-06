Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C253EC72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiFFM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiFFM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:59:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E423146D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPAz9ocFy430xupOvhcrwa09a2xFVQuvCRjgdgfZ0orGrxMhAKQieHYMEU/nuVAN1XjoG2FNS9YVfrzug3VAe0AqWuSrbbzzlMjdgfRa642UtUKtjk4PMeIa5vGNzrOI3dvr/lG1BgQhz9pB44pogzgUSXsG5DBs7e4VkGH719AArTBF1WHnWWUhkHjMqxZksYlupMA980qwXxf4Hj+DhXhw7pCMf6lcA13R6akmkycEMcy8KgCZwPaQuwLQKYyNOrR93//idBBzBtsoLN22fTuwA8IY6bUYBM33I9S8WNawgMic6rbWDTxT3Mf/gxerFAiDzoD0o49+hIDIDUTbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZ2aktnt7dRdeEWaHtQs4hHuBHKyUFjObnUYp2yKFpU=;
 b=afkXG5y6eBOMINeyU8mMwBfLwf1THJVuk+M7q42s3F/ueG9ena8ADN0nnITHJWuJvUEhPDycyOpu76bwRFvJrO5uROBgDkZm9UPCGQuvMAcvl6e/mlz38htr9ehn43+hwiD8nYHwFTrpl7cUWJkEeqLS7RDJue/3rskVR1r0+sG1+wbmA8S5NFKfPKS2AqV/zVMOy+olcgsjWUlqeOWdxwJUMQSrnm6bXSJjo2oSVTnf867z64cG8McfAtqYw3VqkPuVu3NGvGiL2MVwLFs9UMGj9vh7Q+XKp4+vXYw2zOghDC6hufRbBOorGfgRIOB6eSZNn+KsK9lEm889gjYZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZ2aktnt7dRdeEWaHtQs4hHuBHKyUFjObnUYp2yKFpU=;
 b=m7aFW2m3yoXN9ojPvDihHrerPi/jlIYyOEqVPbzp0OaY4lREPWJALRIQEdmm+N6JbFXKcGopNDCyzyETpT+32RewR+Ru2OHcLrigwJPKIvtxc08i17Yf/Mr77dBH+wiXZJNhQAMpGMJK4OIWgrg8M3FuCB1APzjS78O9QWnTS+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by PAXPR08MB7318.eurprd08.prod.outlook.com
 (2603:10a6:102:231::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 12:59:12 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2%3]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 12:59:12 +0000
Message-ID: <45bf11a8-47eb-e088-ba99-30c8788c7143@wolfvision.net>
Date:   Mon, 6 Jun 2022 14:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on
 protocol list
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20220523171559.472112-1-cristian.marussi@arm.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220523171559.472112-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203d80cd-9dfd-4e9e-6619-08da47bc5a2d
X-MS-TrafficTypeDiagnostic: PAXPR08MB7318:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB731893B2688B04786848023EF2A29@PAXPR08MB7318.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oc6kQrxZFcF6plkoJ2OULAXzQuuW2DDAokK2v6v1zlJi8cr/6N1yQs1sPuiTerM0kKqrNSGtN6CqdNS1ZDLb1xtRJANoeACKtoUCZ0wsx6pUfJV/hfmrhmv1pWJpLApsqc9bpVW7l6XGe5dHmmerEhEzJGq2LJaoMhF0OT9GXceln/KPyW8qc1m7JeH5t//q+iV0tDJa4KT/I2dDcHbEaeYkkLfAJhDadm4oG+nuBrbEOdm4nd2Ty6ZEwbOZ0wuYzFpgy7KjXmCi3t3yNfbdI6G3hUV1NOSziyTHJxjOFhEQxjY21HO5qfuCx4QpZR+5SPixuFSYjup1Ix8iN1A0O4gqVY/K9xgQ3Rm1zvRD1Y0nA0Z6ydVSPMX0M9pes4XwUTvsfo1i8GMKcUrFmBHibCxKPFlg+l3hqy8KAM+p0yLf2XiNFruZglnOQJVDtfKhfZcrWcd0uNseISMj3AOXXuPZNqplnSDXXYuS6dSYYESFc3uDdNyULiJu46+t8mPoIeHWi8hzQeclQdKYxCa5MiFNHItyf1oTV9YhI39U4U8PpR+wbxfDRzGuS8msVB4HVbHn8bcz1Gp/hr2mUriNInDIeXJXbInrxCh8XKWswlE080nhMmCDYD9ZQBMsKGPjBnLTaCfiRhf26Pd7dYGPzTC2xKDvjv2DY5pryPV4eHAz5b5BAiL1RsH1k+hgVDPE6XgT6RHqSwn4vQnmQtC0r92aerWvo7gEO66MP3xZZ2czeglJTt8pifGXUEgP0aKm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(376002)(366004)(39840400004)(136003)(346002)(396003)(186003)(2616005)(41300700001)(2906002)(4326008)(36756003)(86362001)(8676002)(31696002)(31686004)(6486002)(54906003)(83380400001)(316002)(6512007)(508600001)(44832011)(8936002)(6506007)(66556008)(52116002)(7416002)(38100700002)(66946007)(66476007)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhzVDhmOGNFd1NnMEZRZkZBbXBmWURUNm83MVZJRTh6RWNxaktkcXpQNlF1?=
 =?utf-8?B?QloxM0p0dVBZRDhqMGtOTnNWNTRYSjF1V2E5V284ZzFqb0N0b1hwRUJWUldl?=
 =?utf-8?B?NHFvYzdlOUFzVlJtSmNRd1ZsK3gvbGxRUlAxTFhzUGczZVpjTDlUcis5MXFF?=
 =?utf-8?B?clFqT2k1Z2JDVW12OGpKMW54aTlMaDBsQW1yVEw0WVNDcllsMmlhdnJzWHdk?=
 =?utf-8?B?Z0d4OWZreW9VUlRvaHYxbTZIS3hpS0pFNm93Y01kOENVWVpsY1BJcWdLZ2R6?=
 =?utf-8?B?ZkRtWUtXTHRTTkgyVHpKN2NrdERoeWFONGJ6eVNnSUpYTWp0ZWhmVkxpcGkv?=
 =?utf-8?B?My9xb3Y1R1d5MXdhajY5Nyt1RktlbGlONnJCNTM3ZFh0Zk9WTTFqSnRObFMx?=
 =?utf-8?B?RUhQOEtaazg3YnQxcGFRMjN2a3NiWXowZnhrUnRuN2ZqZHBnVVUxUDl6WkNy?=
 =?utf-8?B?SVEwSmw0TFNMN3Mrc1JVYmpnN09QNGoyMDBHaTk1Nm9GTTJzU3c3MGtzRmhM?=
 =?utf-8?B?L2diTE1Vc0h4TUR1RzErY1ZJSTlRZG13VFVlUDk3Nno0VXE3dFVLc3ZreCtV?=
 =?utf-8?B?ZXIwTW9vM2g1bDNpMkV5dU42KzI0aDJYbWNSZU9OWXNKaEtUVGt3VC9VMmFj?=
 =?utf-8?B?bitZdnp6STR5YWI0WGZDMlJtbWxWSndyRXF6d0YyK3A3eG91Y1FDT1ZMbGtF?=
 =?utf-8?B?RHVrOFN4Y2ZIeDhpakFmSzZLaGdJNGNXQTQ1aDR6VThaSXVvNXl0dnc1aSt5?=
 =?utf-8?B?NjRYeFFrVit3czVGMDc4SGliMzJmWTdFNGYxcW5INTZucGZBWFgxNVJuREcy?=
 =?utf-8?B?ZEsyZm5oKzl3d2V2NkR6My9tRkpEOEtXOFdjVURLUHlCYkVXVUxZdENqWis2?=
 =?utf-8?B?N01hNE9uYnZUaUJ4Wk5seDJqOHNjaEwyb1dBNDZVYUxENUEvcE5PWUVmUzRi?=
 =?utf-8?B?QWJxTmgxSXJMTlBQeWJzWmx4cTlDS1J1R0dZQmJ2Z1NzdVg1dGhDN1p5OUs1?=
 =?utf-8?B?cEYwRWJNNHlXY2dxRnVIT2UybkhGTDgxWE15dlJFaGpUUVN6KzBKNE50S3Vq?=
 =?utf-8?B?MnRrTnFMSVZUbTB1czBSd0kwa0ZMZUl5eE9PMWNzU1pVRFZ6ZVNSbU93dVVD?=
 =?utf-8?B?OVkycWhrb0h4aUMyblJkT21uTGkxVzdDdkkxYXdUQ29FSko0K2pOOU4vRWMr?=
 =?utf-8?B?UkxUajlvcnJ3Z09TZHE2WWcvNGFXcG8rVFBjRzErK1FydHRWNE9Gd3hKbFlm?=
 =?utf-8?B?RWxQVjRBSExUeTJYS3VHVVBTRElXSGhPS2EwNVFBaHhvdXpwMFFtYk94cEM2?=
 =?utf-8?B?NjJqeGJOWDUza3BzbDNsSW40NUI3MFlsVlB1RWhTT2ZFVVpnSFJId1F6a2xk?=
 =?utf-8?B?azNDN3p4NTJqMGlmY3NEQ0ZyZXdlcTdzUk9DWXpGWE5CUUhTRHNneDZKSWt0?=
 =?utf-8?B?WU40S2hWS1ZuZHZMb2lDdjVhbGszb2FXOUc3S2RGS0lXdkRoOHp3Q3B2QmJP?=
 =?utf-8?B?a1RjT2lRcU0yUHg2RnlxRXplVG9YbVpOajlUV1hYTWVRUk9HbmUyT0lMSE1T?=
 =?utf-8?B?NWxWMXRJd0M1SDdzejUwYXZnYnA2cDVjRG4wdE5zbE5GU3RxVy9hNUVJQ0Ux?=
 =?utf-8?B?b3ZiK08zUkdSZm05RGpsY0Z4ZjgxaTFQOGdaTDZvUzloVFhtTWhXTUVVR2xz?=
 =?utf-8?B?WmRGbkhya1BHWTczNVF5UFJib3FPWWJMNnAxWTd0RmhIc1ByVmJWSUlUQklX?=
 =?utf-8?B?Z1Q3NEVaVnBwWTFxMy9Wc3Z4YTNnY2JyZnc1akgzTHFzbkpVMm52ZlNra0F0?=
 =?utf-8?B?RHkraEdsNEpzOTA1QUhvTW1pWm42dldOLzMzMlZTelY1RVQ4MTRKK3RJcXA1?=
 =?utf-8?B?TXhsZjZwNndYY2thOC9Ja05Ob2JUMGRQbERoYyt5S0JqUHc4QllnQUJqOVFB?=
 =?utf-8?B?MElMRkhFVGpOYlJOOTJ2VVp1aElxS3g2cVNxeDZ1NjNSRS9lK3lCVDhxUU85?=
 =?utf-8?B?NTI5MmxtYUlZWFdQa1pLV29vWHdGalFyT1BwQnloaWNpVGluMEUxSE96ZFhN?=
 =?utf-8?B?NVRMWDBpM0M0cGlTQ1Zjd3g3d21XdG5MQ1Mwa2pYdTNjRWRwMTEwOHR2cjZM?=
 =?utf-8?B?eXorQzIrRmlqZU16cXF3N3BKaWEzb1RTd1cwc3diZ0xka0x4S1FtMlRPUDNu?=
 =?utf-8?B?ZDlLVGMwek95d3F4RTQ1dERORUR6aUN6dXhaWlNEbUs1ZHZtYWlRcUViOFpQ?=
 =?utf-8?B?OEhPcFU5Ny92cDFpakJRdW5KcGNxNDI4UDVGK0pseFRDQmozSUw3bFhuaWtH?=
 =?utf-8?B?VXBOVlBsaS9RSHNoamlaZC94MTlvdGdBa2JJTURTUzZYSDJlbzB3ZlQ1alpw?=
 =?utf-8?Q?DlAgIMKHj0u6nhR/eAAIrE26M7yebCzzh/1CiYzx8S9YF?=
X-MS-Exchange-AntiSpam-MessageData-1: ToOyJNpllMxSxSDVR3p0CK7xYB9N6Eka3UCk3ekNXtAF8Y86EvN/tUPg
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d80cd-9dfd-4e9e-6619-08da47bc5a2d
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 12:59:12.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW3rPy3SifX0yIG29WBqftT5lc4wqm1mn7cOOI7eYI8xKcjr+7D4buX9xpSopwn+qZRrRJl8PShbP4RiNDMcWBn5OmjM23eD5p99cTHjWCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7318
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On 5/23/22 19:15, Cristian Marussi wrote:
> Even though malformed replies from firmware must be treated carefully to
> avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> be tolerated to avoid breaking existing deployed system, as long as they
> won't cause memory issues.
> 
> Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks a lot, without this fix the Mali G52 GPU won't probe on my RK3568
EVB1 in vanilla v5.19-rc1.

I guess this patch should have a Fixes: tag, right?

Would be great to have this in v5.19. AFAIC:

Acked-by: Michael Riesch <michael.riesch@wolfvision.net>

Best regards,
Michael

> ---
>  drivers/firmware/arm_scmi/base.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 20fba7370f4e..d0ac96da1ddf 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -221,11 +221,17 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
>  		calc_list_sz = (1 + (loop_num_ret - 1) / sizeof(u32)) *
>  				sizeof(u32);
>  		if (calc_list_sz != real_list_sz) {
> -			dev_err(dev,
> -				"Malformed reply - real_sz:%zd  calc_sz:%u\n",
> -				real_list_sz, calc_list_sz);
> -			ret = -EPROTO;
> -			break;
> +			dev_warn(dev,
> +				 "Malformed reply - real_sz:%zd  calc_sz:%u  (loop_num_ret:%d)\n",
> +				 real_list_sz, calc_list_sz, loop_num_ret);
> +			/*
> +			 * Bail out if the expected list size is bigger than the
> +			 * total payload size of the received reply.
> +			 */
> +			if (calc_list_sz > real_list_sz) {
> +				ret = -EPROTO;
> +				break;
> +			}
>  		}
>  
>  		for (loop = 0; loop < loop_num_ret; loop++)
