Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB165539E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348828AbiFUS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352291AbiFUS47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:56:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761429C95
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:56:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f39so8281690lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=WnoLWhxeYHm5yTgtcGD1IsezPefmqZIcjwjw5Wg8Y1s=;
        b=A0iPKWj/b60aY72nWLN+L+5qwzuBwgkTum1Nj3z85tVeILqikpZo97/piph2moEAyI
         ZAA5BM8ZMmcGV+3zxaWwi0lPt+yVJkZOmJ/qN0sH6z/ioOvf0Kezc0cJLj8f3NQ7m1pc
         eB1q+sX9/jXxB78m0DhfWhyW40vltUW/UiB3WK4EPIeKXPAj7ecznjMPow0YduS7gwP5
         f1b54Vs01hf9s3H/yG2oTu5b1GqmF2MH9VPm40JiN5fBJWpR8Uv5ustdhVHU5fRZ1Z5G
         DBH2agrb2JSwNH4CpO18Vhe702GF/BFl0r0bIJdQJTwrESpYDe9meRlfhODVit0zZ9Vb
         uyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=WnoLWhxeYHm5yTgtcGD1IsezPefmqZIcjwjw5Wg8Y1s=;
        b=b1l2oHXjcaggbZ9fGcl5YhmcbO0dsh952ECcxvs69eH5yU88C7cy/aW5cAq4zk/Yy2
         esVvAbr1PF0sgJYGRmq/P+H0JP5gViKqQzi3/gURA1mtzTTEOSXQg6mGjpL5NQPfV1Pj
         n6FpE8wfiFZ8CCaDm2QvAa4SaEk6+aG/sDZhC82Zg44K2y2TCGAOSv+jjQ1tc/XL0GJb
         AEVimXHPo4Rgez/I5b6BCHJdiujwiexS/1fw8bCYlOGWHti/oqlidYG7lTqAfv1QY51d
         9Y2CypuvVTRsIwCqRha0B78WimvY+NGn1NphfEJMPpC6fZfw/XvRaG7VPGCdeU5ZKip+
         ZSFg==
X-Gm-Message-State: AJIora+DLMvGXgU8pvxlqelRetpANRmC7VizTh2biAXr+E6V1kbJzhLD
        RylNZL3Uenw+L+DFs3QgxR6FEw==
X-Google-Smtp-Source: AGRyM1sftYHhG2H1/RbaWHAxQwPnIdXY1mfFVlAOlwLGeBmR2GQ87dQlV7VOlpFL1C5+w62FZN3G5A==
X-Received: by 2002:a05:6512:1513:b0:47f:6b4b:5e8b with SMTP id bq19-20020a056512151300b0047f6b4b5e8bmr7764466lfb.469.1655837816113;
        Tue, 21 Jun 2022 11:56:56 -0700 (PDT)
Received: from [192.168.43.7] ([188.162.64.230])
        by smtp.gmail.com with ESMTPSA id b3-20020a2e8943000000b00253eee43dd7sm555624ljk.44.2022.06.21.11.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 11:56:55 -0700 (PDT)
Message-ID: <9ed319ee-07bd-253a-c7d8-a35d7d709da0@linaro.org>
Date:   Tue, 21 Jun 2022 21:56:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [v3 2/5] drm/bridge: use atomic enable/disable callbacks for
 panel bridge functions
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com
References: <y> <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
 <1655808800-3996-3-git-send-email-quic_vpolimer@quicinc.com>
 <ec989295-faf6-0288-cc5f-54821c654845@linaro.org>
In-Reply-To: <ec989295-faf6-0288-cc5f-54821c654845@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2022 21:54, Dmitry Baryshkov wrote:
> On 21/06/2022 13:53, Vinod Polimera wrote:
>> Use atomic variants for panel bridge callback functions such that
>> certain states like self-refresh can be accessed as part of
>> enable/disable sequence.
>>
>> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Oh, wait. NACK. This will not compile. Please fix compilation with this 
patch.

> 
>> ---
>>   drivers/gpu/drm/bridge/panel.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/panel.c 
>> b/drivers/gpu/drm/bridge/panel.c
>> index 0ee563e..59a3496 100644
>> --- a/drivers/gpu/drm/bridge/panel.c
>> +++ b/drivers/gpu/drm/bridge/panel.c
>> @@ -108,28 +108,28 @@ static void panel_bridge_detach(struct 
>> drm_bridge *bridge)
>>           drm_connector_cleanup(connector);
>>   }
>> -static void panel_bridge_pre_enable(struct drm_bridge *bridge)
>> +static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge)
>>   {
>>       struct panel_bridge *panel_bridge = 
>> drm_bridge_to_panel_bridge(bridge);
>>       drm_panel_prepare(panel_bridge->panel);
>>   }
>> -static void panel_bridge_enable(struct drm_bridge *bridge)
>> +static void panel_bridge_atomic_enable(struct drm_bridge *bridge)
>>   {
>>       struct panel_bridge *panel_bridge = 
>> drm_bridge_to_panel_bridge(bridge);
>>       drm_panel_enable(panel_bridge->panel);
>>   }
>> -static void panel_bridge_disable(struct drm_bridge *bridge)
>> +static void panel_bridge_atomic_disable(struct drm_bridge *bridge)
>>   {
>>       struct panel_bridge *panel_bridge = 
>> drm_bridge_to_panel_bridge(bridge);
>>       drm_panel_disable(panel_bridge->panel);
>>   }
>> -static void panel_bridge_post_disable(struct drm_bridge *bridge)
>> +static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge)
>>   {
>>       struct panel_bridge *panel_bridge = 
>> drm_bridge_to_panel_bridge(bridge);
>> @@ -158,10 +158,10 @@ static void panel_bridge_debugfs_init(struct 
>> drm_bridge *bridge,
>>   static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>>       .attach = panel_bridge_attach,
>>       .detach = panel_bridge_detach,
>> -    .pre_enable = panel_bridge_pre_enable,
>> -    .enable = panel_bridge_enable,
>> -    .disable = panel_bridge_disable,
>> -    .post_disable = panel_bridge_post_disable,
>> +    .atomic_pre_enable = panel_bridge_atomic_pre_enable,
>> +    .atomic_enable = panel_bridge_atomic_enable,
>> +    .atomic_disable = panel_bridge_atomic_disable,
>> +    .atomic_post_disable = panel_bridge_atomic_post_disable,
>>       .get_modes = panel_bridge_get_modes,
>>       .atomic_reset = drm_atomic_helper_bridge_reset,
>>       .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> 
> 


-- 
With best wishes
Dmitry
