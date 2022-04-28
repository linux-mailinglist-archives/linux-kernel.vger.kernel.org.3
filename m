Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A9512BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiD1Gpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbiD1Gpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:45:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A29858A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:42:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g6so7593019ejw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MZG22l/qdJpv+4yVtt3zGuWmyDY+DVXAkSXGCXtC6sI=;
        b=BYvVyl2Gr8y1nPvegi1Ay7DRBXVbuAvq4T/gOFkNNcyvEDyr7TAS5T/AzubXgZjG+T
         QkT90r04Cr7mCzmUt8haPJX83qsIBnQn0clLkizaHn1Wlp5TFEK9QoW9FM5sVreM5tH5
         KZ/mczOmS+lOisQ32cFK4uhSYQdNp57WO0fo7hwQkmlgg6+3U4v5cj7V7j/+TL5U70UK
         tkab1KR6cNO5XNhQuEX5jG4qDe7tv9RZsL+0ZQJUby4WU6V32wQQDYZEW4O3oWz9QhBC
         zP1ufyD8840U9Ri0MwTwO9fDlpXNAUFBAXYXDpJqShYslRzT0aeSC1g35HFMq7kSGNI1
         6c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MZG22l/qdJpv+4yVtt3zGuWmyDY+DVXAkSXGCXtC6sI=;
        b=Q/G8mfLJhFDkjBp55UaNtppdjELkTcSswbGQtRGHc5+ZhsVVS9vCm83LrBLEPiAmmQ
         1zk1+WrY//TopvAU2q+e3oZKsx/7cHMVlqwo4A7XU/mSiiS/vCWBrqOXkZj1HtI/lCzT
         bvWQoqCAdYw5Zh5ehNJTB5YLRO4awPs0Kli1lN5SPpwe0C/QgIdfXlbbkiszp4+OGec6
         AnVNYvsc9NY91R5h9VU2NGiEkkzM7jL0/Icu6NRULBXcqFHQLBCq+C82yXoB6I8brWY/
         dIokgEB3tGnyCdWyXf/et181HSlmUlzfCckTubZX7cwMvlRcRsTZxlMTiGKfFGsqrJ9u
         HFAA==
X-Gm-Message-State: AOAM530/+qVH85TsFwv02JG8Kd8U5EbElYWV82r1zuwxSpWL49kc4yTp
        e1mHMQiYGT0T4AwXHK2+GnRyB+bpXnIyIA==
X-Google-Smtp-Source: ABdhPJwmWU9ucEkFeithz9ICXEUwzhJT9n8kl51GkC3DUA2UwcMPTk41Ve4wgXPk2LkxwFwS0+dElQ==
X-Received: by 2002:a17:907:8a11:b0:6df:db0a:e5ab with SMTP id sc17-20020a1709078a1100b006dfdb0ae5abmr30038285ejc.528.1651128146469;
        Wed, 27 Apr 2022 23:42:26 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cz9-20020a0564021ca900b0042617ba63b3sm968663edb.61.2022.04.27.23.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:42:26 -0700 (PDT)
Message-ID: <069fa3d6-7bc7-671c-3263-f3cddc962d00@linaro.org>
Date:   Thu, 28 Apr 2022 08:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add sc8280xp RPMh
 power-domains
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
 <20220426233508.1762345-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426233508.1762345-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 01:35, Bjorn Andersson wrote:
> The sc8280xp has 13 power-domains controlled through the RPMh, document
> the compatible and provide definitions for the power-domains - and their
> active-only variants where applicable.
> 
> The SA8540p differs slightly in the power domains exposed, so add a
> separate compatible for this, but reuse the constants to allow sharing
> the DeviceTree source.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
