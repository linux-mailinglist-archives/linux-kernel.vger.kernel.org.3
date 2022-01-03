Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AF4838F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiACXBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiACXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:01:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CEC061761;
        Mon,  3 Jan 2022 15:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3nDVn8ws7/m69Ka3Wq2aZ970s0t94NQxPoFLp0IKM6M=; b=Dn5Whu7Vr7PETcOW1Npz8Sp/do
        GaeJ8/dNdJdT1M1Zym/mIVHmDh3hUJvgERGCJylWrccvr2zFKGPq542VkkWf0VbGA31Ik3CzAuufT
        cPXlcduIrrrh/NGZDGmegmzVJ4YKNebTS5PsuFqTe/OJvDXvrBPiO4ELMVHrXfbwRztaM81PPuqz0
        VxkVYRWHIOEHE+G1octtnJ9khy1n0uV5jTJkGDOjomDEisRf3z49kz+JTjZXjcwQK4t0PTqe9onkY
        rlwSTf/QFhnT8ceChQmocEv/Saeie7XdAC9kLAqU582fEM+qhuWa2yyCJYDejzcjDdqNYDI3G1jsr
        Tam8XiSQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4WKi-005AhY-Fb; Mon, 03 Jan 2022 23:01:40 +0000
Message-ID: <6e8661ff-b470-10e9-966b-587c7fc2c296@infradead.org>
Date:   Mon, 3 Jan 2022 15:01:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] docs: discourage use of list tables
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <87r19oxx87.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87r19oxx87.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/22 14:36, Jonathan Corbet wrote:
> Our documentation encourages the use of list-table formats, but that advice
> runs counter to the objective of keeping the plain-text documentation as
> useful and readable as possible.  Turn that advice around the other way so
> that people don't keep adding these tables.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

for sure.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/doc-guide/sphinx.rst | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 673cbb769c08..bb36f18ae9ac 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -261,12 +261,11 @@ please feel free to remove it.
>  list tables
>  -----------
>  
> -We recommend the use of *list table* formats. The *list table* formats are
> -double-stage lists. Compared to the ASCII-art they might not be as
> -comfortable for
> -readers of the text files. Their advantage is that they are easy to
> -create or modify and that the diff of a modification is much more meaningful,
> -because it is limited to the modified content.
> +The list-table formats can be useful for tables that are not easily laid
> +out in the usual Sphinx ASCII-art formats.  These formats are nearly
> +impossible for readers of the plain-text documents to understand, though,
> +and should be avoided in the absence of a strong justification for their
> +use.
>  
>  The ``flat-table`` is a double-stage list similar to the ``list-table`` with
>  some additional features:

-- 
~Randy
