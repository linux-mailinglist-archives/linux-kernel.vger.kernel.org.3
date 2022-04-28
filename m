Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A825133DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346360AbiD1MnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiD1MnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:43:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160DDAD121
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:39:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so8386938lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=VfwjyPbBfFqO7CvMvoZLf+wxpfLiKn0LTDd54jeVGXw=;
        b=oBMGlpTC4R864+6cJYNiCygI9icaV1nx+ayPgJ0wpuP23dgcbNDaOIraUrMco1Ll+1
         4bENeXI1+VxUPBauIBbYdE3vOPc9+zN1jDoLrprQ2K+C6qBrA13gcgy7+gP3lU0CIIqZ
         Z/6CSXxrJ1xcJ6sXsGGc2hNPGsozJ/cvCFW8WtkttMO3prQrbFwXbX5xQwPeHBXX0tho
         NllCv+vbGCpz+Lhog+DoK7CUXhe2S9Q9bzdRNTo3TF2B61hPBAq09pNsKXmE/cGvxFew
         8lRV/7zcX//SBBzLhqHJWieu9p9BvsVLGyiTaBiAZg6XwstkP4/yhpm+tjdqykzpiE4K
         nNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=VfwjyPbBfFqO7CvMvoZLf+wxpfLiKn0LTDd54jeVGXw=;
        b=wyl2SGRpNwBXFSS6m+ZP/cKd2m6db7sGJQhSXq8eb3l9LmpKCc2AaInEenfm37dZKB
         Jwk4FjqoOeAlX7ujdaxacGTlf4fagxXS8VvPbV0l5DLg+q/K4XnbwybAOAKW63bb3QGC
         AYAoWwlCc1vihO2AGnFJ7l2l1rIw6r+Tq7Ay6emhmp5shU8UvAL9HykaAEjfGyCgCN8+
         PTmYEry2jhDBi5YffGz8GzwQAjy8pqVj9yIer6YsSRV4S3KiHnoyylFplf3KMcPadfsB
         +C62kQy8Pny3oI92XhYrxGE41rHL3Ij9zWEHLnv5eKBoexHN07jaePjUk+2V9mNAFI11
         Mhrw==
X-Gm-Message-State: AOAM5316KWonTbuPm6CnY9EK5a+b5H/dE98crNmqh5IhMpyyEBW8aYBx
        AsTQ0EiYMiPBEXUR+MzoH4ciu32X9R4/5/JI1Dc=
X-Google-Smtp-Source: ABdhPJzev38OC8LoxcPaXSa1nocIEqgNQ4YwvBchUhdE+nWL4EmMyVgHQKR9nFtfdNNN8alTM18bdKSTCvxq2uIiQ4I=
X-Received: by 2002:a19:ca06:0:b0:472:3b31:1ade with SMTP id
 a6-20020a19ca06000000b004723b311ademr1759344lfg.162.1651149587379; Thu, 28
 Apr 2022 05:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:26c3:0:b0:126:bae1:1038 with HTTP; Thu, 28 Apr 2022
 05:39:46 -0700 (PDT)
Reply-To: bellwoodo@yahoo.com
From:   Olivia Bellwood <fatgando01@gmail.com>
Date:   Thu, 28 Apr 2022 14:39:46 +0200
Message-ID: <CAFAqxBbrB41_QNbGx_HVh-s2Kt5d5PPyD4fd8f=E6LkWsK6C=g@mail.gmail.com>
Subject: A Call to Humanitarian Service
To:     fatgando01 <fatgando01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from the United States,
I will like to engage your honourable person for the service of
humanitarian. If this interests you kindly reply me for more
information.
Olivia Bellwood
