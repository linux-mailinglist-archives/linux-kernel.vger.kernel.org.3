Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B334757D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhLOLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:34:54 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46843 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234047AbhLOLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:34:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E333F5C0346;
        Wed, 15 Dec 2021 06:34:51 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Wed, 15 Dec 2021 06:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=m3LAop276JGnuIzrbo3h0hI4rst+
        9X0A+rv7sty1g70=; b=QHUfO1ZT7H+y/sweUvnZTrMZKGCc/fLq1ft4S2MVkOHQ
        dgIW3qrcxFtsMP52lrFj5anX2btycq2kWEwhupbNDexEdlztHucsnPxaZE2QWh2I
        OGZYAUByiAsZ9lktB4BYSyPUE25kA4HthSKSgjX3LsiqH6ptjXDP6nGbG+6ZwsPI
        FaSk31h3rFXzODeE9iW2dfLav0Vtww83olmlKOcOeqMiMS5VU/bFD8k8USIhF14Z
        PcyZMVK3nglsCWvSiBh7uI9svgvR93pPkOm7HrnzTMiwC2tNLqYRIt1xahQsWiSs
        LwyuDuWH+I2ILRsRkKg3pdePkmE7ukrG1t1yXtmCVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=m3LAop
        276JGnuIzrbo3h0hI4rst+9X0A+rv7sty1g70=; b=T3SH6Rt6Wsvjl84z1jl9/i
        ZBwskCVOaC+MtI0/kVEkSt04bh6AvlqrBnVMVPjbTHUxlKh9p76XAy5hDnhu+wfp
        D+es3GX+4LnjJ1z2MfUfX5/jLnkxgidHX+YXPZP0WEvdISSqVlrmHWu0ug51tGAG
        Df1tN/XuaCUVlwYsNU9aZ2gzaAme9DN6tkh6WJW4ROUC6Jhx4OONl9f5ftM7yDLW
        NGJf7MyOjED5NP+lBX6UIT+/FDIdfbY37sI6KQoCBB4lZaaU76XzrYmpisc47aJ2
        pTypD5ObVr2QfN6gPeQJ1bPeQw2dDU50NeBT5N3IS7aVnBrZoyK/gjeadqZJ+w+g
        ==
X-ME-Sender: <xms:29K5YdayOcaB9M3P6Q9TJJx7Yuh0Ybf374DxaOQOQQ1qPyeogkDrRw>
    <xme:29K5YUaFe_ZXnV-2XCQJfSnY6veGm7sg3PckNhJsFz8yYSEl849RpS8ml3SPPst8e
    turKvlcXBNieaeUO4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:29K5Yf_6PHTIco8GoPH1VhAO9UV34oHXDzSjJhJdTL6pBfjMVFPigA>
    <xmx:29K5YbpkbxE6BW4_kAdHtx_IV0dIPcrdX_vs_x8suf0a_-pLv5LceA>
    <xmx:29K5YYrDqOTnB7S6Gpk6qIAgkJ7XwljRVqS1C_jJjpQS3uM0o2x-mQ>
    <xmx:29K5YVCNJJ-G6ZvVmgc4lUDNvHfXHK8DmoFkJA6mRTHsBYQ_t6Uueg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88F56274042E; Wed, 15 Dec 2021 06:34:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <b082f563-833c-4813-948c-eb498fe84817@www.fastmail.com>
In-Reply-To: <20211215112935.238561-1-marcan@marcan.st>
References: <20211215112935.238561-1-marcan@marcan.st>
Date:   Wed, 15 Dec 2021 12:34:31 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: apple: apple-pmgr-pwrstate: Do not build as a module
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021, at 12:29, Hector Martin wrote:
> This doesn't make any sense as a module since it is a critical device,
> and it turns out of_phandle_iterator_args was not exported so the module
> version doesn't build anyway.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

I think it'd be nice to add Reported-by: kernel test robot <lkp@intel.com>
here since their service found it and maybe also a Fixes: tag.


Reviewed-by: Sven Peter <sven@svenpeter.dev>



Sven
