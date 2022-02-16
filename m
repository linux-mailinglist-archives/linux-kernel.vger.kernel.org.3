Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5524B91D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiBPTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:53:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiBPTxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:53:39 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459E219C31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:53:25 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so2035819oos.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=5wnuKZvhxhXGVVfjSFw9REI9M2UWFR0iZQ0UxSN2RYo=;
        b=aCs87OAVbqYJMT4rtLTSXZeTTZzIIvg8D0cRpuN0b5nXGkx3mW7Uf8c0z1ITmiI0JI
         TQ+CfTkJF5gAr5FAzLUiUaF31gyksgKErRcvIHhl8TcQOQEwsupOIrBUUC4iQ3GWFyID
         kRO9JQcrrjKCDhuOj60Y6bpCfnPZeCT6WtrBWhWmI3oo/DK90GoIymr3Npyph7lmO3Vb
         ag2Fpb6A2p/6DAC8OJSEoyxQxb9H72kg+/B9sODvUJJI2UsIEsLxDcKZx7YMpjQ42QWK
         /jFunSFXzPzb9+mE9U2N6v2gnRio5g45MxT2iEdZLGcU6arf9tMuatiilE7RW4+AvN8O
         7beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=5wnuKZvhxhXGVVfjSFw9REI9M2UWFR0iZQ0UxSN2RYo=;
        b=SFwARgc4QWOG9nQRbtil9sYfhcaIp4J/X24zEl/Dy+398tAfd08BH1NoceNM0cTbeS
         d6+ctk4bCwMFpAEEuxhlrk4aLL0jo7gqndtnsp6+LvzfhBx3SlUHIcyb+2/ZSa5M/nzz
         ht1tIEtCbf4sphgmmg0Ymj0UKeG/1a+CwVNTnfsgYHEbLH8dAPDmVYUi4nmP6Yqo5yOt
         4H22boTZThpdtqSvliaGFpGCkbg4HjC45rObvMBGdA2GEIpsJhQUIidpweXncFj6+IpZ
         b1AG+k1N8rFQMslAZaf2SMxdbgq/P4Uv4oI44enBttEDssHZaXvExUNXoCT2GxABhMrB
         KWkw==
X-Gm-Message-State: AOAM530EtVNUrxZK27A0iyK6PnvwpfA+xRyLuFYHULmY34qf6nDIzb9T
        La1FRxbdvKAVLtBw3k7FR9/g9WTDk1SRFhkcbbI=
X-Google-Smtp-Source: ABdhPJyDXpOlkmTzqYZzIjw4+hnwyDlMITYkpOHvLd5Ke7+jc09YTrRbJo7kYyT8v7lcq7lq/SvctPkAS7dOh6egL8I=
X-Received: by 2002:a05:6870:8316:b0:d3:a001:96cf with SMTP id
 p22-20020a056870831600b000d3a00196cfmr315272oae.85.1645041204884; Wed, 16 Feb
 2022 11:53:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:7312:0:0:0:0:0 with HTTP; Wed, 16 Feb 2022 11:53:23
 -0800 (PST)
In-Reply-To: <CACH8gcq2=hKkmWmN7WMM2BihUSnJuGZ81UAHrJjtisG8qKah0A@mail.gmail.com>
References: <CACH8gcpeRvraH27HuA23qnTmOZAyGQjd7E1mtR3FUTAvm6bLQQ@mail.gmail.com>
 <CACH8gcoesVp2Q-bQx+7OAnYSuxC+4JF=1D2mp8vg=stbCj3X+A@mail.gmail.com>
 <CACH8gcrYEXS2QXL5ntJpP0-sVCu=UouC+VDn_70D2CdCeSB15g@mail.gmail.com>
 <CACH8gcrkb2sus9Zi88SQOH3z+DWhbarqGUhdHCdw3YPF9aex_w@mail.gmail.com>
 <CACH8gcrEsPpDjkgZAqwGrfFsM1rSrk_FkbsW086dg8h73vwKLQ@mail.gmail.com>
 <CACH8gcpR+=JN_sep4shz=J=zponH5p=vp3xoUZGgjATKVnXVtw@mail.gmail.com> <CACH8gcq2=hKkmWmN7WMM2BihUSnJuGZ81UAHrJjtisG8qKah0A@mail.gmail.com>
From:   Robert James <jude1bambam@gmail.com>
Date:   Wed, 16 Feb 2022 20:53:23 +0100
Message-ID: <CACH8gcraN5Qer-yUjTfeY=8ZWfBOOaggy_cMpi10nge_8E_K0A@mail.gmail.com>
Subject: Re: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLY,HK_SCAM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jude1bambam[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear  Friend,
 It is my pleasure to let you know about my success in getting those
funds transferred under the cooperation of a new partner from Greece.
Presently, I'm in Greece for an investment project. Meanwhile, I
didn't forget your past efforts and attempts to assist me in
transferring those funds despite that it failed us somehow.

Now contact my secretary GRACE BENSON  with her email is
grben2014@gmail.com    ask her to send you the total $ eight hundred
thousand dollars certified bank Automated Teller Machine {ATM } VISA
CARD,  which I raised in your favour for your compensation for all the
past efforts and attempts to assist me in this  matter, I appreciated
your efforts at that time very much. So feel free
and get in touch with my secretary GRACE and give her your address where
to send the draft to you.

 Please do let me know immediately you receive it so that we can share
the joy after all the suffering at that time. In the, moment, I'm very
busy here  because of the investment projects which I am having at
hand, finally, remember that I left instructions to the secretary on
your behalf, so feel free to get in touch with her without any delay,
Contact her immediately.
 Regards
James
