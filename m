Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CC574875
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiGNJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiGNJSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:18:00 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F64A82B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:15:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r9so1762279lfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R+KzWMV4PGws7LHrrh61+iUc6s0/upYI0aondL2dwwY=;
        b=qxclZdaOL0Z2pWNQkJeemWXR7/uucodFnIH6t05D3hME0vYV542h+0TcKto/g/+L9L
         kCrfljDmp7NmiDi+iAjXKqBlAnJJRId8hBZ3vYZlGwgmNHkQZSuPVpOuLNYwfLG0tY9N
         9ZNnJyL1PzpjcMNwr3O37tsrUNGox5N5VPiJYYKCabDQN7z0h4rRRWhht0Fr+QRmv+0k
         MdOLRruTS1V6lTAA5M+xV/wghi7koOOCiDQuMyIdztrwRrGONdDnd1MsAx56UPRFZTX8
         ILOwDQO6BGDQ5c3nwlK9G7/uq1S9rjS4+z+RwJrgF77dwzbubFlDmQ+mnxUBvEzdDCdh
         cdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R+KzWMV4PGws7LHrrh61+iUc6s0/upYI0aondL2dwwY=;
        b=ZgXpAwz1A9oCgSS9aLNLQ001Mb5n3+cS98z/eHYDA57GQ6FLfWo6GGvhJrgFi2pleP
         w0dnknIFLPfd0q9URVKEV+8S5GcG7L7Ma290Fo0G3CPGc7fz25HY9Y061Xvq2GEAfPhJ
         jebPi2Y/6/ac3WftHMyNbLNHbq9c/90FW//ccNp2uWRUWOq22eaTDnxVNSyqpXHLdBb3
         XwL3qAHbICyQfgcmtLo89syK4T3wmdWCSUCoeyLkfmky0HEIlWVBLg0a+V3PstOZZ7H4
         uxVeXXmzw3O3pFVTYaMDPWghL7cmyJFsMjeNYU07gFT0TZqeY0MgtpR7i5WWLBp/0wlz
         A67g==
X-Gm-Message-State: AJIora/QX2+uyRSZLDrKzS8PeaQEjHqzulpQB/XI4HnStGFgMWNGNNB/
        s7QrNfo3ph3rh2RTwUzcyyf3Vg==
X-Google-Smtp-Source: AGRyM1sQWC4ogVdKX+fBAK6mPRvhxHD8r32F51/7jDL1xoqZXPehDsD9tbjLIkKwEPqmVgm7V44uBA==
X-Received: by 2002:a05:6512:16a2:b0:489:cbc9:a4ec with SMTP id bu34-20020a05651216a200b00489cbc9a4ecmr4630321lfb.173.1657790143160;
        Thu, 14 Jul 2022 02:15:43 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id h25-20020a056512055900b0047f79c636f7sm253111lfl.167.2022.07.14.02.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:15:42 -0700 (PDT)
Message-ID: <0e698eed-e6ff-9c37-1de9-f1f224531c8c@linaro.org>
Date:   Thu, 14 Jul 2022 11:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 13/30] dt-bindings: phy: qcom,qmp-pcie: add missing
 child node schema
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-14-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 15:47, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 92 +++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
