Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC7493EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356348AbiASRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356330AbiASRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:05:51 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED5FC061746
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:05:50 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c6so9407899ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYhFZj7bN4GmfkpGkaypcnLkkrDkLgSpBT+XGsydD5g=;
        b=mIA0V51NKn2sgb6c50eVbnJ5qxx5W75tk1TI+G3HyWv4wKr/lV32rL3AZ52KcsXuYx
         heIq0u9vo5KgXspeyd+8pS5QbFss564saWV/iHJp9kkkwZyGmCU47xzv++/isrTLwdQZ
         6niZm+AZiWU+oH/DBBsJZk4MSYl35DUmEXOT7CjdtbSQKDt0DT5iI9pbx3c/WD0I0kYQ
         VPCTzKCkOZ+2ma2GeeN4Nex82FjDKb25ui+aOf87YPFdFnw1ZCH2RB7CRq09JhQErAEc
         yBNCVAyZiKkZVxhv5PnOAsmgRNDvz8dnPHEglaHyXrSs/BzI80+hPCfccT8+OKJ86MWn
         j4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYhFZj7bN4GmfkpGkaypcnLkkrDkLgSpBT+XGsydD5g=;
        b=Q2Ep0qD3sg8m6SFu+yfG+hRbTSV6cmMocWEbrE6G80nssVlnJvnTQSvCZh2cMeX/w3
         +NnjXeeXtVuOGof7/+49/1aajlJ6seDEniBUI+s/Cmmlc0Sdc/OX5MCMOLsqvHlXjBpw
         bChLArZqwoT1mUknJtRdNH0KH1ydIztWr651gEcsum7PLytPsbnnrz9OdxWV33PJmFWi
         RFKlXDzDm0nq+Hfc4DAHaFzreeQ+9aputFKYZ4w11kLiRUq199vKfFM9btUYuOJT4gG6
         FHHISvvrBIPAF2z8sqxnnT2lW5G4YuiGFkkkXulTZOVOKYSxDWR4OdK/1d9Tx6VPZE+g
         TPCQ==
X-Gm-Message-State: AOAM530ZimZoSAW29X7J6DqQZEKvWMUsc/6jtGJHBzoxuO32IfRlvs2g
        YmxCuG6hv2pTy5wwYvp1MCh3ePIi1su2vB+/RAQvj9FXkMc=
X-Google-Smtp-Source: ABdhPJyOW9d3AS7oBdQPamilXLaey5HZBJCYVDMerC5sglVNvpvYVmXkmE1Hi7bAmW34h372gn0zkSzR/jisOQDGB1c=
X-Received: by 2002:a25:4987:: with SMTP id w129mr40312318yba.34.1642611949650;
 Wed, 19 Jan 2022 09:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20220117120317.1581315-1-hannes@cmpxchg.org> <YeaoeQlAoj06qlNa@hirez.programming.kicks-ass.net>
In-Reply-To: <YeaoeQlAoj06qlNa@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 19 Jan 2022 09:05:39 -0800
Message-ID: <CAJuCfpHX9TUsfN572Jq+X0ru++LQGbzr9TuMimHmWLNYUm-kQA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Suren as psi co-maintainer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 3:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 17, 2022 at 07:03:17AM -0500, Johannes Weiner wrote:
> > Suren wrote the poll() interface, which is a significant part of the
> > psi code and represents a large user of psi itself (Android). It's a
> > good idea to have him look at psi patches as well, and it's good to
> > have two people following things in case one of us is traveling.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks!

Thanks guys!
