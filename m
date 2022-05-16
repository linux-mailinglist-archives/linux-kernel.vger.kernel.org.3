Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D713528801
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiEPPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiEPPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:06:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EB3B577
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p26so2527421eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5t+Cs8HDnvWj16xGCIF+mikJ115zNj7hKt8zOUcIyb8=;
        b=Ia7MeHbT6Cl9ycW08HrSddHkar2N5jifNPJOghuyto8SjAe9dMpb41yfEBLr8HxUsE
         ZCw9vE6Cs34OxAjjE9d321oVSoYzny4BIbOMXorsuNtxFnSj/ASZrloNo/e4+OhQLs5n
         Yq+1a4x5pFq4zJyNT49fBnO4VaGRJHHECaGZs7gizor1iLUmvjxXy7EDGqoZjRuu7Iuo
         iM8tWP0ekcEjRzq19qY4wzWob32Gdrz5w9jDpabhpWcDdWjHAfeMR6PYjbd5oHNaONOK
         QbdaX50xzlMQpb3q2S6uN8K2czHC7S6lLppkBQ7/yNY9U3V63mNhGbNN9bYOq0+QF0CB
         10Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5t+Cs8HDnvWj16xGCIF+mikJ115zNj7hKt8zOUcIyb8=;
        b=SbxLGn3UntEJvb/00khoIrGi6UhiK1BuzVXeZTA6LkyZpavCLD2ZMuAUrW5iAe05fJ
         028i7P5hmRY05BIW0jnzon3YWdJ997pRcaMXbJC9YsMIxW+m85e8SthYjoHDaYuoCny4
         2UlFqn6ucbFA4nWPDxsPG+PDrc//ecu1C/lVJkMjzToHWmxl5T+/pXnTTcSXIvyJ9ubs
         WA2Tjrk7RPnD3ptDQ9K+8gM+4Msq19u6oD+szg0ZyjUo5RrEzZ0gcOrnTyNNfBXx12WF
         6ZpdlQ/ofJrwUEC4Zb1h2CC2m7IOnD0qkGTTYI/mdQjQzucvpocVcBMvmR9ETHdqv2dp
         KBUA==
X-Gm-Message-State: AOAM530Nd6zG8Mwicq4kon2NY4oGiqlrP8gazOvsx6wPQqGojpNdq9Yb
        McE4e9+QHCslGL7s137OoU8FNw==
X-Google-Smtp-Source: ABdhPJzeCPsTLFSMafvtYEP2F1yq4Y7s3vBkx7ePuRLbETQKthyM7TyPkmutQIxLHaU7ngGhBL4V8g==
X-Received: by 2002:a05:6402:3590:b0:427:ba05:6f19 with SMTP id y16-20020a056402359000b00427ba056f19mr13653559edc.334.1652713591923;
        Mon, 16 May 2022 08:06:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006fe32c5636asm1509512ejc.184.2022.05.16.08.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:06:31 -0700 (PDT)
Message-ID: <3dc0651a-fc12-ba2c-b178-841529a90310@linaro.org>
Date:   Mon, 16 May 2022 17:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: qcom: Add sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.2.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <d4e031d0-8a43-e458-6535-1044d43a2b63@linaro.org>
 <CAD=FV=UfNKqca5XHX7aWZmxvPmKNikA-=X0Hv5v0MbumnB-W8Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UfNKqca5XHX7aWZmxvPmKNikA-=X0Hv5v0MbumnB-W8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 17:01, Doug Anderson wrote:
> 
> 
>> Actually this change should be rather part of that other commit...
> 
> I'm not sure I understand. Which of these are you suggesting?
> 
> 1. You want me to squash the two commits into one, so we add the
> generic doc in the same patch as the one adding sc7180 Chromebooks.
> 
> 2. You want the generic doc to come first in the series and it just
> adds the little blurb into
> "Documentation/devicetree/bindings/arm/qcom.yaml" even though
> Chromebooks aren't actually added until a later commit in the series.
> 
> 3. You want to add the sc7180 Chromebooks first in the series with no
> documentation and then later add in the generic documentation and the
> blurb into "Documentation/devicetree/bindings/arm/qcom.yaml".

Sorry for being unclear, I propose the third option. I mean, the hunk
referencing "chromebook-boot-flow.rst" should be rather added by the
patch adding that document.

> I'm also interested to know if you think the generic documentation
> patch should land through the Qualcomm tree. I think it would
> absolutely have to if I take your suggestion, right?

Yes, in that case would be a 5th patch in the set here, so I think
everything would go via Qcom SoC.


Best regards,
Krzysztof
