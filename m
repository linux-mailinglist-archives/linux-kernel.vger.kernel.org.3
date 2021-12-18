Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5E479BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhLRQiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 11:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhLRQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 11:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639845489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CLjo1gIDUoeSbGFUtF3PQ0rguEl4NPT/joskNAW2FvE=;
        b=Ga+pgJN1nAjAWpJTv9xE3Fc9YsQOl4s4TnWURsQiTgcnHh3xufuPurqtOJw4bqXkQudFIn
        jMuNKs760hJuxHP8GZY4ZkyA5IcPv58Zm/iYqrfDU8Iowpnb/SKAN6htA2OHyZpbrf4bbi
        Sx6nRZtKIHuJTE4JtgDcMeupQbkE5XQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-r9mGJTKxM-ym7w2Kwm-y6A-1; Sat, 18 Dec 2021 11:38:08 -0500
X-MC-Unique: r9mGJTKxM-ym7w2Kwm-y6A-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so2553257wmq.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 08:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CLjo1gIDUoeSbGFUtF3PQ0rguEl4NPT/joskNAW2FvE=;
        b=KbmHgQqQ7/krxmp7p45IB8Q0Hq7+72LA9fAVDu5xlOPcjt+CqMVElzLVhfeIfbTwGb
         FdqO+nDmIUyBBvG9E0VOnuhg3vcTnfEgxaOe9Ylb+xf7aSvau8PKDzPWra1atV4SVso+
         n0MHptiMF4S5U1PGFwoAWKfNDeM3RPPJY6DE6zmaX8kO9FVZ8Dnw/DH4C3qn2E1Qc124
         mYAFj3/kn941MgmFVIgyzIgLyghdoFyTmQWvmpHgyXiooS/mJTq9hzVIvhzcy8eAQCcU
         4ZW8ESICzIF61ccsYYcwnWW6JDficIFg3Q+FL9eunMhAugHVQbrxTaEObghSDqXct1hK
         998w==
X-Gm-Message-State: AOAM531v4zBtdszbXC+T8LhXn2HV/uu1O2k7F9P890PsMjjTTRkY0iYV
        nMePx+uVzP99gz68IDstzFPEgEuRjWWQxV9jO/VQypobHuD2d/l8ywc/adB6aZTrqRY6Vyv0bfE
        5zlhuFS6Xw7ancnnaYOmXs4Ub
X-Received: by 2002:a7b:c207:: with SMTP id x7mr14117465wmi.108.1639845486646;
        Sat, 18 Dec 2021 08:38:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh3Is+RVwzODBIrmxqGJuDjB6gew6nN8H58Go6LndbRVZZq5vyNL1/XHLTmSm4bAfWxEYlzA==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr14117453wmi.108.1639845486410;
        Sat, 18 Dec 2021 08:38:06 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3511:9200:f938:102b:34c2:d5db? ([2a0c:5a80:3511:9200:f938:102b:34c2:d5db])
        by smtp.gmail.com with ESMTPSA id v6sm13680159wmh.8.2021.12.18.08.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 08:38:06 -0800 (PST)
Message-ID: <fd01689470411c409e0e568e6bb362435c29c968.camel@redhat.com>
Subject: Re: [GIT PULL 3/3] bcm2835-bindings-2021-12-13
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 18 Dec 2021 17:38:05 +0100
In-Reply-To: <98245a14-2fdd-347d-0450-f649d795695c@broadcom.com>
References: <20211213123040.184359-1-nsaenzju@redhat.com>
         <20211213123040.184359-3-nsaenzju@redhat.com>
         <bc9a960f-7577-c3cd-a58f-91c165f3e06c@gmail.com>
         <98245a14-2fdd-347d-0450-f649d795695c@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-18 at 08:34 -0800, Florian Fainelli wrote:
> 
> On 12/13/2021 7:38 PM, Florian Fainelli wrote:
> > 
> > 
> > On 12/13/2021 4:30 AM, Nicolas Saenz Julienne wrote:
> > > Hi Florian,
> > > 
> > > The following changes since commit 
> > > fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> > > 
> > >    Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    
> > > https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git 
> > > tags/bcm2835-bindings-2021-12-13
> > > 
> > > for you to fetch changes up to 4e5be177f6d2545dd639f41138af3b138470c61d:
> > > 
> > >    dt-bindings: soc: bcm: Convert brcm,bcm2835-vchiq to json-schema 
> > > (2021-12-13 13:10:11 +0100)
> > > 
> > > ----------------------------------------------------------------
> > > Stefan Wahren converts VCHIQ's bindings to YAML format.
> > > 
> > > ----------------------------------------------------------------
> > 
> > Merged into devicetree/next, thanks!
> 
> Nicolas, do you want to send me an updated pull request with Stefan's v3 
> or should I just go ahead and replace it? THanks

Hi Florian,

I was waiting to see if there was anymore feedback. I'll send it this evening.

Regards,

-- 
Nicolás Sáenz

