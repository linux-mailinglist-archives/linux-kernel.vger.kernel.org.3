Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090C85372AA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 23:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiE2VLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2VLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 17:11:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45613E9E
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 14:11:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u140so9542323oie.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=JwNP4rOC9kEntm8T2Rqo0JxTSnzOqMZp+/5DaHi4PykmltLbciXisgALucIlde8iqI
         abP97YuKi+/V/ojwyxtkjhm/zgwj1p69BD3KfT0hTT4B2RyxxAnGP9GorhhUPoyuc0gG
         djUBSoLo04xFocONhVFIZKJBkLmiTMMjkhGy1n+cAHgX8LtbNr7hBD7NVCwNmFjndfW8
         fYgQQPheQBfoJoHZQI3RJ/m4VUAeTEAuYvvvdQHkd60sIKyHwlLDqvBqXL5A0Kcxyxgi
         JNmIqBiop+u1geFPkJ/4/WiNJPpfGdDj7bfj2yAm9oemB9R0wWw5oTImnF5MvaGzwFNs
         Z4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=mFuhHg+u2cNhbIYQO9cR5VQRobtJ5A5Bmp7KIR5o6sRr4Wm5ecaJZW5gBBIzFQa3dA
         d3DO2NoHKUCdgi3DvGzWx1EOV5zxV0p0DXXif51aHaNW9RqXULFu2aDpRoymt5/hmbEl
         0r9JJiC/XYrRaguuhU+w0OnfmVkLGF7aR0q2ZV9VJJqh2Qmdv+0dzyDTDvQZT66RmVcA
         /2SyOPSbPVBjwEvgiL781v69rBcKoteCAQEJWghd5N51Kqzg5ChgS5Ue3qT+GNf5R4Jh
         itoZdzUJDYH6FQ44cIOlu/3q8WzijSKnHlKsOtLJfE8ydsecSZ1915JyaecZVECy/Hij
         nV6Q==
X-Gm-Message-State: AOAM532Rnoax8JNo4mfrXlDGo0hZjsHt9Rdviqg/6tXuw3SVwrRN62k+
        5EUpD1GninUmHfoAr6TJUwUbMPvdlIDTavat+SU=
X-Google-Smtp-Source: ABdhPJx7D39/ZFGvCsfkH+QfED8kLGxHDqCG+bwaESF71cRbxN5KDi/0kWnb7oQNbRbBY053gSU7PfRKxuJ1DOP1fHw=
X-Received: by 2002:a05:6808:1719:b0:2f9:ab58:73db with SMTP id
 bc25-20020a056808171900b002f9ab5873dbmr8762092oib.201.1653858693378; Sun, 29
 May 2022 14:11:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6a67:0:0:0:0:0 with HTTP; Sun, 29 May 2022 14:11:32
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <harikunda1116@gmail.com>
Date:   Sun, 29 May 2022 14:11:32 -0700
Message-ID: <CAGEpkWqovQCi2kX0iDXno_rUrkHV0su1h1fmCn897SpbyKLqwg@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [harikunda1116[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [harikunda1116[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:233 listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
