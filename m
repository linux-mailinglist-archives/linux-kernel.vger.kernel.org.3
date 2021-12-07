Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFFD46B8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLGK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:27:12 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60383 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhLGK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:27:10 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 88FB93201A3C;
        Tue,  7 Dec 2021 05:23:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 07 Dec 2021 05:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nlg692ydclwMWGK24xPJwB5kA06
        /7G/RW+/el1Qn4DQ=; b=OwmR8CdAgkVclHO/CxofTo6r/QzZbcIFXV2TagnAAXI
        pOjdPioKHVMrP0SkFRfnlf2KVsgwQq6LwticV/5F651vwFFJyetza+uPf4uhNuZi
        ZoGDMT5CPTjYUeJsSeoKL5zXBdzaNFn5t/xR/SH0YwKkxtL4kv9jxHvZWRjvyiu4
        NBkIiTdG5q9F/nmeDnAK9IAfRIAsxC1NWMlKnifykvhFzZ4kAobWYGZ7KFdYHsMD
        MU/0W4f5SSrJVrmZOpWS8vduwXjUAMTj+UXFNrm7QEghtFmfSl4ip1kXXzzw8H4a
        9x8skc0cN3h7BCKHs7tloV63GM/qMy3N4A9G21TI60A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nlg692
        ydclwMWGK24xPJwB5kA06/7G/RW+/el1Qn4DQ=; b=H/TNBCm4zXMsk41Tkmupwu
        /sXtnV7YfGWDkwXdm4cIUt1uPDFHOVrmsHqIH/v/+ip7RbNRDEUD7Wf22sBXfB1L
        vIquaiyh1XGfj6283dahYq3DCtvSlK+yISIuF+n+Vlkf0TKu8kZjJJr7r+00PSik
        F7EGth61PK5VzGurqEJdyeX3z5dmziUvYSDxhEqyYLE5qUJ9v06aMoXzc5A6xPiz
        MIZwp3cXd1609ELngaqIcTxveZLEc/YBVefYigPrXyesTRxFiNKjqHZnX3nkJT3C
        HqGooFpHam05aBo41fC2Cms/dui2vDvaiJm0h4Qqo8cGSQCuioCn/50gCLU7HPlA
        ==
X-ME-Sender: <xms:KDavYarxkemzRdjRVt7tHVFR3b7QpdFeGhteJP2tT1rMgPAxrjD5JA>
    <xme:KDavYYq98A79gG_5espJX8w8SrG-WPLZUO0bQ_lpuRIh1PNFv97qRXs-0oBO4XEB4
    r9c27KNtmkx8A>
X-ME-Received: <xmr:KDavYfMHYwUK7qtj15kW0cPBI9Sacwg1KRarOTdqLGYcTMz0nUbPBMPIJhA950a3_w88Ee8BaEbD7yIwJcGwbW-v_WjETe_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:KDavYZ4gNpeWnb-C-9mr2BuoGPxvoVBN8gUVb-WWn2fnQYSzDOuH5w>
    <xmx:KDavYZ6bRVXQAicfz9fzq4lFKsPb6WmPR9qjO52A9abA7CLLrI2Syw>
    <xmx:KDavYZjSAdM_sjaRENTxVpnQJKe06AXDImzrw6ni6tgQQaXKGkI3XA>
    <xmx:KDavYWsVZ178P0GW41BxE3EPZEpTBqvcv4wrDct2mX_oZy34oEq07A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:23:35 -0500 (EST)
Date:   Tue, 7 Dec 2021 11:23:32 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <Ya82JHGJPzs7D/Hg@kroah.com>
References: <20211206193050.17ad78aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206193050.17ad78aa@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 07:30:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/admin-guide/cputopology.rst:49: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   f1045056c726 ("topology/sysfs: rework book and drawer topology ifdefery")
> 

Thanks, I took Heiko's patch now to resolve this.

greg k-h
