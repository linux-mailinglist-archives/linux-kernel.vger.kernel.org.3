Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8289C4BD065
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbiBTRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:31:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:31:36 -0500
Received: from sonic301-32.consmr.mail.ne1.yahoo.com (sonic301-32.consmr.mail.ne1.yahoo.com [66.163.184.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DED2409F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1645378274; bh=stLzmJif3JsDPnLrx1c01Iyxz59e3vU+zR7HdCG4h/Y=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=DHoSSndxNFKxGnzeb+j0YgYbveQtYOTDWrDloM30Xq1nVYcPDx9AehnaUcHxY0o13ZZkTm6zAjOzPOGkrspw18y0O9Eo6n1VytpS0a8L+0Jsj9BLXozS6tXEfVX1qrj5+JyBaaHOaTBvi28eurbYemDZrJF4PmSZl4wCjAL1u6Eee94yAW84EkQ83pJf5F/YPe2K+8d9wDp/Pgq1LjScWUPOMLOTOI22857dDa6oFmIzJ4uAOdnUUk8mkBUgY4NggcnhYJ4cmVoRy1uSlIu74W61ay0yAqzSYXe4QKEyUyZEf0lEWNH3mlekFUq5/6it+S9/QszYOmhj6GOQm9G/lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645378274; bh=uSb43o6K9HvrzctQhzcqRf/sRuLcezeK3yQkILhgndZ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=U6p2cb9THs8M4libf1xmLr9JnS4HPepbzIrwb20S86V8FSFrsm5Feu7IgWZWu0kJIaUj6i/wfPtkJDnTR7azFa5g16o/gFy2b5hrkGG2UMrylPRYutE+kdpFcP5BPtJ1Uyl1x5Smf1roKdV1QrMD1vzv13H4Iq+SMOjRrLFbjeDwe5pQvOIms7M+JydeT0RJz4pwNhUDAniYDmYSgaDt59kINtCGoO4Dbfa5xXbjl8Y5VrSPG2Ai1jV34puDyouc5QPWhAPpJKPM8b+BvB1nJr80aFhcZ6rHFx8IhmhM6TDWA65/Sknm8YO6yCF3zUAeJjSI36HOlmGygvxNeMO6MA==
X-YMail-OSG: 8FyqS9EVM1mbaqc7XPjb25YYbmSVXBA4MR2V2D18YaaZLnD.6bfZn0juFJessY5
 nEiWeVBLob_0IfIziwAVzjq1CEVrZ4LWas3HPUP_rVsDhMtPZYMeSXbWopx1j7aY7Xnmnj_R7mkM
 .8we2oqe9Hp5A48pXRGrFy5kZreHw58qxVUN8QuWG4dN4B7b2vOYuYei3as0d4zv7lOhkBgauz6u
 Dt9PXK9M4rKGse.smJFtyVYBZx0WEFHxSNmCU1xfOShJ1ma8g0D.0iRkwpLt7HHiWTFhYj88hdzO
 2ZL7Ikl1kaZlyL.JJfptC2FkDDSV50ZjjZCRZ93JFcqbZHymGHmA0ffGPls_jk9cm1goO7Q1Y3j2
 0s7x1mvcUEzR8pI8oOd6VDV6PqvliCcLU.2dxV8kQJPZsiBM2Cpk1SxfTQqT9UY7Su4qBIayjgzc
 85oJ7nZ63SscKlcNUs2XXjM7kt7Eig89i3dfU2r.5EdM9cxlRUfvYMD_wX0Zw3JeH2mey9rWhPop
 metQBopxJC2XqeY2ZGd_aRvcAuKzq.j.agalAoF5BccY.la7Q9fR8NifTcSbi08aDzPpwYx3xF8J
 hWQTqUmF4ZvSaNjicGyfUdRDO3NaTrlBg9gbzwxDDAxo9clKt9g4a65ZDbPYcbSh.pyqubjxlWnm
 eNK6toxEH7vML2P6EjhAR8aka_qWv.khCks6cHdFy1Xu8HfF_0b.YKPXNsIj_..nvDEkaTJMmsvG
 SpWlXFVA.dGAQZuIPB8Ah8SikvADm4xKjnpzc3RAMlPUnxDxNRGyL467O3VoVvW6Zo9itF3zefj4
 2KcIYpPbCuBrDzlp2UGxDpYrCxh21PtriYYdSR89lVKsb1bsSYBt1ZQNaMaQiNviDCBqFHmcQS2R
 VJX10hLX8pzE_CWQ._Is71i_i5jPEtWHvjzNkFYHfcsDTQThnWvWZlVNUhNu53myFSpqH.j6dTNh
 7NfvsG_LGIUw6P38MaSGHOiMetiIQWuKLVqPPgilo0KMgywD6qRshCpWYNRSzeFF9K0qOFV.QST_
 GQuuWQRyGr8lQNjN1dser8SusC7Jsaqi8ZSJfuQxzEug5QdyilztYW46KugoAhUvJGwrCI0xMp9o
 Isw59j7ev90A4okYwgq_ZlK0eYA3dLwQ9jdZA8BiIgmPkoaf1VthNTMk.phJTeCC24FfjY0u47FA
 DxEnFZgBw8Tbsv148cxZOLp8hMw7zVJR2IQZqPVwTWW5xiDBNewue2rpJYqt8CeBCmgzjYxjKuyY
 FvUEheoE_Tc.cOB3WDtFOOg5ZZnBeOzy_.Viy.QHnZhFu2fbpNpNFpguHKl_pks5WcXGJC9KtVKY
 ZYpSV4S7MIf1697leBq99Ef_oTNAqGVud8XqfFg3hymVK_ZM5LcHYsRx2j.2aG8nfySgV5ilGI.r
 RdtBS_QxqmGKNB36.olLgNAn9Iu8Pe9SDRW6HyKICQEswfUJo9r_ZoVOhfSU1it6dOGdTxJBnntV
 H0kXbqSxKhdrY8A9EEmxtZMtvh9pEz3A_ft8sdwVTn_Iq8aytrKsZvE8jh9kM0k8ZXPY1x2iCXKn
 6O.Nfi5ZQf5I.uvKgnoYHcl3gGLm5MJ2H5VswQN2TlTY67NQlMICRygnju4AIjD8PyibJm9PPf9e
 4rGtGTaAoOnnaIkDoJRRAhY5A.OnPAmmmjWgiPnr8aCAykX9PALdY_gQ9fnFP.jdM6kAR4CZqGEP
 TATQBbERmN4zr.ImR9YMIbrRYeD32f_Eo5DBxgcQs3iPxspHz_Q1LI_F1A_hlqXi9t2g.CpA14pF
 zyuGA2ow4485pfir0iAxEAONlydAu3dQBkQGw5FHXxlXf7u5pSUyaCDCaRX4hpTuM7X6YZEICIVf
 2TYGKRUiVjGgMC4DO796O.M3NsTCC2g6yPISkDbMED0Sp4_Dg8hPycaU0l3quOKEyveBdeOG1lsk
 ndb3zQq0uJw_clicnf_52GjDx_6nZbM_QQ.H4wE19DXrGiMJZbU8GFMZdOX4XFH6MLP0L0SObFIh
 Yi.AkCSRaRueJmkV8ceNNH5ZcJBbc2bFmsTIih2p3lM_WqW7o.5Os07HPAFeAjQR.XZkwOvqR8Pp
 3.bxVakZ4y470O0.dRB.a1iGLisDeEUKwTsXYicg94DgRwO18LENBTlSRgmDin0eKb1vYjFMbtM8
 NWXG_TYDJK0i8D1EATd4rayzhYfoGi98LydBsvoNFDUbFGwo835wUgYKRiozskRz8vTouGdTtdU_
 x
X-Sonic-MF: <marcelo.as@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sun, 20 Feb 2022 17:31:14 +0000
Received: by kubenode522.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8a2dcc81a07db2dcf1be2b4f9b04191b;
          Sun, 20 Feb 2022 17:31:09 +0000 (UTC)
Date:   Sun, 20 Feb 2022 14:31:05 -0300
From:   Marcelo Aloisio da Silva <marcelo.as@aol.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary braces in if
 statements
Message-ID: <20220220173105.GA11223@snoopy>
References: <20220218043705.GA23783.ref@snoopy>
 <20220218043705.GA23783@snoopy>
 <20220218114455.GG2407@kadam>
 <20220218125058.GE2467@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218125058.GE2467@kadam>
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 03:50:58PM +0300, Dan Carpenter wrote:
> On Fri, Feb 18, 2022 at 02:44:55PM +0300, Dan Carpenter wrote:
> > On Fri, Feb 18, 2022 at 01:37:05AM -0300, Marcelo Aloisio da Silva wrote:
> > > Braces are not necessary for single statement blocks.
> > > 
> > > Signed-off-by: Marcelo Aloisio da Silva <marcelo.as@aol.com>
> > > ---
> > >  drivers/staging/r8188eu/core/rtw_mlme.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> > > index 45eff3018d73..ad1d73a27548 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > > @@ -1379,10 +1379,8 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
> > >  	if (pregistrypriv->wifi_spec == 1) {
> > >  		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
> > >  		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
> > > -		{
> > >  			/* auto site survey */
> > >  			rtw_auto_scan_handler(adapter);
> > > -		}
> > 
> > Generally we prefer if statements around multi-line indents.  It helps
> 
> I meant "prefer curly braces around multi-line indents".
> 
> regards,
> dan carpenter
> 
Thanks Dan for the feedback.
I'll fix the brace for this if statement in another patch.

Regards,
Marcelo
