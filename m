Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82759A557
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350017AbiHSSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbiHSSJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:09:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B471D0E5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:58:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y15so978780pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc;
        bh=u/OaRe8j4jksvhIVs7jDH2hbGqgIsID85M7442i+PLU=;
        b=ofOnX9epaZ6TkoPnOrD2MQRhXBeJwTBwxFiai8Y/m3gpyurNs4+FfFaepjKC3XmuXB
         vcSwqvOZy1D8QwI5GgV6ouzRyafKPC0jTdJv9T7tpKzZPhx1bnaw+Y2fvolnvVmJoBWz
         t4NLIN+TDI6V7XPed7LoQOMXaAFHvl8q1bc7sJjnkxtJ7DL8QkEWImIdnShLF2SVlS2d
         bcAJK26C3d76h5nKkmahEdfsbrl7tSadz0pQHvTvnj4UguXZP6QoM9TFObrggpYyXfQo
         ZtwtIFZJF8tzj9UJ99nPaWqdUN7tNT+bizmHw0/EvAQ4DHwOfUU/sOs20KStaCCzu5GI
         MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=u/OaRe8j4jksvhIVs7jDH2hbGqgIsID85M7442i+PLU=;
        b=cYGwk2uqEN3h4lshQO1Nh2IMw7ZlS6BVdYATIxggLjtmO+rNPHDctjB7dqngfjm17a
         PaFFyr6qj0ily81vbTOkOPWdXQFVybUb8ZX40q7Pv+mSmOxXpn/c0e42+XFuwW+vS0iw
         4tAzW4AaXLOsAp+UM+VIG/44zYBaMf9FAMXRyc0bbGy54Bk3p0Z8Aolmv/7Z+waI6FDU
         fXgpDLplCw8S0Xs/QBx17zijKJl9yW/xTyE6+VPaj9Sre6IuRzHf4gAwcrh4gfsH1CTw
         b5TYEi6aBmNUZqJ9K7b0z3U3cON1e631xsd+IVCftsrMBQyW2VFIOQOObYArQ3Vyvz2H
         Vg1Q==
X-Gm-Message-State: ACgBeo13UO2FPwl1zr+o4xlPcLLXrAvmygYVKohE/03Y+1MR2pyaFYBV
        HIDybG2mQcD13JdzrFHbfKrSLg==
X-Google-Smtp-Source: AA6agR4TgjmrO/fYfCUIjwhhh7ReSLmLXbqBTyG98BJJD7Pb7nWu2n/C96KagGp/cR1VHhyHJ36mkw==
X-Received: by 2002:aa7:8895:0:b0:52e:c742:2f3d with SMTP id z21-20020aa78895000000b0052ec7422f3dmr8983529pfe.69.1660931909171;
        Fri, 19 Aug 2022 10:58:29 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902f61200b0016c4f0065b4sm3419926plg.84.2022.08.19.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:58:28 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] MAINTAINERS: make me the maintainer of DaVinci platforms
In-Reply-To: <20220819072232.8105-1-brgl@bgdev.pl>
References: <20220819072232.8105-1-brgl@bgdev.pl>
Date:   Fri, 19 Aug 2022 10:58:27 -0700
Message-ID: <7h1qtct8sc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> Sekhar is stepping down from supporting DaVinci. As it's quite low-volume,
> I will keep maintaining it.
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thanks Bartosz!

Kevin
