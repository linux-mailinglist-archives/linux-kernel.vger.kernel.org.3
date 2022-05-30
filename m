Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36F53855F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiE3Pt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiE3PtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:49:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7395A06
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:08:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v9so11882754lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=elQ8ovHeePfEyvDpZZSAHdlwsc5opTR17fDgZ+MZlI4=;
        b=G+JEkGkIb/z2sNEqJCYGJ5wLRAXy//9cmj/RoePJ7laPmY0gZ4OYlxNknCg3moq98z
         y6U0lgHJhFUQ0vMegkZIb5CYNOrFMYki411WkR8w5zDt/9HiWVflEvNqAJkWsMl2+ggs
         kMYsVR9Fe1HGji9tosS7J9uH/Runp+nrl9ShYrsck9rbeXsHI00FferGMhteZwMgC6iV
         +pDnnOJZqCclhJ7SGNpAX/lbIAtAs/t8GbA20vNg503jbfdUjNN3WoehCNJJK+42ZohP
         AEU08vwC3yWm8qErZJ/4Zfdp/UZMJqLqy+Qlt3VipMk8TUkHLeC8RIDBhrZMoqwFyrIi
         d0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=elQ8ovHeePfEyvDpZZSAHdlwsc5opTR17fDgZ+MZlI4=;
        b=1xGfbi8RU6uQP5x1s3kNIZYY2glaYywruGex3OCT9hRGg6jbYPtUTJbZWoAo3iIsDv
         8YjSgPilFJlHkygSu5rOncCKncADXSQcrdUS1Je2jQDLdn6p+vIqFtC1fN1cNRNm9zpq
         TYHoD9/oSylfMk9HVyyZ3KmUIiuAdG1Mza0aGXBYOBYWewIPZBQMVYxg8UbAqgn7j3cR
         +KtFlL2qXf+zxzLh6rm8QYuyO8uJ83+0e6LFv/0uZT7V5x4TRptjB2pmyT8ZxOn6XH+N
         9XHG2zLZcQyDaXXs0WlxSBeyAmcxKqm4aV0v10Io4UHI8+q0xJSpaDyhWsVPflA396hB
         tuIg==
X-Gm-Message-State: AOAM532BzFpGdvuY8L9cJrK/RxKfF9BiiT3ym4EVPvQ57lsJpg38JfNt
        XdkHuWgxZl8InCkHWr40gU7tskHBRAAkl7+yRdH/C6lxmdY=
X-Google-Smtp-Source: ABdhPJyHsNO3LLF4JSv9dzL2OwtWrQM4gX3+OvNGp4DwEofP0/d+TQwE9+eZrUwBynCMmSXZc6ih41yUX6EI5DPoJpg=
X-Received: by 2002:a2e:58f:0:b0:255:4e2f:a7c9 with SMTP id
 137-20020a2e058f000000b002554e2fa7c9mr4351334ljf.127.1653923315486; Mon, 30
 May 2022 08:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:561a:0:0:0:0:0 with HTTP; Mon, 30 May 2022 08:08:34
 -0700 (PDT)
Reply-To: sgtkayla2001@gmail.com
From:   Kayla manthey <sonouke.victor@gmail.com>
Date:   Mon, 30 May 2022 15:08:34 +0000
Message-ID: <CAA+ANJ+Sej9gErPw0qduhg64mYCLVvDVTMuyEybNXLN48mN8Uw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

-- 
Hallo mijn liefste, ik wil graag weten of je mijn vorige bericht hebt
ontvangen, bedankt.
