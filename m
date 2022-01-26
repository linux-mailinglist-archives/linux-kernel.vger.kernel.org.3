Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A349C936
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiAZMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbiAZMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:00:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D57C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:00:33 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so4361319pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8FlV/YHHKzs1EGyGFYr2IIA2jSZG4sumY01yYjIfAXQ=;
        b=NSDMnM9ZAtjtpE/6vJ9R7JCcPIPlpyEIGaJGPeHMxKjJ3iLmz5EBmhVt7GpBBFS/e5
         dN2NYlc3AOVp0/lpyRrs0glV7LcnVR2z6RIvx3+muZkOs28I5+p2sm1rvaHgo+EFP3WD
         XjN2+P2fgg9Ju/2iuVfarT/dZzBuAe0FDnB2Obwa6a2SAKX9N7IbhFS+7eqqoCzH8kp5
         nglbXxgu8rNBar36lsWgLFdZ+yPQMHQ1FEa3L/zmJSSP0v3RxX3b1dadEqHQBydE/kO2
         iLmzNgR0NH6fehi9GHD0UkqNcC/3YK/0/DqlrshaPbrpaC0OBlEgjtfFZcvVdvsfgXM3
         f2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=8FlV/YHHKzs1EGyGFYr2IIA2jSZG4sumY01yYjIfAXQ=;
        b=1zrlCtDI/FUyBe3DK5aTup66dq6aTyx6lMbQS0Gm7QzVxDcdarxsVyQrniquePrX/r
         V1SxEuoDIcyY4QeegXPgTNCV5v4UPrjKNAriEo/gPMSQRe3CP/m2HFFJxgKyh7lDIo0x
         7w5BEq6yieeN1ZavnqWvOI/D94h0nsgwiVbenp/SOh3cAz8boc2Qy8xXQXg2Koq26HMk
         KwDC7Cp5EEkm31h0SEVDnsCuy/ybCIRM9CvfU3OC4zMtSiiYFnC8C2LUSi6fML/y/q7U
         YicuWRQNpGCy5QARVILhjGu45r6Z4iCFm4GX8bSdHlqF8I7TwU7Vai4Vcvu28bB7fng6
         3fjA==
X-Gm-Message-State: AOAM533uQKbTBVRQt1TlJG/VWwbajOL4BBC+KCSxlndWSTFrZgHt87Bv
        Ono9K2lB9ygHcgIldVAT5GS48i6pl1rQJt/+130=
X-Google-Smtp-Source: ABdhPJyCYVTwRo7oLDEiVVSKqqbZ6GF+BB38XujH4MJLE8ItbEk0QxXbPmiwjGAp/m7bJDKTPpqlKzSLhC3gpGx2eto=
X-Received: by 2002:a17:90a:f982:: with SMTP id cq2mr8434185pjb.36.1643198432824;
 Wed, 26 Jan 2022 04:00:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:4744:0:0:0:0 with HTTP; Wed, 26 Jan 2022 04:00:32
 -0800 (PST)
Reply-To: jenniferatuma23@gmail.com
From:   Jennifer Atuma <christvianney222@gmail.com>
Date:   Wed, 26 Jan 2022 13:00:32 +0100
Message-ID: <CAKVPjxLY0g3n4Z8rAxvvL2an3yg-XwmvRA8MCRUuZ8LH9AfwPw@mail.gmail.com>
Subject: Guten Tag, Liebe.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guten Tag, Liebe.
Ich wei=C3=9F, dass wir uns noch nie zuvor getroffen haben, aber ich bin
von Herzen =C3=BCberzeugt, Sie zu kontaktieren, um Sie um Ihre bescheidene
Unterst=C3=BCtzung zu bitten, um zu helfen, das Geld zu investieren, das
ich von meinem verstorbenen Vater geerbt habe.
Ich habe die Summe von 5.500.000 Euro von meinem verstorbenen Vater,
Herrn Fredrick Atuma, vor seinem pl=C3=B6tzlichen Tod geerbt.

Ich flehe Sie an, mir zu helfen, dieses Geld auf Ihr Bankkonto dort
dr=C3=BCben in Ihrem Land zu =C3=BCberweisen und zu erhalten, wo ich Zugang=
 zu
dem Geld f=C3=BCr Investitionen haben kann.

Nach der =C3=9Cberweisung treffe ich Sie in Ihrem Land, wo wir das Geld zum
gegenseitigen Nutzen anlegen.
Ich freue mich auf Ihre Annahmebest=C3=A4tigung, damit ich Ihnen weitere
Informationen geben kann.
Jennifer Atoma
