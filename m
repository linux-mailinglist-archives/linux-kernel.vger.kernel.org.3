Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CA4B7614
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiBORBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:01:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiBORBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:01:33 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20032E6C33
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:01:23 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAD7B3F1D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644944481;
        bh=SfcsF1mVhQhwOu0M+IJzq8imoaIRW/agDsf8ihIikrI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uaOeYE36IWkZwEz4tJtJrw7+XeIwfSBVuqD1kO/SKTm+QYeFYQFyElWEnX8USS8vk
         vUkwwQ4WgN48ZBejPWAS7sHYXBqaklQq8rWcZOKpSwz/fwuuzomID9mWcc81Jy2Akd
         ckL7bEXyNBYFYE3q5yJyys1u4M3SRfeApkx2LsrDFqfadOKKiF6j73c8tZL6NOE87r
         BCi5/10Bu6JuJMnsxsDdHOfdVMYe7yoeOmHCii3BglSik7yVNYZ9AAoLu75f1m9l/M
         3jE/ibQj4/At1MXc8XnZjkNdCknUnZiPMQzuoyCWLiUdD8/m0TYwVF5w5n3/x8pahV
         qeFwmG1XrqiHA==
Received: by mail-ej1-f70.google.com with SMTP id la22-20020a170907781600b006a7884de505so7601427ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SfcsF1mVhQhwOu0M+IJzq8imoaIRW/agDsf8ihIikrI=;
        b=ZfAcaE5stdaCimAiUHVArZaHffNFb/b+FXRHdovqRRO8VjsyKUp6r8yivjfxTqKiRl
         IVLlkf094Jk6ZbmBoMKKekbAI70BoK2QpcgXr0BnZhOYWycZihFzo2Mgq/cw5nZWsKzG
         B1aev0pzhGBlCZlsAC3OCwuJFcOR3xBL/+3ph7rWwdI95VGmjfTreMTIsY6/tLnbQPxU
         T/GEFcm7psTLbR4kqV+fCSdSYPwJyWiPPYgZEPbg5I7MiJr8Qd9FsDWnK1W2j4LiEbO1
         FD8CMJeOjUMTPLI8/acBDffBogY6JB/LtLSD2ZO72uXzcUVvxhxBXwB73947axMXNWUh
         bEIw==
X-Gm-Message-State: AOAM530YdBqyz9nrCqYoiXcTAdJRlw4Cvr7YP6Fhm7IrivWOU++ZMRyf
        JPyICpZbrmOb7UTI4tqFlXmic8+6V9Cl/o2ACU2j75IXVNpOwd/P9wICGB6g0vQRXMfESAi1Bng
        HFTdHWBTtRb654mte9mT71R9dQc8qEe38TsHnruKjig==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr3642197ejc.645.1644944481559;
        Tue, 15 Feb 2022 09:01:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzMQsYTFUkZkiFrj3/E6W19Nix9stJF1B8bhLbUQmhJC33R7s7pBFl+O1wg+WfY04/ukm0SQ==
X-Received: by 2002:a17:907:a41f:: with SMTP id sg31mr3642180ejc.645.1644944481369;
        Tue, 15 Feb 2022 09:01:21 -0800 (PST)
Received: from [192.168.0.109] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id fy37sm2822372ejc.219.2022.02.15.09.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:01:20 -0800 (PST)
Message-ID: <cce2459e-cb6e-898c-e130-e818bd427ef3@canonical.com>
Date:   Tue, 15 Feb 2022 18:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: dt-bindings: ps2-gpio: convert binding to json-schema
Content-Language: en-US
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org
References: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215165113.52659-1-danilokrummrich@dk-develop.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 17:51, Danilo Krummrich wrote:
> Changes since v1
> ================
>   - binding as separate patch (driver patch will be sent outside the scope of
>     this patch series)

Bindings patches are not a separate series, but a separate patches
within the series, so driver should be posted here as well.

Best regards,
Krzysztof
