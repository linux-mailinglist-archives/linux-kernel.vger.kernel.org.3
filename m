Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF05049AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 00:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiDQWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDQWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 18:03:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A6634C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:01:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so24055252ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtwSwKHxvQg2zlm6kaPIkHmv4vJJ4TgMpLArTx9nMTk=;
        b=N+ftmGGkeBsUXnMkxCA7AVVmpWQRA+37MSw9ui2XtKchj9xLlk9Ue/kT1eDK7IP+tn
         mOKzprMirSfavzuBIp7Tg0Whdnv5cD9R/O5k+XdmdMm50r4rfufypffv65bqiN9QkSt4
         prXrbeNdBaHLDLFY8N3eHvHLh7fPSZ8jI2+AZvfAPr+ipEiQM8HVqjiX/FH9mbmzUIXr
         P1578CZhRcRELAmfZxxYAoz6T68uat1uVtDkLSF1bhRki1Z6IBns0FSbZa36KZf875k+
         czM7S8qVbpyuUl7+e5fbHD4gZq3EsHbT6n0FMAXGYvEaslunVuWOBHNZIqUSEk/Pivp6
         YJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtwSwKHxvQg2zlm6kaPIkHmv4vJJ4TgMpLArTx9nMTk=;
        b=t2o061ioTB0FohTorGr5oTJ1deD4PzaatxPdjEOTfsVSVcCG0i10vbH6IBASQ5ncy3
         QetbWBosmVBmaOmG9cT75JRrA4tCZMip8VL9BSPkhRZB55h0cLOnleydMFfu7mnRXCQd
         np75bMWBHMMQ0FpWihquI9g/TJtITjc63gNOUWqKn6+q7/dXuW7MxzFpQpGa4FOjNZ6R
         +7Ut03JLIF1uSQkBQ9WZdoutFuiHNH3RGZPFG+wZUUzDC4nIWD/q8khyBmFjHUJxjmwe
         2ywDMDDAVT8KIAj1XVuggwj7MHos1to3zOh1j1U3phDR3hzstjo17InGeD66n+q27tK/
         MXGQ==
X-Gm-Message-State: AOAM530dZRUAms2KxPDQUtws/L7xA4KT7c2qIRmNicIb3M4srmtbVa46
        opvYWWdrsUJF9ThS5+O35A4=
X-Google-Smtp-Source: ABdhPJyOcrwE+vW0uWdyga/v0UvMb+hTCda7Xrxo4w+xnODxG8gFJS4tGjUDMkuZFKLLou2A3BX9Xg==
X-Received: by 2002:a17:906:974c:b0:6e8:9453:4209 with SMTP id o12-20020a170906974c00b006e894534209mr6993992ejy.755.1650232864313;
        Sun, 17 Apr 2022 15:01:04 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm3996407ejb.179.2022.04.17.15.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 15:01:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Jaehee Park <jhpark1013@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member free_bss_buf
Date:   Mon, 18 Apr 2022 00:01:00 +0200
Message-ID: <4396697.LvFx2qVVIh@leap>
In-Reply-To: <3164900.aeNJFYEL58@leap>
References: <cover.1649990500.git.jhpark1013@gmail.com> <20220417204200.GA236965@jaehee-ThinkPad-X1-Extreme> <3164900.aeNJFYEL58@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 17 aprile 2022 23:13:50 CEST Fabio M. De Francesco wrote:
> On domenica 17 aprile 2022 22:42:00 CEST Jaehee Park wrote:
> > On Sun, Apr 17, 2022 at 11:16:38PM +0300, Pavel Skripkin wrote:
> > > Hi Jaehee,
> > > 
> > > On 4/17/22 23:14, Jaehee Park wrote:
> > > > My understanding of Pavel's response is the free_bss_buf member of 
> the
> > > > pmlmepriv structure wasn't being used anywhere and that the
> > > > rtw_free_mlme_riv_ie_data function frees the memory of the 
pmlmepriv
> > > > structure so the second check is redundant.
> > > > 
> > > > However, as Fabio said, the free_bss_buf member is being used and 
> pbuf
> > > > memory is not being freed.
> > > > So I'll revert the patch as it was originally (which was just 
> removing
> > > > the {} around the single if statement).
> 
> No, Jaehee. This is not what I said :)
> 
> > > > 
> > > 
> > > Why just `pbuf` allocation can't be removed? This memory is just 
> unused,
> > > isn't it?
> 
> What Pavel said is what I said, but using a different argumentation.
> 
> > > 
> > > 
> > > With regards,
> > > Pavel Skripkin
> > 
> > 
> > The free_bss_buf member is unused.
> 
> Correct.
> 
> > So it can just be removed right?
> 
> No.
> 
> 
> > I guess I'm confused by what Pablo is saying about causing a memory 
> > leak
> 
> A memory leak is caused when you allocate some memory and then you lose 
any 
> reference to its address so that it cannot be freed. Right?
> 
> > by getting rid of the pointer to the memory allocated by pbuf.
> 
> No.
>  
> > Sorry if I misunderstood. 
> 
> No problem. Let's rewind...
> 
> "pbuf" is assigned with the address of some memory allocated with a call 
to 
> vzalloc(). Since "pbuf" is a local variable, you see that the above-
> mentioned address is stored in free_bss_buf using the line "pmlmepriv-
> >free_bss_buf = pbuf". Is it clear?
> 
> Well, you decided to delete the line that calls vfree(pmlmepriv-
> >free_bss_buf). At this point you have that memory leak.
> 
> Pavel noted that pmlmepriv->free_bss_buf is unused, but it contains the 
> address of a region of memory that was allocated for no purpose.
> 
> Therefore, a correct patch should also remove the allocation that was 
made 
> using kzalloc(). 

Sorry I made a typo: kzalloc() -> vzalloc().

> If you merely remove the line with vfree() you cause a 
> memory leak.
> 
> Please don't revert your patch. Just fix it with a new version that also 
> delete the line where "pbuf" is assigned with the value returned by 
> kzalloc().

Same here: kzalloc() -> vzalloc().

> 
> I hope that now I've been clearer.

Did you find out where is the line that calls vzalloc() and returns the 
address to the local variable called "ptr"?

As, said before. You should delete it too, otherwise you lose that region 
of memory until the driver is un-linked by "modprobe -r <driver>" or the 
system is shutdown.

Fabio


