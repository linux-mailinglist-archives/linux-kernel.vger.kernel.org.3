Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0F5755EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239452AbiGNTiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiGNTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:38:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA9BCAB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:38:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id o7so4460315lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LagmDdxVXBJl9IE0ptXNNuex8JcvTCw5qDwyNhMdsIM=;
        b=EA80EXxLCWl7Fb6Vtb/416i8FCVNcyCcya9aTZSxbiBitE26UVWveyLrdWXEtVKi1a
         03jbvVOjTbYE8ka7WTHfZ/aZUI0qvjN/axBQK2ZWv+KQCGoYFcBUaCGAD4Fg9fASmPik
         XGwStUoczRZj9DODrplpoA+ElPePpN+bk/NGB2f4YUw64jb8T5INoSGYCIucfMcok1bh
         wC9Z41QdEbLbIk+OzzfLVPP2PY3fwH8tEHtgotVZfQ8IwnOMFqV2esAZZbWPRolX2WRL
         z24Is0nW0eXjZmbIMEzTvf9fTMsbaeu1ntUdRM8tjFePVUZgQgdy/L8h+PnVA3FVBWns
         9h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LagmDdxVXBJl9IE0ptXNNuex8JcvTCw5qDwyNhMdsIM=;
        b=OaDIpBL4XOj4/Hqaggdq940unwgrAyzL+osw3z1/JnjugwwqnEMV0w9AsBYacVJO6Z
         CU9hGLl57IazBRLssu+xxjBXZ72NhmfXqQI9QkPCyjkvhADFr2P76cWGiDtdKF+CieVu
         qm8PLBxRZLrJ2k0kYfH7TShT1wlBQJfYIDaAMCPC0cL9+6HA8matUy2EMWV6D3M5xwbQ
         FQRLKF60r/3OrbYG9585pz/hiCFQEfCgxS+fQuWaQLf7j4dA3h568skWQWENMPwGSfRG
         3g1ftiFFGKSPm2uh6S6Olc+sFOHRHLeCfMCK1Wanr+2VGVSPr1Zqc2/xFoGkyDcrNZS9
         VUIw==
X-Gm-Message-State: AJIora+aDfp5vwIOibdyrlxYLGkyzxo9hCaLowuKeLPFWoZLH5YQnROa
        ZapS5lBg+cVrM9UZGhiU5kvPYCQ7UVtyZlM33V0=
X-Google-Smtp-Source: AGRyM1vawfQe4Fw991wNGcVa38UmAsoPcKfIXFQQ8PNN+OyythZ/hVgs7LP6ZDwcZv6241BAzzaXW17sNud8SRsfKAU=
X-Received: by 2002:ac2:4f02:0:b0:481:43a8:e368 with SMTP id
 k2-20020ac24f02000000b0048143a8e368mr5831128lfr.65.1657827517820; Thu, 14 Jul
 2022 12:38:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3a8b:0:0:0:0 with HTTP; Thu, 14 Jul 2022 12:38:37
 -0700 (PDT)
Reply-To: rosewe999@gmail.com
From:   Rose Webbe <piusclay@gmail.com>
Date:   Thu, 14 Jul 2022 20:38:37 +0100
Message-ID: <CABeVQO+bZtpvyaT8KvW4FgW7XJSH62RFuy_L-mky8y88gOksgw@mail.gmail.com>
Subject: did you receive my email??
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [piusclay[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rosewe999[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

-- 
how are you doing
