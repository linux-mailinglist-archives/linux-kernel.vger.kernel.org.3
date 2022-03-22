Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13C4E4584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbiCVRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbiCVRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:53:04 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D138CD89;
        Tue, 22 Mar 2022 10:51:35 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id z92so21693012ede.13;
        Tue, 22 Mar 2022 10:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vZ/ZwDND2DM7W3zO7/91P5DQk072Qyyap8DYUvTWLHg=;
        b=FjLnjC2emab4rOZhrdPuYjxr5zNtB620yJSQAsRtKiofHJ62zFE0Q+DOZbn4Hp4xof
         KDR2UDd+LI2lzOgUlCDYBsAkqP801vSUKQ70Hkrb3nr8T6Ga0LlFL/kHFx/7WXon5yy8
         IkBjiOSzf1TMGYJkRMAxHGN4VTdTUuuDqsc90h6utIOhdXa54npgYb0DTjwjKlsIIHp6
         U7TV7YCwp8fdLK4R1P+3E8fz5KFdOU7EPj9u+wdIQV15Ey0FTr1cXa5TP8Z2pgEM1tj/
         /UOtLi/Yd/mX+grU0PZiRAgcsUDjJUWxIIzKpcD5s4WqBDIIeMC2U54Kxhi7yLuQyiMG
         +sEA==
X-Gm-Message-State: AOAM532C2EgCYJrxxcqZ/YEFKL4wEDnr45t8HQpEtmnQh18WPnQBEB2G
        0OA3mtfM/E5B9vc8yRkL/z6XDT0LXGY=
X-Google-Smtp-Source: ABdhPJzA/0REXywCUbR+lRzR+Yv1EhYQ71lr10sQZ9QR9zkrdf6Gy0wWv0YrWg4hPXs7CE+OgS4pjQ==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr29953899eda.203.1647971494344;
        Tue, 22 Mar 2022 10:51:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id b11-20020a170906728b00b006df8494d384sm8419729ejl.122.2022.03.22.10.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:51:33 -0700 (PDT)
Message-ID: <7f3a0b7b-96d3-2d6b-308b-2e9cca13663b@kernel.org>
Date:   Tue, 22 Mar 2022 18:51:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Add ARTPEC-8 compatible string
 for exynos-thermal
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220322075617.109855-1-hypmean.kim@samsung.com>
 <CGME20220322075557epcas2p26c9dcb578e9c5f68a23f7fe1bdf35f65@epcms2p5>
 <20220322081928epcms2p5c426f8eebbc5251a294ab08ae869e487@epcms2p5>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220322081928epcms2p5c426f8eebbc5251a294ab08ae869e487@epcms2p5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 09:19, Sang Min Kim wrote:
> Extend the exynos-thermal dt bindings document to include compatible
> string supporting ARTPEC-8 SoC
>  
> Signed-off-by: sangmin kim <hypmean.kim@samsung.com>

This does not look complete. Your driver uses different binding...

Best regards,
Krzysztof
