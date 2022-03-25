Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F984E6E58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiCYGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbiCYGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:47:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921ACC6EF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:45:46 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220325064544epoutp040c6ce74a12d720c7915fd82db55e4fca~fjL-jCilG3062430624epoutp04Y
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:45:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220325064544epoutp040c6ce74a12d720c7915fd82db55e4fca~fjL-jCilG3062430624epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648190744;
        bh=Yg1S58FtyllFU9egbe2cmqLI+H9g8v1yz2RTO9J0OXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tfatufBb19mIpAaC4XqAXpaLFhHSUZ2t3UyPFu2GFIh2qfCA6tue9PeRSE4f7Y2nC
         2jdgpSbC7PGlVLwx40HpF3M/D5QVLnXPnl+KOdWhW+n2JMjdXELyjNRJc03H1Z5O5v
         OYdFrBBhAaE6aHouiBU4yJ0lBmBuTMo4kflj8EN0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220325064543epcas2p42c78054fc2b778786b43a5859dd9e82b~fjL_3NSKs0632606326epcas2p4L;
        Fri, 25 Mar 2022 06:45:43 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPszl2gsJz4x9QF; Fri, 25 Mar
        2022 06:45:39 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.9F.16040.1156D326; Fri, 25 Mar 2022 15:45:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220325064536epcas2p31fa7f18cf356399d84f76458a58901e2~fjL4jNtjh1562015620epcas2p3I;
        Fri, 25 Mar 2022 06:45:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220325064536epsmtrp1ffb5b1144df6e7de2b098640ab0fe46a~fjL4ie2Xt0461204612epsmtrp16;
        Fri, 25 Mar 2022 06:45:36 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-f8-623d65119a64
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.CA.29871.0156D326; Fri, 25 Mar 2022 15:45:36 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325064536epsmtip142cfcab716bd6e8dd256eb8b09df422c~fjL4WOyTz1296612966epsmtip1x;
        Fri, 25 Mar 2022 06:45:36 +0000 (GMT)
Date:   Fri, 25 Mar 2022 15:44:13 +0900
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: Re: [PATCH v1 1/3] sound: usb: Add vendor's hooking interface
Message-ID: <20220325064413.GA123495@ubuntu>
MIME-Version: 1.0
In-Reply-To: <Yjws5IhAqos5LDM+@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmma5gqm2SwcVLShZXLh5ismhevJ7N
        4u7DHywWU34tZba4vGsOm8WBP4vZLDp39bNabPi+ltGBw2PD5yY2j52z7rJ7bFrVyeaxf+4a
        do99b5exefRtWcXosX7LVRaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
        F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn/L86n6XgpkTFtoYLzA2MZ4W7GDk5JARMJO4dbWIE
        sYUEdjBK3H9l2sXIBWR/YpS4duQrE4TzjVFi8Yz/rDAd1848Y4Ho2MsosX4mI0TRE0aJTRe2
        gCVYBFQllm7aBNbABmRPX7YdbIWIgLFE/9lZ7CANzAKNTBK3XpwDKxIWcJM4sHo2G4jNK6Aj
        8erKMyYIW1Di5MwnYEM5BTQlZi9+BTSIg0NUQEXi1cF6kDkSAjM5JGbM72OHuM5F4tmTh0wQ
        trDEq+NboOJSEi/726DsYomDC56zQdg1Em8PtkLFjSVmPWsHO5RZIF3ixrIVrCC7JASUJY7c
        YoEI80l0HP7LDhHmlehoE4LoVJKY1NQJtVVCYsXnJijbQ+LEzKPQQPzCKLF/wUKmCYzys5B8
        NgvJNghbR2LB7k9ss4BWMAtISyz/xwFhakqs36W/gJF1FaNYakFxbnpqsVGBETyuk/NzNzGC
        E62W2w7GKW8/6B1iZOJgPMQowcGsJMJ7/7J1khBvSmJlVWpRfnxRaU5q8SFGU2A8TWSWEk3O
        B6b6vJJ4QxNLAxMzM0NzI1MDcyVxXq+UDYlCAumJJanZqakFqUUwfUwcnFINTNc+yHRo7zRb
        ny7qmdC1r4T1z8eJpqYMAtY/5TwSaoL05kpdOrTu3ytO8UsH+/d3z/67KfzFJrapq9beldsR
        /X9z+3ruxZNKtJN+s5R0OE/5xffA4nfFjS2R02K9XkbXBQtFHtwSd8l1/sFDt+7q+V7y5jrj
        oJO78o7tqtuHxO6cvLJX0LzV8m+9VfKKNZNPTv7NPOnbR7YmTSGOmsJnSSkb/Ppz13+c+o5h
        CsPMlj/HNtcVCFydVPMvssvk6AOX0uZr+xW4E9SndKVefJI8U/VF65/dkltk9c+/+rkxbt+p
        +NZ97ad02XN7Xiy7zH91b01VbUvJ7uezXn3s1F24y5KRf76B7s787W7idxy0OQqVWIozEg21
        mIuKEwGE9UGFPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnK5Aqm2SwebP+hZXLh5ismhevJ7N
        4u7DHywWU34tZba4vGsOm8WBP4vZLDp39bNabPi+ltGBw2PD5yY2j52z7rJ7bFrVyeaxf+4a
        do99b5exefRtWcXosX7LVRaPz5vkAjiiuGxSUnMyy1KL9O0SuDJuTPUpmCNW8WL3JrYGxpWC
        XYycHBICJhLXzjxj6WLk4hAS2M0osfzCHCaIhITEgq7XzBC2sMT9liOsEEWPGCX6vpxlAUmw
        CKhKLN20iRXEZgOypy/bzghiiwgYS/SfncUO0sAs0MwksXb6TrCEsICbxIHVs9lAbF4BHYlX
        V54xQUz9wihx4+xRVoiEoMTJmU/ANjALaEnc+PcSqIgDyJaWWP6PAyTMKaApMXvxK0aQsKiA
        isSrg/UTGAVnIWmehaR5FkLzAkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwbGi
        pbmDcfuqD3qHGJk4GA8xSnAwK4nw3r9snSTEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QD0+mpfnN3ecpb6v6tjbjb6uG0bpHKS5Y9PR4pWzUdlopGSwYt
        ZLRYoX9na82Z6RUrLu53iBd1e/HcR8vjdMMX0b4lT7QLK/PK+GquV0SfCi/XYs46zWpzIm6j
        Ws8x9fM5++btl1DRLD63ev71aTZJBxLiUjPT5+gvjHrK9EGs7oDe4bPhkwVlLfPiF7E/mHLn
        yU9n2W6We0afur+9a7FcKqd85c2maYt+ut17Unjerj84KyeXc+rhFgPbA4a+TadnX23auemn
        f+Mkfc1tP6byLbr3qc4n+/jqGi7W350ztT4uZsmd/PeoZq8UU6n3Jk6R6uu9VTm+JvI/bL0b
        T/WXbjv6o/Sr2dX8r04JEw5MU2Ipzkg01GIuKk4EAN3UscgEAwAA
X-CMS-MailID: 20220325064536epcas2p31fa7f18cf356399d84f76458a58901e2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_8f06_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b@epcas2p4.samsung.com>
        <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
        <Yjws5IhAqos5LDM+@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_8f06_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Mar 24, 2022 at 09:33:40AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 05:10:42PM +0900, Oh Eomji wrote:
> > In mobile, a co-processor can be used with USB audio to improve power
> > consumption.  To support this type of hardware, hooks need to be added
> > to the USB audio subsystem to be able to call into the hardware when
> > needed.
> > 
> > The main operation of the call-backs are:
> >   - Initialize the co-processor by transmitting data when initializing.
> >   - Change the co-processor setting value through the interface
> >     function.
> >   - Configure sampling rate
> >   - pcm open/close
> >   - other housekeeping
> > 
> > Known issues:
> >   - This only supports one set of callback hooks, meaning that this only
> >     works if there is one type of USB controller in the system.  This
> >     should be changed to be a per-host-controller interface instead of
> >     one global set of callbacks.
> > 
> > Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
> > Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> > ---
> >  sound/usb/card.c     | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  sound/usb/card.h     |  20 +++++++++
> >  sound/usb/usbaudio.h |  45 +++++++++++++++++++
> >  3 files changed, 184 insertions(+)
> > 
> > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > index 3769622..bd59311 100644
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -117,6 +117,117 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
> >  static DEFINE_MUTEX(register_mutex);
> >  static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
> >  static struct usb_driver usb_audio_driver;
> > +static struct snd_usb_audio_vendor_ops *usb_vendor_ops;
> > +
> > +int snd_vendor_set_ops(struct snd_usb_audio_vendor_ops *ops)
> > +{
> > +	if ((!ops->connect) ||
> > +	    (!ops->disconnect) ||
> > +	    (!ops->set_interface) ||
> > +	    (!ops->set_rate) ||
> > +	    (!ops->set_pcm_buf) ||
> > +	    (!ops->set_pcm_intf) ||
> > +	    (!ops->set_pcm_connection) ||
> > +	    (!ops->set_pcm_binterval) ||
> > +	    (!ops->usb_add_ctls))
> > +		return -EINVAL;
> > +
> > +	usb_vendor_ops = ops;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(snd_vendor_set_ops);
> > +
> > +struct snd_usb_audio_vendor_ops *snd_vendor_get_ops(void)
> > +{
> > +	return usb_vendor_ops;
> > +}
> 
> This is the function you need to fix up, and add proper reference
> counting to, in order to solve your "this breaks with multiple USB
> controllers" problem.  So this really should not be all that difficult
> of a task.  Why has it taken years to do so?
> 
> thanks,
> 
> greg k-h
>
Hi,

Is that mean the scenario when two or more usb audio devices are
connected through the hub?

Thanks,
Eomji Oh

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_8f06_
Content-Type: text/plain; charset="utf-8"


------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_8f06_--
