Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6535479789
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhLQXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:32:06 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52507 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhLQXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:32:03 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id E8C915800DD;
        Fri, 17 Dec 2021 18:32:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 17 Dec 2021 18:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=y1HcJePN2RJJHD40n2VXxi3Qfyo
        A7ern3R2q1G97nDQ=; b=C3kaVO9iX/wJl2f43ogdV2aSQQhWH/Vl+ATkmui0kAZ
        FB9ckiX0NZ55gH4lOrtI8KK85Z6bivhhhNuqY6dUvn/UJxHkZ/BoJMJFasu2jK4G
        QLGdyiRuhl7nyWnDRkTI/BgTNod5EZZx9T+FdH2TDjsXc+LwpW8jzPsO1yYWankb
        IF+sqdKUMUnT7TAmCd8YMAA/La9nd88WDCGsgJc4nJBHmwXY6JRHWnNjN89P3MkF
        XsV8d6LBlEpZkv/1KEJ3OTV/iKKZfuLHilqhFfHE55/uSEgsYvX0nhNjq97qy0AD
        mhiCUNUxCNubABp9Uw9Lm07pr7mUZo/mdZS3R0X6xjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y1HcJe
        PN2RJJHD40n2VXxi3QfyoA7ern3R2q1G97nDQ=; b=HoR5ghLbIOhzfiejHM0dGu
        LnwQ4Wd9qq20+FkU9PJf+JoCYCMwzMfNfnvvGqB6YmRArP9rBTstW2/9EZgkiUyq
        0usfDgZq9j2YRMVcS5YqimH5pWzM0cfg+tGEZPx/hrQktK1g5OPNP9XT9Ir15WSj
        pdeLw377R9u36jk50ejZNdSgAc7RvB5C80joUnEmz6ICUw684kpz8Ftp3Hw9ghgd
        y+fOH2OnnyNpr83tT5qJpuhKns6q61YYmJOHQUOZrb/LxCctwee+MY1DWgqmCdfC
        5Npquc0PaSItNDk9H7UFN6k+OWD+wqO+lsnXgagjsIYLOa6xv/MCryeiLovtGbtg
        ==
X-ME-Sender: <xms:8h29YXhE2zfgwVMdOtV__wHJmpHiFm6x-pcXZcUBQPAjdWLHXruLTw>
    <xme:8h29YUATdj5G3If-QEgJRSVjR8wkpmnu3hPBdPQMgRMVGDyUxTUNiHfJV_Ff1O8Cp
    cV4dDbDsbRYAA>
X-ME-Received: <xmr:8h29YXEK8uMT2qMy1LbBmhCQ8VD5F7WofM85oimXrQO-jozhr-hnqrBQqDW1ZY45PNjMlIfmPkoPGaENFcgplsHgO3GhVdFm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhrohgrhhdq
    jfgrrhhtmhgrnhcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnh
    epffelgfdttdduveeiiedvgffhhfeftdefgeejiedvgedugfejteejuefgkeehffdtnecu
    ffhomhgrihhnpegtohhvvghrihhthidrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:8h29YURkf2ZY7EM6TkeVe1Rxx9qzLjB_5B3KQb8B8d58eTTV8EHXXQ>
    <xmx:8h29YUyNRrt9OMdUHAB6t70CipoRPrSItYDo-lEvlSkdYvMP3FzWig>
    <xmx:8h29Ya4N88qW3ux7Bu3_2945v0CK2-6hMgrnIQW-jhiRXZK2nvv_yw>
    <xmx:8h29Ybj64-VBrqmjO0qvm9pwpzFbL_Vv5s-eL-ql4KZGxAsULuvcpw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 18:32:01 -0500 (EST)
Date:   Sat, 18 Dec 2021 00:31:59 +0100
From:   Kroah-Hartman <greg@kroah.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org,
        Norbert Manthey <nmanthey@amazon.de>
Subject: Re: Coverity Scan model file, license, public access
Message-ID: <Yb0d70yFL4rCL1tq@kroah.com>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com>
 <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
 <202107151111.23BA48F99@keescook>
 <1bce95f4-ddf8-2081-57c8-67cd9d4dd3d4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bce95f4-ddf8-2081-57c8-67cd9d4dd3d4@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 12:32:59AM +0500, Muhammad Usama Anjum wrote:
> > As far as I know, the model was written originally by Dave Jones, with
> > further changes from myself and, I think, Colin Ian King.
> > 
> > I thought it was visible through the Coverity dashboard, once you're
> > logged in:
> > https://scan.coverity.com/projects/linux-next-weekly-scan?tab=analysis_settings
> > (See 'Modeling file loaded [View]')
> > 
> I've sent the request to join the dashboard. Who is the maintainer of
> this free Coverity dashboard? Can anyone use these results to fix the
> bugs without the permission of anyone?

Yes, no permission needed, fix away!
