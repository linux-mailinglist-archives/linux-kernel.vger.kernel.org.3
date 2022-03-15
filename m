Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD704D919B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbiCOAch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiCOAcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:32:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AA3AA70
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:31:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2dbd8777564so184877717b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eWWAIq4GOD2TDjB3wTVzuO15Vfksobxiuw1mavkPNE=;
        b=ANxWNMjShIHor0BITAU53mQIjLb9XmteDZSn8rv5iqZP6Oa5DRn5yb+vy9CA1UW0RL
         vqEsV/7Y/REu+3V89owkeo9JRj2n2p8/Uc9s+pCO1V/y1huk1heGDDo9oikdI5aNbjD+
         dREYz4sE62mL2kDPSHJLnaKZT8GsbaWta+ayGQEFKUZ+EVJ3oP/TJQLATtKupBFcizhp
         PlMKyovbFnqTSBBiv7QffXZ6P3nC7et8a60Fw708RbH9qywIxeUYPeIzDwWueHbK32Hd
         NnPFlWlKWl+fB4aS9e10AqKuFVS4aRjr9sHoEuZ/8i61rAK76AhwHrTh9J+SgjcAhvj9
         UJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eWWAIq4GOD2TDjB3wTVzuO15Vfksobxiuw1mavkPNE=;
        b=ZMqYmyUmEU7+6t0O1XSvWMfQr0Q3nt6HaFS7eFyUgDBmkmTmpdtwDwahbE0kS3tzIh
         FenrGqIJV/M12ZobxI8Z7MH2d3jdUFkeMdvL/0OFKVMqQOr36WF7/fsv5eesKX8IsIkz
         yqeR95L6C+fiGREz3knF3jHRP3Aw/xAgm44WDpCcpMc2MoSWQcrmZDxeevyOVQSI/Na8
         /mecD8k3dfJq74AzcEcX8de4lZF2xrOivL+CrZ9If5WGYo/PVdaOISE1AjpTZjmPyKd8
         ZDrvIDt8CySGvCQwQays6Xoi9/2HNGFJiptwJwIrYCT+aegDcDCGpPmflAW4SoSCPlJM
         F74g==
X-Gm-Message-State: AOAM530Qhph7djbDX1QYMlai+FQ3VIRmZK257F//AatH2mJoMewo6Odv
        5ZpvUgQ+OHLAtmhfJWtPNcfwEy47YxWHQYcqBYFd3A==
X-Google-Smtp-Source: ABdhPJwRuBglSdMYHlRyDi6I0V4WTw1liBNuu4TwmelKISlpf17Xaq65fPRfdD4AFRt4ddNiRs9p9jZQfi4lNqjmVHY=
X-Received: by 2002:a0d:db15:0:b0:2dc:b6e4:cd2f with SMTP id
 d21-20020a0ddb15000000b002dcb6e4cd2fmr22611124ywe.118.1647304283915; Mon, 14
 Mar 2022 17:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220220162355.3594831-1-trix@redhat.com>
In-Reply-To: <20220220162355.3594831-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:31:12 +0100
Message-ID: <CACRpkdYQ9K1pvXBaeXQNJGFEON6ya6i9-5KsG0=Rpta9t6YJXA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: cleanup comments
To:     trix@redhat.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
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

On Sun, Feb 20, 2022 at 5:24 PM <trix@redhat.com> wrote:

> From: Tom Rix <trix@redhat.com>
>
> Add leading space to spdx tag
>
> Replacements
> voilates to violates
> sepearte to separate
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Patch applied!

Yours,
Linus Walleij
