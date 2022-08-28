Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460955A3E41
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH1PNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiH1PNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:13:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188A32BB4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:12:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id l8so8053483lfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OtM7iPNjdY/5wZ1fS/xdrs+Yl/HaQkufjAk9Dk8g/F4=;
        b=ZM9+t75/Iyhz/lVJ4dOs+/qO7x3tO4hFdfVYKfJAKuZtKyO0dYezs2g8vYXYLIPrgv
         0THHHcwNDPJR/dGl7hpzW5jhbj7wa7lJHZvMgEFaHe1pqdTYPUEttNy2XsAXrIJL3B6s
         OfljqMOZhjzRj2nRTGyB2cE/4MPxAesLsxCsMU8my4rlUdYwfsgzSeWjKyHHIncaTeTK
         36DijBVMrf13XmSw/tz6YXINirzTxABTTunVY1jBpbTFOF5uTeJRmL3HZUnnhcL7wMD7
         qetrttlyczmEIVMiPk229AcL65+w8/VHzxIUhMskDFqjvUHT7VOY9HsIrPNcK3utCzYQ
         xe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OtM7iPNjdY/5wZ1fS/xdrs+Yl/HaQkufjAk9Dk8g/F4=;
        b=2T0wYnFlsd5XpMcenhMb8FntGkGpb94T5ut+YwJjj6LxXouFxmuORdT5EqDezhiohD
         KdihvCU5j5b83cdEhDiEba1pYcWHdmBxEnv3gplXSwI5d5r7m+xGU98/khwuYs+vS+zC
         Uxt2nVhkfvb96f6Z+9qK1z1zcYNVwm8hgxb4cfNz04okVnTCx+nUNdO1bx16TdfGohZ+
         ThBUY2EibtpOqjkWLMEeSyJRRbOamfzNhIgu3tHDOnAnxKX4kqkAiYRSCmZXtRmxiy/I
         ztyytK1LeT+h/QPXQxdFsV0C056lvOrB1rzJ+NaEtSY3wBXb1tbQy1axFlIlbfS6i6g9
         ZCdQ==
X-Gm-Message-State: ACgBeo2r+6bt5neCQsUlFGuSuyo+7SMm+TBIHJmYZuzBJ/zQRzvOFhtM
        HRpfXhiG79Vb9ISdWRlpm5dIbQ==
X-Google-Smtp-Source: AA6agR5BQ9SYbGpzS3uLENZcMMQo2IUbuXQi9Ks69vuUcUBcnzw3LTesdRgczeXwLvS6raLMb76axw==
X-Received: by 2002:a05:6512:1583:b0:492:c028:d2f3 with SMTP id bp3-20020a056512158300b00492c028d2f3mr5750535lfb.216.1661699575603;
        Sun, 28 Aug 2022 08:12:55 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id c9-20020a2e9d89000000b002655fb689a6sm78562ljj.139.2022.08.28.08.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 08:12:55 -0700 (PDT)
Message-ID: <cf49e23e-69f8-e8e7-056a-2b3c281ff214@linaro.org>
Date:   Sun, 28 Aug 2022 18:12:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 07/11] dt-bindings: PCI: qcom-ep: Make PERST separation
 optional
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
 <20220826181923.251564-8-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826181923.251564-8-manivannan.sadhasivam@linaro.org>
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

On 26/08/2022 21:19, Manivannan Sadhasivam wrote:
> PERST separation is an optional debug feature used to collect the crash
> dump from the PCIe endpoint devices by the PCIe host when the endpoint
> crashes. This feature keeps the PCIe link up by separating the PCIe IP
> block from the SoC reset logic.
> 
> So remove the corresponding property "qcom,perst-regs" from the required
> properties list.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
