Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD0347978D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhLQXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:34:12 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52527 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhLQXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:34:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 48D393200A2A;
        Fri, 17 Dec 2021 18:34:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 17 Dec 2021 18:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=VFlN5gwlUl6OdjrrwGITikvRTVw
        gKWO/tVets6VatFs=; b=GSbYpc8/LL6WCh4MtgGXXA5c7FQ0qg03y0ZBP/u0PDc
        mDNexl3frQtjMYlP75c1g543el0Itk5VsZz0o6E8MPa16izsb9m23WQYYcZfBI5g
        /+gBixaP0/bjIAT+tIosPDdg5gA32lWW4sqZVbxGacegcmcBsG32T3tQk132hOcu
        yBZ7QD/bo2f+9xEie0ZNUC7UeHNhj5NeI5RLMTSYrehM2B7bSx+eqcb7aHM2br8T
        nbfsaULItjaPqyzSrbLx0KYZ1vWabNyku1R/aMVgiurEIup4frSoD9/fNrwgtyGB
        Ld7IEC9QNcLt6462vpffqNcwp0WhYda2cxqMuIN792Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VFlN5g
        wlUl6OdjrrwGITikvRTVwgKWO/tVets6VatFs=; b=jPTONtQCBZWOd+ejl98LKM
        brLXBJ9FUuLSCjOgEze9qN1AXm6X8DKZwyBCtfG65GXRdc3J1BSYebeD6TuZVr+V
        q9pMwnpMgiLqagmaebOrnNrdhp8Hp7ZmqhoD5DK+wk2mVBBpS2yYecPkq5wpAlBQ
        SUbbgl29IYx0lLht9kSVzC2yABzn7cMPRZEUjGowYtjB43x1vBpthFiVPHu1xrig
        MiHwmeSCf5t67CRPev1XCLoXctazqCwvFoGt/0PPdC3BRbRH2Hc0VvLJ6q+lv7ys
        kSVg0jkBNTn7EGgmOO7FsT3vZ2snPpsDXtoCQe1Gpe6yRMGieDCmRUITOKl7uNpQ
        ==
X-ME-Sender: <xms:cR69YWUyBdswt6VHaxp13EFqRX4L0Ljk_b76SJ44tPlzJGaUcoR2sQ>
    <xme:cR69YSlPjz-7KLO4FTlvIY20n5BmApu9qFPAVLAssnkozmsyXkwKQ5wRYAZbo0GbZ
    20lSLZ2ulMLNcyAWA>
X-ME-Received: <xmr:cR69YabiT1AJCunSpr2eQzvZdz4no9c2i0IjIVJfXBNIDmjNaHbUTEGVt_qDYoM8tk1UO4CGvU-0Vly3joE5ovNJ49OSYt5T9TVQyPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjohesthdtre
    dttddtvdenucfhrhhomhepofgrrhhkucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgr
    lhgtrhgvvghkrdgtohhmqeenucggtffrrghtthgvrhhnpeeiuefguddtfeeitddvffetud
    efvdejhefgveevfedugfejffegieetteejudffhfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggvrhesrghnihhmrghltghrvggvkh
    drtghomh
X-ME-Proxy: <xmx:cR69YdUQkCERdzKTsuJelFbtbJk33V3skgZwVYKU0-SAhIU0iApTSA>
    <xmx:cR69YQlNFjDbt4N3WU0Y6jXxka1EaVuCuX1qBdKofs1r7N3q_-nTPw>
    <xmx:cR69YSd_59VWLSbwoRx5i1akdq_2K7XLoBfBmlTZIkaAMpx2K2bQlg>
    <xmx:cR69YVyS0ILS0XaFV-yGjOuBoh2ulku2rNo5KcQBkzjdRZ1mSXsmVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 18:34:09 -0500 (EST)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 898EF13600C6; Fri, 17 Dec 2021 16:34:08 -0700 (MST)
Date:   Fri, 17 Dec 2021 16:34:08 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Jorge Eduardo Fermino Oliveia Silva <jorge.ubermensch@gmail.com>
Cc:     mgreer@animalcreek.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Header line: Coding style fix
Message-ID: <20211217233408.GA47062@animalcreek.com>
References: <Jorgecommit>
 <20211217143408.10313-1-jorgeubermensch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217143408.10313-1-jorgeubermensch@gmail.com>
Organization: Animal Creek Technologies, Inc.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:34:08AM -0300, Jorge Eduardo Fermino Oliveia Silva wrote:

[Note: I am traveling for the next week so I won't be very responsive.]

Hi Jorge.

Before we get to the platch please remember that you should send all
Greybus patches to greybus-dev@lists.linaro.org and
linux-kernel@vger.kernel.org.  I will add them in now and leave all of
the context so other can see what you sent.

> Solve CHECK: Lines should not end with a '('
> 
> Reported-by: Jorge Eduardo Fermino Oliveia Silva <jorgeubermensch@gmail.com>
> Signed-off-by: Jorge Eduardo Fermino Oliveia Silva <jorgeubermensch@gmail.com>
> ---
>  drivers/staging/greybus/audio_manager_private.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_private.h b/drivers/staging/greybus/audio_manager_private.h
> index 2b3a766c7de7..a17f09a19014 100644
> --- a/drivers/staging/greybus/audio_manager_private.h
> +++ b/drivers/staging/greybus/audio_manager_private.h
> @@ -12,10 +12,10 @@
>  
>  #include "audio_manager.h"
>  
> -int gb_audio_manager_module_create(
> -	struct gb_audio_manager_module **module,
> -	struct kset *manager_kset,
> -	int id, struct gb_audio_manager_module_descriptor *desc);
> +int gb_audio_manager_module_create(struct gb_audio_manager_module **module,
> +				   struct kset *manager_kset,
> +				   int id,
> +			struct gb_audio_manager_module_descriptor *desc);
>  
>  /* module destroyed via kobject_put */

The part you're removing has all of the parameters at the same
indentation level and what you adding has them at two different
indentation levels so I'm not sure this is a step forward.  Since the
kernel coding style doesn't address this specific case, AFAICS, I would
leave it as is despite the complaint.  If others disagree then go ahead
as I really don't care much either way.

Mark
--
