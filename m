Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF861533419
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiEXXtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiEXXtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:49:47 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69362120
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:49:47 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e3so19882498ios.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=T/c8O2EWeG3CEtDKLYgYxmiBCxgkdgj92v9IOvcwlz11iDEwDxXDl1gqWk0Y5NpCnt
         BIHP7m01f+kmYW8CAQddcGLDLoIgzd53Kzfwger/5uP9kTN5guwN2fQuhD68joSLxNwX
         72fcjhvgRxy66gckw62jFBTLI3Ot7uHo78OARAIBUwWn6FOG0A75n37mZJUaUqOc87lp
         RQhYKrrpdUsv5NkTAlGFSiDLM3zU+HndDxuqN6RkB788Lnuw3HyXoPDN2TvwEUdKqvwy
         eIJZNRBIIZllVurWPnGlYTXc10tFBJgBo+laorio5BV9n8ASzxwrA9qJFZNLn6ZcoEuQ
         vKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=ox3JjOPS3sdZZVsQp0RRCgMkmX0SjnTICo7H76MltwbKKXK+3kWsM4FuzXUlGh0oQ+
         ATel2vAy9fPcvMjxAI+fQC9XXO4zJDG7rXsBZ2JEb3yvNVNs19eNsF4CcwyY9gqzpSdc
         lEsLmtpzHfUP7nHDtcwlnBd6WYMZh4fxUisHUzSFZPw2fNrFAw7HOQH8zSKzvVBVc2q6
         oyPQ0uY60C7yvsPEFEvCO8qAl+GsLGYUVroG2LMnIcHkNuiQN+xkazJC4IegjbCI6ePo
         ZoMYHAQmHJApoklt63ao3PCuPPpir85Lzj1ZDqxUIyWTYsHORXlDVuzCJAe7hxrzx4j7
         mIcA==
X-Gm-Message-State: AOAM533biQItigPmZen8wRVpkUU7WHeJdxB+b+3dDGFQGnbRQlsjsHdx
        xIA06ut71HIL2x7E1bkB3fPzCJHofD9/YoleIXY=
X-Google-Smtp-Source: ABdhPJzk5VV9KUpTXFynKJfvx0OF1Y4tvJSfY34BatwSbd7XEwCysukdv4/WbEc3cE0PUae87pBxM3g9hqfcgnA2Cwg=
X-Received: by 2002:a6b:7302:0:b0:660:cbd4:b5de with SMTP id
 e2-20020a6b7302000000b00660cbd4b5demr8928127ioh.24.1653436186617; Tue, 24 May
 2022 16:49:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2d0a:0:0:0:0 with HTTP; Tue, 24 May 2022 16:49:46
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   SgtKayla Manthey <kenechukwu202@gmail.com>
Date:   Tue, 24 May 2022 17:49:46 -0600
Message-ID: <CANkpFmqL7wbCisZeN0ZYE+rizxuG_+sip-dRWA6yE==1xj1SOg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5107]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kenechukwu202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kenechukwu202[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
Please did you receive my previous message? Write me back
