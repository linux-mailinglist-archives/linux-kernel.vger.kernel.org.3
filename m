Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BFD543749
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiFHPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbiFHPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:23:08 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33415A3FF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:19:37 -0700 (PDT)
Received: from 104.47.13.55_.trendmicro.com (unknown [172.21.180.2])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 93E5D1000065F;
        Wed,  8 Jun 2022 15:19:12 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1654701552.023000
X-TM-MAIL-UUID: 941246ba-839c-48d6-898b-5cd9b49b7675
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.55])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 05C88100019CA;
        Wed,  8 Jun 2022 15:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArEB24V37jVPqL87TKH7Ef85FpFftmHKfPe829UejLZ4IfSxTwX/+HPJ2ncfk40d6SZFwEvxboFKEJkfWa/EXE2nI439qZXkm80TW0dP9pbFIb9DkgX15yq5oCaLiu2e+SCotRF0LMkZhfTuGaPrZ0GiNGNaksyg/p11rv5dk2jFt3XIgy4FalEqv4F8fdSTyESbYrWHLcjKI1bKTywS3pvqu06ylWCWapVrL/Rr7r/VM5VcTLWS9rb0Lj5FWN1fZGkhMQMMlPGfANc+3roncEbyy+/iuMtuVvFvCsZaHQJ5mee06plEzPFsnx0S1mOWpf+48YuWCkrN5Z/FSPAqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8NZJq6bDixnn8cWf89V7iVKH+9GsSh+4KG4ZrhoDHE=;
 b=XYxusufl+FCHLh70UdrpHF2bF+Uw3Zz2jRZqjB7pPDgVzInjElMvSyg0OHu/T45bEehJNn/vohqCZ7GGADfYiJjOkwu7yEjWywUUh1wCJj0dS1gWgK6ottmd/HG6CoE5bnH1rOJCqbvvrmT85+aOb6tgjqp50f+5pTh971Ulbhe3odGNFVBqA4nL5XrVnZ1/1dX4UWBXv1Qum/uKUd67+u/qUt65sRMUAktWk3Qw/82Kv25IPHu3AhxkCLOeSXl6fEKmO+EZ5MKRAgsqdeR8K/xaIhKWRNiwc2guBjs9bYj9vm7hx7JFK8/sSoBvsbKKdIFaPyFdv4ukGd+Tu4zPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e71ba4db-202e-a74a-3c36-b4dea5566d43@opensynergy.com>
Date:   Wed, 8 Jun 2022 17:19:09 +0200
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com
References: <20220608095530.497879-1-cristian.marussi@arm.com>
 <20220608095530.497879-3-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH 3/3] firmware: arm_scmi: Use preferred strscpy to handle
 strings
In-Reply-To: <20220608095530.497879-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0194.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::19) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fafbd3-4aca-4c2a-f810-08da49623d2d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3877:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3877065D80415781843B8F2F8CA49@AM6PR0402MB3877.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VB1cDKMAZhmZ8mR90E1jpBBxgyVWEaNrjo5gzveHrtgSK2tZfBsi0qivUp916dnrKjdIcv8vp3pdgfcp7NByrPVeBkpXnFklWls47XD1Fbdq7yRnZgWga73tmtipxKkXuUlRU/u8vtYcUFev312fr1oAkaoDUMenmYtCZVAyEGCGbLhlwXydivN1zzj/s2OBOftGEMd8GLdYDAPEdT9d50rUmI4Y21bRY5pKYTrMQE/tY6JJQkABzuQiJ0RcLgG8XOv3kjVl3WtXipaqdWjF6Z8U/fS5UUGF09sPd9IftewJ2pEsMhVJ5Yf5qmAF0KiVZFsuiefomWIrD6r1hlqkyBLJn1RoRiQBD4iSI2wPp61VJNDmY4H/CT0nCLZWmvS1IRaxPoB38k8V/wOKR4THAy9/kbKlS5GSiKvx6Fn0etsT5++OaoZ6/pGSRMIstlPQSs0aJkC9ArTp7hL7KT4E3SJ0+LwX89+qXpA2HW//UsWOcRKjmJYOFSzCQof7NBLbsFawk2P02I1ATWsvGLP3NVca34dvIz8rsxrRYGUIIOlFVMgDN5krDOTRJq8c6FqRuYEJ3RLSUjtCkp2/9lfb3gkYErTMCSuBsEEpjCt+ltZwuJMdcDQaurzPPKh+Bhsema2Dt43L+mfFJsSSi74ouw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(66556008)(186003)(316002)(8936002)(83380400001)(42186006)(31686004)(66946007)(8676002)(38100700002)(36756003)(2906002)(44832011)(66476007)(5660300002)(53546011)(31696002)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lYSnpzYk5pQ2poRTh0ZFprVVZMU2FrWTV4MWxiLy92bnhQMFdSZitUVnpa?=
 =?utf-8?B?WGN0SnJ3NGtWcmFIc0RqS2J3Q2ZKelZBOXRIdjFJdXRDNktwR3RLejE4eTI0?=
 =?utf-8?B?NEd3dG9kcm4yQmliNjBVbC9IT3R5WkJFVGtKTTZBNEI3WmJlL2xobFN6VTU3?=
 =?utf-8?B?N0FNSEhuVFVSelFjaTNnRE5RNi9Wb25WMzZMcTU5ZDJ3aUdiaDBFSVBKR0ZF?=
 =?utf-8?B?d09mWGFvR0ZYQnQva1pmWXNrcjZXNkJKbDdBbnBjT0QvUUx0TlJQemFuRXVG?=
 =?utf-8?B?TDIwdVVVemRvUEJoQnBhL2hJczZYajVnUGVRcVZIUUZiUXcvSDVnei9xeC9D?=
 =?utf-8?B?eTY4cmlYVlluTCtlcjc3ZGFBQko0bFhDRjE0RXZXM0o5ZFVzZW9pTURxUXdO?=
 =?utf-8?B?TWlsZzRITXY3c2VsQnliWVdkbFNBVVUwYTJFbzE3L0VTUHdHbE1BNnNxUnFa?=
 =?utf-8?B?UTNiWStIMXgwdnBDRlVoUS9BRE1lY21Nb1hpRWI5bklmOHh2dFdOQllaRXIr?=
 =?utf-8?B?WGRoaU5HcHd6QnFFZVhLRXArTFh4SVNETFlEYlRQZ0pWTHU3QXB3dkx2WmxW?=
 =?utf-8?B?eUxGUmx4N2RXRU9XUjVaWUg4TkFpODd6aHN3YkkwREhBc21mV3d1TDR1aE95?=
 =?utf-8?B?bU9BdmxFVGprTEZscDVNVUVKa09PTUpWc1ZwcCtQUk1odzA3QVhhRUl2b2R6?=
 =?utf-8?B?QnAzTWY1ZzRVNTF4N0xxTUNIVlNNK1dTa2E3VFA4VUpFODZ6aEF6YWkvWVZD?=
 =?utf-8?B?WklZTFJVMC9DY1FSaXF5Tk9ockhpZWdSaGoxS3JSUll3T1cyeHJhbnEvRDA5?=
 =?utf-8?B?M01pOTZvYXpua0N0UGlDN050NHBNTkxXVDlPa3lFYVl3L3h2a1VrWWt4Nk1w?=
 =?utf-8?B?R0xWY0JCQlVCZWRXZlBka056bXZpTEVDUWh6VmQwSGk1K2ZFZkppdU1YVTY0?=
 =?utf-8?B?c1llais4NnhnT0djaXhyNWlQdWtrZ0tMQTJ5ZE9ISEJzV3pnZ2tFek1NdzFq?=
 =?utf-8?B?aW1kRDBvN1JCSUNKdTIyY05QM1FXd0hiN0Z1T2hNSE01dE0xR1hGVHg0bmVT?=
 =?utf-8?B?RmFZcEhkUmdMWlY2VThBcE5BWVdua0pDREMzTkgzb3U0Z0RrUkJpcFhQdW4w?=
 =?utf-8?B?aU0veUVkSGNKUE13M2pNT2g2cVJTdWVOQWJzZVVJaEtBbGt1cXFCWTZlWmdC?=
 =?utf-8?B?d1haV0ZHRSsxbU51OHJQdTd2WVZlejNCKzdROFBiWHdrTkdqa0NZWUxUNmtH?=
 =?utf-8?B?UFR3NklOUG5DSmEzTE9kbFJXeVFiL0tUY1pPNjBNcDRidkh4QmNlMHhsbWFy?=
 =?utf-8?B?KzF3UmpPR2xZUXZ6d3dtQTlOUFAyUGNrWmVqL1FYWUhMV3VzMVk3MGNTbEh2?=
 =?utf-8?B?Ny9aMUZYeEV6cXRTa1lEMUNFVllBV01mOCtWS1ZkSnFKOU92a3hRNGRtSjU5?=
 =?utf-8?B?K1V6U0hWZlFUWXM1SmdLT3RFOWRKK2ZaMk1YNU9WVHpHa3Rpc3R4SXdtemNa?=
 =?utf-8?B?WC95SWFVLzBLNEEyUzlOUWZmWWg5QkU5czFTWWw1WnhuR2Q5M0tXZzRYcEZ6?=
 =?utf-8?B?djB5TExaa09NNHZCdm9GY2lwS05uRE9JWUlHcENWZUo1TVFlMVB5WHVuRzJG?=
 =?utf-8?B?OEJ0dzAxM3VHcVFaTGgybnlRT01JbzZTNHlGUnhjS3lwaFZPWkZKSDFCY0k2?=
 =?utf-8?B?YmZ5YlVKMG8vcUx2L3hDZUg4eVMzRVNuK0ZSNjQvdEx6Q29vdFhPQjBUaHJj?=
 =?utf-8?B?dmRHaHV3emtyY0NUK0ZlL2tBTkc3bEJYLzBvUjVnaDVCMVZkQWhxandQZmtm?=
 =?utf-8?B?bW8wbXNmSkpTeS8vZFZJOWNwV0o2OTNFNldXTW02blVoWFlnWHdsbDc2UjBp?=
 =?utf-8?B?RW1INktkbE9qTEFDWGlrelNXWHhJa3N3dXMvSG5zK2dVUUtxc09EZm1nQldm?=
 =?utf-8?B?d1N1VTRyd25jbC9BZjhCZTNycFJwTVVIRGNxQkZkTk4yeG82OFRMNjNPcTRD?=
 =?utf-8?B?dVV5NS84TFMvV20zSmNXWFNTNHJYQkJ5ZE1rN3RJcEdSdElNNWJuRDZYMStO?=
 =?utf-8?B?V2JoYXJ4OVRvbms2Y2ZQbGlHdGM3WHI2N28yc3pLS21pQ3k5Y1Qrcm1LLzl1?=
 =?utf-8?B?ZmNKeGdzd0VaS0orQldJMDUyOHJ1Mnl4YzZBTWZHRm92SnhDSWY5c3NNc2pQ?=
 =?utf-8?B?bTIzdWRNc1RNd3VvR3U4bnptMnZ4bkh4RFlUQnVVMXNQblcvN0tnekVGbDRV?=
 =?utf-8?B?MnNQV01hcjZkdmk0OFBzWWM4czNpVzY2TTV4ckhBKzZUQ1h5VmduUHA2OFcx?=
 =?utf-8?B?OVhBRUI2emtkUVZMQXVhZHU1TFFsR29UdHVJSjRhQlBjbFRJN1k1VzlnQTZr?=
 =?utf-8?Q?gypvcz7GJUbWey8WxhWJuu3mMdhIbTb4NQKa0FHgFA6C2?=
X-MS-Exchange-AntiSpam-MessageData-1: 4gpX8Y8hpGNosg==
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fafbd3-4aca-4c2a-f810-08da49623d2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 15:19:10.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxibHcmPvD7V8Mk2Je9rk4WXcnZlnVW2M2ZpiRn5MtLgn3py6j18Hskk6uEeTq2gxQSvGUS9rKTIO2BBtElxmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3877
X-TM-AS-ERS: 104.47.13.55-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26944.000
X-TMASE-Result: 10--7.146200-4.000000
X-TMASE-MatchedRID: +f/wAVSGjugMek0ClnpVp/HkpkyUphL9GEfoClqBl852WyWfI8cX17ER
        MpuIU2oehPscUcu6Cfw+jgBHpxu6du8QljqNvuG6kCThXPqsqisYH39vFLryE+PsX9qV3arkMo2
        of6fSrt3odgNepR+E+Z33gveUEAAcFwfDEoKO/5GC+Y2uxPjociEEwm0ncLbiOhR0VsdhRrC/BR
        68O365bn9eOltIlLtrK3zipCmfjlqTiN/on4eNSXzmmMD/HXF+0MQw+++ihy8BeuPUOTLHR/qAD
        eqinEVfBNSB1bQ1dKtFkHd/dGgtnBLcDqfEqfizDJbLZQ2fIBdKTvzkVGmdxZsoi2XrUn/JyeMt
        MD9QOgChMIDkR/KfwI2j49Ftap9EsjvNV98mpPM4XUADkWm4AgiEKaDWzZxBvmuwDCufUGUGdIs
        GzhaDY2jvxu02OrdkftwZ3X11IV0=
X-TMASE-XGENCLOUD: 339a2885-184e-4962-afa5-470d1e15a1db-0-0-200-0
X-TM-Deliver-Signature: 4E3D0873ACF2512DD82DB0C91BF823EF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1654701552;
        bh=/Z5UHSr676DLi9LccU9QxkRPA4NnByktAHbsE0zmmEg=; l=5472;
        h=Date:To:From;
        b=OuGqbdsPEJQd+toZpWI0O91Ha8+zvYWLtjH3QXHMLQxLEsEDBou0US0z0CwtsxwwL
         GgT8FANsqejP3OrwbP6AB72zu4WvZK9t36dH3o50lzFLkrQ2ZkkPCDcmKk4MJjodU2
         PDtPR3wl9Vcdk2C4JxhNFUXbXr0bg+r4Hnd7IKVsZcihyOJi3W5iWdmGSK/BrJ2ATm
         Sg7mZWpUY3b5uaTsVKLufaCBvSKoslSzg6VAGdaktahaW4Rn7n45UX57/ObnVX9aw9
         4EwVR+hDmrljsU8z+UiXIj6Jg8Cg235yR2CL0SKb2ceZ8J1CuoskRH9l5ai1LTOtlh
         +q9DaO/Lwhr8g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.22 11:55, Cristian Marussi wrote:
> Remove strlcpy calls used to collect short domain names of SCMI resources
> in favour of the preferred strscpy; while doing that change also the used
> count argument of strscpy to make always use of SCMI_SHORT_NAME_MAX_SIZE
> while dealing with short domain names, so as to limit the possibility that
> an ill-formed non-NULL terminated short reply from the SCMI platform
> firmware can leak stale content laying in the underlying transport shared
> memory area.
> 
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: ca64b719a1e66 ("firmware: arm_scmi: use strlcpy to ensure NULL-terminated strings")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Peter Hilber <peter.hilber@opensynergy.com>

> ---
>  drivers/firmware/arm_scmi/clock.c   | 2 +-
>  drivers/firmware/arm_scmi/perf.c    | 2 +-
>  drivers/firmware/arm_scmi/power.c   | 2 +-
>  drivers/firmware/arm_scmi/reset.c   | 2 +-
>  drivers/firmware/arm_scmi/sensors.c | 4 ++--
>  drivers/firmware/arm_scmi/voltage.c | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index 1a718faa4192..c7a83f6e38e5 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -153,7 +153,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
>  	if (!ret) {
>  		u32 latency = 0;
>  		attributes = le32_to_cpu(attr->attributes);
> -		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
> +		strscpy(clk->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
>  		/* clock_enable_latency field is present only since SCMI v3.1 */
>  		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
>  			latency = le32_to_cpu(attr->clock_enable_latency);
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index c1f701623058..bbb0331801ff 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -252,7 +252,7 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
>  			dom_info->mult_factor =
>  					(dom_info->sustained_freq_khz * 1000) /
>  					dom_info->sustained_perf_level;
> -		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
> +		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
>  	}
>  
>  	ph->xops->xfer_put(ph, t);
> diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
> index 964882cc8747..356e83631664 100644
> --- a/drivers/firmware/arm_scmi/power.c
> +++ b/drivers/firmware/arm_scmi/power.c
> @@ -122,7 +122,7 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
>  		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
>  		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
>  		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
> -		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
> +		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
>  	}
>  	ph->xops->xfer_put(ph, t);
>  
> diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
> index a420a9102094..673f3eb498f4 100644
> --- a/drivers/firmware/arm_scmi/reset.c
> +++ b/drivers/firmware/arm_scmi/reset.c
> @@ -116,7 +116,7 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
>  		dom_info->latency_us = le32_to_cpu(attr->latency);
>  		if (dom_info->latency_us == U32_MAX)
>  			dom_info->latency_us = 0;
> -		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
> +		strscpy(dom_info->name, attr->name, SCMI_SHORT_NAME_MAX_SIZE);
>  	}
>  
>  	ph->xops->xfer_put(ph, t);
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 58fe4f0175be..42efaee27b7c 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -412,7 +412,7 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
>  	attrh = le32_to_cpu(adesc->attributes_high);
>  	a->scale = S32_EXT(SENSOR_SCALE(attrh));
>  	a->type = SENSOR_TYPE(attrh);
> -	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
> +	strscpy(a->name, adesc->name, SCMI_SHORT_NAME_MAX_SIZE);
>  
>  	if (a->extended_attrs) {
>  		unsigned int ares = le32_to_cpu(adesc->resolution);
> @@ -633,7 +633,7 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
>  			    SUPPORTS_AXIS(attrh) ?
>  			    SENSOR_AXIS_NUMBER(attrh) : 0,
>  			    SCMI_MAX_NUM_SENSOR_AXIS);
> -	strscpy(s->name, sdesc->name, SCMI_MAX_STR_SIZE);
> +	strscpy(s->name, sdesc->name, SCMI_SHORT_NAME_MAX_SIZE);
>  
>  	/*
>  	 * If supported overwrite short name with the extended
> diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
> index 97df6d3dd131..5de93f637bd4 100644
> --- a/drivers/firmware/arm_scmi/voltage.c
> +++ b/drivers/firmware/arm_scmi/voltage.c
> @@ -233,7 +233,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
>  		v = vinfo->domains + dom;
>  		v->id = dom;
>  		attributes = le32_to_cpu(resp_dom->attr);
> -		strlcpy(v->name, resp_dom->name, SCMI_MAX_STR_SIZE);
> +		strscpy(v->name, resp_dom->name, SCMI_SHORT_NAME_MAX_SIZE);
>  
>  		/*
>  		 * If supported overwrite short name with the extended one;

