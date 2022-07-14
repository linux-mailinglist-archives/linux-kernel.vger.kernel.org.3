Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A9574699
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiGNITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiGNITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:19:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17102C125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:19:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r9so1265773ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/bA0iCr71DROdXmtOkrhzL3xskgesKZUk47mbotuKjo=;
        b=NymNbbvJ53tf7Gf7X8RL4UaRBvNMWmi02ufYgJ2Q1AiyiIWCTEqE7TSz5QpexuJZwJ
         GsmSxGMoSDoEEoJb0oHaHT5zr9ZTM7dqNjvEBg1g2ECqZPW+LL3Xa2Gv5PIFUnRmplc+
         o1tcD7eq9sr+9NDwgoUiTG5SN+/90DF0Uj17Z6czL8VDHJosLgvEtHNPDFZ2w5w+mQUG
         LfjYQS2zHHpcZCcxEtZn7pJukOTJT+DuBKkWYemfB+360ybD3U2l3ti+CmuwPTe/7vAo
         n8JhAvoCvHnnJhcpaGbO3vzOKC8gESf1olepp5YeES0smpi0pyYMr8alyVu5VNcotq7l
         sabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/bA0iCr71DROdXmtOkrhzL3xskgesKZUk47mbotuKjo=;
        b=swhv/QMqcgF/5dvtlvlSDdfL3ili/vwc8FaSoOq1BibCLL2CYR5ra5JoKPf2+2tOOi
         0JsjvB+oOj51CgK70hAWRSgIOaTsa11tKMniy6I6p1zu2PrTJeXpF5GjF+Xt2SBrc8Dk
         /TxdxPMiykicBP+Uvyi3B5q+PiseLtAWIzKL1ZXTiQnXGbzAyCtXQhZF5Ch7v1E9GR6W
         Ty+fjDqlVvtkt38wP02W3B7k58cv6N6QjkCGzprR5IltTIncriTxuqRJMAKZmjirBrLH
         ZEiylyVnlzaiOdjQ9ZG6mZpMJadIrFkdq9bw5bi0Agh/w6euFWhLs7UWKLtviblqL9HP
         VjhA==
X-Gm-Message-State: AJIora8QbVMioDPBT5DA4okfC4KidBvjwOwOnNxEFdSSl/YEVGDpoJYN
        zN9+SCGuL4WZmDdIa8ZjPQIWsQ==
X-Google-Smtp-Source: AGRyM1vDxPLvTmBZ7zkjEEjHN4sp70D8r623sgjsy2QRpHEk5l8SQvlSrWdMlRMkhzzxhxEKDITW/Q==
X-Received: by 2002:a2e:8889:0:b0:25d:53da:7963 with SMTP id k9-20020a2e8889000000b0025d53da7963mr3870306lji.335.1657786788172;
        Thu, 14 Jul 2022 01:19:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b00489d1896c06sm233362lfq.125.2022.07.14.01.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:19:47 -0700 (PDT)
Message-ID: <45ffd95b-427e-be30-2d29-dbfcabdab96e@linaro.org>
Date:   Thu, 14 Jul 2022 10:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v19 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714081350.36447-1-xji@analogixsemi.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714081350.36447-1-xji@analogixsemi.com>
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

On 14/07/2022 10:13, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
