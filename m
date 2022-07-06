Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29075681D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiGFIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiGFIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:36:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AAD24949
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:36:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bu42so4825738lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P97RgFCmNV942tctqpn0OBJg9vJcOtiyZezQH2Fw3y0=;
        b=AtdGW6jfzD/zyGOlMQXFUoK+i7IgFxR9NelxXFHL7rCJMB2nAnOE6hbJWykEcnX9aa
         8pXFU2A9UbF9XCrE9Tyk3EbeE1RERHv+P5gFb0BVvLXhGAu3CzJlrWiIJB6O2eT0GLKo
         cx8OkcnsnRuOCSeMVYsrHnevbHP1nv5fcurFoEdmpesZRxA3fVRBIAnT9jlE8PTmHPen
         WjNzTYmHX1xsa1dUalkHHc2aIHrZNV9kAVsvbdMV7PxfgHrAPENzgLh/uMM/Dat5XAQC
         Z5DXu2hxL8DYvN8ZILYH90NOdJBEdrOsvdTJSeea0BqSWz09EVRhXRfMvUzesf10QS+/
         WDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P97RgFCmNV942tctqpn0OBJg9vJcOtiyZezQH2Fw3y0=;
        b=sifVM3YbUsTvga0uBbcxXiluhpjz+i2pZhWpsRPb5/H2kMn9lKN21ycOM0hjlXU2bs
         OZfSuUjMYOdm6wajOrermmJXhMxkQ3KJJddcXSE8LS6HxqMDuHv5EJG+T6Ll2ayWTZYk
         9LIvSV/QVfL9r0XxqhUrGc/vfFYQuYITMwJz76rL6WQOQh6p4v9AWjVEfMjinAyeL06j
         QmmmlVOH/uqL14Wdwo2wr23w09lGi+OL6jO4is0VOdlUOTfxGbgmIsirgi5zb9f8y3lK
         o+QnKH7a+H86AFVQQaUO1wNbor8uTCarwSSKlavAItVQLcjAD7ctHLJLC3v3wa1WzFLM
         Q6AQ==
X-Gm-Message-State: AJIora9aVW/izA4xH15FMLX2fUsxzJaXNStMz8qjPNuoAOiJcZ0hneIL
        n+bkLTrKCrCf7oI67dzu1L+uwg==
X-Google-Smtp-Source: AGRyM1vI6+gYVywu/DuF0fgyKCxnUJ512MxR6y5v2Risw6pNlpeBZRBAlmqd01KbPYPBEgr6Fdi4vQ==
X-Received: by 2002:a05:6512:360d:b0:480:d14a:20ef with SMTP id f13-20020a056512360d00b00480d14a20efmr25206205lfs.508.1657096593541;
        Wed, 06 Jul 2022 01:36:33 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id q185-20020a2e5cc2000000b0025a891f7b8dsm6029436ljb.32.2022.07.06.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:36:32 -0700 (PDT)
Message-ID: <6c67a90a-510d-a3e7-4d04-66038395379d@linaro.org>
Date:   Wed, 6 Jul 2022 10:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/13] ARM: dts: qcom: enable usb phy by default for
 ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-7-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705133917.8405-7-ansuelsmth@gmail.com>
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

On 05/07/2022 15:39, Christian Marangi wrote:
> Enable usb phy by default. When the usb phy were pushed, half of them
> were flagged as disabled by mistake. Fix this to correctly init dwc3
> node on any ipq8064 based SoC.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
