Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3A55CA66
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiF0N2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiF0N2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:28:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FD83BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:28:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so13095168wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ls6yB7m2qi6FUlQi0e95Lc81JKfij9i9l6rtcmcTak8=;
        b=Jd0mnpnyP4rJZ9Y4IhxngJKeUIOf0Z/VNFHnAFqnaaAy2z7OkGrRewlJPEiUcsZD87
         PIlMG2oSpUu7u+GTFQMuajnL9dKQcpt5pyZKd1deRSVB9nOYV+B1myKwmSZAuHx6AibA
         iolrI0LSUo0gNVgzQaibDJi4t0Yo4v0AjbRpiA8hL/vk3PGO2oHFrruanBcjtZVAVDRA
         3wjH05iBG8qcXs00ugZgTErw9NBaOSTFBGgP1h7srx00mHlBAfY+BCGjC9CKeauFNGdF
         I0YCsAlWvVvbLiFJlGyzEVR6+25+InTsPs2H6eAxdiIMfYGka2kjiXU1sCuOKycmgnOt
         toTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ls6yB7m2qi6FUlQi0e95Lc81JKfij9i9l6rtcmcTak8=;
        b=VmAFDp1L9xVMoef1FThuEOnqyVLltlr5nu5x9eUYtnUPOijn+b/dbp/emfS8knKotD
         0dkmQf2nAn+4CgpJfA0BAwy/E+wfmJA9lY3dpEB0eTJHQjuK9tGT7HLVXlYdNWUkogYS
         vTQxh+1Ongn5zZUHc7CR+SY472wNET0B5Vfbb03aRcfOaAV4bX67cOTIu0bTsyHJp+TI
         uP28uVi7eWZ8jgWfRUsmmlt0y6BehANy6UGobehP8qsTbhDsoFot2tLZa56tMiq017Vd
         bVOMNo+C8XjTKiQFJFbtRs7TWUWkVo4vDV8B9fcAkcYadcAT+n4Kf3o2f1xWca3FaBtW
         728g==
X-Gm-Message-State: AJIora/XGJmecoPiwSnJscoF5S1GGFxVmfpt52Ngq6umyAKwEAlxX6m9
        o+33s8TyEyQmzi4u6pHoUdN2uw==
X-Google-Smtp-Source: AGRyM1tsqKmfD0LspHT7HlY65vqjpsSthGGW/eUJ1V0K0Z5bfsNimFwCoKv+V2gUeWRwD9QslV7Qgg==
X-Received: by 2002:a5d:5984:0:b0:21b:a858:3678 with SMTP id n4-20020a5d5984000000b0021ba8583678mr12519365wri.293.1656336490689;
        Mon, 27 Jun 2022 06:28:10 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b0039aef592ca0sm13404144wmo.35.2022.06.27.06.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:28:10 -0700 (PDT)
Message-ID: <4ec8e2d2-f199-976d-52ae-bbba2d6ac40c@linaro.org>
Date:   Mon, 27 Jun 2022 15:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        s.nawrocki@samsung.com, jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
 <YrmYbZV4mj9d9++t@sirena.org.uk>
 <a25126ed-ef39-8316-6ae5-9551aa8120b0@linaro.org>
 <YrmvZonpB5GhLGbG@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YrmvZonpB5GhLGbG@sirena.org.uk>
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

On 27/06/2022 15:23, Mark Brown wrote:
>>> That coverage has apparently also been missing in -next for several
>>> weeks.
> 
>> Eh, it seems defconfigs for this old platform do not select sound, so we
>> rely on randconfig. :(
> 
> It's not even turning up in an allmodconfig?

No, because it is old driver for S3C24xx platform which:
1. Does not have compile test (I can try to fix that),
2. Depends on/Is selected by S3C24xx code which is not multiplatform
thus is not enabled on ARM allyes/allmod.

Best regards,
Krzysztof
