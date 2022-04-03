Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4824F07A7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiDCE5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 00:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCE53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 00:57:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF491CB05
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 21:55:35 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t19so5327867qtc.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 21:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kUho+lhvmxV7brTbWyWD6YBAbxEiznMLxM2RG/qNbi0=;
        b=C/VjivnMQ7u3WrE2jMPbSdDZ66Apq6t9jTvxgevpelL7gFXesHnmMuBMTb423wzHZe
         T9um4G9m00c+tBGrArgCttnBudMADQj/hBR/B37yqyaU0JCDuuFebOmJBvNx25FxDDCQ
         4386gXqEeSTAV+LFXYg3XIb8D3xVDpOjIxIDJKs0B70kLyU80C3P3fJJ++ChZMkAkXZn
         1CopDq3PBX0rUDeexfzKFSEDP3buvWAvB18vn7RWtxz6wNRj5TtuaEGrAK2myYaLXS8u
         RrRWugvGI33g6gdecB+X0/ulbHJnsH+xXJB2YGZr5BYqYk1B/M/MhbEHxEPJ/8D/h48N
         cPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUho+lhvmxV7brTbWyWD6YBAbxEiznMLxM2RG/qNbi0=;
        b=FTeMF7rtBDqWKcDjYAdOZnI4HfxqOCIcgXKW+yJ004JhtLZWc8echebxS7vNHKywlJ
         3svm5Efmq4TJ3CznCIeEmWF5WZZmU+Oko4gVAcI3cW7hHiDk90iG78VDTKyBYrs5/Il3
         kFt5CGOzp3O4arN81+jYw4GckWAd2yLtMEM1Mts0XRPjD+vDimfrjyk9WCVdx9g4eyPx
         lusFqRzO3opXV7/CkW/qqwPCEiCYV/b9wDLuJhZgs9dViJAAD2E55RGWqLn+fzX16lz0
         0xuKkLlQhnEOcTaxtIar7uMAVTIJpnOd8QosGK6oZywWosQiQB399NOZ1uAXxx8r/Gjv
         JmoQ==
X-Gm-Message-State: AOAM53224ycVfPtVqHlNnVpr6BMQ+eNPBiMJM5Q/BKU/nxFLpbaOB1kd
        8J58OGuL5BLMN1drBhg4KAY3kfb5yWD7rg==
X-Google-Smtp-Source: ABdhPJyjS3PusZ7wLVd4SqsMjD6uPEcBYYEPhF4QBQ+xq7Dt8koQL+u681oR/qxGQVCBHyeEL5dP5A==
X-Received: by 2002:a05:622a:1646:b0:2e0:6fe2:9f7d with SMTP id y6-20020a05622a164600b002e06fe29f7dmr13477824qtj.174.1648961734509;
        Sat, 02 Apr 2022 21:55:34 -0700 (PDT)
Received: from sophie ([45.134.140.181])
        by smtp.gmail.com with ESMTPSA id s5-20020a37a905000000b0067d35f2fdb1sm3990931qke.37.2022.04.02.21.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 21:55:34 -0700 (PDT)
Date:   Sat, 2 Apr 2022 23:55:32 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     outreachy@lists.linux.dev, Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] staging: r8188eu: format block comments
Message-ID: <20220403045532.GA12084@sophie>
References: <cover.1648888461.git.remckee0@gmail.com>
 <0387f3df49d89c17acf96cf072e70c98e81e58f7.1648888462.git.remckee0@gmail.com>
 <563ddd2d-b8b2-dde6-a0de-c7bbebcc834e@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563ddd2d-b8b2-dde6-a0de-c7bbebcc834e@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Sat, Apr 02, 2022 at 11:37:27AM -0500, Larry Finger wrote:
> On 4/2/22 03:50, Rebecca Mckeever wrote:
> > Add ' * ' or ' ' to beginning of block comment lines
> > to conform to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > 
> > WARNING: Block comments use * on subsequent lines
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_cmd.c | 29 +++++++++++++-------------
> >   1 file changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index 2e135bbd836a..0c659b40aa1c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -12,9 +12,9 @@
> >   #include "../include/rtl8188e_dm.h"
> >   /*
> > -Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
> > -No irqsave is necessary.
> > -*/
> > + * Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
> > + * No irqsave is necessary.
> > + */
> >   static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
> >   {
> > @@ -97,14 +97,13 @@ static void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv)
> >   }
> >   /*
> > -Calling Context:
> > -
> > -rtw_enqueue_cmd can only be called between kernel thread,
> > -since only spin_lock is used.
> > -
> > -ISR/Call-Back functions can't call this sub-function.
> > -
> > -*/
> > + * Calling Context:
> > + *
> > + * rtw_enqueue_cmd can only be called between kernel thread,
> > + * since only spin_lock is used.
> > + *
> > + * ISR/Call-Back functions can't call this sub-function.
> > + */
> >   static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
> >   {
> > @@ -319,10 +318,10 @@ int rtw_cmd_thread(void *context)
> >   }
> >   /*
> > -rtw_sitesurvey_cmd(~)
> > -	### NOTE:#### (!!!!)
> > -	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
> > -*/
> > + * rtw_sitesurvey_cmd(~)
> > + *	### NOTE:#### (!!!!)
> > + *	MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
> > + */
> >   u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
> >   	struct rtw_ieee80211_channel *ch, int ch_num)
> >   {
> 
> These changes are OK, but the rules in drivers/net/wireless specify using
> 
> /* abcd
> 
> rather than
> 
> /*
>  * abcd
> 
> Thus, if and when this driver is accepted into the drivers/net/wireless
> tree, another change will be needed. I suggest doing that now.
> 
> Larry

To clarify, I should make that change in this file?
And would it be better to make a new patch for it, or make a revision to this patch?

Thanks,
Rebecca

