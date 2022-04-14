Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF87500C28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiDNLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242300AbiDNLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:31:24 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078FD7EB1D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:29:00 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k17so4236200vsq.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VYSsZAXJFvZdvRNT03FxYfigdtS1EW9aZIVl8FLZRw4=;
        b=im+JZ0CGphKLH2eiW6KMoe2q4DKqPVqbROXEprTkBHLwlget+e0Jhvi/FRqh1eCdXP
         k4kq1eSDUkPFfOZbThO8oroERgLUpB53HNHmNVfHts4aFFymUuUus9mUQESDJuKSDbqI
         F0WLBv7ELWaqPVTWgDv79rFNE+bYDq6DFD1tHnzDats/iDf5x+y9MPZUdb5cvMe2qkZt
         tqThWZ01hxx3kYOsptzAH6H61+HrrvX2RSish0o/S+9ZiujgZQAGRqF/7hNk7G1xbl4k
         qKjY+esN0SGb6FHdJQwvRyKzoxFANSzHU8giD6XDKjgT3eDbR3gt5tO4GuvUyAtRNq3j
         PYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=VYSsZAXJFvZdvRNT03FxYfigdtS1EW9aZIVl8FLZRw4=;
        b=HKUAPioC34t0G7uFHQv4OiUHgcFIx176crow1Og1ytB9hPt2AVloQbqw9Guv/KZsmp
         2Pc+Bse+DkaevLvsJFjbV2o9yNBcVRVXJ0uZgFHpZfdVf0yeMki1owWL7pvQG7EhH4eQ
         ztRYkEdfJCrNHj44eBAhIdBzK8nObAAExqAXQ16JoazmwF/xr+b027sWv2odnX8z6+me
         PTBE3Sc5DpmUFi0AKZf6K4sfCD7/hnNV15qFScsRUJhhSexQGkllI4zPKlK09+3AnINy
         INWyKM+fhcar/4eNHgO3emv7qdXj3tiwd9Hp8f3faWVa9jo5C6hONOZ1qD8yPVpi9A5h
         bQ+A==
X-Gm-Message-State: AOAM530XKsSjJ0wMVFHjdNyZCEKFMsPjtzh5J0EbVbxzXQm4YAQmn9V8
        MF8dr3bsl6vdmfyndXpnJCGXodx3mMnN+8o02cI=
X-Google-Smtp-Source: ABdhPJyzSBJbA6MvLM9lan07Ko9R4uhsM/pz3SGtYvYBG5JS5QjeAx212N+w4lzxVwY5SA/7uhHThhYOcUZx2ExioBU=
X-Received: by 2002:a67:ed55:0:b0:31a:9544:cf86 with SMTP id
 m21-20020a67ed55000000b0031a9544cf86mr1047991vsp.3.1649935739129; Thu, 14 Apr
 2022 04:28:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bb52:0:b0:2ab:8088:8447 with HTTP; Thu, 14 Apr 2022
 04:28:58 -0700 (PDT)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <barristermusa32@gmail.com>
Date:   Thu, 14 Apr 2022 11:28:58 +0000
Message-ID: <CA+gLmc8ODaNUs7o+3aj6zqH3xQRSx6K1AHX_8_jtY9BdN4=KnA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Merhaba, Mail kutunuza gelen bu e-postan=C4=B1n bir hata olmad=C4=B1=C4=9F=
=C4=B1n=C4=B1,
=C3=B6zellikle de=C4=9Ferlendirmeniz i=C3=A7in size g=C3=B6nderildi=C4=9Fin=
i l=C3=BCtfen unutmay=C4=B1n,
merhum m=C3=BCvekkilim M=C3=BChendis Carlos taraf=C4=B1ndan (7.500.000.00 $=
) bir
teklifim var, ya=C5=9Fad=C4=B1 ve =C3=A7al=C4=B1=C5=9Ft=C4=B1. Burada, Lome=
 Togo'da ailesiyle
birlikte bir araba kazas=C4=B1nda ac=C4=B1l=C4=B1 ve trajik =C3=B6l=C3=BCm=
=C3=BCnden =C3=B6nce. Talepler
=C3=BCzerine fonlar=C4=B1 alabilmeniz i=C3=A7in =C3=B6lenin en yak=C4=B1n a=
krabas=C4=B1 olarak
sizinle ileti=C5=9Fime ge=C3=A7iyorum. h=C4=B1zl=C4=B1 yan=C4=B1t=C4=B1n=C4=
=B1z =C3=BCzerine sizi modlar=C4=B1
hakk=C4=B1nda bilgilendirece=C4=9Fim
bu s=C3=B6zle=C5=9Fmenin y=C3=BCr=C3=BCt=C3=BClmesi., bu e-postadan bana ul=
a=C5=9F=C4=B1n
(orlandomoris56@gmail.com )
