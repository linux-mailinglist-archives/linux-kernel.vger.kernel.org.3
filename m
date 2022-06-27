Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA60955C1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiF0VJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiF0VJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:09:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D1E61
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:09:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so18770833lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+swm2aR4k5sh3YX3jWcBe4STb31+XEBdKQilBqyzaG8=;
        b=OPWLUIKbB4Y3o6eeIleWV1rQB0nu4NANmi/ChXofR+u07PJcf63EjrcaVD8WFHeSWE
         K7BgJsjBWvCAIDHd3d7Qpd+28/twGLYrbZGS63VwC8HfHZurG6OCGyyyi86V4ASOc+mu
         pzqHp/dJjivcGRqAogYWGJi7QoC6L1EQ5+LHRcXeUkDWUHvEs9O1Ubcdxyxr8PA9XyjI
         c/F6KPfDTrNsNLGQ5Phb4jC9+WnHgi0V1hqNCXgObIaain0K3R5h+63uVjRmiCH3iGij
         PNKQclMfkzxsDjro/izGRmKLSK9rptsi4lHn6EX89VHsIToLg5uGtc99NcsaHKZm8Xuv
         kg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+swm2aR4k5sh3YX3jWcBe4STb31+XEBdKQilBqyzaG8=;
        b=6Ab1+9HTlttuD9OIRec5GaiGOOmyeQa6+0/pmZTh0SvxCNtXJ/ipYZyx4XS9Q+eLud
         45L4Gb6dL73bYbD2bA/Tv2kJJCksWICN2e/96Whnd9/XiQqsmKlkstlO5NGQn6Hnf2Os
         69cBmeK4uXLtO2G2Z5sVU893BJL4GbQIQagT0ZU/QwIdZq3NBNaJnnMDVt3JCVXNBgYn
         rUqHQObn2pLJIGhOOQh0Q28GO8C/SKaApSlY3iKLJFa5TzYQ2btSIIfsx17/VOuged6C
         xkg5g0b5PfbAiJtxrxc6s1BIj54ZnhWPSd4IaXjJhuV0JyLOsy8V/OXjrdIY6sLcpgAi
         OBBg==
X-Gm-Message-State: AJIora9WXuHp2Pc1GT2xUTA5HhjsA6hEvhmJy39EyCovYidg4hcvR01R
        Q1KTjzYSLeWg0AblE3E4O1PcaXWh2qXk32ruwchd0g==
X-Google-Smtp-Source: AGRyM1sND3JnuSvyboTunC/f7GbcmxFhxxncvjNSJRMmz91aVLp/+RtW9ienklRrhBf9uLmDz0Vd9qOdwx12S+wvy3k=
X-Received: by 2002:a05:6512:1693:b0:474:35c:8c11 with SMTP id
 bu19-20020a056512169300b00474035c8c11mr9287580lfb.19.1656364163891; Mon, 27
 Jun 2022 14:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220627192434.2306065-1-cmllamas@google.com> <20220627194753.2309523-1-cmllamas@google.com>
In-Reply-To: <20220627194753.2309523-1-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 27 Jun 2022 14:09:12 -0700
Message-ID: <CAHRSSEwVq0Jhf2v1NY4LUr7hTJXuU904BU1XMOdA-fB0uXfUqA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: update Android driver maintainers
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:48 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> I've been contributing patches for binder{,fs} targeting fixes as well
> as new functionality. I've also helped reviewing some of the incoming
> changes. As such I'd like to be added to the maintainers list for the
> Android drivers. Note I'm also dropping Hridya's name from the list as
> she has now moved to a different role.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
> v1->v2: Use the google account instead of personal email.
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe5daf141501..081f1dc17871 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1329,7 +1329,7 @@ M:        Todd Kjos <tkjos@android.com>
>  M:     Martijn Coenen <maco@android.com>
>  M:     Joel Fernandes <joel@joelfernandes.org>
>  M:     Christian Brauner <christian@brauner.io>
> -M:     Hridya Valsaraju <hridya@google.com>
> +M:     Carlos Llamas <cmllamas@google.com>
>  M:     Suren Baghdasaryan <surenb@google.com>
>  L:     linux-kernel@vger.kernel.org
>  S:     Supported
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
