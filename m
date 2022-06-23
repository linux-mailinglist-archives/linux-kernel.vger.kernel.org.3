Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C5557850
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiFWLCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiFWLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:02:08 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB84B413;
        Thu, 23 Jun 2022 04:02:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1499A320025E;
        Thu, 23 Jun 2022 07:02:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Jun 2022 07:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655982125; x=1656068525; bh=mpauSKw+ac
        HPItioESckgR4zKcDAJsLKlb/hRUGvUZY=; b=digU+6+a5NZnWygryndK+FNVk0
        JFmB4nycZRvtBSgpPJK39kUQpsSD1/OihQSB/EE9vy0uwRwM5nCQKfJ2v4NStwYS
        5iVDZlYPPcnTNVa0YFz6uB3fs1fLCpyyluzdyzWsk4GohLb78tzL3XK6EohedLbk
        GTFoTDzG94kH993ONMA6V2YKipF1PoMayEGA9NNlv9dYT088QrQskzfNJpp7n6Kb
        fVjCOyAmSMsBMN6nStNdQ17y1XNndhANQhurIo7RQ6XduYEO958SW9Ov6q+DuK4R
        Sv5gLfyZogoIj9HTI05SRbrSMfbT843VIh6sW5D/hrXu4oPitjDTK4Uet3xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655982125; x=1656068525; bh=mpauSKw+acHPItioESckgR4zKcDA
        JsLKlb/hRUGvUZY=; b=Esb6FbF7+s9GnsZ5izrQUi/4wLV2gTiQJAw+6/gL8PuL
        mGQXwu9lBYIcWye4+MoGvA3xdydjI5hUWTP1MnyoqC3uschjWKjbiyD7/N0dvl7H
        KI1+OExxrBDeIYr4GGb4iYUE/0nEE1IXM+CtO56DoSWnHZF37yb9M8we7980fYAc
        /WgxVAO2Z/CCwAhUDZRyfg+aVX7u3pcLSDiYnHYXnFMIS8g6mjnA1tBG+FBGwDWc
        n72h8NJEP4ybFcGO2GxlIh6xkb5hLQCGJHO7Tc+UAhFHSmnr7U2ONvQbQKlH0dri
        kAqjmLf3CI9JXv95UWcVa1KT9WDvLqCp7Q8zz9qfRg==
X-ME-Sender: <xms:K0i0YunGeSD1USAu7tZsD7hMGOCIGW-hydmybv1f0eJWfMQH9VtVGg>
    <xme:K0i0Yl0jUfGolCFxD3ZnIDZxf-cT-Vd7y0LxKQISe6kOPM8cKcQ5PTtw0_2vtMo8l
    cB7EyG0_25-KA>
X-ME-Received: <xmr:K0i0Ysr0bdxNs8C_5MZH8avEtGvUPtw9SFXDYDx278_9Y2t0U49K7bty>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:K0i0Yiki2r_SHZwHvAJp8n23eEvnnBHyUcqphMsvdsacY36kQI76kQ>
    <xmx:K0i0Ys0lofLqyZWcV1VCwya8JYgg06NCrp5QtGLLp3qqQOfOVFliqw>
    <xmx:K0i0YpvidTZPERsm303Cu1XvsH3UTLlmK7r5Mahov9G2QIFGC6oCYQ>
    <xmx:LUi0YiM7bVMEgfTaXhFZNNV8yIuZABRxmvPLQ2z4FIYiG2Z9GJ43CQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 07:02:02 -0400 (EDT)
Date:   Thu, 23 Jun 2022 13:01:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <YrRIH24vRuPFze7J@kroah.com>
References: <20220623160723.7a44b573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623160723.7a44b573@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f2a4c268ac72..9d6418bb963e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4723,7 +4723,7 @@ static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
>  	struct drm_device *dev = adev_to_drm(adev);
>  
>  	ktime_get_ts64(&adev->reset_time);
> -	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
> +	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0,
>  		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
>  }
>  #endif

Ok, this isn't going to work as-is.  I'll go revert this patch (and the
other one) from my tree and then request this to be done in a way that
does not break anyone going forward, if possible...

thanks,

greg k-h
