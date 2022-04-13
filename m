Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D64FEE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiDMEqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 00:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDMEql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 00:46:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA9C1F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:44:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bk12so567484qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 21:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZLPVnz8+CmyHrIBYurkIW2TTvDikbuZwnfUEIgf50uI=;
        b=nANZ40d7vawO4uMCRvgPuFdQC14wrez+F1spKBqrPRbKH/PbQhWPj3BukiLVnold9U
         0wojkJNsY/E/O3lZwDBdyV/13isiyg56SFHMum30GeQ7MI5Wf/DZFDN4R1G32WD6xGX0
         CLBFcVbLaS3pLQPo0qSRfDpIi+erD8//drjNs+KK0WU5rBicFeJqf8yEhHO2LP1gUIZO
         VSEo1ZYvh6MXAXGgL0PXgLBXlaV14PDz+1RGQhj+FMImklOK2cNXja9eacJOGDduK6Rv
         pp598Y/ISAHe/3kuBj/Ay5qTboJIMigTawILJSa59NyK7yV0Poy7rwUcusXQxPXhWbBG
         cbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZLPVnz8+CmyHrIBYurkIW2TTvDikbuZwnfUEIgf50uI=;
        b=iJwWJEki3oHIn3+Fj6M2KRXfchmdbtlQzRokGCd5GryBDSiF3rNtkunxNpw7BiZcYh
         bEoLYbfFiEGWzY2Mk1Tef0T00ENwQnUQE9ruirppwLWs0A7hWR9YK3EXr4Ajfn6Ku+O4
         HeVlPbGYFDN/Lh42t7WwgM6cmBZHUaz1w1DGLmXPXB9huIelA7nW+oj6P6iT/tfF260H
         jHIOdcCCy+mD8kcRMcj1nrqQH2e9MkmhULbMRbbHN4YYwADCFArZoKkzK/J13P0t9ZVS
         yQYv++rDCobHGNEr6I0NMXN8MH0QupuMpscLuXJcRYfIWm86lQHBhP+OuXunGhLl/0dd
         /oDw==
X-Gm-Message-State: AOAM532MxNg33wOwTyzl44ymTrXbNXbu9XRGN720D3UJ2QTAnBZ8VAk9
        GsEVhAcN//0+GtgHLBQ5eL0=
X-Google-Smtp-Source: ABdhPJxhvR9BbzTTdUPd0GN26sm1C64fuJ3oWzB8hVSptjitL40jxKTzif/wA+YYGD7UvYGksUmXDg==
X-Received: by 2002:a05:620a:4014:b0:69c:10af:d98e with SMTP id h20-20020a05620a401400b0069c10afd98emr5471620qko.633.1649825059953;
        Tue, 12 Apr 2022 21:44:19 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([2607:fb90:50fb:900e:5e57:caff:f44b:33f4])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm10232117qkf.101.2022.04.12.21.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 21:44:19 -0700 (PDT)
Date:   Wed, 13 Apr 2022 00:44:16 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2 2/2] staging: greybus: remove unneeded return
Message-ID: <20220413044416.GB3357359@jaehee-ThinkPad-X1-Extreme>
References: <cover.1649793138.git.jhpark1013@gmail.com>
 <d4d01ecdabc492e52a3decebf165d1f584f3b3bf.1649793138.git.jhpark1013@gmail.com>
 <5792471.alqRGMn8q6@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5792471.alqRGMn8q6@leap>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:35:58PM +0200, Fabio M. De Francesco wrote:
> On martedì 12 aprile 2022 21:59:15 CEST Jaehee Park wrote:
> > An empty function with void return type does not need an explicit
> > return. Issue found by checkpatch.
> > 
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/greybus/audio_codec.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/
> greybus/audio_codec.c
> > index 0f50d1e51e2c..3e3a16568def 100644
> > --- a/drivers/staging/greybus/audio_codec.c
> > +++ b/drivers/staging/greybus/audio_codec.c
> > @@ -1032,7 +1032,6 @@ static int gbcodec_probe(struct snd_soc_component 
> *comp)
> >  static void gbcodec_remove(struct snd_soc_component *comp)
> >  {
> >  	/* Empty function for now */
> > -	return;
> >  }
> >  
> >  static int gbcodec_write(struct snd_soc_component *comp, unsigned int 
> reg,
> > -- 
> > 2.25.1
> > 
> Hi Jaehee,
> 
> If I recall it correctly, Dan Carpenter suggested to remove this empty 
> function. 
> 
> When developers remove lines of code from a function which becomes empty
> after the removals, they also remove the resulting empty function and
> delete all the calls (if there are any left) at the same time.
> 
> Thanks,
> 
> Fabio M. De Francesco 
> 
> 
>

Thanks Fabio for pointing this out!
