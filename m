Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C905751B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiGNPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiGNPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:21:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E935F11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:21:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z12so3014847wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZP/v8ROQZNe9hsHPJL6oKnTbTJZCrCGkGnLFioI+Fvs=;
        b=zc2ivyoCK+kvXMBo3qql0SaINu+scvSM1y/gvVJyFuR1GqvOzSBZogRXLMScFaMc8c
         SXG2U8mBibMgF8MEhMFkA1kTlqBRXIhC++X+pWLmIXYmZRqNt98CCvB2/puY0+nioEol
         /BBPAXE+K/zudc6GflSzpKUED0/ieie6CjJ3ugmmzPO1EOFBtVK3ni5cpug6Iv1SKAQ3
         kYkY9G3eq9PwPGAz81k+Bfsu/FJivMtOFFtHLSk93GnxjJH6jBxhYpeLCTJvsmn1yMNL
         1/AKiLX7/x1hHDmUUxfUpZipubOako9kalXK+0jCiDmbPLFuZr/MFmb+cYACz8N6vxF2
         iepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZP/v8ROQZNe9hsHPJL6oKnTbTJZCrCGkGnLFioI+Fvs=;
        b=xJtJPC20ch0LlkRi5ZSyUUwqejPSDW228iQ9a306cG3Uovib4Xkr/axl6uN3n+i19U
         zdv91nZbWrk1Tcz+Nzqc9vhPGC1KNGMNoAG74+4BeFb4DZEqm/Rb/uvnTH2qENwvTMq8
         kde7QKu3n2nYBc4AAS+VDDgiCsoQiW2xhyDcKAOyrBZAenOEe111hEfz9l4CCW/cOl8l
         q3rI40MafmwkoaVLSkyrm4fvQIKsMbhTDBjMY4H8GPekVazgzzfzZsZ+FL+O08uQuFbT
         QC39DOAEs1BXHuZ5iDBM8hqFCLrUU1mJrNN1y72s84oiQmeOGEmbWOLZbsQhCsWC/M+H
         PIcw==
X-Gm-Message-State: AJIora/ljuxOd1M6iwQhlLvs86Cq5TMiNJPMnzw2qTd4MMGLheGIsrQ5
        QEPAqV9hgiS56HfZnXwigsSCiw==
X-Google-Smtp-Source: AGRyM1tIhk9hLd6ozum0NBKrIshtJMT72+PlUC63cQOXl5f8uXly4TBxvlVhx7heX8RQf1fh0eiq3g==
X-Received: by 2002:a5d:5444:0:b0:21d:6497:3210 with SMTP id w4-20020a5d5444000000b0021d64973210mr8558449wrv.587.1657812109173;
        Thu, 14 Jul 2022 08:21:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4ccc000000b0021d6e758752sm1731229wrt.24.2022.07.14.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:21:48 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:21:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/8] MAINTAINERS: Remove myself as PWM maintainer
Message-ID: <YtA0ikPPMuvPNGxs@google.com>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-4-lee@kernel.org>
 <20220714151305.ridfaom2l4qaao4t@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714151305.ridfaom2l4qaao4t@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Thu, Jul 14, 2022 at 12:25:28PM +0100, Lee Jones wrote:
> > Thierry and Uwe are doing a fine job, leaving me surplus to requirement.
> > 
> > Happy to pop back on-board if anything changes in the future.
> 
> Thanks for your efforts in the team. I don't know your plans for the
> future, but I wish you the luck you need and the strength to decide the
> necessary choices on your path forward.

Thanks buddy.  Nothing drastic happening with respect to upstream.

> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Cheers.  Keep up the good work!

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
