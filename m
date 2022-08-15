Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E125927EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiHOCwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHOCwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:52:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCC13DF1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:52:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso13285265pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=97tyCh/hztKpfXO6u7xzBaFIppY93MdOrm2n8zHUB64=;
        b=H8jdlmhwkxVG0lk4LDQB/bJj0Mm+afebg1AZ+jF9cTIqiY25bexB+7F6sn1382nDE8
         XyIT1Ntt+lpGJ7nC0kJnjcAp3mg4cajjFMTLfESOT4PWfl9tFNPgMF/A+h3/Nf36TuyW
         CDm+Mg67fRHXAm9tOxDBvyMhaRe90aN5VMq6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=97tyCh/hztKpfXO6u7xzBaFIppY93MdOrm2n8zHUB64=;
        b=jQek+iws3SX5J0WROa+52l0q58mpzObvLFTsRYOl4CO0dw/rEXJSBC/m8LiNE8s40/
         rYRKbOtnUtautHVuB3aoxW/9qa8h2BfiqyyAWrK6cVh0f4COYxinnzs+LnUTSuOggqzT
         j9dCPqOjMNLoSc00pEDajcjyJmC6q0DIwod62Naq9MxTabg4ioXjO/5Zdm8vTIvdVdZs
         A0fY2d0K8H9kZpX8Fl4oo8aIKcLoqYgbpLAZJbcbag4Mgm2c2/wHkY0EK/DJtRh7ebAL
         vY3o+7slTUWBwraTHNjMI7vU45QiIPBd1ctfDczeZIRe322P5KH1zuioqAfFznh5amt1
         4v8A==
X-Gm-Message-State: ACgBeo33g1NaLyxNUOTQGlN7VzGU18kUjKn6HlqhVo4/J4rR042QgfRS
        YQ4sb2l6wtKiBgW+ZfTxiE+2m/ulybS1lw==
X-Google-Smtp-Source: AA6agR6ehp0puQvxCbDXA3dNRkeihvvt7eY4tDwGsjqcpgYgSX6GwZTIv+f05mPav55ebhupdmaUvQ==
X-Received: by 2002:a17:90a:640c:b0:1f7:6ecf:33b6 with SMTP id g12-20020a17090a640c00b001f76ecf33b6mr25658771pjj.3.1660531972720;
        Sun, 14 Aug 2022 19:52:52 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:110b:946c:84b2:7c95])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b0016f0c2ea14csm5989566plq.275.2022.08.14.19.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 19:52:52 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:52:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1 1/2] zsmalloc: zs_object_copy: add clarifying comment
Message-ID: <Yvm0//iPcvbW1M55@google.com>
References: <20220811153755.16102-1-avromanov@sberdevices.ru>
 <20220811153755.16102-2-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811153755.16102-2-avromanov@sberdevices.ru>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/11 18:37), Alexey Romanov wrote:
> @@ -1564,6 +1564,12 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
>  		d_off += size;
>  		d_size -= size;
>  
> +		/* Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic() calls
> +		 * must occurs in reverse order of calls to kmap_atomic().
> +		 * So, to call kunmap_atomic(s_addr) we should first call kunmap_atomic(d_addr).
> +		 * For more details see:
> +		 * https://lore.kernel.org/linux-mm/5512421D.4000603@samsung.com/
> +		 */

I'd drop the link part, Emails are not documentation, kmap_atomic
is documented in Documentation/mm/highmem
