Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE14C2C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiBXMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiBXMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:54:00 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232620E782
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:53:30 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d07ae0b1bfso23827147b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pa5+KWLWH/xTD6y1ZfeTwhABwlgMcIDFHCErhQl8iX4=;
        b=lxEz94RrhWNvaWvFwgjLao6uYurgQlt16EZNZpnTUFlDYSq/dAi3IDrZC1GgerbltB
         MI8w6l73LzhxDP3kbKNQ2kEYohpLL9OmNdKsaf/6n9LpAE+8RyIwsL34shWH2bEZ9cSG
         HvWoeLhOXspL3EaZ20LljNhKGjrISZ6aF95x56oRlSZrw91WI/2MjbbLpmRAfKiHGAhS
         rwQXe6Xi4UN92eLsVk7pofzqE+vdBmDxCqyEVlxUL6QnPOk925SBjfzx75k3WSMD0Hky
         f3SHr9/mb9dcEn4+oEP5zyMQQr1GBWBGdijQziyiHybXn/lrZfiZyMpkpkr9uaIO3VFh
         0SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pa5+KWLWH/xTD6y1ZfeTwhABwlgMcIDFHCErhQl8iX4=;
        b=PKTVlj/X6DWkFhvR3Rozjx4CJGt7ihp7quOlHvE0MOIqP5dXo9lik98RsGco3Foy9r
         rrDjO7e+v4UesoWk7mdkxSkekD9L12pZsPGBf2apOJ40zWMS61Rd55A1VqGYzz3eUl+K
         MbVmvwElc7iVmwqJViAeZtWwuHiJ1I/K9Ltverk/qw47F7kGLMp7a2rlhN8lbtmqgLBE
         i7BdXCnJpNufQhhbvNOe/7/flH/SXcvezyJ7f6dII8QqeuyNoUIxO/wZZ6r+jmI+IuS0
         zmYyXLHtWMCBiLa4UiJQ2SNegagY9fQ3hTnUBwcB0UghLee11Z53pc0ZbkFGpHmVuzpe
         mXeA==
X-Gm-Message-State: AOAM531JugpgFALZdg9yPJ+6KyEtYCQ37+fvIyQyVxpLkn7Hj+JuXb0t
        lv9CaTX1/+Tnjf9NzU4uXFOpS9SkBQeo9J5gPy8=
X-Google-Smtp-Source: ABdhPJx30H9kgTKpXKhyEnb2UtXdYviTaZ43zY2k7US0PGAHR9I3wgbSLNyLV4yXdSgAfT4f62XeWv9A+p2odAuJogw=
X-Received: by 2002:a81:4e49:0:b0:2d6:ef98:f882 with SMTP id
 c70-20020a814e49000000b002d6ef98f882mr2124434ywb.26.1645707209896; Thu, 24
 Feb 2022 04:53:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:90c9:0:0:0:0 with HTTP; Thu, 24 Feb 2022 04:53:29
 -0800 (PST)
Reply-To: michellegoodman035@gmail.com
From:   Shayma <shaymamarwan08@gmail.com>
Date:   Thu, 24 Feb 2022 12:53:29 +0000
Message-ID: <CA+HOoT1n+=4bu74TiSt8To4kPjjUKWPgkFTB0Rn7jBKjzS13TQ@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shaymamarwan08[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shaymamarwan08[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht bekommen.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
