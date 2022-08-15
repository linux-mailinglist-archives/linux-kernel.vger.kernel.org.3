Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17761592EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiHOMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiHOMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:03:16 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08722B3F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:03:16 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso1298877ooa.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=+mcTZ2eqc3eLQRfLqaTPyOtzxWrRbXuCUvN2Q5tWSyo=;
        b=hctLBxZVyyvwJoIpeXoXZn1NAvAkLSb+eLgOB8nCAXo+MlMA0IhkxNmfS3x+ybhmCc
         tHVzcXrqCqhjjz0BJv/TtjSAAqe/J3FRLqJ7UJ3LsGtzba4J5e1Zq4dr72NNbZ5nvn6B
         SBuPrXVb/JR4X40TDn8BVmcCjfKlJ2GPjWb0I4dkmwQHooKH6nDvUkcAWx6acOmGJQEF
         bTk9dwoFxdSpb4sDv2C6OctiBafyfj/OZpLMEhX1sRzzw6E0X5UlZ/CjPuRni+pd8RKR
         WH1eSdX5LZYOc4Pa+z2RfGdhpjpELcWgIpYaO6uyMQlbPrvCpmTVnV9StRdRdpdgRMA7
         I59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+mcTZ2eqc3eLQRfLqaTPyOtzxWrRbXuCUvN2Q5tWSyo=;
        b=cuutxyPWGTRDwJoblvURunBZ9xE+lFpiLgEdOBnIR6EZEyUsBOo2dspnnVP76khTQM
         yTbvjWOGkz48ABWHSI9sRxBnyJ4im19dxTN34FWLMokskLVEojUUnQJAWJOoIzBFRmRK
         fwp7Ko1PrgN5TJlAk26g/TR9F0GxrMQ8Nr28HRZpHWaxw6CBQnlwFGHG4pwKowA0PmSa
         LGpPvW03x/hWXr1YJBuiA8eoDKFAxeO/zV33uOekQ3aZnvXeKxa0vtrqKgd7C1QRssSv
         /8DRDtcHZ0biIINT7t23y8X5u+K8LUAftMQgXVr4Te8terdXAExZVfCHUfZEWCqh4OQT
         QGXg==
X-Gm-Message-State: ACgBeo1uJaxCQzAyzf+zI249DvAUNaEc0obc3v+idMnqtxrE1XodsOrV
        JpmUTxgPYcbKpc9g8Q0V7egGGmYNz3HoqxCswt8=
X-Google-Smtp-Source: AA6agR7ynAHEr8f5gNu+C3telG+SncFvxjQtkKrhOIeFYI/9kwGrD57FIhyq+qo4bEOPkc9MqRWlobrQ64IqUenCFzM=
X-Received: by 2002:a4a:894e:0:b0:440:b743:c7d with SMTP id
 g14-20020a4a894e000000b00440b7430c7dmr4777977ooi.86.1660564995142; Mon, 15
 Aug 2022 05:03:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:5398:b0:b2:b875:1ec8 with HTTP; Mon, 15 Aug 2022
 05:03:14 -0700 (PDT)
Reply-To: michellegoodman035@gmail.com
From:   Michelle Goodman <michellegoodman323@gmail.com>
Date:   Mon, 15 Aug 2022 12:03:14 +0000
Message-ID: <CAEJQfw=L-Y3MjMMPpYP+TKXFexFT8EV0aamx+xHO87sO7uDkBA@mail.gmail.com>
Subject: Helo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman323[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman323[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVyaGFiYSB1bWFyxLFtIG1lc2FqxLFtxLEgYWxtxLHFn3PEsW7EsXpkxLFyLg0KaMSxemzEsSB0
ZXBraWxlcmUgaWh0aXlhY8SxbSB2YXINCg0KVGXFn2Vra8O8cmxlci4NCk1pY2hlbGxlDQo=
