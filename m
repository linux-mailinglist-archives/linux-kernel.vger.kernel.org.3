Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EF480E51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 01:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhL2Arz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 19:47:55 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43481 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232172AbhL2Ary (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 19:47:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 080243200907;
        Tue, 28 Dec 2021 19:47:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Dec 2021 19:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+6s5js/9vHUWIGmQb9F7iYVKz7C
        UXR6BbKv38uwChjQ=; b=mQANk4iTsUNqh7rIDA8pqeT+GqT6wkVlxk2zUt1Brf5
        eDzmeCt3w+y1LAu3MbyObira/hIDI7O6K0qo5PC0ogM7/OC1azKm9pb9j76yvgLy
        IYjfYRAlzCydH3Z9LgefHiqKZwY6+4EbWCICqN+GezYxDGhrSbqfwDdcI+sXGIGW
        LpCPL7wKb6OKSUvdNEjZGqopgj3o3JI5qWDellRMfv+IN/puXeMLC72YryuOcFiN
        PUCS6rqJh99NNWY4iv7DPgE0O4bffl6H+/9BjPYSdelrrY0xCjrePCDH8dqypPzj
        6ocq8l0lzbUb1QQ8ldBVimN6UzdPgAyzro0NsQsoRJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+6s5js
        /9vHUWIGmQb9F7iYVKz7CUXR6BbKv38uwChjQ=; b=LTdd5iuTVhbaqD+jqxoFI8
        dWWB7lRvQL9XMBfsYh00k/VIMYg+X5f/vJjf53XaUsz1867TNvyeY8Qy6vAMc8/0
        n9mP3CR63oNhmFxJ+lclwGo4O8EIQNS2Eh8bI5NHvKEcjd9xdUWsIUf2sVuqwp5J
        dSbh7d4QgWwVZXXT2MB2AldUR6c00dsCeG1wpPboTkMHAJYBDSMfj6jhpx1E53aD
        mqHwFA12NYZ7UgucxE0Be5S+PNHj96ys52CS7VsXWh9nSWwjTzojyxtOJqlUpfYB
        Sn6P6g2aCrvqDEZw/CxwzzOVWi8TSgNHT6R3mMuioqE1KJfoicDnHi20ZVnQovGg
        ==
X-ME-Sender: <xms:OLDLYeDp4ak1gcMlyvs5XKkATV40R4evztOxy0biMnLpbRVUuMa2Dg>
    <xme:OLDLYYjwxW8aY1dUl-urflj36Md6Rip8O5pl4_fcdbx65QaAruT_yqfnepAaSuYok
    iaQD105FQmqtGz0-Q>
X-ME-Received: <xmr:OLDLYRnyIRKdNTIoeKPM1tmenFboGlyOpjlZNBnH0JqbfXUjzNUfjlyriNQI1d-Kh6HrGvfNuAw8enD4Et4Ndp8pb0x6LTccc7RO9l4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddvtddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjohesthdtredttddtvdenucfhrhhomhepofgrrhhk
    ucfirhgvvghruceomhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghkrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeiuefguddtfeeitddvffetudefvdejhefgveevfedugfejffegieet
    teejudffhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomh
X-ME-Proxy: <xmx:OLDLYcz25VlFIBHZe2ne2ac-rNR86OD0wrXny-uVqVim3aTfp2yrnQ>
    <xmx:OLDLYTQh-YozLKu_FEox2ag6KF5jxZyrpcCUt8cOHCePaRrFoMb8cw>
    <xmx:OLDLYXZ3vjQxyZrl0vW0sTGDqbmUjTLQ58Jc56_iLnMLmrNXtE-BRw>
    <xmx:OLDLYSGHHYvt4e7lk_ZDdLNnIwc7XnZM9A3Ko8BhlZfpM6rfh0T2uQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Dec 2021 19:47:52 -0500 (EST)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 0775A13600AD; Tue, 28 Dec 2021 17:47:51 -0700 (MST)
Date:   Tue, 28 Dec 2021 17:47:50 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: auto_manager: use default_groups in
 kobj_type
Message-ID: <20211229004750.GA114392@animalcreek.com>
References: <20211228135541.380275-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228135541.380275-1-gregkh@linuxfoundation.org>
Organization: Animal Creek Technologies, Inc.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 02:55:41PM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the greybus audio code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> Cc: Mark Greer <mgreer@animalcreek.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/greybus/audio_manager_module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index 525cf8f8394f..0a0f0a394c84 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -142,11 +142,12 @@ static struct attribute *gb_audio_module_default_attrs[] = {
>  	&gb_audio_module_op_devices_attribute.attr,
>  	NULL,   /* need to NULL terminate the list of attributes */
>  };
> +ATTRIBUTE_GROUPS(gb_audio_module_default);
>  
>  static struct kobj_type gb_audio_module_type = {
>  	.sysfs_ops = &gb_audio_module_sysfs_ops,
>  	.release = gb_audio_module_release,
> -	.default_attrs = gb_audio_module_default_attrs,
> +	.default_groups = gb_audio_module_default_groups,
>  };
>  
>  static void send_add_uevent(struct gb_audio_manager_module *module)
> -- 
> 2.34.1

Nice!

Acked-by: Mark Greer <mgreer@animalcreek.com>
