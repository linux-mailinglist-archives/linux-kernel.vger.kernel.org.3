Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90E44664BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358355AbhLBNzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbhLBNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:55:41 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DEBC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 05:52:18 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 188so18489900vku.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FQbdCARvsIV+StGedgnGxEbIsQvvx/Dy+uqBegWfhJU=;
        b=lgkbb6fkVjP+e8lJwjCDOJNBLqt9QYknp0necwDmjCJvCn8sD7RmDy5eBl3rsYu9Z1
         6yvE0OnjaRisU1qxN+uAaPXlbj4T/ibQrrsoyWT1nzS6rU8qFl4lbKi4pKPC5CyzwtmQ
         0vyCjw6CEmzSSsElPVZWURJPZ8n1FrCeMr9p1N4ItY1sif6Bkm4wJzY+9I4D8F7OA2aZ
         cFh2w4FrUiN1KtwExkjX3MIDQolcRok7ucI/aBHXZCDTwwmtniPgnARkwzTBY6Fq+EZt
         cL1bxTUZzJOqjR8p6WXvhLENhDP9D7dyPDkau3yy6bVZXERe0zGW2gvzOkB06naLr621
         N09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FQbdCARvsIV+StGedgnGxEbIsQvvx/Dy+uqBegWfhJU=;
        b=ghFQfqMOjckM4CXf3TEj2K9ZqCIjYxkTk+odKBDicLgsoC6szredIcAm58w8jmL2/N
         enHOx5ESnETe/larkVxVcB7BFILSUea8qQbfe3MumhN5WlhAFCBy/KdhnNyazsD/Hj+T
         hF2RkCJTlRMCUvGxacivl/EwpyXnJGewVW3lePv64TSObl26pRtuU0fZN0KlaGF5lBQI
         +DW9GMcVJ4hTGuUon4P+c181v2rQGx1CCj45S+Ens9RJeHfdnc6pMSEs4GhfFP1vf+d8
         Ns4d0dDEKlRoRn+3U92lyM67JXsIFELzA7BhjOsJnDgaZcbIeIVrFxofqlBUepQvH+13
         ExaQ==
X-Gm-Message-State: AOAM531AHb2OpuT8XwomyzFv+LnNe0kWznqyrULQHEcXr1FMSihiNi+c
        gjLI7uzI/cq7Bcrd2N81NUFlNy/yCdsgNbmJvdc=
X-Google-Smtp-Source: ABdhPJyry/sgYvUgbTCpEYDiRKfnF4rL4KfIoATyo4KREZ1nmJlJ637uhRy5qdfJS/Sib3HodJOtB9x6NeGFkRvscFA=
X-Received: by 2002:a1f:52c7:: with SMTP id g190mr14403609vkb.1.1638453137897;
 Thu, 02 Dec 2021 05:52:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:e03:0:0:0:0:0 with HTTP; Thu, 2 Dec 2021 05:52:17 -0800 (PST)
From:   Rebrcca Lawrence <l.becca889@gmail.com>
Date:   Thu, 2 Dec 2021 13:52:17 +0000
Message-ID: <CABWPqJE2=OeAh35hdQpjpd5jGcnLRJ4==gdXEfeCnDFSg1-4Vg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj zlato,
Jmenuji se Rebecca, jsem Spojen=C3=A9 st=C3=A1ty a vojensk=C3=A1 =C5=BEena,=
 kter=C3=A1 se je=C5=A1t=C4=9B
nikdy nevydala bez d=C4=9Bt=C3=AD. Narazil jsem na v=C3=A1=C5=A1 profil a o=
sobn=C4=9B jsem se
zaj=C3=ADmal o to, abych byl va=C5=A1=C3=ADm p=C5=99=C3=ADtelem. Pokud jde =
o d=C5=AFv=C4=9Brn=C3=A9
z=C3=A1le=C5=BEitosti, kontaktujte m=C4=9B zp=C4=9Bt aprost=C5=99ednictv=C3=
=ADm m=C3=A9ho soukrom=C3=A9ho
e-mailu ribeccalawrence@gmail.com, abyste mi mohli pos=C3=ADlat moje
fotografie a poskytovali v=C3=A1m dal=C5=A1=C3=AD podrobnosti. Douf=C3=A1me=
, =C5=BEe se v=C3=A1m
brzy ozvu.
pozdravy
Rebecca.
