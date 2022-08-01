Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21E5867E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiHAK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiHAK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:59:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E834B7E8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:59:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h145so8054629iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=OBoRdmC3WZpcg7B7QYUJ9ZF86GtX7OgaoevIh51l5CQN1L4WAwQ88B2tRwTzo7RGFX
         AbomqOOKtA+dHHFeAtd/L+1QcSsWTpku7Cyj4oZGtw4JZsstm98hw3ExtajCZnjo+l6k
         eUjjmkinOPIXwp7bwNZU6p+wtoSygGk3gDBjTuuiTsrOy71aXxZYU3Xjg4CVovU24czA
         vk0heoPU+OAp4FeUsohGMeSEsccSnbWS0N4g8xGbTvz26FctPvHs40xs+CQi3GyYmcbo
         XwhhKJDT5HlfbfuQ3weClKFTlAxURAFQGatZ/Y7hDv2TDL3hPoxBGOhl5/pTYLul0/P0
         Q+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=hnrY5vuW/CzkgqoRkdoEM7SoC1v54eHiMZUREUwO90C1hcoEQOnxQVVs9+cOMNoDxo
         7K/OEj/HHFcC3sDKT/rlq/p2EqBIAzxSBq4U0PcrPsn/LTWRaLB5bQ6C+r/xR8o/Y2yB
         i77MEcv20/zhyTj0OuDCUvqSxH6U9VOGkNNLenjoukuGbNqTUIMjWIKo1BwJyVbzQC3n
         g1E3c7WxFHNqe220YkRQIIA5iXKRmG/+U2jefBaWr5bsMVbfB6n+5YqVvg6gGLu5reYR
         5SlJEi8Qo/VGe+ilsZ4kRRxIZvSr5KrgEWX5qQMNljvY6B4/Kx7SVSqcLSx3FoIn2G8j
         6kkA==
X-Gm-Message-State: ACgBeo0YImlGPj+0aOiOoiykSJoq9g4gxx+p1WnDxF0sAryCDWlt3iuO
        TrUbjquZ+JQxHniYt+2DdDfZZM8IDOfETwdmuPo=
X-Google-Smtp-Source: AA6agR52JbqfYuqpjXo8PRh2qgzsxr0AoJkRk0zWXUUnsRnr28TWAQSIFF2GLvmeC1fPke6yHfFLbfX902oai1gwLqM=
X-Received: by 2002:a02:cd8c:0:b0:342:7e69:f296 with SMTP id
 l12-20020a02cd8c000000b003427e69f296mr3791jap.223.1659351576846; Mon, 01 Aug
 2022 03:59:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1926:0:0:0:0 with HTTP; Mon, 1 Aug 2022 03:59:36
 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan bikram <sherriahmad220@gmail.com>
Date:   Mon, 1 Aug 2022 03:59:36 -0700
Message-ID: <CALkASqOS=aw0RHfnu8f-iSLvL8PONUggF8kxmO3jt8CiFuLr2Q@mail.gmail.com>
Subject: Nice to meet you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [biksusan825[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sherriahmad220[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sherriahmad220[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
