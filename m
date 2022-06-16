Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BD54D72C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbiFPBjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358219AbiFPBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:38:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EB57B19;
        Wed, 15 Jun 2022 18:38:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso4602346pjb.0;
        Wed, 15 Jun 2022 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FsbGtY6ybO5i94cEGRw91xXrnBAb+w+D3K5JghnAVfE=;
        b=mK2rmvByw5FxP/VDuR9Uau4CGs06KNreFgtZGESJcIUwQdX/OpPXHXY0XKwGLvs61p
         gtlfa47NadAmHWf/nF9v8oHxPfmUwuF/sm+3/7KdLZXGi3rv2bfG+gvcIZjjoAYrEA/i
         syTdr5Hk8vr8eEe1FbAcKY+OM6fqHZZkqmdynP4zelBB6Z6h3/eRQ4dHVyBWYTf1+5s/
         Yh4w38dSFTsPgXP608Ogjt1ALqpoyv8mz6j4mqR2JT7O1jj6ElkpnN+xv3z4eWrpnFx6
         aa4NIsgs6eKGNOFNleSHoNNb85SHvIHqyJ14jWT9LU0UbJOuVaY3wvlEoX5faFtFDLN/
         CblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FsbGtY6ybO5i94cEGRw91xXrnBAb+w+D3K5JghnAVfE=;
        b=JvYC2f5p3xeIpD5u924blZSp5Uj+iE2FPC/LYwV3zIwcBOyYV40OixGG2jZ4QtYlIV
         FdtanIBmGTnJWMdLLUVHJcDGL9GTu3IuymR6DM/4mnbRmQX0uJBFQWU2/YwLn3rP089V
         +KQcOcer9d3T2P9Xh+MXr2ECAe8A3y9iFyrBUvngetQpm5sn7jlyMPUWDpO8dgXEkPtA
         Tr0V332bjCiYUZuF16D3aYBIqWXC1WqkqDhpn8QoiyHpp2249wR14ZMVV7TcfZ8vZtBD
         +G2W6bOTMpukDfC3ZRq4TBB0asP/DLfWyz5y4Ss87/loHoXAuxECrv9SoNotzghaFqS2
         5QQQ==
X-Gm-Message-State: AJIora/S0CB+PelPfkQCDHtgmwDr/Ct+CdOOYu8SIsthv2iXUeRab8+V
        tTYj1axGxmOLIDQpM6LLNk8=
X-Google-Smtp-Source: AGRyM1ulUMg+nyfV+Q9WLCBZ5A5YYGzZ7XNO3ds3ZmYEF5y9LsWVHB4sLYTgNqHy5SiKSol8wRNk9w==
X-Received: by 2002:a17:90b:3b88:b0:1e6:7aa2:4301 with SMTP id pc8-20020a17090b3b8800b001e67aa24301mr13162105pjb.118.1655343522796;
        Wed, 15 Jun 2022 18:38:42 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0015e8d4eb1d2sm301894plh.28.2022.06.15.18.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 18:38:42 -0700 (PDT)
Message-ID: <38c5d597-4e24-6933-dbf7-b98dd7458cc7@gmail.com>
Date:   Thu, 16 Jun 2022 08:38:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] Documentation: highmem: Use literal block for
 *kmap_local_folio() example
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220615101509.516520-1-bagasdotme@gmail.com>
 <YqnujWdTA+QSdMHJ@casper.infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YqnujWdTA+QSdMHJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 21:37, Matthew Wilcox wrote:
> On Wed, Jun 15, 2022 at 05:15:10PM +0700, Bagas Sanjaya wrote:
>> These warnings above are due to comments in code example of
>> kmap_atomic() inside kernel-doc comment of *kmap_local_folio() are enclosed
> 
> You still seem to think this has something to do with kmap_local_folio().
> It has nothing to do with kmap_local_folio().  Your next version of this
> patch should not mention kmap_local_folio() anywhere.
> 

But I think mentioning kmap_local_folio() is necessary in the patch
subject, because we know the original warning is pointed to kernel-doc
comment of that funcion.

-- 
An old man doll... just what I always wanted! - Clara
