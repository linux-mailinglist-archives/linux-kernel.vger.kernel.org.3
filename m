Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA353B81C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiFBLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiFBLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:50:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018CA2B194D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:50:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fu3so7983651ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gCvBltJfXbRRVoy51T4SCE98uCf7r0noGcg5kkBqPqI=;
        b=uerIyCIuu1S/pbzidh/Xpx3iyz5o5f5ZQqCth4Fq6RhpIDm1SzbJqFtWwHqnvPHpBu
         hE/XRMgXWJsst9z5LM216UCBIPW0rKjXrnurbnJZqhh1CSoqp4xIxCX/hVnfzj2exztX
         G47tJe9xuCOROeU03RB8IPODU9jziY6yrJDB2ti7d9KCFRrk2CBLjnzqH8T2ubqv9qKD
         GPoQRtFXEvKPYBB+g19Y8jv62xBRFTDJbn4wpCWLBzAXOgHNmQ9X4j9ijv0Ng+egIJjr
         C7VbKZ+UpO+86kNg3cm8ehtM2lKW7K3+/8k60BWtoodoG1KOJpl9sBvkcWnDDGfj0+co
         IItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gCvBltJfXbRRVoy51T4SCE98uCf7r0noGcg5kkBqPqI=;
        b=ZdLDCSwneVAVlxC4Rp5qIqLwEccgBWfj7xyEWoRCzPUPnYGw02ABuBbdvfiH5Rw/jb
         MpthRFlzoArz+e84WtOSAEeFfy4YArB88spZIAwEB4xkDBQFbw08PevVfXpDi41lmWIp
         3/VTljlvKIL/h34IO8ujKF6lmMesl3G4QT/TPt7CmEo8t+TwS0l8raZWIEv7PYQYd4QX
         rhxnJsmwnB/Hfka2cTNEEDmrxhhVafxK2N0TsPRYmOc3ulsYyFiem3mHnfAx6+GNufMd
         UQJCduSb+BYfhfnpE8s5pkogWnUsKKJ0puvW8NbWu9INtnaZn2Lnu7MwU4e7JCoAMtK4
         MPxg==
X-Gm-Message-State: AOAM5336HRnnpxdu1J0AFIk2jDYmP3kxazEUMp6MU6QlQf938grwe9Ur
        kNRapHNmf9wTtad8yYL9utarcQ==
X-Google-Smtp-Source: ABdhPJzAoeIBFOdaKcZDbDTXfrUs0HOvrIkxezbud3v2G3E8egD2aFaD1KnllZrPayWGmKwqATuL2w==
X-Received: by 2002:a17:906:478c:b0:6f4:e6c6:526f with SMTP id cw12-20020a170906478c00b006f4e6c6526fmr3875045ejc.41.1654170638556;
        Thu, 02 Jun 2022 04:50:38 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906601600b006fe8b456672sm1707918ejj.3.2022.06.02.04.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:50:38 -0700 (PDT)
Message-ID: <d7af6420-212d-ae33-ded3-4498e7f32a03@linaro.org>
Date:   Thu, 2 Jun 2022 13:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: clock: Update my email address
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1654118992-4026-1-git-send-email-quic_jhugo@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654118992-4026-1-git-send-email-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 23:29, Jeffrey Hugo wrote:
> Update my email address from the defunct codeaurora.org domain to the
> current quicinc.com domain.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
