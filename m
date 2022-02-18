Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC94BBE53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiBRRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:25:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238510AbiBRRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:25:24 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BE2B6200
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:25:06 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so3773673oib.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=NrtR9+xtE0nen8wtzr6Z9xalBUEY+y3BMYwe1v/JgYpQ4EWoaDpS42MEcqEdN9JKUq
         yKeIYwqnj0dvneqByhH5LYGyVbzbUEguQ27QoP86fknOJae0imy2lrGMosJV7/7474Ii
         QBhuwm5l5BzJ3xj4m9TbhA2JPahsGznkgMBVmcZA05jCskaL83OHAqYQSPV6zyV+W5yD
         I4DqAu/vDW0kHWz+pERFxwwpTSXznIdP/LPJdIPH8HnmeYLB+9KoJkswd7a6/5oozqQZ
         UWxucd06b3f64yM/E+lIeTOCZBvGZzGTOIhSdBszK3PVhzss3plMpr5Y+62pN0iQn53a
         ucSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:cc;
        bh=AT2vVSkbs5Z2AlPH3lVSxISBm4g33VFLgVGD3BjUf+w=;
        b=W74EWu94ewj33hskRka7v3PL+oMkzQI1o5ZEhB52Qt2E0haVBCAHPKxyv3C79nncIe
         HDt6ra9vs9stVBfhww0XivyAduvztzR9tXpiHwKJnYhkDGdXkYWaQVHCHsGIQyBHOOcy
         RyvwcrvrojGXGkVcF4Ldxs7F1JGkV53/fhXBcbZrQBdvM83VgK3Nvh7EkVe5lGIXOKUr
         /JAgmPg0ucluAxgq6++Jo4cCCxvV/sSRFxlaRPZacb82xmZ7MOZ8p24sCS0GXp5d8zmL
         g2uYScgw4eubnpGOjCdOdhOO+HpLdQJtktx/q6nFHS3Xe3w3Z4FwU1JzTvsfvs1a74M/
         eTgQ==
X-Gm-Message-State: AOAM533eDmj1l7Be5vugezTujCc9sdw0f5Uqnmeh+F1rjpWCZNYOL4ep
        o+eFxuaaZE/j2bIjRDm1fpkYNPfAwA2SJGShcUU=
X-Received: by 2002:a05:6808:3084:b0:2d4:c36a:4d27 with SMTP id
 bl4-20020a056808308400b002d4c36a4d27mt213128oib.66.1645205106262; Fri, 18 Feb
 2022 09:25:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:3d81:0:0:0:0:0 with HTTP; Fri, 18 Feb 2022 09:25:05
 -0800 (PST)
Reply-To: lisamuna2001@gmail.com
In-Reply-To: <CAA4TxLDjn13B2rruf_MxysWGf6Qrb07+HYx7VUDeiFJnPHWB-A@mail.gmail.com>
References: <CAA4TxLB-GPMzqZS53twLjRpPD=FV6nyBch9Ug31kgcwjZKYSbg@mail.gmail.com>
 <CAA4TxLABzWLhedu5LeEqyKtfSzmfA_LKSBkg6ZuppkjYDOs-3g@mail.gmail.com>
 <CAA4TxLCp_wUVhpz8Vh2rF2sU73hauve841SP2uinzWotLydM+g@mail.gmail.com>
 <CAA4TxLBCRwXJZ9h_LotGjdRzZf0SoeT+GUOwSRkB5JtGAV3PGQ@mail.gmail.com>
 <CAA4TxLCRb-V=h7Lr2m3JQRfV4c8ra5md77rj7kh9qsYsHtGUMg@mail.gmail.com>
 <CAA4TxLDLzVe8g9NL54ATHfuBW9U5+n1BY-C5t9kHcx=GKfhdzA@mail.gmail.com>
 <CAA4TxLAoLESq5rAn9B91aVpAXR32AiOH6y8cKnkrTnrkZKra9A@mail.gmail.com>
 <CAA4TxLDG84jPsEOC8edRq5ggdu0gqHkaQk_=OsiygAWJog3g-g@mail.gmail.com>
 <CAA4TxLAoa53CGtXP-TGNAUFfa6pE-TSwmBWEcJwhiFvRFe88Yg@mail.gmail.com>
 <CAA4TxLD4dBU59pCyVRKfTzCkV83AHA_7RAgpQr7MEds1yNowHQ@mail.gmail.com>
 <CAA4TxLBn6KhR2Ci6vAnPqCZi0LenDsDtHSzgdY5i8-329WoR-w@mail.gmail.com>
 <CAA4TxLBSWTRUwxQ9N_CP3azLh=yvV___HporFsBwWUtmJBp2ug@mail.gmail.com>
 <CAA4TxLCcCJiV=XYwTxDOT_6mYBAeJyaRj0+iRbtng3JXCzVwkw@mail.gmail.com>
 <CAA4TxLChV=prOWEi3ZVSEhzXe2BAAOj-mDTk7vDxE-rxGE5pFw@mail.gmail.com>
 <CAA4TxLBHsKpS5F=ruymO6B88H435httx5XWS8PR+RxMs_WJh9Q@mail.gmail.com>
 <CAA4TxLD1s0m4714Jnb8W2uUm2L6+S6t7YfZbzNjwVv-RyW=hKw@mail.gmail.com>
 <CAA4TxLDKTg488SZ6h8njg9VACJO8mK1NJ3cHS7Yh9bfQu5VDug@mail.gmail.com>
 <CAA4TxLDKY=diqROV3Dm5+wXB0BxbxgwBmpF-Afua7yTFip02-Q@mail.gmail.com> <CAA4TxLDjn13B2rruf_MxysWGf6Qrb07+HYx7VUDeiFJnPHWB-A@mail.gmail.com>
From:   lisa muna <kristengriest098@gmail.com>
Date:   Fri, 18 Feb 2022 18:25:05 +0100
Message-ID: <CAA4TxLBvc6YKLOLED8V=Cu7SR=M2UY30dj0sRFYN4Sx-aYEJ-Q@mail.gmail.com>
Subject: hi
Cc:     lisamuna2001@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do you receive my massage
