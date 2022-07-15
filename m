Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF56575E91
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiGOJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiGOJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:28:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7A7B7AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:28:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p6so5073274ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7lAKt2pLXSIw8Y78aDglwxmws3OifCrCJDIyJl/7ydQ=;
        b=oMw5CMKaEe1o0BsrWvjAIjCpfEYcs+CRCqS2mWgW9bf2tWvsMjhXHCWCF2RBm9jAXJ
         zrBwT9R0bJF6NZgKBseIPdhusgIkJGJZQMp13ZyMWDmMb/Po/VBaC+PVC/kzTvITCTh5
         byGOd0DLiNG/HsO02YzZ5kag3cvPGyEl/XNYc24huSzsA1Uiy1WYIs7cHbLw3Ork5chp
         qebxv+3HID7kY+VFDo6Ql7MAZNmZxqfcowZOtXSV2PSKAnthHnHSgXvyWDuwuKmGvxjW
         2srdah9kti2iXNqyMZ72wOxNapfd8hxwG8T/UBOaWTRTnTU4gShq5jEWxeMpZooMkvL2
         eI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7lAKt2pLXSIw8Y78aDglwxmws3OifCrCJDIyJl/7ydQ=;
        b=BoJAesoBo9QgYd4XlX/8C+knFcJdgiIGtELigju73uydk22bqLliUMCDlLNU+U7FyU
         /oDTxF7ZY1JGG9rqlfHCZvMyIkCHgwbDONKFBJuNqST1phfb8DAhP5YTYZYUGZ09lkuD
         RamqqVDB/2efdJ6YqAc4BP/qUx7QBZ+4BIpb0RaTcc0/NFNXFwGer3EQY/b88OYKBrU/
         w7xEd6Zc6mRYrZlfYGdIXAKFfNEIOfcuUHxoZtvh8RdP2AbV/SEYWWpyDu1DrHYw1AFa
         5LNbu7e1fW3Xiq5VFVrhEakzc2ilZXmRc3Oi5ZLLHIJsZLFWNPhMPulPNPpkf0++3u4P
         jB+w==
X-Gm-Message-State: AJIora8l5KET4sQBJwUluucRKkiO6cYPe+YfozQ32CXV130udRYSJGr/
        pObSYwcb2XO2udyGMXV/hyeT8w==
X-Google-Smtp-Source: AGRyM1uRqvzl9P25ieuUjyyi2ChznSaWsPC6k4S2UrcNBoBdi+ue0XgO6K1+kzq3688TpGu6J9w29Q==
X-Received: by 2002:a2e:8852:0:b0:25d:4ab5:593b with SMTP id z18-20020a2e8852000000b0025d4ab5593bmr6129325ljj.261.1657877284869;
        Fri, 15 Jul 2022 02:28:04 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id f8-20020a056512360800b004870ef4a0c7sm817849lfs.17.2022.07.15.02.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 02:28:04 -0700 (PDT)
Message-ID: <46f8d979-3d66-feac-95e9-a0fe73d32ef6@linaro.org>
Date:   Fri, 15 Jul 2022 11:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 20/30] dt-bindings: phy: qcom,qmp-usb: add missing
 child node schema
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <20220714124333.27643-21-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714124333.27643-21-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 14:43, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I think you missed my tag here.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
