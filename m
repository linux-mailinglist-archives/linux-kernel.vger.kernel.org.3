Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A34A7BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbiBBXjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiBBXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:39:06 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAAC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:39:06 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id g14so3497506ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpbPkbhHKCL1jkMxCSu3j+IP3px1jyA2L5DaQThLjmM=;
        b=PRqEoX3NALne9rfjrS/rhhQhS2eaw4PRm8+rovUvPFO4Whq3cFEB+0Ejkgrh6Ktu57
         Oop4fa3n4++zl26aG/T/LHmq2G6NP5V32/bAujhZZ6iCmd9mTsFwEPI0DKd7SeGY65PF
         xehwwJi6gyZqN7rSQcFRk9K2jJe3yjiMfE5M+h0piCM0qLugR4GOoaz5fIVuYz4bcKLc
         uc/tLKNY5s8MSk9ZBpyYqTyPlEpa+S0Nel/0eFDqpafpKnTzlGlCWsPYwB+5RzfyxqSW
         FJ7xzPjyz0PnWEEaXcjdIO2lk4wSHBtMfTB7SxCEtCLCMRJiIGFMJMp/qpCW+fxWWHRZ
         lb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpbPkbhHKCL1jkMxCSu3j+IP3px1jyA2L5DaQThLjmM=;
        b=LoJz6K/Nfhm+xFitWEdGVEo+VI3HycC5XCF3CHcCtmzdw34gez5/Xxi0ZlvYqLc6Zb
         OQoYulw6DTr1GEFCaBrsMgPPT9zuiKY9jF85+MIi3HVXg9CtkaapS82R5FukfhnJWz1C
         ZEFWvqWXSbVAhAibj1b+69WauQF/tL40L5eGuaNEU0UpTikhQd/cF2GWT9mTD0DPDTBP
         dskbFVUtHQfLubjKld1Z+YhRlKDP/TAygVx/27GT+kdwvcHOpXidu1+mWIDwNWKUGJ/a
         egvAQaarwW042yWL3/TNVZs4SbFEJoUsxTWtAu2pY7Hi3k9KC22dZimWDgaxP+UWA/no
         D1QQ==
X-Gm-Message-State: AOAM532qJmF6zM4OiVM/5SpKPj0HNeU6Q3T176A08vfOHkJM87rZtjv3
        6zLL4UATkRH5po6o3Pq5ArKxXgUrSqcU4t+B9FAhjQ==
X-Google-Smtp-Source: ABdhPJz/jjrriNNle4c10Xmkx/FGjzD6biAb60s26WMECGdM0QTrPdZRScnMt2kXh6S0nM/yMScoiApfxnv6vdSXwkk=
X-Received: by 2002:a25:5143:: with SMTP id f64mr47044018ybb.520.1643845145451;
 Wed, 02 Feb 2022 15:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20220125131858.309237-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220125131858.309237-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Feb 2022 00:38:54 +0100
Message-ID: <CACRpkdaCq7wwh4cObQ4zsw3uyf3_-M8RHtsF43csTpmQV9v3Cg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: ocelot Add support for ServalT
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 2:18 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> This patch series adds support for ServalT pinctrl.

Patches applied!

Yours,
Linus Walleij
