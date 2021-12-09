Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE846E0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhLICGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhLICGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:06:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFBCC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 18:02:31 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bk14so6701103oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 18:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8K3bG06x/4Qcc20a3im8lkNmJGI7KGAZkSewlAH7Ic=;
        b=hbEBZYfCJ7j5wm9xIF0hzQZiJGXk6e83kLO58LTAkWQqt6LBo5fjaRYwbB7B3df7FX
         /deh+sF65RsILVht4N6YxfwYv75j7Cdx384iTgycWw6tej3js5HOQabpe8xLbHW+IhKR
         2NOxZhfxxa6SBEqFGHyCdvxvJwx+Ov2hSQZt6ev08fR57PgOkE70hX7AKRro5UxWUgvb
         vD6kb4S+CA+xFMLpI7bjKYTFyGEuvZrxqyLXmvv7oOSo76T1gUJ/tlHAhcIErd/yNqG+
         cu0dgjOKOVsun0wP0C5Dn/EfWyl/mu7Hl7cXRnQQ9CG/ZIUk86BnKO4SHNaVn8Qlj+SG
         S/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8K3bG06x/4Qcc20a3im8lkNmJGI7KGAZkSewlAH7Ic=;
        b=X2v+bMJzRqYGxEdxyTavObCbnB5mD6GoWekb5/nd3zmXg3P2Amf+IhWgnBf64ogaS2
         zSF9RPgoBygX9e67+flPN1wcSDk9N6iHZd13uMCrgF3r4jI9cFV7v1rANgEsdmQCgl4J
         4IW4rD5M0PvsJ/iKfqj0cARyRae+kFBzWGTC3eouvd30XhnorbhQyQq88vyW3lXWqaOt
         hbdBP+pw+4y6dAlexZh1on/2hGcE9YqoLX9w/aG2Z6DjyRqbYrDDJi/tRnMoXSvkKXwd
         qqlzlqAZjToscl9+Iv6fc6A/qcWjdtCoBeuGYw6l0OpNizg11Bk78gCHq05haaRQ3MiS
         71lg==
X-Gm-Message-State: AOAM530S/7QsFDxbtwyrmFPxzsakJCrfmu4+pQM/3fwZrHcjxDpeOzUX
        +Vrp9jVj9FbDQA+9KB80YpVNKsOuLxLjNmJnHwKGQQ==
X-Google-Smtp-Source: ABdhPJzCzGNZwo5zhe/Xg4dWDfMmoCYErIh/bGdFKt4jw38rx+SAbxKy4CMNvHObhJWo2OyEZLQY/O0LIL+U1EGgjcs=
X-Received: by 2002:a54:4791:: with SMTP id o17mr3263096oic.114.1639015351156;
 Wed, 08 Dec 2021 18:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20211201072434.3968768-1-vkoul@kernel.org> <20211201072434.3968768-3-vkoul@kernel.org>
In-Reply-To: <20211201072434.3968768-3-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Dec 2021 03:02:18 +0100
Message-ID: <CACRpkdYLvEBMzkWgErXNM-NZ3HXrK=stL68Eu2wzaSi8yG8Bvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add SM8450 pinctrl driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:24 AM Vinod Koul <vkoul@kernel.org> wrote:

> This adds pincontrol driver for tlmm block found in SM8450 SoC
>
> This patch is based on initial code downstream by
> Elliot Berman <eberman@codeaurora.org>
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied!

Yours,
Linus Walleij
