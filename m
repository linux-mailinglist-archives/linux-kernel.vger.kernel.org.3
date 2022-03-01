Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AE4C8CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiCANi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiCANi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:38:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9BDFB2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:37:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk29so3267191wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=F+Qe6v1W6dvi4gCsL6zLMdBJo6m37Lt00siMxcyf4O0=;
        b=Smc8XXZwYFL3tDqCYve8L/Sla6G73emz6AINwqB8p7xBVSopCuc3yR0CTLKoKI7OcY
         IDk4lgfCSk+peLXUkD/kHlN7gPzNQ5abUE6gyM6BfRbhvNzQhJ2XHE42g2BPeiw4jzb5
         eaM7+W0mk3yXJVtGUdthBKk7F185QKXYnllOjhE+a/f1up1j4572bjiaqfXTEreWt39T
         Y6Sec8AcM+PRBZokHRZuWxs3BKu2h69zziiCErEYLF0kp9kZXWCm+C6tHYevdsTHb0ys
         eoDqbPRz8jRRSVak1inSrOcaHWlUZVwvjBSdjRnMe77rYN9HDxXc40BnVqb8/mXTx7yJ
         bs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=F+Qe6v1W6dvi4gCsL6zLMdBJo6m37Lt00siMxcyf4O0=;
        b=q+qNb6seCZwx8PT433Rw6BoO3WHDyizUs8LIOovwxFBySVhh+7gzzqn6tDVT8nVwNh
         gP23jzp5WkIt5q/wFwURkXNzFcjlIowI0roY0T4BeLgld77CME7r9YlI/Cy3XqdWEijm
         /JTOu6zTlWPnkzS21OqfV4+K1WWVFmFY8yH4rwhwHDapjVpqrJ2bMU6wYDa2Z5MbtENQ
         GxphsZW+UOGgFKAlfZMIbPOTq0kGl0myLUfhl+nSUyz131UwuOX+DX869YpJmXN8Yy9K
         7/wksm2C0j/4PlgpWvbWXtxGM9JDe5mIhc3GE+6//H0bKR9qbxmtqyjab0GnrpiIcZar
         PCYQ==
X-Gm-Message-State: AOAM531SOvXfOacL+UnCLqIz1vuhmsaJJwFdio28Q39McFL+snWY5WU4
        qbxvih07TrlFuNnr94EqPiaQQ4fY26mAOm6xQvo=
X-Google-Smtp-Source: ABdhPJzeSZ3x2aVFKfb1bNRBw6wqg0HKzgVHi8fpPBZmoyhxCTENRv3LI/p4RhHgKi3wmWsoy0wv1AjWZgc2feZ1ANo=
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr19493031wre.276.1646141865070; Tue, 01
 Mar 2022 05:37:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:ed4e:b0:17d:fbdb:af08 with HTTP; Tue, 1 Mar 2022
 05:37:44 -0800 (PST)
Reply-To: adamaiwo23@yahoo.com
From:   Adama Iwo <adamaiwo@gmail.com>
Date:   Tue, 1 Mar 2022 14:37:44 +0100
Message-ID: <CACDM63SQLvmxXZAyZ8peUwte3dLPpHzY79KGuiO13yoo8K-axg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
How are you?I am miss.Adama Iwo i will like to be your friend
please write me back on my email for more details, Thank
