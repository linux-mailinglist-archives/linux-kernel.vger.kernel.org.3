Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6163648E192
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiANAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiANAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:32:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D90C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:32:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so13028398wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KlzgoeIphsWtbK6+VtD88aVKqCm4pOwdtls8/CLOXkE=;
        b=06t5TCnFYjUobCTtTnRue9V6YcrweMimjAEa4YzgiKwtjWhdsrR77J2SlGuf/iEZ65
         HCrCHxXONUhfe1leuumwj3LM4vtSiMy0U0lwX4rfHBsCdrISZ+OMJAfliWTNR+E6Bch2
         49C67TZGgAtdvz1hi37aG7iN+o08TYp7XPkwC9WuPm1o+5482JBRs0aUHLJyHQyUSYvx
         T0gy/J/X8l0HSrTWjdNah/TnAUS0eMTuhCezBIm4SM2uhFhh7DIZwjuFEf3YqtQIrzUz
         JoNDi/By6ofnU5Acinuv9IN4Ljx/Ec0UEJ+cL0wCEIBgh4+3PricbSM6Nau6I/l2I2j2
         0TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KlzgoeIphsWtbK6+VtD88aVKqCm4pOwdtls8/CLOXkE=;
        b=bGZud/I/OBpb9VF0DIcxLYwvVmPpVWOJ980IctL8/cl2TPeR+LrhCWdGR9PcO6LX4m
         tOks1AbgcPWO9xtJqWbGSrYhoaUgOaofljFUK1unVFGXsEXrlw8VOiVFD2vHp4o72Q5h
         u9po0fQtENPVf62vURC4q9tenkgk9UNHKnYAF7/9WjXX74j5qrCm3Kvee7MXhU15S2u8
         uFvrTMsvknjJ6272bSHPrJKMsrKOPh5NreEMfzfv9ji6ae3wLxUz+glD3tMWol0w9QN7
         RUA+W2L8iVQ1q6cgcQQ6flH9hJFiaoCK9brcRdKU24kRlH7wyPiOWnE1KDVg7LIMoivz
         91Vg==
X-Gm-Message-State: AOAM533kBECw4TXTf/IlUS4yPXUhjgILuNOFh+eqGdPSz/8zRHKHUTIh
        JKEjA30bSui1X3xzWYFiQL6UyQ==
X-Google-Smtp-Source: ABdhPJxIxU23ZFw7SgW+EYYPZ0nrj6BYFkziYsFCgTIKo9oHokqLByvSQcfQmoaKsCIF+fi2IYcJVA==
X-Received: by 2002:a5d:648b:: with SMTP id o11mr6339386wri.227.1642120372431;
        Thu, 13 Jan 2022 16:32:52 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id z17sm3946965wrh.87.2022.01.13.16.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:32:51 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:32:48 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 7/7] staging: r8188eu: convert DBG_88E calls in
 core/rtw_sta_mgt.c
Message-ID: <YeDEsOz8GkNPJYJQ@equinox>
References: <20220110090020.6800-1-phil@philpotter.co.uk>
 <20220110090020.6800-8-phil@philpotter.co.uk>
 <32d83cb4-ceff-a5c5-be62-a8fe99aac3de@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d83cb4-ceff-a5c5-be62-a8fe99aac3de@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:05:09AM +0300, Pavel Skripkin wrote:
> Hi Phillip,
> 
> On 1/10/22 12:00, Phillip Potter wrote:
> > Convert the DBG_88E macro calls in core/rtw_sta_mgt.c to use pr_debug,
> > as their information may be useful to observers, and this gets the
> > driver closer to the point of being able to remove DBG_88E itself.
> > 
> > These calls are at points in the call chain where use of dev_dbg or
> > netdev_dbg isn't possible due to lack of device pointer, so plain
> > pr_debug is appropriate here.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/core/rtw_sta_mgt.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > index 54561ff239a0..de5406a5870c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > +++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
> > @@ -104,7 +104,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
> >   	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
> >   	if (!stainfo_offset_valid(offset))
> > -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> > +		pr_debug("invalid offset(%d), out of range!!!", offset);
> >   	return offset;
> >   }
> 
> There is only one caller of this function and it also checks if offset is
> valid. I think, this check with debug message can be removed from this
> function.
> 

Dear Pavel,

Thank you for your feedback, much appreciated. Good call on this one, I
can take it out in a subsequent v3 series.

> > @@ -112,7 +112,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
> >   inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
> >   {
> >   	if (!stainfo_offset_valid(offset))
> > -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> > +		pr_debug("invalid offset(%d), out of range!!!", offset);
> >   	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
> >   }
> 
> Is it safe to proceed with invalid offset? Debug message says it's out of
> range, so might be we should just return with an error?
> 
> 
> 
> 
> With regards,
> Pavel Skripkin

I would need to check the code, but good observation. I wanted to limit
the scope of this series explicitly to DBG_88E calls, but might be worth
changing this at the same time.

Regards,
Phil
