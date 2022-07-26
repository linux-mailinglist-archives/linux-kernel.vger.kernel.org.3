Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A8580E66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiGZICo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiGZICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:02:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43AE2CC94
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:02:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sz17so24733993ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tqRCRe4eX+VkGHjaxOX6NtuRPCa/urbMxkt+QthVPS0=;
        b=OWITSNRKHM8Fga2M8WOo5srtID0NrtHoyp47A1Ey1jYEfyBzDqOc8NsHA03D/MAFtn
         iLdackwCJA9q49X5e1VXu0aOlU/R9e6gz1qT+KOIBIVzsr/3j54IwXb18J1BZ12AYy8Q
         lPzXqW7MVb1oCnw3P6+llwraCJCuSTnYWWrJ61LTjl8Xy3UWoNX/avOpzlTHOFKOjyhr
         ZjpYxuyuEOu8/LXS4xkxc6FAb732y1h8csYmfbolGsmNnCQmViIZQQ6Sjb3nSZO9oCQL
         mfKDOXy1kRWb3mxiDXlj0BH2wnyST+SeyltucNcgl4ctzR3Lq+f3qylxWL+4iUaetFcP
         0cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tqRCRe4eX+VkGHjaxOX6NtuRPCa/urbMxkt+QthVPS0=;
        b=bv+QVtAulvv0I5GQtsuqy/6izOD+Epz9r0ODBZw5sclhUOYhCc7IVj1+LOoiOaoXoJ
         cbEIjZJzPVr7SjATFW+S3rx5y/L8wlMZLK1jbdQ+QYkY+LdTLiewLqopMM98mVEEax2x
         iUHZxJ9cyI3sP75FwinPF2naLWQLXco4k9BMqk4Gxg5MrrDz8uXnfSBXUnyTAOJGVJWl
         19R5R0MyUmTzt/8ffKDiDIVA42l3jW+Roce5Bo0fLf5U+uIy5WJ35ePrtyhkbvvPYZzH
         paJkRaXR2tPUPGrsw3H32XWIIW8b306+8a1QtziyKwoI9GSWZyLKfQg8xZX/pNDTuvC4
         Karg==
X-Gm-Message-State: AJIora/bpHdbmMGkD5usBZ9HaynucfbM19EBhSikWGv0AQAoYt2PbZC0
        kCbYHslJTYeXRJSLm+3mqYlpV34oDUr/YCK4yh8d7unWQkKARQ==
X-Google-Smtp-Source: AGRyM1usXww6QrDgVRlTV20uypXHuu5RtRCNDP8/S0/sCysg10uzzGGC0YEhdHtviVWo89ng+KSkTUQy5BgNPCfu3FE=
X-Received: by 2002:a17:907:a053:b0:72b:3051:b79b with SMTP id
 gz19-20020a170907a05300b0072b3051b79bmr12564833ejc.690.1658822553187; Tue, 26
 Jul 2022 01:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220722220810.28894-1-mario.limonciello@amd.com> <20220722220810.28894-2-mario.limonciello@amd.com>
In-Reply-To: <20220722220810.28894-2-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 10:02:22 +0200
Message-ID: <CACRpkdZ+2XCSJo336+=k_fxmPxu=M3KZJofKfY5JqPXGoKmnYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: amd: Use unicode for debugfs output
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:08 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> The output is currently split across two lines making it more
> difficult to parse unless the newlines are removed between pins
> or it's read in by a parser like Libreoffice Calc or Google docs.
>
> To make it easier to follow to the naked eye in a terminal window:
> * drop the newline in the middle of pin definitions
> * shorten all output using unicode characters
> * align all pipe delimitters
> * output the same phrase even for disabled functions
>   (but with a =E2=88=85 character)
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

That's a bit unorthodox, what happens when someone uses their
old VT100 terminal to look at this file?

BIUT! It is a debugfs file, and you folks at AMD are going to be
using this and I just assume that you folks have aligned internally
that this is how you want things so I just applied this.

We need testing in linux-next for this anyway, the merge window
is close. If the other AMD people don't like it for some reason
I can always pull it out.

Yours,
Linus Walleij
