Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5722B4B2565
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349902AbiBKMNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:13:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349885AbiBKMM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:12:59 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F121E9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:12:55 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id t19so3523103vkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=VCy5pLs9VsGDwyQ4hfai46UAoZM5FEVwAyVbdK/rZv0+7CHZPlgE+FNoxTDjcVOLBJ
         4Rq9G3RgHpjLwZaRR6eg0HTXYKJPfn2TwsEr3CofywT3kTeJ4NoXoHQItp9/UsoA/EaD
         RYo4r7mwI3vah0IpSKASS1RVMVAnO7sqlbDVdIStjJYeqd221+qH8GPjcY+kPCyhhfEj
         c0aWYQRhpW31qnmWwwfrnwb2B849MfxSslkoPc0uSAqosxK3YSM5e4aHCBfxsfeIhTd3
         AnE+NKKJV/oG6MOlbi8xKA4DPFWVRlgKoq8P4IHuJscvdQUiME8bGCLA5cFc67l0Y5l3
         YRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=pbCVlee58SNRljTVR7wTvz7D3A0MvcLCtUjVncuzsEg=;
        b=f8pGFD9hwXkVqX9PhIPA5DswZJdbRHO9WlyZsPL154/hIfmYQMjsuPeGLIAVTZlgXb
         tj2qo85d63k3ec8j9ix+sz/vRezLvwk4HFvxvC6ucWYfheDhKJafH3iSCIwI1fdJly8x
         SEUsoDhuEwpCAbLdq24ZlIG9H9i+A2CxSpes3PgWn9PT935EVaLN/YxbGQrE/MKMx1O4
         bEFsLGs1hU1SmEp5uFYG2UXpylW1jjK35CuLLOg1qaXVo+Q7LCpgdIG9Pq+7vISkYFE4
         W2JPOPEXj6W7Nt61zMvTgzZziMWJWvAQvRw5xJ0IZmVaWF81hj9ABg3A5vg6IZN568Us
         fCJQ==
X-Gm-Message-State: AOAM530r0FngaIZLoLfLmRVCaURZQx9Am9isKyCm1AeQFmrH/IWSzl41
        gVp2ofwR0LL/PcJTg+5ifURn8MdXPXmL3BfMo5s=
X-Google-Smtp-Source: ABdhPJz5otK9D/K3Cjngea/6yI4dVjNgjIot/D0crqlaaO69dySg31Y/l4xGRmFqBWzTGSWa8GEBexP3QF+YYMvanVI=
X-Received: by 2002:a1f:31c7:: with SMTP id x190mr369593vkx.22.1644581574351;
 Fri, 11 Feb 2022 04:12:54 -0800 (PST)
MIME-Version: 1.0
Sender: acw.charles12@gmail.com
Received: by 2002:ab0:32cf:0:0:0:0:0 with HTTP; Fri, 11 Feb 2022 04:12:54
 -0800 (PST)
From:   Charles Anthony <banthonylawfirm21@gmail.com>
Date:   Fri, 11 Feb 2022 12:12:54 +0000
X-Google-Sender-Auth: -Fm6szCQce9wjJQM2q_1leUtxHU
Message-ID: <CAGgrmKp9qNrs9=m_RW_tZiqGCnQFSucO8bbpx+Y6hF5+1uh2ZA@mail.gmail.com>
Subject: My Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello

My Dear, I am Barrister Charles Anthony, I am contacting you to assist
retrieve his huge deposit Mr. Alexander left in the bank $10.5
million, before its get confiscated by the bank. please get back to me
for more details.

Barrister. Charles Anthony
