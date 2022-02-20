Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1A4BCB80
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 02:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiBTBge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 20:36:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiBTBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 20:36:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB7A3CA62
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:36:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id o6so9617610ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 17:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yEjbE6lnO413X9rJwaQVrz4VUUBVdQyP+yXzCzyXOCY=;
        b=eZVMdbPzh3jGcAnDFRWvSR97bN1l1KDfM4P69bI6Ko+sKztvOXErqkgXnc8b86GYCc
         fnTs7/x1u4R8ab4KbmH0e301HNRoegPCWb4zoakLdXQjuFj6wIjrAxeJDn7BZGgyLyrJ
         s+LPnvAk6Lcm2qartM/wHaUwro3Qt3LXb1R4whvaixK7se4tdQ3utfZzM/P2CucRHuBS
         3pIfzKCbz8wbXqnenrnZjN9Ep6FK6FnP8kVQC6gheCkgBumfmPFtMrxNOzmZIplidtC5
         Rli1UdJdoEBckfp8cc//mP7qByWyZDXic+W2Zj+RLB71urLgUmQ7acJRj/wj4bI3HP9s
         FTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=yEjbE6lnO413X9rJwaQVrz4VUUBVdQyP+yXzCzyXOCY=;
        b=DW6YdW3xYsLe6sDbadWWnLKYmfKqkiEQALw7M9mytkdWDavdWPTjnMZtpWSHTmb4HO
         XmOFtQfS0rAIwcJ0JqoXOEVjgfCc0WiFQd+muNOZfXBdP6UZaNFWO1Qucz17lOAnASVb
         ctOrNbeKo+QfTv/ZClmWWjyk+cex24rHPyirgHHekB0hGxw2KOLsOGBIaspTOmNqAguq
         vWiDMu8aVkBEQVC3YafTc8r9JF3/Ug53aia84+pHtY85ZXSEa/PglzLZ0P59lmppypLF
         8P24lk++j+NUOqwhsCQOvAeCKzUU2VXWORtSiMA+4CFO8y7Ndlxwi7PV06upDSmQTbuo
         sA8A==
X-Gm-Message-State: AOAM530jKLoCGxbTvRwY0CZWKbcrlyMddOiNME9wFNhNfmBnLTWoWtVK
        stJO91+ULLMC9V5IRcHY7SEY1/bDNtHvjQoNyo4=
X-Google-Smtp-Source: ABdhPJyT3nUorOqe+NtGomFzScCitH3LCFYgi9+CnEvtHc9wWyrg1K2rWffUASW12pfwk/xyIIazTPa8Q07IfG+sSOg=
X-Received: by 2002:a2e:bd13:0:b0:246:1ff8:6da1 with SMTP id
 n19-20020a2ebd13000000b002461ff86da1mr7853850ljq.219.1645320972299; Sat, 19
 Feb 2022 17:36:12 -0800 (PST)
MIME-Version: 1.0
Sender: okg500110@gmail.com
Received: by 2002:a05:6512:972:0:0:0:0 with HTTP; Sat, 19 Feb 2022 17:36:11
 -0800 (PST)
From:   "Ella.Hazem" <ella.hazem1@gmail.com>
Date:   Sun, 20 Feb 2022 01:36:11 +0000
X-Google-Sender-Auth: c5BjaKvkrlIYaeP1ipa2iKKvMOI
Message-ID: <CACajLuuCfafK0pNy34r54tHx+9igjFtFv_8kn_bWq=E5w6g7og@mail.gmail.com>
Subject: Hallo, Schatz.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, Schatz.

Wie geht es dir heute? Ich will mit dir kommunizieren. Mein Name ist
Ella Hazem. Ich bin ledig. Es wird mir eine Ehre sein, eine gesunde
Lebensfreundschaft mit Ihnen aufzubauen. Ich habe Recht, neue Freunde
zu finden, meine Hobbies sind Lesen, Reisen, Schwimmen und Tanzen.
Bitte schreiben Sie mir noch einmal, damit ich alles =C3=BCber mich
erkl=C3=A4ren kann.

Aufrichtig,
Ella.
