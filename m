Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7F47523A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhLOFne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 00:43:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52575 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235611AbhLOFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 00:43:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2145F5C0465;
        Wed, 15 Dec 2021 00:43:33 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 15 Dec 2021 00:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=Y5ux8cuARhLoUZ59VzaOt21HPiT6ag2
        JxcVbnoECCS0=; b=QPZhVruchCzOKkawkzaofyB6VaCTWXv3cGIrDuU1/RPyMjN
        kkuM1km6iBv8C0j12j/mBAc3BtAgLCMBtMYMH7k231FqkJFqg+xN//YAqbhk/16I
        l4VQUoxhjYb4Xbkqfnm74skCTAYjfps/My4bp66dmhIn5em7nr/lF1ydPWrzs0+A
        de8wd/KAI2gbF8k803c1eynm2Q+3y2z4bAXThW9cguzPyB6ad4KRgmi8LSX2Oljd
        nLtgEEiXINVtKkgpMZxeJHOzD6WnhvIc6rFD7s+6PaQ799IDeoBm4CJGUm/eJQAd
        vfgZ5xtAhO1XjvHiwB1ObnnA2P5WyqbeSHMeSQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y5ux8c
        uARhLoUZ59VzaOt21HPiT6ag2JxcVbnoECCS0=; b=JhNFHwZzXZfYJdvMEbxlyd
        Zq2LqiDD/E7Y8V4Ni/JdLZYIX/OwERVmJxkVwdxUCr5kB8WHV1jU0+D/BUVhtMV3
        2nDzivG/KUmPJjiJdtRYc2A+apYNZJ92HaB1C27iByAomUR1/WOELp0kcuTZvoUO
        ySX7BjsQsYSV0LSoH7slqwRhxlyHbFrHVaS6RTQTKCLh4pJldrUNPdZ3r8zafCBM
        W2x8fpViT9kqH9ffbKwlX93XDDG01b4DQ2ktepDaXnZLZlr87tx17fDemioDLdvf
        gVD1skXA81gyq1ucpqdOE8MkIF2fdjIEaN/Q2rkblmnavjV41BpLDhx0jwNo5wog
        ==
X-ME-Sender: <xms:hIC5YUQ8OlF0MHTSyMpKuFBh_xuTx4bjc8fD6HKoz9ZnqE23rlDCzA>
    <xme:hIC5YRzdlradIccsn4VWCuz6uegREnYP8CihV8x8_dcTBHtI8yVGylB93UPiQrJsf
    kyJESfqaBCaYt6IUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:hIC5YR2lE14U_HxqLJx_eybHZLv0xT33tCuzJf8CqHXenV4VnDIr3w>
    <xmx:hIC5YYDHVFYpl6nCBg6eUgK88NqQKa748ZCBPSHL0bRbqeaFRjBiEg>
    <xmx:hIC5Ydi1mROynyCj3ufDOpLlNZClg1j4J3OemSxHlLQ43_75Ek_KJQ>
    <xmx:hYC5YdeZREYFKGVB4w3p4Yc4E6ZQTn3s6X-ysJkoj3fovamRFHniwQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA8B3AC03DB; Wed, 15 Dec 2021 00:43:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <6db73ea9-96e8-42cd-97a5-0667de8d0097@www.fastmail.com>
In-Reply-To: <20211215005833.222841-2-amitay@ozlabs.org>
References: <20211215005833.222841-1-amitay@ozlabs.org>
 <20211215005833.222841-2-amitay@ozlabs.org>
Date:   Wed, 15 Dec 2021 16:13:10 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Amitay Isaacs" <amitay@ozlabs.org>, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, "Jeremy Kerr" <jk@ozlabs.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Eddie James" <eajames@linux.ibm.com>
Subject: Re: [PATCH 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amitay,

On Wed, 15 Dec 2021, at 11:28, Amitay Isaacs wrote:
> FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
> the response to *the next* chip-op sent to sbe.  The timeout value is
> reset to default after the chip-op.

For the user? Why reset it automatically? To avoid unexpected surprises 
in existing code?

>  The timeout affects only the read()
> operation on sbefifo device fd.
>
> Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> ---
>  drivers/fsi/fsi-sbefifo.c | 42 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsi.h  |  6 ++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 9188161f440c..b2654b143b85 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -32,6 +32,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/mm.h>
> 
> +#include <uapi/linux/fsi.h>
> +
>  /*
>   * The SBEFIFO is a pipe-like FSI device for communicating with
>   * the self boot engine on POWER processors.
> @@ -134,6 +136,7 @@ struct sbefifo_user {
>  	void			*cmd_page;
>  	void			*pending_cmd;
>  	size_t			pending_len;
> +	uint32_t		read_timeout_ms;
>  };
> 
>  static DEFINE_MUTEX(sbefifo_ffdc_mutex);
> @@ -796,6 +799,7 @@ static int sbefifo_user_open(struct inode *inode, 
> struct file *file)
>  		return -ENOMEM;
>  	}
>  	mutex_init(&user->file_lock);
> +	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;
> 
>  	return 0;
>  }
> @@ -838,7 +842,11 @@ static ssize_t sbefifo_user_read(struct file 
> *file, char __user *buf,
>  	rc = mutex_lock_interruptible(&sbefifo->lock);
>  	if (rc)
>  		goto bail;
> +	sbefifo->timeout_start_rsp_ms = user->read_timeout_ms;
>  	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, 
> &resp_iter);
> +	/* Reset the read timeout after a single chip-op */
> +	sbefifo->timeout_start_rsp_ms = SBEFIFO_TIMEOUT_START_RSP;
> +	user->read_timeout_ms = SBEFIFO_TIMEOUT_START_RSP;

I guess I was querying this one

>  	mutex_unlock(&sbefifo->lock);
>  	if (rc < 0)
>  		goto bail;
> @@ -847,6 +855,7 @@ static ssize_t sbefifo_user_read(struct file *file, 
> char __user *buf,
>  	rc = len - iov_iter_count(&resp_iter);
>   bail:
>  	sbefifo_release_command(user);
> +	user->read_timeout_ms = 0;
>  	mutex_unlock(&user->file_lock);
>  	return rc;
>  }
> @@ -928,12 +937,45 @@ static int sbefifo_user_release(struct inode 
> *inode, struct file *file)
>  	return 0;
>  }
> 
> +static int sbefifo_read_timeout(struct sbefifo_user *user, void __user 
> **argp)
> +{
> +	uint32_t timeout;
> +
> +	if (get_user(timeout, (__u32 __user *)argp))

Hmm

> +		return -EFAULT;
> +	if (timeout < 10 || timeout > 120)
> +		return -EINVAL;
> +
> +	user->read_timeout_ms = timeout * 1000; /* user timeout is in sec */
> +	return 0;
> +}
> +
> +static long sbefifo_user_ioctl(struct file *file, unsigned int cmd, 
> unsigned long arg)
> +{
> +	struct sbefifo_user *user = file->private_data;
> +	void __user **argp = (void __user *)arg;

Why are we doing strange things with the pointer types?

Andrew

> +	int rc = -ENOTTY;
> +
> +	if (!user)
> +		return -EINVAL;
> +
> +	mutex_lock(&user->file_lock);
> +	switch (cmd) {
> +	case FSI_SBEFIFO_READ_TIMEOUT:
> +		rc = sbefifo_read_timeout(user, argp);
> +		break;
> +	}
> +	mutex_unlock(&user->file_lock);
> +	return rc;
> +}
> +
>  static const struct file_operations sbefifo_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= sbefifo_user_open,
>  	.read		= sbefifo_user_read,
>  	.write		= sbefifo_user_write,
>  	.release	= sbefifo_user_release,
> +	.unlocked_ioctl = sbefifo_user_ioctl,
>  };
> 
>  static void sbefifo_free(struct device *dev)
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> index da577ecd90e7..3e00874ace22 100644
> --- a/include/uapi/linux/fsi.h
> +++ b/include/uapi/linux/fsi.h
> @@ -55,4 +55,10 @@ struct scom_access {
>  #define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
>  #define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
> 
> +/*
> + * /dev/sbefifo* ioctl interface
> + */
> +
> +#define FSI_SBEFIFO_READ_TIMEOUT	_IOW('s', 0x00, __u32)
> +
>  #endif /* _UAPI_LINUX_FSI_H */
> -- 
> 2.33.1
