Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632555B41A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiFZVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 17:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiFZVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 17:00:09 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1557D62
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:00:07 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id 184so7275385vsz.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gZjULo1j7ebY8Ze0HsuXWMqQ2SJ6jScpdPHRTlPBUPA=;
        b=McGuEJuW+7MAUfrCySK8qwRq1IVWCT/PSYnazRTVEL0+UTwb+ZeMlzjgSD63vwkvMQ
         VVu+6ovaOSkdkdLJHRaHB+t52VOr5Yq81GO8yNANTJwPRxqMybP+DFkZnFj248QCu9st
         hhod1FYJsFeNklQBtfK3pvpKa8AsLvtsgkRG0/mk+rzVYlxYDmF5rwSzRV38PDYm0EHz
         TW0axdK/k3LA74zNp+6YxvviYKxlDa/KY9tDvlGFhNHovylOsPZqdHzoc1ODcVjnJToZ
         ij+gOTeJfIEYkF5ZUpziF6/tZrRR8WtGURDpl2qRHm9s5wC6PJ4XKQD3YTlhawabhlI6
         C1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gZjULo1j7ebY8Ze0HsuXWMqQ2SJ6jScpdPHRTlPBUPA=;
        b=W6Ik/Pdzo312BqiD4Z42RkfrDaeb02lFadrrjHCq9iITvXC03VEYPAyF96g+xOnzI7
         fTjJwTcjovzPcHOUGl5kCw6uMACZKot0+dWPVcpUCrtYG23YA64y6qGHGNEwM+0UGz/5
         LtxdQcT13Mp5iged1Hrh+0Sy0cXWHz1ZWpgfYjRMLZhRztKc4qwQV5M33jOCfEl7wBpf
         BZiUzaC6ppmzp2sCJqxbHZvHDeFUdZhfEynJmOxug2YbpC/RTrJDxh9CdP4eaapXZ1l6
         pQZy1s8mhjVikB7g7kNONB+7LIWDfH4zTwhl8FEZfZeVwbBzkB9F+A4VGb4UAK2UzvUB
         WFZg==
X-Gm-Message-State: AJIora+3YJMz0gTB02YpVKjxpf7V0XKXTzz0qd6IKVP8Knka0IP/4NXu
        e7lnpz29Le2DUPE+KxnAI4RkDGURLK9837WB2zUXUjdGiyc=
X-Google-Smtp-Source: AGRyM1tIi7AwheiB3Fda0nfyuD2zgfrxDzT3Nhn8AyV4ftSadiZv9E83Kq1We6wYML33kdqfkAiqu+9/NmfEL5762gQ=
X-Received: by 2002:a67:ca9d:0:b0:354:42b5:20b8 with SMTP id
 a29-20020a67ca9d000000b0035442b520b8mr3163239vsl.60.1656277206824; Sun, 26
 Jun 2022 14:00:06 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 26 Jun 2022 15:59:56 -0500
Message-ID: <CAH2r5ms_jsG7KpPzYyF3jnW+O3c191fR-nY+GT51hDa6b4tb3g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: nfc: drop Charles Gorand from NXP-NCI
To:     LKML <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Mails to Charles get an auto reply, that he is no longer working at
> Eff'Innov technologies. Drop the entry and mark the driver as orphaned.

The Documentation file for this driver
(Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml) lists a
second maintainer:
      Krzysztof Kozlowski <krzk@kernel.org>

Should the maintainer entry for this driver in the MAINTAINERS file be
changed to him?


-- 
Thanks,

Steve
