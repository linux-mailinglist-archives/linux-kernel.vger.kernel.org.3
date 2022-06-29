Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569F85605CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiF2QZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiF2QZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:25:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41931908
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:25:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x20so8984231plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y8ziZDNWSGpH+caflqHgz1XdoUi/eUcpFf4wGqujwO0=;
        b=iLwOCgKaw4ULiw1MtL5kj3jncFtkSo0dtZTJxeXcdNaSrLNJUmSQEkXfIEh8JYqLZ9
         MeL9BIO5q2F9ruADm57A4XbEiahrpoIIdNpBe7Nm1wsxfSLjViEmlmjgebFpUbRvpxAy
         mGXn+cdlwukdxXA3u8vl2GRcp7bnvff7dBhCGkWbJTp2zeSRPGUkWcHtVQFDI5lRolGP
         6Z8Qd79M4QNSBwYjvDGFgtKRuLILYHhwKXmVI4n6GXrAbglySXwr8AXE1sVYuWMnb93w
         W5KsggXbPSdfpnaoYmlp5HYyXhlpAlAknzL0fiaoLTPJ2fmPCZlBynzpPUiiSewX8wQf
         Fjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Y8ziZDNWSGpH+caflqHgz1XdoUi/eUcpFf4wGqujwO0=;
        b=HkR0n2yf0JnegRz1k/MaWS0ZU3Mfz5rTpgJFJiJPE7Ml6OQgINjEAIq+5t0uhU8HL+
         WqpmOd5uWuE+M5+Fb3JqMmhoVtC9E/mx8OYxRM8tNZ7yLmmYOUvXN1ex4J+7uxDO1o9J
         DJ7wpF25r/eJPRritDx5813P423yH9NSvTdBRRrVe6Sp2ZFmWNXJXXXgv4Xpari92Gd6
         cxD/QwrR3A+J72H9e504E9uTu8So39i0PQiZHCocQLGwaKRYFvkZO7u+cEYRsKE8ZQEN
         wgMQNuYGVZbcesqnM4rI14TxUG4xFi2mvIAWZzAP0EGVlwFe8WMciaxmEhBntspUIVIg
         g0rQ==
X-Gm-Message-State: AJIora+bFMDnKmCU2SvkgGtNqLmZyMsTJvtWq+tKzMe1Az9Vfc5XvgtQ
        B3+xGNSGDRCmmz9iTSSkfmJ5tVBICGbxThKXpKA=
X-Google-Smtp-Source: AGRyM1uoyzkBz7Ghe9R77ky9N7uumZUYdjrZb2Zm6IYRpoLAkSy+D6lX6dWcm69jUfsw/918TJAB8aurrjaB7teU3eI=
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id
 l15-20020a17090a408f00b001e3023a2370mr4705376pjg.84.1656519918759; Wed, 29
 Jun 2022 09:25:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:be02:b0:16a:61e9:b6ad with HTTP; Wed, 29 Jun 2022
 09:25:18 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <akouviayena15@gmail.com>
Date:   Wed, 29 Jun 2022 10:25:18 -0600
Message-ID: <CAAk+1uVQOaM2BFLLD6V+61tZ7ZU_oZjtfPxDP=0DUASc2FgcdA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Tervitused
Palun, kas saite mu eelmise s=C3=B5numi k=C3=A4tte? kirjuta mulle tagasi
