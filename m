Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C755D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbiF1Max (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbiF1Mav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:30:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9FA2DA90
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:30:50 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q132so21900786ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBKXak+Ob3Ei97kT4QVvvk8BCgAkzxz//k5i3YHr7AQ=;
        b=GgR5U+cpKuP+beC5qwn6CiR0EOEH6XzBLb0i+6n7DhIVMPsRTVguBuX0GIFAwxtHyh
         VOlzkQLFjsTz54u8QZEbUukqSXXjKYLOVIBuqZ3j1btODAdIlrA9u1a5VdWDSsmZEmmt
         8HzOgNn9XwKr39VlXaWUXbCXnfhLuQ2pIouO3gSqelhRlHTaBJG2ZJb+VzuU0TyMB2Xy
         Z/MBdiVRKz/qu7DF8dDxgw2opyLIs9KHEig8sEDnhzt37j5kzjlQHYZtOorhWUzsHAah
         HzUDVeCnzEqccpNVKFVujHPC/JsZe9FKezhZa5GXwVtxF+kOJpeAyebhqmWlELdqmzu6
         wGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBKXak+Ob3Ei97kT4QVvvk8BCgAkzxz//k5i3YHr7AQ=;
        b=OgmuMy4sdG9y6+tgJa87G7xjnXnm51z0/BEEX33uWQcxx7n08nzMSAQR0gD5xKzAr6
         XoSixDjxQivovIxsFolyT7MdnUxvyfqS97Ep5yu4QJMRbh03A2qe2Wneuo6qEkrpZE5O
         eCwZn6lkTz3vKmhkpwgzT5PCNpgAlnMxvw/BUOJpIJE0ytKjB7b1x7/9iaKDanfX6zaD
         bf6z+JAZ7hoYZRtSTFXrmexFNr0u+EB6IfGXuy9VamJg26kW0Df/HSRvZH0HweN+yrh6
         s7jM4VMJ9mZNdmYg0sGIRh1kWYdezyWCJjIjqm4e8cvr7LH6idKBPITtzzojpzEX4D4Y
         Dctw==
X-Gm-Message-State: AJIora9TWEJOTtSsScyKZNtBhmJPFHT4OaJUaLQaYMZ9NQATwDw492Qs
        RCCK7u8c+4WhLsxzmL1mStrvr9AJsIZ0lOWAiUS8d5YDi4k=
X-Google-Smtp-Source: AGRyM1uqJ5PwmFL/fd47hWxyC8kjLJIIiZ/wXBwR5XK7rYnGkAQfZxlfGFpBUXdqrwfZF2uAIE39CgbX1jpXs0bF+JY=
X-Received: by 2002:a25:d88d:0:b0:66c:999d:919c with SMTP id
 p135-20020a25d88d000000b0066c999d919cmr16080159ybg.514.1656419449622; Tue, 28
 Jun 2022 05:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220618130854.12321-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220618130854.12321-1-wangxiang@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:30:38 +0200
Message-ID: <CACRpkdYqNNAN=-=zfNo4FCVZhQuNju=fGA8ykSQdndd8NfQ86g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     andrew@aj.id.au, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sat, Jun 18, 2022 at 3:09 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:

> Delete the redundant word 'and'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Patch applied.

Yours,
Linus Walleij
