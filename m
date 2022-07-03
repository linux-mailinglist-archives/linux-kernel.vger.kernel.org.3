Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684AC564917
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiGCS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGCS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:27:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A212702
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:27:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so4271382wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dUKCLz3Nb2t7edfPr776AE7gmnux0cfRHAVMKkAI21M=;
        b=YQa8dCC5P2KhnWLxs+F8cQjKca7Vqar/t0VvCH2v/lsFr9UxItxIK2asBzL3dxeeYf
         LDZ85xNEBIlfFbB65eiwcb2v5Rpni/8i3p6YPdbf860gDuwUVhUcx6eFJeLn+a7FwEqM
         0u0RoQLT/s0khVguiz58vpptg4ikF8EBHZN/9yWXoczNy6R6aNVH6nh/SCb4132BlsxH
         v59E+fCds+kYtAUt0KShQZ5anAdE82RBysgLsrjkZxiTKsjM0W8NQkzb/GbhEH23Ojg6
         dDkQboZ6uVsIjyDW3sl8CdepVcP/x2fwFsi3THx8QbZX6JIGw5C/m/cqc9XGWeTB3+N6
         IgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dUKCLz3Nb2t7edfPr776AE7gmnux0cfRHAVMKkAI21M=;
        b=zGgg39Nt2urTlASFItD6mQBHxQPbTTSiTWMIX+R9SmA651KMzfxpCjOUsybXF2hftV
         GHzvMdIMy2iANxuognsJgOxibtue9eZIhw3XMQvNvjRHQT4FeVgzpgEvT2xbhK7k9E3A
         BrBZYSOST/L1Ki3BP9O/uytNzdy72zssgZhBKkDdU7C9xXf56Fw07rMLcUwKC+hNauN7
         M/WGnv7Q2nn6jpzH2Kqtg7CvQS4aR0QQGClZLp0n4R5W5pjuZhEirks51XI3Q0YhHDRY
         R8x0jw/GAv4zGWJwURu4+sy1RUPH9OBx41o3+0ZM090NFGKmYkcbRbtObZtz2npLXTjS
         nDLQ==
X-Gm-Message-State: AJIora+nBMZ+hKRu3J0ZdxdCrvNooHWGy0W5V7/NR358M1lPxLRiaghc
        iMcJ3lUxMOIZ2JFpQag+jtE9xHuDSfFHrgvgUkI=
X-Google-Smtp-Source: AGRyM1s2oLLMACDx6xhNaqQB0zApY/hfz1quW0duxDUYvoTOKNxfZF0+8M1/BFR2Z2eK3oGbg7+dwCvnK9oTGhW9hZs=
X-Received: by 2002:a05:600c:6004:b0:3a0:41db:aae with SMTP id
 az4-20020a05600c600400b003a041db0aaemr28141829wmb.171.1656872849925; Sun, 03
 Jul 2022 11:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:600c:4f8e:0:0:0:0 with HTTP; Sun, 3 Jul 2022 11:27:29
 -0700 (PDT)
Reply-To: sarahritterhouse60@gmail.com
From:   Sarah Ritterhouse <naissifou@gmail.com>
Date:   Sun, 3 Jul 2022 11:27:29 -0700
Message-ID: <CANSd+uWBqc9LJVtE1R5zOY2dbBw16RbX5s19XJ6xKLx+q745MA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am intereted
