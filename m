Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDE5501C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345068AbiDNTt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiDNTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:49:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3DC90FC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:46:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf18so3964002qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHFyNRnOj/Hxzbtit9ErbPyMn3ggMxI97B8KNHlSfnA=;
        b=XmBXwU+6Qz2sJFPbjWiAhS2IElnJo3bLBXUs7w53UyBUWGzxaImzO7bmue2bTlHVsz
         pj86/B+0QIb+YY/CmD6qV7kvEJDg+Z3yOLNxhXEnYyRtHY7D4mfmxpdf41MN8T9dsHUu
         qobIpJwyg2zNKQXFkCatxq9HKGiBoK7XCcpYCq3Uu+CUeCPweUX4o5yI2nngnTe0H1m0
         FdDadaX110mnc8iUxE194XGSFM9Pmnh7lb/rmF2Ty9ISksoDfylEKFQm5x5FSYrUdjJZ
         zjXsNx51beK0WfOU1QqZLa4+7XqMURWAl4his/iIc6KB/DQBlEjEIM8a80lM/sygYGmU
         kihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHFyNRnOj/Hxzbtit9ErbPyMn3ggMxI97B8KNHlSfnA=;
        b=vPBxIKxWXEbFmK3ji6GkAPbaAhYEIpbRyxXz6Grp4Bn7NJEQR4lBjwHDB5gSpJDD2D
         1+7JhN1v0Wfuff3rGOmU0Bn93qieTsHMp3yYS5zFKUs6WNg2rPY8qDESEqN5SvdycdHe
         CT+bGenN64vLOcBmMPbs4kpyd346WybL/K+SpQIY88zb2N3xIvEYxDlPDBT/tDKsEHk0
         zC1e4fzFcN0459MFzpAqbGpSBReDEJRt1G/5mihAqGZwf+sjAW6pVG3fdFrb3JwsPJOJ
         KJDwtrbpdzvJT6DeIMYvMk+j2ow24MDyZX09WczRLOq9ySU7IPQBJTLhoXECYdcnjavX
         4zxw==
X-Gm-Message-State: AOAM532OqOMJmUyX4GtYnP6qgZSehW9+cJJZ6CVw+B6mm0SjyUsqeamH
        sWFjizn5T0iQDI3LNLp/UBs=
X-Google-Smtp-Source: ABdhPJwwxLI+rQE00DqqustI+INL2vQrHLXTZ76110K9L8pdQP6KkWX+uyARX6v+p6R29zzFIj+D3Q==
X-Received: by 2002:a05:622a:50a3:b0:2f1:d143:e533 with SMTP id fp35-20020a05622a50a300b002f1d143e533mr3098282qtb.208.1649965616139;
        Thu, 14 Apr 2022 12:46:56 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm1632590qti.20.2022.04.14.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:46:55 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:46:51 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 4/6] staging: r8188eu: place constants on the right side
 of tests
Message-ID: <20220414194651.GD4144553@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649880454.git.jhpark1013@gmail.com>
 <d2469155c37b8677a8dcbed28bc0840745d46f76.1649880454.git.jhpark1013@gmail.com>
 <eda6a3a94b768f06e67581bbc4d9974b391f0651.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda6a3a94b768f06e67581bbc4d9974b391f0651.camel@perches.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:16:58PM -0700, Joe Perches wrote:
> On Wed, 2022-04-13 at 16:11 -0400, Jaehee Park wrote:
> > To comply with the linux coding style, place constants on the right
> > side of the test in comparisons. Issue found with checkpatch.
> > WARNING: Comparisons should place the constant on the right side of
> > the test.
> []
> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> []
> > @@ -1997,19 +1998,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
> >  	else
> >  		pnetwork = &pmlmepriv->cur_network;
> >  
> > -	if (0 < rtw_to_roaming(padapter)) {
> > +	if (rtw_to_roaming(padapter) > 0) {
> 
> Do you think this change is the same test?
> 
> What happens if rtw_to_roaming returns 0?
> 

Hi Joe, Thank you for your comments.
If the roaming trying times is none it wouldn't need to associate with
ssids. And we wouldn't need to go into this loop. 
I think this change is the same-- am I missing something?
Thanks,
Jaehee

> []
> 
> > -				if (0 < pmlmepriv->to_roaming) {
> > +				if (pmlmepriv->to_roaming > 0) {
> 
> here too
> 
> >  					continue;
> >  				} else {
> >  					rtw_indicate_disconnect(padapter);
> 
> 
