Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A440656157A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiF3Izz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiF3Izx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:55:53 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2523B542
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:55:52 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j1so17572444vsj.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Vh7wj/vtPH/RYi/xxKXFC21qgmPG9hBrn7wXPWClL3LOwVRv5jzcOvxCaOwosS4mlP
         Kj27miMVP7Q6Po62VJkjquZN3UyoueAFJnZksKbR8xx87/hYkOA3ILmFYK5lU4ZlME0j
         73sjzQA4RNiu3Jew+X06vQEIJvbYCGO+7ibmZduBrgJKMA5U3UmfK2OnXvbh5G9CgPe1
         lTz3rUS7ZJGMkCeq70/iOd7C8CNS2SZszbxOdc7ZFQLxjb69chQ3ueqPM4OuOXPXdlxX
         /uv8Ny8EROz6yrme0qJGA9dW1fYdLivUibdwlGqTwdpm1evPwgbfx0sHlt3z+eVOw3HB
         Yvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=sEpZLTrjAUkeV7W3T0b9HrW9oe2ELtCX4g5oF37guDZL/iVaWGePzq1DOw7uRNi8hX
         mN0E0jrSoJ14lG5091kPShaQufoL7wQuQ3R0BtGOgoAXih0040U9s+vhUwmPgJtpNop0
         31oD8JQGDoEhDE0GM5Sp69R8CJlN2N8TajnVTydE17TPAfNCDspPH6IqGFmI5oASzAG6
         mmfVSYLZafY4J11Y2cIjk9oUw1Vn23iSjDVpQmyDi9uf9E77xQDN1asLRo6swXBbSV3K
         jLSTuZernEdAfWcyJVSLp/w/4EkDSGh7zXcrFdx425gPbF0OkmDFjJdfZ2jhOIgHx4Jf
         o/uw==
X-Gm-Message-State: AJIora8SDYNCLQzTWnK24y8F9pZml2OEnhjwkT+3vjobJoGUWgYK/9Lm
        9PuVxcjnE/prX7U+K1eHUZ3p1G7OtTclfl8Fr7A=
X-Google-Smtp-Source: AGRyM1uvqZhGUaEvlkFD46gVa+OlxYu3IZjhw2MmFcb/xe1uspZnV3l5f9LJS3Kz++dLnmpZj0jK08iZRwSY8aJJnIo=
X-Received: by 2002:a67:d89c:0:b0:356:8ebd:b41f with SMTP id
 f28-20020a67d89c000000b003568ebdb41fmr443538vsj.82.1656579351545; Thu, 30 Jun
 2022 01:55:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: www.ups.usa01@gmail.com
Received: by 2002:ab0:3d07:0:0:0:0:0 with HTTP; Thu, 30 Jun 2022 01:55:51
 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Thu, 30 Jun 2022 08:55:51 +0000
X-Google-Sender-Auth: K4-3jLOl2YEtjX6BNiMfE24Gz9U
Message-ID: <CABpS9gbtgq43FoZvkHj+YmGF+iPVjfBsau2abFL+wqenpTF-Ww@mail.gmail.com>
Subject: Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
