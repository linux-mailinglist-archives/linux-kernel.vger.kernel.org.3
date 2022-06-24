Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD355983A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiFXKxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:53:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9912AF7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:53:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c2so3900570lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=tc/9GhMGILH31U9N9aM0UY6agRe2uFnep9S8pLV/Yuc=;
        b=IVYRfxWwHfxen6ARqkX3Q+5c0coCZpfKqwKk48V3gKxJiYP2gsQIoxKHDweizWduvM
         ulgeTXQeZX7wEVxwlp0+1Etkk5KrmQ1FEVLYpQfHyw33JhLxx4Sk5ZM54dgwquYkVU0L
         9OeWgd7alZzHs62o31JijceNbbRxHT2UCc7Gax0LyM8Q3Gy6ClnsS860VBxp2t5D1WjI
         pqO8HvIgQoMIFcl10IEtUo40d+LovaXlshIPl/JS1UL2g7zM4Hw6/s0gZKLzkFOPDxlW
         1Qh3r4j+lT6tC9LXUxG7NlDph585AtlVTEIApGXyhvcDgIUVylqs+eMX1W+GkAYGEwMX
         29ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=tc/9GhMGILH31U9N9aM0UY6agRe2uFnep9S8pLV/Yuc=;
        b=roUF3ZaT/ywb3M5e6xdUmL91u6iQm/Hl9cksxTNjxddQWamHYT6oe5gOVzEwRbxrwh
         IC10402SaEmlDEXc7WowpbCmMtG7SF9jD6P+V/40+aoRRuKf0GE4e7utx1yubh4FjFMk
         zDcWm7l/8DUAQa402VGZXlw4JjpAmxKqN3KMXXH/STDeHW4CZ3gImteWIXlaTqcXNXc3
         b8tC2GjpyWkiRNQI2QYZfXxQVsCYNrJTpTEsU4zbC+bzt8wOKOzVj5vVpU9tkIJ9NXkz
         EW6wFk9wwqY7kMqdLSU/MDaCmvfup2dlSWUkyw/GuoGItMoyGOT2YzB64/gFiOzhGEZS
         SgPA==
X-Gm-Message-State: AJIora87/fLPGJdYwcbmFeEJuJRF7ljB46XVmL6SMNivithX0qjoceZK
        iAynlxM3AZlnNjltTVE/ephIvtLGMBi9iys1WJ0=
X-Google-Smtp-Source: AGRyM1vz90d1Yl00i0boWgAdub8WMOAJcPNHk1dUxuXdM+R4Abt+vmggvwpJghUtIHY3k8XlmDV9UJGyGYHObRAJNoY=
X-Received: by 2002:a05:6512:a84:b0:47f:71d0:6bb0 with SMTP id
 m4-20020a0565120a8400b0047f71d06bb0mr8362834lfu.241.1656067992713; Fri, 24
 Jun 2022 03:53:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkalamanthey@gmail.com
Sender: madameyao05@gmail.com
Received: by 2002:a05:6520:25ce:b0:1f5:22e:215b with HTTP; Fri, 24 Jun 2022
 03:53:12 -0700 (PDT)
From:   Kayla Manthey <sgtkalamanthey@gmail.com>
Date:   Fri, 24 Jun 2022 03:53:12 -0700
X-Google-Sender-Auth: S5opkfoXx4OdRmpecE_KVBtuNns
Message-ID: <CAP8oFycZujvpq_KWXPoLk9C+ZcWrbqRB-YhTfntEYHkCS7hBTw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pozdrav jesi li dobio moje mailove? molim provjerite i odgovorite mi
