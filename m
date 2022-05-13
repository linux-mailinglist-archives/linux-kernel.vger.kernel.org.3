Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67BC525E88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbiEMIqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378582AbiEMIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:46:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BD2A711
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:46:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m62so4386710wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=04w5YaMGFccJS2MvJApndeFCqSyCGIijDOoLgle64NY=;
        b=gmFrIGT+sb1PBHEhifWOMRyfx7ADWu+JiV7OQm+RKt5pUPvj/JLAQy2SYPWyR+HJST
         hoSQZEs7pAzPtCjwFwSd2se69HIX0ig2yTiFGjdW8qneY5bJeZopZ/44x4QhM/WgI+nz
         4PC/CJNUMHk+dDABivl+77UNxca3GaNFPRQDH3gFs2y8MpZus0Y+yeFQJfoNlzxR3n4g
         sSHGWyrfhPDmDavQfTPomZdXMw+A1X8g4qBfW44bH0SVTPWVu03jqVgQ5NvuGnXrelAT
         apNKjBvEvEeVaQsxlzqyPuoG+N3eP2iXaEOm+OR3rNFCaEBs2t4bPCyfFfH5wYv4OsTL
         7AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=04w5YaMGFccJS2MvJApndeFCqSyCGIijDOoLgle64NY=;
        b=X6iJSot2jsNiy47KZf0KayM28CRAIdcSk6Uz+eoDvWQTj8EwD+yu9lHfRYzCkm8aCL
         DmZLcrxnOAdLQ0MhqGACYyrIBjMS5t7CBMx3cczY7McuBwK1kLDZ1+WEpitLTSnhHkQD
         qdrDEEL0rqB2AQVkaRPxbxWmJnpIA2PYY/mkn3OB+g5t7yUKHngBfV8mx962SMMtq35/
         szPlaJBvL1jiKHSa7l7p+A3uMcco+svyjXQc0usUa3iTM/mDfcTKlHdKVRH9rmwrL9hW
         bvcg90aZLjNnQm+eLWozlqFI1svc1DGn3HtQ1UXII6TZTHnDbb714Q00oeYEGH6CZrFB
         6nBw==
X-Gm-Message-State: AOAM530IDLr1oP0JUgtnzWcmqcEnkPUNrjuui0IYVPp8hGSwne17yXCC
        sY3iDB7ed2TIsSfLsGdcsxkBcQ==
X-Google-Smtp-Source: ABdhPJweskYgglLHszs5ylTIWhkMT4egoZXQ7xUriNdpWwOvbW7HRa5jjRQvBYvsJ+qWot5FYqKimQ==
X-Received: by 2002:a7b:c088:0:b0:394:451e:34a0 with SMTP id r8-20020a7bc088000000b00394451e34a0mr3537426wmh.10.1652431592670;
        Fri, 13 May 2022 01:46:32 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k8-20020adfb348000000b0020ac8c19ecfsm1606877wrd.3.2022.05.13.01.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:46:32 -0700 (PDT)
Message-ID: <a1f9d4b4-8ac5-ee28-51d5-478372183178@linaro.org>
Date:   Fri, 13 May 2022 10:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] arm64: dts: marvell: add support for Methode
 eDPU
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-11-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-11-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:49, Robert Marko wrote:
> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
> 
> They feature the same CPU, RAM, and storage as well as the form factor.
> 
> However, eDPU only has one SFP slot plus a copper G.hn port.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Missing ---

> Changes in v2:
> * Make the DTS split a separate commit


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
