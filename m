Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7C527E07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbiEPHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiEPHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:05:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9BDFC1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:05:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a23so8865408ljd.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BsXDhItNMT5Neia6iEh90m0FKxZWB0Cje5RLh5qk0FU=;
        b=zXnviqtatlH8Kv0AtsqIILhhjvTHmjQaDTZWAifNpeJlHmvVI3sxF/NjUuOW7vh8ZT
         aGcc4nnJkMAxMSh+KXt40raW27l1Eejq88a5IxlJeEny3bMIn62mq/wY3zsKI6C+NROV
         xGgVmrNQR839nenO02Bi5RCLx+qWl0P6PlEXRdGdS2qg+Jw6jpD6kJ+AjLWxQFheDEFG
         ko/RawHYAHV0RpinfnpUkOMCr1E5iPDt8llXnzN+G4AUA2sYf7qjn2ncq6PIJb/QN/4s
         A4pAsREeZ63qVl7809n8JQPE8sL/aXGyQMddTwpOK21on7DGyGEwExGUd+JAFpYptOp2
         d5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BsXDhItNMT5Neia6iEh90m0FKxZWB0Cje5RLh5qk0FU=;
        b=yzLM6Zt0nO7cJTJKwHkan+Xpoi0s+b/Kyx5GF/6FczfRl6iYQlD1D2Py4muiSlCdEL
         lFBWObeUIvqSPSB+OqPwhSb7uLjMG4ENrKy8b90Tob0X0HAe44H13sptQPoimfYtsSOz
         WbW3+ALTZIrG3LTgYE5oq/mVaAfVDRdFW9XDTS+dQSMttkwEmr/EYyqT9VMS9h0Tx97Z
         WiJD5J3qGn7vvHPHkLWoF4Z5faEdGYp5tfkVC05UTgWPi0d4RwX/zZYVmPIMzZyHyT35
         GggGFHi/Fy6O3Q0kxQnyETLBRpTQg/6D08btaKAsCES+UrAMpy71ODYS/eFf+GJITlJX
         yCag==
X-Gm-Message-State: AOAM533Iez9/wYyv/oOPzAVCaMt2yQttBTLQjSdS7b29lzRYw7in/pWm
        tpybzooEVsCFnm+rV1kj+NuJhw==
X-Google-Smtp-Source: ABdhPJxIJ8omUPJ/AvoDpAmPbW3fsJ//qRHGFd4yhL/DVWvVieKPHQeOqcBcWfhiImygaCMIEVi5Tw==
X-Received: by 2002:a05:651c:2115:b0:24f:f52e:16a0 with SMTP id a21-20020a05651c211500b0024ff52e16a0mr10724742ljq.362.1652684702183;
        Mon, 16 May 2022 00:05:02 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g1-20020a19ac01000000b0047255d210e3sm1219897lfc.18.2022.05.16.00.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:05:01 -0700 (PDT)
Message-ID: <125970b0-af71-1695-a3ab-10a159ac63a5@linaro.org>
Date:   Mon, 16 May 2022 09:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 18:59, Douglas Anderson wrote:
> This adds board bindings for boards that are downstream but not quite
> upstream yet.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2:
> - Use a "description" instead of a comment for each item.
> - Use the marketing name instead of the code name where possible.

These should be published with the patch adding their upstream DTS/DTSI.
There is no point to list all possible boards in the world from any
downstream source. For upstream there is no particular benefit for such
bindings, for downstream you also said there is no.


Best regards,
Krzysztof
