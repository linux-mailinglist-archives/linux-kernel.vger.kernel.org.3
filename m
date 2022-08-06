Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E328658B4B5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiHFJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHFJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:05:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E28AE51
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 02:05:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i84so3475524ioa.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=HGrxmIA6vpZaTYJqYRQ6OcwmtNtaa4n0rjfXy5Axk9/xQomyPG+Aw+vx65qcCU/viU
         l53ZgTJK3xclEZFJ561qYtFFMzTRc51RKjfhIJ5aBZrZt1cuHadzGGt1Y2RYqdlIvQP+
         LD30SkXu4qzXA2SWZgOTxjxJNv0QxR1aM1ZfxFk5AbZM8ebSc5wbP7qiCXX4SuXP1V/i
         mbNNlBGkmaPUD+/JNl11zb0KH5ue43hPa+XbqimtIVOE1eCRvB5uUa0BSkDdLo8N6IGK
         3StNfGkOr3PqG4+XDlPkJ0JuXUB5iSVWHY1jB3+XXkXgCnXeJpXyRaepF/Pk2akkhl84
         v2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=alEn8HeR0+NpKI5nQ73odjmjRvxNIVKYDgXpj8L5xIO5b9MMAJbFqd3Xisi2n2Uzxr
         uHJ3Pmhwn6lkRY0DNG48A4n7MnMb0HFdmzFCL3vFTGbgaZuBKRIKfWsfk/dTYGvm2u/z
         lDeZS8K8ZdbtJE4X3u6LFFCWaVzS41JcsEE7fv7LYZyb4svIXjGVRqlzFs+7qV7qkvge
         085VyGaV2G0SNDCGQ4WROxVwpEDGXfED3Lx7iKjUEX9a0lHEDeCYN3pwMppn09S0GLXc
         MWMfJYo3JOfNQSLsrnPEi6gwwygtIv/aa6mBqB/A4wWkT8qHYC4Y/hnDXWb5MuDyapnV
         eG2g==
X-Gm-Message-State: ACgBeo1a7qhzbpSyTH7lPBORICaGGX9IiVRVB6uSws5RsPQBja+Cza3l
        zVK5HyG2am5cOL2SAG+gjuI8rrDaXxi01dHnai4=
X-Google-Smtp-Source: AA6agR7nnzmDjOFZFPwUfqSd46vMho2Eg4wZsocxOrLpPD/Oi5KWodS8BUl0d1i0mB/n7tDONgTEpkzBEeWIRiZ//o0=
X-Received: by 2002:a5d:9383:0:b0:67b:adc2:c053 with SMTP id
 c3-20020a5d9383000000b0067badc2c053mr4497290iol.102.1659776704013; Sat, 06
 Aug 2022 02:05:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:16cd:0:0:0:0 with HTTP; Sat, 6 Aug 2022 02:05:03
 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan Bikram <jbi880375@gmail.com>
Date:   Sat, 6 Aug 2022 02:05:03 -0700
Message-ID: <CAHiEHe8w8GRRBOmUgHBCnVjLn_2ASzBAXvhPyoCBcffjoRFXNg@mail.gmail.com>
Subject: Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d29 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jbi880375[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jbi880375[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [biksusan825[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

Susan
