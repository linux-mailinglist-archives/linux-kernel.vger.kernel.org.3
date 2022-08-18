Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933BE5988EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbiHRQdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344815AbiHRQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:33:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759371704B;
        Thu, 18 Aug 2022 09:33:31 -0700 (PDT)
Date:   Thu, 18 Aug 2022 18:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660840410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8G/qFmUGW/BNQytAyJX+Ki4HfNnrYJzfFV7g5CzBno=;
        b=yxPOe4Bm2C2U6jGLDCHYvCFzUQuEuqZhVqSoejm4cG+fy0ac0NY5XS11qa0xYgI8iqJqE7
        rYMDhnf0lEvCtBU/808yY3JKmAEI/gDNC2OtdAtDHJ0Cp5jhIytTOfjbLZjpP6WQI+itQy
        8vXYZm4wyqBPuu+mnyvplxz8WxW5JW6/iwHkGg2Y8QQ/O5pGsFq/cIX4Sm0tQn/MdfUnFC
        RqY9wymEgc5Zfuc25YIvLRCzbfk3W056WDrG+WDme83rZvXXuRgbXHXVg5ikHAM0gP0Ejt
        6eIJBA5uwFQhjZy4VYotP3GnPuZRKilYoK2pLWrSY9uk6lKahK8P4pHJYMV7Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660840410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8G/qFmUGW/BNQytAyJX+Ki4HfNnrYJzfFV7g5CzBno=;
        b=oxOkjT3VB0bl0Ks27qtnGE/9M+MXKPmQKuVRW0g6WRq+V4uXL2Zy7j7VFEMO3l5rP1zU4z
        2ztGb1JJ0IgwnaDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <Yv5p2E9e5B897V4I@linutronix.de>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
 <20220626123019.GA51149@zipoli.concurrent-rt.com>
 <Yv5j8NQ72KXu60nL@linutronix.de>
 <20220818163126.GA47319@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220818163126.GA47319@zipoli.concurrent-rt.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 12:31:26 [-0400], Joe Korty wrote:
> Hi Sebastian,
Hi Joe,

> I just verified that 4.9.319-rt195 has this fix.

Good to hear. And the v4.9 series was the only broken, right?

> Regards,
> Joe

Sebastian
