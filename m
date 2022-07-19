Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E487457A8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiGSUxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiGSUw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:52:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4736113B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:52:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z22so13318158lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KhU1W70D4jonOKin9dlyG55Ut81l+FHDBHw3/l2epvI=;
        b=MHRUtnKPft/lQQvF3I8thXTohDMvi/cGK0vlVpSfkp0h7nUcnDX0gedEkzMW2XDupB
         bUSogWe5T6GsDUnVamwrVHWGHGHgUp25BVhFzEAruv+dV+MQZAFOitC+pMIMZ/rxFDqO
         0Siu5tIzWhZ8HkZdHg98Agep2wta2b4Zj9I8QUXtAmFg5vKZi/5AxoUwyGTr0JjdRHVl
         kqEnAKnukQnkj7cW6yQmSkklGGJg73z7o+6nVQom6+A64V/3ofF6co+073+8JejN3wxv
         0f76cSmSgU0KbNNeKardLrwAQ0LUa230C6XG2ul1w46aEYizWAWumI46rrgbfWKSi6dd
         OdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhU1W70D4jonOKin9dlyG55Ut81l+FHDBHw3/l2epvI=;
        b=B/o+A/QCniKw4EGeg9kId6ekPa/0DX0CT9kW2iDwKFyL73kvjsSoZCUSJ+hyDD8P/2
         hDDr4+2LMylV0QrMOGlRqOL4VcnMkD5XXglUa1ufXIINpVmgCIQXKWtCBSDEBKhSPCny
         D86Qm/Zv7oz6Iek4y2eteL/2xYdicIbD28YsGmHl6iCLVlTLpXxKfsLf9PHasm0n2J21
         9DuaFtjmQP2bdZg/xwIRzw9chG+AL343UQhcRLV+I98HF3vV1tms6cInNWmoKdEkx+1p
         0SpdKoE/qkIXFQ8KyIW2aI+hPqGZkYUtuWyfGgAIneY3PE6j19XIH+XDlFswe+TT+yZZ
         YFjQ==
X-Gm-Message-State: AJIora+cJKTCBl2/V6ZQicrbp3v4Ru9JohBD01i99yZy1HuD6wza3F+O
        uu8lokfsiHY92d0CA0tX6ll8lg==
X-Google-Smtp-Source: AGRyM1spxVtinCKzBO6icf4fP6IUBtiwtc4xbwmDvFd+uIrZtsORmgdPs2xNWNmwBojc7VfegL9r3w==
X-Received: by 2002:ac2:47f6:0:b0:488:b649:9f77 with SMTP id b22-20020ac247f6000000b00488b6499f77mr19773340lfp.559.1658263973918;
        Tue, 19 Jul 2022 13:52:53 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o20-20020a05651205d400b0048a4256c683sm1273908lfo.170.2022.07.19.13.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 13:52:53 -0700 (PDT)
Message-ID: <ac73eec1-1592-7b9b-9dc6-086653b8e917@linaro.org>
Date:   Tue, 19 Jul 2022 23:52:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qrb5165-rb5: Fix 'dtbs_check' error
 for lpg nodes
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh@kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
 <20220719205058.1004942-2-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220719205058.1004942-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 23:50, Bhupesh Sharma wrote:
> make dtbs_check currently reports the following warnings
> with qrb5165-rb5 lpg nodes:
> 
> arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:
>   Warning (reg_format): /soc@0/spmi@c440000/pmic@5/lpg/led@1:reg:
>    property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:
>   Warning (avoid_default_addr_size): /soc@0/spmi@c440000/pmic@5/lpg/led@1:
>    Relying on default #address-cells value
> 
> Fix the same.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
