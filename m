Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739BA483BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiADF0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:26:50 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52021 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbiADF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:26:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0342C3201F4E;
        Tue,  4 Jan 2022 00:26:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jan 2022 00:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=q/uGjEz3u6hJ9Wy+DckATc7YSLX
        e92cnspAamWMzasc=; b=UTE5UyiqV7gDlT0RA0n3x4OCUgUNWQWJV9RQDKsjQTW
        uCXnUhHQp9MfAn+4lzvj4JgpGO56ayOz60Sd0c8/ymDg33rbkkIs0Z35A7grxU6h
        xlzq0+lnS+wv/0xA8po1UXtsgOFc7XSAbRss2nrVa6155WzqTE6yWqIEtVjMva0K
        4WRtLeBN4Wis7TO1F18uIdiA2hxnDmWNzdyZFyEfVoyeroMKH2PTumJLdMISv3/5
        GEjBz46PKs7gWQz+3uXCj8iHVfZDu5WrbetK/sJyvcqj6iU4BY4oTK2g6pb89qRQ
        vp7hROIzB0VmO+J563oKDcurxZD+yDXtlSa7ggGD0ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=q/uGjE
        z3u6hJ9Wy+DckATc7YSLXe92cnspAamWMzasc=; b=LpGpvPd3FO9vM9g42wB0si
        lgP0b9/kolqywWJ4REdPp09Bl4BfFhUPPkZYiyXGLGOd5BXU0+3UKo7H++A/U9oU
        5chJR71J2jtD+dJsMjmqYWktxF8HtdLZ8TMtAJ7HMvFldQ5QiMBce43fI4WPHFWP
        NQCfRnWl1zDg2OgwhHXY50Xk/SBQuqSVNgt8/lKDExPqltXMe1eRGD93iS0P3Yp7
        w0wePnQwCd7cttf8MLQvtWeI0pYpOlp5Vc80vI6WDPCW5U5Yikh1hy2Rg0u6n+dt
        kF2aQnGanUliZYy0D/8BGREeS8gZPz2CW+4PjujSEMQ0DlJ53PO9uu/wEkOwqQqQ
        ==
X-ME-Sender: <xms:ltrTYVKI9puhZdViQ_g1f2LtvSOLqr_W-gInF1cpCzNJ6Qfx9sG74w>
    <xme:ltrTYRLT__X3wpt5qarQO0sS5jfaTcMARszoiy8Tn1SfeqW-L8M7o3spkTQvzEN4c
    dFUVsj-kQnrMbyO6w>
X-ME-Received: <xmr:ltrTYdtih72HH_A-pYSmfOf-IJNqWGqqTc59uXFNTlbDu7zEKTXH_EnNHzmRVaDW-GTcurmpG2W4u8Ja8gWv9jdI4Uhz2EuAfjdL-Mu8Wxs4kpV92tk4OwrBRVlx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ltrTYWZFPaZdLpqFhUtM7QD3qn4wcC_E9SjL_N49I0miJQNKmXHqwg>
    <xmx:ltrTYcb0u37XRCQud6k1wH25s6QntpIMecslsrdcKZKwlamno2IYfA>
    <xmx:ltrTYaC4X6_Uqcvapi0UQYwgbRaHGmY4ydgF244ufIVcDanEJ3WtMQ>
    <xmx:ltrTYTVLJqc5jDxpxfFgiatngFf1aMH8ygw_dythzjKCWeXKXpFbiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 00:26:45 -0500 (EST)
Date:   Mon, 3 Jan 2022 23:26:44 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, giometti@enneenne.com, linux-kernel@vger.kernel.org,
        thesven73@gmail.com, ojeda@kernel.org
Subject: Re: [RFC char-misc-next 2/2] pps: Fix use-after-free cdev bug on
 module unload
Message-ID: <20220104052644.j5y5c3s262fa4dac@muhammad.localdomain>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
 <bd7cb7db45c11f50495697ad23804a30a2e3b2d4.1641185192.git.dxu@dxuuu.xyz>
 <YdMC07NTx7sTRKtI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdMC07NTx7sTRKtI@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 03:06:11PM +0100, Greg KH wrote:
> On Sun, Jan 02, 2022 at 09:01:40PM -0800, Daniel Xu wrote:
> > Previously, a use-after-free KASAN splat could be reliably triggered
> > with:
> > 
> >     # insmod ./pps-ktimer.ko
> >     # rmmod pps-ktimer.ko
> >     <boom>
> > 
> > and CONFIG_DEBUG_KOBJECT_RELEASE=y.
> > 
> > This commit moves the driver to use cdev_alloc() instead of cdev_init()
> > to decouple the lifetime of struct cdev from struct pps_device.
> > 
> > We also make use of the previous commit's new cdev->private field to
> > store a pointer to the containing struct. We have to do this because
> > container_of() does not work when we store a pointer to struct cdev.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  drivers/pps/pps.c          | 20 +++++++++++---------
> >  include/linux/pps_kernel.h |  2 +-
> >  2 files changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> > index 22a65ad4e46e..97ce26f67806 100644
> > --- a/drivers/pps/pps.c
> > +++ b/drivers/pps/pps.c
> > @@ -298,8 +298,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
> >  
> >  static int pps_cdev_open(struct inode *inode, struct file *file)
> >  {
> > -	struct pps_device *pps = container_of(inode->i_cdev,
> > -						struct pps_device, cdev);
> > +	struct pps_device *pps = inode->i_cdev->private;
> 
> Why is this pointer now valid while the original structure that the cdev
> lived in, not valid?  I do not think this really solves your problem,
> only papers over the delay in removing the kobject that the config
> option you enabled is trying to tell you is a problem.

I'm confused here as well. The original structure that the cdev lived in
is still valid here. I think this is the only way back to the containing
structure if we choose to embed `struct cdev *` rather than `struct cdev`.

Unless you're suggesting the cdev is opened after the containing struct
is already freed. In which case neither the original method (embeddeding
`struct cdev`) nor the private pointer method would save us.

> 
> >  	file->private_data = pps;
> >  	kobject_get(&pps->dev->kobj);
> >  	return 0;
> > @@ -307,8 +306,7 @@ static int pps_cdev_open(struct inode *inode, struct file *file)
> >  
> >  static int pps_cdev_release(struct inode *inode, struct file *file)
> >  {
> > -	struct pps_device *pps = container_of(inode->i_cdev,
> > -						struct pps_device, cdev);
> > +	struct pps_device *pps = inode->i_cdev->private;
> >  	kobject_put(&pps->dev->kobj);
> >  	return 0;
> >  }
> > @@ -332,7 +330,7 @@ static void pps_device_destruct(struct device *dev)
> >  {
> >  	struct pps_device *pps = dev_get_drvdata(dev);
> >  
> > -	cdev_del(&pps->cdev);
> > +	cdev_del(pps->cdev);
> >  
> >  	/* Now we can release the ID for re-use */
> >  	pr_debug("deallocating pps%d\n", pps->id);
> > @@ -368,10 +366,14 @@ int pps_register_cdev(struct pps_device *pps)
> >  
> >  	devt = MKDEV(MAJOR(pps_devt), pps->id);
> >  
> > -	cdev_init(&pps->cdev, &pps_cdev_fops);
> > -	pps->cdev.owner = pps->info.owner;
> > +	pps->cdev = cdev_alloc();
> > +	if (!pps->cdev)
> > +		goto free_idr;
> > +	pps->cdev->owner = pps->info.owner;
> > +	pps->cdev->ops = &pps_cdev_fops;
> > +	pps->cdev->private = pps;
> >  
> > -	err = cdev_add(&pps->cdev, devt, 1);
> > +	err = cdev_add(pps->cdev, devt, 1);
> >  	if (err) {
> >  		pr_err("%s: failed to add char device %d:%d\n",
> >  				pps->info.name, MAJOR(pps_devt), pps->id);
> > @@ -393,7 +395,7 @@ int pps_register_cdev(struct pps_device *pps)
> >  	return 0;
> >  
> >  del_cdev:
> > -	cdev_del(&pps->cdev);
> > +	cdev_del(pps->cdev);
> >  
> >  free_idr:
> >  	mutex_lock(&pps_idr_lock);
> > diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> > index 78c8ac4951b5..4e401793880f 100644
> > --- a/include/linux/pps_kernel.h
> > +++ b/include/linux/pps_kernel.h
> > @@ -56,7 +56,7 @@ struct pps_device {
> >  
> >  	unsigned int id;			/* PPS source unique ID */
> >  	void const *lookup_cookie;		/* For pps_lookup_dev() only */
> > -	struct cdev cdev;
> > +	struct cdev *cdev;
> 
> So now who owns the lifecycle for the ppc_device structure?  You just
> took it away from the cdev kobject, and replaced it with what?

Unless I'm misunderstanding, the lifecycle owner has not changed in this
patch. AFAICT (and KASAN seems to agree with me) this is all still
valid.

FWIW other drivers store `struct cdev *` too. See fs/fuse/cuse.c's
cuse_channel_open() and cuse_channel_release().

Sorry about any dumb questions -- still new to driver stuff.

[...]

Thanks,
Daniel
