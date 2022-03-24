Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB444E6A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353403AbiCXWJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353292AbiCXWJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:09:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E3B0A77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:07:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e5827a76f4so65668267b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLWxA8wg6n+f5T0y24aBtJCW8wmwD4SPo3vQt28tWYA=;
        b=Y05/Zab1HN03P/jamNVYSBGzSSB6uMo6K1AqSpX4Fxja9nAWYB7jx6uug50l05xED2
         SMjJHNzStFjdvwwHW2ExpO3Bi7ghTLj7DDBu9RYdoCgFOaTa9pLA73HoN6iJn7lLjXZu
         gaadP+bwRY19CKk2QJrcb+lH7maUnhS6shMRClU7YKcDCIn/dwJdqwIsrksId5b3XRz2
         WMP3r2iy+OfvegOnXXvdeWbzp4iQoBh3uMrVIeWY5MEQzSKFM147CFcAQSELVvOZEcfu
         ZvQBPhR65RmW9lR0brsiLuHIQgI8pP2jw6V2ZEeXZ40Lo7v76ks6XhHFaDz988SdRfxo
         O7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLWxA8wg6n+f5T0y24aBtJCW8wmwD4SPo3vQt28tWYA=;
        b=BHvYny4VLxepv+is0dVHe/W1rQS0F4AVjsT0JzrQq5kcNCSi2+gjQPaBbhvapZAfRO
         woBQrkNTT+ZX0eOzs42lAKAezrE9ss3V0L1pukWmyV8Y+vufhyrFFlrgf4XM+j+DNurt
         6yli0uyG1uIFAu9neFTKqtcDbarQC9gKe+wRmS35/7l77HcW5JjV+VrMmuyKJ6NlIvCe
         oCEkhRLxaE9abJP/Xzbx7oT6cRcdqw4TrZlmtSS7Nd5zFfg2wzQA43E1ZR6RAdrX81UH
         9gqFI7rT4s/bNeQBQM5ge92Yu1mhhuql8/yxeg0XjW/Vn1tv9xtXliDEJEq1a9VgLJWN
         nAqQ==
X-Gm-Message-State: AOAM530Pg7vCDHMh0eCTVVau9RLXAAX0qN/h7+7leietWDVbA0et535x
        E9i+vgm3mSFQ0KVermjWXqXOtKH2bK/7H0E0lwN2qA==
X-Google-Smtp-Source: ABdhPJxyiOfpcU/N2RYdUqFJbv5TG+c6h1/t5HMUEdue5RzMjHlvdgz7MxYCZsJVXcGks9THnDuZ4XTJmcFkkT/XHPI=
X-Received: by 2002:a81:89c2:0:b0:2e5:84b7:83e with SMTP id
 z185-20020a8189c2000000b002e584b7083emr7528200ywf.448.1648159675714; Thu, 24
 Mar 2022 15:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com> <20220312113853.63446-2-singh.kuldeep87k@gmail.com>
In-Reply-To: <20220312113853.63446-2-singh.kuldeep87k@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 23:07:44 +0100
Message-ID: <CACRpkdafQ4G=a1E=G6GK3W2zAD4Nh96GiQiYbYkn4ctVu3c04w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: integratorap: Update spi node properties
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
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

On Sat, Mar 12, 2022 at 12:39 PM Kuldeep Singh
<singh.kuldeep87k@gmail.com> wrote:

> As per spi pl022 binding, SPI clock name is "sspclk" and not "spiclk".
> Fix it.
>
> Also update ssp node name to enable spi bindings check.
>
> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
> v3:
> - Reword commit message

This and patches 2, 3/4 applied to the versatile DTS branch.

Yours,
Linus Walleij
