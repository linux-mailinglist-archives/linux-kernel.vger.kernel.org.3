Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282A853D66D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiFDKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiFDKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:32:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690F26D6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:32:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v22so17789358ybd.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sRyoBNxqpzQeBGx+4ntrAvIX7ut3gN0OpdBOsklImU0=;
        b=HAJrJCfu+DsTg0nDUKJ0XyMdjt3uxVFBfjLKfRSqpodkrWnbpo1D3+DQZuOn3BDWRZ
         kQAPh3OGYtg91sDdf3Z/BcgUJcyxPghMdU77Bima+RCTnHqKy81HTMazrfmTQjHXzCFt
         R+Vp74J20FHYgEcKT3JH8XtMDDQ5dxbizXnmNWHra/mqBTAVq1KcJz7rLVap7I2mDuD7
         LVEf3WHy/fdfkDodaefuAd2Gjb1rx3AuiZPZCD4tO38QZXK1/+mzPnvVUDzNZn72siVi
         VhR7DFHXmjISlQF7K5pR/5spuVjjSd6PwFmjJENKnmmBm0syPwhQm8FEj0cObufKh/US
         JeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sRyoBNxqpzQeBGx+4ntrAvIX7ut3gN0OpdBOsklImU0=;
        b=WAtCazEVq6nJ0pIozUBD3uqbgd8zsITjrWFY0AfognCF58aaKTA6uF7rQyWk5VanjX
         JcW18oKcrrXO6KKd54iru75DJI0RmhALfIIKuL5Cf+jazhqaUjNFq4NOmWsqmsDgVy3D
         wBkkv4Lbx9Jo//cExJFOUQ5pgQDvwdZxLmeCuuLTJ57nF6dAV2W1rsuhb8lmedRU9Tvi
         XwmtSoiyuC54LaLbiHxJ90Yp5BcFfBkeNPyqXiE9bGw3N6+d3XLEYm0TLmaFw7GNqxC3
         2ydfWm/UqhboVxxvIhv0/7iIJ0X8XIp2uG9j2DKNT5thCn9gJ3so8TaV6aE5GeB3OXFe
         mG/g==
X-Gm-Message-State: AOAM533LhgzfLHQyi5nDLM6blnksR2f29TKmUN2VeDADWtJicouE8WXI
        PtfffANFmKQC1mt1EOR9rbxwa5ynUPsUQJcqYHY=
X-Google-Smtp-Source: ABdhPJxm4rReSkXEQ6I6ha6UKSGskwKhEohI7hPbC9zD8iPGzmfKpXHp2AF9cqbs7tGurblETay9SffIbL/xTofIzkI=
X-Received: by 2002:a05:6902:100f:b0:65d:516b:d8b with SMTP id
 w15-20020a056902100f00b0065d516b0d8bmr16186212ybt.369.1654338737245; Sat, 04
 Jun 2022 03:32:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5f06:b0:2d2:ccf:ecca with HTTP; Sat, 4 Jun 2022
 03:32:16 -0700 (PDT)
From:   "Dr. Mark Philip" <rhondamill242@gmail.com>
Date:   Sat, 4 Jun 2022 12:32:16 +0200
Message-ID: <CAMJKuXL=1f+-RHtF=Y_kxu2OWvB10JOMdnW6fLZa2iT9cz6C1w@mail.gmail.com>
Subject: Ihr Fonds ist zur Auslieferung bereit.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MONEY_FORM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Achtung Beg=C3=BCnstigter,

Seien Sie informiert, dass Ihre Entsch=C3=A4digungskasse versandbereit ist.
Wir senden Ihnen eine Anzahlung von 7 Millionen Euro. Das Geld kommt
in 2 Kartons, die mit synthetischem Nylon versiegelt und gepolstert
sind. Die Kartons werden mit einem diplomatischen Agenten an Ihre
Hausadresse geliefert. Bitte freundlich Melden Sie sich mit den
angeforderten Informationen bei mir.

(1)NAME:,
(2) ADRESSE:,
(3) TELEFON
(4) ALTER,
(5) GESCHLECHT:,
(6) BERUF,
(7) PASSKOPIE ODER FAHRERSCHEIN.
Antworten Sie mir unter (mphil01@yandex.com)
     Dr. Markus Philipp
