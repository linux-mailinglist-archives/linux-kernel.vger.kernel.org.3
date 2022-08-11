Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92405590919
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiHKXUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236676AbiHKXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:19:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD43BA1D38;
        Thu, 11 Aug 2022 16:18:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so15975969pgm.5;
        Thu, 11 Aug 2022 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=OOQhYGWLxduttyBcQPYlJ8Cr6Ni+A7e5iC9czx+4CEg=;
        b=f2Upyew1Cmi3ho8riwxjmApDSwchBnLplYu80GOQwtEVVpow0mmS7jY4TJinZV9NhV
         mm4Eqitc4ruJXoeMABt94tQX2p5uyZmyBg8Omy0lfeEUHcNjKC9NrYCb+qzX97kiwNu4
         e5uN7V4ZZwaD4eodEGWbKITxJsOyt6q8Omh2f98ARh/WK8HRmv2ruoMX1o5k7u+6NrKl
         P1TPRIdKiomfXAwxHpXTxRVroEhYlUsWjqg2nT7ZeLatH4HeHi+YULjuKCXTI+CpdaVy
         m7jizu0hbSQwu+tv1WlgazCoEmpdleM4/yNpwj225kIRa4Ue0nsh9NQKQPVI0hL5cPW9
         XxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OOQhYGWLxduttyBcQPYlJ8Cr6Ni+A7e5iC9czx+4CEg=;
        b=PQ4YBuDqJWC9OmN9PD1Ok4PAWYFa2J1aSRoURXRP7IBxxkU5w0dsbqIWRUVYFkNGky
         zf4YIt2eG3dQ0y9oNapN4u2JalyoVO/Pb7+1w2p+wGLqUI72StY0eZaGRa9I2BK688iJ
         zW/jfxAOm74fkAX+iOMU3TvyueI1vswHX0lybsWN3SxglW4g8ODfEfAb5L46h4B/rczv
         /LyAQnQ4CGtvkGV9fyIDTkItAdECndELUtk6WGKzzabePU1K73/eZcsfsIfYweF7eC/r
         uVrfXVatK3JG96MC1XwaNwZgh9c4H6hifX9EhNPjkXOFWF7pKpk/pVfPF8VMQV7o3E0p
         PxHQ==
X-Gm-Message-State: ACgBeo2DEPA6R9daYT6aSegbcSOa7EzXUC/+zdkHVSUHrkfwNb/e5mlA
        2Pw9d7mXd/rzdWCgCLOP8tM=
X-Google-Smtp-Source: AA6agR71i6ETGQ8VeuFs4taQE1k5cW4qfigksQ5UUbCpz6KwvzdlsUoxhhjr5yfEUF+XQ4NMiYfUsA==
X-Received: by 2002:a63:4620:0:b0:41b:8a9:9868 with SMTP id t32-20020a634620000000b0041b08a99868mr965313pga.345.1660259929118;
        Thu, 11 Aug 2022 16:18:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id ja14-20020a170902efce00b0016be527753bsm195816plb.264.2022.08.11.16.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:18:48 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:18:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     kernel@undef.tools
Cc:     hadess@hadess.net, hdegoede@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCH] Input: goodix: Add support for GT1158
Message-ID: <YvWOVsnw7lZ/4uDu@google.com>
References: <20220809091200.290492-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809091200.290492-1-kernel@undef.tools>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 09:12:01AM +0000, kernel@undef.tools wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> This controller is used by PinePhone and PinePhone Pro. Support for
> the PinePhone Pro will be added in a later patch set.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jarrah Gosbell <kernel@undef.tools>

Applied, thank you.

-- 
Dmitry
