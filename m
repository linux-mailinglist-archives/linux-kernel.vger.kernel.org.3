Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21D258C7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242395AbiHHLyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbiHHLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:54:33 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3037C1C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:54:33 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso679638ooa.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=17gFLvzgLPNcrQG8yZh78YHLKjibiE9nN+3c5XWj6LY=;
        b=VFgB/7/bB4u1cdGnapBRhQBSPJazhJ+nR4m3MXsIlb+bEeI6jyr++Tj7EewNOXB7fJ
         Zb8WIuN2qKoDPvZDNLeAWGbFi8Kz9FUpVs6eXkdY/F8J94bU/m5nOkqrDKgLAs3qULSi
         IRIEq9hx55tBc6LbqPXzP8xnRr2LtIafxoZlI69uxs0Bt9t24eRctJECVpKaGtgs/edQ
         /Kzd1dHkWeICWhfuJTC40e2rvNJUXxVlX6mTeIoSuJUKuoYfEDM5db8ymCFw3OeBJLNv
         GF+krE7hZMBugEPJEWlXcC2w7otqVGhrfgZpi10a1rHHJJ6R7tFZFjuOrlnLCanUkeeL
         8fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=17gFLvzgLPNcrQG8yZh78YHLKjibiE9nN+3c5XWj6LY=;
        b=Be/dLITnuRnItKJL+n38WiaR5fd30maG2t1xkQlNpmn+2MQHZLYs8ZwyICl60KqD01
         NmMEJBwBTytFr+fRGO149I4T9FyLqnUknTekhV0VvCOkaqg8Bo4eF3N3tdmByJ5EV0Ub
         aHZbY0AHzRKdWeOu8W4hygEUe4T4AaQ9TN4IoDsetibnfPifsS9Yw4dEXEOHZSJ9i0Kd
         EV2035qXs+o7joBiJum0wFTJDZNJgXTsqq8HaVuiKZcvhMILBzJ/2cCCUFE9iDIzuHya
         WrZFKvrrMvKbBntwqT+KEo7E7S48ofrydDnlEfWK5DRbvh/m2BKsEJoFThwYPe7BBaBs
         0exg==
X-Gm-Message-State: ACgBeo342rRGXP/Bzm36K4kWONsAancuWvoXdWx2YtnPSSnB8FDYVLDL
        emAEUoxt7qjZIi3yUHOmNqTk0KGb0E652A0cRBw=
X-Google-Smtp-Source: AA6agR70c1Gr53xaAvF0odG4T8n2zybniaN5i75SOckvSxUSubLUsXMjoTi9p6++jF9QYhZ1EjhbLrtpZMXTzn6Z56I=
X-Received: by 2002:a4a:4917:0:b0:442:42a9:19af with SMTP id
 z23-20020a4a4917000000b0044242a919afmr6432133ooa.38.1659959672471; Mon, 08
 Aug 2022 04:54:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: stepanchernovetsky@mail.ru
Sender: delamoahcharles@gmail.com
Received: by 2002:a05:6358:1083:b0:b0:408:d9f with HTTP; Mon, 8 Aug 2022
 04:54:31 -0700 (PDT)
From:   Stepan CHERNOVETSKYI <noraabdmanaf1@gmail.com>
Date:   Mon, 8 Aug 2022 04:54:31 -0700
X-Google-Sender-Auth: f9bXseNeRvwhu9m-6rvjwgd_F7g
Message-ID: <CADwwSp__AXhzNAhoQ1GEEuxxTe0=frYWrmJ+1ONG-UJnR8Q0mw@mail.gmail.com>
Subject: =?UTF-8?B?SW5mb3JtYWNpw7Nu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Querido amigo,

Soy el Sr. Stepan CHERNOVETSKYI, de Kyiv- (Ucrania); Era empresario,
inversionista y fundador de Chernovetskyi Investment Group (CIG) antes
de la invasi=C3=B3n rusa de mi pa=C3=ADs.

Revis=C3=A9 su perfil y parece interesante, as=C3=AD que decid=C3=AD escrib=
irle y
buscar su ayuda y asistencia, despu=C3=A9s de que el ej=C3=A9rcito ruso
destruyera mi negocio y no hay actividades econ=C3=B3micas significativas
en mi pa=C3=ADs.

=C2=A1Realmente me gustar=C3=ADa saber m=C3=A1s sobre ti! Y espero que uste=
d tambi=C3=A9n
quiera conocerme. Si es as=C3=AD, estar=C3=A9 atento a su respuesta.
"Con toda mi sinceridad
Sr. Stepan CHERNOVETSKYI.
Tel=C3=A9fono: +380 63 505 7616
Correo electr=C3=B3nico: chernovetskyi@chemist.com
