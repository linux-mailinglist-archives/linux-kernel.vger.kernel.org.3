Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7E52705A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiENJoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 05:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiENJoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 05:44:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10543EB98
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:44:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so18229720lfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 02:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=hrfXREiEhQm0OgMs8hlGUo6d6xUQTWKKBevWgHItulNwUPLW1iZFbrjrft5Yi4+/Jf
         zH/hyhoLGs/SpG5PdE+Ec55KrXH3HZFD/7gY2muZ9HHuR4JYiC1+QfrNVOvDrrJLv8qu
         MpwkXsQ0XgScEd7KKYJCW6WaCja1JTBKcEmOyO7m+Ys4a1PSHnpP+CEcvSP1yk6JyYYv
         wc7DGdM3KLO5tW+juOdj8hmigJdL7Bz1u7wcsMj33O8LyEAgAIV4DvwY0WVSvK79V3uC
         Onx39xzJZHy0m2bn0e72AQSzslj6L0IXaoQgYGoJwtmp0IBjNDUOOWkDvFS6G+tIrcQ3
         gd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=pBghM70T4d7a+sE116PtN+owt3rvCIH2onPHYQsxAWB768yeVhxlVUcm4icLVqKLEX
         7/QEGFsc1xs4d2QGvmAQfUl+ZqHsrgE1Kz30aJxBGYxe8+mS8aBAVZvcdOhHfq+TLOsd
         yxbjjI+OzR6uNq8n4O+CbpcvvQJsLFq5c0bqVI+SX+UGGamNsCwBONOfH0vVsbCo1lFR
         YCaHmBtlrbTjIgAtDu8y3EtLkfXfJhwYVSjMCv9CRiV5/IofigIxiUeJqY76ephiKFMM
         BcZEPhAcfnY1VINYQ69vECzLPPPDLNdnYfG9Dt85Ysnq67M6lAsiX29kGtYbQG+kI/ja
         RF2A==
X-Gm-Message-State: AOAM5337KTPPSf8+vBeq1OfspV/O40ApVXNcixOZnf7pPkhZLb2FCt/C
        jeLuJeF8LvFbNW/dCosMTnuVAP0vk2px8ErLBBo=
X-Google-Smtp-Source: ABdhPJx56LS+ZJlsDzJRdVtjJ3JmBynUwaZwIOiDnV6OKgwPkNeV5JUHwTG8TarPdyMGiPVHXwfHrKV6ZWy7n1hCMKQ=
X-Received: by 2002:a05:6512:31cd:b0:473:a235:1ac0 with SMTP id
 j13-20020a05651231cd00b00473a2351ac0mr6575133lfe.364.1652521449991; Sat, 14
 May 2022 02:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:5198:0:0:0:0:0 with HTTP; Sat, 14 May 2022 02:44:09
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikarm <klotsijeann2019@gmail.com>
Date:   Sat, 14 May 2022 09:44:09 +0000
Message-ID: <CAFjstLy9KRgQdT+v_n1RtwU+gg1R_fxQpZWmcKdRmyuaLqPNFg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4974]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:130 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [klotsijeann2019[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [klotsijeann2019[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
