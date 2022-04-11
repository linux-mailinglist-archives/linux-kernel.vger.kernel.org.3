Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491E4FB8AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbiDKJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbiDKJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:56:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128541F8B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:53:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kd21so12801205qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=f71Au0+fOTCPW0xWIMggzxJfG5UVz177qYSg6ljoYohDVKC6h0y/xOKrjzk+6jpFAV
         UUO5GJ52S3UjZF53KzpjxYa+0rqkWowLYS332M7s3ZB0AvyzqciAdtHWYenzf53PJpA2
         YnDWADxrjxs6SPgGJJp4u46EMOpD8Alr8CPbuftJ5b3tcSJSFAqynq5ph7lWxgw4vE92
         XAJS5PuPGOxP+34uXG/9xrOm3VRCOg/l40YV4KWu0kxgpW/VBXq7GJlhlTg73TJQyAVH
         KZCSwpGQUxUy7fUvrVnZtUgmST16a7p5npxMtH7M2VH86+UuJd8hKlTa1/Ki2xFOyxeR
         B5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=0pS34ZrIKrxA7slPKwWm9xj6xqhOO7KXq+dsLV1NhhfutAniZ5ED6UQ3qHZPoxwRSV
         8goLFAbXUlS+y9fCtYvDbFB9eTjq0JddKe0miejknFua7qtF2z04LQzwLJzgvgoAjgXN
         tcZVm6eHJqPe5osByiFQ4vxPc5Ho8tofNe5+jDJz+qcaZSz1q1mWF5dO6AkbMUBn0P81
         0h27KSH0t5+EsGfJhVqod5OucG7CGGJAsTuuDnT5qwgJjAudENHb0bj+8MyrHjf1kzNW
         r/TZJ4UDS0McyZwqJ0mOwYj0HbmvPaYwx1zbj7+mqj5K6X993WFifcFbQz8/5NNatgl3
         7zXw==
X-Gm-Message-State: AOAM532X/mEJmw/1Ci9JiVMaqjxX+0fS7tYEcdez09Y5WjuzXpde4Ddv
        dEXT6unIh3vrbx5ltCb17PM0vx69Iisfl8cUybI=
X-Google-Smtp-Source: ABdhPJzQOQ7CsHhCj2/iRdqqVadeYa15JFA3VaPvPlzyjJ1HDGQiPlUT/VpIdxjkgUfyld4bVflxknM6JJvtUvukHTo=
X-Received: by 2002:a0c:f60e:0:b0:443:d9d8:8bf5 with SMTP id
 r14-20020a0cf60e000000b00443d9d88bf5mr25907287qvm.51.1649670798691; Mon, 11
 Apr 2022 02:53:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5150:0:0:0:0:0 with HTTP; Mon, 11 Apr 2022 02:53:18
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <senyokomiadonko@gmail.com>
Date:   Mon, 11 Apr 2022 09:53:18 +0000
Message-ID: <CAEdpTfSg4bdLp8_J=VumaZdfr5S+UfyY1FBFna2w-_YYxzh+MA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4213]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [senyokomiadonko[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
