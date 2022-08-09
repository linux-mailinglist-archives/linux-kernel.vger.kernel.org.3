Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76758D976
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiHINhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiHINht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:37:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CD19295;
        Tue,  9 Aug 2022 06:37:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx38so12982402ljb.10;
        Tue, 09 Aug 2022 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=vXfr9KBF4DgN/jcineippluN2rW/vBNsvOtV+uFngTc=;
        b=ZGc/4S8/9bvauWjgB79xOtMr/EyeLD9IdPKY5I7nJApJm+7yNCt61aVTtAxVD6DXMy
         fPuFGNIQHkPW+jUsOZu4M4fMIByIaursGfOIDrS3Sbu7KB+8GiV0uesuKfmIYh9hTOfM
         c79TRstZKlsfXUJapR9NBqh0CApDGVi3TJ6kX+05xiprAvTodbx7DxVjAoE7XF3uztGC
         e1/Z42C3EbHKN/r9blYS2vzWOv6BKNIeLhxT3L7FlFUObjmZa16MiCUdfqsaO+RlPu5s
         YrCTrwydDDseHi/UNB+9DKssA+epIpGAXRfynJ29q9jQvKx0rCxZdxXPoZufv5MU6RoN
         Ha3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=vXfr9KBF4DgN/jcineippluN2rW/vBNsvOtV+uFngTc=;
        b=BLDMJrZSnGassUpHMnjhxKDR0t4/LlaEm8Pl+6PP3g5Q/bHt+AhLOUJqDDCJ25/Y2d
         TTiAMNRy/JTFfb0F01KGue9QggTUDflMXfFH4L7/cwlLT5x2kl0oZ0sqOncXlO2xREwp
         mW/yoMEZZUJzw5pfvsY2EMGhP4WdjW2X5fZBvbukB9CHJAkOjLGS90bgrFMK7a6Jvyw8
         wtWobCTH6nBYEwalsbGT70Jt1Gxlh9sBTszmVp1DEFklVOZQNt1FRUUux3p8FGMbvxO8
         Tr3kEP3+JCitrnMoDejDWyliTDZ0xaXqs82Q2eWyMA9dF7jawSwb6Hyrt+SMN8c+RwHF
         H3og==
X-Gm-Message-State: ACgBeo2TMu8CK8paRMuIMPpbC45ujYRRIFwERx1mAyv42qNtC+tTdn6T
        8X7swWnFRg7oOcUj2smUIrhsAA6RM6voXA==
X-Google-Smtp-Source: AA6agR52admbmnFPbomhNq9SxayDYDRtMFVx+mT8e8pNao1FrfMD7fH7TevWndlAsnzlQERua+CkfA==
X-Received: by 2002:a2e:8e29:0:b0:25e:48fe:d2e1 with SMTP id r9-20020a2e8e29000000b0025e48fed2e1mr7781873ljk.312.1660052267187;
        Tue, 09 Aug 2022 06:37:47 -0700 (PDT)
Received: from elende (elende.valinor.li. [2a01:4f9:6a:1c47::2])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b0048af796cbe3sm1771359lfr.79.2022.08.09.06.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:37:45 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 9 Aug 2022 15:37:44 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: stable: Document alternative for
 referring upstream commit hash
Message-ID: <YvJjKHCo6rod8Yl9@elende.valinor.li>
References: <20220809045543.2049293-1-carnil@debian.org>
 <8735e5a864.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735e5a864.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Tue, Aug 09, 2022 at 06:54:59AM -0600, Jonathan Corbet wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > Additionally to the "commit <sha1> upstream." variant, "[ Upstream
> > commit <sha1> ]" is used as well as alternative to refer to the upstream
> > commit hash.
> >
> > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> > ---
> >  Documentation/process/stable-kernel-rules.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> So this is a nit but...
> 
> > diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> > index c61865e91f52..2fd8aa593a28 100644
> > --- a/Documentation/process/stable-kernel-rules.rst
> > +++ b/Documentation/process/stable-kernel-rules.rst
> > @@ -97,6 +97,12 @@ text, like this:
> >  
> >      commit <sha1> upstream.
> >  
> > +or alternatively:
> > +
> > +.. code-block:: none
> > +
> > +    [ Upstream commit <sha1> ]
> 
> Can this just be:
> 
>   or alternatively::
> 
>     [ Upstream commit <sha1> ]
> 
> That extra RST markup just clutters things without any advantage.

Okay, I just have sent a v2 dropping it.

Salvatore
