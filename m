Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8E58496B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiG2BrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiG2BrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:47:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284AC17596;
        Thu, 28 Jul 2022 18:47:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so3394433pfm.11;
        Thu, 28 Jul 2022 18:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Pv6W8Maka4VAZeV92WQ+4edaVOyQNGXitAaHP7ckb1s=;
        b=DQNYIaXwn/HtUMIALq8u0oVCo5V+VpcyXVyvdU4QTb52/TlE7QNu4RklQ1TKWGXNPu
         BfkbTzmzHuyWjOkb6iDxCmd6NnPXwh5FU4hYo9/jTauIDVTpdVI/uR69yAF00d7OHhLG
         YvPDTsH11PT3nqyg47vL9vDveEtEwaVErSBORvxyGuqQb0Zs1MK04YnDBmBfkIl5+6Ld
         rQiYvD6Zy1HhwYIGSVAoy/0gC8Df/Qi1HOqHsiOazm5bOu/0hIee8fwtD4z4aXhzCseW
         lH0mt1cgM+PwYTAmKASvcH37vTLv9Ms5lRXvvFripyzP7ABayW4tV4VI00uxNTI5pWVi
         EJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Pv6W8Maka4VAZeV92WQ+4edaVOyQNGXitAaHP7ckb1s=;
        b=vL5KH/P8Hpd7Q//u4/PUIpfVG9ZOuCF6NbDgasdnMg6ZiSfi7nycbGA/bzg21JjqDv
         W6StElb4azOKoSG9GgS552wDRI5gntfM5BfCrEfJEcHjdakj0KrXltC2HE4pTqMZvHKS
         ao4f7vNqUSDWV+Mz7Q7qDj0EJLY/3CbYi1Wt98X0w9aKuTzrPf8FAZDAoxPJOPhc1h0P
         tiwd6PQU+Y7Yf5wzs+L4ZnayZ5R4Sm1rRuWtDVfVeGI41pLCODHjEmCN9PXJPpVMCb52
         b5uuL1KwzZf9jJtBSsMF9ZuqF9pO/cJlv7RnqdoUhM3AerGdrIlRvkmlE9xjlye3vDw1
         xfAQ==
X-Gm-Message-State: AJIora+/7qsB7MN/WouTmIBX91QsAlYQr3nJ6nStqTHyAeq0UN1tqZyK
        xQgQFV8rw1c9hhm9Mm7QngI=
X-Google-Smtp-Source: AGRyM1tMQ+yLoJhQ+H5u56wIqUt4cuZjOlPGsZir9KwDdJ+xtEdWwKn8HuCV5UlzjGRn3BbniqNFaw==
X-Received: by 2002:a63:451e:0:b0:40d:c602:4e with SMTP id s30-20020a63451e000000b0040dc602004emr1119796pga.453.1659059225609;
        Thu, 28 Jul 2022 18:47:05 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b0052ab5a740aesm1416661pfk.162.2022.07.28.18.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 18:47:05 -0700 (PDT)
Message-ID: <78f782da-1af9-a068-3aa5-1d6102f5e8c1@gmail.com>
Date:   Fri, 29 Jul 2022 08:47:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/5] maintainer-pgp-guide: remove keyserver
 instructions
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-2-c48fb06cb9af@linuxfoundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220727-docs-pgp-guide-v1-2-c48fb06cb9af@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 03:57, Konstantin Ryabitsev wrote:
> Keyservers are largely a thing of the past with the replacement systems
> like keys.openpgp.net specifically designed to offer no support for the
> web of trust. Remove all sections that talk about keyservers and add a
> small section with the link to kernel.org documentation that talks about
> using the kernel.org public key repository.
> 

AFAIK, keyservers are synchronized (federated). For example, when I submit
my key to keys.openpgp.net, other keyservers (like keyserver.ubuntu.com
that I use) also gets a copy of my key. So "replacement systems" in
this case is referred to kernel.org key repository (using git). The
wording should be "Replace keyservers section with kernel.org public
key repository usage".

-- 
An old man doll... just what I always wanted! - Clara
