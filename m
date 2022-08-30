Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34E35A603F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiH3KGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiH3KFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:05:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DBCEEF26
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:03:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by6so10781681ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+Rmf6Ay/5f9NnZwdZRewRAWeUIFEVxm3g3aQu9VQRg4=;
        b=P0J8K0R7ZZqi6Jsr1dj02/aY0fuWShyfs2bZj+MZZ8gPn5iVvSjI/79ZsYMxzinfwz
         MNndVVaIsJPtL70GXStzlwNXHj6K0gb74SLgWUT7RRwbmIPbnxAWsQ8gHlbJQ2JB2KSL
         6BpZpoKnYD6w6pOeM2AadeKBziK+hYOF9M7aeNgKTFhLBn0CtVBwYvvSocucy81J3X5B
         CZgKUSS31ZUTr6353s+0CeKI1VoZ3OpZAhZd0f4X+vnloGG816uQ0HD+L+oD2uT28Bdn
         6L3FPQ+pDIepyo5QdJdXtYa7l6z+Ko9L3l01QBe4RxhHNNuzBdszogrMrL59ug3B+NVC
         rgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+Rmf6Ay/5f9NnZwdZRewRAWeUIFEVxm3g3aQu9VQRg4=;
        b=sUT+0g48QRqhpydzzqrm5q8A8LgfhaAWn662f2J/fWiWcAxjxPW0NpfyAGi9NS5Fv0
         wXzzoIr0krvLjH4Iv2RZA6IUiamskvI1KFz5si5xcW0rS2HMwri/zguBLqQuJVYbY4KL
         8XDS/OMQF7S37gNdgCI0qN80hiGXxiA7UWwl7xwatN8GtwFzUKgVkP5UZi1/xKr1f0Em
         G/sbZGyERDNYq+sX7Gyw5kGL08nFLJyxe9L9dkAZqIpolm8+18uS0uUFaAH9LlPXuFDq
         ton1hA0OByQA1OE7BTwk95LZiGaaSwJDnlkJ7zuvJjjUw6z66dQDXt3Wv2y/JNiJ65Yv
         Lzvw==
X-Gm-Message-State: ACgBeo342fKl+8lQChfO/4lXnbSB5/8DPEf+xpgTIbll7VQCkG0MBhLp
        Q5Z95ApbOysQrFwscAA3B1A3Pw==
X-Google-Smtp-Source: AA6agR7gmsLtXHKiV5/+nl4hdZyDBOEekrdwrl2N0/Dt19xwRjqcrEz1LF6+TNZhAHJwBOXqhHa8Hg==
X-Received: by 2002:a2e:b282:0:b0:25e:46b6:ff33 with SMTP id 2-20020a2eb282000000b0025e46b6ff33mr6645589ljx.503.1661853781591;
        Tue, 30 Aug 2022 03:03:01 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id p9-20020a2eba09000000b0025df5f38da8sm1707002lja.119.2022.08.30.03.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 03:03:01 -0700 (PDT)
Message-ID: <6f5183b9-7979-b71d-6051-23752cd9580e@linaro.org>
Date:   Tue, 30 Aug 2022 13:02:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 5/6] dt-bindings: drm/msm/gpu: Add optional resets
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <sean@poorly.run>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661714479-28981-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220829005035.v5.5.Ieffadd08a071a233213ced4406bf84bb5922ab9a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829005035.v5.5.Ieffadd08a071a233213ced4406bf84bb5922ab9a@changeid>
Content-Type: text/plain; charset=UTF-8
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

On 28/08/2022 22:21, Akhil P Oommen wrote:
> Add an optional reference to GPUCC reset which can be used to ensure cx
> gdsc collapse during gpu recovery.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v5:
> - Nit: Remove a duplicate blank line (Krzysztof)

FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
