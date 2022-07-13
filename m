Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87460573D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiGMTmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMTms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:42:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2192DA8A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:42:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp17so12936529lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ldc6EH3f0PCrz9DFtr2JKghEU6+WJ+6Kwsia41CZb2o=;
        b=U2864nCS2RTRnOm/zhwLgraRfau1uEITErI////4/3D8VystBt4uPXZpklLUMMT2eN
         gtbC4pcNO6Ch5Jn848muxQ2OECUluQ9wDGRChRQ79CtEfmiHG4PbkaZGMg6b+yG0I9Hv
         Azx5rqGjLvLblXBDQnotHF1AbP3Oznn8m92shBFd/YRcU5/6nvoguZREMx63M2hFqL+f
         8svsAOU9M67FrU47oa/dYT08eHyEdxWTdfHWjgxtjr5ppihH64oVtT/V07QQNX/49RtN
         oHcRuYbcnxN/AM/dOGrPdfIo43rX6HvCWjtVbYTsA1jXGvLMC3HIHSwsVmSvdCgcTr3g
         hY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ldc6EH3f0PCrz9DFtr2JKghEU6+WJ+6Kwsia41CZb2o=;
        b=nyqy0/ofkRzK0TQnvdKrf+y1mSgbQ8K7DH+yY3xxo8QP+aNXaP0VdsSRQK191mMxFF
         cK+y9/zYB32t2mCYRRz+X/rjoqwrd37wtIGAODtU/89yUI/18cmnzJSFOvU3hvlQif+m
         y/EILyHllEmjNW3NeF2bEWvrs5oSyNXOSTigdOHMiOnobzjIbXEEV4qR5zdH+tX+9w7Z
         oepiv9OOvKOshbqpbw4JLaqsjhEHPiin25DncxyYezdS9W1LgQADNZFYVD7RpaV0zJdI
         jyxaivuNWd7C3XiR3ji87w5HIwmQZqXkJl62b5WIFE+0rONl83ves0XBC5dq/ZDv/ODp
         JRTw==
X-Gm-Message-State: AJIora+d0EWeRgw58RSjH4A9urwwjrKZWgkYoiaeHiqHzVv2OcllqO0i
        tu7f1jMCfQoCjeRx0/Di1/wd5w==
X-Google-Smtp-Source: AGRyM1ubh9NqE683R2zfQZ0ChzL1PyNugIevDbn1eR9hv3KkNP9YLc1dhgGADZBEmoWmCPTnZtwMpA==
X-Received: by 2002:a05:6512:3612:b0:48a:14b1:ec09 with SMTP id f18-20020a056512361200b0048a14b1ec09mr14842lfs.681.1657741366105;
        Wed, 13 Jul 2022 12:42:46 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id 6-20020a05651c00c600b0025a891f7b8dsm3309629ljr.32.2022.07.13.12.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 12:42:45 -0700 (PDT)
Message-ID: <a9e1ccb7-6caa-2f7c-b879-b3ff4945794c@linaro.org>
Date:   Wed, 13 Jul 2022 21:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713125644.3117-1-pali@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713125644.3117-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 14:56, Pali Rohár wrote:
> All Armada 3720 boards have Armada 3720 processor which is of Armada 3700
> family and do not have Armada 3710 processor. So none of them should have
> compatible string for Armada 3710 processor.
> 
> Fix compatible string for all these boards by removing wrong processor
> string "marvell,armada3710" and adding family string "marvell,armada3700"
> as the last one. (Note that this is same way how are defined Armada 3710
> DTS files).

Please do not introduce some changes just in DTS, but start from the
bindings. Someone wrote the bindings like that and expected to be that
way, so first change the bindings with proper rationale. Then change the
DTS files.


Best regards,
Krzysztof
