Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8E518517
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiECNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiECNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:09:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F170EDF08
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:06:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y2so30914408ybi.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=QqOKqosLnTIysETfUoo3k9YZKo+wVelCjriYi+CdH/w=;
        b=OKL0gLF8Dq+3houx4Ob/d9UDHyjdgeQRQ+uroYP82+WKwhgLZhwA5R456tDw3jtena
         7JKJEWd9r1Jzv6u1B3b+q9InqxflX/XATipqT4KriGM3inL1ZdDwOL/6XlrLIj9jxKtf
         ONwcBPRZ8jLAblwm/reG1EcEYq9Ne/DeRZx2pTz0fVfIdgQ7n41+uxBh5yhLkC9IknAU
         /Ia3fCIcMKbNnLG3xci7K4shhCs+S0xBM+sZ/3wmnmmXHAmuOPb4H0n32F1+zbasZoZN
         gmH1xJkfQsp0XekryVdWgnUYVgOpVgpdzYlH5EkR/FZ8M4NM/K+SRiPqCfCeydeWGsNy
         wA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=QqOKqosLnTIysETfUoo3k9YZKo+wVelCjriYi+CdH/w=;
        b=cvU4AVxziqQvql0LmjWy7G95OPJGRxcoKuWqboSe5vwKu5tBYrnhi5ptChvOqC0N31
         0mYGhUL/sbyusZXMDJRxpo+siwFFpgpRYPTsxyGXsucQG/QJqgmT3K5IjVOSgenAlGT3
         rgyMdsSzpAgfDM01uFJ3HUi2WU5D3wppr0ix9bn1mFoMMI2pJCF4TlqZAM+Q5tbmqZ/O
         ANX/kTz3PAQS54i35l7u5msb58oQLK4Y9pJepiYRRFcLBLrU6xAYdiOybd0aE+IgTBRu
         H7FgH/fNUqcqyg0e9s6wrxzlkdRCu16uwiMrcGWZttavBjzsjeqpeF1jbH1Ef3vJl1bp
         tAaQ==
X-Gm-Message-State: AOAM530A+Cx0atinyU8Cj6RdF8tQNxVj8IIxCZl1CfwvIRJxEfIFZqKR
        4iNB+F+1nhFvo6xh7TRkw3jqo9VPWwcUKM6svgM=
X-Google-Smtp-Source: ABdhPJwXJ/TFqT7IR3LbncUDDuwDnajWBXr0ai10w86tu9525KgbAMu3NWJyGQpaBOvnHKh6gprm8uSCA2bXeyRVqnc=
X-Received: by 2002:a5b:f8d:0:b0:628:620c:a45f with SMTP id
 q13-20020a5b0f8d000000b00628620ca45fmr12791829ybh.17.1651583159760; Tue, 03
 May 2022 06:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5827:b0:28b:3af5:e708 with HTTP; Tue, 3 May 2022
 06:05:59 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   Synvoy Company <synvoyvaitservices@gmail.com>
Date:   Tue, 3 May 2022 21:05:59 +0800
Message-ID: <CALiB83eo0xUOK2UCkUXnhCZeC1sb8riCYoLaD3s5RrW7zEo1rw@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [synvoyvaitservices[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
From: RGI Company Ltd
Address, Netherlands
Call:+3197005033311
03/05/2022

Attention:

RGI Genealogical Investigators specializes in probate research to locate
missing funds, inherited funds around the world. We can also help you find
wills, obtain copies of certificates.

Recently a woman from the Rothschild family, one of the famous families in
Europe contacted our company that we should contact a business minded
person who is capable of investing her funds in a lucrative business.

Our service fee is 2% of the funds and we will be paid after you receive
the funds. The funds transfer process should take just a matter of days as
we have the mechanism and expertise to get this done quickly. Please if you
find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr. J.T Woods, CEO
RGI Genealogical
