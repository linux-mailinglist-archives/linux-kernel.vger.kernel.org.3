Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BC46F1FF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbhLIRgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbhLIRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:36:50 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09461C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:33:17 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so6536986pjj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=uwmi9weQSyq/d/deHnNiqYvxECbRWaov59JeMbz9coU=;
        b=PkmqzihQtYH1Cyz+PUk0B1bHaOVSk1sDmp8GdJGwJosEFzLacODoxN/xf3cIk2fe/C
         PC1k3TgeaqOwv8fCwOXROUyRlwLq1os/Nh0DVQUz1KKLzH2D3xa4iJ0SANKEOIdEHAIg
         xbyJKaZkz1MWIDK7fKqFwbSgM66Sn+AIkIPPHLVS5hN8yV8HR8rwf77J/El5ePn30SzW
         AbRdTIdArCLlhtJNGzJiLuVe+s72rcQkcdgncsNrmWGmiHkXfFcJWBnn1rynJvSg1K5Q
         cERKLMzvc4SDfEU+1/yhct27hztjZfOHbOhHWfz4doWucNfhbJ2Z8po7Lw260OrC0QqF
         I1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=uwmi9weQSyq/d/deHnNiqYvxECbRWaov59JeMbz9coU=;
        b=xUmgS5nnLM2JSQV/OJwkst/gHV+Lmk0Iba2ZjWJ0evgtzJQJk0ITrOCSPaxbB0qk34
         Lh4+XJD4Q1Jc8HExw1nghKLj0oYTBWoktZ+fO0PbnYKTvVFpb6BWvD9rcCGiv1Vl1e1D
         pHmPd9jH65OSzedACQbMDtxJ6XB2rdZBdwnLh3v0b5gf3BAL3Tj6H4TUqTMtPkDTFkDH
         UHY81upzwYL1nIB8YrxwmQIuhx8HJTY3BUoOP0MY1KjUZoNc82EWoOrfoyVEtY84RBBu
         d5qyd6wd6cPj/AVFiomLgfe1JYVTNpSanhLi5k/C6KC+KcL5UYDzTKN4HjFjAoqNzcji
         Dq6Q==
X-Gm-Message-State: AOAM533riiZURX6kGjSVqXJgsCyyQ6S6rMRFgPyr7b2pMlTyOXg5jRiq
        VZsnkbVQGfwXwAugVs4zFQbyCkLaICBjyHKe3XM=
X-Google-Smtp-Source: ABdhPJwZJR2ee6RIUdfwu1A9jIILM1yf8rp4cqE3jufFORIdWyGjjona99ScKoAXciES2lpNIyRnVDPjn9SB3qYwk5Q=
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr17282506pjm.166.1639071196343;
 Thu, 09 Dec 2021 09:33:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2a8a:0:0:0:0 with HTTP; Thu, 9 Dec 2021 09:33:15
 -0800 (PST)
Reply-To: martindevatta@yandex.com
In-Reply-To: <CAPr60DhL=inkR4RmpH+BhEVmnEEsF5dyzTSt4cw_X90maDyCNg@mail.gmail.com>
References: <CAPr60DjtOn7XBPMVqa8LvaNXZVg0DM79NRo3ucC46+yrtJRgnQ@mail.gmail.com>
 <CAPr60Dhig22odSsZ5Fk60CpiD0h7uCg-KaFDBF2Hd7sFc570RQ@mail.gmail.com>
 <CAPr60DiCAzaZD3TWC33xXp5qfdYBY47aAJva61RtipftO3yO=g@mail.gmail.com>
 <CAPr60Dgj-pfoedqDU7XPrQ20v1FV1o2R2XUQgpL=gY0SqTyfyA@mail.gmail.com>
 <CAPr60Dj+ax5_c0s+_BGLt9453cBcGYZ5tSkR8SgAfhyuhtt5RQ@mail.gmail.com>
 <CAPr60DhC6z+zH+b9vk8Gvk2n0DS3VPpSs4nOtCx3ox+TKoeGeg@mail.gmail.com>
 <CAPr60Dj9LAbo-+N755WEaGe1k1JOiXc0iR_0KnO_Tf7TP0TZjg@mail.gmail.com>
 <CAPr60Dg8G3DRAJs6nsxYYMKKdQ3r0=XabGAOC-rrJmZPDWsmtA@mail.gmail.com>
 <CAPr60DisnOfhPE8omkEKTnq+dCGureoRFSQPNwpYxPFTrC4q5w@mail.gmail.com>
 <CAPr60Di45SpnWVHBriWQwSWGphLrp3ixacMPZmqUYTg0g8Ti0w@mail.gmail.com>
 <CAPr60DjfTxYH6iGZBZMLg+NyOyis7c8vipQMCNV2XNBOgm75ow@mail.gmail.com>
 <CAPr60Dh0c25+eoNrFAGumo0jz93gEdUcFMWaWEdv7=k1Lr+y5Q@mail.gmail.com>
 <CAPr60Dh=_orVq0hU9bHp69e4dGkc7Mfb55-YMPL=ftttgfGfqA@mail.gmail.com>
 <CAPr60DgD9Y6Gbk-08yp1oqWDyKgVr2wBiPuWvS+j_UZpXx-UQA@mail.gmail.com>
 <CAPr60Dj89ASdiYH5qPVYTpHZ8LLHwos1oiKWV=DumOKmoxy9rw@mail.gmail.com>
 <CAPr60DieaMk3a5J3dzSL116SpUnGD6moGScFSa8e4Mq1PJRUSw@mail.gmail.com>
 <CAPr60Dj7FrJQdhbWK42WEyVg4_DGzc8gdNxVFmPJrXv_iE4Z1A@mail.gmail.com>
 <CAPr60DjJTzYqqdnuRhpp3qO3LRmAbR6GpGWVtVCM1XUSHKvziA@mail.gmail.com>
 <CAPr60Dj4tpJKWFWGwotwFM9Gosgqf=Q7cGQkYPqn_LrXMTz7GQ@mail.gmail.com>
 <CAPr60Di2Uu_ZoGdyq3ka9_8r-CZYNszKYBVYxZj0x4kh3eVqUg@mail.gmail.com>
 <CAPr60Dj8rXjmF1+C=sg6Zk5kV18quCDAD7dM-jiWY-jxrEGuug@mail.gmail.com>
 <CAPr60DhPiamSV6wOEjvbWtvxrsb_oh_bYPjHJ39xbXOf2NijwQ@mail.gmail.com>
 <CAPr60DiWUcv2H0doGxsnuE1s9ici7iAQiE_qhVRpXY8RWuOF4Q@mail.gmail.com>
 <CAPr60DgJqSKDZZv_oaiAQGHtM7eBaaBT7hDvk3DHn9Y9mQpNVg@mail.gmail.com>
 <CAPr60Dg8_==PPB=6=tXPWktaJuKteYVuwoxbV4Cutje4hX6FNA@mail.gmail.com>
 <CAPr60Dj_NCxz+ysfkq25jxqJRgdmcbarYrGFqrOHa9A=vhQjkA@mail.gmail.com>
 <CAPr60DhUmV-rLo-zMRYMoVrJN5XAjGQqdjrbpSG4L--+hX5LPA@mail.gmail.com>
 <CAPr60Djn9QBeu46-mkjNNRegQdRh733OTEjBwk_v+8tdm2H=aw@mail.gmail.com>
 <CAPr60Dj_n0pqTHUzptAAWhm1jKuX9gi2DS9ZUuv5FzHCvVhQdg@mail.gmail.com> <CAPr60DhL=inkR4RmpH+BhEVmnEEsF5dyzTSt4cw_X90maDyCNg@mail.gmail.com>
From:   martin devatta <carlson99hellen@gmail.com>
Date:   Thu, 9 Dec 2021 19:33:15 +0200
Message-ID: <CAPr60DiHXp4xy057CptZM_i+FkXzs7cwit4b0bbeTdV=4UzKzQ@mail.gmail.com>
Subject: From Procurement Supervisor
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sir,

I greet you with warm regards. I work for Malaysia Oil Refinery Sdn
Bhd Company as a procurement supervisor; Malaysia Oil Refinery Sdn Bhd
is an Oil refining Company situated in South East Asia.

On my desk is a mandate to arrange for a Crude Oil purchase from the
National Oil Corporation of Libya, from the State of Libya for up to
2,000,000 (2 Million) barrels on monthly bases for 12 calendar months.

The reason for my reaching out to you is because I am in the process
of establishing a broker / mediator or a middle man structure to
mediate between the 2 parties involved (our Company and the Company in
Libya) before the contract is signed.

You may be wondering why I cannot execute this transaction by myself.
The honest fact is that as an employee working for this company, it is
against our company operational ethics / policy for an employee to be
involved or profit in any financial dealings involving our Company,
hence I am looking for a trustworthy person outside my work circle in
order to maintain a discreet profile.

I wish to extend this partnership to your friend to build a broker /
mediator or a middle man structure with you while I work from the
background to guide you. Our company pays between $ 2 - $ 3 per barrel
of Crude Oil as a commission / brokerage amount, if the target of 2
Million barrels is a monthly we stand to share $ 4 Million - $ 6
Million every month for a span of 12 months.

.Contact me if you are interested in this deal, so that I can give you
further details.

Martin Devatta
Procurement Supervisor
Crude Oil & Products Trading Division
Malaysia Oil Refinery Sdn Bhd
Tel: +60 1117225127
EMAIL: martindevatta@yandex.com
