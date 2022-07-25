Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE07257FBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiGYJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiGYJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:01:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72F8B85D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:01:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v13so7214911wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=oDGw3WVCUqpb1y41tcLQhQZCB3Jkdv/9EGqZqsBM1SQ=;
        b=I1fhCkNu27OGN7Su+f7uyyZcISxU2+WbQ5HmPddk7CtE2cPl1TtpAMV82mYQHu2JTq
         Cs48CbMOZhMEjZfbfPKY1RUMRDD1dCgcoSqocJXsMGCPX39SjriIlwDhSrcyLVmdyu63
         D5nTvdq4RRIHJtTTXKeKMWX39fAA4lpGLHbzHbrjWiwQxP2NeGqdk8Fg+EX+hZPlYi6r
         XGomyUA1ZbGC/xcFG+kZOY+bTaPA7b/DirD5fOyweA6VixBaYfZZsQkAOtnBE3M0s5kv
         zYTMlhlggE6TiFSSd0vVn3qmwOE/ogDnG5n+w93rMeq848bAE/U0o8wbB1umx8D5q5PA
         lB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oDGw3WVCUqpb1y41tcLQhQZCB3Jkdv/9EGqZqsBM1SQ=;
        b=Mg+stcceh/7aLMJEtJfUBVApLqR2VmX7UC1AMMgPNU2wPf8iVChjObMdjIBatewRFy
         NNnQGv9TmZr1kxe7qO5iD2LnCrMQxakkY0AsbAx//irohYgL9RWvKvZhpsQU5npQrZ/D
         E8UEnDj4094gKml6av7L4sYZkICTOb8klQCInJokyRde2cPkS8sxba7JTrg3qP2cWX+a
         zjQlQGjvWVc5xvZ9GteY9OdCtWoqLAtQizGUxI6ZGnCkDFxZWXvsQpkj9zBDnPQSb2hY
         zsjI7O+7YdB/sFT4XgO3dsf35zFepDYegXzYo9T99gAnXZErUmiBBCLKcFKKMiE5PYwP
         87bw==
X-Gm-Message-State: AJIora+aMCjtfuYCaLhU0ucC5fydETpkjUuu/UnxJ+VfnD/PTqyl/hU/
        zEUrturEfdseGTZJGP1rLwEsEvDRwDv5Jw==
X-Google-Smtp-Source: AGRyM1vmszB0XdSa2HBsMAR85kUABI5hCHOPFiTJ0YewyS3HdWyPG2vzZJymYlF3mE08s/9WMTEJrQ==
X-Received: by 2002:a5d:4523:0:b0:21e:5796:3622 with SMTP id j3-20020a5d4523000000b0021e57963622mr7273694wra.456.1658739682454;
        Mon, 25 Jul 2022 02:01:22 -0700 (PDT)
Received: from [192.168.1.9] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b003a342933727sm11246988wmq.3.2022.07.25.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 02:01:21 -0700 (PDT)
Message-ID: <f7df92d8-5faf-b643-cb3d-57115ca6cebd@linaro.org>
Date:   Mon, 25 Jul 2022 12:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <b06c71d090ae7eaa3cd047bb0067f566371bac3a.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <b06c71d090ae7eaa3cd047bb0067f566371bac3a.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 16:34, Nicolas Dufresne wrote:
> Le mardi 12 juillet 2022 à 17:53 +0530, Viswanath Boma a écrit :
>> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>
>>  V4l2 encoder compliance expecting default values of colormetry for the control.
> 
> nit: colormetry -> colorimetry
> 
>>
>> Change-Id: I1db0d4940b54e033d646ce39d60dc488afba8d58
>> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index ea5805e71c143..37ba7d97f99b2 100644
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -352,6 +352,8 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops = {
>>  int venc_ctrl_init(struct venus_inst *inst)
>>  {
>>  	int ret;
>> +	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering = { {34000, 13250, 7500 },
>> +	{ 16000, 34500, 3000 }, 15635,	16450, 10000000, 500 };
> 
> What is the origin of these values ? Should this be done in the control
> framework instead ?

We needed some safe default values to satisfy v4l2 control. I took the
values from here [1].

I'm not sure do we need them in v4l2 control core (most probably it is a
good to have it), Hans ?

> 
>>  
>>  	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
>>  	if (ret)
>> @@ -580,7 +582,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>>  
>>  	v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
>>  				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
>> -				   v4l2_ctrl_ptr_create(NULL));
>> +				   v4l2_ctrl_ptr_create((void *)&p_hdr10_mastering));
>>  
>>  	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>>  			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
> 

-- 
regards,
Stan

[1] https://www.elecard.com/page/article_hdr

