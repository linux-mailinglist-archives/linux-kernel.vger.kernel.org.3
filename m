Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5757C483B75
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiADFTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:19:17 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46559 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbiADFTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:19:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D906B32005D8;
        Tue,  4 Jan 2022 00:19:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jan 2022 00:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=g0e5mC5FTUbVkZ+y/r+i6QJZzPp
        kaBFL8g/OBJ4oIxk=; b=oW/QyltMmIj3+lA5W1Xu5pfwuwnAfQvHrvhXtbHiWwq
        GZAlHrs7++QtLdYUhl0noFTkFhhQYds/blp1UO2a/h5NEzUhs229gonQ8nIkmhFR
        4g/vx653UbdozHSGP/WcgaNbM3FfBr66QNuH+cqxjGSvNjTlkouXMfoAcWDPS0J2
        WeDxTpfpODsp1s/aPmgGq/Zr0FB16t0fZo5yJ2G1tUgV1zTshTxSVWi4mUdCd0xm
        PEFnWzS+q7XtVUCPENcLjo9wB9Rkp/OLFMbzLK56Vn3I/40iuusUgUIAgk0Eh6rE
        Wxn7pen156Q5W1aZfWu7fiauhrpyC8cV4/78IFMxOGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=g0e5mC
        5FTUbVkZ+y/r+i6QJZzPpkaBFL8g/OBJ4oIxk=; b=L2O6/lI6J8THaxcy+wl3Tn
        PWlGCNwA+UVJEQJ/XxpiiLuwUVx/T1pkouqZL9YW5fMd7zjXA7vdRW8JFQFX4A74
        GeTDvUcEVXmNwHh4N/kgkE9jbW7eHhF48dtZdwN9+Di5W9o1UI0QCelDQ4Gf9bIl
        y6lrxuYBm3JPUyRrewaQkELhMJ0xtBzgRWEW3s1+SFCNqZ/AOwlifTvUUoC+LINH
        B+PivAfRspE+pakpUqe7Mg45LDxPNhy8kRLVYzRLc1ySFkKuiF9t08HQYH2O8n+B
        n4KG8NspRuhKPTvsJVgWEDVgzTd73HzcK/BnUTuC7kCU84bYhKjeVMSsDmKeoznw
        ==
X-ME-Sender: <xms:0djTYVq9fb5hw3z5IfYj3KhHqu0QJHtG3kH98robCervjTuJ-_UihQ>
    <xme:0djTYXqXlvYqghQT4snGtWqfW1w-VCnmH1u8MN15pjgD_AxvYLuchS3I2CWlf86rQ
    c1twcmnkMyxGi9OYQ>
X-ME-Received: <xmr:0djTYSNzDrJtO3CEbeQlA0S7wKk4Ip_pYdK_bikBXnZ8gomSHRoo4921TTrwzm14xy8IU2evsvHphgSmFTRV2g4F2C7U2azXVjMfBeXg3HOn7y5n0GlqfUkd565X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:0djTYQ7kv44uqaZtpYmGJ3m-RHLr4BNlr1oaNmiP8PGNELaOOjkSuQ>
    <xmx:0djTYU5yxMsuIBVZtjNUtMz7qfoXpuWACwnaeFyZwtURHLyI6_YOyA>
    <xmx:0djTYYhbJca_5oa00AzfvT7Wkpf2q5gGB0AxY1XQ54N5nVuBGU11Yw>
    <xmx:0tjTYf3o-oG-ZkV53osHasQYKru11pZFtIopgwtp2woWBRlVPdqAyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 00:19:12 -0500 (EST)
Date:   Mon, 3 Jan 2022 23:19:11 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, giometti@enneenne.com, linux-kernel@vger.kernel.org,
        thesven73@gmail.com, ojeda@kernel.org
Subject: Re: [RFC char-misc-next 1/2] cdev: Add private pointer to struct cdev
Message-ID: <20220104051911.ldwvwe65hc26bqbv@muhammad.localdomain>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
 <34157f5e8dbaa1063dd76608e1e57244305460e8.1641185192.git.dxu@dxuuu.xyz>
 <YdMCXierm0K6cVA/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdMCXierm0K6cVA/@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for taking the time to respond.

On Mon, Jan 03, 2022 at 03:04:14PM +0100, Greg KH wrote:
> On Sun, Jan 02, 2022 at 09:01:39PM -0800, Daniel Xu wrote:
> > struct cdev is a kobject managed struct, meaning kobject is ultimately
> > responsible for deciding when the object is freed. Because kobject uses
> > reference counts, it also means a cdev object isn't guaranteed to be
> > cleaned up with a call to cdev_del() -- the cleanup may occur later.
> > 
> > Unfortunately, this can result in subtle use-after-free bugs when struct
> > cdev is embedded in another struct, and the larger struct is freed
> > immediately after cdev_del(). For example:
> > 
> >     struct contains_cdev {
> >             struct cdev cdev;
> >     }
> > 
> >     void init(struct contains_cdev *cc) {
> >             cdev_init(&cc->cdev);
> >     }
> > 
> >     void cleanup(struct contains_cdev *cc) {
> >             cdev_del(&cc->cdev);
> >             kfree(cc);
> >     }
> > 
> > This kind of code can reliably trigger a KASAN splat with
> > CONFIG_KASAN=y and CONFIG_DEBUG_KOBJECT_RELEASE=y.
> > 
> > A fairly palatable workaround is replacing cdev_init() with cdev_alloc()
> > and storing a pointer instead. For example, this is totally fine:
> > 
> >     struct contains_cdev_ptr {
> >             struct cdev *cdev;
> >     }
> > 
> >     int init(struct contains_cdev_ptr *cc) {
> >             cc->cdev = cdev_alloc();
> >             if (!cc->cdev) {
> >                     return -ENOMEM;
> >             }
> > 
> >             return 0;
> >     }
> > 
> >     void cleanup(struct contains_cdev_ptr *cc) {
> >             cdev_del(cc->cdev);
> >             kfree(cc);
> >     }
> > 
> > The only downside from this workaround (other than the extra allocation)
> > is that container_of() upcasts no longer work. This is quite unfortunate
> > for any code that implements struct file_operations and wants to store
> > extra data with a struct cdev. With cdev_alloc() pointer, it's no longer
> > possible to do something like:
> > 
> >     struct contains_cdev *cc = container_of(inode->i_cdev,
> >                                             struct contains_cdev,
> >                                             cdev);
> > 
> > Thus, I propose to add a void *private field to struct cdev so that
> > callers can store a pointer to the containing struct instead of using
> > container_of().
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/linux/cdev.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> > index 0e8cd6293deb..0e674e900512 100644
> > --- a/include/linux/cdev.h
> > +++ b/include/linux/cdev.h
> > @@ -18,6 +18,7 @@ struct cdev {
> >  	struct list_head list;
> >  	dev_t dev;
> >  	unsigned int count;
> > +	void *private;
> 
> I understand your request here, but this is not how to use a cdev.  It
> should be embedded in a larger structure, and then you can always "cast
> out" to get the real structure here.

Hmm, I see. Is there a recommended method to avoid the use-after-free
issue then? When `struct contains_cdev` is allocated on the heap we must
free it at some point. IOW how do we ensure `struct contains_cdev` is
only freed after the `struct cdev` is freed?

> If you can't do that, then this
> private pointer doesn't make much sense at all as it too would be
> invalid.

I could be misunderstanding something here, but I don't see why the
impossiblity of doing a container_of() implies the private pointer is
also invalid. Could you please elaborate?

Just to be clear, the goal behind this private pointer isn't to access
`struct contains_cdev` via a pointer to cdev after `struct contains_cdev`
is already freed -- it's to avoid a (IMO) previously unavoidable
use-after-free.

I see this private pointer as the same as in `struct file`'s
private_data pointer. There is no contract -- it's all up to the caller.

> Ideally the kobject in the cdev structure would not be used by things
> "outside" of the cdev core, but that ship seems long gone.  So just rely
> on the structure that this kobject protects, and you should be fine.

I'm also confused on this point. `struct cdev` has a kobject inside
which manages the lifetime of cdev instances. But that doesn't protect
any struct that embeds a `struct cdev` though, right?

[...]

Thanks,
Daniel
