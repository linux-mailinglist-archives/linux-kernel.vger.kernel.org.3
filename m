Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15149EAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbiA0TTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:19:54 -0500
Received: from outbound5f.eu.mailhop.org ([3.127.8.113]:51250 "EHLO
        outbound5f.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiA0TTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:19:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1643310228; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=Ye4a/YOw5mc7PMx4VhwPdnbqnRInsEyWyWjHIJT7R2tYU2oJWxoEdrZkOb2ASnM7vXRlfZE/YBaQx
         QVgHmgiMTjH8jN31IksfUDxDDW4RFqyYOenya1wQUzVyfckoY/+nOJvpzFkktnQxoVryFDGp7PuqkK
         63QudzS7NNYKQ9T48JWJeLEp8uwcsMtQHisqqg+U/NV6EoMat/rDfYGQNXHTM+7JIE2MWE3UuWuN4z
         VYT24B0SCnfl9q1fJ/Dp+n5spn1J/2XZCHLWLf0DKr6M2/mkEfkkOzQ2E4w4a8k52L9ORcWE01hz5J
         p7Cf9/Wd0RCWN32NAL+stsXE/YbxTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:dkim-signature:dkim-signature:from;
        bh=ZPOoAh9ilR0mDf2sGLTWKIgj5O+vg7Y8DEFiCpa40cI=;
        b=PynOkqGLTt/cBF4XyvaikcntXYxmLkK6g/FkDi80kEVYY5ZoKmZLy1YS7adUA9quoDrFCY/KCXHu5
         fzVkBh7/pNjT5/SVfdN9Polz6W3aSEJGZIkioH+XNmHGEaizTTFD96qS10cqOhhgozXJb6qnxQkM4i
         ZkONICbPvOYdU30d4duUGOtAxUm3SxrCj+ldIVi+GEb+PFvUpFFVJ5qXXZtTfkT0JUAlcXhMzAivnF
         ZZ6bmQ+Bxdu5RfroZ9LraCeTbVvwiWiDif2ILAuhg7zIJRd3EJV6DV2vTpZ3+ZtJvNS0iDpaqIoe1H
         1ER1VewTpvUf3+U/AcVx8UKUeOIq0ew==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
        spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=91.207.61.48;
        dmarc=none header.from=stackframe.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stackframe.org; s=duo-1634547266507-560c42ae;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=ZPOoAh9ilR0mDf2sGLTWKIgj5O+vg7Y8DEFiCpa40cI=;
        b=sf+CSgcB2S8FS7i8w5gOYZ399ZV3KikJV/JWhAzf1mfhipkqdEd9YVATpBOUWJlgyOlqDdefwjBau
         6p061PYZzMeceDBH7PGmgIFf7IdfFK/xogyYHD7mPRzlTOBDTK/WwG89eKHAx39qEHZlKDo4zVopq2
         IYIxpTu/lRY4U8Do=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=ZPOoAh9ilR0mDf2sGLTWKIgj5O+vg7Y8DEFiCpa40cI=;
        b=NtFjJ/cqVCyljlDqPGqg5Z6BbPDsUamusZVkWPLeLkZ37IHSlMVQvIEBHpR+uVk7sgKAEOtZ1WwiZ
         NNhUnZWwlD7AmZEN1nsQ/cJNK7z1SM80CVkIqVC1rUwS0uzDvinDJw+WFkJZRd3EF+x7BekNSDKuCg
         TsB5fKWI/Tldw+i7R/Z0j2CrudhSNFKeyXOly0c2ZJ/bfgX3l4i3RlUa8AhO5klovyNmNQL3lFNTWf
         SNI6DMIGxbDnAdznOlM57NwMtTTiBZ5rn3gSg8w3Dm9MlxHex2llQcvJey51DavIDxpFW81JAGprgr
         bO41FwzxvdCE/Qdk9hks6X7Gp0NAl8g==
X-Originating-IP: 91.207.61.48
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: d7a1b121-7fa3-11ec-a079-973b52397bcb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (propper.duncanthrax.net [91.207.61.48])
        by outbound2.eu.mailhop.org (Halon) with ESMTPSA
        id d7a1b121-7fa3-11ec-a079-973b52397bcb;
        Thu, 27 Jan 2022 19:03:42 +0000 (UTC)
Received: from hsi-kbw-109-193-149-228.hsi7.kabel-badenwuerttemberg.de ([109.193.149.228] helo=x1.stackframe.org.stackframe.org)
        by mail.duncanthrax.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <svens@stackframe.org>)
        id 1nDA3Y-00767l-Pz; Thu, 27 Jan 2022 21:03:40 +0200
From:   Sven Schnelle <svens@stackframe.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-csky@vger.kernel.org, linux-mm@kvack.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH v2] usercopy/csky: Do not fail on memory from former
 init sections
References: <YfLpNkmlvoR8iPcq@ls3530>
Date:   Thu, 27 Jan 2022 20:03:38 +0100
In-Reply-To: <YfLpNkmlvoR8iPcq@ls3530> (Helge Deller's message of "Thu, 27 Jan
        2022 19:49:26 +0100")
Message-ID: <87k0el57cl.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> While working on the parisc port I suddenly noticed that with
> HARDENED_USERCOPY=y the usercopy checks randomly reported errors which even
> prevented the kernel to boot into userspace.
>
> Specifically the function check_kernel_text_object() reported those errors, as
> it thought the kernel variable I was using belongs to the kernel text area, and
> as such was invalid to be used.
> [..]
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index b3de3c4eefba..37a35c6051bc 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -113,6 +113,15 @@ static bool overlaps(const unsigned long ptr, unsigned long n,
>  	return true;
>  }
>
> +static bool inside_init_area(const unsigned long ptr, unsigned long n,
> +		char *start, char *end)
> +{
> +	unsigned long initlow = (unsigned long) start;
> +	unsigned long inithigh = (unsigned long) end;
> +
> +	return (ptr >= initlow && (ptr + n) < inithigh);
> +}

Gerald added something similar with 7a5da02de8d6 ("locking/lockdep:
check for freed initmem in static_obj()"), so i wonder whether that
could be used?

Regards
Sven
