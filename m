Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8854D0EE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiCHEzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCHEzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:55:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7039133A17;
        Mon,  7 Mar 2022 20:54:48 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d17so7508240pfv.6;
        Mon, 07 Mar 2022 20:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+mhDsYXIh6KsERGGuN7btucncjAhTz1j8z/Nt9vm2cY=;
        b=QNbZAwA0rjFRZyjubU45PCGK/FyoRJXi6KpwyZeOqUEUFdWBDTtsQrNyf2WxAMd8c9
         fC8wHCEkiPnF9mcYki9HVANH6VUz66Mq4Kw+Ly3Jk1qc9kFMOzuEPry4QLrdesuVyxtF
         XaIap+/557La4Bw/pZ9CrpPEdZKhg6xpl9W7GI/a+XLgHstLSnWItlpm4PpnJ7IWKvzb
         bFOy1wIC197H0LWlp6EDY+Be9g71Sjp0ci4dDbMNcby83cp3tFlNM2lggC5Jx4FZXpGN
         w6LYmO1xAGR2E9j60+TN3YrWej6KwXUG2O1RxKt43MLCabIrm/zLJosgz9wPZCdgiY4V
         xlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+mhDsYXIh6KsERGGuN7btucncjAhTz1j8z/Nt9vm2cY=;
        b=1D4EgmcS6t3ta9XPAqmBwVn/AVw0hSUOcTVqXAtRE4YDMVnxmV+xWhqmNqgJdVhF2N
         ZnwMavLuFdRcGcaIKhUP/slxGFC+UkGjWsLAytJWm0g5OWr0EBOq0IgXRWx34S/hMFav
         LJ+VgDIDZ63NaO3EsrUisHMluBhwDUHR29ROwNLfdeTT9H1uupcrN3xFiCGp7sgVILrf
         kggHSUsdYyYyz9AXDwvEJZ4XqaKO40XImMPBctgAHunWzaNBZhrDZSln5J/2Mk6cTd93
         12xNNWnCSvF4PhD+4W0UgHhlVqK7u9+DFdlwabeh5SC/YIwxoApiOt40mn2AI12d6X25
         ibgQ==
X-Gm-Message-State: AOAM531UiFpUBNBt8G2W59Y90r12xRjx145nnmogLEorShVobrSkGo+7
        8Sw8ugU5Ha3QoTio9tfIC9Z64LJU5Lwmaw==
X-Google-Smtp-Source: ABdhPJz2utjtm1oDtXkQkzQXlbjYXtYs9e5zG0XjM8qwBfYpnPSjsmgu6EoTWd1CPgdCJ+K1DL0aaQ==
X-Received: by 2002:a63:5826:0:b0:37e:d37f:bd8e with SMTP id m38-20020a635826000000b0037ed37fbd8emr12520760pgb.433.1646715287914;
        Mon, 07 Mar 2022 20:54:47 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id nm14-20020a17090b19ce00b001bf2404fd9dsm1016245pjb.31.2022.03.07.20.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 20:54:47 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:24:42 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: Update git tree for broadcom IPROC
 boards
Message-ID: <20220308045442.GA67274@9a2d8922b8f1>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
 <e08f2e52-0684-89b7-b1df-f27e4c0d74f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08f2e52-0684-89b7-b1df-f27e4c0d74f2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:19:20AM -0800, Florian Fainelli wrote:
> On 3/7/22 10:20 AM, Kuldeep Singh wrote:
> > Current git tree for broadcom boards is pretty outdated as it's not
> > updated for a long time. Fix the reference.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> 
> Applied to maintainers/next. Please use scripts/get_maintainers.pl next
> time though, our internal mailing list was not copied, thus our
> patchwork instance did not pick up the patch.

Ahh i see. Though I ran get_maintainers.pl, but couldn't cc internal mailing
list. I'll take care next time. 
Thanks!

Regards
Kuldeep
