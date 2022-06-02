Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5341453B7DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiFBL3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiFBL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:29:34 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAC2A90C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:29:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id f21so9336008ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4UAbEa9va3g/aB6L4sYjHuVME065z0rZ9NEcVci82/g=;
        b=boYJcjxxR1VP9Gm1ei8b9ieE9mbCP5fz5ABFoJm749/FSTtO/BvE8KyNvcH3fFXtgm
         6zUlfT5O5ONjFNwSfHsuajKswREs9qdNpJo1kukIPK4cu5/5WQBMfnYrIxEeP6uCG7VB
         HOf6opFr2/DcwaYoMLDUJ6WXLkGXrxL+WgFm+FBvShG3hW3QXTVj2kVXxhnlA5oNz7MS
         a83DmB3+XQwKuOs1EfUCa1puTAXxTrGbi7pKsxxW5hx+S0sPfgI0z/Qgg7kWwmte7FYO
         5mvah4qGZPHm0xlzFb9DrNM2WdixjkA+vW8D/DsFhfPiAshfBdvHhxdz+hLExhIRNlhp
         9CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4UAbEa9va3g/aB6L4sYjHuVME065z0rZ9NEcVci82/g=;
        b=DBMKNfC1+LHWn4+rmoAtOLll/Bn5L9TVr3cuEDOF4XbNDnaosnyXr1tqNsSEcjPLSr
         UBr9sNFmbt2QW+L8TdRC1KSnGKfl5eHeSCUAhjH2cMKcbnMfZDvEtrTl9QXRcikEY62S
         8/Xy/8aBo3UJ1cmnKVTRvGIGsVfwDC7g7uy1MNYVwRQGBA2y9tKda0rNAUCjXF58ca+x
         x2FewbDzazH9D0t6C2lEWtaut2rmfaF31OXwzt6Pp4p2YS2s0I5vnECKsMroYyX04oPs
         InnQUVKH1uX2a/C/vo5Ew12QiVn4ieDHClv0v8DwZ9mW8YkU+hNpngZQXNX6UUm3tuAk
         cHRQ==
X-Gm-Message-State: AOAM532otK1M1Z6Q6FQtf0nx37sUge6poHXEUe0PJRCafm72H3zT7RO2
        JUxqn7gft7R+P1tF9f005VWobA==
X-Google-Smtp-Source: ABdhPJyFk5q64JEFBXNWdBpIbmC60t4bU1CUxNnolUYuhLdYQyHqyRSrf6dYdOsOKhwWHjek2pBvaw==
X-Received: by 2002:a17:907:3c09:b0:70b:442e:7e80 with SMTP id gh9-20020a1709073c0900b0070b442e7e80mr1912653ejc.593.1654169371467;
        Thu, 02 Jun 2022 04:29:31 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id yz17-20020a170906dc5100b0070b1ecdc12bsm465137ejb.112.2022.06.02.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:29:30 -0700 (PDT)
Message-ID: <8e0ac315-453a-5bba-9c68-cf69dd88c3ce@linaro.org>
Date:   Thu, 2 Jun 2022 13:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] dt-bindings: remoteproc: pru: Update bindings for
 K3 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220602101920.12504-1-kishon@ti.com>
 <20220602101920.12504-3-kishon@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220602101920.12504-3-kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 12:19, Kishon Vijay Abraham I wrote:
> Update the PRU remoteproc bindings for the PRU cores on AM62x SoCs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
