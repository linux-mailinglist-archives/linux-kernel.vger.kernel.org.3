Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA956A3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiGGNiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGGNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:38:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285B2C66B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:38:11 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c8a1e9e33so117816247b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fMXMrcc1nEUI+wuPCiYfYqhHz2SxADiONzXQR+IXB/w=;
        b=cqI0df0/bM14+Byc7m55xqH/dIAnqndav6WEZ0vXEwN8nE+9d/6E7bPTx7jurCCx+Z
         8/AGzVUBhsuLMdgiSE0bAwmOpzkhXeTzNERKwBMZmx56CqYiVGEUFpDaFU/oeT9pX4Qr
         AXnav1DzXc7BqLT4Rwp7nglSOltIpsRoPeRPyBx5zeh5SxsEFv+mHAvksmYG+5+lbCTx
         xUlDVOqa17c4lqvu0OHC3OQrsUza+R1PN6Cw7iy1LVFKAlXnNCEXxUXW6kkxyxXnqYrU
         35ZrvwI/DXXk6eooLBO4KbMf0Oz3iCRHNJvEOtz8P58RulMlLP2c1aW33cz8Hg6SWvqK
         dIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=fMXMrcc1nEUI+wuPCiYfYqhHz2SxADiONzXQR+IXB/w=;
        b=eYBQsfaU3N7aiOoyeZEt9xZlQZpeGbGt+AN7CkdjVCCnNHLLAu8XvYAtz38TnuipFL
         RWx/c77q/5Is0+DnZc2Z6hAQAkoESRpEq+m8SIN32Aqt15e7B+JGPlLkNLla7CG2ii99
         PHmtwJ/YIFr1J/VxMBuSLZnNpdxf4rPmN0755mluncIJuYA+3LaPTeWPpeUujVJXI9s1
         DG99hnXfu7vZNptYUOfINaL93OXCWwCoA5Wo6fM2ARctVRS4hsAtCsYPVCTr/xjXece6
         7Z1fYhuljsZNIbyLXwNJytDJjl71f6mSVkC5J2c+37VepvuVvykNbv7OQvwbvVcU5/h1
         7w1g==
X-Gm-Message-State: AJIora9spl90eT1WGsAZlKf6JA8XXUj5hQ5IlI0j+ISm6fspzCWDFSYX
        DchMlUMqFwSrSf8ZMotQWzBghzJ+Ug3x38Unh9E=
X-Google-Smtp-Source: AGRyM1vCQXAllNS9enJwQwPcq7JKZWRaRH29Sl14BzUwoGw1r7ZzDhKtZLSsOlJlfnMRrfHKHEtxNFnh8Fp+JpFpal8=
X-Received: by 2002:a0d:d903:0:b0:31d:4fb:2a10 with SMTP id
 b3-20020a0dd903000000b0031d04fb2a10mr4870695ywe.339.1657201090557; Thu, 07
 Jul 2022 06:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:f30f:0:0:0:0:0 with HTTP; Thu, 7 Jul 2022 06:38:10 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <sarahtage24@gmail.com>
Date:   Thu, 7 Jul 2022 13:38:10 +0000
Message-ID: <CAK7Gz5z0FDTFZ1L3oqyHFzzRgFNQh1ZjHh82tA7OmdyktT3G5g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9700]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sarahtage24[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sarahtage24[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Ich entschuldige mich, falls diese E-Mail Sie =C3=BCberrascht. Ich habe ein
Gesch=C3=A4ftsvorschlag, der f=C3=BCr uns beide von gro=C3=9Fem Nutzen sein=
 wird.
Wenn Sie bereit sind, weiter zu diskutieren
In dieser Angelegenheit erwarte ich das von Ihnen

Antwort. umgehend, damit ich Ihnen weitere Einzelheiten mitteilen kann.



Mit freundlichen Gr=C3=BC=C3=9Fen,

Michelle
