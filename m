Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796555ACDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbiIEIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIEIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:48:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBF22517
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:48:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br21so12225950lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9Kl/LP3x7BLRniWNOfuWrIvnLuvqTIiI5JtIWaJ5bks=;
        b=kvMuEdEeAdG4Zk8Gr6mqRS97+G/xGpS/9tGFAJMlKtecigMe7vkTx6AQsfBCtJpmct
         oGb0BAco13T8hmQFaU851PvYTZ5HkVjRIP3+Vex56hxA5Zrm+l8zYGe9yjZSWHAjzN8z
         +LaPdjCKcMovFUeNao7lSsHR6P/Lvm7j5Ju5/uvL3QOA54/+RsTjO4PpaYv0pN9UFMOS
         0qTmY4ZRa0WNYcyzzU5fv7UsywfOnjXAg07+ueOTLMoVKEi4HwEKMZdQGekmLBLRmY0K
         815SC/Hd9CgaQ6CnOhFDLwl5n/EowpNz8mLCdwopYLh4WpboZF3RmpfFmRWXyG2ECH27
         K4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9Kl/LP3x7BLRniWNOfuWrIvnLuvqTIiI5JtIWaJ5bks=;
        b=s6qIIG7gVAo/02gWhh8JUMgtWTC5rfe6tuNOdCtj/dQFigRqYNPV+hDe/ihl6X3CWl
         uzfaXMA4PQNrg4T+vyM7sLuwpfcZXLv9S2kvApfzs9psHU6LiQzUK7XBR2qQV1QylZ5I
         xiEKF1jD4NHh+a/FOWNSdrt6mvT5fW98f6tbWfkLVSQPbJ/ih6LYsi2VC//+SiModyrp
         bXQ5A9t3bWSig70Y2FgbSh94DiJVAuzs8bnbDU7StXNBGRQBWyJWa31NsDxrVxeoW0My
         RsUHnz2Xh9Zxk6/f/Yqk1XGxPWfCfaePNGUPKff+IBGP00HKKkd/p4Pg7pm5Bx+dfheZ
         9VSQ==
X-Gm-Message-State: ACgBeo1zDcW0p9/fezKw42cU6EwiHH+mrmKzQrZsprg0U/DsKVDDQBte
        qo7ytOft3CaQRtNR7mIvWdqFng==
X-Google-Smtp-Source: AA6agR7Ohfi3cEjWcbL50mHtxThquWN9Y8UfBcBIQo6pDVKTVo5u2VYkJgEW+uMwFizgGWxx3eccTw==
X-Received: by 2002:ac2:43a1:0:b0:48a:fa18:60c4 with SMTP id t1-20020ac243a1000000b0048afa1860c4mr15128966lfl.27.1662367678419;
        Mon, 05 Sep 2022 01:47:58 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w1-20020a05651234c100b0049472efaf7asm1116704lfr.244.2022.09.05.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:47:57 -0700 (PDT)
Message-ID: <94a40049-ff71-1b34-53fe-eb94350315ec@linaro.org>
Date:   Mon, 5 Sep 2022 10:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V5 2/4] dmaengine: imx-sdma: support hdmi audio
Content-Language: en-US
To:     Joy Zou <joy.zou@nxp.com>, vkoul@kernel.org
Cc:     shengjiu.wang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220905083352.89583-1-joy.zou@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905083352.89583-1-joy.zou@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 10:33, Joy Zou wrote:
> Add hdmi audio support in sdma.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

This is still not properly threaded.

Best regards,
Krzysztof
