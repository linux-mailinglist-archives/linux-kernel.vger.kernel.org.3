Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E8486769
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbiAFQKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:10:38 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48283 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240960AbiAFQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:10:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C14D33203792;
        Thu,  6 Jan 2022 11:10:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jan 2022 11:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=GYrOzPy4E9jGWAdsDPb4wXuhkQK
        EoqLRn+NcBFYgQ48=; b=LCFglY/d9i+zVQnK63ApRSeHxG82YFekFP/3eAJ4tHq
        g2Y0fVrM/QkgkfwpAGCY6HcPrnDaEuzi8HQQrV4FDk6I4pUwIhGNI6B8UHOkDsTc
        SmUzJEApYaohRSKXzqFoSyaOp9fGEAkNd722iLwPnvH7NW9teWY80KQf7WX9ITtH
        In5B1ObOw0obfB0kOSqMZmkmj5sRkgNUgWUp3/OkXGXnas2K6R858znM0cGKfpEk
        HZy1aZIW7B8KRa2jCD1TXsuE3X9cQq4voCgCXyn/1P8xXCy82flc7i0Ea63raD7J
        FC8qbwlMdYoIMm2Z2jCJ0R6d5ii51f+4iFW1yfinjjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GYrOzP
        y4E9jGWAdsDPb4wXuhkQKEoqLRn+NcBFYgQ48=; b=GKwioXZAQ4b9Mv69hMrz6u
        EDYru7fCdvH8aSedCyU7HbBarCXwcTRDbdrdWECJFgJ0dAara4cyW0nsf/Fkyz0W
        scQoBJLsjuE9nXNZd6AdbRngGDCi05xdY6qbcopYUAX1A9YDO79K35FGK4Gl4t9F
        +wkpp4E3wsdtShtqgYFuiFSbUyTJNJVCwG1go9MjcH4jozKw0y3UE/766dybxGBw
        734W3kprOBCs8RxsBymf+FiiSFGhvk8BBDZ/S8T3IRe1LLNJMWC04nwS7S99BuHd
        RcEDhGWAcCt1umpl1194I8pFatPHpzVUYYcdnF4DyyR57EskfB6Su3KRtbBBkLSA
        ==
X-ME-Sender: <xms:ehTXYdArnZPbAzH4jfyPIskAnjXayN8_-DfuI0sM15D_f-JWN2Q5nA>
    <xme:ehTXYbij_hp06kPlN9Zb3QGcCKTISqt3S3ydQW0zdLzkkszML7gJA1TvvkO_kdJWo
    yR-9ramtM4W0g>
X-ME-Received: <xmr:ehTXYYldg7rsXrwLSK8ItJumnDw6jsuT4fa4Q4Swa9JuB26Hw2AVD7zqJ9MP6FulM1Hu1qaevcASMweUnyLdc-TeikdYcykS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:ehTXYXxVJ71jW5VKjp70jWmazRAH9YBdgR8mWFz2afYdr7RnvERm7w>
    <xmx:ehTXYSSSIHNb8kVUl6n9qfsSE895RgvjgF2j1S5bFd-D5U-Uv0SI7g>
    <xmx:ehTXYaYtQbpIyBTmxcH4ByU2j9U_D0sL2g2bJLFkEl1P8J_27H0MDg>
    <xmx:exTXYREl7Tqu8bw4A2IRo-DntWaYBKa1gdKJm3oTxuN14BUTYM84cQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jan 2022 11:10:33 -0500 (EST)
Date:   Thu, 6 Jan 2022 17:10:31 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <YdcUd19eAmI1MwNT@kroah.com>
References: <20220107024815.15dc7e04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107024815.15dc7e04@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:48:15AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/ABI/testing/configfs-usb-gadget-uac2:2: WARNIN
> G: Malformed table.
> Text in column margin in table line 27.
> 
> =====================   =======================================
> c_chmask                capture channel mask
> c_srate                 capture sampling rate
> c_ssize                 capture sample size (bytes)
> c_sync                  capture synchronization type
>                         (async/adaptive)
> c_mute_present          capture mute control enable
> c_volume_present        capture volume control enable
> c_volume_min            capture volume control min value
>                         (in 1/256 dB)
> c_volume_max            capture volume control max value
>                         (in 1/256 dB)
> c_volume_res            capture volume control resolution
>                         (in 1/256 dB)
> fb_max                  maximum extra bandwidth in async mode
> p_chmask                playback channel mask
> p_srate                 playback sampling rate
> p_ssize                 playback sample size (bytes)
> p_mute_present          playback mute control enable
> p_volume_present        playback volume control enable
> _volume_present        playback volume control enable
> p_volume_min            playback volume control min value
>                         (in 1/256 dB)
> p_volume_max            playback volume control max value
>                         (in 1/256 dB)
> p_volume_res            playback volume control resolution
>                         (in 1/256 dB)
> req_number      the number of pre-allocated requests for both capture
>                         and playback
> =====================   =======================================
> 
> Introduced by commit
> 
>   e3088ebc1b97 ("docs: ABI: added missing num_requests param to UAC2")
> 

Pavel, can you send a follow-on patch to fix this up?

thanks,

greg k-h
