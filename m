Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56EF53B910
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiFBMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiFBMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:41:42 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF91D0FC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:41:41 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id u188so2118584vku.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s+1y2xmR1XuhFIQ8Y0mXlC0pPT+2h7fZM1K5yK9/aLQ=;
        b=kFRyJ5IlHh7pOr0KSIzlBpzmp0ndav916+DgYWRyRSKuARrS7Yts+ll7G57OzgsBoL
         hIrntEU3FVe3b4VkHaJ7ZCfU7gDbQbFvHuDeAlWgxbFC/wNFNEJEXJjkz1BUT4qnQ6Eo
         VEHLnWUk4mzqNhfNz1KuA9GAUo2l29ByZMGOup7kgwMHN8vMYdE4/Gy6NU6AM9iVaLw0
         FD6C9UE+8UPWXyaEOcoEo2/15HvY0Dt2PpcBGeHJ/X8LlX86llwI3304Ikjg2KEM7J76
         np+x46b0xqmN9IExTkHUE3fXjK2pPVpwh81pK3SMrmd/7FncgMyTXx/pVGI9hmVPMoRV
         dPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=s+1y2xmR1XuhFIQ8Y0mXlC0pPT+2h7fZM1K5yK9/aLQ=;
        b=dd5ACFhiG91zyu2Kr43VvufZuVSAex7dGcso3VCJnTBvg9S19ghAJLPaRpumwhCMMi
         1wS81d3HEnABbX/xJfldsGq2yzE2jTx6W30ryBcS47IoNmfr+Bemt2AiCXnh6KpjI9fU
         sNyuCmreX/XY3g85GbUBLgqJl5LdnWuTC7eNFJcA6dyqJt44IiZULRimFb7kYT7qi5xs
         d9+jQkQCHrlbfwaidx4wUzpm9ukxV0usNHUy6jxYrT0Wh09SxMerD+rikl1c7kpTD30c
         5qKhGJE9PDE09S51XJVQ9anJIfeKUIF0Jyzi8AcGfs8FubEi6h8EbSU2KET3MXl+fm0z
         QxVg==
X-Gm-Message-State: AOAM530Lqmfr9PYEw8mYQlUk2hbZr/ODNqNHD04B+YoUONEmUmq7vv8J
        fWvCmSTd0wDVPgZk75rA7zrNOGUhJOZ9KkIcacA=
X-Google-Smtp-Source: ABdhPJx9z7xe58ZBiDoI8/CHZDfLMrekmdYhMNr1sT66GKPz9F2x3ZaVfQHaqjEEf3N+DfBmCuZwKmOtPEpvrP9kQMI=
X-Received: by 2002:a1f:ab16:0:b0:357:ab29:7536 with SMTP id
 u22-20020a1fab16000000b00357ab297536mr20998412vke.36.1654173700339; Thu, 02
 Jun 2022 05:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d9c9:0:b0:2bd:e709:5416 with HTTP; Thu, 2 Jun 2022
 05:41:39 -0700 (PDT)
Reply-To: westerunionbankoffce@gmail.com
From:   "westerunionbankoffce@gmail.com" <bankdirectr1@gmail.com>
Date:   Thu, 2 Jun 2022 12:41:39 +0000
Message-ID: <CACyQhy4u=OdNn0w7iDEMNAV6vAmcsLbfum2k8i+V9UmJSKtRBQ@mail.gmail.com>
Subject: V
To:     westerunionbankoffce@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        NAME_EMAIL_DIFF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_PDS_TO_EQ_FROM_NAME,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
 Kontakt v na=C5=A1=C3=AD kancel=C3=A1=C5=99i, 2554 Road of Kpalime Face Ph=
armacy Bet, Lome, Z=C3=A1liv.

To je WU bank director p=C5=99in=C3=A9st ozn=C3=A1men=C3=AD pro v=C3=A1s, =
=C5=BEe Mezin=C3=A1rodn=C3=AD m=C4=9Bnov=C3=BD
fond (MMF) kdo kompenzace v=C3=A1m sou=C4=8Det $ 850,000. 00 proto=C5=BEe n=
a=C5=A1li va=C5=A1i
e-mailovou adresu v seznamu ob=C4=9Bti podvodu . Chcete tento fond z=C3=ADs=
kat
nebo ne?

T=C4=9B=C5=A1=C3=ADme se na va=C5=A1e nal=C3=A9hav=C3=A9 sly=C5=A1en=C3=AD.

S pozdravem
OLIVERA JONESE
=C5=98EDITEL BANKY
Whatsapp, + 228 91441856
Kancel=C3=A1=C5=99 e-mail:(info.westernunionfinancier@financier.com)
