Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9F3542C64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiFHKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiFHKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:00:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81C4B1CB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:36:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o7so6994027eja.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kpmo7UeS2XJUltFXsYvK1cKEeY9o0dVRqp/sC/YL3Dk=;
        b=uKCZkhB1+8jxuH6AiQ4zRdCOXEvKaBt/5+UnRk6DkVIcXew4DnwU58d/d0dXot9Mam
         HkT1/ElgHOLf7a9J7rMz76/rtFSO5lHeq6jWMqeHkw4Q+lEm/2R9fAHE55x6UStDLGL9
         jGZ8tHlPhaQLe/A9KnCyVFhOlUDAfrUI4dBop2mfW9rrEFwORGGo1Om0RMA2QmGvA/ZA
         j2BsrALYRqbdlQBAIDMdGiOB/Qc84Np6DA1C7yTbAYdpj8pVHLEhUfSI8Jd1LrTWJfbk
         5k/8bLKvdaN+zEgK+i4ESUJ5QDLAUCH3Ad1zyWjB6CbEj1yjbTHaVQ4cXtyC9kLP5PJ/
         7t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kpmo7UeS2XJUltFXsYvK1cKEeY9o0dVRqp/sC/YL3Dk=;
        b=3u5uxTPk42OurDusAuJ46hLtoYn4qsf0c4nI050yyVzGoyhAT2OF3t4AFuYg2MyF+i
         U4nJpLqUw4b4uHOrGfLHDLqVnDnLEa6nIq6QMQBT5rbeCJWmcubE8wHLV+MS/SaRQ4IW
         5zjlVjgFzTDapkuGZylsKYmXZDvBsnui1wNGy5Dor0Z3u3PKjyJanlg2UOSjTTmGcUq/
         YiOMx4L+ct93xsrUtM8iHsbCDRt5cQlNeBizqAp4wZ23WcjzkzHHFiS7gtE+oIelshwn
         5tzHXCYuI+f6e8M8k/Om7/YD0zdRVlYaSxGkwz24FngKCAq6gOgaba1EJmwebtvpXabI
         Y71w==
X-Gm-Message-State: AOAM532N3SgEDH2Zm/qklNDYV0aEIfJG3P4p7yIAv3z+hdf8DBXfjEWu
        b7tLZNHet0PHu9lOJxzgaf7oQw==
X-Google-Smtp-Source: ABdhPJw8iZ4CGSvQ5CosOn5nP4C7ONH+zhaseW/eid1dlnzNMHrirG75Ha4zhHbFqrG/GvG9OMg60Q==
X-Received: by 2002:a17:906:7b82:b0:6f3:ee8d:b959 with SMTP id s2-20020a1709067b8200b006f3ee8db959mr31198083ejo.458.1654680996179;
        Wed, 08 Jun 2022 02:36:36 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ck11-20020a0564021c0b00b0042de3d661d2sm11974599edb.1.2022.06.08.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:36:35 -0700 (PDT)
Message-ID: <0de4b78f-5ed1-efea-4b53-fe16ed9c7e42@linaro.org>
Date:   Wed, 8 Jun 2022 11:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 3/3] arm64: dts: qcom: sc7280: Update SNPS Phy params
 for SC7280 IDP device
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
References: <1654066564-20518-1-git-send-email-quic_kriskura@quicinc.com>
 <1654066564-20518-4-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1654066564-20518-4-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 08:56, Krishna Kurapati wrote:
> Overriding the SNPS Phy tuning parameters for SC7280 IDP device.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
