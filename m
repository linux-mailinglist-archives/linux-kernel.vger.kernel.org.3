Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD44B678E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiBOJ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:28:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiBOJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:28:27 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF38564C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:28:17 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id e6so9982864vsa.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AuT4st4Mdz6E9ng3de55/ySJOc7SimIbntAvhT1m0cqPZOG6LuTnGC/6NPWMJM9aa3
         GU6Xayt+4eWuUyMPl5Sgzde6f0W+8F7czDsC0ztr3vGyUkL27JqfpuKu0MicT3M/C0EC
         JNXFfgNifPi7cYw7TOMn0ZLeToMElWTxOE0dsewnE17ULW4ejAOqSNh87fTVJarttdCk
         YXdIlLPNsxrlZU6KKnJGOUMcsedx4vtj5hqjKVeNjTYUjEf6+Gy6JORuTwNaecppcWXG
         z4Lp2t3viyr1CxuQQl1eDeNLq1RzzoTMQgCf43M+ZhJKmk++vF/d94P3ZkhCvXxuGfws
         q3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=CrDW0Dxg7m6qE0x2rlh2OEfet5rwRcDK7FVixi5RkYJG+ltOH9yGlVV63mSQx+x8yr
         rBOX/taSlJURGRY5xAvLCRUiQEQZe8LdH9tmQoussZFOaEILOdocp9OYJIG6RdfTVSEw
         TpUaCitXjtZKFzmOWsyFGcWdiH1hjSMglTo7l/2vtgV5piT+Tf4OsGi328/1bLNJj493
         LiL4BpMxdkMulCQny+Tn0OCgnPAN0gtLkcbuj9vwd8gn/JpBrVaWQ1XZfjsOW4EVz3HU
         XCJiYuXQWANLjVa5waKpbdY8Qf18XB+cVVsoAEz6xBp4fnKP5TyLN9QcDSdYdH+/RVsG
         CJvA==
X-Gm-Message-State: AOAM532DeKC6I/LvTPyiJy7cEX1qOAwSJTH4jhEwFclyImNERvJWOYal
        x6INsAmHVpcl2hSwlcrLnlN2MADK6EHfPHKwxB8=
X-Google-Smtp-Source: ABdhPJxuTONBmBP64sTTVG7d/1dnWCuVvKDwDdanYFvqIzYKLJUFlcRAzXvJDnB8GICyiS5tK54G/Ah/gzAdetc8vOU=
X-Received: by 2002:a67:cc14:: with SMTP id q20mr1065811vsl.30.1644917296940;
 Tue, 15 Feb 2022 01:28:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:1081:b0:280:7250:5ff2 with HTTP; Tue, 15 Feb 2022
 01:28:16 -0800 (PST)
Reply-To: abrahamamesse@outlook.com
From:   Abraham Amesse <lkpeazusgeorge@gmail.com>
Date:   Tue, 15 Feb 2022 09:28:16 +0000
Message-ID: <CAKrG5eUykiu06ftVP1RMXapb9k0ZEX0sKzyUHLXDHooQzoNoGw@mail.gmail.com>
Subject: Please. I would like to know if you received the message which I sent
 to you two days ago concerning humanitarian aid work.Many thanks and God bless
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4435]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lkpeazusgeorge[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


