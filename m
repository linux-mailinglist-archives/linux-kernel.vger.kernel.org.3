Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568B1490FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiAQRbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiAQRa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:30:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B88C061574;
        Mon, 17 Jan 2022 09:30:58 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso1156943wmd.5;
        Mon, 17 Jan 2022 09:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fuCfpx6Q20euBcFDKWf3hh/sY23XQfNDZ0HRdq3+IA8=;
        b=iJJh6YyT5Yv6j5Hji4sWjU59+74eSjLAvJx6xl6DxqB5i8u+jydQ8D7bsR8z0b+kSW
         WUrUYdTSBsUjfdV7EV+bJ2DKYi7x8o918wr3tK+eOhq6yBrpq0ygoDL5UQK6+LZamL4J
         XOgSGudmSn3pYEqeLFgEIOV7Y5n9PWaQEXfNGXisj/jMofI5HRjqIRbo/6wCySEmgqS0
         bqgufAxwMivqCdsYqjUtJH5ca3nx3+s3GsukebN5PNlXAXmeDivjkcYBEUaw2LjBGxR+
         Blrc4P9yuypXJBCppGjv/xACPy1SdOjXOA0h6jbUwJNA5NlyMe5okKn4c2FZmh5pgn7q
         xIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fuCfpx6Q20euBcFDKWf3hh/sY23XQfNDZ0HRdq3+IA8=;
        b=OImJlEl1sFPCDon4I775+po+d12jhgSwjexoWaj8XzSDcKs6H9v/s5yv1YmOgdk7L3
         CTrn0DyGugF+28nIwcirOSBfHSDvibKM8KFfdOmk3HW1lUBmjOlnMBu316o628NNy4Wg
         NpVaE2BP8J1lINukNxI8r6VtHFPIsp30JeaR4NkNtq4oqF+jI3PkEhY7HgyYpzhr+Of/
         fcdj0W1s7ZM0+6x5tRd05U5AFYiaIeP9bf3ddHbHJIyJwjNyL0kmk+Wo/eQ2Ie7peaCR
         A3/DvwHmRJgqSq9RT977z9Qvb8oI8K3c2HerqlI+0RY2BWOD8QoFJs3SfmPx4Hzx8Ye7
         lYgA==
X-Gm-Message-State: AOAM532i0AqaNNSsuNkn+9EDdiZAufd41x6eZTwLWew9W3pFWTArNPbi
        /MqG7bM3UR/j0sKXBm40h8fI+zisxsg=
X-Google-Smtp-Source: ABdhPJyW8xZ88UL81VWJHI5TtXZCjb7D6SVJXNR4uSMcPvr/Z2ZolISuOCgZ2/ZqHCW7s/H6i+Zwkw==
X-Received: by 2002:adf:f105:: with SMTP id r5mr9251952wro.422.1642440657200;
        Mon, 17 Jan 2022 09:30:57 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id q6sm14512284wrr.88.2022.01.17.09.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:30:56 -0800 (PST)
Message-ID: <98d87c52-da33-9ee4-b9df-253c8ae8e093@gmail.com>
Date:   Mon, 17 Jan 2022 18:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [patch] console_codes.4: ffix
Content-Language: en-US
To:     nick black <dankamongmen@gmail.com>, linux-man@vger.kernel.org
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello nick,

On 1/14/22 07:48, nick black wrote:
> Fix up the busted OSC command list (reset palette and
> set palette). Remove CSI prefix from the list of non-CSI
> escapes. End all items of said list with periods,
> matching other sections of the page.
> 
> Signed-off-by: nick black <nickblack@linux.com>
> ---
>   man4/console_codes.4 | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git man4/console_codes.4 man4/console_codes.4
> index d549b76a9..001de1955 100644
> --- man4/console_codes.4
> +++ man4/console_codes.4
> @@ -139,29 +139,28 @@ T}
>   ESC 8	DECRC	T{
>   Restore state most recently saved by ESC 7.
>   T}
> -ESC [	CSI	Control sequence introducer

As I understand it, it's there because CSI is not a CSI-prefixed 
sequence (i.e., you have to first document CSI itself, and then in a 
different list you can document sequences prefixed by CSI).
So I'd say it belongs there.

>   ESC %		Start sequence selecting character set
>   ESC % @		\0\0\0Select default (ISO 646 / ISO 8859-1)
>   ESC % G		\0\0\0Select UTF-8
>   ESC % 8		\0\0\0Select UTF-8 (obsolete)
>   ESC # 8	DECALN	T{
> -DEC screen alignment test \- fill screen with E's
> +DEC screen alignment test \- fill screen with E's.
>   T}
>   ESC (		T{
>   Start sequence defining G0 character set
>   (followed by one of B, 0, U, K, as below)
>   T}
>   ESC ( B		T{
> -Select default (ISO 8859-1 mapping)
> +Select default (ISO 8859-1 mapping).
>   T}
>   ESC ( 0		T{
> -Select VT100 graphics mapping
> +Select VT100 graphics mapping.
>   T}
>   ESC ( U		T{
> -Select null mapping \- straight to character ROM
> +Select null mapping \- straight to character ROM.
>   T}
>   ESC ( K		T{
> -Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8)
> +Select user mapping \- the map that is loaded by the utility \fBmapscrn\fP(8).
>   T}
>   ESC )		T{
>   Start sequence defining G1 (followed by one of B, 0, U, K, as above).
> @@ -169,12 +168,13 @@ T}
>   ESC >	DECPNM	Set numeric keypad mode
>   ESC =	DECPAM	Set application keypad mode
>   ESC ]	OSC	T{
> -(Should be: Operating system command)
> -ESC ] P \fInrrggbb\fP: set palette, with parameter
> -given in 7 hexadecimal digits after the final P :-(.
> -Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
> +Operating System Command prefix.
> +T}
> +ESC ] R		Reset palette.
> +ESC ] P		T{
> +Set palette, with parameter given in 7 hexadecimal digits \fInrrggbb\fP after
> +the final P. Here \fIn\fP is the color (0\(en15), and \fIrrggbb\fP indicates
>   the red/green/blue values (0\(en255).
> -ESC ] R: reset palette

Regarding this, I don't know what the intention of the original author was.

The pre-git code was (man-pages-1.70):

```
ESC ( U		\0\0\0Select null mapping \- straight to character ROM
ESC ( K		\0\0\0Select user mapping \- the map that is loaded by
		\0\0\0the utility \fBmapscrn\fP(8).
ESC )		Start sequence defining G1
		(followed by one of B, 0, U, K, as above).
ESC >	DECPNM	Set numeric keypad mode
ESC =	DECPAM	Set application keypad mode
ESC ]	OSC	(Should be: Operating system command)
		ESC ] P \fInrrggbb\fP: set palette, with parameter
		given in 7 hexadecimal digits after the final P :-(.
		Here \fIn\fP is the color (0-15), and \fIrrggbb\fP indicates
		the red/green/blue values (0-255).
		ESC ] R: reset palette
.TE
.SS "ECMA-48 CSI sequences"
```

Maybe it should go into a separate subsection called "Operating system 
commands"?


Thanks,

Alex


-- 
Alejandro Colomar
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
