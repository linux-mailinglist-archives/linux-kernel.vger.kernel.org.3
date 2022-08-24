Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280E59F8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiHXL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHXL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:58:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272089906
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:58:05 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r10so13509718oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=VTUfeIEBhloPwJr12CuxHCw2BxQ7ZpXiMjSS5/bVdWEGyjPKY9NYVlGDwVs1gBepbl
         CWD2evjs920DYE5w+GnT4EsUJVl2V35NywyFvVS3kS2FIKLLMXC5yaHnC2nnfCbGebkW
         OIw3tWPzikquhwHdze6r9y2oXdMXhnUg8FDuiug/Z8Wk95p03Bhtk9pkDSPxV3aYZGs1
         lyRIJWdxPFEDrzgxE+x+VXELqbx2ENONUkqqdyQqDJILI4gQW2u9jd6iY9BOm4stOQU3
         UUOmmWOszFBKzuTe3IE0qfCMJoEMhYqf/LShSHcz1E+uTz2k5HH+lbdOe5fy5plxap/W
         8xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=ZftIvfUGaY0MefR7tdcFxw4gwBB/q/ZYNGEYqrNHDZjdPaU7twb/OnfxsT5oU9wHQK
         fQQNpTDVc08tp2ImIyJsGBdXqbK6vsBu3MEqXp8Qa2xzZDOIWRNq9WY+SLDBaYGrabe2
         eXUrrUyAbzjk6o/U8vw4sxfE8jlB447HrCQqe6EPPbAsZLGa9HJxIgyB7c3xi7TjkmuZ
         nWjrc0ZrSkPl4HKIpHk/XFzIp61af0FcsUTlLn7Ux/cdBqnfcZziBim8DCwv2bCUuTg8
         nou5xqwayjstrkYZqQHgxuRUWzM9IHMCeQafd7XOVsF4m//Bo1xhf60VQw1SnTQhF10I
         WEDw==
X-Gm-Message-State: ACgBeo0SA9wk8Yrx+JUtVmD/j/ZivwPwfwVUsHH4Od6eOZ0zx33C43/l
        FOTkeO671xq0hKSL+q3Uwv/6/M520agxTdEZeqY=
X-Google-Smtp-Source: AA6agR4n19Bn6PFoFfzIiFJJQk4Ydkhl5NL9ad8OwcaBoueVIZFTImeyGm+dfd/smGqUJBBF6YIedvcBGqTAi+HwLT0=
X-Received: by 2002:a05:6808:1442:b0:344:a466:83ff with SMTP id
 x2-20020a056808144200b00344a46683ffmr3224767oiv.204.1661342285032; Wed, 24
 Aug 2022 04:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:410d:0:0:0:0 with HTTP; Wed, 24 Aug 2022 04:58:04
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <mlovemore73@gmail.com>
Date:   Wed, 24 Aug 2022 11:58:04 +0000
Message-ID: <CAALJgL-GxnfDc7X2uR_MLO4ZT3VOO7Qb80txtii-gqxhjX5X1w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mlovemore73[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mlovemore73[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

Bok draga, mogu li razgovarati s tobom, molim te?
