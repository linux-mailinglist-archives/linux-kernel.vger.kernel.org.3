Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D78504969
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiDQUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiDQUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:16:56 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371521BD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:14:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hh4so1582041qtb.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AS+oYxA2XxEM6bqJppDgwrZ4Gcy+rhF+IvOsgZDdqmU=;
        b=CLJQK5dlE5pC5Njy/nGh+0rfnirzmrcMxp+vgma56/SZeBl9a0889RpT85fG5t0u7K
         syD6JnagTtGda+s4MEYFqVSy/hxQJdodzEM56/KhoAKcR95JBSEcSlFarjue4jWmGYZm
         x+9zXJ/p4rc8hWAn66rO0Ej/Ncdb9YXPyp75jgpHJx9odZzkX2YMCmFwbYXNrSpQ5M1K
         7XlvhaHzfDDKxICsmxzMJuwdbZ2QOA3ZEWdRgmfgkJYgFMB5SiHkZmzrPshMG5squEBl
         WpoO6zIXGHEkoxtat6pfbDTpmvrYO7VPc9T41XsMrMyQ4K5ifDbMCSAdCCuzdHfC3Vni
         hl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AS+oYxA2XxEM6bqJppDgwrZ4Gcy+rhF+IvOsgZDdqmU=;
        b=GwbNp24mvLm4XwVfO1Th4/lPR1A8suQG5ORFcdKOnRLdkbVdvVyoVNfCF9+gVifWtO
         wldcI+Vk7MI3p/xuji5XpemyAzhWWojatG3H5BR67w74OUhFjiYPK6FllRjqLFm+1ymx
         8rWvmZXkYh6bS7nceobBe0wRnfImnklxYyRCuxcwFyqMSghyvVwdUcLUCrM2c5UjJ9qs
         etTf0FKJ0gg1lii4aTqXwZzwH6V/Oqtq/ODsb2mwP2tTaJ9AbW5XgV3aSNIGXjrqJyzl
         joKEVheNWwN1157zgmRgrWdRTmThHhdCS8NodKBwubD9homxzfKfOlH+brduZjNG/aVB
         T7dg==
X-Gm-Message-State: AOAM5320XCKOjTCxeUsp+7+/3LlrvJyhU+WtGsZVjQ7P7ZmOGWVM3tvw
        /etrVr5jAIwEA3jmVe/3Kow=
X-Google-Smtp-Source: ABdhPJxRrsss0dNrrASDRfM7j/fyvMDnWc0jDFzEXbOZZPbGtM0vRVweIABpHu0Xsz3wpEYKPtSgOQ==
X-Received: by 2002:a05:622a:155:b0:2f1:f9b7:383e with SMTP id v21-20020a05622a015500b002f1f9b7383emr3087124qtw.668.1650226459087;
        Sun, 17 Apr 2022 13:14:19 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50e6:61ed:4df2:ed9f:52ea:476e])
        by smtp.gmail.com with ESMTPSA id v67-20020a379346000000b0069bdb3bb132sm5811126qkd.37.2022.04.17.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:14:18 -0700 (PDT)
Date:   Sun, 17 Apr 2022 16:14:15 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
 <3608313.MHq7AAxBmi@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3608313.MHq7AAxBmi@leap>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 06:29:15AM +0200, Fabio M. De Francesco wrote:
> On venerdì 15 aprile 2022 04:48:32 CEST Jaehee Park wrote:
> > The free_bss_buf member of pmlmepriv is unused. Remove all related
> > lines.
> > 
> > Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
> >  drivers/staging/r8188eu/core/rtw_mlme.c    | 7 -------
> >  2 files changed, 8 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/
> staging/r8188eu/include/rtw_mlme.h
> > index 1dc1fbf049af..0f03ac43079c 100644
> > --- a/drivers/staging/r8188eu/include/rtw_mlme.h
> > +++ b/drivers/staging/r8188eu/include/rtw_mlme.h
> > @@ -319,7 +319,6 @@ struct mlme_priv {
> >  	struct list_head *pscanned;
> >  	struct __queue free_bss_pool;
> >  	struct __queue scanned_queue;
> > -	u8 *free_bss_buf;
> >  	u8	key_mask; /* use to restore wep key after hal_init */
> >  	u32	num_of_scanned;
> >  
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/
> r8188eu/core/rtw_mlme.c
> > index 3e9882f89f76..aed868d1d47b 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> > @@ -61,7 +61,6 @@ static int _rtw_init_mlme_priv(struct adapter 
> *padapter)
> >  		res = _FAIL;
> >  		goto exit;
> >  	}
> > -	pmlmepriv->free_bss_buf = pbuf;
> 
> Hi Jaehee,
> 
> "pmlmepriv->free_bss_buf" is assigned with "pbuf". The latter is a pointer 
> to virtually contiguous memory which was allocated by vmalloc() or 
> vzalloc() (I didn't check, but the vfree() in _rtw_free_mlme_priv() tells 
> me that indeed it was).
> 
> >  	pnetwork = (struct wlan_network *)pbuf;
> >  
> > @@ -109,13 +108,7 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv 
> *pmlmepriv)
> >  
> >  void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
> >  {
> > -
> >  	rtw_free_mlme_priv_ie_data(pmlmepriv);
> > -
> > -	if (pmlmepriv) {
> > -		vfree(pmlmepriv->free_bss_buf);
> > -	}
> 
> Therefore, here you are causing a memory leak, which is something you 
> should avoid :) 
> 
> Why did you delete that call to vfree()? 
> 
> I think that you are misunderstanding what Pavel said. Even if it were true 
> that the code makes no use of that region of memory (again, I didn't 
> check), nevertheless, that memory was allocated somewhere and its address 
> is now in "pmlmepriv->free_bss_buf".
> 

My understanding of Pavel's response is the free_bss_buf member of the 
pmlmepriv structure wasn't being used anywhere and that the 
rtw_free_mlme_riv_ie_data function frees the memory of the pmlmepriv 
structure so the second check is redundant. 

However, as Fabio said, the free_bss_buf member is being used and pbuf 
memory is not being freed.
So I'll revert the patch as it was originally (which was just removing 
the {} around the single if statement). 

> If you can confirm that this memory is allocated for no purpose you should 
> also remove the call to vmalloc() / vzalloc().
> 
> Thanks,
> 
> Fabio M. De Francesco  
> 
> > -
> >  }
> >  
> >  struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* 
> _queue *free_queue) */
> > -- 
> > 2.25.1
> >
> 
> 
