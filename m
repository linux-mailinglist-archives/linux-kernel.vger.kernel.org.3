Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5955C79F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiF0Ok4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbiF0Okz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:40:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69190F68;
        Mon, 27 Jun 2022 07:40:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CDA215C00A1;
        Mon, 27 Jun 2022 10:40:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 Jun 2022 10:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656340853; x=1656427253; bh=yLd/tFyFBX
        Pfe4WL4650xXMRPu9U8zL44cPGtXj0tuw=; b=Swb2iaAcnVPoeH4cVNNzg/u60L
        xp9UyyL4m0zZn2NnbslisrRlxjNg7yQHzz3j0pUdS5TWLp3lTTVLpLYYUPcgFmD4
        q0QgLoDHJwj9FYLoq8qkkvPnHHXXyxWdp+VK40p9P1jJuwWlAEuu/LNRM2f0IwWM
        L40siopL5y36sbMLRjGxWZ3FXuTD385n409ac45Z/fwk35HkAIX0ip2BqU/Tn+6+
        dRf8cPOc4IEMAaYtco76BkrZycptb43lNmDqE/rTu/bfrhZovBMuSqw1jNN1hFMz
        4pz74464XBPrLU+dloGrFlnIxVSIXDPcmKw/HnYukzo4gAZBbb+RieNZBVKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656340853; x=1656427253; bh=yLd/tFyFBXPfe4WL4650xXMRPu9U
        8zL44cPGtXj0tuw=; b=DCNwxgQsuY49OnDxnuWk37BEcm5WNAttBictH0+a6qlD
        C3cHwClZyqRq3zKSa46ImNcSJGMxZ2eHRA5U2c6+qV05k4piPVlDADmEBy7tRlUU
        fi1iiV3kkShlFPLXm3Q63fKujBInZbWG9Tn62CryH0L1KXuXgChS6Hqqm5U9rcqc
        c8SUcl29kS9T3OKSuz8HhPUYWqwdrRPALfzrNft0lzvufLKUTyFn22hr4WV3ExJS
        tWaJigYXyhrlNPlQWBA054jjJ1fIGFa31i/ArnKLjQsZk0Dp2Z76NdM9TKXT1IW/
        47pMyovX3kszS9m9vTHST9RTZGirTG1CwfE3QZwieA==
X-ME-Sender: <xms:dMG5YpJgFuekJRpqcxw1nBIbRzvFUQ2ZEmeCxEtz-nHe34Dx1vnRTw>
    <xme:dMG5YlJm2GnneGXT7ZiMJPr6Jnvahld0GfrVzG_gZf2Q9TD4QBMgdHnZFcxhVS1RF
    tNgn4thLaIPPg>
X-ME-Received: <xmr:dMG5YhuVCeSZbOy8p20Z_kaLAbjWnqAwBn_BMWue1Z8rxETbArOxZAFAjhc9hBRcxWtoPp0ZbY72NFC0wGQSIXyD7piFnidg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:dMG5YqYq0teEk3zK_N2dqPkC4BHmFoopf2vT1bRKUfptGzLYLjp4ng>
    <xmx:dMG5YgYRGTirzGzw4-7BM2gSefa5Ed0X-Hf_Diosc5vMFr34fd-VQA>
    <xmx:dMG5YuA_Zs7iuv7cwjmFdLpkI0O30rYQGxqY7u5iDZpYM88LuxuStA>
    <xmx:dcG5YsTJdhXWuXrX7qNkJKtD33ZPFvk5YEwo0XQn50VROSN5yD7GlQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 10:40:52 -0400 (EDT)
Date:   Mon, 27 Jun 2022 16:40:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <YrnBcobDaStH8/83@kroah.com>
References: <20220623160723.7a44b573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623160723.7a44b573@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 04:07:23PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/radix-tree.h:12,
>                  from include/linux/idr.h:15,
>                  from include/linux/kernfs.h:12,
>                  from include/linux/sysfs.h:16,
>                  from include/linux/kobject.h:20,
>                  from include/linux/energy_model.h:7,
>                  from include/linux/device.h:16,
>                  from include/linux/power_supply.h:15,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:28:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function 'amdgpu_reset_capture_coredumpm':
> include/linux/gfp.h:337:25: error: passing argument 5 of 'dev_coredumpm' makes pointer from integer without a cast [-Werror=int-conversion]
>   337 | #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                         |
>       |                         unsigned int
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4726:55: note: in expansion of macro 'GFP_KERNEL'
>  4726 |         dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>       |                                                       ^~~~~~~~~~
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
> include/linux/devcoredump.h:59:30: note: expected 'ssize_t (*)(char *, loff_t,  size_t,  void *, size_t)' {aka 'long int (*)(char *, long long int,  long unsigned int,  void *, long unsigned int)'} but argument is of type 'unsigned int'
>    59 |                    ssize_t (*read)(char *buffer, loff_t offset, size_t count,
>       |                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    60 |                                    void *data, size_t datalen),
>       |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4727:23: error: passing argument 6 of 'dev_coredumpm' from incompatible pointer type [-Werror=incompatible-pointer-types]
>  4727 |                       amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~
>       |                       |
>       |                       ssize_t (*)(char *, loff_t,  size_t,  void *, size_t) {aka long int (*)(char *, long long int,  long unsigned int,  void *, long unsigned int)}
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
> include/linux/devcoredump.h:61:27: note: expected 'void (*)(void *)' but argument is of type 'ssize_t (*)(char *, loff_t,  size_t,  void *, size_t)' {aka 'long int (*)(char *, long long int,  long unsigned int,  void *, long unsigned int)'}
>    61 |                    void (*free)(void *data));
>       |                    ~~~~~~~^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4726:9: error: too many arguments to function 'dev_coredumpm'
>  4726 |         dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>       |         ^~~~~~~~~~~~~
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
> include/linux/devcoredump.h:57:6: note: declared here
>    57 | void dev_coredumpm(struct device *dev, struct module *owner,
>       |      ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   3d8785f6c04a ("drm/amdgpu: adding device coredump support")
> 
> interacting with commit
> 
>   77515ebaf019 ("devcoredump: remove the useless gfp_t parameter in dev_coredumpv and dev_coredumpm")
> 
> from the driver-core tree.
> 
> I have applied the following merge resolution patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 23 Jun 2022 15:56:22 +1000
> Subject: [PATCH] fix up for "devcoredump: remove the useless gfp_t parameter in dev_coredumpv and dev_coredumpm"
> 
> interacting with
> 
>   3d8785f6c04a ("drm/amdgpu: adding device coredump support")
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry for the delay, the driver-core tree has now reverted this, so all
should be good.

greg k-h
