Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3735A2D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiHZRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbiHZRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:25:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F78AB072
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:25:29 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-324ec5a9e97so52591827b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=LcowEz/MHN6VIwZyVyshjW7bqzLnX3nnurMOL1MyeF0=;
        b=puzFGmbvEjs1MXMTmNuMzsKqel6bD3ftFe3esLTIfZMg+e/XXwCyR/RpFSvGGRLoo0
         F28TQqWZdRIT6HsUzqqPPbGnzrY8GyBGkDVROeI4aiPvL2MJZ+bLZvarbo+ynkV4dAPs
         WSJ1//Q58EDoqYoEYsIkjwsld2Sc7DG3BhRhPnrLluinWUrnTJKTJj1TmgzDt8mteTSk
         ycE/BTc0N0m+tBew/P/40JuO7nMnqQYnSXnumCq22i52ega8GB1FjTK3HJhQ7ZG1pDmn
         HHjS9M3WXcchMY5QChSEkt0pMnSUV7QzAqPinNE2FmzNabsNQ7sJ0DbUVdjvC4/Uh0cr
         VRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=LcowEz/MHN6VIwZyVyshjW7bqzLnX3nnurMOL1MyeF0=;
        b=uFWplg4+/1yALOia8E/bkxkS0nb1gp/X+9OpR2j3q2SSAOI16pF9NRNHLxskaHGO7G
         TcEXdEcfXaRgntO/XuTgwPL6QyNWgVLqzzy+eeb+MpGUfgGz9n2BoSaFMJ9EHHlWxXlN
         mgscpTABhj+iK+kIv7x4hFtoKu6ZHYOP3VMWHR/aTcO2T+H5PKVpA1whxlhLBvnn2gYN
         FbLlR5ulg4EPwrX6HLWRGRCR0AzDPJKxevy9Fpk1gXzgN0elGwnBl1HHbFekXI9VzrwF
         prUuhjdqFjHNsB8Zua7yuXE4XhW3A9sLIL+R7oN+dZzFGHqR0Bnul48qsBqBCWeyhij3
         jRWg==
X-Gm-Message-State: ACgBeo1GafhkwVKSwShW95Hn/Xmy7fxMJJHmbgPbt/pJa95FZWz44JiY
        S6PCrGv4awy7srK+CUA/QAou26oBdXoDTXV2meE=
X-Google-Smtp-Source: AA6agR7P/wpYWWjmXJEPjz9C6Uy48MZWhUUZ1Oru/j0ATu4rwNT1kl6k+Pj8zshCp21d4svKaisHYhSX4CKcBFeHeOc=
X-Received: by 2002:a05:6902:1501:b0:697:c614:2079 with SMTP id
 q1-20020a056902150100b00697c6142079mr667112ybu.389.1661534728969; Fri, 26 Aug
 2022 10:25:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: 93779247nourou@gmail.com
Received: by 2002:a05:7010:8d85:b0:2ec:d4af:689d with HTTP; Fri, 26 Aug 2022
 10:25:28 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Fri, 26 Aug 2022 17:25:28 +0000
X-Google-Sender-Auth: zpcjarWsG6R9DCUli619ggKDcno
Message-ID: <CAAzAzB5ni2WVNVHJfDc6gzHs6H=Fp35hREDsaakR-ZgvbvSkFw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, voc=C3=AA recebeu minhas duas mensagens anteriores? por favor
verifique e me responda
