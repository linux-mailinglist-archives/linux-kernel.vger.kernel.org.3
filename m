Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F244599C04
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348999AbiHSMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiHSMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:32:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC23101589
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:32:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t5so683796lfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=D5SJuTALBMW6ZisiIq4CNlEgACEGpj6SujSVeeFnOEpMZxNAmr7PmAVmgPYiffKr8X
         RgUizoFgcBUtOQn9uAft0tf71gYdN6WMKjXyFeZ9uvF4E5CwyqknDTbn22CKPt/qezHf
         +fPo6nFXGb8yZqUWeNVT7rAhI3IkJRmYjoJKac/w/09q20QKyoTWnBnM7R5F0GhxzQ5+
         iM+qTP6xRQ7MiyAOXua37nNPz4beTdjSN7xALlZ5XAiCzlR3AfaHiDUuyEfD/256qyrU
         IODIEKzb58zHUw0vqod8SjHe3XZhO/2SG3844lSmMCMRPK9PqIYIe5NCXeDx5JxJNhA4
         ju5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=Blg5c9diNTxharYOdry1eckyZWi1Gtt2p+BJfrAKGc1Nemr7W2XnL3XjDqBKYSyaEM
         e9+0jx1uDlWCtFK7mBWkEPCc3dwOV4qthGDhqzONT0yY3Mqm1HN3fdXxN5l+e37LTiob
         w9+O6m+0AhiCcCkIMLtt5I+TqHt+6TrWZMeHxTrcvzhamMs99r+jvSKJ0eU5l9M9a+4l
         skYyP8ysJOHFIL7yV6hXIMEqP66JlaQRAMBC4inT9sSaIkHSiHUsf9MCMk1AfF7vUWRl
         d/AFJtONA1sGgbocTlrJfvpuNIQegoKCM8PkXgPWM5zISC35APz5oYuNsuZk6zoegxEI
         vMWg==
X-Gm-Message-State: ACgBeo2Coht/V6DTCrZyLLhAyUiG0FL68w6mBBoMduMio2m5uIPHmVai
        onhaser7GoUosTzoIYpJlWBSDlnUEJ5ZxqArHUs=
X-Google-Smtp-Source: AA6agR58LTG6UQZmArbbsZvlN0LIZU857C0XhU4F4kSE/vRJmFqu2FP04c9fJlNu1HJJjER/yKhZ3HZ/v33YYMiJY7c=
X-Received: by 2002:a05:6512:3996:b0:48c:fa00:e33f with SMTP id
 j22-20020a056512399600b0048cfa00e33fmr2286559lfu.343.1660912365558; Fri, 19
 Aug 2022 05:32:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:3c3:0:b0:1dc:2e38:6928 with HTTP; Fri, 19 Aug 2022
 05:32:44 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   donald curtis <donaldcurtis100@gmail.com>
Date:   Fri, 19 Aug 2022 13:32:44 +0100
Message-ID: <CAOHTQhRg+pgGpYBox-hFF3mvpD5wDqtmeENK0xHsG_GC34Er=Q@mail.gmail.com>
Subject: Donald
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [donaldcurtis100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [donaldcurtis100[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [donaldcurtis3000[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Donald
