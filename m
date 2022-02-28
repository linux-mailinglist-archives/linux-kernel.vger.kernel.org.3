Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC04C7BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiB1V1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiB1V1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:27:08 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9BF122201;
        Mon, 28 Feb 2022 13:26:28 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4F59A58022C;
        Mon, 28 Feb 2022 16:26:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Feb 2022 16:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=OIyz6P+AJkzgHPB6lyoqYyA4WryI17czGefy6S
        o4+vg=; b=g+0sLbddNqSKpmzpc8dRTL56R47UoWQdA/cTdlH2s7qDz1LunFgBrx
        77D5SFRQOoavhceKTiA5eGeaGrNFb68RGBbUBpv3y7sFXzmSLwpKeRiYcVv+0tJE
        Ou5JpSjSFnkFHo3IMJzOxgnRwmvi/l2LbR9lozfhKjvwXpJ6X7au/VKHTrffLnj5
        Y/X6G9Wyo/od7aYAHChfzL6AZiBm4vBBPNypxXERnrj6G5bGNUrx7/Efa1NTkDYa
        SbamfILq3vDTdlmAg0qpLWqfQps2qYvvQU0MKrO9KzHsS2XDNAWcg+7aY5vWGIJ5
        IJxf5Vg982y/c1D7B6E4Y3rKTuMS2SzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OIyz6P+AJkzgHPB6l
        yoqYyA4WryI17czGefy6So4+vg=; b=MvmSfJvCfoV9oQrUkCqSJe2LBYIWbqQAL
        sGsAh5QeJHl0JMOHyqMcISU5a1i0jq18mxziuS0pg+xlxwgPU88f3LCb2rge64Gw
        mME+sG3YZp1mKR/Qx0AScN//1iA3mi6KWykeaX9VLFlI4l18LT7oahoz4FP8F71h
        MP4TwMgMzZvebJDuO33S8Aa6p2vLW7GA3QTgymdP+D72qbMIxztPEzfFkewya/t8
        lPQQzIToMmSKcgU62jL/nHKl43o8xXTYpB3kYp/TrzaybDOC59Kl2xXNl+KGhLtk
        IWyEs1y2x9BuQkNGM0MiJOgP6GApDg8CWR1337VcV/B5TGLep0OJQ==
X-ME-Sender: <xms:AT4dYt6sOlewmArsKxusIZfj4Jkmr_mXHVU6zhzf37ngRks0zeR73Q>
    <xme:AT4dYq4q6QPNm44c1Q2CY8qHcxhNdp3MpUeprEZ8J3y5iB-1p3k4oyePZ0gElivTe
    H00uePtqTps6A>
X-ME-Received: <xmr:AT4dYkfYZ1opuwGS1l4ew4k4MsCAeYY-nvw5BAMN35VT-nzpf9bfzW8jJEz4EkMLZoiplP2nQ-eL5wIAybCzy4Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:AT4dYmJM3gKYYlpiXoV5L_biHklvY-S-Mbx7H0ypnIpbDrtGN6_qYA>
    <xmx:AT4dYhJW4pMLY3Vw8IPGVzlcjVb8YnXIKSx-xFcrSj-26Ry072N41g>
    <xmx:AT4dYvxtMcZ91RtcjIYcEymFylo7tL4VuQ0dUEutHZGbgsdCYuGGGA>
    <xmx:Aj4dYrDmrBqqm1sx2vgHp9qipKdAMjpbASwQCbyP6MOrEOaOqt148g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Feb 2022 16:26:25 -0500 (EST)
Date:   Mon, 28 Feb 2022 22:26:22 +0100
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh09/r/nT2LeE82n@kroah.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhzENKPtY+WOp566@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> On Mon, 28 Feb 2022, Greg KH wrote:
> 
> > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > 
> > > > Hi all,
> > > > 
> > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > 
> > > I did ask for this *not* to be merged when it was in -testing.
> > 
> > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > it.
> > 
> > > I'll follow-up with Greg.
> > 
> > Should I revert this from my tree?
> 
> I did try to catch it before a revert would have been required.

My fault.

> But yes, please revert it.

Will go do so now.

> The Ack is not standard and should not be merged.

I do not understand this, what went wrong here?

thanks,

greg k-h
