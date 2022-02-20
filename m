Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56464BCD92
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbiBTJ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 04:26:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243514AbiBTJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 04:26:46 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945A377EA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 01:26:26 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id g20so14478179vsb.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 01:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=+g+XOEnZDMt0XAPiTITkStc8VlKT6qzNfRpqfetPRlk=;
        b=ENqHg7DkgLkZXvmVUETa/EXG0BPe9JjcSGAThRUZddrOyY/CT5iBulvcdQEft8csFp
         4J2XOzmE4JC9mD+BKWxPbik/9DduGLkjncMb6Q8g4pqzZiJa6okNgeD794ffpaHcCUtC
         cqnbxHNjv0J2lN1eGO7GrjC2C+dePw38ZFaoDZRTYYPuLIMMg7XnY6ABC072dPkWX92B
         RgZ3ZF6rIPRL18j28SromkEnaLyJ+tEvt9c4eIFK03LT5RYGqqcL+XRrIio7YnhLCm+P
         jw2pAAoCuybJtftdw42wDaPQvkCiKB1zZoUjCoNvzKJxnH+/NeATINyc458f3ShU1C+N
         AAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=+g+XOEnZDMt0XAPiTITkStc8VlKT6qzNfRpqfetPRlk=;
        b=KDAvQqWoMbaAXkqcdfk8EOmAjBoVe/7n5af1qHZwuyfEdv3+6HCUrQ99MKJYGVfcOu
         rpsynoJnEYHMz2Tf6Ekzo3jJALxFPevB69H9ix8lttJk/1WoaLqhI/SdM1KyfSWX9KhR
         hlFN5CePJ2VQH4tan0ngt0hKqco/gA2T7VmYhgtWc2XKYZT9NcvzGu5+n9vKCMukyE+X
         D0DEzphW/MXc62qguphwsCTBGWxzB+/tiafVuUfUNYgc/25wyTDjdDoqhvjCRmfEoL+z
         S/hjEZUO6CvtIq/EkKGBj08lFHO6EIJsWB4bbU3c0JNsmtuSfwaya/e6fUVlKkBh9e3n
         H4Bw==
X-Gm-Message-State: AOAM531LK5Rm00Ulu7sZcSNnkV+MaOXW4Gy+wWtiQZqtKkF+GKoba6++
        dCum6O0qZA7NgDArFC2AeOplEmDeOq5OdEtd3QA=
X-Google-Smtp-Source: ABdhPJx7+MJhwW7aBrzQCRITbAXW/Ug+/Eb9s2fjdgeyGEaMWj5oDwM6XcQb8XTu13C8vXtMgwKVQb/CWMlElWT1HOw=
X-Received: by 2002:a05:6102:364a:b0:31c:1996:8843 with SMTP id
 s10-20020a056102364a00b0031c19968843mr2870856vsu.31.1645349185562; Sun, 20
 Feb 2022 01:26:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:d20e:0:0:0:0:0 with HTTP; Sun, 20 Feb 2022 01:26:25
 -0800 (PST)
Reply-To: alxqzn@aol.com
From:   ALEX <alxqzna@gmail.com>
Date:   Sun, 20 Feb 2022 09:26:25 +0000
Message-ID: <CAPWn1OtS84--myXLoh5MXbx1_a_unczms5qHtwfn+X9x_NFkew@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2b listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0009]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alxqzna[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I have a business proposal of interest to you, contact me for further details...
