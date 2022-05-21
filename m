Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61E52FA24
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiEUJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 05:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEUJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 05:03:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB4C6E76
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:03:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t6so14254420wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pTzrnwrB+fbTMxj4ZKcYrs49wGDFRgxcATF+5Ao1my4=;
        b=QwPxwMN+oGr8QBpJzIzca241jKt80oJrFqjKmwkHgRTmkg2iaT0WAp7w74k2pFVcwJ
         GIBGsOgVKamuZQvf8apjrrVMtXFh8P+vklmG+cObqKtxPaCzThVF8pIk5chGW28grrKi
         2MJHUwjpMEX54s6TCTK9tSJHXhdWFkmgnixH8U2IYwQxqL0dqCF0lDRK+/LvTVozvfy9
         eyUzZXTZx0GJZ5IZ5KBXlt4+c8tW0zq7k7Uq0td40cqrcqVzbVcyUQBpNPR7tC3FAyyN
         omdQy401wSI8deAX1wH2fMZztg3IL5PeDcghpSg3W3XvgQAbwo/4zEwdr7rRM0l6UUB3
         jAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pTzrnwrB+fbTMxj4ZKcYrs49wGDFRgxcATF+5Ao1my4=;
        b=6tBtzWkELHRtTF5lt1OwsJre2GtHLu8CWYG1/4bvpO3cYYp5hA4x+OU9OJHhiDl5S5
         mr+Gfty0fLx9BV5Av3+nCoig3DkrW2VB+z2T4w/tht6kSn5OMEkYguJQJpi11LupUzHT
         2m5j7ZOXKAfqkrbQvym2qJ6fNsNgeEdRLCg5+421FQTfFP+pA3wuXj9ckyU2k3NLsOK1
         TqVW8hkEZRsz5Adf4vL+NfZaOvYzQLt1yEUQ0YHK9+Vs7pPHLFX3Ob8Wsg1lR0A5LX1j
         3MVXmEhIRJazrhHJJpPuBaf5ATIYOsw7hZ2EM3u6ep1OEHECLzH/70/PAVYmw/cb+WC8
         AC0g==
X-Gm-Message-State: AOAM533DZx3woUtIvNX3z1au/hlPkWK5VxwHf2gCXS+FlsUFEXyTvaJs
        v802er1By9Rt/wh78aHaw7j08SjRvMNPWu2QrK4=
X-Google-Smtp-Source: ABdhPJyz1ELDDHbZxNB2rlrpf6e+G3/4PqRaPE4sBhGRaxYz/kEYHh0Je3dkmKaIvIm3JvF/DPDnLoCdQimstbNd4Ec=
X-Received: by 2002:a05:6000:1c09:b0:20f:cd6f:f88b with SMTP id
 ba9-20020a0560001c0900b0020fcd6ff88bmr570942wrb.571.1653123788842; Sat, 21
 May 2022 02:03:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:783:0:0:0:0 with HTTP; Sat, 21 May 2022 02:03:07
 -0700 (PDT)
Reply-To: ofd567807@gmail.com
From:   "ofd567807@gmail.com" <wwwheadoffice01@gmail.com>
Date:   Sat, 21 May 2022 09:03:07 +0000
Message-ID: <CAPb9ZyyKEPyp=G4Ad-ktoK4gz9pX84ZjGqbfSOYxNvgu18V9AQ@mail.gmail.com>
Subject: W
To:     wwwheadoffice01@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_2_EMAILS_SHORT,NAME_EMAIL_DIFF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Do you willing to get your fund or not?
