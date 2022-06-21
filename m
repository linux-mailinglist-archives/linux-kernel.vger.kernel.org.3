Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E6F553E95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbiFUWfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354293AbiFUWff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:35:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3531DD3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:35:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lw20so8087592ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fE13mG9CKvIUbMO9JtlL0pZ2ijxEEYtHb1Jlhe49Vto=;
        b=S417DFgbvM0La9BdQyrCMy6u0GYqMwbvSHr0l1IeeFlxbPH0BaPdx+AWt147nNHgAP
         Qa+faBHIurOrbOtlHXkqhkExIbuKJow2Yig4wYFedKol+We9E6K79umct/wnO66ihbrC
         R8TjjsEsw8pLiDUtPEHfa7wcj7dRpiti876pfi1mn1HiEg/9MY1oFJErZNefsa0/pbcR
         7xZk+OgdG9/YvBtT5J2HhHdURQ21JeZ1wK4zyKX+zfgEf1/gUrlH9Mi80CfuEy8J2RyA
         RSaH1PN3CMc/ZmyPHDUjlygyIIHfGMJoljH+k/eChcPDU//tLkNAVtt3Gbkk56vMZgcw
         /+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fE13mG9CKvIUbMO9JtlL0pZ2ijxEEYtHb1Jlhe49Vto=;
        b=4ZcM6xZyo5W/Wk/cpfPH0eXkItCUwqWlIsQuCF2B/segkAwxpIcDpKIUMg+JijhgzZ
         NShw3oLRzmaOdjfjPqUONp8U0qxepe4/Htc0AkGUv5Tp0crG9+u1xMTtVXlgKjnLMQkR
         GfRnYOOWn4Io+lTSC6zrOAp66837ex5H9vGI6JPpHE9kAndln1oYykS0nam5l8YK7Tu6
         CXI775CLnmBfYcuDyNuk9U5R08RLglkgqIgidKLesYGM8Y2zl68jrTtTgFz7j+EbAMxJ
         yFA8/tSMcCkMi+n+/IhFjjIdh58MJ+eTxwNyuUjrRkZHidpYAQWrwYsQvm2XwojKg0AD
         ooCA==
X-Gm-Message-State: AJIora+YuE79buXjR/iEqn7edbfpgb5/em7S1Oc4v/bCqF/jjM3TrVB0
        FcLWI5jTVGcEvDuvh4FaaqxaDMxO7LaRABcaSSc=
X-Google-Smtp-Source: AGRyM1vjKPgpQn6C0iWl/ATZAPlIpQte8Z8n/NdpgdzTB5HDwnW55fUYw+vUV3DTIZ8l6/3wBXL5RKz3HjW0nJ4UeXE=
X-Received: by 2002:a17:906:7791:b0:712:1c42:777a with SMTP id
 s17-20020a170906779100b007121c42777amr329384ejm.68.1655850932513; Tue, 21 Jun
 2022 15:35:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:624a:0:0:0:0:0 with HTTP; Tue, 21 Jun 2022 15:35:32
 -0700 (PDT)
From:   Schlumberger Recruitment Team 
        <schlumbergerrecruitmentteam@gmail.com>
Date:   Tue, 21 Jun 2022 10:35:32 -1200
Message-ID: <CANv9ONDNVSMfiGEEuyXZB+aZCGgSU++FNEEnA-3Df6gvsVs9FQ@mail.gmail.com>
Subject: VACANCY FOR EMPLOYMENT IN UK
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
The Schlumberger United Kingdom, We are recruiting all professionals for
our ongoing project . Salary Rate from =C2=A3 2,000 British pounds to =C2=
=A3
65,000 British pounds depending on working experience and
qualification, you are hereby advised to send us your recently updated
CV/Resume with the below information if you are ready to relocate to
the United Kingdom.

1) Your present monthly salary in the US .....?
2) Expected monthly Salary....?
3) Are you willing to relocate now.....?
4) Your present Position....?
5)  WhatsApp Number for interview

Thanks,

HR MANAGER
The Schlumberger Recruitment team
