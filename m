Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1E4E5F34
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348313AbiCXHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348493AbiCXHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:18:01 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC1C6EC5D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:16:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3C7D73200564;
        Thu, 24 Mar 2022 03:16:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 24 Mar 2022 03:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=DTXAgwW3KMmK8mgaK0WiOyLx0v+7wJCh+opul4
        1HLN4=; b=Ak5FUmYfoDG94Z8MR47dR/Lmfkl7s97imwMLzSeBNmGgGLVBM1hLIZ
        JCe/+4ZHLgN2Y3gg5x9phrt1wDSxpk+HZ7ghpQCNt8vHkwSz0vOqPhldh1h7fEkV
        k5NQoSc+tXkI0q9N/anfIc8n5+UMqCE6BEUS+MxWCUhjKp331qm+lvHH/Uua4szc
        59tY8jm3mvrF9/EZ5sKdHSCFTW06LEd3ysQHU1Bu0oaMd2CmJPJT/Q1JiV/9MaEI
        R8uPoXrrAOmetAXtXQOnPWAg96AHwXcVH+VzSe0BQGwCXHnECrTZfZqiFdS6B6OP
        Ld/DFeIRPwHZqoSkPSX3BNSFfvhenqVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DTXAgwW3KMmK8mgaK
        0WiOyLx0v+7wJCh+opul41HLN4=; b=U34MNpiP9sGi7DrRGk5IjXLQswGgk9bCP
        RXNpeYaPMMgUdrXrnP0MGVYSyzj5ro5juGhSJZLgCxCv8/Ozq9sYFYqGToKF5r3d
        Aj7GgWotlA4e+ZWtVNQou30ZsdZBPUMb96sdlrGuMU5VKXyMpSPAqJO1PBAYENv5
        aMGTSsZhTYP9druV3UWCN7fopdwK/bPv63TZuh7OzQa53x/zdTBhTUB+aC4Q0aqM
        bFkXq5Xon/0Q4p3kSsdQt8kWvA17b1dpdkQxGGGaw3WJKmKiN3tuNKxeQUJXaLla
        KuYOhOsJTUqVVJRb5Vv5rlLo4E+y4Svim7nMRdv1a4kss2gxazwYg==
X-ME-Sender: <xms:yBo8Yj7zy5WJ1BYbT9CS3URvEWCaVaSpC13ocRwU8OqPqmyuFdZBvg>
    <xme:yBo8Yo5hfk1ox3XtR9TL-bRjsnEnhgsM0DI4_woFVcYnedtQqnKAHJbyMl53Qv3Nu
    PxLcozU4gZ4xQ>
X-ME-Received: <xmr:yBo8Yqd1vZQ2W4Ocg_fGuXMhwBEfpi70TSHOxUZzY90d917f2AHZ_sAEpYhyjLIxFo_Bp71VyKd0mFDWYZiqeUfODUgF-LWH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegkedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejie
    eugeegveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:yBo8YkKONhnzIIiUUXw9yQUnv-967jQRB_-2VQkN_WHlmgKCvG-c8g>
    <xmx:yBo8YnKiJV1sc6srUm8njJOGzLsj9hBTIWrPRw3ZtF10fqIWUXA16A>
    <xmx:yBo8Ytwy95YbPmov74QQqLs1QDr992D8SCEEmb1yrLtiMF-J4CSOmQ>
    <xmx:yBo8YhCSbsWENZwKUcgBtq1bvKJOW8emoQrehkyviOPB0eP9ld4v1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 03:16:23 -0400 (EDT)
Date:   Thu, 24 Mar 2022 08:16:15 +0100
From:   Greg KH <greg@kroah.com>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Johannes Weiner <hannes@cmpxchg.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Subject: Re: kernel space: finding cpu usage of individual process/thread
Message-ID: <Yjwav36K8D+8yPli@kroah.com>
References: <CAOuPNLhB8pojv4wqv6d4FvhoBbNvUxD19ciK-6E8HtbbrnjF9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOuPNLhB8pojv4wqv6d4FvhoBbNvUxD19ciK-6E8HtbbrnjF9g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:15:16PM +0530, Pintu Agarwal wrote:
> Hi,
> 
> For one of my requirements I need to find cpu usage or load_avg of an
> individual process or thread using "for_each_process_thread(process,
> thread)" where process/thread is a pointer to "task_struct".

Who is making such a crazy requirement?

Have you looked at how normal tools get this information today?  We have
loads of userspace examples and libraries that provide you this
information, no need to reinvent the wheel.

Unless this is a homework assignment.  Then that's up to you to solve,
not us :)

good luck!

greg k-h
