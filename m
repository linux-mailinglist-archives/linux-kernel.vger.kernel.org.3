Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC49049C653
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbiAZJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:30:16 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40161 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231742AbiAZJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:30:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EEF6058044A;
        Wed, 26 Jan 2022 04:30:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jan 2022 04:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=zmX5h2jV3EHx3yzNE12hU7F6WuB4iwZH2e1xCG
        J9lzs=; b=XzCwmHYomZaj4oeGGDLIa5U9L4jNa4gHNnQze5oUFWo4p1T6gZoRBv
        f0GTimCbIcNENLLJrWnzEhKr2q0tlR9XlXG/+vBA+mlvpKKPgqJ5FELbWuxM8L9p
        7OG+mNvk34ScZ4RvGWzpXoOPWBDvd/0r6hOiCZjRGFycvLdxxvkO3NBEr122w/tk
        I9hPL392fiPRPl0BCfwMi3CJy4iKyxn0ryyvOgLw0MzJGwEEjqpiXviEExKBuuaZ
        oh7soEv74bhGF/H0+OJh6eVHmsmLQ/UPMChXra+6YKyf3RPq57uSg0Wnha6y1HiB
        Mfb2I4YPyJouL390ZgV/j5SKhgovc2oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zmX5h2jV3EHx3yzNE
        12hU7F6WuB4iwZH2e1xCGJ9lzs=; b=PG8tgOisD2oLuFl/GOdEAQv9cSlxtsGbn
        qsy3UyDqykILHXZsMmBGTsSH7Y9SOsdYUjm1k2fITRdZ3l34QZjYTZ6y5WwbBGO9
        2ot5b46otnvVGFvGJWXScvAh1Q6IZkzz93wl/pDJgwDkWZYfyWiCFUTw3tSLGrPO
        GfgGYEBanxwZ/PnPpWkzFL5P691cWJcDJd/Fj3gTKrwAK9VukU0fbouwWUxb4y9d
        IJ6kCpxX7ObSDXN4dfprBNhiWRfpGJWJGiqsyinaPXzw/7EPcD3wTGS+QGvxTQtx
        x9+QCBxEfbvapaRuvMYVI2UmFp9x3vSEBEpUWOy8kC+QUE4cGG8nA==
X-ME-Sender: <xms:oxTxYRzZwawrAUjoPg_qIwd37LDc53-NANfS3zcqqW3seesLcbCwlg>
    <xme:oxTxYRS1Xm2WdQifiJJa-_2ac_YNz76T6spL4NwOUi4DWfBGCX9y-JyIi8uEynwsD
    dBvFKIDDYITvg>
X-ME-Received: <xmr:oxTxYbVp0-URbNATHgMFwMz10bTCN1BcoKsxUhzTu1-rEEjLcf9LrfUxMU6tyDj4rzJznSJiEuf6_Za0a7_J2v4Ov_6a7vYh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:oxTxYTgMvHlsz3Nna5o3Te1JC5vmOWlXnVny60ws5sKN2NXhhjEfUA>
    <xmx:oxTxYTBI79cBfAaK14fD4YI_KEblxua0qBwKgIrqoytGCiTgauiw6Q>
    <xmx:oxTxYcJ445hJ8Kw2ejgG0O9xae5rYybhJUwiUvl2z0iYuTOF0U9l1A>
    <xmx:pBTxYUtBQqC4XDTe8D-dzXYEdzEW1SCGwRTJT3lCr_bGo4Qu05lRkg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 04:30:10 -0500 (EST)
Date:   Wed, 26 Jan 2022 10:30:02 +0100
From:   Greg KH <greg@kroah.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V4 3/6] soc: qcom: eud: Add driver support for Embedded
 USB Debugger(EUD)
Message-ID: <YfEUmuglZluWwsg2@kroah.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
 <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccee5ae484e6917f5838c8abde368680ec63d05.1642768837.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 07:23:48PM +0530, Souradeep Chowdhury wrote:
> Add support for control peripheral of EUD (Embedded USB Debugger) to
> listen to events such as USB attach/detach, pet EUD to indicate software
> is functional.Reusing the platform device kobj, sysfs entry 'enable' is
> created to enable or disable EUD.
> 
> To enable the eud the following needs to be done
> echo 1 > /sys/bus/platform/.../enable
> 
> To disable eud, following is the command
> echo 0 > /sys/bus/platform/.../enable
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-eud |   9 ++
>  drivers/soc/qcom/Kconfig                   |  10 ++
>  drivers/soc/qcom/Makefile                  |   1 +
>  drivers/soc/qcom/qcom_eud.c                | 250 +++++++++++++++++++++++++++++

This should go under drivers/usb/ as it's creating a USB generic
user/kernel api that all future devices of this type must follow.

thanks,

greg k-h
