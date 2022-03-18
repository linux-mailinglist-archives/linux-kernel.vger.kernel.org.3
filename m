Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB54DDAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiCRNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiCRNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:52:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D11EC64
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:50:41 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f38so15965629ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RUm+BHjHjBqeaGuCk1BVfImjY9k8WWn0rEUOHAWVbOo=;
        b=ZrYBrPpWBM2RjpWfdZN9f4l+L1hi9t3P5mYL9wSgaSnK/Nk4frepBbdcKmTsYJ7+j9
         acA3BibaO3H8q9tu+r4/KezhzKIjRZhkaJYnO+QVqGQeI+3frEYAz0cduOKhJfOkTl10
         DhSBx3Tszo3h8lerAn+l2xf5XufG2sF2BVeFK+XW553fQ5cmA14677xN3tDrSpYuk22g
         YmIFV7pjnFy5tVazayaancHTRXR5bevoIom+BkA2ZYv+bnpSQR9twbxChqcvGytbidjX
         WgQwqVZ+Ge6RiV6WMP688SZfIEFpmrrVShgylANpHs7jaEDcVeHXLSnsRQAfd9of9gZz
         2rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RUm+BHjHjBqeaGuCk1BVfImjY9k8WWn0rEUOHAWVbOo=;
        b=HFEj9sMxQqN05D+3xRkFXeP9Zqy2dC8lM1GR4kzF9f5qORkm9CuV81i+F4eJfjJQ/x
         WJlTXVykhjrI3rvO9V8nMwReDfWxlmn4QDCj5njQyQdw02jxGZRasQboqyvXrugVYeZK
         oJ8ZBMKJKxgBtQHk4OyvyxrGmZyQ1F0ot7kT6qg07tthIYhcK/jVcALF4X2png39FUQK
         ++kLNMK3MWC49DE6nYYsgWXuRA2aP8+sMkzbDktEw31yssCw5Mu1Hs67hqQU5pVfVy7E
         HOzq5bt9Noq9Enanjr3w194pPLrJv7UxFsWLHSeZCUW5RiH1WBinPyiEClaKEtxC8pW4
         9OFg==
X-Gm-Message-State: AOAM5313WfRYL8MkbyEQgwZJh6tNx/V0w2x/0rSyIV9xYgTUgI2mojmo
        BH0RRBmHaNrHOudTDzxuHobTFm691UYBXzWqdcJ4GCxej1HrBQ==
X-Google-Smtp-Source: ABdhPJxwwT/RlQuLBSkFMNQJLr+RmryRMNe1lGwD1wjxOkE0Rky/hlLyNr4KYAyZprGwSh1+xFnEWvgtlP3g5AmoM2Q=
X-Received: by 2002:a25:ab81:0:b0:633:c474:9330 with SMTP id
 v1-20020a25ab81000000b00633c4749330mr1232292ybi.383.1647611440888; Fri, 18
 Mar 2022 06:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:526c:b0:a7:a253:f724 with HTTP; Fri, 18 Mar 2022
 06:50:40 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle <michellegood044@gmail.com>
Date:   Fri, 18 Mar 2022 13:50:40 +0000
Message-ID: <CAJ5e1jaM3f3V9Rb620p+ZRnXqQ2ncNvm2Z2LTZYUcHYgVwfV6A@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegood044[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegood044[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten
Danke.
Michelle
