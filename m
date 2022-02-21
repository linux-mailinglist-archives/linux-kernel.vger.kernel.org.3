Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A84BE752
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359116AbiBUNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:34:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359098AbiBUNdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:33:53 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C6220F6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:33:23 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id e26so17585663vso.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FNR5T6Z01UkWpBHi+H4JVSGpKE3b3kPuS7Yn8CkS96s=;
        b=PD3EsvvWF+hEH2LlQtAVz1CHnQxSq7BDG2SP5WetIG0IpWuKVBXp4wCWs1vVaZ9zFE
         6E6zzgByC1+69NiZ35dywqWP0QE/Q712vCicIqCowSQ73EDnU+gfIummaFCIcdzPOZp4
         0ljxafCYs0uvlpbbRuFEkfupycP0glGjgb3G4I1p/wYho9EBUxaerxM0CdpakMYG5IlJ
         hgenj9YYVmLhSowyPnG0fGq15P0oTMQPD8eKaT1tj+ZcRLb3kAX480y2Smxz4m79UIw1
         +3w8FkUTm2a4WeozMvURXaXgg0i2nW3R7C5SD/s4hcjS7KL4tN2FhC6rDI6kyYLpnfpw
         Ae0w==
X-Gm-Message-State: AOAM5339yKbruyB4JZVkMehne1eOG9FaO2UGTU+QFarbNRfdYY5NQN4B
        1H8Ak7qQ5GbEyVLv0d5gNThSa/gXciY9xQ==
X-Google-Smtp-Source: ABdhPJw9JbgDcFECca+S/4S08heh6vp8caJWn9Tn4OGa6Y1fzdhGdFkwanlZ7cSJHM9WwNFFpntkOg==
X-Received: by 2002:a05:6102:14a8:b0:31c:1cd1:be56 with SMTP id d40-20020a05610214a800b0031c1cd1be56mr3982195vsv.7.1645450402829;
        Mon, 21 Feb 2022 05:33:22 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a74sm156336vke.33.2022.02.21.05.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 05:33:22 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id j3so3370871vsi.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:33:22 -0800 (PST)
X-Received: by 2002:a05:6102:956:b0:31b:1b52:ed9f with SMTP id
 a22-20020a056102095600b0031b1b52ed9fmr7911944vsi.28.1645450402349; Mon, 21
 Feb 2022 05:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
In-Reply-To: <20220220210714.2484019-1-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 21 Feb 2022 21:33:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66AZaN5S025z8JxPJJXc_WM=a+YTzPwpyL-v_XP+wa3RQ@mail.gmail.com>
Message-ID: <CAGb2v66AZaN5S025z8JxPJJXc_WM=a+YTzPwpyL-v_XP+wa3RQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Allwinner SoCs maintainers
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:07 AM Jernej Skrabec <jernej.skrabec@gmail.com> wrote:
>
> Maxime is stepping down as a maintainer, I'll take more active role and
> Samuel joined the team.
>
> Maxime, thank you for your effort! Samuel, welcome!
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
