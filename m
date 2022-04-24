Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735A850D233
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbiDXOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiDXOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:20:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8522409B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:17:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w16so3725801ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FTcbreNzit4lFujKbZVkI50XE/fCo3nhqPPDp0S/o0I=;
        b=ALm1perdnMZ0U/5Np+noEQPEWoaxtzCMsPeAABou07ukt6smeu/ByTmIUeXAP/i0fH
         hIrqC9T/0FxsUd8au2lJLzmyCfc4cU2FXkLYuJA+FK3U1tVRP3XFS2FLe0PEkqTXls56
         PtwdSG4D701jgG2DJzL2JbLPY5Wdo4cD8T/M6jT+/n3x8dYqXc2NQ8MOYcx8O58OKLEA
         wc/eivx/N8rrECn9kJsKklHT0NtYJ7zuOAE02JiEwxkLpeIRoOUez9Ktlm85KahXr45R
         GDnH4oWDIFE02v+2lFK6Nit9pI1rexB2Nv3N3ruGtUVtgWWGsC5odbgvYqGlfeTgK7rh
         SRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FTcbreNzit4lFujKbZVkI50XE/fCo3nhqPPDp0S/o0I=;
        b=lINx2jRsXVJw9wRIvOeab17nqS3rHDHFf/L/cCWCbG3Mu/Jk87acOA6L3knDo9/RzM
         8kZ+mCQNHzI8M4zLV2dkZ6EiJ5SKthGSsLcQ85WfpQ8aKZhY7MAoHDKi23XkaCaCOuBb
         9s+EU9KZjOtEKvTxoZFsgCjby2VoKAW0pJLGs+nQnZH+RbV2lWiXxRhPANjdoGEC9D/u
         HwW2JYZ0gv6lS5kaGwnXjjKXeoKHOjWR/xEx9nCQq1aH9XJUwCsqVmSWagtqbLwdXDVj
         SVpGfBOYVII19Yo6ShnvvPCHLI3jxEWth6l3twpFDcFatrT3fPdDetPjZhnVDUwnj/lE
         UxbA==
X-Gm-Message-State: AOAM533pK/vUKksEYGn6XbsR6fGJbrhdUTXQhwJNI3S6cWKEV3/6t5FK
        Kx/1DHjYK8kVDr0eW5jbmoNCCw==
X-Google-Smtp-Source: ABdhPJxXW89xIavurkBTqOY1VrHCJ7eDRfv2ZCewJi0ZlNbYbPHMU1bGvQeeUTGJAqqRb3/PFNV3VQ==
X-Received: by 2002:a17:906:314e:b0:6f0:659:963 with SMTP id e14-20020a170906314e00b006f006590963mr12681191eje.358.1650809839506;
        Sun, 24 Apr 2022 07:17:19 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r24-20020a056402235800b00425c4dd84a2sm2595585eda.29.2022.04.24.07.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 07:17:18 -0700 (PDT)
Message-ID: <24ae656c-d898-5cf9-37f4-0c050d9145de@linaro.org>
Date:   Sun, 24 Apr 2022 16:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: soc: qcom: convert GLINK binding to yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220424101637.20721-1-david@ixit.cz>
 <184784e4-0a85-c0bb-fdda-b8c41d8abc0f@linaro.org>
 <ee77216c-c319-7a68-7f08-d5f845efa1e2@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ee77216c-c319-7a68-7f08-d5f845efa1e2@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 15:52, David Heidelberg wrote:
> Yeah, it seems there are several mistakes, I thought it was in better 
> shape (4 months passed.. :( ).
> 
> About testing, currently I have limited ability since broken libfdt, 
> which dt-schema use, doesn't work on new py3.10.
> 

One way would be to have older Python, install dtschema inside
virtualenv and remove system-wide dtschema. Or use a container.


Best regards,
Krzysztof
