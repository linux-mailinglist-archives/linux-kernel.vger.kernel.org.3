Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3F546B13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbiFJQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349926AbiFJQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:50:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50A29348;
        Fri, 10 Jun 2022 09:50:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h18so21357494ilj.7;
        Fri, 10 Jun 2022 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGxcvvJYy03A6wteBM0BcXbbkTu0XQ38OAx58GjiKYI=;
        b=I28gC4LJOetplJcM9grRBxKIYjuI5i/X5PfZAxaN2YDFflEClUrX7I7tOPOldrr7mi
         Nt86AkBx3bGtSEtMYKpxRr0mW6brtuLag0h0p8AQwzmgLf+F1WEGFbzjcZkTYb77omv6
         cR9UMBAskXtIHR97VtHYuzNBjWLo5UdcHSG05+5JWoecGDr7qzb9B0Jzx9HgWVVTK2TY
         /AU149gMGpavE/fPfiIKLBTGxHWf2+vXQTzh7sUmGPB06tDfDB4/IjkQGW25yi//aArH
         b8/VYaYPfhG/lwDAywZQTVB8V9DPf2M2kDNkl0m/O8fSdwgR4Itp4pznQsU3db1mit5F
         UBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGxcvvJYy03A6wteBM0BcXbbkTu0XQ38OAx58GjiKYI=;
        b=pvXXvs+pS/fX7ZQFQ69FCw1gF/kqjkawrjysKuNrn3SNGk6ZG0iLTxn9Rw6cE8DOTI
         2AzFUAJUj2SpZ5oDprWccQWcQM5rtzh3eV71/2x6beCdQQjDHc59WVpOUlO6UbM1k+wK
         tMovXPC7/CGsPj09IardvANnaJ+Tsq6hPgwa6/Kf+wzpvdf8zVjLgkKPeJvW+7lhSwfa
         hPaUodTEFZZqQRaf15TVLYDXLa75C23d2aH4nZU0vT6monlPa65nTkKAUA/dHHfvtFd/
         tIZ8Uvw9cJoB8xXa/ZVXCBattIdremS1e4Wg+uGQkWNKv1mQPBiecDy39sV469IitYjo
         w4ug==
X-Gm-Message-State: AOAM5306QdaHeEnx0Ao1Lyqily/aOcXuqFiH1zU0SV3P+I6XCTSxQn1G
        b+C4f1wGMcTvwkeJF914ZjcPKz6XV4d/lNgQdq3O+NHstjo=
X-Google-Smtp-Source: ABdhPJxNLHpFyPTXbs5fl264+vPRDCjkwED81P+zBTPlUV0jZd9Yas7zs7ph54LGjttd2VsxIR+LJRjm+dguQ7TFT5k=
X-Received: by 2002:a05:6e02:152f:b0:2d4:980:a529 with SMTP id
 i15-20020a056e02152f00b002d40980a529mr21205445ilu.72.1654879827513; Fri, 10
 Jun 2022 09:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
In-Reply-To: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 10 Jun 2022 18:50:16 +0200
Message-ID: <CANiq72=jEDgxD5ZWwGXBTf7q760Rb-WKF7xNmY6cJurnULSUqA@mail.gmail.com>
Subject: Re: [PATCH 0/5] docs/doc-guide: Sphinx related updates
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Jun 9, 2022 at 3:21 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> This update was inspired by private communication with Miguel and
> Jon.

Thanks for working on the update, Akira!

Cheers,
Miguel
