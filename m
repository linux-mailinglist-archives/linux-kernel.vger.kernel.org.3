Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75F948B610
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbiAKSrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiAKSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:47:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51857C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:47:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso6914816pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EBGPmf/4b8LtJ6IRDoixNp9baHgCn1IFhp/o+iuQRBU=;
        b=paSVu7fL/cMC9s/i+J/cExD+hEW0YlScO5DY5d6qIamg46PLj01KzSDaYsEgIPj9bM
         iMj1E59D9pH7RAY1xKwdJIuhdVy/SGwl0fHlIpTaKVZ0AURFU3Ygx20rb+ndC3LlxIAC
         IfisQE9vpefbDBjUgG1oxovdaC/ByCzdd32zjZWfewOixPo5l5zDCIbSiRn5atwc2nJI
         nGX3TqMrl289lw6D0XvWN1y8SYzk+KJtzHNpepbclb23sXmGmNH4ZEbvCTGNooan+I28
         ymi7OZ8CDEjVF0LPYZqZ/6KnCKjtXl39XrFW5xWXFf0l8rE9rGShpZxEfpHv6WI4R9OI
         PqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EBGPmf/4b8LtJ6IRDoixNp9baHgCn1IFhp/o+iuQRBU=;
        b=LaL008ZPFl0O8ZkS/mm7mOAIZ7cRzUkmNNGO2W5qyZn5dk7ze6jH8Pttus9LEj4F76
         DsbbX7gsqYpXHxM07WYAgbDv7qbrw0a+4WxvxKoBT9Td0ea7L+RxP6UALm2ZNTURw5sv
         jFJsseze3Qi8uqpIuSrV5L2ZGAFt7TAVR99d7GApwY4lo2Zq3E3xMeRI0irsPNaa9v6C
         6nivZrikgkQXrCbQ0ZTKM5oRAOdskK2GtHzRW0P93b7LPkuDAfkWRD0ZZ+GX2+oUjzB6
         g59djf2KuexVqS9KoYJpJ64fH1Tq7tv/S1ADX7W3vGJd7FfGyL91Um2gP9dchbe0GNOX
         715A==
X-Gm-Message-State: AOAM533zym20TGzo6BNaO6N8ob/FqGd7o+qF0pM7wl8g1/dzXvRs8I03
        7LCjFhQdqN1nVnNyMzRYtEEFxg==
X-Google-Smtp-Source: ABdhPJxnaXAlz26FFDOUJctx5xKwiFMkun3rvJ0Q1Mof/Urwu4EWmqRQOOvbSVmnouRM2uJkVIDd3A==
X-Received: by 2002:a17:902:d503:b0:149:16ed:d15f with SMTP id b3-20020a170902d50300b0014916edd15fmr5893872plg.102.1641926823855;
        Tue, 11 Jan 2022 10:47:03 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id on9sm3256638pjb.35.2022.01.11.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:47:03 -0800 (PST)
Date:   Wed, 12 Jan 2022 07:47:00 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Message-ID: <20220111184700.GA10070@nyquist.nev>
References: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
 <Yd29tk6ZJgDFDvVI@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd29tk6ZJgDFDvVI@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:26:14PM +0000, Mark Brown wrote:
> On Tue, Jan 11, 2022 at 01:00:09PM +1300, Daniel Beer wrote:
> 
> > +  ti,dsp-config: |
> > +    description: |
> > +      A byte sequence giving DSP configuration. Each pair of bytes, in
> > +      sequence, gives a register address and a value to write. If you
> > +      are taking this data from TI's PPC3 tool, this should contain only
> > +      the register writes following the 5ms delay.
> 
> This doesn't look appropriate for DT, it looks more like it should be
> loaded as firmware since systems might want to support multiple
> configurations at runtime based on use casea.  It would also be good to
> have code to validate that any supplied coefficeints/firmware don't
> overwrite registers managed by the driver, just in case.

Hi Mark,

That was my initial thought, but the problem is that different instances
may have different configurations.

We don't really have a way of validating the configuration here, since
it's typically generated by TI's PPC3 tool.

If you think it's still inappropriate to supply the configuration in the
device-tree, do you have any suggestions?

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
