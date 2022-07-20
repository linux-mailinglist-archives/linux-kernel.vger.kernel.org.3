Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EE57B3B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiGTJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiGTJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:22:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4638847BBE;
        Wed, 20 Jul 2022 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658308915;
        bh=LR/kJjh/rfAFTLPaTCm8fJ5QMC5XfKbqUauGgnqaklI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MRtHWOfD8ULW0vHudyDmZYX3RcB570OOG3Vcp8yIZhon1W06aUAHsk40tZSCUj6jn
         WFM70lFiE5f+h4HgtFXzVYokvytUCbyTK/VQAZ2A3jPn+K6cBwn3e7xRHZw1UFVjeK
         lcz+VBs88ef5r2R6ckIlyuH7YHJspEqfidnn64O8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.166.214]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1ndfDr0NPQ-00aWaI; Wed, 20
 Jul 2022 11:21:55 +0200
Date:   Wed, 20 Jul 2022 11:21:51 +0200
From:   Helge Deller <deller@gmx.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Helge Deller <deller@gmx.de>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <YtfJL7b6nvanVdYk@p100>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
 <Ytd2g72cj0Aq1MBG@ZenIV>
 <860792bb-1fd6-66c6-ef31-4edd181e2954@gmx.de>
 <YtepmwLj//zrD3V3@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtepmwLj//zrD3V3@ZenIV>
X-Provags-ID: V03:K1:vTnu5NZoBlVOzTUly+Dqyz0I1Zfe8UZirZ97bPhXyfDJzLOTaxe
 MikUA54Hm5SDHtw5MKM0dtmPU0OyUROx8MOugYhdh7iQ43kP5yD9OkM0Xm7nwvAtsWlRmFx
 JvRa1Db5uMCBwBm5AB6psDF+sjy9XD9HBD5dMQ08Q0bt4hqBeAuAMIIeIAAF3Hbud/uekEM
 mgFfgjJcdkXyo7hcETd5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUVygIjMYNw=:X+z+xYkYoj5Seb+rpwcEjP
 am8XKNu8ERlJ2lwcqHY1n+B6QD4rd0btKO0ga7gQwRy70nO7twvsMxNedKtec5fqrJDlEer+a
 8XGm7EOHnXpHt1zo7lqV1u9Y7i4XiNlvorzilXFO89WN7NaRTczz+rMIxWFud64HiPTAQOcdB
 9IoDDpzJqpC2uzMSKWkAxwWKj6zovT7CSW2fhemiA9aKrjCAxcwDS8nVG64mu+0f5YVaKrj1c
 HDi+zjOl0B/eseIEXZZSzAYpOrHviSEkGKw4jR1UTcCcNh05IZQ0P4r2vkQ5QLN9KtarlQA1L
 361xD6RC8+Pgzv13YVjKKMtGeSIvlTaztjUT7eJmPi5XOz1MeMKwoow53iTPnmgRYrBQppbHY
 ojo3EZzrSue3rcoE2zHMbois02EVHmK27UyqHjYeRUYxnqi5UCbmZAaQbkKv2XIECVJACEn1W
 snPp0aKBIo/lrikpHzNSIYKPQ1logyvkZfvOeaHbwCBCxHZ4liA9mnUZW8jKbEeA1oBnuJBDh
 bjqJw74FRHiwHrLtrUg30ZrP4VZL9fuIiBPlJdYV9E8ToCOitBY+mC0gkCYuy4mjudTpgWzYJ
 pwEvd8lwT5FY2zJSpJmgEIFjitnqV87FQQ4wluute2XSL/FIqJYDiV9yGIYIpiZB/r4S1utRC
 SOYqR00OuaYMxIje81eRTO3oGP+rJ0E62pqFznDOcg1kARGYnKD1IS5I9Eli2L3MBkE1WDjZF
 dzYQ69Wlp46M9aEGdopfD9APEu7VIMTXH+d19V8MnM9eQlXNC559MzmPkuqAPxB8DQHKajwcC
 V4WtnF4Dd0BmLV/Or55AHTjtAiWK/yYQvGHcx5+BVI3QM0rZRDp3TNRJxrwOTzQaoI9IBUbW7
 d6no2HBnPr2BIIgX//SRkM/DOsKSGyZHj9ioG71lrxWvmVg1gmLawTvTclYvwYDCFdcbqW38B
 tH5Hq/LrF6lWnHDfA9tggaGOz88sdr1MHZ2mPtV+h0gLyPa6xy1kJFhQ4hAdPXmxytYGQpJpe
 wwsgZL1KHvZcby6LnWyWE2/WFeSaHORi2NM3eeOBNnoBQSnJC3nAAtbKVNIx8GvvwaOwUqE9j
 lg2sq3yXAV4LzEUDs2DSz+/6vtlbDSHSDg7IBgtdyc8190w9Q4pJkfgkQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro <viro@zeniv.linux.org.uk>:
> On Wed, Jul 20, 2022 at 08:53:53AM +0200, Helge Deller wrote:
> > On 7/20/22 05:29, Al Viro wrote:
> > > On Sat, Jul 16, 2022 at 07:27:30AM +0200, Helge Deller wrote:
> > >> On 7/15/22 15:33, Hillf Danton wrote:
> > >
> > >> [108565.341434] dentry->d_u.d_rcu =3D 0x416be770
> > >
> > > Incidentally, does that match the address of __d_free() on your buil=
d,
> > > or is it something different?
> >
> > I don't think it's __d_free().
> > The source is:
> > 	pr_err("dentry->d_u.d_rcu =3D %pS\n", dentry->d_u.d_rcu.func);
> > so the "%pS" would probably have resolved the pointer to string "__d_f=
ree" (or something else).
>
> ????
>
> That should've taken a word from desc->addr and printed it.
> If it had managed to get to a string (you'd needed to have
> CONFIG_KALLSYMS enabled), it would've printed it as a string,
> not as hex address.  Seriously, check System.map for that
> kernel...

CONFIG_KALLSYMS is enabled - otherwise I wouldn't see the backtrace either
(just to be sure I did check the .config again).
But it might be, that when I produced that debug info I had
%p instead of %pS - that might explain why the function name wasn't resolv=
ed.

The kernel functions on my build on parisc range from
0000000040100000 T __init_begin
to
0000000041700000 D _end

In my current System.map (which may not fit the address above!) I see:
00000000416bda50 d in_lookup_hashtable
00000000416bfa50 d counter.0
so,   0x416be770 would be in in_lookup_hashtable(). Does that make sense?
Again - this is a somewhat newer build...

Btw, you asked if there were any other private discussions/mails on other =
mailing lists:
There are none, only those which are in this mail thread.

Below is the current patch with which I will try to reproduce the issue.
I'll disable hashed pointers too.
Any other info/patches I should add?

Reproducing it is time-consuming. It takes me usually a day to trigger.

Helge


diff --git a/fs/dcache.c b/fs/dcache.c
index 93f4f5ee07bf..047729fc1a97 100644
=2D-- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -360,11 +360,32 @@ static inline void __d_clear_type_and_inode(struct d=
entry *dentry)
 		this_cpu_inc(nr_dentry_negative);
 }

+static void show_dentry_info(struct dentry *dentry)
+{
+	pr_err("dentry =3D %px\n", dentry);
+	pr_err("spin_is_locked(&dentry->d_lock) =3D %d\n", spin_is_locked(&dentr=
y->d_lock));
+	pr_err("dname_external(dentry) =3D %d\n", dname_external(dentry));
+	pr_err("dentry->d_flags =3D 0x%x\n", dentry->d_flags);
+	// pr_err("ERROR on file %pd\n", &dentry); HANGS
+	pr_err("dentry->d_name.len =3D %d\n", dentry->d_name.len);
+	pr_err("dentry->d_name.hash =3D 0x%x\n", dentry->d_name.hash);
+	pr_err("dentry->d_lockref.count =3D %d\n", dentry->d_lockref.count);
+	pr_err("dentry->d_flags =3D 0x%x\n", dentry->d_flags);
+	pr_err("dentry->d_inode =3D %px\n", dentry->d_inode);
+	pr_err("dentry->d_parent =3D %px\n", dentry->d_parent);
+	pr_err("dentry->d_u.d_rcu =3D %pS\n", dentry->d_u.d_rcu.func);
+}
+
 static void dentry_free(struct dentry *dentry)
 {
-	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+	int unhashed =3D hlist_unhashed(&dentry->d_u.d_alias);
+	if (WARN_ON(!unhashed)) {
+		show_dentry_info(dentry);
+	}
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p =3D external_name(dentry);
+		if (!unhashed)
+			pr_err("value of &p->u.count =3D %d\n", p->u.count.counter);
 		if (likely(atomic_dec_and_test(&p->u.count))) {
 			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
 			return;
@@ -605,8 +626,13 @@ static void __dentry_kill(struct dentry *dentry)
 		spin_unlock(&parent->d_lock);
 	if (dentry->d_inode)
 		dentry_unlink_inode(dentry);
-	else
+	else {
+		if (WARN_ON_ONCE(d_in_lookup(dentry))) {
+			show_dentry_info(dentry);
+			__d_lookup_done(dentry);
+		}
 		spin_unlock(&dentry->d_lock);
+	}
 	this_cpu_dec(nr_dentry);
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
@@ -616,6 +642,8 @@ static void __dentry_kill(struct dentry *dentry)
 		dentry->d_flags |=3D DCACHE_MAY_FREE;
 		can_free =3D false;
 	}
+	if (WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias)))
+		show_dentry_info(dentry);
 	spin_unlock(&dentry->d_lock);
 	if (likely(can_free))
 		dentry_free(dentry);
