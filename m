Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0F4D8B12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiCNRuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiCNRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:50:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99D13F10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:49:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 25so23045070ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EaUHmdZ87qFbfpgGvP+lfvqYtgcNelL/CAyS1EJnQ2E=;
        b=EUR11CPUMpXhpTUHlXB0wXqPyg2vosIXnDxkyMIW8eIBMcXoDugOkIa+FJDSk7xz/0
         6cb5Ezxi+FSbss/jEWINb2mZrZXDkBYYHeH7sgRFtinc9T6V89ZoL6lXzOt+WT1hxK6L
         Nr6+W03u/HnJ0a3SugQQCvKPtuhQy9WCvQm9i7uNYimE8gJ2zg7pN1xhJ1HYZmKBGpUf
         ZnetaLPDEV1Mv5Oh+Tud8iLVyIDx1Ohjo82lOonXsv+YWGpIenOcDW/nxq7fItJg4NlB
         8efECk198MOGYApyVBDh3xi13Nl57E6k5PdAFy7iEVNsPzK6SeLCu6XhnOrFb2mRoVQg
         Bf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EaUHmdZ87qFbfpgGvP+lfvqYtgcNelL/CAyS1EJnQ2E=;
        b=d7/zPc3c6yp0bu4As/mXwxCKpaBFeGVy6SXBjaTIQF2A5syYHepr9GYgHYgjM5RVXx
         DzivtrTW6VCeVkeYSEjoQN+JtLhONrcl+RXq3o4oPQMF9l2mArNxEfUGzWJz5asHE77V
         A3kSWOBPoeI77aY1OLp0ND5W3ZVXZXX4OQ63eCP9JH2D4ix5qkX6QLen2h+0Q7s2fSVP
         yBjHCTxL9EQqw1deNowuycyk2RtSiaC627DcJyaeoDP1lYJhxEbbWch3/8M12tpyaclc
         WxUGgfZfwrLd2SeVYs94Ge9vyd9swW/cbmaR26LdkJYJQXqB8LMEK2WWOoeTq5nD8SLI
         q50g==
X-Gm-Message-State: AOAM530HXO1AreoS2vKiYg0GD9iQB+DbvAAqx5gmnZF4DrQTdU8WFqJD
        r/yd3zHz3k0Co3gy5vkHzYmqOHbkJ8RKuGi5hBQ=
X-Google-Smtp-Source: ABdhPJz7IMJnBbK+pvnUC4L7dKw71SQklsjidlV+zJsFMzfavVN1MqeCZAIAS/RAvRSM34JphGLhpbmbiRUwzXqt74k=
X-Received: by 2002:a2e:a554:0:b0:247:b65e:74c2 with SMTP id
 e20-20020a2ea554000000b00247b65e74c2mr14924417ljn.328.1647280171683; Mon, 14
 Mar 2022 10:49:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6289:0:0:0:0:0 with HTTP; Mon, 14 Mar 2022 10:49:30
 -0700 (PDT)
Reply-To: db.bankdirecttg@gmail.com
From:   "db.bankdirecttg@gmail.com" <mdialo008@gmail.com>
Date:   Mon, 14 Mar 2022 17:49:30 +0000
Message-ID: <CAFmzXQSS0F5agY4an4y4ic5sJLwx0VDVRD-CHYr+-RNcyDjWaQ@mail.gmail.com>
Subject: Hello
To:     mdialo008@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        NAME_EMAIL_DIFF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Irod=C3=A1nk el=C3=A9rhet=C5=91s=C3=A9ge: 2554 Road Of Kpalime Face Pharmac=
y Bet, Lome, Gulf.

Ez a WU bank igazgat=C3=B3ja =C3=A9rtes=C3=ADti =C3=96nt arr=C3=B3l, hogy a=
 Nemzetk=C3=B6zi
Valutaalap (IMF) 850 000,00 USD k=C3=A1rt=C3=A9r=C3=ADt=C3=A9st fizet =C3=
=96nnek, mert
megtal=C3=A1lta az =C3=96n e-mail c=C3=ADm=C3=A9t a csal=C3=A1s =C3=A1ldoza=
tainak list=C3=A1j=C3=A1n. Hajland=C3=B3
vagy venni ezt az alapot vagy sem?

V=C3=A1rjuk s=C3=BCrg=C5=91s h=C3=ADr=C3=A9t.

Tisztelettel
  Tony Albert
  BANKIGAZGAT=C3=93
Vegye fel a kapcsolatot a Whatsappal, +22892905783
