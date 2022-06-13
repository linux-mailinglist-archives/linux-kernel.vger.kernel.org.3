Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47E75483EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiFMKMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiFMKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:12:40 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C6F08;
        Mon, 13 Jun 2022 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xbSS6/wiDH/1RkoIqjpuk8UPCrRb3ic63i+lK3L+h/Y=;
  b=ZQ457tF97m5mn6CMi7t5HVWoScnKbwtSSgkgmV4i8qd6jDKaF1OM4/iY
   XsvbYSJQZSbphS+NqBc22dkJxFafFZ1GaTTCdrWGPb1Chv8UWoz+Lij6E
   bh2lOb+K9jZxdTcO5vt/HCR+w31RcF/r7lAHbovMi5ntPymrWAwBqLIQr
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40717374"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:12:32 +0200
Date:   Mon, 13 Jun 2022 12:12:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>,
        Dongliang Mu <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev-tools: fix one invalid url
In-Reply-To: <Yqbu8TwmaXdBiIBs@debian.me>
Message-ID: <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jun 2022, Bagas Sanjaya wrote:

> On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Fix the invalid url about Semantic Patch Language
> >
>
> I think what this patch doing is to point SPL reference URL from old
> Coccinelle documentation (doc root) to actual SPL doc entry on new
> Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> description and title.

Agreed, thanks for the suggestion.

julia
