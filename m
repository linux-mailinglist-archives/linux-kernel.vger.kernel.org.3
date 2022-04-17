Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B133B504978
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiDQUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiDQUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:44:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A856429
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:42:04 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id o18so9020587qtk.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=siAKpMcN2i6Q5zwPWMFzdjMytkBZWIwEIG4ky16AcDE=;
        b=POT4kupDxVMVYxPM9uQ91fxJF+fbbvfcfAK6+sd4/52H+jBSq/EHv+JVS201vbVhTI
         58Ziu9h2KBrJMhG90YOixxlX5mFL3miqMxgkP+CWBQmQKAYw7uP7dvh/SlG/B4A6LQE5
         4hYureZf3iXY1B2JOyjwnaECwkaY4YxS/y/iy6ffD4rXUv9jjcZDklQfkTs9VCQwltIl
         17ZqlOOG+da029OX07OoI8PFbmvzBVo1L5bINDSoU6FvtCBbTAsJeEUYO8jr25hs0tE3
         IJk4sYY2cm5icEDjZ9MGfZa/Sbe9xyCgf7w44s50LieRSLt1SzdelfYd4SSCWylHAear
         YhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=siAKpMcN2i6Q5zwPWMFzdjMytkBZWIwEIG4ky16AcDE=;
        b=JRvw0TQUD4Li/xNiFVq8AzyzaRlhOwEyVjoTVydFMRSQYSsrWmoePs+W4x8TsjuI0n
         2vM9ZDlF6+R3ug6otY1/U/RGAzj6ATGKWzyoIf+WpzKU/IR+7kdSS6CQYbn6tyDX6xkW
         61mXEmpADaWtcaPEtiWFXEb00M02SfEXwaWnxBPSCVcE7G0YV/j/+CQf7Nqe4dedtffC
         3CMFLf8rihBmvS9m91ZyOGYK9Zl6h1n1zYbZFebyO6RLD7L9Y6DQPTeCga1AQLUMVoM9
         tESNHj+rhd53JRmmWwObKZGJHigxV4d3IIkd4JWYPWEVvzzQmKmiul3//ymc0HYqfPyl
         N6eA==
X-Gm-Message-State: AOAM532i/mP2wyQObZRi2mkjBq6MxF8DhPLMuVF6Q9/XKsfePrGAz7AC
        lORcBRQ5un1cofhrbF+DkAw=
X-Google-Smtp-Source: ABdhPJx0kCkCJfgKcw+kUzw+Q6cJHzf27oLCO+xIYKc13wBBsro0rB/QZNqK5Xbf9vslD4NrwrOWAg==
X-Received: by 2002:a05:622a:1109:b0:2f1:f7e9:1b3 with SMTP id e9-20020a05622a110900b002f1f7e901b3mr3868301qty.671.1650228123726;
        Sun, 17 Apr 2022 13:42:03 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50e6:61ed:4df2:ed9f:52ea:476e])
        by smtp.gmail.com with ESMTPSA id y20-20020a05622a121400b002eefd7bf5basm6706502qtx.63.2022.04.17.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:42:02 -0700 (PDT)
Date:   Sun, 17 Apr 2022 16:42:00 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 1/6] staging: r8188eu: remove unused member
 free_bss_buf
Message-ID: <20220417204200.GA236965@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649990500.git.jhpark1013@gmail.com>
 <e41e0d3b62395d04f41d6934074074c431e7aacc.1649990500.git.jhpark1013@gmail.com>
 <3608313.MHq7AAxBmi@leap>
 <20220417201415.GA233554@jaehee-ThinkPad-X1-Extreme>
 <a28f445f-f088-620e-6baf-4cad3e1a8146@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28f445f-f088-620e-6baf-4cad3e1a8146@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2022 at 11:16:38PM +0300, Pavel Skripkin wrote:
> Hi Jaehee,
> 
> On 4/17/22 23:14, Jaehee Park wrote:
> > My understanding of Pavel's response is the free_bss_buf member of the
> > pmlmepriv structure wasn't being used anywhere and that the
> > rtw_free_mlme_riv_ie_data function frees the memory of the pmlmepriv
> > structure so the second check is redundant.
> > 
> > However, as Fabio said, the free_bss_buf member is being used and pbuf
> > memory is not being freed.
> > So I'll revert the patch as it was originally (which was just removing
> > the {} around the single if statement).
> > 
> 
> Why just `pbuf` allocation can't be removed? This memory is just unused,
> isn't it?
> 
> 
> 
> 
> With regards,
> Pavel Skripkin


The free_bss_buf member is unused. So it can just be removed right? 
I guess I'm confused by what Pablo is saying about causing a memory 
leak by getting rid of the pointer to the memory allocated by pbuf. 
Sorry if I misunderstood. 

Thanks,
Jaehee
