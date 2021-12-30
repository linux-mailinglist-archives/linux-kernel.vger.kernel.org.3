Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3565481AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhL3IrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:47:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35951 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237529AbhL3IrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:47:14 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EA41D5C0215;
        Thu, 30 Dec 2021 03:47:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 Dec 2021 03:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tzxkr1kIMEUZBmCty5MSXunzxr0
        VXfeqbA4q6CzmkCg=; b=rH6jeIlXYaTfJQQHwHANYc56wAje/zw4vc+7SIlQF+q
        oIH8U1p/wV1/jGvZJiklMCLO/e9OEydj42BCvtoVI+3y7PE+2L4axnNIF0vyoIU1
        nAdVJtJWPT/YSwx9Hzjr/f2VfBz6H2KJHTAH8bmohzEAU7m5Tk2dxLaBUUxW8q10
        6PxeYKmAPO9NgcgT3i6H1NARlkdEjtJbl0MEf7O5SNCJKUAuKHz6BcatgdMH7qAj
        a5b/p4ULtZ0w0sz3zDUVot2lJ+i41sJ071VZR4p9NW3HLXElfBlP1W+95SugCW1g
        Xm2J9bAOSjTbAiAE3SAgi6Wf7hdcmXuTZKHLe6LuRog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tzxkr1
        kIMEUZBmCty5MSXunzxr0VXfeqbA4q6CzmkCg=; b=RwycIi9r7qgC5Agb130kG5
        LIm7cyJcIMPoElh19eMtj1f5YQ8KoLtKHYjkG53BPRJJsSTsmqRBQLgMHfev65RE
        +jCLPZrKF+IZQJp4F8jdrRCE7OcZJFyfDEXQaN3HJ90xEFPJTq9T9nU/uVzwg/zO
        GEO/aW5xEvRxZf2HVvAkCUOtjZzq4PKZWDNvaEeIXTJtGlczUeICU3zKy7zSQ2KD
        T0O+jdANbQxA4ZYgMWa98DxoW9xxUhIUuPv6lDX3rJemoW5lhAgANIfOCtavipZQ
        d+lPlWsBzr+kiOlOSyemSgZ6TR+CmW0OSGoGuTyQkAStNnKUnAYfRleTxkj8jigQ
        ==
X-ME-Sender: <xms:EXLNYSSgwVbkTcs4XITRTHTijOvkhMrMz9OSx6y-ZCn61panumJdfA>
    <xme:EXLNYXyjdwfVRQzu4sOVtR1CR6fpVae8JQFP9TL4DU8EQKGXDKXbCYn9TWHzf9zJv
    -SSRry0bbXtDg>
X-ME-Received: <xmr:EXLNYf1bguDA5SUKCvRlTKPFAslffrHgF7uBwMYoE5D8TfljjmWfHj7-icmK5ij7k0Cjt6aQYUZwjxDhYSfo6RllYARZ8Fv2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddvvddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejie
    eugeegveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:EXLNYeDkRS4QwgVaXerTS1K7-5KMmyk3YAC-iFcCq78ngt9relwOog>
    <xmx:EXLNYbh3J_rZkkfQAojeTbswUwXgnk77iBrgrIyg1b20d8L9I7RMkw>
    <xmx:EXLNYarl42Zj-lSBY-5O0lDOzqVBRwr2wSclrFs2HABwUbA3ZjbJmg>
    <xmx:EXLNYWVWJ0YVXkVbeozGFnRdz1owLIvCP0_zmxy1tsUqiHH-icjghg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Dec 2021 03:47:13 -0500 (EST)
Date:   Thu, 30 Dec 2021 09:47:06 +0100
From:   Greg KH <greg@kroah.com>
To:     ycaibb <ycaibb@gmail.com>
Cc:     vapier@gmail.com, zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: fix socket leak
Message-ID: <Yc1yCp3RI0/zT2zn@kroah.com>
References: <20211230082059.98012-1-ycaibb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230082059.98012-1-ycaibb@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 04:20:59PM +0800, ycaibb wrote:
> In main() of ucon.c, the socket may not be closed when send_msgs is true.
> 
> Signed-off-by: ycaibb <ycaibb@gmail.com>

Please use your full name.

> ---
>  samples/connector/ucon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/connector/ucon.c b/samples/connector/ucon.c
> index fa17f864200e..4f9d93a5c107 100644
> --- a/samples/connector/ucon.c
> +++ b/samples/connector/ucon.c
> @@ -180,7 +180,8 @@ int main(int argc, char *argv[])
>  
>  			ulog("%d messages have been sent to %08x.%08x.\n", i, data->id.idx, data->id.val);
>  		}
> -
> +		

Always run your patches through scripts/checkpatch.pl before sending
them out.

thanks,

greg k-h
