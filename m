Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889DB4753FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhLOIBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:01:12 -0500
Received: from meesny.iki.fi ([195.140.195.201]:49372 "EHLO meesny.iki.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236127AbhLOIBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:01:09 -0500
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 50379200BF;
        Wed, 15 Dec 2021 10:01:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1639555267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRG/LiziOcBYYwv08cFlMdGFZHWxzkJgPH6L7xoYlJk=;
        b=RWoPNEvXh5n9U53qz15nSqM70aVRWEWJ6sE+y/5Cc8cTqeh5v6lUzXlZlzi6Adz1B1rzse
        9BRe61I0UqwPcjE1bSG1kLSS2n4++OpGc9+Azpzw48OTm0oKz/Qu2T8Pyf5bmpJrjPIaVk
        9kV3eWxafs6IseJkn2xNC6IBvcdUix0=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C4F6F634C91;
        Wed, 15 Dec 2021 10:01:06 +0200 (EET)
Date:   Wed, 15 Dec 2021 10:01:06 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: i2c: ov8865: Neaten unnecessary indentation
Message-ID: <Ybmgwo/6bQXtaT35@valkosipuli.retiisi.eu>
References: <c6189daaac183ddf51da1444c597d8577c1ac416.camel@perches.com>
 <Ya9SlGo5HZpOXTmZ@valkosipuli.retiisi.eu>
 <f02e4204284af7ea848027a67cb1e907fb7d4403.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02e4204284af7ea848027a67cb1e907fb7d4403.camel@perches.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1639555267; a=rsa-sha256; cv=none;
        b=Hu/uexpW+7HydgN4//0wp3sqHr9CVVoffmICz79Sjt4KuZgLKgyjfV564kkQJcdCTgX5cf
        f5xziu15OrDe8eW425NusZ32C0AET5IZMF0WoPl9UjIUqnOPDGEn9M9vpaTiDHLKrWEbYf
        mrqgEo8EzU0/R8qx4lK1LH4IAZrBwYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1639555267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRG/LiziOcBYYwv08cFlMdGFZHWxzkJgPH6L7xoYlJk=;
        b=IfJpnCkxUHnDcGCFouWVYaPg6Qgmrccd9MubfXQ72VbjtGoJJriDr0Bt18vZ8aNn+0Etae
        jghdXTm3eXr8RKogIqrMBIE66FT8Gb1lfm68Z/AUUglH3bWKxEcVWWDEvZDtL8e1EI+xdw
        S+1I6w+4ueEc2EVVH3Dds8Prppu1iBA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe

On Tue, Dec 07, 2021 at 06:47:45AM -0800, Joe Perches wrote:
> On Tue, 2021-12-07 at 14:24 +0200, Sakari Ailus wrote:
> > Hi Joe (and Paul),
> 
> > I guess this patch is fine as such but there seems to be a problem in error
> > handling here: all regulators are disabled if there's a problem enabling
> > one of them.
> > 
> > Would it be possible to fix this as well?
> 
> I've no hardware to test, so I've no idea if that's the right thing to do.

I don't have the hardware either.

But I can tell that you shouldn't disable a regulator you haven't enabled
to begin with. Bugs (fixes of which probably should go to stable trees)
need to be fixed before reworking the code.

-- 
Regards,

Sakari Ailus
