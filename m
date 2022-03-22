Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4274E425C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiCVOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiCVOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:54:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0783525D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:53:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o10so17994280ejd.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTZu+aAjGtXbM3jBypGogmPu5vUABzZBTRhCCSqoFwc=;
        b=fCZjD/FlPyo91HLM3S5Xv48gNzf9IYzMQtgPIPjHfvZ8JuuhVINkE/8wj+OwFkJ68N
         3X85MRvQAnvo4jpNcVwzlbeYFY0pzy6rdCf1mJYEIGnCo1xfX1T0tQaMhMCDPTUnU4pB
         5KYpF1Tu1o+dVn9usYerGsCCPhTN53Q89Tuiz7stPwpcPhIF2y6tU2qmE/b0PVsAwql0
         pB8ngzOAtJoUX4qqfJz5mJedeGTBzo6f9Z25PU3CclCeGQLHAo2LltOzdqeXwTbv+dS5
         5NOYdtdH3hDBm8GxKYe8Cqgtm8Tj5YhyAqNdydyota3BDDm2FsroiV2xf8pTMhw6wC6c
         8KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTZu+aAjGtXbM3jBypGogmPu5vUABzZBTRhCCSqoFwc=;
        b=cjgrpCBZ0pF1zYcX3rw6ES5YIlqyJ+xCQhC+W4IabLYzlnKn8Ih170vySVj4hrxUNK
         zwbuyYjwRlUYlPRLOAYrgTPoYwkQAzzs9jOBYPEEzNhsYAT3hGlfKflDkrOZfk5D+r3+
         3lXrT4fw78xx0AvRF/8HrZe5fq4pdlfky3p4J8bEY3mN6Bca3fXCcOk20T8Q6JKJIBU6
         MpEA1SvNlSlWVReVxiMhZPA4ZcBWHum5JmFWqj6L+lF7YYwokMeD3D/UNJ/wUQlJbBks
         yfje5u1eVMZvEiJkpmuKHLmlKtOFERkk2xLjidaFUCXTKR6/gKiwA8Mn1PhvBek1Qd0U
         hwDw==
X-Gm-Message-State: AOAM530Dcr/sZS0pbj4gMsKXrN8gcxvWsV7i3TelVb7RbQHOQflZI349
        RwOtGWzXFuuKRGfYHmkETw1gmXnayh89V9cWt+A=
X-Google-Smtp-Source: ABdhPJyPff7VNNo/pyyZyW4uwLzi9OXTzypmZtjrYfVjwsI42OcUC/mIG6ZfC2gepDdJHzQFcgBZCxo3kr/Zl5v4Irg=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr8735310ejc.44.1647960804724; Tue, 22
 Mar 2022 07:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220320064529.12827-1-sensor1010@163.com>
In-Reply-To: <20220320064529.12827-1-sensor1010@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 22 Mar 2022 16:52:14 +0200
Message-ID: <CAHp75VfkDbO3J=MgTdRF_UyMvZ9XCJEQcEOUEBuyqEwnrNwbsA@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/brcmstb_gisb.c : Remove the
 suppress_bind_attrs attribute of the driver
To:     lizhe <sensor1010@163.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:41 AM lizhe <sensor1010@163.com> wrote:
>
> Even if platform_driver does not set suppress_bind_attrs attribute,
> when registering with platform_driver_probe,  the value of
> suppress_bind_attrs is still true, see __platform_driver_probe()

Any reasons it can't be switched to builtin_platform_driver() macro
and hence constification the driver structure?

-- 
With Best Regards,
Andy Shevchenko
