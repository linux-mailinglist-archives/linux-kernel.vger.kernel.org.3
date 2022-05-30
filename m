Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36A53783B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiE3JvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiE3JvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:51:06 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B8E70379
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:51:05 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z186so13905450ybz.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+KeSo/fWvnc6u5MrUIaMKgF1g8SLQMm/WZBiY1MQVk=;
        b=epYrj8tuBlD7nPtwAqBw+avCcUvBwb0hoS9nKLq01KJTJdymZP7J8J1Hk3sMy1C3EM
         iblzDU/vGir36G7NOK+k7bkFlGDFwhYxopyELG2mdHjU1/KNUETtBt26SZt5VyxVdUXz
         a9SLKnz+f1EHW8n32gVL6bgPFikyXeDwv9y5nL1iAlBZil8sSb/uwMLexvmyvX0DAgHq
         FK1rzq6SWmSHPhF4rxFZd7eBjj/9OOXZHZFgMMXJWq7FsbTG1j+yteOb+BWYX/UPcXnf
         9cU5gUqpM3KP3k0Bn8kI7JxI4Yfi+9iJsm9fhRsWuizUHXbfIF/W90Q/E/O2pvBNLr61
         +N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+KeSo/fWvnc6u5MrUIaMKgF1g8SLQMm/WZBiY1MQVk=;
        b=6iMHI/nbYgz08h0K+r5WYzMkEoL0VlKajByUV5NaZXtRHEchjZv3Mw8GEv/smfQkum
         e/XrwLJmWHtSieQHuHp2YhKv+3fWs+dp1dwTA9+TTqajDcqD/LTi1FwUyAlBc0EzScoC
         xMqkbKBAzhiF/ZX80FrH/p5ptxd2oTciEeaVhLScT35bBdPxATqwp4LseEGWNnRbAtoc
         6u7ny92S6t9kDLOP2G7hseAL107fTxBKCpQjZpa87CtQziZVLumX+eXbuCqDoRlEGMTc
         7L7t1KAlFOMrdiJbWQmMOUrIH/8EKBbQFLjaM0nLqNTTnKSNWPbxdjkAKMo2Daz56092
         oMPg==
X-Gm-Message-State: AOAM532n1MfhLYUSezH2gZxuZHH2UkSr1VNjiAqBq2yTbKBle0JAAtmD
        wZ7tVwf8xLVClsIDR5Aj5UPtfoYbJ8bSdDSqcQjvuw==
X-Google-Smtp-Source: ABdhPJyi6lD5Sm8rQ9ac88KO/Xc8R6A9CcuTRPnROgWjKKyrcs5431nT919e9BUPNVD9slLLBdsrYwpsbgG4th6Ojdo=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr51748986ybt.626.1653904264637; Mon, 30
 May 2022 02:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220529132638.13420-1-danilokrummrich@dk-develop.de> <20220529132638.13420-2-danilokrummrich@dk-develop.de>
In-Reply-To: <20220529132638.13420-2-danilokrummrich@dk-develop.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 30 May 2022 11:50:53 +0200
Message-ID: <CACRpkdZ6ZaRRVzctb72oSbBL_Mwug5cZEKR7y_jbJ5N47psyFw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] dt-bindings: ps2-gpio: document bus signals
 open drain
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 3:26 PM Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:

> The PS/2 bus defines data and clock line to be open drain, this should
> be reflected in the gpio flags set in the binding.
>
> Especially, this is important since the clock line sometimes is driven
> by the host while being used as interrupt source.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
