Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A557215A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiGLQtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiGLQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:49:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C7F5F5B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:49:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 70so7968610pfx.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/iMrTCKTkRgpWpO2hCmtWgkl4iS5MKol8bSUF3o7+EQ=;
        b=JE6UAjTddTEcFULCBFUSaK6iXICjZVr6rmypaSIcwC3/l0sSAmm0rbQEtiLW8wtQrV
         Px1zPt9nY9TV4aSfReThKYM6ZF8a0BhnUQ3vvScftqKHShkSwJrtS9gip2Bh6o6rkixo
         vuT4KFRakCc5pnMMSRH1VRKXEOUYv9V3y+D2X75qem0rnZoU1E/cMfJLWqbCbQ+7fwCJ
         G67jV/NdCZGegbubnJEqz69uimMcdrUQhAO3zgyJJSsAIlRDqf+5NKhI+leLqoP7fzAz
         fUXyqCjaE/StWBwi4Aq00qLFcMS3VPNTGXbRZxetGJmRJUO0TukX24zwcmBDncezrFGS
         tEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/iMrTCKTkRgpWpO2hCmtWgkl4iS5MKol8bSUF3o7+EQ=;
        b=5PsnpzbfKe7QyBvmCXAPbmLYpNMlo63mSH17q2SwsIk76FzZ0eZ4fFXKU4n1XmiYse
         oelHuuyaZvN6CbFZmU2q3elPxGvE+ECBUJJBqDSqwn596Vo+JmVqSmt+x0IKmGI1X5HH
         L54QwC0EjGRfGqajgYo/oCLDdXnQhouzgC5YG5D6Yg0QUekWJ+Hi4o8OXNnl/UiRZZoj
         d0zXu84J9aXFwPITbdXD8QcWxH+iLZtUwPeDeeJ+FnC5sBw6ijAGwo9A9iSObWDiCxdy
         PkZywLwS5JGdAg4/Ir9s8LkqI1pRgsjjIuoPgb+Lhn+yn32BC/rxYVUVyglDv9/zY08v
         WzJA==
X-Gm-Message-State: AJIora+JylJIIN+TZ+o3JHg89V7lgK9uzKAcODP5ebdLA+LFq/P5piQo
        UIeYPwk+gVo1skgbbK4rJsA=
X-Google-Smtp-Source: AGRyM1tkhQgWWTjSn3Uruo4uPMs9W7S0tD8V5YknIYYjSLCaWppfQLg3Lgq5UbZ5WJn0eACSNh+5oQ==
X-Received: by 2002:a63:7456:0:b0:415:320b:67e9 with SMTP id e22-20020a637456000000b00415320b67e9mr20933096pgn.27.1657644553447;
        Tue, 12 Jul 2022 09:49:13 -0700 (PDT)
Received: from smtpclient.apple (155137199074.ctinets.com. [155.137.199.74])
        by smtp.gmail.com with ESMTPSA id a10-20020a65640a000000b0040c9774b332sm6424495pgv.48.2022.07.12.09.49.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:49:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
From:   Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20220712160919.740878-2-konrad.dybcio@somainline.org>
Date:   Wed, 13 Jul 2022 00:49:08 +0800
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A7E181C-DCC5-4793-9A3A-76318D2F1581@gmail.com>
References: <20220712160919.740878-1-konrad.dybcio@somainline.org>
 <20220712160919.740878-2-konrad.dybcio@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Nick Chan <email@example.org> # iPad Pro 9.7 Inch (Wi-Fi), =
iPhone X (Global)=
