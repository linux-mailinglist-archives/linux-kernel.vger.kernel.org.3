Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3AA461C96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbhK2RWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:22:03 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:35700 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbhK2RUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:20:02 -0500
Received: by mail-vk1-f173.google.com with SMTP id q21so11596098vkn.2;
        Mon, 29 Nov 2021 09:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fBdrgGv6tktc6qHM+QrJHNp1TEWCu/zp5THtBD27tLk=;
        b=Xbn4r9BdZUr0h/PvtkAz8PRTXmpShz5YZrbr2cRAPex6RfgnW2YA0f+dQ384oumW60
         P2j74IDPd5uIW7xVpo6uRI3bTVOb+g57AzzZr9U3UrFZBwXRJIBcGmhPX2LCV6MUhHD7
         m+RDixhyOoVcyyGg9zgzt8SAu0GMIvgIqJIlcdQf2FkjSwF3AFPCBKbleMZL4jxpLIyA
         +T7r19ulzQBReYRJbCSY+0gBsH5EZ+vFLZy8spnkaclQC9gZqKqixdLWt8A4qHDWvGcw
         QLB6vfMIbQ6iMgkDnlE1A2qud7gWIhcUD2n+sILD0VpE4C5dxlfIulFfjn+FKD6ZumTp
         rPWA==
X-Gm-Message-State: AOAM5329YwVY/6lEvQ2ZVOeLbTSeN9YkjB6la9VgsechBFD0TVx4ZH6d
        73Mj7tmNeFkjJTAX2UePMRhOY0p1eiQt+w==
X-Google-Smtp-Source: ABdhPJwKxSCtshx7ofqy7tF7q8TPNlJC1E2UiXxiMH8jhU2ttdAUvvFczL8cWDNi1aS68DbpCyfkNw==
X-Received: by 2002:a05:6122:201e:: with SMTP id l30mr38464274vkd.10.1638206204210;
        Mon, 29 Nov 2021 09:16:44 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id p130sm8406551vke.56.2021.11.29.09.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:16:43 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id o1so35596393uap.4;
        Mon, 29 Nov 2021 09:16:43 -0800 (PST)
X-Received: by 2002:ab0:6d8c:: with SMTP id m12mr52235612uah.105.1638206203112;
 Mon, 29 Nov 2021 09:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20211129165510.370717-1-jernej.skrabec@gmail.com>
In-Reply-To: <20211129165510.370717-1-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 30 Nov 2021 01:16:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67M2Qi5tUq0BNbgahTsY4bbYGQeqzjoH8RZ6fYWzrWsYA@mail.gmail.com>
Message-ID: <CAGb2v67M2Qi5tUq0BNbgahTsY4bbYGQeqzjoH8RZ6fYWzrWsYA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: Adjust power key nodes
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Klein <michael@fossekall.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:55 AM Jernej Skrabec
<jernej.skrabec@gmail.com> wrote:
>
> Several H3 and one H2+ board have power key nodes, which are slightly
> off. Some are missing wakeup-source property and some have BTN_0 code
> assigned instead of KEY_POWER.

It might have been that after shutdown there was really no way to
"power on" the board with these GPIO power keys, so we didn't use
KEY_POWER for them?

> Adjust them, so they can function as intended by designer.
>
> Co-developed-by: Michael Klein <michael@fossekall.de>
> Signed-off-by: Michael Klein <michael@fossekall.de>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
