Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34A570ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiGKT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:29:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735EF2A433;
        Mon, 11 Jul 2022 12:29:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so5844316pjl.4;
        Mon, 11 Jul 2022 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=dt9ajF6fcJjGOiO9pFsmnlVg5KP/cQHfnIOqjxWko10=;
        b=B3zce7njlIj0lIcx8i1HPL0WQREmVEyNn15hteyCSGv3mNXSQFZS0GqGvQwe5AGFv8
         4uPkFqrPhc2nUtyGnVOmZiOumxjr++okaiFAvlH11g41uIfTXLMDGAJSpGTgYHSlrdXl
         0XdvtsbS9IEtof1t6ilDOSEwJ+qGM5w4tO0APW52LhppevshRxRThGS4PksLtw6OhTu2
         hSLCmGiuttDkfB1kx16vYcQ9ukVBkYnoT/w9Rm61QzYKlOM9+KWBqlG6XlJI+MjoCbFn
         Bs/lM41IOZ3M/pADKQqWj8Oq7hRysYf1UXRtcCV4QdXTncIv5LEzXHXH/Df5mkw5+qy4
         z6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=dt9ajF6fcJjGOiO9pFsmnlVg5KP/cQHfnIOqjxWko10=;
        b=gcLI+0r1SWAW8S0Uo+T4RQ/M8SfJDIZMuPO0qivuQtrR6nlOzEmoY3osCk4i8Qkrw3
         n4Ws8M6MJO0exILJt1wBJXDQuKHo41YnGbEycAmXOI0q5PlOMU6iEA1xiJ/lDhpop/UY
         aD2xcsmWfTcwubE/UmsLThWaopx9HH7kgiUy+i5RLmzujNnSlPOnca5kTF7rBlmhABgz
         YObpveiOc0WALeeE7C+/JWzEbQftL3DcVtsnrneoqq4CPPmMI9E6zUNBdEWJAOKTiAWm
         C70orWA9THTojQTyG3g/+nBgJDMKyrCN1rosGf76rNGGJwhbwg4uOqChXQGiw6VCDuMl
         EPsw==
X-Gm-Message-State: AJIora8ZoKXpo0EJBbg3mjtpCrlIWT2k0sKkgO4cLzyUOmGINLV2UnKN
        9jkYaLv75Yxv1eAC2ez1Sc/UwsCTSr7BJRaO
X-Google-Smtp-Source: AGRyM1uHygxjTAesTKTeLYOwAKf/vjKwMP1LxCtf7rH05N60cuar1UWhqrNRF//8gtl1IiVsKXlNUw==
X-Received: by 2002:a17:902:aa44:b0:16c:fc8:a625 with SMTP id c4-20020a170902aa4400b0016c0fc8a625mr20573486plr.139.1657567765974;
        Mon, 11 Jul 2022 12:29:25 -0700 (PDT)
Received: from localhost ([116.193.141.30])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b0015e8d4eb2cdsm5109846plg.279.2022.07.11.12.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 12:29:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Jul 2022 00:59:17 +0530
Message-Id: <CLD2QBMKNA4W.3ICD19XKEALSR@ArtixLinux>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio/gpio-lp3943: unsigned to unsigned int cleanup
From:   "Aakash Sen Sharma" <aakashsensharma@gmail.com>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>
X-Mailer: aerc 0.9.0
References: <20220711052935.2322-1-aakashsensharma@gmail.com>
 <CAMRc=MefDXzawodvNYWS8h-fzdeUhmSCFjOFwfkALpB-a0PjCw@mail.gmail.com>
In-Reply-To: <CAMRc=MefDXzawodvNYWS8h-fzdeUhmSCFjOFwfkALpB-a0PjCw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 11, 2022 at 1:44 PM IST, Bartosz Golaszewski wrote:
> On Mon, Jul 11, 2022 at 7:29 AM Shinyzenith <aakashsensharma@gmail.com> w=
rote:
> >
> > Getting rid of checkpatch findings. No functional changes.
> >
> > Signed-off-by: Shinyzenith <aakashsensharma@gmail.com>
> > ---
>
> Applied with a tweaked commit message.
>
> Bart
Thank you!
