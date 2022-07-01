Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7F562C30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiGAHCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiGAHBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:01:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589AE599D3;
        Fri,  1 Jul 2022 00:01:35 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:2a18:eef7:517c:3467] (unknown [IPv6:2a01:e0a:120:3210:2a18:eef7:517c:3467])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C6E6660194C;
        Fri,  1 Jul 2022 08:01:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656658893;
        bh=NTiiCjHsVzQfkW49+IKSa3lND9VprClSAoCryBqkY7g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G0GQiXo3kDQz4wF1/cVHjADGf4/k+qqNIGKSr5xznbhyQVJmTYgEA/RwSr8naWWoX
         IKvvneS5gwgmXm3JatggW9poKEly4OItp7c2m/iTunYcjADZ686BqOrDkThAUCMlxO
         N5gJ09i4bg3oX8Grrkr5gdtmxAnM9/ZDuUP9Um1JYH+zNUwAb3TYRDWwEJwtWYS1z2
         FzXBUTgrhvfVHif3NcpOMwsjWtFMPVKOrR1Mkgh2R39kt1BYRpS5HynQvRD2SK/qlN
         ZBXTlaItprH8/yy3AyqtiYim1GlQXo1WXypgTsPprbWg4xMuyaGOmLhOFOJDwh51MH
         Cb1ZCMBK4ZVQg==
Message-ID: <16bb6fe6-0d95-d4d1-f7c7-f2ca61f7bdcc@collabora.com>
Date:   Fri, 1 Jul 2022 09:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 6/7] media: hantro: imx8m: Enable 10bit decoding
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
 <20220617115802.396442-7-benjamin.gaignard@collabora.com>
 <Yr3gDuzOXk58wTnd@eze-laptop>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <Yr3gDuzOXk58wTnd@eze-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30/06/2022 à 19:40, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> On Fri, Jun 17, 2022 at 01:58:01PM +0200, Benjamin Gaignard wrote:
>> Expose 10bit pixel formats to enable 10bit decoding in IMX8M SoCs.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Looks good to me.
>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Have you checked Fluster tests passess using both P010 and P010_4L4?
> It would be good to double-check.

It isn't possible to check P010_4L4 with fluster because GStreamer
videoconvert element doesn't support this format.

Regards,
Benjamin

>
> Thanks a lot,
> Ezequiel
>
>> ---
>>   drivers/staging/media/hantro/imx8m_vpu_hw.c | 27 +++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
>> index 77f574fdfa77..b390228fd3b4 100644
>> --- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
>> +++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
>> @@ -162,12 +162,39 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
>>   			.step_height = MB_DIM,
>>   		},
>>   	},
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_P010,
>> +		.codec_mode = HANTRO_MODE_NONE,
>> +		.postprocessed = true,
>> +		.frmsize = {
>> +			.min_width = FMT_MIN_WIDTH,
>> +			.max_width = FMT_UHD_WIDTH,
>> +			.step_width = MB_DIM,
>> +			.min_height = FMT_MIN_HEIGHT,
>> +			.max_height = FMT_UHD_HEIGHT,
>> +			.step_height = MB_DIM,
>> +		},
>> +	},
>>   };
>>   
>>   static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] = {
>>   	{
>>   		.fourcc = V4L2_PIX_FMT_NV12_4L4,
>>   		.codec_mode = HANTRO_MODE_NONE,
>> +		.match_depth = true,
>> +		.frmsize = {
>> +			.min_width = FMT_MIN_WIDTH,
>> +			.max_width = FMT_UHD_WIDTH,
>> +			.step_width = TILE_MB_DIM,
>> +			.min_height = FMT_MIN_HEIGHT,
>> +			.max_height = FMT_UHD_HEIGHT,
>> +			.step_height = TILE_MB_DIM,
>> +		},
>> +	},
>> +	{
>> +		.fourcc = V4L2_PIX_FMT_P010_4L4,
>> +		.codec_mode = HANTRO_MODE_NONE,
>> +		.match_depth = true,
>>   		.frmsize = {
>>   			.min_width = FMT_MIN_WIDTH,
>>   			.max_width = FMT_UHD_WIDTH,
>> -- 
>> 2.32.0
>>
