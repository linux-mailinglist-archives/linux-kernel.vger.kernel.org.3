Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26831473ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbhLNCoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:44:22 -0500
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:34027
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhLNCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mida.se; s=rsa1;
        h=content-transfer-encoding:content-type:subject:from:to:mime-version:date:
         message-id:from;
        bh=s344w45NWwHNWSwsL4wF1AmmouZCdQJVGvoZvGKycrQ=;
        b=lu64zCRs29kruxxWflakdtz0eHH40kqwUHSpDQ1n/KYXgQlhPCSrD0WgVjkCu2mhWaEHtyiL1Uj8y
         YKFP6qB92dhSTocKO37JvHsTLjs35KS58Atu/NeBH0iUySCpSegqptCv0+2A3t7w6nId7EF9Gsqzss
         2Vi5CN6kYkrusIULNEwZMU33AAOG8wrVUEmokWTF9w2bKDjZNhHYG7cyTuG4uRvWSieiBewN5Z+nZE
         iJH9faZNkt4KjPFCd7IvJ81jd0wpTY6YiWgu41MF6WZNLJLeUMxnZx+s7oyAuuqpiEMrxx7pJ7wp6+
         dQm7bw/aQ+g0vVWmkUaxqNgbG9yH+iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=mida.se; s=ed1;
        h=content-transfer-encoding:content-type:subject:from:to:mime-version:date:
         message-id:from;
        bh=s344w45NWwHNWSwsL4wF1AmmouZCdQJVGvoZvGKycrQ=;
        b=Tu4L0ND/ccJcqSndaxgACD+cEvb00DugWCbG2rOOY0dhMrVJYzaQfQvCJ6xmyrfuHRJYVwStE1lmy
         y6PVUnGCw==
X-HalOne-Cookie: 30b03178fa56633e7b7f8fc35edc0dbd1f188f9c
X-HalOne-ID: bc6d769a-5c87-11ec-b08d-d0431ea8bb10
Received: from [192.168.1.107] (37.250.11.128.bredband.tre.se [37.250.11.128])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id bc6d769a-5c87-11ec-b08d-d0431ea8bb10;
        Tue, 14 Dec 2021 02:44:19 +0000 (UTC)
Message-ID: <55fac469-5265-5710-7b0e-17d00271bfc5@mida.se>
Date:   Tue, 14 Dec 2021 03:44:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: sv-FI
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
From:   rkardell <rkardell@mida.se>
Subject: About patches
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I explicit asked if the patches were ok when I sent them and I got no 
response. Now I received this “This patch is broken on so many ways:” 
with comments. Responses like this will certainly not encourage new 
members, especially since the comments and changes of the code was not 
of high quality. And it certainly discourage me!

I include a copy of my comments sent to the responsible person and 
de-register from the group.




Den 2021-12-07 kl. 09:29, skrev rkardell:
 >
 > Sorry if I created problems for linux-media by pointing to a solution 
to a problem that has been in the kernel since the introduction of USB 
EHCI. The only PC I have that works with this DVB device is from 2005.
 >
 > I first asked for comments since C/C++ is not my preferred language 
and Linux kernel is not my normal working environment, but I got no 
response. I submitted the patches to the best of my knowledge.
 >
 >
 > 1. Your documented way of submitting patches did not work, so I had 
to retrieve the patch and send it as an ordinary mail.
 >
 > 2. If you cant get 1 byte buffer in the kernel, then you wont reach 
this code, but yes I could have tested.
 >
 > 3. I didn’t change the write code, because it was not a problem.
 >
 > 4. Sorry for that
 >
 > It is obvious that its the USB transfer that is the problem since USB 
is used for the i2c transfer!
 >
 > I have no way of knowing what combination of chips/drivers are used 
and possible side effects of changes. That’s way I preferred to change 
the the code this way
 >
 > From the documentation I found, it’s not the use of pointers on the 
stack that is the problem, its the use of buffer on the stack.
 >
 >
 > About your code: you don’t have to free memory that you could not 
allocate.
 >
 > My pc is updated with my patch, so I cant test your solution.
 >
 >
 > I don’t need this type of comment after my effort to point out the 
problem that has been in the kernel for such a long time, so I will 
de-register from the group.
 >
 >
 >
 > Den 2021-12-06 kl. 16:01, skrev Mauro Carvalho Chehab:
 >> Hi,
 >>
 >> This patch is broken on so many ways:
 >>
 >> 1. your e-mailer converted spaces and tabs into UTF spaces (0xa0);
 >> 2. it is not checking if allocation failed;
 >> 3. it doesn't fix the write function, which also uses stack;
 >> 4. you need your real name on your from and SoB.
 >>
 >> Besides that, there's no issue on using the stack for I2C transfers.
 >> The issue, is actually to use stack for USB transfers.
 >>
 >> So, the right fix should be, instead, at the bridge driver, and not
 >> on tuner. It seems that Mega Sky 580 USB DVB is supportd by m920x 
driver.
 >> Right?
 >>
 >> If so, the enclosed patch should fix the issue.
 >>
 >> Please test.
 >>
 >> Regards,
 >> Mauro
 >>
 >> Em Thu, 7 Oct 2021 14:29:00 +0200
 >> rkardell <rkardell@mida.se> escreveu:
 >>
 >>> Solve problem with initialization of Mega Sky 580 USB DVB (and other
 >>> using mt352), error when reading i2c id.
 >>>
 >>>
 >>> Signed-off-by: rkl099 <rkardell@mida.se>
 >>> ---
 >>>   drivers/media/tuners/qt1010.c | 6 +++++-
 >>>   1 file changed, 5 insertions(+), 1 deletion(-)
 >>>
 >>> diff --git a/drivers/media/tuners/qt1010.c 
b/drivers/media/tuners/qt1010.c
 >>> index 3853a3d43..1bc0756f7 100644
 >>> --- a/drivers/media/tuners/qt1010.c
 >>> +++ b/drivers/media/tuners/qt1010.c
 >>> @@ -11,18 +11,22 @@
 >>>   /* read single register */
 >>>   static int qt1010_readreg(struct qt1010_priv *priv, u8 reg, u8 *val)
 >>>   {
 >>> +    u8 *b1=kmalloc(1,GFP_KERNEL);
 >>>          struct i2c_msg msg[2] = {
 >>>                  { .addr = priv->cfg->i2c_address,
 >>>                    .flags = 0, .buf = &reg, .len = 1 },
 >>>                  { .addr = priv->cfg->i2c_address,
 >>> -                 .flags = I2C_M_RD, .buf = val, .len = 1 },
 >>> +                 .flags = I2C_M_RD, .buf = b1, .len = 1 },
 >>>          };
 >>>
 >>>          if (i2c_transfer(priv->i2c, msg, 2) != 2) {
 >>>                  dev_warn(&priv->i2c->dev, "%s: i2c rd failed 
reg=%02x\n",
 >>>                                  KBUILD_MODNAME, reg);
 >>> +           kfree(b1);
 >>>                  return -EREMOTEIO;
 >>>          }
 >>> +       *val=b1[0];
 >>> +       kfree(b1);
 >>>          return 0;
 >>>   }
 >>>
 >> Thanks,
 >> Mauro
 >>
 >> [PATCH] media: m920x: don't use stack on USB reads
 >>
 >> Using stack-allocated pointers for USB message data don't work.
 >> This driver is almost OK with that, except for the I2C read
 >> logic.
 >>
 >> Fix it by using a temporary read buffer, just like on all other
 >> calls to m920x_read().
 >>
 >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 >>
 >> diff --git a/drivers/media/usb/dvb-usb/m920x.c 
b/drivers/media/usb/dvb-usb/m920x.c
 >> index 4bb5b82599a7..691e05833db1 100644
 >> --- a/drivers/media/usb/dvb-usb/m920x.c
 >> +++ b/drivers/media/usb/dvb-usb/m920x.c
 >> @@ -274,6 +274,13 @@ static int m920x_i2c_xfer(struct i2c_adapter 
*adap, struct i2c_msg msg[], int nu
 >>              /* Should check for ack here, if we knew how. */
 >>          }
 >>          if (msg[i].flags & I2C_M_RD) {
 >> +            char *read = kmalloc(1, GFP_KERNEL);
 >> +            if (!read) {
 >> +                ret = -ENOMEM;
 >> +                kfree(read);
 >> +                goto unlock;
 >> +            }
 >> +
 >>              for (j = 0; j < msg[i].len; j++) {
 >>                  /* Last byte of transaction?
 >>                   * Send STOP, otherwise send ACK. */
 >> @@ -281,9 +288,12 @@ static int m920x_i2c_xfer(struct i2c_adapter 
*adap, struct i2c_msg msg[], int nu
 >>
 >>                  if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 >>                                0x20 | stop,
 >> -                              &msg[i].buf[j], 1)) != 0)
 >> +                              read, 1)) != 0)
 >>                      goto unlock;
 >> +                msg[i].buf[j] = read[0];
 >>              }
 >> +
 >> +            kfree(read);
 >>          } else {
 >>              for (j = 0; j < msg[i].len; j++) {
 >>                  /* Last byte of transaction? Then send STOP. */
 >>
 >


