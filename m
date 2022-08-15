Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0832592F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiHONFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiHONFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:05:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4088B193EF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:05:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o15-20020a9d718f000000b00638c1348012so402111otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=I+y/ZymfRcUOa9dFnDPtZmH532laontsFG6433XUp9s=;
        b=kSmcS6Um3yRPWaJ1zC7Thzfv301GLxle+7pgbWUNRRS9MJm1CRTcTBa2IAKKkKbiLw
         r7NBfgabDwtNL0r5w1PSQmjQbVvjcFa8eZxFSUO+noyjtmj+NoW4Osv9zm1L/Inz4Sy0
         BYOD1ufM3CLy6AY5LV7HkKHVhuSAauv+Acfgp/kFrqeGETj+WdrX5EYZFuyPqBKBhuuv
         GDXJbG1Y0SIZU1d9ZjHPqO0+IgDyOTTK0CPDwUMg4K9OSbbvoRdvzqGDWo822lv4RUhI
         me3NZqrABr0fSsCT9vr2aDGsbg+sU2SggaznAnWKt6wknr5M06dehw34Uw1dx97Sto5l
         oqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=I+y/ZymfRcUOa9dFnDPtZmH532laontsFG6433XUp9s=;
        b=ytEnFBj1EwWhh6Ai1Zu65K7yAMWder8u2sIFz8NQdoF0nxxbjQ7lStbdMVpyr+GN3l
         nKdCTx7+i3QZ6x+YAyEioxIBFNZCtXyt62ZFoIWFbbM7x29duFiWsmywNkR8BHRbXiE+
         R/OaSkFHRRXmb5OHQLITXtwksmJdfX1gdaqikIugmWbgD8GjEaZD6p/X8xfx/BVXGHjd
         BPH7NziYqDcsPo1Vz4qZpO4LHvYY5j9+Rcr+fc05Du6l5zVCBqNSzyIjpSoblLyGNXWZ
         5pF1ymiM6D9yMIpRgTzJnI2fhGuoGkklltZ32Ne5LYViuXqyxWuSsaAWolZ+uSY40e3y
         namQ==
X-Gm-Message-State: ACgBeo3qVeYlZV0DnF1POBVsNoOnp2x3V2pXrQiMYOc0aDvdSbm6LUgI
        rFbmA4TS779rFZS1VZUtDVubTbyZF5AujirWMY5oNjBs1msYgg==
X-Google-Smtp-Source: AA6agR5kbSKPEBnHk0c4XegzFyNoExF9CT4sgJlf/yIRKd+Lqn3wNZsdOOhLNSDkQQZvEImQPhCA/GjrKmjPAx8ZFyI=
X-Received: by 2002:a9d:7a55:0:b0:637:1874:a2cb with SMTP id
 z21-20020a9d7a55000000b006371874a2cbmr5893075otm.318.1660568701218; Mon, 15
 Aug 2022 06:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:4a10:0:0:0:0:0 with HTTP; Mon, 15 Aug 2022 06:05:00
 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <ubabankofafrica010@gmail.com>
Date:   Mon, 15 Aug 2022 06:05:00 -0700
Message-ID: <CA+hLP9D6x5oAWD9Hk9Ned-d=2GG29KCPza+qEJJNp5SvBui98w@mail.gmail.com>
Subject: =?UTF-8?B?7KKL7J2AIOyGjOyLnQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7Lmc7JWg7ZWY64qUIOyImO2YnOyekCwNCuydtCDtjrjsp4Drpbwg64u57Iug7JeQ6rKMIO2VnCDr
i6wg7KCE7JeQIOuztOuDiOyngOunjCDri7nsi6Dsl5DqsozshJwg7IaM7Iud7J2EIOuTo+yngCDr
qrvtlojsirXri4jri6QuDQrtmZXsi6Ttnogg67Cb7Jy87IWo6riw7JeQIOuLpOyLnCDrs7TrgrTr
k5zroLjsirXri4jri6QuDQrsmrDshKAg7KCA64qUIE1zLiBLcmlzdGFsaW5hIEdlb3JnaWV2YSwg
7KCE66y0IOydtOyCrOydtOyekA0K6rWt7KCc7Ya17ZmU6riw6riIKElNRikg7LSd7J6sLg0KDQrs
gqzsi6QsIOyasOumrOuKlCDso7zrs4DsnZgg66qo65OgIOyepeyVoOusvOqzvCDrrLjsoJzrpbwg
6rKA7Yag7ZaI7Iq164uI64ukLg0K6reA7ZWY7J2YIOu2iOyZhOyghO2VnCDqsbDrnpgg67CPIOyy
req1rCDquIjslaHsnYQg7Lap7KGx7ZWgIOyImCDsl4bsnYwNCuuLpOydjCDsmLXshZjsl5Ag64yA
7ZW0IOq3gO2VmOyXkOqyjCDrtoDqs7zrkJjripQg7Iah6riIIOyImOyImOujjA0K7J207KCEIOyg
hOyGoSwg7ZmV7J247J2EIOychO2VtCDri7nsgqwg7IKs7J207Yq466W8IOuwqeusuO2VmOyLreyL
nOyYpCAzOA0KwrAgNTPigLI1NuKAsyBOIDc3IMKwIDLigLIgMznigLMgVw0KDQrsmrDrpqzripQg
7J207IKs7ZqMLCDshLjqs4Qg7J2A7ZaJIOuwjyDthrXtmZQg6riw6riI7J6F64uI64ukLg0K7JuM
7Iux7YS0IERD7J2YIOq1reygnChJTUYp7JmADQrrr7jqta0g7J6s66y067aAIOuwjyDquLDtg4Ag
7IiY7IKsIOq4sOq0gA0K7Jes6riwIOuvuOq1reyXkOyEnCDqtIDroKjsnbQg7J6I7Iq164uI64uk
LiDso7zrrLjtlojri6QNCuyasOumrOydgO2WiSDtlbTsmbjqsrDsoJzshqHquIjri6gNCuyVhO2U
hOumrOy5tCDroZzrqZQg7Yag6rOgLCBWSVNBIOy5tOuTnCDrsJzquIkNCu2OgOuTnOyXkOyEnCDr
jZQg66eO7J2AIOyduOy2nOydhCDsnITtlbQg7Y6A65Oc7JeQ7IScIDE1MOunjC4NCg0K7KGw7IKs
IOqzvOygleyXkOyEnCDsmrDrpqzripQg64uk7J2M6rO8IOqwmeydgCDsgqzsi6TsnYQg67Cc6rKs
7ZaI7Iq164uI64ukLg0K64u57Iug7J2YIOyngOu2iOydtCDrtoDtjKjtlZwg6rO166y07JuQ7JeQ
IOydmO2VtCDsp4Dsl7DrkJwg6rKD7JeQIOyLpOunnQ0K6reA7ZWY7J2YIOqzhOyijOuhnCDsnpDq
uIjsnYQg7KCE7ZmY7ZWY66Ck64qUIOydgO2WieydmA0K7IKs7KCB7J24Lg0KDQrqt7jrpqzqs6Ag
7Jik64qYIOq3gO2VmOydmCDsnpDquIjsnbQg7Lm065Oc66GcIOyeheq4iOuQmOyXiOydjOydhCDs
lYzroKTrk5zrpr3ri4jri6QuDQpVQkEgQmFua+ydmCBWSVNBIOuwjyDrsLDshqEg7KSA67mE64+E
IOyZhOujjOuQmOyXiOyKteuLiOuLpC4g7KeA6riIDQpVQkEg7J2A7ZaJIOydtOyCrOyXkOqyjCDs
l7Drnb3tlZjsi63si5zsmKQuIOq3uOydmCDsnbTrpoTsnYAgTXIuIFRvbnnsnoXri4jri6QuDQrs
l5jrqZzro6gsIOydtOuplOydvDogKGNmYy51YmFncm91cDA5QGdtYWlsLmNvbSkNCkFUTSBWSVNB
IOy5tOuTnOulvCDrsJvripQg67Cp67KV7J2EIOyVjOugpOuTnOumveuLiOuLpC4NCg0K7KeE7KCV
7Jy866GcLA0KDQpLcmlzdGFsaW5hIEdlb3JnaWV2YSDrtoDsnbgNCg==
