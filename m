Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC847C100
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhLUNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:50:18 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:39921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhLUNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:50:17 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEmtx-1nFLem2FbP-00GGn7; Tue, 21 Dec 2021 14:50:15 +0100
Received: by mail-wr1-f50.google.com with SMTP id c4so27078746wrd.9;
        Tue, 21 Dec 2021 05:50:15 -0800 (PST)
X-Gm-Message-State: AOAM5312MLLDQ7yejLPyWfrf7Kv80XAo7UN8TZTybaMNN4ZVLSKdhvlT
        419xQP+fyDQmczRwZjsr46g367FK1XBCZOwsxAk=
X-Google-Smtp-Source: ABdhPJz5oNXt5Ga1PydZPMRy0cK9JxZy2wOJ3/4MRzLYmzgRmyDbJyE5bMVFLmoe3iAC2lHRt7T5hp/Dtgt9fwgbvDU=
X-Received: by 2002:adf:f051:: with SMTP id t17mr2750920wro.192.1640094615142;
 Tue, 21 Dec 2021 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20211220211854.89452-1-nbd@nbd.name> <20211220211854.89452-14-nbd@nbd.name>
In-Reply-To: <20211220211854.89452-14-nbd@nbd.name>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 14:49:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3jVd5VmsRB81CuFxbjwVwVrisicsjK8VtN3saHsto-HQ@mail.gmail.com>
Message-ID: <CAK8P3a3jVd5VmsRB81CuFxbjwVwVrisicsjK8VtN3saHsto-HQ@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] gpio: Add support for Airoha EN7523 GPIO controller
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        John Crispin <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nSahvMAUtlEP1Kimj6u2SwIObF5fyWNnNfmjp03FIQV5BX3RcxF
 xLPUleYHS2ewqReNLDRY3NGaoZ5OuuilCXMa9q27cUs4Fs/Obqosf/Ijpiir+kQdKi4qVG8
 eBN3enx7XaLYQ4Vjmzg0/BvLOYWQF4oCHaalAGhqSCp6afK+qMmNZFhMECaZjUlFKQGsuaQ
 3b/AvCYvgOKb4ym1l5sHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bBc62t2rk3I=:jCVnudesCLNbV9j49JLS74
 X0icSKgbKcqC6vE8qWxjuAII6jLSuyHZgWi6zZVerSD/4iIcVC8CMY0NsnJtbu5ygu9RsP5di
 FRY6dkwM5GDGnZXqRo8MCrrVLtLd+HNIAvGJAhKyswNfZdJm41GYWik7hw+cL1CWnH1ljYkd8
 +hIJimx4ivRqSzFCdHpk9aWJTDaTZV0CWw2sNUcYNFaknhrh2lFGHYNd2/WnV+mHRC6jKuhYF
 A3zA77+sxJykRgLtOVZZRFZe7qam+wuklrgQZA1gW0O4XkXxKJUH1DGDEUlWzvy25YraE7RBC
 BFAbBrT0BgswmsxyNbSjZwMmAd/CrG2EUq1tEzFFZqHh5Oonk4BV6bdHLI1ztNKTxf936H9/3
 runB4byNuS9OxV5ULUhFXWEz8+Fk4N7HBhpSK+lSvoTGFYGZWBhzx5a9ux/CC1CFHRqFrueaL
 h3/RqGQ2g671MVZRPlTj4ov9xSk8zyTax6aDC8ncs7TlObJ22UXlbuBZvag28+XCeCsBBEzWK
 AJG8W6SyRQtrm2O5svMByWu+pJs4OYmZgzBeivukRSQcHfZF+0iN5EcXWLtCGqzDPYDC+pz8q
 PoW54npSHsVK34Nn8DRTHdf1EYaP5HawQWuDDVmB9MkSOUqT28vgB0YUqPs4r7AfeHflVBr0j
 dI6rQYJh0IDl6Qn6Hvj2/Oprc+8pYUxACgIgfeEiib4YdNI6F+EylkCjc96BZtarjkKIeFM0B
 tgVUT+k3AKYFJm8SdQd2rVpNjydxzpCjjvdKi0aEORGFum80cSUmaQJqsrkObLR+fkb8gxdni
 wXpiILphTHFChRWa4ihhrDfcqKDrW5A6pwy2IHqjspeYmpnDB0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:18 PM Felix Fietkau <nbd@nbd.name> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs. Each instance in DT is for a single bank.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

This looks ok to me. If you want to merge the entire series through
the SoC tree,
it does need to be reviewed by the GPIO maintainers though. If you want to
go through individual subsystem trees, I would suggest you post this patch
and the DT binding separately from the rest.

      Arnd
