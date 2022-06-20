Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393F5525DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344045AbiFTUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiFTUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:37:48 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D7192B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:37:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a11so4389760ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4AgI1OeqvKa54AE3ibmZQ72eMIxlgyZDqRzxMCeBNr8=;
        b=QBtuY4wXg/c+FMySfQQzgbU6tlAeaQ8DmAALE6apPfUuxC9bf3/d5ySZUDSgao1o6b
         KjZhA6Qq37l3Sk6af89F26XLK2Bmx7+sKuhgZt2jtqxjfS8vKf7ZqXX9A86jUY5J5oGV
         byPli33F5D1I3Rg8tYNfuH9Rfq/gGK1TIKMxduF1yAKIKrBQxN6w1TsIL1oZ/q+IifoM
         IKXHeZ1xNOLP56e8C6BdcRr2NV/fgfKj97ccQAVUcAcrm/wKi/8xsz1IVmCJo4pt80ny
         DzGNPMrSlGvseJtj5Gvg7taOGess691R4KpLV72rH8SKl4HFq45euJsXXrQdAnT9asfa
         EoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4AgI1OeqvKa54AE3ibmZQ72eMIxlgyZDqRzxMCeBNr8=;
        b=bCEu/HhxQQjklcoKJm9PpfDVCMt4KRpHv+tDf8kw5gS1Q8uB1KiXvCHsRBw2VFDkw5
         Uw8Smnjd9I3u/+pphS1AEKeYH8Dhg3+octYXDhyvQzDAZRQWhg9XPFP8JQxuXhaU81WR
         s7oOW99kfyWwePh7uOOhzHrdmzUi+05kL9/Fczbe5Xu5YIf32dIm4gG/QFjOdAgsYHc8
         gVJEeTrji6z39DCWUsX3CU8X0tpq/U0Vd13+c+BdFqMgFtja9yUiUVT9hBrm/ei4o0+5
         Zjb9JDaZxFiWKWCVwX7lnmaNOoKky0wusTSf6hUg+flrpp5AzzQhXo6HTqcs7qGirIrX
         KcXA==
X-Gm-Message-State: AJIora9PFHElG/ZnBcjeC+9D3tEh0TFz5Mfe8KaCyBzi9u/JFxQRTg1i
        fPdNtE2M+DI66XisxhjXXJKPZg==
X-Google-Smtp-Source: AGRyM1v1weyBbsnBoedcMba+ZaM6RXMXAZYUhNBE+zvVspODn28UBal0BFmiHO4VWi+4KkT7KnZJ6w==
X-Received: by 2002:a05:651c:23b:b0:259:fee:cc2a with SMTP id z27-20020a05651c023b00b002590feecc2amr12503239ljn.400.1655757465110;
        Mon, 20 Jun 2022 13:37:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b30-20020a19671e000000b0047f71cca2d5sm458137lfc.100.2022.06.20.13.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 13:37:44 -0700 (PDT)
Message-ID: <d7563107-ecd3-1ec7-c654-db493216636b@linaro.org>
Date:   Mon, 20 Jun 2022 23:37:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v14 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1655755943-28594-1-git-send-email-quic_khsieh@quicinc.com>
 <1655755943-28594-3-git-send-email-quic_khsieh@quicinc.com>
 <3d8f5a58-0efb-af27-eb19-ee2236a942ea@linaro.org>
 <3af48ac4-c9c2-5636-c18e-6e8c2ec2472d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3af48ac4-c9c2-5636-c18e-6e8c2ec2472d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 23:22, Kuogee Hsieh wrote:
> 
> On 6/20/2022 1:15 PM, Dmitry Baryshkov wrote:
>> On 20/06/2022 23:12, Kuogee Hsieh wrote:
>>> This patch add regulator_set_load() before enable regulator at
>>> DP phy driver.
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>   drivers/phy/qualcomm/phy-qcom-qmp.c | 40 
>>> ++++++++++++++++++++++++++++---------
>>
>> This was not rebased. There is no phy-qcom-qmp.c in phy-next.
> 
> is https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git 
> phy-next tree?

Yes. The 'next' branch. The file in question was removed in the commit 
a50280ead1b6a56f3b4738808a8c2be7c2c63666


-- 
With best wishes
Dmitry
