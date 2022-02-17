Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC44B99AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbiBQHMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:12:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbiBQHMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:12:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C95132957
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:12:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d23so8151120lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cEr9ceiXSBzxtl9pW55l2PGta6KX4196ZTMOQFJarqY=;
        b=np3fgCu6l1VhZUSWIXrd8VY48YtoJal3smJlQs93fg9Ywg5XRZoejvZRhulbNkpQ/y
         AWSXr4LWhVvagLBB1oN24NnacWGTzlzQNmftkwb7dl1IWGJ1kEUSvyMZPSY3unTbKUeF
         d4RZiITdFXae8qr2GVo/nv2HOIKnpJ36bi5eqVN4MdYQUAghyEmivM1CJeyHpdppOtYh
         9vraOypWdpLsv86N+130sPdZ68X1MZFrh8XGqAQe5AIxxdGIF1R0W5PPaI/mwwQKiAxO
         2Ek8GPxa/ERfzESvdXEsopRODe82vRI2Dp4WKd+4VhwaIkCGjuk5+Ie99kRmrtK9wt5+
         n2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cEr9ceiXSBzxtl9pW55l2PGta6KX4196ZTMOQFJarqY=;
        b=26yJCt0xgqtqi/vklM7uJWKGXUWSYyUvYipiuOxtbMTU508Js4ziEsBk+YvOAzPoTS
         /9lmGraD9hUYaRxJHS6lSnQCCNkNP1w9ASLoN4IAOwy+xlIOWzUUb8DB1vs8JFeglodE
         EU4ReCRgDUrnLRGvAGeblHVXSW4oXyMSKKlRomn6K+dmNglT6WFfw23Eoa6b3CxLQ94Z
         AAQjHJzm5emRoSjZx5JS438lbCIAiYb7XSn5RezNh1yGy0KSMhbq9EafhqtVEBtJ4VqW
         p3Fc4r+dVUStzNRgiQmTZ6W7/wG5INrQKssULpleK/NOA6PuB5kFa/grsxDOLnPjDLK7
         CjOA==
X-Gm-Message-State: AOAM530mbeTDrwLNTKg8nOcWU0t6a/8hUGimqmOL0yBTKIh+LYyqBAtf
        8x3GkuALplY03p+0ff4dRPJiIw==
X-Google-Smtp-Source: ABdhPJyUzt65C5f6ESKZs6SoN+X8J1YfJ+9Ofv8uW/Qw02VVoWXM/VHkeoOw1AcbxBoh2tXXohpYPA==
X-Received: by 2002:ac2:58d8:0:b0:442:bc4b:afb7 with SMTP id u24-20020ac258d8000000b00442bc4bafb7mr1116916lfo.99.1645081941762;
        Wed, 16 Feb 2022 23:12:21 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o18sm3276467lfk.17.2022.02.16.23.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 23:12:21 -0800 (PST)
Message-ID: <acf0a2a2-f2e5-906a-3c51-525abd18ee6f@linaro.org>
Date:   Thu, 17 Feb 2022 10:12:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [REPOST PATCH v4 08/13] drm/msm/disp/dpu1: Don't use DSC with
 mode_3d
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-9-vkoul@kernel.org>
 <67006cc4-3385-fe03-bb4d-58623729a8a8@quicinc.com> <Yg3mvEvqYs89dJWI@matsya>
 <4b89f5fe-0752-3c6a-3fb0-192f1f2e7b9e@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <4b89f5fe-0752-3c6a-3fb0-192f1f2e7b9e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 09:33, Abhinav Kumar wrote:
> 
> 
> On 2/16/2022 10:10 PM, Vinod Koul wrote:
>> On 16-02-22, 19:11, Abhinav Kumar wrote:
>>>
>>>
>>> On 2/10/2022 2:34 AM, Vinod Koul wrote:
>>>> We cannot enable mode_3d when we are using the DSC. So pass
>>>> configuration to detect DSC is enabled and not enable mode_3d
>>>> when we are using DSC
>>>>
>>>> We add a helper dpu_encoder_helper_get_dsc() to detect dsc
>>>> enabled and pass this to .setup_intf_cfg()
>>>>
>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>
>>> We should not use 3D mux only when we use DSC merge topology.
>>> I agree that today we use only 2-2-1 topology for DSC which means its 
>>> using
>>> DSC merge.
>>>
>>> But generalizing that 3D mux should not be used for DSC is not right.
>>>
>>> You can detect DSC merge by checking if there are two encoders and one
>>> interface in the topology and if so, you can disable 3D mux.
>>
>> Right now with DSC we disable that as suggested by Dmitry last time.
>> Whenever we introduce merge we should revisit this, for now this should
>> suffice
>>
> 
> Sorry I didnt follow.
> 
> The topology which you are supporting today IS DSC merge 2-2-1. I didnt 
> get what you mean by "whenever we introduce".
> 
> I didnt follow Dmitry's comment either.
> 
> "anybody adding support for SDE_RM_TOPOLOGY_DUALPIPE_3DMERGE_DSC handle 
> this."
> 
> 3D mux shouldnt be used when DSC merge is used.
> 
> The topology Dmitry is referring to will not use DSC merge but you are 
> using it here and thats why you had to make this patch in the first 
> place. So I am not sure why would someone who uses 3D merge topology 
> worry about DSC merge. Your patch is the one which deals with the 
> topology in question.
> 
> What I am suggesting is a small but necessary improvement to this patch.

It seems that we can replace this patch by changing 
dpu_encoder_helper_get_3d_blend_mode() to contain the following 
condition (instead of the one present there). Does the following seem 
correct to you:

static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
                 struct dpu_encoder_phys *phys_enc)
{
         struct dpu_crtc_state *dpu_cstate;

         if (!phys_enc || phys_enc->enable_state == DPU_ENC_DISABLING)
                 return BLEND_3D_NONE;

         dpu_cstate = to_dpu_crtc_state(phys_enc->parent->crtc->state);

+	/* Use merge_3d unless DSCMERGE topology is used */
         if (phys_enc->split_role == ENC_ROLE_SOLO &&
+           hweight(dpu_encoder_helper_get_dsc(phys_enc)) != 1 &&
             dpu_cstate->num_mixers == CRTC_DUAL_MIXERS)
                 return BLEND_3D_H_ROW_INT;

         return BLEND_3D_NONE;
}


> 
> All that you have to do is in query whether DSC merge is used from the 
> topology. You can do it in multiple ways:
> 
> 1) Either query this from the encoder
> 2) Store a bool "dsc_merge" in the intf_cfg
> 


-- 
With best wishes
Dmitry
