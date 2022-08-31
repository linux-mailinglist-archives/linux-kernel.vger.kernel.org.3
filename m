Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAFD5A841D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiHaRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiHaRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:17:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE025CAC4B;
        Wed, 31 Aug 2022 10:17:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so14740714plo.3;
        Wed, 31 Aug 2022 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=id8ZvF9LfPH1Vxy7z5dNEHgiRdyi8KBwBy/JBc/Yqww=;
        b=kYU6eqRMcIUGpPZAvvilV7pOhoIz2NZrgE363sDDW2Kr5jzl46JYK18VSp/kwvC3ph
         oiZhlo1RlcBVVxeeOevK3VtFfBCvJJwS3EzvjcdKXAYdTd0lm46oAutzddhP27ysUzCq
         w0uvwImhT5gk7op6+UmVcUzSvQNU4zoSc07AP8FTZSIQSeEWWTH0xtsgxkDOp1ig0eyO
         D91gmtNB1sjYTXzI97GuQ7C046mi5aUB03r2vrnGRwrnEszcaHxUUhiQOU/AJtEH13xo
         loZYMe9G1YlEWhgSMBVuIFdedq+E83BtyKQDBqgziD6rZCV4+Sdadog7zs7mIyBe18/K
         7A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=id8ZvF9LfPH1Vxy7z5dNEHgiRdyi8KBwBy/JBc/Yqww=;
        b=ZMDKdBQ4/bD2GaKlEz7rSedHV2Iw41V25RuV9TIYTy7WBFx20Ry7tCefxR+lnEKK4R
         XvLd8h5EC687/i7JqJa3g+fOQee7pg2nF/hpi+WfsLeHpFgYnDO50MRAtmvhsScDDRjh
         Fht4JjAppbhcHVExxlooGnnLBRl5ZGA9XLBRYab9ebfK/IoiyrJw3rW6hslEWs9FryRb
         iptmW+24F/jb72WhYJBryq6vhBnfwAuRtMCik3OzzjAUbBUv0WyE7i/NUUJ8gBcPWTpJ
         EzMw4KcVeAnm8WY6ZCVoQsB8xKXRNM1HsehJGuaKfclE+bQNUIeZAsTGXeW1NXl1V8sP
         k2PQ==
X-Gm-Message-State: ACgBeo1HVxtpO5zY8pn/7VSso8LcYwmS6peuKe4Y8gDcVpXXVdjoVJZw
        q85mby/nDyPnPUSFEpDNXq3xYmCaXKM=
X-Google-Smtp-Source: AA6agR433WsM1zafWGUUh1tgZ3bzDc2DbEbBDXLZd4MNjEiU/mNjApppn3g0eXs4Wji0TRo8irtQHA==
X-Received: by 2002:a17:90a:7185:b0:1fd:768f:232d with SMTP id i5-20020a17090a718500b001fd768f232dmr4366561pjk.149.1661966264220;
        Wed, 31 Aug 2022 10:17:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id e187-20020a621ec4000000b00537a38ec2c6sm8736539pfe.164.2022.08.31.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:17:43 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:17:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 0/2] Input: touchscreen: Minor colibri-vf50-ts cleanups
Message-ID: <Yw+XtAvlt9Fys3wK@google.com>
References: <20220712101619.326120-1-francesco.dolcini@toradex.com>
 <Yw9rh7L3QecetL7m@gaggiata.pivistrello.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw9rh7L3QecetL7m@gaggiata.pivistrello.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:09:11PM +0200, Francesco Dolcini wrote:
> Hello all,
> 
> On Tue, Jul 12, 2022 at 12:16:17PM +0200, Francesco Dolcini wrote:
> > Hi all,
> > This series introduce some minor cleanups on colibri-vf50-ts, allow using it
> > with any IIO ADC input and fix a couple of mistakes in the dt-bindings
> > documentation.
> > 
> > Max Krummenacher (2):
> >   Input: touchscreen: colibri-vf50-ts: don't depend on VF610_ADC
> >   dt-bindings: input: colibri-vf50-ts: Improve documentation
> > 
> >  .../input/touchscreen/colibri-vf50-ts.txt        | 16 ++++++++--------
> >  drivers/input/touchscreen/Kconfig                |  2 +-
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> Just a gently ping on this series, anything I should do?

My apologies, applied the 2 patches, thank you.

-- 
Dmitry
