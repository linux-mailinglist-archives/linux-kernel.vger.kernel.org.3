Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17955B149
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiFZKqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiFZKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:46:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563B12D02
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:46:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so9243590edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IR5ASCo6Y/Rs1/PH2JcO8TDLcE91NrIowM+FbUwhGRc=;
        b=or3a9faEfHAGd6P1JG+ETIMPC9qnTPWQ1U3JQvxvvcbaP0M4zp0oVG+fSiQQqsXq2g
         +iCKH752/3VDi2b8QYCFJdXRg9c34dOAtlmH7c58wrHVVudODXsWxLb+QOx/gHT08qD6
         msEBnvQHHd20+Yh8uUgZiBfnjp88MK+nn/6kf0MvrU41FX3tu+3TePh3bhjkYbxcZCij
         Yf1dNp63XzTly3S4JAHnNoSdUXr8/VLy1LXd0bLC/F7Tft3AMMoDUuGpmBCi4ST3itVZ
         QFCWI1XipWQhkBhhDKBVtOxMQ4acvaTQvVoAajg98C7CtvMe2OezfG/26oFvlYXzBv0B
         MidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IR5ASCo6Y/Rs1/PH2JcO8TDLcE91NrIowM+FbUwhGRc=;
        b=kmF69ZwbWbdDkWcqtblps7awuw+lcqqQijQZ8xhqrDTh/a4TvyQ5IfPOJcJKIrKHGK
         Inz7eHHUcnShw5HjdVw1EEYdnIhfKiVs87+J/7QJ6hAIgevty+lRVBYrxYPRBHE+1mAP
         sYGj4RsBiYq8U0eDjz7TqaMzaNl99eHSDzBYIrPEXWk39dVtImZwUQfXWCdYrViJvYWy
         7txG4EfrPyRFzSXWidWyKk+u0G7dEdpTFDr/rJNl7x2Qf/wDbGLCZZ8zgquqPFMVmNsy
         2IK9RNZNBcdxWpHw/Z+VttLPgJgacRvYd6nsFEmDMvdYXmahAolJAh/3j4rGfq8tcrq8
         EUZQ==
X-Gm-Message-State: AJIora86flEukLQ6n0iTmMOF0MCZU9y0hKegHcVCUGBhGq7liPdyn0oA
        myPXH420rkNOc5tde6xq0elCfA==
X-Google-Smtp-Source: AGRyM1v9t9D/Wd5uU9xYXVJRI1WbAqZUpUFiKyMzRg8VSkIRrTAJcHRXDC6RuuCxKlZQHNNFkzUySw==
X-Received: by 2002:a05:6402:4306:b0:435:a1c9:4272 with SMTP id m6-20020a056402430600b00435a1c94272mr10184877edc.205.1656240377073;
        Sun, 26 Jun 2022 03:46:17 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906595200b006f3ef214e20sm3576655ejr.134.2022.06.26.03.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 03:46:16 -0700 (PDT)
Message-ID: <ed35498e-7509-f701-84f5-3b3550021ac8@linaro.org>
Date:   Sun, 26 Jun 2022 12:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v9 4/5] arm: dts: stih407-family: Harmonize DWC
 USB3 DT nodes name
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624141622.7149-5-Sergey.Semin@baikalelectronics.ru>
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

On 24/06/2022 16:16, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>

Thanks, applied.

Best regards,
Krzysztof
