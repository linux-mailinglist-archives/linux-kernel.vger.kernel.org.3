Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA284E6153
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349359AbiCXJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347493AbiCXJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:54:03 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED129F6C2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:52:31 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 134so2236513vkz.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=G4sQ6e5aBfiiUy9SDG53wpKivSFmAkOLfyuZPVcm0UUefA9l/UymTGDJqQycKQtEZH
         Fa39mESf8OVTjrHnCQWTkrRDAACJQ4rAxMkOas4we7oOpbfaG3qOycXwypOqIfCkzPSS
         fmlVALeVawn5Qcip8KwdIi3ddfdMgCEOdl7hW1r4tCARLZZL7mr5pGf2XndODLZwnPyx
         F5tCh11JThHtps+I0rzN3PVCoNvgY03p1eVvGsioHAQUj4Jv8DOhasC1IGO0vtnDtf34
         qCmMZnk+sb88VUMXA5EiLjmUBiZ7exqr80BoCKB2nMp4YEmq+psoJXgm83kI3l4CN7uI
         DBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=DBxpfJpQuIf6m44S0OJYb9qGQ3JxPrI/LzY7qjA1ZN17wC37ViOdec/HcXo12JsOxI
         8z06M3izcSwxjq9nSSxWc4yAd+kUkcsWMRFq8NHWL5dxkGNjZtnrq27yD/2KzE/fwxhu
         fQRDUI8AOysjb9P4wpEK1gI7MJXDAxtL59wGUyG/VwagPzrU/z9EIkmTJW27efW2y4kn
         94fT7TwbnsFoE2gmZtpflbl/8prI0O/OMG7FjXt8CqISPrEeiw1BMaDGObDoY0CNvx8l
         xxBmN41JjoxsaBiqHR1uHVsuqEANHB3nA7RGnh6/XT6ZPF6QwWwDx7V53TJUlyBoqoFc
         V0bw==
X-Gm-Message-State: AOAM532quwi9tR2HzMkfYOO0tOiKYixyDSvOqprz83gwIAXq0gj/zDu5
        FF4/Z+Zibi4EMwWqYFOF9CyB3tLU9CuKCIWPkGQ=
X-Google-Smtp-Source: ABdhPJx/daTqomSULFms92dC975WDvdiCRXLkJR/zi9lukcTJWfTkLf8La1Iwyz4WMwkG+Cym4gio+9K5M+lLr5sEZ4=
X-Received: by 2002:a05:6122:992:b0:33f:d0b0:1968 with SMTP id
 g18-20020a056122099200b0033fd0b01968mr335905vkd.6.1648115550563; Thu, 24 Mar
 2022 02:52:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:5c12:0:b0:2a3:1110:6996 with HTTP; Thu, 24 Mar 2022
 02:52:30 -0700 (PDT)
Reply-To: ozkansahin.gbbva@gmail.com
From:   OZKAN SAHIN <ahmeddiarra25@gmail.com>
Date:   Thu, 24 Mar 2022 12:52:30 +0300
Message-ID: <CAMpRB370UTP-tPSodM9s1UbewPDv_Tj2PmnkmzqtqaBk+VkP+Q@mail.gmail.com>
Subject: My regards
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4418]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ahmeddiarra25[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ahmeddiarra25[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
I'm  Ozkan Sahin, and I work as a Financial Management Consultant. I'm
thrilled to approach you and present you with a lucrative offer I've
prepared. If you're interested in learning more, Please reply as soon
as possible.

Please contact me at (ozkansahin.gbbva@gmail.com).
Respectfully,
Ozkan Sahin
Financial Management Consultant
