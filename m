Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6654A9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiFNGma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348263AbiFNGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:42:25 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90FBC2A;
        Mon, 13 Jun 2022 23:42:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 18B7D3200933;
        Tue, 14 Jun 2022 02:42:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jun 2022 02:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655188942; x=1655275342; bh=P/7bswqMPQ
        X8oQsoC8wI6KavpZ54vOriWqWeBl8HWd4=; b=tscxm2fYP6lpWoGyM03ZgD1EpK
        ExMfOq9mEe34+Fxjmuhb/3n/7TtRVmDoVec8fLfFFvzD0rwS30Iz+eiFkFLvxNIE
        +4/TS1y8i6DKERc/0L91u0/baHV7iEd6xDBQ+u1QlU6oPORwf9rOApeSgmy+0PAx
        7/n8sYka12lDgCupo3VVDkYUAVGULYOitpoF+AgYvIEvrGkpZj4ouVV8wk5louiW
        awU9IH5GKZMGvYurmL1Rb17pmcLkSj3vKmeRoDjpZDtxpe7zGknm35CRewjKRZpw
        tXBmqRgI1BFS17jHgT5oXzE5DtqT5hGGwwacPyu6eqsA3Rl0hrhCQSsQ8upQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655188942; x=1655275342; bh=P/7bswqMPQX8oQsoC8wI6KavpZ54
        vOriWqWeBl8HWd4=; b=ZfNg5ZRuXzht+q/H66J4oxyK7nSAH51fcaG+jEgx1BP1
        ZCF/5cGVUTA9V5ZzsI+NzShch0iQGB890rw1G5vyUTuCgJ34/bq0IhFbpGWnPeIS
        O1SHSYeMDIbteEZDoUvvYfDjtbBkbbkm1n7IVeKXJZQO3jdwqU34E+16iBaUhRl8
        ixmNp/1WzzbY7q27IDi8qxRW3PWaVIHFZzaAyDT3xTnvdMblbkGO9VEpyIffhe2Z
        x6H9cQ1Mqvg1lHgl07Xc2tThl23BQxG1rgrRVFUiqYP4bZsKfEwfIk2C0yXoxJ/n
        x44CLa7GDbdWs0yryqT9BNA3rl1ulk/+M26tZiqE4w==
X-ME-Sender: <xms:zi2oYr1P6TkbzjgS4P-cxlxQHDElzTjjHAj50AtCZIpLOHNxSVENEw>
    <xme:zi2oYqHdLPYfpwne5_Qp5xJTroa1wrO_4eI42wuSlLhJkXUVwSIhIyjTl-OzuLH35
    FfeeWQTJk9mtA>
X-ME-Received: <xmr:zi2oYr5bBQb0vE1qflhgSSZTrObVQNGdjy6ufqfEheMK2IxdFmyRaUDnWbxdadIM96d1o2mMWfU-6zmlcm3ZuzVG2JxkN8Y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddukedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:zi2oYg0wwPwZdqiQHqcjPNfwHKexKDXpFXyJxIdYAbUbJgWXkpvOJw>
    <xmx:zi2oYuHnPxeoO7ZFSQhW52s9NGBtk2BhFnkpspS3IvjUS_gP6mF9tQ>
    <xmx:zi2oYh993LKObMOidfXKbC-vq8dGt405L9YPFNasbx259p_QVW2BpQ>
    <xmx:zi2oYsav2psZfxKa1X8hGEfWC6NK-Gv89LLJGtTV8shdB20iWjISAw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jun 2022 02:42:21 -0400 (EDT)
Date:   Tue, 14 Jun 2022 08:42:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nam Cao <namcaov@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 staging.current tree
Message-ID: <YqgtzPOGyom7eq8n@kroah.com>
References: <20220614122448.1360395f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614122448.1360395f@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:24:48PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c
> 
> between commit:
> 
>   96f0a54e8e65 ("staging: r8188eu: Fix warning of array overflow in ioctl_linux.c")
> 
> from the staging.current tree and commit:
> 
>   ac663ae22f02 ("staging: r8188eu: replace FIELD_OFFSET with offsetof")
> 
> from the staging tree.
> 
> I fixed it up (I just used the latter) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks, I'll resolve this when the staging-linus branch goes to Linus in
a few days.

greg k-h
