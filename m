Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD3A536407
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353118AbiE0OXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiE0OXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:23:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF21207E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:23:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y8so4757312iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Dl3neGbWJuUPrZD+P8vdryuz/5nRnjOm3eWjq/e3Vh0=;
        b=QuTQClfDaEKtCFxDZXxpBx113hn5JCwCa5KmeRzf9H2LW2g5b55dqf0JqQSQOAUdRA
         K1SzvBsYWjiyXF1Pt7RU7D23D1b95EWbOYk4yZK/yyye6WlgOUEgbEVk6g8z7uU7x+E5
         tb6lzYUMH3mrDhuNykUMDq2L5dbQECyvaqoD0nFW3zGzpGlivGJzl6o2MXhtitZo9MNm
         olGL6qMxKPApuN5SzBidAvn0HYmuOvFLaCmoiHtUp+5QpUsW+bsYwJqTA/SlIvMYCTOx
         HFDr/XxJBKLBit1JLlIS9M1OmtqOGJI8K/a6/oV2ddrQE0CeTU9jQPjW/+CGvN6u3W1Q
         ziMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Dl3neGbWJuUPrZD+P8vdryuz/5nRnjOm3eWjq/e3Vh0=;
        b=LkNIEWnNGRslibpq4nUKLItf7hOeCqDiJqNNIIJ3FU0LSGIXbwwxgPVjd/wOgumZnm
         8sNhLHvXliYurz/k65pZ06cHQnLDe8ZoFWBR5TLxO20r2tilbcm/ml9zhaPm0EWx0car
         ynGuExypQ9YIYQ6uDJQxJbm5xuFpmTqICYOzk2xdaPbyG6vhHWmRxmZqaV6sMwO+e5nM
         5Bi89ezM+6uuOt1B+hmm6WnLbym2NBRPgKIs3nuonsX+5Jm/mwMyupzjh3cAXs4Z1Jz8
         KVx/oSI28jM4IhEo7FusVyxVEWQ5gXFp/WsHEed0ZU8q9oVHAFzWuVJ6X4r6jQF8voYQ
         lTIQ==
X-Gm-Message-State: AOAM530wGRUuBtbSpK4foUfCalcY8Ligg1vfMQ939TkatzsCkUa1v4b4
        s/6BVHCN7t0Pl6/DkxAZHmZAZA==
X-Google-Smtp-Source: ABdhPJwGWdrEGfIXWmlj206LeA00IrZgWciBCp2zZTxFCqvThu44vgP0eYq8ge4I4+TmZf/KvykkiA==
X-Received: by 2002:a5d:8619:0:b0:668:4b3d:baf0 with SMTP id f25-20020a5d8619000000b006684b3dbaf0mr1883558iol.185.1653661413138;
        Fri, 27 May 2022 07:23:33 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d17-20020a0566022bf100b00657b5623333sm1248877ioy.3.2022.05.27.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:23:32 -0700 (PDT)
Message-ID: <d9e3bb1d-b9e6-5047-04be-01e69394d9cf@linaro.org>
Date:   Fri, 27 May 2022 09:23:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] clk: qcom: rpmh: Add note about sleep/wake state for BCMs
Content-Language: en-US
From:   Alex Elder <elder@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, linux-arm-msm@vger.kernel.org
References: <20220517190949.2922197-1-swboyd@chromium.org>
 <cb32f8c6-8a4a-cc3d-4154-a4377a238628@linaro.org>
In-Reply-To: <cb32f8c6-8a4a-cc3d-4154-a4377a238628@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 2:16 PM, Alex Elder wrote:
> On 5/17/22 2:09 PM, Stephen Boyd wrote:
>> The sleep/wake state doesn't need to be set here because of specific
>> RPMh behavior that carries over the active state when sleep/wake state
>> hasn't been modified. Add a note to the code so we aren't tempted to set
>> the sleep/wake states.
>>
>> Cc: Alex Elder <elder@linaro.org>
>> Cc: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> Looks good to me.  Thanks Stephen.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Taniya, do you have anything to say about this patch?  -Alex

> 
>> ---
>>
>> This superseedes a previous patch[1] I sent that tried to fix this.
>>
>>   drivers/clk/qcom/clk-rpmh.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>> index aed907982344..c07cab6905cb 100644
>> --- a/drivers/clk/qcom/clk-rpmh.c
>> +++ b/drivers/clk/qcom/clk-rpmh.c
>> @@ -274,6 +274,11 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh 
>> *c, bool enable)
>>           cmd.addr = c->res_addr;
>>           cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
>> +        /*
>> +         * Send only an active only state request. RPMh continues to
>> +         * use the active state when we're in sleep/wake state as long
>> +         * as the sleep/wake state has never been set.
>> +         */
>>           ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
>>           if (ret) {
>>               dev_err(c->dev, "set active state of %s failed: (%d)\n",
>>
>> base-commit: 42226c989789d8da4af1de0c31070c96726d990c
> 

