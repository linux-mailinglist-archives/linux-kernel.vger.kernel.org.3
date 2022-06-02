Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5633153B3E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiFBGwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiFBGwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:52:11 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084C212552
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:52:08 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsHwC-1ndSua1MAE-00to7z for <linux-kernel@vger.kernel.org>; Thu, 02 Jun
 2022 08:52:06 +0200
Received: by mail-yb1-f178.google.com with SMTP id p13so6774325ybm.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:52:06 -0700 (PDT)
X-Gm-Message-State: AOAM533+oefX9606DAHuIN5aNiFjQTxbe3IU6U3euPM/wYDmrnCgXd7s
        boSP8DAMkbQn6tb0N3Dw+dVg5HFUZUSKJ+q9dlo=
X-Google-Smtp-Source: ABdhPJzDNETBbskTFEfKk8IpKv2OrM4G1jtncn3kO7XmzWMj4qYZvUerA1LHtACXqYEygNZdRXVf6lTmGjXQaEZfgNo=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr3648878ybf.106.1654152725143; Wed, 01
 Jun 2022 23:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220506191339.78617-1-nick.hawkins@hpe.com> <20220530070626.GD1363@bug>
 <DM4PR84MB19274FE59381E204CBCFE55888DF9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <20220601205723.GA10927@duo.ucw.cz>
In-Reply-To: <20220601205723.GA10927@duo.ucw.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 2 Jun 2022 08:51:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3J_JoM_QGD2wpXXs=PPNwrhJQiS9aA5gTRacsYRQ_iGw@mail.gmail.com>
Message-ID: <CAK8P3a3J_JoM_QGD2wpXXs=PPNwrhJQiS9aA5gTRacsYRQ_iGw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] ARM: hpe: Introduce the HPE GXP architecture
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zwgWsyRakFdCvFEHrMSXBLeXMDL+n/Z0rxcKJdZSbBVBXJNb7c9
 bYAZq9zFmmwJX6clq00pOqKTC8clNSclmkcSoW3qe/ifXhERMBLkhNCxT8AcU3ccGs8H9ID
 AAXhZxq+uIIYZ8qeAT1v/73+k1Pivd7hfl9CNkjEGGAhLCNt+HFRRpf9b0vF8Cray6qHdMU
 CgeVJ0qggX/sabsSKDQ/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wHWPCVJ7QOk=:tjLhCqo9VgP6ZhwfYNYHXh
 bJb0LVAE1hPiA8gCJbw0j75vICYorAOai5TKUqcr5oGWfsDjQynVSJtQ3JG8t3DBG78jjszf8
 +Q4rQKxEd97z6O7QD5UykXgDprwsAY5fe89E9JtVUVctr8JCgdoonS3g8jGtXjw+WSaGupK5J
 aPZtyxVhbGcTC6xc4FiV8Yl9LSYnVOTMPeSrQ0Fst1T4Ime0zccvpOMUNgTyihAoAoUFFXcTa
 6nQOAzzzt2Hq+fjJ9JAm2lYrHt2rgwFvwl583l11AZ99OYEx1yNO8luaD+Sb9wuNpr+AGXDjF
 0CFKAjJaVxZV9JZtdlmHLyNDa3b4ZsYGgGyamGwVCSG3uUinX55U67JDocyc5w7kQkoh3pUog
 ItxJBl4x4YNMo12Ri2cGaSL5PTk/wP1Qzi0VQbtUkrnhfcJLBj1x2NBLaNsxy8FAagJIK3pOT
 GRY3b1QzgKXMzWHs/NLycXGXp/gPxcULK38sAj8vxNgGzGsKducnBfBw3NpDQrOY4W0YHdwZ1
 oYCxSRLMAic5pKbxRMpkMRxDbiQwO2d5v6CmYTUZ5iVrynItYuPBf79TNQM1btMyBnAjlQ9zq
 xVCMRODZHrj1gJp7W+QKzWohdJybkVXIDsdr/sMQ95tfGeY+j9pX/54j8zbyFvpIu/7DtGz1Y
 /mKrBXRtGJjDRivTgovSnjr3nUxv12ZEONe2oQbEviztyQrkKoIRAj6idNRansvpsrS3xyCce
 OFCfQe6U8IRpFNIPbIhkmAayb7o6MTbmvO0B5Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 10:57 PM Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2022-06-01 14:14:33, Hawkins, Nick wrote:
> > > > From: Nick Hawkins <nick.hawkins@hpe.com>
> > > >
> > > > The GXP is the HPE BMC SoC that is used in the majority of current
> > > > generation HPE servers. Traditionally the asic will last multiple
> > > > generations of server before being replaced.
> > > >
> > > > Info about SoC:
> >
> > > Normally, 1/7 goes into the same thread as 0/7 mail.
> >
> > Hello Pavel,
> >
> > Thank you for the feedback. I believe the code is already in the process of being merged upstream in version v8. For future reference can you elaborate on what you mean?
> >
>
> You used separate email threads for 0/7 and the rest of the
> patches. Normally, they should go to single email thread.
>

To clarify: the way this is normally done is to prepare the series using
'git format-patch --cover-letter ...' and then send it using 'git send-email
--thread --no-chain-reply', which makes all patches a reply to the
cover letter.

       Arnd
